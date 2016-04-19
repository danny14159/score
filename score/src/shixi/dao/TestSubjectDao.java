package shixi.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.dao.FieldFilter;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.service.EntityService;
import org.nutz.trans.Atom;

import shixi.bean.Subject;
import shixi.bean.TSubject;
import shixi.bean.Test;
import shixi.bean.TestSubject;

@IocBean(fields = { "dao" })
public class TestSubjectDao extends EntityService<TestSubject> {
	/**
	 * 根据考试id查询考试时间
	 * 
	 * @param testid
	 * @return 对应考试id的考试时间
	 */
	public List<TSubject> querytime(int testid) {
		Sql sql = Sqls
				.create("SELECT ts.name AS name,tts.start_time AS start,tts.end_time AS end from t_test_subject tts JOIN t_stubject ts ON tts.stubject_id=ts.id where tts.test_id=@tid");
		sql.params().set("tid", testid);
		sql.setCallback(new SqlCallback() {
			public Object invoke(Connection conn, ResultSet rs, Sql sql)
					throws SQLException {
				List<TSubject> list = new LinkedList<TSubject>();
				while (rs.next()) {
					TSubject ts = new TSubject();
					ts.setName(rs.getString("name"));
					ts.setStarttime(rs.getDate("start"));
					ts.setEndtime(rs.getDate("end"));
					list.add(ts);
				}
				return list;
			}
		});
		dao().execute(sql);
		return sql.getList(TSubject.class);
	}

	/**
	 * 添加考试科目
	 * 
	 * @param ts
	 */
	public void add(TestSubject ts) {
		dao().insert(ts);
	}

	/**
	 * 批量插入考试科目
	 * 
	 * @param list
	 */
	public void adds(List<TestSubject> list) {
		dao().fastInsert(list);
	}

	/**
	 * 根据考试ID删除考试信息
	 * 
	 * @param testid
	 */
	public void delete(int testid) {
		dao().clear(TestSubject.class, Cnd.where("test_id", "=", testid));
	}
	/**
	 * 更新t_test_subject中间表
	 * @param ls
	 */
	public void update(final TestSubject[] testSubjects){
		FieldFilter.create(TestSubject.class, true).run(new Atom(){
		    public void run(){
		     for(TestSubject ts:testSubjects){
		    	 dao().update(ts);
		     }
		    }
		});
	}
	/**
	 * 根据testid查询记录
	 * @param testid
	 * @return
	 */
	public List<TestSubject> query(int testid){
		return dao().query(TestSubject.class, Cnd.where("test_id","=",testid));
	}
}
