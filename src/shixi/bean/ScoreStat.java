package shixi.bean;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.PK;
import org.nutz.dao.entity.annotation.Table;
//成绩统计表
@Table("t_score_stat")
@PK({"stu_id","test_id"})
public class ScoreStat {
 
	
	@Column
	private int stu_id;
	
	@Column
	private int test_id;
	
	@Column 
	private float total_score;
	
	@Column
	private Integer class_order;
	
	@Column 
	private Integer school_order;

	@Column
    private int del;


	public int getDel() {
		return del;
	}


	public void setDel(int del) {
		this.del = del;
	}

	public int getStu_id() {
		return stu_id;
	}

	public void setStu_id(int stu_id) {
		this.stu_id = stu_id;
	}

	public int getTest_id() {
		return test_id;
	}

	public void setTest_id(int test_id) {
		this.test_id = test_id;
	}

	public float getTatal_score() {
		return total_score;
	}

	public void setTatal_score(float tatal_score) {
		this.total_score = tatal_score;
	}

	public Integer getClass_order() {
		return class_order;
	}

	public void setClass_order(Integer class_order) {
		this.class_order = class_order;
	}

	public Integer getSchool_order() {
		return school_order;
	}

	public void setSchool_order(Integer school_order) {
		this.school_order = school_order;
	}
}
