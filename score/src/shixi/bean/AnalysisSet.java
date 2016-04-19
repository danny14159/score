package shixi.bean;

import java.util.List;
import java.util.Map;

/**
 * @author dl
 *分析结果集
 */
public class AnalysisSet {
	/**
	 * 各科分数线[{'subject_id':[90,60,40]},...]
	 */
	private List<Map<String,Object>> lines;

	/**
	 * 全校前X [{'stu_id':1,'stu_name':'张三','total_score':'300','school_order':'10'},...]
	 */
	private List<Map<String,Object>> schoolTopX;

	
	/**
	 * 班级前X[{'stu_id':1,'stu_name':'张三','total_score':'300','class_order':'10'},...]
	 */
	private List<Map<String,Object>> classTopX;

	
	/**
	 * 各科优秀|及格|差生率 [{'subject_id':[0.5,0.4,0.1]},...]
	 */
	private List<Map<String,Object>> rates;


	public List<Map<String, Object>> getLines() {
		return lines;
	}


	public void setLines(List<Map<String, Object>> lines) {
		this.lines = lines;
	}


	public List<Map<String, Object>> getSchoolTopX() {
		return schoolTopX;
	}


	public void setSchoolTopX(List<Map<String, Object>> schoolTopX) {
		this.schoolTopX = schoolTopX;
	}


	public List<Map<String, Object>> getClassTopX() {
		return classTopX;
	}


	public void setClassTopX(List<Map<String, Object>> classTopX) {
		this.classTopX = classTopX;
	}


	public List<Map<String, Object>> getRates() {
		return rates;
	}


	public void setRates(List<Map<String, Object>> rates) {
		this.rates = rates;
	}

}
