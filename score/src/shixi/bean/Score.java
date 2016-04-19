package shixi.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.Table;
//成绩表
@Table("t_score")
public class Score {
	@Id
	private int id;
	
	@Column
	private int test_id;
	
	@Column
	private int subject_id;
	
	@Column
	private int stu_id;
	
	
	@Column
	private String stu_name;
	
	@Column
	private String class_name;
	
	@Column
	private int at_grade;
	
	@Column
	private float score;
	
	@Column
    private int del;


	public int getDel() {
		return del;
	}


	public void setDel(int del) {
		this.del = del;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getTest_id() {
		return test_id;
	}

	public void setTest_id(int test_id) {
		this.test_id = test_id;
	}

	public int getSubject_id() {
		return subject_id;
	}

	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}

	public int getStu_id() {
		return stu_id;
	}

	public void setStu_id(int stu_id) {
		this.stu_id = stu_id;
	}

	public String getStu_name() {
		return stu_name;
	}

	public void setStu_name(String stu_name) {
		this.stu_name = stu_name;
	}

	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public int getAt_grade() {
		return at_grade;
	}

	public void setAt_grade(int at_grade) {
		this.at_grade = at_grade;
	}

	public float getScore() {
		return score;
	}

	public void setScore(float score) {
		this.score = score;
	}
	
	

}
