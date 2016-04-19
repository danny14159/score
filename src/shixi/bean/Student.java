package shixi.bean;

import java.util.List;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Default;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.ManyMany;
import org.nutz.dao.entity.annotation.Table;
//学生表
@Table("t_stu")
public class Student {
	@Id(auto=false)
	private Integer id;
	
	@Column
	private String name;
	
	@Column
	private Integer at_class;
	
	@Column
	private Character sex;
	
	@Column
	@Default("0")
    private Integer del;
	
	@Column
	private String location;//籍贯
	
	@Column
	private String address;//家庭住址
	
	@Column
	private Integer enterYear;//入学年份 
	
	@ManyMany(target=Subject.class,relation="t_course_selecting" ,from="student_id",to="subject_id")
	private List<Subject> subjects;

	public List<Subject> getSubjects() {
		return subjects;
	}

	public void setSubjects(List<Subject> subjects) {
		this.subjects = subjects;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getAt_class() {
		return at_class;
	}

	public void setAt_class(Integer at_class) {
		this.at_class = at_class;
	}

	public Character getSex() {
		return sex;
	}

	public void setSex(Character sex) {
		this.sex = sex;
	}

	public Integer getDel() {
		return del;
	}

	public void setDel(Integer del) {
		this.del = del;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Integer getEnterYear() {
		return enterYear;
	}

	public void setEnterYear(Integer enterYear) {
		this.enterYear = enterYear;
	}


}
