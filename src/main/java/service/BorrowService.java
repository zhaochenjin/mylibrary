package service;

import pojo.LeadInfo;
import pojo.PageBean;

import java.util.List;
import java.util.Map;

public interface BorrowService {

	void lendBook(LeadInfo leadInfo);
    PageBean getPb();
    List<LeadInfo> listDisBackBook(PageBean pageBean);
    int countDisBook(PageBean pageBean);
    void backBook(Map<String, Object> ret);
    Boolean isLended(LeadInfo leadInfo);
    Boolean cardState(LeadInfo leadInfo);
    Integer historyBook(String leaderId);

}
