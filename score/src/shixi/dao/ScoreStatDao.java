package shixi.dao;

import java.util.ArrayList;
import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.dao.FieldFilter;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.service.EntityService;
import org.nutz.trans.Atom;

import com.sun.org.apache.bcel.internal.generic.ARRAYLENGTH;

import shixi.bean.ScoreStat;
import shixi.bean.Student;
import shixi.bean.StudentTotalScore;

@IocBean(fields = { "dao" })
public class ScoreStatDao extends EntityService<ScoreStat> {
	/**
	 * 插入一条记录
	 * 
	 * @param scorestat
	 */
	public void add(ScoreStat scorestat) {
		dao().insert(scorestat);
	}

	/**
	 * 批量插入
	 * 
	 * @param list
	 */
	public void batch(List<ScoreStat> list) {
		dao().fastInsert(list);
	}

	/**
	 * 根据学生id和考试id插入排名，通过过滤孔子段，可以插入班级或年级排名
	 * 
	 * @param studentid
	 * @param testid
	 * @param classorder
	 */

	public void insertpart(final List<ScoreStat> ls){
		FieldFilter.create(ScoreStat.class, true).run(new Atom(){
		    public void run(){
		      for(ScoreStat ss:ls){
		    	  if(exists(ss.getStu_id(),ss.getTest_id()))
		    		  dao().update(ss);
		    	  else dao().insert(ss);
		      }
		    }
		});
	}
	
	/**
	 * 删除
	 * 
	 * @param student_id
	 * @param test_id
	 */
	public void delete(Integer student_id, Integer test_id) {
		dao().deletex(ScoreStat.class, student_id, test_id);
	}

	/**
	 * 更新
	 * 
	 * @param scorestat
	 */
	public void update(ScoreStat scorestat) {
		dao().update(scorestat);
	}
	/**
	 * 批量更新排名
	 * updateByList
	 * @param ls
	 */
    public void updateByList(List<ScoreStat> ls){ 
    	for(ScoreStat ss:ls){
    	dao().update(ss);
    	}
    }
	/**
	 * 查一条记录
	 * 
	 * @param student_id
	 * @param test_id
	 * @return 某位学生某次考试的统计信息
	 */
	public ScoreStat queryById(Integer student_id, Integer test_id) {
		return dao().fetchx(ScoreStat.class, student_id, test_id);
	}

	/**
	 * 查所有记录
	 * 
	 * @return 所有成绩统计信息
	 */
	public List<ScoreStat> query() {
		return dao().query(ScoreStat.class, null);
	}

	/**
	 * 查某一班级一次考试所有学生的记录
	 * 
	 * @param classid
	 * @param test_id
	 * @return 某位学生某次考试的成绩统计信息
	 */
	public List<ScoreStat> queryByClass(int classid, int test_id) {
		Sql sql = Sqls
				.create("SELECT tss.* from t_score_stat tss JOIN t_stu ts ON tss.stu_id=ts.id where ts.at_class=@cid and tss.test_id=@tid");
		sql.params().set("cid", classid);
		sql.params().set("tid", test_id);
		sql.setCallback(Sqls.callback.entities());
		sql.setEntity(dao().getEntity(ScoreStat.class));
		dao().execute(sql);
		List<ScoreStat> list = sql.getList(ScoreStat.class);
		return list;
	}

	/**
	 * 查某一年级一次考试所有学生的记录
	 * 
	 * @param at_grade
	 * @param test_id
	 * @return 某个年纪的某次考试的所有学生成绩统计信息
	 */
	public List<ScoreStat> queryByGrade(int at_grade, int test_id) {
		Sql sql = Sqls
				.create("SELECT tss.* FROM t_score_stat tss JOIN t_stu ts ON tss.stu_id=ts.id JOIN t_class tc ON tc.id=ts.at_class where tc.at_grade=@gid and tss.test_id=@tid");
		sql.params().set("gid", at_grade);
		sql.params().set("tid", test_id);
		sql.setCallback(Sqls.callback.entities());
		sql.setEntity(dao().getEntity(ScoreStat.class));
		dao().execute(sql);
		List<ScoreStat> list = sql.getList(ScoreStat.class);
		return list;
	}
	/**
	 * 查某班的前几名
	 * @param classid
	 * @param test_id
	 * @param top
	 * @return
	 */
	public List<ScoreStat> queryTop(int classid, int test_id,int top) {
		Sql sql = Sqls
				.create("SELECT tss.* from t_score_stat tss JOIN t_stu ts ON tss.stu_id=ts.id where ts.at_class=@cid and tss.test_id=@tid and tss.class_order<=@top order by total_score DESC");
		sql.params().set("cid", classid);
		sql.params().set("tid", test_id);
		sql.params().set("top", top);
		sql.setCallback(Sqls.callback.entities());
		sql.setEntity(dao().getEntity(ScoreStat.class));
		dao().execute(sql);
		List<ScoreStat> list = sql.getList(ScoreStat.class);
		return list;
	}
	/**
	 * 查某次考试年级前几名中该班有那几人
	 * @param classid
	 * @param test_id
	 * @param top
	 * @return
	 */
	public List<ScoreStat> queryTop2(int classid, int test_id,int top) {
		List<ScoreStat> list=dao().query(ScoreStat.class, Cnd.where("test_id","=",test_id).and("school_order","<=",top).desc("total_score"));		
		List<ScoreStat> list3 = new ArrayList<ScoreStat>();
		for(ScoreStat scoreStat:list){
			int stuid=scoreStat.getStu_id();
		    Student student=dao().fetch(Student.class, Cnd.where("id","=",stuid));
		    if(student.getAt_class()==classid){
		    	list3.add(scoreStat);
		    }
		}
		return list3;
	}
}
