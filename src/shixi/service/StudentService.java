package shixi.service;

/***********************************************************************
 * Module:  Student.java
 * Author:  Administrator
 * Purpose: Defines the Interface Student
 ***********************************************************************/

import java.util.List;

import org.nutz.dao.QueryResult;

import shixi.bean.Student;
import shixi.bean.Subject;

/**
 * 学生接口（学生信息的增删改查）
 * 
 * @author handsomeye
 * 
 */
public interface StudentService {
	/**
	 * 增加学生信息
	 * 
	 * @param stu
	 */
	void add(Student stu);

	/**
	 * 批量增加学生信息
	 * 
	 * @param list
	 */
	void batch(List<Student> list);

	/**
	 * 根据学生id删除学生信息
	 * 
	 * @param id
	 */
	void delete(int id);

	/**
	 * 根据传入参数，查询学生信息
	 * 
	 * @param stu_id
	 * @param atclass
	 * @param name
	 * @param pageNumber
	 * @param pageSize
	 * @return 学生信息
	 */
	QueryResult query(Integer stu_id, Integer atclass, String name,
			int pageNumber, int pageSize);

	/**
	 * 根据学生id，班级id查询学生信息
	 * 
	 * @param stu_id
	 * @param at_class
	 * @return
	 */
	/*List<Student> query(Integer stu_id, Integer at_class);*/
	public void updateStudent(Student student);
	
	public Student loadById(String id);
	
	public int selectCourse(int studentId,int courseId);
	
	/**取消选择
	 * @param studentId
	 * @param courseId
	 * @return
	 */
	public int deSelectCourse(int studentId,int courseId);
	
	
	/**查看所选课程
	 * @param studentId
	 * @return
	 */
	public List<Subject> listCourses(int studentId);
}
