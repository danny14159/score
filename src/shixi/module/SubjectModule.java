package shixi.module;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.nutz.dao.Cnd;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;
import org.nutz.web.ajax.Ajax;

import shixi.bean.Student;
import shixi.bean.Subject;
import shixi.bean.User;
import shixi.dao.ClassDao;
import shixi.dao.StudentDao;
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
	private ClassDao classDao;
	@Inject
	private SubjectService subjectServiceImpl;
	@Inject
	private StudentService studentServiceImpl;
	@Inject
	private StudentDao studentDao;
	@Inject
	private SubjectDao subjectDao;

	@At("/mine")
	@Ok("jsp:MySubject")
	public void MySubject(HttpServletRequest request,HttpSession session){
		
		int uid = (int) session.getAttribute("uid");
		request.setAttribute("list", subjectDao.dao().query(Subject.class, Cnd.where("teacher_id","=",uid)));
	}
	
	@At("/subjectStus")
	@Ok("jsp:SubjectStudents")
	public void SubjectStudents(HttpServletRequest request,@Param("subjectId") String subjectId){
		Sql sql = Sqls.create("select ts.id,ts.name,ts.sex,ts.location,ts.address,ts.enterYear,tc.name as className,ts.at_class "
				+ "from t_course_selecting tcs "
				+ "left join t_stu ts on ts.id=tcs.student_id "
				+ "left join t_class tc on tc.id=ts.at_class "
				+ "where subject_id=@subject");
		sql.params().set("subject", subjectId);
		sql.setCallback(Sqls.callback.entities());
		sql.setEntity(studentDao.getEntity());
		studentDao.dao().execute(sql);
		
		List<Student> list = sql.getList(Student.class);
		for(Student item:list){
			item.setClassName(classDao.fetch(Cnd.where("id", "=", item.getAt_class())).getName());
		}
		request.setAttribute("list",list );
	}

	@At("/")
	@Ok("jsp:Subject")
	public void toSubject(HttpServletRequest request,HttpSession session){
		//int uid = (int) session.getAttribute("uid");
		int level = (int) session.getAttribute("level");
		if(level == 4 || level == 1){
			request.setAttribute("allteachers", userDao.dao().query(User.class, Cnd.where("level","=",4)));
		}
		else if(level == 5){
			
			//request.setAttribute("mycourses", studentServiceImpl.listCourses(uid));
		}
	}
	@At("/add")
	@Ok("json")
	public Object add(@Param("..")Subject sub) {
		
		int num = subjectDao.dao().count(Subject.class, Cnd.where("teacher_id", "=", sub.getTeacher_id()).and("weekday","=",sub.getWeekday()).and("part","=",sub.getPart()));
		if(num == 0){
			subjectServiceImpl.add(sub);
			return Ajax.ok();
		}
		return Ajax.fail();
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
