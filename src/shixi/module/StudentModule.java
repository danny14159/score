package shixi.module;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.nutz.dao.QueryResult;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import shixi.bean.Student;
import shixi.service.StudentService;

@At("/student")
@IocBean
public class StudentModule {
	@Inject
	private StudentService studentServiceImpl;

	@At("/")
	@Ok("jsp:Student")
	public void toStudent() {

	}

	@At("/add")
	public void add(@Param("..")Student stu) {
		studentServiceImpl.add(stu);
	}

	@At("/batch")
	public void batch(List<Student> list) {
		studentServiceImpl.batch(list);
	}

	@At("/delete")
	public void delete(@Param("id")int id) {
		studentServiceImpl.delete(id);
	}

@At("/update")
	public void update(@Param("..")Student student) {
		studentServiceImpl.updateStudent(student);
	}
/*	
	@At("/query")
	@Ok("json")
	public List<Student> query(@Param("stu_id")Integer stu_id, @Param("at_class")Integer at_class) {
		return studentServiceImpl.query(stu_id, at_class);
	}*/

	@At("/queryPage")
	@Ok("json")
	public QueryResult query(@Param("stu_id")Integer stu_id, @Param("atclass")Integer atclass, @Param("name")String name,
			@Param("pageNumber")int pageNumber, @Param("pageSize")int pageSize) {
		return studentServiceImpl.query(stu_id, atclass, name, pageNumber,
				pageSize);
	}

	/**学生选课
	 * @param sid
	 * @param cid
	 * @return
	 */
	@At("/selCourse")
	@Ok("json")
	public Object selCourse(
			@Param("sid")Integer sid,
			@Param("cid")Integer cid
			){
		
		return studentServiceImpl.selectCourse(sid, cid);
	}
	
	/**
	 * @return
	 */
	@At("/listCourses")
	@Ok("jsp:listCourses")
	public void listCourses(HttpSession session,HttpServletRequest request){
		
		int uid = (int) session.getAttribute("uid");
		
		request.setAttribute("courses", studentServiceImpl.listCourses(uid));
	}
}
