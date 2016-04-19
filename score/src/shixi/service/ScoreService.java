package shixi.service;

/***********************************************************************
 * Module:  Score.java
 * Author:  Administrator
 * Purpose: Defines the Interface Score
 ***********************************************************************/

import java.util.List;

import shixi.bean.Score;

/**
 * 成绩接口（成绩的增删改查）
 * 
 * @author handsomeye
 * 
 */
public interface ScoreService {
	/**
	 * 录入成绩之前对数据库的操作
	 * 
	 * @param class_id
	 * @param test_id
	 */
	void inputBefore(Integer class_id, Integer test_id);

	/**
	 * 录入成绩
	 * 
	 * @param score
	 */
	void inputAfter(Score score);

	/**
	 * 根据成绩ID删除成绩
	 * 
	 * @param id
	 */
	void delete(int id);

	/**
	 * 更新成绩信息
	 * 
	 * @param score
	 */
	void update(Score score);

	/**
	 * 查询考试成绩（根据学生id，考试id，如果有学科id则查相应学科，否则查所有学科成绩）
	 * 
	 * @param score
	 * @return 对应的学科考试信息
	 */
	float query(int studentid, int testid, Integer subjectid);

	/**
	 * 批量添加学生成绩
	 * 
	 * @param score
	 */

	void batch(List<Score> list);

	/**
	 * 根据学生id和考试id返回一个考试信息
	 * 
	 * @param studentid
	 * @param testid
	 * @return 对应的考试信息
	 */
	List<Score> query(int studentid, int testid);

	Score query2(int studentid, int testid, Integer subjectid);

}