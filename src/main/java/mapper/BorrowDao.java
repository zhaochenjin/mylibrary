package mapper;

import org.apache.ibatis.annotations.Param;
import pojo.LeadInfo;
import pojo.PageBean;

import java.util.List;
import java.util.Map;

public interface BorrowDao {
	//添加借阅记录
	void addLead(LeadInfo leadInfo);
	List<LeadInfo> listDisBackBook(PageBean pageBean);
	Integer countDisBook(PageBean pageBean);
    //设置罚金
    void addFine();
    //归还图书
    void backBook(@Param("params") Map<String, Object> ret);
    //是否已经借过
    Integer isLended(LeadInfo leadInfo);
    Integer cardState(LeadInfo leadInfo);
    Integer disBack(LeadInfo leadInfo);
    Integer historyBook(String readerId);

}
