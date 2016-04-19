package shixi.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.service.EntityService;

import shixi.bean.ClassSubject;
import shixi.bean.Subject;

@IocBean(fields = { "dao" })
public class ClassSubjectDao extends EntityService<ClassSubject> {
	/**
	 * 添加class和subject的关系 
	 * 
	 * @param classid
	 * @param subjectid
	 */
	public void addSubject(int classid, int subjectid) {
		ClassSubject cs = new ClassSubject();
		cs.setT_class_id(classid);
		cs.setT_subject_id(subjectid);
		dao().insert(cs);
	}

	/**
	 * 在t_class_subject表中删除 
	 * 
	 * @param classid
	 * @param subjectid
	 */
	public void deletesubject(int classid, int subjectid) {
		dao().deletex(ClassSubject.class, classid, subjectid);
	}

	/**
	 * 根据classid查询该班级的subject
	 * 
	 * @param classid
	 * @return 对应班级的学科信息
	 */
 
	public List<Subject>  querysubject(int classid){
		Sql sql = Sqls
				.create("SELECT ts.* FROM t_class_subject tcs JOIN t_subject ts ON tcs.t_subject_id=ts.id where tcs.t_class_id=@cid");
		sql.params().set("cid", classid);
		sql.setCallback(Sqls.callback.entities());
		sql.setEntity(dao().getEntity(Subject.class));
		dao().execute(sql);
		List<Subject> list = sql.getList(Subject.class);
		return list;
	}
	/**
	 * 查所有
	 * @return
	 */
	public List<ClassSubject> query(){
		return dao().query(ClassSubject.class, null);
	}
	/**
	 * 根据classsid删除一组记录
	 * clear
	 * @param id
	 */
	public void clear(Integer id ){
		dao().clear(ClassSubject.class, Cnd.where("t_class_id","=",id));
	}
}
