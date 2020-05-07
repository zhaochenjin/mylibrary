# -*- coding:utf-8 -*-
from sys import argv
import numpy as np
from collections import Counter
import pymysql
import datetime
# 打开数据库连接
db = pymysql.connect('localhost', 'root', '123456', 'mylibrary')
user_set = {}  # dict字典键值对

# 根据这个商品 推荐借阅此图书的用户还借阅的其他图书

# goodsID:表示借阅过的图书，当前根据该图书进行推荐
def also_borrow_recommendation(goodsID):
    '''
    输入商品ID，计算商品相似度，将最相似的商品插入（更新）数据库
    输入：商品ID，int
    '''
    listt = recommendation_1(goodsID)
    listt = popular_recommendation(list(listt))
    str1 = ','.join(str(int(i)) for i in listt)
    # print(str1)
    # 使用 cursor() 方法创建一个游标对象 cur
    cur = db.cursor()
    if cur.execute('select * from alsoborrow where goodsid=%s', goodsID):
        cur.execute('update alsoborrow set list=%s, createtime=now() where goodsid=%s', (str1, goodsID))
    else:
        cur.execute('insert into alsoborrow(goodsid, list, createtime) value (%s, %s, now())', (goodsID, str1))
    db.commit()
#1	50000001	50000003,50000004,50000002	2020-04-17 15:32:23   图书编号  与前一个一个图书编号有关的图书的编号  创建时间

def recommendation_1(X):
    '''
    实现借阅了X图书的人还借阅了什么图书算法
    输入：X，图书ID，数据结构：int
    输出：推荐列表，数据结构：list
    '''
    # 使用 cursor() 方法创建一个游标对象 cur
    cur = db.cursor()
    sql = """
    select l.reader_id userid,b.book_id goodsid,b.class_id parentid, l.lend_date createtime from lend_list l
    left join book_info b on l.book_id = b.book_id
    """
    # 读者id  图书编号  图书类别序号 创建时间   谁在什么时候借阅了书名图书
    cur.execute(sql)
    # ((userid,goodsid,parentid,createtime),(...))
    # 接收返回结果行的每行数据
    results = cur.fetchall()

    # [1 1011012 1005000 datetime.datetime(2019, 8, 21, 14, 8, 7)]
    # 变成数组形式
    data = np.array(results)
    # 用户的id列表 数组
    user_IDs = data[:, 0]
    # 图书的id集合
    item_IDs = data[:, 1]
    # 图书对应的分类
    item_labels = data[:, 2]
    # 借阅或者创建时间 影响因子
    purchasing_date = calculate_time(data[:, 3])
    item_ID = X
    # 先查找借阅了x图书的用户，再获取到这些用户借阅了其他的图书 排序受影响因子影响
    recommendation_list = also_borrow(user_IDs, item_IDs, item_labels, purchasing_date, item_ID, alpha=(1/24/3600))
    return recommendation_list


def calculate_time(t):
    '''
    时间转换函数，将datetime.datetime数值转换成以1970年1月1日开始计时，到t时刻的为止，一共经过了多少秒
    输入：
    t:当前时间,数据类型：元组
    输出：
    listt,时间转换后的列表，数据类型：列表
    '''
    listt=[]
    for i in t:
        # append（）用于在列表末尾添加新的对象   abs() 函数返回数字的绝对值   total_seconds() 真正的时间差 包含天
        listt.append(abs((i-datetime.date(1970, 1, 1)).total_seconds()))
    return listt


def also_borrow(user_IDs,item_IDs,item_labels,purchasing_date,item_ID,alpha=1/24/3600):
    '''
    实现借阅了该图书的人还借阅了函数
    输入：
    user_IDs:用户ID，数据类型：列表或者int
    item_IDs:图书ID，数据类型：列表或者int
    purchasing_date:购买时间，数据类型：列表或者int
    alpha：时间衰减速率，alpha越大，则时间差对用户影响越大，数据类型：int 或者 float
    item_ID:用户借阅的图书ID，数据类型：int
    输出：
    推荐列表，数据类型：列表
    '''
    W = ItemSimilarity(user_IDs, item_IDs, item_labels, purchasing_date, alpha)
    # 借阅了item_ID的用户还借阅了的图书列表
    recommendation_list = most_similarity_items(W, item_ID)
    return recommendation_list


