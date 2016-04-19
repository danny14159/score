package shixi.service;

import java.util.Date;
import java.util.List;

import org.nutz.dao.QueryResult;

import shixi.bean.Subject;
import shixi.bean.Test;
import shixi.bean.TestSubject;

/**
 * 考试接口（用于考试信息的增删改查）
 * 
 * @author handsomeye
 * 
 */
public interface TestService {
	/**
	 * 增加考试信息
	 * 
	 * @param test
	 */
	void add(Test test);

	/**
	 * 根据考试ID删除考试信息
	 * 
	 * @param id
	 */
	void delete(int id);

	/**
	 * 根据考试ID更新考试信息
	 * 
	 * @param id
	 */
	void update(Test test);

	/**
	 * Test表根据id查询
	 * 
	 * @param test
	 * @return 对应考试id的考试信息
	 */
	List<Test> query(int id);

	/**
	 * 根据传入参数，查询考试信息
	 * 
	 * @param date1
	 * @param date2
	 * @param name
	 * @param pageNumber
	 * @param pageSize
	 * @return 考试信息
	 */
	QueryResult query(Date date1, Date date2, String name, int pageNumber,
			int pageSize);

	/**
	 * Test表根据时间，name查询准确记录
	 * 
	 * @param date
	 * @param name
	 * @return 对应时间和名称的考试信息
	 */
	List<Test> queryByDN(Date date, String name);

	/**
	 * 查询某一次考试的科目名称
	 * 
	 * @param testid
	 * @return 对应考试id的考试信息
	 */
	List<Subject> querysubject(int testid);

	/**
	 * 插入中间表
	 * 
	 * @param test
	 * @param lt
	 */
	void addwith(Test test, TestSubject[] lt);
}