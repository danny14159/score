package shixi.bean;

import java.util.Arrays;
import java.util.Map;


public class Analysis {
	
	public Integer getAt_grade() {
		return at_grade;
	}

	public void setAt_grade(Integer at_grade) {
		this.at_grade = at_grade;
	}

	public Integer getTest_id() {
		return test_id;
	}

	@Override
	public String toString() {
		return "Analysis [at_grade=" + at_grade + ", test_id=" + test_id
				+ ", type=" + type + ", class_id=" + class_id + ", topx="
				+ Arrays.toString(topx) + ", lines=" + Arrays.toString(lines)
				+ "]";
	}

	public void setTest_id(Integer test_id) {
		this.test_id = test_id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getClass_id() {
		return class_id;
	}

	public void setClass_id(Integer class_id) {
		this.class_id = class_id;
	}

	public Integer[] getTopx() {
		return topx;
	}

	public void setTopx(Integer[] topx) {
		this.topx = topx;
	}

	public Map<String, Object>[] getLines() {
		return lines;
	}

	public void setLines(Map<String, Object>[] lines) {
		this.lines = lines;
	}

	private Integer at_grade;//年级
	
	private Integer test_id;//考试ID
	
	private String type; //分析结果类型
	
	private Integer class_id; //班级ID
	
	private Integer[] topx; //班级前X名
	
	private Map<String,Object>[] lines; //分数线
	
	
}
