package shixi.bean;

import java.util.List;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.ManyMany;
import org.nutz.dao.entity.annotation.Table;

//科目表
@Table("t_subject")
public class Subject {
	@Id
	private int id;
	
	@Column
	private String name;
	
	@Column
    private int del;
	
	@ManyMany(target=Test.class,relation="t_test_subject",from="subject_id",to="test_id")
	private List<Test> tests;
	
	@Column
	private String during;
	
	@Column
	private int teacher_id;
	
	@Column
	private int begin_hour;

	@Column
	private int begin_min;
	
	@Column
	private int end_hour;
	
	@Column
	private int end_min;
	
	@Column
	private String weekday;
	
	public String getWeekday() {
		return weekday;
	}


	public void setWeekday(String weekday) {
		this.weekday = weekday;
	}


	public String getPeriod() {
		return period;
	}


	public void setPeriod(String period) {
		this.period = period;
	}


	public String getPart() {
		return part;
	}


	public void setPart(String part) {
		this.part = part;
	}

	@Column
	private String period;
	
	@Column
	private String part;
	

	public int getBegin_hour() {
		return begin_hour;
	}


	public void setBegin_hour(int begin_hour) {
		this.begin_hour = begin_hour;
	}


	public int getBegin_min() {
		return begin_min;
	}


	public void setBegin_min(int begin_min) {
		this.begin_min = begin_min;
	}


	public int getEnd_hour() {
		return end_hour;
	}


	public void setEnd_hour(int end_hour) {
		this.end_hour = end_hour;
	}


	public int getEnd_min() {
		return end_min;
	}


	public void setEnd_min(int end_min) {
		this.end_min = end_min;
	}


	public String getLocation() {
		return location;
	}


	public void setLocation(String location) {
		this.location = location;
	}

	/**
	 * 上课地点
	 */
	@Column
	private String location;
	
	private String teacher_name;

	public String getTeacher_name() {
		return teacher_name;
	}


	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}


	public int getTeacher_id() {
		return teacher_id;
	}


	public void setTeacher_id(int teacher_id) {
		this.teacher_id = teacher_id;
	}


	public String getDuring() {
		return during;
	}


	public void setDuring(String during) {
		this.during = during;
	}


	public List<Test> getTests() {
		return tests;
	}


	public void setTests(List<Test> tests) {
		this.tests = tests;
	}


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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	

}
