package shixi.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.dao.FieldFilter;
import org.nutz.dao.QueryResult;
import org.nutz.dao.Sqls;
import org.nutz.dao.pager.Pager;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.service.IdEntityService;
import org.nutz.trans.Atom;
import org.nutz.trans.Trans;

import shixi.bean.Subject;
import shixi.bean.Test;
import shixi.bean.TestSubject;

@IocBean(fields = { "dao" })
public class TestDao extends IdEntityService<Test> {
	/**
	 * Test表增
	 * 
	 * @param test
	 */
	public void add(Test test) {
		dao().insert(test);
	}
    
	/**
	 * Test表删
	 * 
	 * @param id
	 */
	public void delete(Integer id) {
		dao().delete(Test.class,id);
	}

	/**
	 * Test表改
	 * 
	 * @param test
	 */
	public void update(final Test test) {
		FieldFilter.create(Test.class, true).run(new Atom(){
		    public void run(){		
		       dao().update(test);
		    }
		});
	}

	/**
	 * Test表查询所有
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return 所有考试信息（分页）
	 */
	public QueryResult query(int pageNumber, int pageSize) {
		Pager pager = dao().createPager(pageNumber, pageSize);
		List<Test> list = dao().query(Test.class, null, pager);
		pager.setRecordCount(dao().count(Test.class));
		return new QueryResult(list, pager);
	}
	/**
	 * 查询所有
	 * @return
	 */
    public List<Test> queryall(){
    	return dao().query(Test.class, null);
    }
	/**
	 * Test表根据id查询
	 * 
	 * @param id
	 * @return 对应考试id的考试信息
	 */
	public List<Test> query(int id) {
		return dao().query(Test.class, Cnd.where("id", "=", id));
	}

	/**
	 * Test表根据name查询
	 * 
	 * @param name
	 * @param pageNumber
	 * @param pageSize
	 * @return 对应考试名称的考试信息
	 */
	public QueryResult queryByName(String name, int pageNumber, int pageSize) {
		Pager pager = dao().createPager(pageNumber, pageSize);
		List<Test> listByName = dao().query(Test.class,
				Cnd.where("test_name", "like", "%" + name + "%"), pager);
		pager.setRecordCount(dao().count(Test.class,
				Cnd.where("test_name", "like", "%" + name + "%")));
		return new QueryResult(listByName, pager);
	}

	/**
	 * Test表根据时间查询
	 * 
	 * @param date1
	 * @param pageNumber
	 * @param pageSize
	 * @return 对应考试时间的考试信息
	 */
	public QueryResult queryByDate(Date date1, int pageNumber, int pageSize) {
		Pager pager = dao().createPager(pageNumber, pageSize);
		List<Test> listByDate = dao().query(Test.class,
				Cnd.where("Date", "=", date1), pager);
		pager.setRecordCount(dao().count(Test.class,
				Cnd.where("Date", "=", date1)));
		return new QueryResult(listByDate, pager);

	}

	/**
	 * Test表查询一段时间的记录
	 * 
	 * @param date1
	 * @param date2
	 * @param pageNumber
	 * @param pageSize
	 * @return 对应一段时间内的考试信息
	 */
	public QueryResult queryByPeriodDate(Date date1, Date date2,
			int pageNumber, int pageSize) {
		Pager pager = dao().createPager(pageNumber, pageSize);
		List<Test> listByPeriodDate = dao().query(Test.class,
				Cnd.where("Date", ">=", date1).and("Date", "<=", date2), pager);
		pager.setRecordCount(dao().count(Test.class,
				Cnd.where("Date", ">=", date1).and("Date", "<=", date2)));
		return new QueryResult(listByPeriodDate, pager);
	}

	/**
	 * Test表根据时间，name查询准确记录
	 * 
	 * @param date
	 * @param name
	 * @return 对应考试名称和考试时间的考试信息
	 */
	public List<Test> queryByDN(Date date, String name) {
		return dao().query(Test.class,
				Cnd.where("Date", "=", date).and("name", "=", name));
	}

	/**
	 * 查询某一次考试的科目名称
	 * 
	 * @param testid
	 * @return 对应考试id的科目信息
	 */
	public List<Subject> querysubject(int testid) {
		Sql sql = Sqls
				.create("SELECT ts.* FROM t_subject ts JOIN t_test_subject tts ON tts.subject_id=ts.id where tts.test_id=@tid ");
		sql.params().set("tid", testid);
		sql.setCallback(Sqls.callback.entities());
		sql.setEntity(dao().getEntity(Subject.class));
		dao().execute(sql);
		List<Subject> list = sql.getList(Subject.class);
		return list;
	}
	
	/**
	 * 添加中间表关系
	 * @param test
	 * @param lt
	 */
   public void addwith( Test test,TestSubject[] lt){
	   dao().insert(test);
	   List<Subject> ls=new ArrayList<Subject>();
	   for(TestSubject ts:lt){
		   Subject s=new Subject();
		   s.setId(ts.getSubject_id());
		   ls.add(s);
		   List<Test> tests = new ArrayList<Test>();
		   tests.add(test);
		   s.setTests(tests);
		   dao().insertRelation(s, "tests");
		   
		 
	   }
   }
}
