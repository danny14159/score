package shixi.service;

import java.util.List;

import shixi.bean.User;

public interface UserService {
	/**
	 * 添加用户
	 * 
	 * @param user
	 */
	void add(User user);

	/**
	 * 删除用户
	 * 
	 * @param id
	 */
	void delete(Integer id);

	/**
	 * 更新用户
	 * 
	 * @param user
	 */
	void update(User user);

	/**
	 * 查询所有用户
	 * 
	 * @return
	 */
	List<User> queryall();

	/**
	 * 根据id查询用户
	 * 
	 * @param id
	 * @return
	 */
	User queryById(int id);

	/**
	 * 根据name查询用户
	 * 
	 * @param name
	 * @return
	 */
	User queryByName(String name);
}
