package shixi.bean;

import java.util.List;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.Default;
import org.nutz.dao.entity.annotation.Id;
import org.nutz.dao.entity.annotation.ManyMany;
import org.nutz.dao.entity.annotation.Table;

//班级表
@Table("t_class")
public class Class {
	
	    @Id
	    private Integer id;
	     
	    @Column
	    private String name;
	    
	    @Column("at_grade")
	    private Integer at_grade;
	    
	    @Column
	    @Default("0")
        private Integer del;
	    
	    @ManyMany(target=Subject.class,relation="t_class_subject",from="t_class_id",to="t_subject_id")
	    private List<Subject> subject;
	    
	    private Integer nstu;//学生人数
	    
	    @Column
	    private String teacher;//班主任

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

		public Integer getAt_grade() {
			return at_grade;
		}

		public void setAt_grade(Integer at_grade) {
			this.at_grade = at_grade;
		}

		public Integer getDel() {
			return del;
		}

		public void setDel(Integer del) {
			this.del = del;
		}

		public List<Subject> getSubject() {
			return subject;
		}

		public void setSubject(List<Subject> subject) {
			this.subject = subject;
		}

		public Integer getNstu() {
			return nstu;
		}

		public void setNstu(Integer nstu) {
			this.nstu = nstu;
		}

		public String getTeacher() {
			return teacher;
		}

		public void setTeacher(String teacher) {
			this.teacher = teacher;
		}
	    
		
}
