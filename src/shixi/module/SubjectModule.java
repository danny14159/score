package shixi.module;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.nutz.dao.Cnd;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import shixi.bean.Subject;
import shixi.bean.User;
import shixi.dao.SubjectDao;
import shixi.dao.UserDao;
import shixi.service.StudentService;
import shixi.service.SubjectService;

@At("/subject")
@IocBean
public class SubjectModule {
	@Inject
	private UserDao userDao;
	@Inject
	private SubjectService subjectServiceImpl;
	@Inject
	private StudentService studentServiceImpl;
	
	@Inject
	private SubjectDao subjectDao;

	@At("/mine")
	@Ok("jsp:MySubject")
	public void MySubject(HttpServletRequest request,HttpSession session){
		
		int uid = (int) session.getAttribute("uid");
		request.setAttribute("list", subjectDao.dao().query(Subject.class, Cnd.where("teacher_id","=",uid)));
	}

	@At("/")
	@Ok("jsp:Subject")
	public void toSubject(HttpServletRequest request,HttpSession session){
		int uid = (int) session.getAttribute("uid");
		int level = (int) session.getAttribute("level");
		if(level == 4){
			request.setAttribute("allteachers", userDao.dao().query(User.class, Cnd.where("level","=",4)));
		}
		else if(level == 5){
			
			//request.setAttribute("mycourses", studentServiceImpl.listCourses(uid));
		}
	}
	@At("/add")
	public void add(@Param("..")Subject sub) {
		subjectServiceImpl.add(sub);
	}

	@At("/delete")
	public void delete(@Param("id")int id) {
		subjectServiceImpl.delete(id);
	}

	@At("/update")
	public void update(@Param("..")Subject sub) {
		subjectServiceImpl.update(sub);
	}

	@At("/query")
	@Ok("json")
	public List<Subject> query() {
		return subjectServiceImpl.query();
	}

	@At("/fetch")
	@Ok("json")
	public Subject fetch(@Param("id")int id) {
		return subjectServiceImpl.fetch(id);
	}
}
