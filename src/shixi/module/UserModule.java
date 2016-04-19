package shixi.module;

import java.util.List;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import shixi.bean.User;
import shixi.service.UserService;

@IocBean
@At("/user")
public class UserModule {

	@Inject
	private UserService userServiceImpl;

	@At("/")
	@Ok("jsp:User")
	public void toUser() {

	}

	@At("/add")
	public void add(@Param("..") User user) {
		userServiceImpl.add(user);

	}

	@At("/delete")
	public void delete(@Param("id")Integer id) {
		userServiceImpl.delete(id);

	}

	@At("/update")
	public void update(@Param("..") User user) {
		userServiceImpl.update(user);
	}

	@At("/queryall")
	@Ok("json")
	public List<User> queryall() {
		return userServiceImpl.queryall();
	}

	@At("/queryById")
	@Ok("json")
	public User queryById(int id) {
		return userServiceImpl.queryById(id);
	}

	@At("/queryByName")
	@Ok("json")
	public User queryByName(String name) {
		return userServiceImpl.queryByName(name);
	}

}
