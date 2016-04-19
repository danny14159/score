package shixi.dao;

import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.dao.FieldFilter;
import org.nutz.dao.util.Daos;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.service.IdEntityService;

import shixi.bean.Class;

@IocBean(fields = { "dao" })
public class ClassDao extends IdEntityService<Class> {
	
	@Inject
	StudentDao studentDao;
	
	/**
	 * class表添加
	 * 
	 * @param clz
	 */
	public void add(Class clz) {
		dao().insert(clz);
	}

	/**
	 * class表按id删除
	 * 
	 * @param id
	 */
	public void delete(Integer id) {
		
		dao().delete(Class.class,id);
		
		/*Sql sql = Sqls
				.create("update t_class set del=1 where id=@id");
		sql.params().set("id", id);
		dao().execute(sql);*/
	}

	/**
	 * class表更新
	 * 
	 * @param clz
	 */
    public int update(Class obj) {
        int extRows = 0;
        if( null != obj ){
            extRows = Daos.ext(dao(), FieldFilter.create(getEntityClass(), true)).update(obj);
        }
        return extRows;
    }



	/**
	 * class表按id查询
	 * 
	 * @param id
	 * @return 对应id的班级信息
	 */
	public Class fetch(int id) {
		return dao().fetch(Class.class, id);
	}

	/**
	 * class表按at_grade查询
	 * 
	 * @param grade
	 * @return 对应年纪的所有班级信息
	 */
	public List<Class> query(int grade) {
		//return dao().query(Class.class, Cnd.where("at_grade", "=", grade).and("del","=","0"));
		List<Class> classz = dao().query(Class.class, Cnd.where("at_grade", "=", grade).and("del","=","0"));
		for(Class c:classz){
			c.setNstu(studentDao.count(Cnd.where("at_class","=",c.getId()).and("del","=","0")));
		}
		return classz;
	}

	/**
	 * class表查询所有
	 * 
	 * @return 所有班级信息
	 */
	public List<Class> query() {
		List<Class> classz = dao().query(Class.class, Cnd.where("del","=","0"));
		for(Class c:classz){
			c.setNstu(studentDao.count(Cnd.where("at_class","=",c.getId())));
		}
		return classz;
	}

}
