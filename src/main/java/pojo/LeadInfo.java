//借阅记录
package pojo;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

public class LeadInfo implements Serializable {
    private Integer sernum;//借阅号
    private Integer book_id;//图书编号

    private String bookName;//书
    private String adminName;//读者

    private String adminId;//读者id
    private Date lend_date;//借阅日期
    private Date back_date;//归还日期
    private Integer state=2;//归还状态  2默认未还  1已还2未还
    private Double fine;//罚款


    public Integer getSernum() {
        return sernum;
    }

    public void setSernum(Integer sernum) {
        this.sernum = sernum;
    }

    public Integer getBook_id() {
        return book_id;
    }

    public void setBook_id(Integer book_id) {
        this.book_id = book_id;
    }

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public String getLend_date() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(lend_date);
    }

    public void setLend_date(Date lend_date) {
        this.lend_date = lend_date;
    }

    public String getBack_date() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(back_date);
    }

    public void setBack_date(Date back_date) {
        this.back_date = back_date;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Double getFine() {
        return fine;
    }

    public void setFine(Double fine) {
        this.fine = fine;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }


    @Override
    public String toString() {
        return "LeadInfo{" +
                "sernum=" + sernum +
                ", bookName='" + bookName + '\'' +
                ", adminName='" + adminName + '\'' +
                ", book_id=" + book_id +
                ", adminId=" + adminId +
                ", lend_date=" + lend_date +
                ", back_date=" + back_date +
                ", fine=" + fine +
                ", state=" + state +
                '}';
    }
}
