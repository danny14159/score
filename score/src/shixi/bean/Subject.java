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