def ItemSimilarity(user_IDs, item_IDs, item_labels, purchasing_date, alpha):
    '''
    生成图书相似度矩阵，更新用户倒排表
    使用条件：
    每当用户产生借阅行为时调用，函数会更新user_set（用户倒排表），并产生商品相似度字典W
    user_set：用来存储用户的行为数据。key是用户ID，value同样是一个字典，key是图书ID，value是[购买时间,评分，物品所属label]
    W（图书相似度字典）：key是图书名称（如'a'），value同样是一个字典，key是图书名称(如'b')，则W[a][b]是商品a和b的相似度
    输入：
    user_IDs:用户ID，列表或者int
    item_IDs:图书ID，列表或者int
    purchasing_date:借阅时间，元组
    alpha:时间衰减速率，alpha越大，则时间差对用户影响越大
    输出：
    图书相似度字典W：W[i][j]表示图书i和图书j的相似度
    '''
    # 构建用户倒排表user_set，对于同一件图书的多次借阅记录，倒排表中只记录最近一次的借阅行为
    # 设置user_set是全局变量
    # user_set是一个字典，key是用户名称，value是一个字典，key是物品名称，value是列表[购买时间，label]
    # 由于user_set是全局变量所以更新时可以直接调用ItemSimilarity函数，会自动更新user_set
    global user_set
    if type(user_IDs) == int:
        user_ID = user_IDs
        item_ID = item_IDs
        time = purchasing_date
        item_label = item_labels
        if user_ID not in user_set:
            user_set[user_ID] = {}
        user_set[user_ID][item_ID] = [time, item_label]

    else:
        for i in range(len(user_IDs)):
            user_ID = user_IDs[i]
            item_ID = item_IDs[i]
            time = purchasing_date[i]
            label = item_labels[i]
            if user_ID not in user_set:
                user_set[user_ID] = {}  # Map<key,value>: key 不能重复的，唯一的  key:value
            user_set[user_ID][item_ID] = [time, label]
            # {userId:{goodsId:[time,label], goodsId:[time,label]}}， {userId:{goodsId:[time,label], goodsId:[time,label]}}
            # 用户userId借阅了哪些图书

    # 存在影响因子 影响图书的排序，相似性（不可能超过9个）
    C = {}  # 两个图书之间的影响 C[goodsA][goodsB]  C[goodsB][goodsA] C[goodsA][goodsC]
    N = {}  # 记录次数的 {goodsId:counter}
    # 获取用户的信息
    for user in user_set.keys():
        # 获取图书ID的信息
        for item_i in user_set[user].keys():
            # 获取时间和菜单的信息
            time_i, label_i = user_set[user][item_i]
            # item_i 图书的ID
            if item_i not in N.keys():
                N[item_i] = 0
                C[item_i] = {}
            N[item_i] += 1
            # {userId:{goodsId:[time,label], goodsId:[time,label]}, goodsId:[time,label]}, goodsId:[time,label]}}
            for item_j in user_set[user].keys():
                time_j, label_j = user_set[user][item_j]
                if item_i == item_j:
                    continue
                if item_j not in C[item_i].keys():
                    C[item_i][item_j] = 0
                C[item_i][item_j] += 1 / (1 + alpha * abs(time_i - time_j))
    W = {}
    for item_i in C.keys():
        W[item_i] = Counter()
        for item_j in C[item_i].keys():
            W[item_i][item_j] = C[item_i][item_j] / np.sqrt(N[item_i] * N[item_j])
    return W
    # W[goodsIdA][goodsIdB]=0.8 W[goodsIdA][goodsIdC]=0.7


def most_similarity_items(W,item_ID):
    '''
    根据W和item_ID生成和图书最相似的图书ID列表
    使用条件：
    当用户产生借阅行为后调用。
    输入：
    相似度字典:W,由ItemSimilarity函数生成，数据类型：字典
    图书ID:目标图书ID，数据类型：int
    输出：
    图书排序列表，数据类型：list
    '''
    listt = np.array(W[item_ID].most_common())
    if len(listt) == 0:
        return []
    else:
        return listt[:, 0]


# noinspection PyInterpreter
def popular_recommendation(initial_list):
    '''
    输入推荐列表，若推荐列表中的图书个数大于10，则选择前10个
    输入：
    user_id:用户ID，数据类型：int
    initial_list:初始推荐列表，数据类型：list
    输出：
    最终推荐列表，数据类型：list
    '''
    listt=initial_list
    if len(listt) >= 10:
        listt=listt[:10]
    return listt


if __name__=='__main__':
    num1 = argv[1]
    # goodsID = 50000001
    goodsID = int(num1)
    also_borrow_recommendation(goodsID)
    cur = db.cursor()
    cur.execute('select list from alsoborrow where goodsid=%s', goodsID)
    arr = np.array(cur.fetchall())
    print(arr)
