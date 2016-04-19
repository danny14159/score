package shixi.dao;

import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.service.IdEntityService;

import shixi.bean.Subject;

@IocBean(fields = { "dao" })
public class SubjectDao extends IdEntityService<Subject> {
	/**
	 * 
	 * 增加科目信息
	 * 
	 * @param sub
	 */
	public void add(Subject sub) {
		dao().insert(sub);
	}

	/**
	 * 删除科目信息
	 * 
	 * @param id
	 */
	public void delete(Integer id) {
		dao().delete(Subject.class,id);
	}
	/**
	 * 根据科目name删除
	 * deleteByName
	 * @param name
	 */
    public void deleteByName(String name){
    	  Sql sql = Sqls
		            .create("delete from t_subject where name=@name");
          sql.params().set("name", name);
          dao().execute(sql);
    }
	/**
	 * 更新科目信息
	 * 
	 * @param sub
	 */
	public void update(Subject sub) {
		dao().update(sub);
	}

	/**
	 * 在subject表中按id取一条 fetch
	 * 
	 * @param id
	 * @return 对应id的科目信息
	 */
	public Subject fetch(int id) {
		return dao().fetch(Subject.class, id);
	}

	/**
	 * 查询所有科目信息
	 * 
	 * @return 所有科目信息
	 */
	public List<Subject> query() {
		return dao().query(Subject.class, null);
	}
	/**
	 * 根据name查询科目id，如果没查到返回0
	 * queryid
	 * @param name
	 * @return
	 */
	public int queryid(String name){
    int id = 0;
	List<Subject> ls=dao().query(Subject.class, Cnd.where("name","=",name));
	for(Subject s:ls){
		id= s.getId();
	}
	return id;
	}
}
