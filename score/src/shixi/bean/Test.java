package shixi.bean;

import java.util.Date;
import java.util.List;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.ManyMany;
import org.nutz.dao.entity.annotation.Table;

//考试表
@Table("t_test")
public class Test {
	@Id
	private int id;
	
	@Column
	private String test_name;
	
	@Column
	private String remark;
	
	@Column
	private Date date;
	
	@Column
    private int del;

    @ManyMany(target=Subject.class,relation="t_test_subject",from="test_id",to="subject_id")
    private List<Subject> subjects;
	
	public List<Subject> getSubjects() {
		return subjects;
	}


	public void setSubjects(List<Subject> subjects) {
		this.subjects = subjects;
	}


	public int getDel() {
		return del;
	}


	public void setDel(int del) {
		this.del = del;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTest_name() {
		return test_name;
	}

	public void setTest_name(String test_name) {
		this.test_name = test_name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
