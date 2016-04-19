package shixi.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.dao.FieldFilter;
import org.nutz.dao.Sqls;
import org.nutz.dao.sql.Sql;
import org.nutz.dao.sql.SqlCallback;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.service.IdEntityService;
import org.nutz.trans.Atom;

import shixi.bean.Score;
import shixi.bean.Student;

@IocBean(fields = { "dao" })
public class ScoreDao extends IdEntityService<Score> {
	/**
	 * 查学生一次考试所有科目总分
	 * 
	 * @param studentid
	 * @param testid
	 * @return 某位学生的某次考试的所有科目总分
	 */
	public float querySum(int studentid, int testid) {
		Sql sql = Sqls
				.create("SELECT sum(score) AS sum from t_score where stu_id=@sid and test_id=@tid");
		sql.params().set("sid", studentid);
		sql.params().set("tid", testid);
		sql.setCallback(new SqlCallback() {
			public Object invoke(Connection conn, ResultSet rs, Sql sql)
					throws SQLException {
				float sunscore = 0;
				while(rs.next()){
				 sunscore = rs.getFloat("sum");
				 }
				return sunscore;
			}
		});
		dao().execute(sql);
		return sql.getObject(Float.class);
	}

	/**
	 * 录入成绩
	 * 
	 * @param score
	 */
	public void input(Score score) {
		dao().insert(score);
	}

	/**
	 * 根据成绩ID删除成绩
	 * 
	 * @param id
	 */
	public void delete(Integer id) {
		dao().delete(Score.class,id);
	}

	/**
	 * 更新成绩信息
	 * 
	 * @param score
	 */
	public void update(final Score score) {
		FieldFilter.create(Score.class, true).run(new Atom(){
		    public void run(){
		    	Score score2 =dao().fetch(Score.class,
				Cnd.where("stu_id", "=", score.getStu_id()).and("test_id", "=", score.getTest_id())
						.and("subject_id", "=", score.getSubject_id()));
		    	score2.setScore(score.getScore());
		    	dao().update(score2);
		    }
		});
		
	}

	/**
	 * 查询考试成绩（根据学生id，考试id,学科id则查相应学科）
	 * 
	 * @param studentid
	 * @param testid
	 * @param subjectid
	 * @return 相应学科考试成绩
	 */
	public float queryById1(int studentid, int testid, int subjectid) {
		Score score= dao().fetch(
				Score.class,
				Cnd.where("stu_id", "=", studentid).and("test_id", "=", testid)
						.and("subject_id", "=", subjectid));
		float score1=0;
		if(score==null)
		{
			return score1;
		}else{
		return score.getScore();
		}
	}

	/**
	 * 查询考试成绩（根据学生id，考试id查所有学科成绩）
	 * 
	 * @param studentid
	 * @param testid
	 * @return 所有学科考试成绩
	 */
	public List<Score> queryById2(int studentid, int testid) {
		return dao()
				.query(Score.class,
						Cnd.where("stu_id", "=", studentid).and("test_id", "=",
								testid));
	}
	/**
	 * 根据学生id，考试id,学科id返回一个score对象
	 * @param studentid
	 * @param testid
	 * @param subjectid
	 * @return
	 */
   public Score queryById3(int studentid, int testid, int subjectid) {
		return dao().fetch(
				Score.class,
				Cnd.where("stu_id", "=", studentid).and("test_id", "=", testid)
						.and("subject_id", "=", subjectid));
	   
   }
	/**
	 * 批量添加学生成绩
	 * 
	 * @param score
	 */
	public void batch(List<Score> score) {
		dao().fastInsert(score);
	}
	/**
	 * 查询所有
	 * @return
	 */
	public List<Score> queryall(){
		return dao().query(Score.class, null);
	}
	/**
	 * 根据学号，考试号，删除一组记录
	 * @param object
	 * @param test_id
	 */
	public void deleteByst(Object object,Integer test_id){
		dao().clear(Score.class, Cnd.where("stu_id","=",object).and("test_id","=",test_id));
	}
	/**
	 * 返回优秀率，及格率，以及差分率
	 * @param subjectid
	 * @param testid
	 * @param score
	 * @param stuTotalNumber
	 * @return
	 */
	public float queryStuNumber(int subjectid,int testid,float score,int stuTotalNumber,int classid){
		List<Score> scores2=new ArrayList<Score>();
		if(score>=60){
		List<Score> scores=dao().query(Score.class, Cnd.where("test_id","=",testid).and("subject_id","=",subjectid).and("score",">=",score));	
		for(Score score2:scores){
			int stuid=score2.getStu_id();
		    Student student=dao().fetch(Student.class,Cnd.where("id","=",stuid));
		   if( student.getAt_class()==classid){
			   scores2.add(score2);
		   }
		}
		for(Score s:scores2){
			System.out.println("ID:"+s.getId()+" 学号："+s.getStu_id()+" 姓名："+s.getStu_name()+" 科目："+s.getSubject_id()+" 考试："+s.getTest_id()+"分数："+s.getScore()+"班级"+s.getClass_name()+"年级："+s.getAt_grade());
		}
		return (float)scores2.size()/stuTotalNumber;
		}
		else{
		List<Score> scores=dao().query(Score.class, Cnd.where("test_id","=",testid).and("subject_id","=",subjectid).and("score","<=",score));
		for(Score score2:scores){
			int stuid=score2.getStu_id();
		    Student student=dao().fetch(Student.class,Cnd.where("id","=",stuid));
		   if( student.getAt_class()==classid){
			   scores2.add(score2);
		   }
		}
		return (float)scores2.size()/stuTotalNumber;
		}
	}
}
