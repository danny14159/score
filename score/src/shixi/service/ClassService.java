package shixi.service;

import java.util.List;

import shixi.bean.Class;
import shixi.bean.Subject;

/**
 * 班级接口（班级信息的增删改查）
 * 
 * @author handsomeye
 * 
 */
public interface ClassService {
	/**
	 * 增加班级信息
	 * 
	 * @param clz
	 */
	void add(Class clz);

	/**
	 * 按班级ID删除班级信息
	 * 
	 * @param id
	 */
	void delete(int id);

	/**
	 * 更新班级信息
	 * 
	 * @param clz
	 */
	void update(Class clz);

	/**
	 * 根据班级ID查询
	 * 
	 * @param id
	 * @return 对应班级id的班级信息
	 */
	Class fetch(int id);

	/**
	 * 查询所有班级信息
	 * 
	 * @return 所有班级信息
	 */
	List<Class> query(Integer grade);

	/**
	 * 添加学科
	 * 
	 * @param classid
	 * @param subjectid
	 */
	void addSubject(int classid, int subjectid);

	/**
	 * 删除学科
	 * 
	 * @param classid
	 * @param subjectid
	 */
	void delSubject(int classid, int subjectid);

	/**
	 * 根据班级ID查询学科
	 * 
	 * @param classid
	 * @return 对应班级id的学科信息
	 */
	List<Subject> querySubject(int classid);

}