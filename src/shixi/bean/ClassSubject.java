package shixi.bean;

import java.util.List;

import org.nutz.dao.entity.annotation.Column;
import org.nutz.dao.entity.annotation.One;
import org.nutz.dao.entity.annotation.PK;
import org.nutz.dao.entity.annotation.Table;
//班级科目表
@Table("t_class_subject")
@PK({"t_class_id", "t_subject_id"})

public class ClassSubject {
	@Column
	private int t_class_id;
	
	@Column
	private int t_subject_id;
	
	@Column
    private int del;


	public int getDel() {
		return del;
	}


	public void setDel(int del) {
		this.del = del;
	}


	public int getT_class_id() {
		return t_class_id;
	}
     
	
	public void setT_class_id(int t_class_id) {
		this.t_class_id = t_class_id;
	}

	public int getT_subject_id() {
		return t_subject_id;
	}

	public void setT_subject_id(int t_subject_id) {
		this.t_subject_id = t_subject_id;
	}
	
}
