package shixi.dao;

import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.dao.FieldFilter;
import org.nutz.dao.QueryResult;
import org.nutz.dao.pager.Pager;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.service.IdEntityService;
import org.nutz.trans.Atom;

import shixi.bean.User;

@IocBean(fields = { "dao" })
public class UserDao  extends IdEntityService<User>{
    /**
     * 添加用户
     * @param user
     */
	public void add(User user){
		dao().insert(user);
	}
	/**
	 * 删除用户
	 * @param id
	 */
	public void delete(Integer id){
		dao().delete(User.class, id);
	}
	/**
	 * 更新用户
	 * @param user
	 */
	public void update(final User user){
		FieldFilter.create(User.class,true).run(new Atom(){
			  public void run(){
		           dao().update(user);
			  }
		});
	}
	/**
	 * 查询所有用户
	 * @return
	 */
	public List<User> queryall(){
		return dao().query(User.class, null);
	}
	/**
	 * 查询所有用户(分页)
	 * @return
	 */
	public QueryResult queryallFy(int pageNumber, int pageSize){
		Pager pager = dao().createPager(pageNumber, pageSize);
		List<User> users=dao().query(User.class, null,pager);
		pager.setRecordCount(dao().count(User.class));
		return new QueryResult(users, pager);
	}
	/**
	 * 根据id查询用户
	 * @param id
	 * @return
	 */
	public User queryById(int id){
		return dao().fetch(User.class,Cnd.where("id","=",id));
	}
	/**
	 * 根据name查询用户
	 * @param name
	 * @return
	 */
	public User queryByName(String name){
		return dao().fetch(User.class, Cnd.where("username","=",name));
	}
}

