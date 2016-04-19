package shixi.module;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import shixi.bean.ScoreStat;
import shixi.service.ScoreStatService;

@IocBean
@At("/scorestat")
public class ScoreStatModule {
	@Inject
	private ScoreStatService scoreStatServiceImpl;

	@At("/add")
	public void add(@Param("..") ScoreStat scorestat) {
		scoreStatServiceImpl.add(scorestat);
	}

	@At("/batch")
	public void batch(List<ScoreStat> list) {
		scoreStatServiceImpl.batch(list);
	}

	@At("/delete")
	public void delete(Integer student_id, Integer test_id) {
		scoreStatServiceImpl.delete(student_id, test_id);
	}

	@At("/update")
	public void update(ScoreStat scorestat) {
		scoreStatServiceImpl.update(scorestat);
	}

	@At("/queryById")
	@Ok("json")
	public ScoreStat queryById(Integer student_id, Integer test_id) {
		return scoreStatServiceImpl.queryById(student_id, test_id);

	}

	/**
	 * 将学生的成绩信息默认按学生学号进行排序
	 * 
	 * @param class_id
	 * @param test_id
	 * @param at_grade
	 * @return 按学生学号排好序的学生成绩信息
	 */
	@At("/sort")
	@Ok("json")
	public String sort(@Param("class_id") Integer[] class_id,
			@Param("test_id") Integer test_id,
			@Param("at_grade") Integer at_grade) {
/*		for(Integer i:class_id){
			scoreStatServiceImpl.sortByClass(i, test_id);
		}*/
		scoreStatServiceImpl.sortByGrade(class_id,at_grade, test_id);
		return "排序已完成";
		
	}

	/**
	 * 将学生的成绩信息按班级排名 查询
	 * 
	 * @param class_id
	 * @param test_id
	 * @param at_grade
	 * @return 按班级排名排好序的学生成绩信息
	 */
	@At("/queryByClassOrder")
	@Ok("json")
	public List<Map<String, Object>> sortByClassOrder(
			@Param("class_id") Integer class_id,
			@Param("test_id") Integer test_id,
			@Param("at_grade") Integer at_grade) {
		return scoreStatServiceImpl.sortByClassOrder(class_id, test_id,
				at_grade);
	}

	/**
	 * 将学生的成绩信息按年级排名进行排序
	 * 
	 * @param class_id
	 * @param test_id
	 * @param at_grade
	 * @return 按年级排名排好序的学生成绩信息
	 */
	@At("/sortBySchoolOrder")
	@Ok("json")
	public List<Map<String, Object>> sortBySchoolOrder(
			@Param("class_id") Integer class_id,
			@Param("test_id") Integer test_id,
			@Param("at_grade") Integer at_grade) {
		return scoreStatServiceImpl.sortBySchoolOrder(class_id, test_id,
				at_grade);
	}

	@At("/query")
	@Ok("json")
	public List<Map<String,Object>> query(@Param("class_id") Integer class_id,
			@Param("test_id") Integer test_id,
			@Param("at_grade") Integer at_grade) {
		return scoreStatServiceImpl.getScoreStat(class_id, test_id, at_grade);
		//return scoreStatServiceImpl.query(class_id, at_grade, test_id);
	}
}
