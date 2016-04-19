package shixi.service;

import java.util.List;

import shixi.bean.Subject;

/**
 * 课程科目接口（用于课程科目的增删改查）
 * 
 * @author handsomeye
 * 
 */
public interface SubjectService {
	/**
	 * 增加课程科目信息
	 * 
	 * @param sub
	 */
	void add(Subject sub);

	/**
	 * 根据课程科目ID删除科目信息
	 * 
	 * @param id
	 */
	void delete(int id);

	/**
	 * 更新课程科目信息
	 * 
	 * @param sub
	 */
	void update(Subject sub);

	/**
	 * 查询所有科目信息
	 * 
	 * @return 所有课程科目信息
	 */
	List<Subject> query();

	/**
	 * 根据课程科目ID查询科目信息
	 * 
	 * @param id
	 * @return 对应科目id的科目信息
	 */
	Subject fetch(int id);

}