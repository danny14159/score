package shixi.service.serviceImpl;

import java.util.List;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import shixi.bean.User;
import shixi.dao.UserDao;
import shixi.service.UserService;
@IocBean
public class UserServiceImpl implements UserService{
	@Inject
	private UserDao userDao;
	@Override
	public void add(User user) {
		userDao.add(user);
	}

	@Override
	public void delete(Integer id) {
		userDao.delete(id);
	}

	@Override
	public void update(User user) {
		userDao.update(user);
	}

	@Override
	public List<User> queryall() {
		return userDao.queryall();
	}

	@Override
	public User queryById(int id) {
		return userDao.queryById(id);
	}

	@Override
	public User queryByName(String name) {
		return userDao.queryByName(name);
	}

}
