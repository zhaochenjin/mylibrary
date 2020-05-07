package mapper;

import java.util.List;

import pojo.PageBean;
import pojo.Readers;

public interface ReaderDao {
	//增加读者
	void addReader(Readers readers);
	//删除读者
	void delReader(Integer id);
	//修改读者
	void updateReader(Readers readers);
	//查询读者
	List<Readers> findReader(PageBean pageBean);
	//查询条数
	int readerCount(PageBean pageBean);
	//查询是否已经被注册
	int checkReader(Integer reader_id);
	
}
