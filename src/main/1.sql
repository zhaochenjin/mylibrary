drop database  if exists mylibrary;
create database mylibrary;
show databases;
use mylibrary;
show tables;


DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
                         `admin_id` varchar(20) NOT NULL,
                         `password` varchar(15) DEFAULT NULL,
                         `name` varchar(255) DEFAULT NULL,
                         PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `admin` VALUES ('admin', 'admin', '李明');
INSERT INTO `admin` VALUES ('zhanghong', 'zhanghong', '张红');
select * from admin;



DROP TABLE IF EXISTS `reader_info`;
CREATE TABLE `reader_info` (
                               `reader_id` int(11) NOT NULL COMMENT '读者ID',
                               `name` varchar(16) NOT NULL COMMENT '读者名字',
                               `sex` varchar(2) DEFAULT NULL COMMENT '性别',
                               `birth` date DEFAULT NULL COMMENT '生日',
                               `address` varchar(50) DEFAULT NULL COMMENT '地址',
                               `telcode` varchar(11) NOT NULL COMMENT '电话',
                               `card_state` int(11) DEFAULT NULL COMMENT '读者可借图书数目\r\n\r\n逾期每册每天0.1元',
                               `password` varchar(25) DEFAULT NULL COMMENT '密码',
                               PRIMARY KEY (`reader_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `reader_info` VALUES ('1850210101', '赵依依', '女', '1997-06-11', '河北省石家庄市', '15312344321', '3', '123456');
INSERT INTO `reader_info` VALUES ('1850210202', '吴二二', '男', '1998-02-01', '河南省郑州市', '15155673476', '4', '123456');
INSERT INTO `reader_info` VALUES ('1850210303', '张三三', '女', '1996-04-15', '浙江省杭州市', '13612765687', '4', '123456');
INSERT INTO `reader_info` VALUES ('1850210404', '李思思', '女', '1998-08-29', '陕西省西安市', '12345678901', '3', '123456');
INSERT INTO `reader_info` VALUES ('1850210505', '周五五', '男', '1996-03-01', '山西省阳泉市', '12345678902', '4', '123456');
INSERT INTO `reader_info` VALUES ('1850210606', '夏小雪', '女', '1998-05-01', '山东省济南市', '12345678903', '4', '123456');
INSERT INTO `reader_info` VALUES ('1850210707', '夏小雨', '男', '1998-04-20', '广东省广州市', '12345678905', '4', '123456');

select * from reader_info;



DROP TABLE IF EXISTS `class_info`;
CREATE TABLE `class_info` (
                              `cid` int(11) NOT NULL AUTO_INCREMENT,
                              `cname` varchar(45) NOT NULL,
                              PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

INSERT INTO `class_info` VALUES ('1', '马列主义、毛泽东思想、邓小平理论');
INSERT INTO `class_info` VALUES ('2', '哲学、宗教');
INSERT INTO `class_info` VALUES ('3', '社会科学总论');
INSERT INTO `class_info` VALUES ('4', '政治、法律');
INSERT INTO `class_info` VALUES ('5', '编程');
INSERT INTO `class_info` VALUES ('6', '军事');
INSERT INTO `class_info` VALUES ('7', '经济');
INSERT INTO `class_info` VALUES ('8', '小说');
INSERT INTO `class_info` VALUES ('9', '语言');
INSERT INTO `class_info` VALUES ('10', '文学');
INSERT INTO `class_info` VALUES ('11', '艺术');
INSERT INTO `class_info` VALUES ('12', '历史');
INSERT INTO `class_info` VALUES ('13', '自然科学总论');
INSERT INTO `class_info` VALUES ('14', '环境科学');
INSERT INTO `class_info` VALUES ('15', '天文学、地球科学');
INSERT INTO `class_info` VALUES ('16', '生物科学');
INSERT INTO `class_info` VALUES ('17', '医药、卫生');
INSERT INTO `class_info` VALUES ('18', '农业科学');
INSERT INTO `class_info` VALUES ('19', '工业技术');
INSERT INTO `class_info` VALUES ('20', '交通运输');
INSERT INTO `class_info` VALUES ('21', '综合');

select * from class_info;



DROP TABLE IF EXISTS `book_info`;
CREATE TABLE `book_info` (
                             `book_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '图书编号',
                             `name` varchar(50) NOT NULL COMMENT '书名',
                             `author` varchar(50) NOT NULL COMMENT '作者',
                             `publish` varchar(30) NOT NULL COMMENT '出版社',
                             `ISBN` varchar(20) NOT NULL COMMENT 'ISBN',
                             `introduction` text COMMENT '书本描述',
                             `language` varchar(10) NOT NULL COMMENT '语言',
                             `price` decimal(10,2) NOT NULL COMMENT '价格',
                             `pubdate` date DEFAULT NULL COMMENT '出版日期',
                             `class_id` int(11) DEFAULT NULL COMMENT '图书类别序号',
                             `stock` int(11) DEFAULT NULL COMMENT '库存',
                             `state` smallint(6) DEFAULT NULL COMMENT '状态',
                             PRIMARY KEY (`book_id`),
                             KEY `pkclassid` (`class_id`),
                             CONSTRAINT `pkclassid` FOREIGN KEY (`class_id`) REFERENCES `class_info` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=50000045 DEFAULT CHARSET=utf8;

INSERT INTO `book_info` VALUES ('50000001', '月亮与六便士', '(英)毛姆', '浙江文艺出版社', '9787533936020', '“满地都是六便士，他却抬头看见了月亮。”', '中文', '39.80', '2017-01-01', '8', '6', null);
INSERT INTO `book_info` VALUES ('50000002', '明朝那些事儿', '当年明月', '中国海关出版社', '9787801656087', '《明朝那些事儿》讲述从1344年到1644年，明朝三百年间的历史。作品以史料为基础，以年代和具体人物为主线，运用小说的笔法，对明朝十七帝和其他王公权贵和小人物的命运进行全景展示，尤其对官场政治、战争、帝王心术着墨最多。作品也是一部明朝政治经济制度、人伦道德的演义。', '中文', '358.00', '2009-04-10', '12', '2', null);
INSERT INTO `book_info` VALUES ('50000003', 'Python编程', '(美)埃里克·马瑟斯', '人民邮电出版社', '9787115428028', '本书是一本针对所有层次的Python 读者而作的Python 入门书。', '中文', '89.00', '2016-07-01', '5', '10', null);
INSERT INTO `book_info` VALUES ('50000004', '第二性', '(法)西蒙·波伏娃', '北京:西苑出版社', '9787506806985', '著者西蒙·波伏娃出生于巴黎一个天主教色彩很浓的资产阶级家庭，她具有作家、哲学家、散文家等多重身分', '中文', '19.50', '2004-05-12', '4', '4', null);
INSERT INTO `book_info` VALUES ('50000005', '资本论', '余斌', '东方出版社 ', '7-80208-158-0', '本书包括“商品和货币”“货币转化为资本”“变了形的商品经济”“金融资本的统治”“新社会的曙光”五个章节，内容涵盖三卷《资本论》和数十卷《马克思恩格斯全集》（含被称为《资本论》第四卷的部分）和《马克思恩格斯选集》中的一些内容。作者通过将《资本论》用于对当下经济热点的解释，证明了马克思主义经济学理论的科学性和前瞻性，展现了经典的永恒魅力；通过对马克思主义经济学与西方经济学的对比和辨析，批驳了国内一些西方经济学家的错误观点，对国内学术圈盲目崇拜西方经济学的思潮带来冲击。', '英语', '65.00', '2016-02-25', '1', '1', null);
INSERT INTO `book_info` VALUES ('50000006', '小王子', '(法)安托万·德·圣-埃克苏佩里', '浙江文艺出版社', '9787533947279', '遥远星球上的小王子，与美丽而骄傲的玫瑰吵架负气出走，在各星球漫游中，小王子遇到了傲慢的国王，一个任性的酒鬼，一个唯利是图的商人，一个死守教条的地理学家，而后来到地球上，试图找到治 愈 孤独和痛苦的良方。 这时，他遇到一只渴望被驯养的狐狸，于是奇妙而令人惊叹的事情发生了……', '中文', '39.80', '2017-03-01', '8', '5', null);
INSERT INTO `book_info` VALUES ('50000007', 'Java编程思想', '(美)Bruce Eckel', '机械工业出版社', '9787111213826', '从Java的基础语法到最高级特性（深入的面向对象概念、多线程、自动项目构建、单元测试和调试等），本书都能逐步指导你轻松掌握。', '中文', '108.00', '2007-06-01', '5', '7', null);
INSERT INTO `book_info` VALUES ('50000008', '布局天下', '饶胜文', '解放军出版社', '9787506541435', '本书是一本历史军事地理著作。政治兴亡常与军事成败相关，而地理又与军事密切相关，故探讨中国古代军事地理大势，对于深入认识中国历史上历代兴亡，实为一个重要关键。', '中文', '21.00', '2002-01-01', '6', '4', null);
INSERT INTO `book_info` VALUES ('50000009', '中国经济2020', '王德培', '中国友谊出版公司', '9787505748583', '本书旨在对2020年的中国经济进行深入解析和预测，探讨究竟是谁开启了破碎化的序幕，指出中美贸易冲突既是终极也是过程，提出中国“三个世界”观点，带领读者穿越重重迷雾，寻找中国经济新亮点。', '中文', '58.00', '2020-01-01', '7', '7', null);
INSERT INTO `book_info` VALUES ('50000010', '战争改变历史', '马克思 布特', '上海科学技术文献出版社', '9787543945623', '《战争改变历史:1500年以来的军事技术、战争及历史进程》从技术革命角度入手，将1500年以来的军事技术、战争与历史的画卷呈现在读者面前。', '中文', '68.00', '2011-03-01', '6', '2', null);
INSERT INTO `book_info` VALUES ('50000011', '活着', '余华', '作家出版社', '9787506365437', '《活着(新版)》讲述了农村人福贵悲惨的人生遭遇。福贵本是个阔少爷，可他嗜赌如命，终于赌光了家业，一贫如洗。他的父亲被他活活气死，母亲则在穷困中患了重病，福贵前去求药，却在途中被国民党抓去当壮丁。经过几番波折回到家里，才知道母亲早已去世，妻子家珍含辛茹苦地养大两个儿女......', '中文', '20.00', '2012-08-01', '8', '8', null);
INSERT INTO `book_info` VALUES ('50000012', '小岛经济学', '(美)彼得·希夫 /(美)安德鲁·希夫', '中信出版社', '9787508649221', '我们渴望消除经济紧缩的痛苦，但是我们忘记了自由本身就是有风险的，如果政府有责任消除一切苦痛，那么就没有人是自由的。无法自由地失败，也就是无法自由地成功。', '中文', '59.00', '2016-09-04', '7', '2', null);
INSERT INTO `book_info` VALUES ('50000013', '大国的兴衰', '(美)保罗·肯尼迪', '国际文化出版公司', '9787801733672', '中国人素来有天下主义的抱负，他并不孜孜于追求中国的世界领导地位，也不反对由美国主导的全球化。但是，当今这个世界上还是现实主义者多过理想主义者。', '英文', '58.00', '2006-01-06', '7', '3', null);
INSERT INTO `book_info` VALUES ('50000014', '厚黑学', '李宗吾', '群言出版社', '9787800806063', '本书是一部有关人间交往谋略的著作，内容包括：厚黑学——立身行世面厚心黑，厚黑丛话上——做事为人厚心奇学等。', '中文', '28.00', '2004-05-25', '3', '4', null);
INSERT INTO `book_info` VALUES ('50000015', '语言本能', '(美)史蒂芬·平克', '浙江人民出版社', '9787213066559', '一扇了解语言器官、破解语法基因、进入人类心智的大门；一个关于语言问题最权威的答案。', '中文', '109.90', '2015-05-01', '9', '4', null);
INSERT INTO `book_info` VALUES ('50000016', '人间失格', '(日)太宰治', '浙江文艺出版社', '9787533943370', '川端康成说，死亡是最高的艺术。太宰治虽然只活了三十九岁，但他给日本文学留下的印记却是深刻而震撼的。', '中文', '25.00', '2016-01-01', '8', '4', null);
INSERT INTO `book_info` VALUES ('50000017', '中国大历史', '(美)黄仁宇', '生活 读书 新知三联书店', '9787108010360', '中国历史典籍浩如烟海，常使初学者不得其门而入。作者倡导“大历史”（macro-history），主张利用归纳法将现有史料高度压缩，先构成一个简明而前后连贯的纳领，然后在与欧美史比较的基础上加以研究。本书从技术的角度分析中国历史的进程，着眼于现代型的经济体制如何为传统社会所不容，以及是何契机使其在中国土地上落脚。', '中文', '19.00', '2007-02-06', '12', '2', null);
INSERT INTO `book_info` VALUES ('50000018', '独领风骚', '陶柏康', '北京:新华出版社', '7-5011-6401-0', '本书以毛泽东的经历和思想为主线，把他的诗词作品串连起来。内含“风骚独领，华采别具”、“风华当年，意切真情”、“沧海横流，壮怀激越”等二十四个专题。', '中文', '25.00', '2003-05-25', '1', '3', null);
INSERT INTO `book_info` VALUES ('50000019', '历史的温度', '张伟', '中信出版社', '9787533943370', '历史是万花筒，每个人看到的不同，每个角度看到的也不同。有的人看到了残酷，有的人看到了温情。有的人看到了杀戮，有的人看到了救赎。有的人看见了别人，有的人看见了自己。有的人假作真，有的人真作假。', '中文', '49.00', '2017-08-01', '12', '3', null);
INSERT INTO `book_info` VALUES ('50000020', '中国文学史', '袁行霈', '高等教育出版社', '9787040063868', '韩、柳所提倡的古文引起文学语言和文体的革新，宋代的欧阳修等人继续韩、柳的道路，完成了这次革新。由唐宋八大家共同完成的革新，确定了此后的文学语言和文体模式，一直到“五四”才打破', '中文', '23.70', '1999-08-01', '10', '4', null);
INSERT INTO `book_info` VALUES ('50000021', '文学回忆录', '木心', '广西师范大学出版社', '9787549530816', '文学是可爱的。生活是好玩的。艺术是要有所牺牲的。', '中文', '98.00', '2013-01-010', '10', '6', null);
INSERT INTO `book_info` VALUES ('50000022', '艺术的故事', '(英)贡布里希', '广西美术出版社', '9787807463726', '《艺术的故事》概括地叙述了从最早的洞窟绘画到当今的实验艺术的发展历程，以阐明艺术史是“各种传统不断迂回、不断改变的历史，每一件作品在这历史中都既回顾过去又导向未来。', '中文', '280.00', '2008-04-01', '11', '2', null);
INSERT INTO `book_info` VALUES ('50000023', '自然科学史与玫瑰', '(法)雷比瑟', '华夏出版社', '9787508091686', '玫瑰十字会是西方17世纪出现的著名神秘结社，也是西方历史上最为著名的秘密结社活动。本书追溯了它的古埃及和古希腊罗马起源，详述其源头的秘仪，揭示其与“炼金术”传统的历史关联，重点关注它的基本思想，以及对西方18世纪以来的文学的巨大影响。', '中文', '89.00', '2019-09-01', '13', '5', null);
INSERT INTO `book_info` VALUES ('50000024', '近代物理科学的形而上学基础', '埃德温·阿瑟·伯特', '湖南科学技术出版社', '9787535772077', '《科学源流译丛》之一。作者以近代与中世纪世界观的清晰对比为线索，批判和评价了哥白尼以来每一个重要的近代预设，对因果性、实体、时间、空间、质量等基本术语及其内涵的变化进行了深入的历史分析。', '中文', '48.00', '2012-08-01', '13', '3', null);
INSERT INTO `book_info` VALUES ('50000025', '大众天文学', 'C·弗拉马里翁', '广西师范大学出版社', '9787563337910', '世界名著译丛。 本书是由法国天文学家、世界著名科普作家C.弗拉马里翁所著，初版于1880年，遂成为传遍全球的科普经典，被誉为“法国图书馆镇馆之宝”。', '中文', '48.00', '2003-01-14', '15', '2', null);
INSERT INTO `book_info` VALUES ('50000026', '近代物理科学的形而上学基础', ' 埃德温·阿瑟·伯特', '湖南科学技术出版社', '9787535772077', '《科学源流译丛》之一。作者以近代与中世纪世界观的清晰对比为线索，批判和评价了哥白尼以来每一个重要的近代预设，对因果性、实体、时间、空间、质量等基本术语及其内涵的变化进行了深入的历史分析。', '中文', '48.00', '2012-08-01', '16', '4', null);
INSERT INTO `book_info` VALUES ('50000027', '现代人看中医', '曹军、冯清', '中国医药科技出版社', '9787506768153', '副标题: 趣谈中医药及全息', '中文', '52.00', '2014-06-01', '17', '3', null);
INSERT INTO `book_info` VALUES ('50000028', '四千年农夫', '富兰克林.H.金', '东方出版社', '9787506042284', '直正的农业旅行家很少。富兰克林·H·金是这方面真正的专家。', '中文', '45.00', '2011-06-25', '18', '4', null);
INSERT INTO `book_info` VALUES ('50000029', '工业技术经济学', '傅家骥', '清华大学出版社', '9787302021643', '本书是根据国家教委对高等学校理工科专业学生的要求而编写的教材。本书可作为高等院校理工科各专业和工商管理专业的教材，也可作工程技术人员和经济管理工作者的参考书。', '中文', '22.00', '1996-09-01', '19', '4', null);
INSERT INTO `book_info` VALUES ('50000030', '交通运输工程学', '沈志云', '人民交通出版社', '9787114047268', '本书全面介绍了铁路运输、公路运输、水路运输、航空运输和管道运输以及综合运输多式联运等各个领域的基本理论与专业基础，简要叙述了各种运输方式的主要设备、设施和建设技术，并对其运输能力、组织与管理、规划与评价、配制与协调以及发展趋势进行了阐述。', '中文', '58.00', '2003-09-01', '20', '3', null);
INSERT INTO `book_info` VALUES ('50000031', '空中英豪', '唐纳德·L·米勒', '人民日报出版社', '9787511523389', '《空中英豪》是迄今为止，最详尽的一部第八航空队专著，也是讲述美国空中力量二战经历的权威著作！', '中文', '128.00', '2014-01-20', '20', '3', null);
INSERT INTO `book_info` VALUES ('50000032', '大象的退却', '(英)伊懋可', '江苏人民出版社', '9787214133090', '伊懋可编著的《大象的退却：一部中国环境史》被誉为西方学者撰写中国环境史的奠基之作。', '中文', '68.00', '2014-12-01', '14', '5', null);
INSERT INTO `book_info` VALUES ('50000033', '现代艺术150年', '(英)威尔·贡培兹', '广西师范大学出版社', '9787533936020', '回顾现代艺术一个半世纪的反叛之路，我们见证了一代又一代人如何变得愈发反叛、大胆、混乱。这背后，是艺术家对“何为艺术”的无尽追问，是他们对周遭世界的回应与抵抗。现代艺术的故事仍在继续，也许永远不会完成。', '中文', '65.00', '2017-03-01', '11', '6', null);
INSERT INTO `book_info` VALUES ('50000034', '南腔北调', '郑子宁', '中国华侨出版社', '9787511377593', '科学吊打口音地图炮，把方言说得比古代汉语还高级。', '中文', '48.00', '2019-02-01', '9', '9', null);
INSERT INTO `book_info` VALUES ('50000035', '中国的西北角', '范长江', '新华出版社 ', '10203-011', '记录从1935年7月起，范长江作为《大公报》旅行记者的沿途见闻，向读者真实地还原当时中国工农红军长征的情况，《大公报》于1936年8月将其通讯集册出版，在中国的通讯史上具有重要的里程碑意义。', '中文', '90.00', '1980-04-01', '3', '2', null);
INSERT INTO `book_info` VALUES ('50000036', '公司法典型案例评析', '赵玲', '北京:对外经济贸易大学出版社', '978-7-81134-405-9', '本书由案情介绍、问题点提示、案例分析、备选法条四部分构成。使得案例分析脉络清晰、易于读者把握和理解。在案情介绍上，立足于案例的基本事实，但是又有所提炼、使得案情主干脉络突出等。', '中文', '19.00', '2009-05-09', '4', '4', null);
INSERT INTO `book_info` VALUES ('50000037', '人性的弱点', '(美)戴尔·卡耐基', '重庆:重庆出版社', '978-7-229-01927-3', '本书内容包括：“能成事的三大处事技巧”、“让人喜欢你的六大诀窍”、“赢得他人赞同的十二大准则”等8章，帮助人们发现并利用自己身体里无限的潜能超越自我。', '中文', '28.00', '2010-04-16', '3', '4', null);
INSERT INTO `book_info` VALUES ('50000038', '犯罪心理学', '张保平', '北京:中共中央党校出版社', '7-5035-2264-X', '本书详细阐述了犯罪心理形成的原因，犯罪心理的相关因素，犯罪心理的形成和发展变化，犯罪人的一般心理特征，犯罪心理的年龄差异等内容。', '中文', '12.80', '2001-05-25', '4', '4', null);
INSERT INTO `book_info` VALUES ('50000039', '孙子兵法', '(战国) 孙武', '延吉:延边人民出版社', '7-80698-186-1', '兵法-中国-古代', '中文', '58.00', '2006-05-11', '6', '5', null);
INSERT INTO `book_info` VALUES ('50000040', '斯大林:胜利与悲剧', '(俄) 德·安·沃尔科戈诺夫', '北京:国际文化出版公司', '7-80173-199-9', '本书是前苏联最高苏维埃主席团主席联共总书记斯大林的评传，作者以客观、历史的视角，记述了传主的生平、政治理论、思想与他对社会主义进程的影响。', '中文', '120.00', '2003-08-25', '1', '3', null);
INSERT INTO `book_info` VALUES ('50000041', '你不努力 谁也给不了你想要的生活', '一颗丸子', '北京:中国致公出版社', '9787514510119', '本书是青年作者一颗丸子的首部励志故事集。精选40篇关于梦想、关于职场、关于情感的励志故事，直击读者内心深处。让读者在感受到温暖的同时，更迸发出向上的力量！去勇敢地追寻梦想，实现自己的人生价值！是一本正能量满满的书。', '中文', '32.00', '2017-07-21', '2', '4', null);
INSERT INTO `book_info` VALUES ('50000042', '男人二十几岁要懂的心理学', '赵松编', '北京:地震出版社', '978-7-5028-3719-8', '本书从心理角度进行解释，指导你完善自我性格，促进人际和谐，改善思维方式，提高做事的能力和效率。', '英语', '36.00', '2011-05-25', '2', '6', null);
INSERT INTO `book_info` VALUES ('50000043', '墨菲定律', '华生', '北京:中国致公出版社', '978-7-5145-1053-9', '很多人看到的世界都是表面、千姿百态的，但其有内在的运行规律，掌握了这些规律，你就不会被事物的表象所左右。《墨菲定律》介绍了彼得原理、羊群效应、破窗理论、木桶定律、凡勃伦效应、蝴蝶效应等一百多个经典的定律，学习这些定律，可以更真实地认识这个世界，启迪人生法则，用这些规律来驾驭你的人生。', '中文', '39.80', '2017-05-05', '2', '5', null);
INSERT INTO `book_info` VALUES ('50000044', '毛泽东传', '(美) 罗斯·特里尔', '北京:中国人民大学出版社', '7-300-07010-8', '本书是外国作者编写的毛泽东传传记。', '中文', '55.00', '2016-04-25', '1', '4', null);

select * from book_info;



DROP TABLE IF EXISTS `lend_list`;
CREATE TABLE `lend_list` (
                             `sernum` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '借阅号',
                             `book_id` bigint(20) NOT NULL COMMENT '图书编号',
                             `reader_id` int(11) NOT NULL COMMENT '读者ID',
                             `lend_date` date DEFAULT NULL COMMENT '借阅时间',
                             `back_date` date DEFAULT NULL COMMENT '最晚归还时间',
                             `state` int(11) unsigned zerofill DEFAULT NULL COMMENT '归还状态1已还2未还',
                             `fine` double DEFAULT NULL COMMENT '产生罚金',
                             PRIMARY KEY (`sernum`)
) ENGINE=InnoDB AUTO_INCREMENT=2020040112 DEFAULT CHARSET=utf8;

INSERT INTO `lend_list` VALUES ('2020040101', '50000001', '1850210101', '2020-03-03', '2020-04-09', '00000000002', '1.8');
INSERT INTO `lend_list` VALUES ('2020040102', '50000002', '1850210101', '2020-03-03', '2020-07-02', '00000000002', null);
INSERT INTO `lend_list` VALUES ('2020040103', '50000003', '1850210101', '2020-03-03', '2020-04-02', '00000000001', '0.5');
INSERT INTO `lend_list` VALUES ('2020040104', '50000004', '1850210101', '2020-03-03', '2020-04-09', '00000000001', '0');
INSERT INTO `lend_list` VALUES ('2020040105', '50000001', '1850210202', '2020-03-04', '2020-04-04', '00000000002', '0.5');
INSERT INTO `lend_list` VALUES ('2020040106', '50000002', '1850210303', '2020-04-04', '2020-05-19', '00000000002', null);
INSERT INTO `lend_list` VALUES ('2020040107', '50000011', '1850210303', '2020-03-04', '2020-07-02', '00000000002', null);
INSERT INTO `lend_list` VALUES ('2020040108', '50000002', '1850210404', '2020-04-09', '2020-06-02', '00000000001', '0');
INSERT INTO `lend_list` VALUES ('2020040109', '50000015', '1850210505', '2020-03-04', '2020-07-02', '00000000001', '0');
INSERT INTO `lend_list` VALUES ('2020040110', '50000022', '1850210606', '2020-03-04', '2020-07-02', '00000000002', null);
INSERT INTO `lend_list` VALUES ('2020040111', '50000030', '1850210707', '2020-03-04', '2020-04-05', '00000000002', '0.2');

select * from lend_list;



DROP PROCEDURE IF EXISTS `update_conference_status`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_conference_status`()
BEGIN
    IF exists (select sernum from lend_list where `state`=2 and SYSDATE()>=back_date) THEN
        update lend_list set `fine`=DATEDIFF(SYSDATE(),back_date)*0.1
        where sernum in  (select sernum from (select sernum from lend_list where state=2 and SYSDATE()>=back_date) as tmp1);
    END IF;
END
;;
DELIMITER ;



DROP TABLE IF EXISTS `alsoborrow`;
CREATE TABLE `alsoborrow` (
                           `id` int(11) NOT NULL AUTO_INCREMENT,
                           `goodsid` int(11) DEFAULT NULL,
                           `list` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
                           `createtime` datetime DEFAULT NULL,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

select * from alsoborrow;



select l.reader_id userid,b.book_id goodsid,b.class_id parentid, l.lend_date createtime from lend_list l
left join book_info b on l.book_id = b.book_id;
select * from alsoborrow where goodsid='50000001';

select list from alsoborrow where goodsid='50000002';