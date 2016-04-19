package shixi.bean;

import java.util.Date;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.PK;
import org.nutz.dao.entity.annotation.Table;

@Table("t_test_subject")
@PK({"subject_id","test_id"})
public class TestSubject {

	@Column
	private int subject_id;
	
	@Column
	private int test_id;
	
	@Column
	private Date start_time;
	
	@Column
	private Date end_time;
	
	@Column
    private int del;


	public int getDel() {
		return del;
	}


	public void setDel(int del) {
		this.del = del;
	}

	public int getSubject_id() {
		return subject_id;
	}

	public void setSubject_id(int subject_id) {
		this.subject_id = subject_id;
	}

	public int getTest_id() {
		return test_id;
	}

	public void setTest_id(int test_id) {
		this.test_id = test_id;
	}

	public Date getStart_time() {
		return start_time;
	}

	public void setStart_time(Date start_time) {
		this.start_time = start_time;
	}

	public Date getEnd_time() {
		return end_time;
	}

	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}
	
}
