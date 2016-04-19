package shixi.module;

import javax.servlet.http.HttpSession;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.POST;
import org.nutz.mvc.annotation.Param;
import org.nutz.web.ajax.Ajax;
import org.nutz.web.ajax.AjaxReturn;

import shixi.bean.Student;
import shixi.bean.User;
import shixi.service.StudentService;
import shixi.service.UserService;

@IocBean
@At("/users")
public class LoginModule {
	@Inject
	private UserService userServiceImpl;	
	
	@Inject
	private StudentService studentServiceImpl;

	@POST
	@At("/login")
	@Ok("json")
	public AjaxReturn login(@Param("username") String username,
			@Param("password") String password, HttpSession session) {
		User user = userServiceImpl.queryByName(username);
		AjaxReturn result = Ajax.fail();
		if (user == null){
			Student stu = studentServiceImpl.loadById(username);
			
			if("123456".equals(password) && null != stu){
				session.setAttribute("username", stu.getName());
				session.setAttribute("level", 5);
				result.setOk(true).setMsg("登陆成功");
				
				return result;
			}
			
		}else if ((user.getPassword()).equals(password)) {
			session.setAttribute("username", username);
			session.setAttribute("level", user.getLevel());
			result.setOk(true).setMsg("登陆成功");
		} else {
			result.setMsg("密码错误");
		}
		return result;
	}

	@At("/logout")
	@Ok("jsp:/login")
	public void logout(HttpSession session) {
		session.invalidate();
	}

	@At("/")
	public void toLogin() {
	}
}
