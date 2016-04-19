package shixi.service;

import java.util.List;
import java.util.Map;

import shixi.bean.ScoreStat;

/**
 * 成绩stat接口
 * 
 * @author handsomeye
 * 
 */
public interface ScoreStatService {
	/**
	 * 增加考试记录
	 * 
	 * @param scorestat
	 */
	void add(ScoreStat scorestat);

	/**
	 * 批量增加
	 * 
	 * @param list
	 */
	void batch(List<ScoreStat> list);

	/**
	 * 按学生id，考试id删除信息
	 * 
	 * @param student_id
	 * @param test_id
	 */
	void delete(Integer student_id, Integer test_id);

	/**
	 * 更新记录
	 * 
	 * @param scorestat
	 */
	void update(ScoreStat scorestat);

	/**
	 * 根据学生id，考试id查对应的统计信息
	 * 
	 * @param student_id
	 * @param test_id
	 * @return 对应学生id，考试id的成绩统计信息
	 */
	ScoreStat queryById(Integer student_id, Integer test_id);

	List<Map<String, Object>> getScoreStat(Integer class_id, Integer test_id,Integer at_grade);
	
	/**
	 * 根据班级id，考试id，对学生总成绩进行班级排名
	 * 
	 * @param class_id
	 * @return 学生班级排名信息
	 */
	void sortByClass(Integer class_id, Integer test_id);

	/**
	 * 根据年纪id，考试id，对学生总成绩进行年纪排名
	 * 
	 * @param at_grade
	 * @param test_id
	 * @return 学生年纪排名信息
	 */
	void sortByGrade(Integer[] class_id, Integer at_grade,
			Integer test_id);

	/**
	 * 根据班级id，所在年级id，考试id，查询成绩统计信息。
	 * <p>如果只有class_id有值，则查班级成绩。</p>
	 * <p>如果只有at_grade有值，则查班级成绩。</p>
	 * @param class_id
	 * @param at_grade
	 * @param test_id
	 * @return 成绩统计信息
	 */
	List<ScoreStat> query(Integer class_id, Integer at_grade, Integer test_id);
	
	
	/** 按班级排名排序
	 * @param class_id
	 * @param test_id
	 * @param at_grade
	 * @return
	 */
	List<Map<String, Object>> sortByClassOrder(Integer class_id, Integer test_id,Integer at_grade);
	
	/**按学校排名排序
	 * @param class_id
	 * @param test_id
	 * @param at_grade
	 * @return
	 */
	List<Map<String, Object>> sortBySchoolOrder(Integer class_id, Integer test_id,Integer at_grade);

}