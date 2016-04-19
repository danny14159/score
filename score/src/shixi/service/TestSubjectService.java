package shixi.service;

import java.util.List;

import shixi.bean.TSubject;
import shixi.bean.TestSubject;

public interface TestSubjectService {
	/**
	 * 根据考试id查询考试时间
	 * 
	 * @param testid
	 * @return 对应考试id的考试学科信息
	 */
	List<TSubject> querytime(int testid);

	/**
	 * 添加考试科目
	 * 
	 * @param ts
	 */
	void add(TestSubject ts);

	/**
	 * 批量插入考试科目
	 * 
	 * @param list
	 */

	void adds(List<TestSubject> list);

	/**
	 * 根据考试ID删除考试信息
	 * 
	 * @param testid
	 */
	void delete(int testid);

	/**
	 * 根据考试id查询对应考试的考试科目
	 * 
	 * @param test_id
	 * @return 考试的考试科目
	 */
	List<TestSubject> query(int test_id);
}
