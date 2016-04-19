package shixi.service;

import java.util.List;
import java.util.Map;

import shixi.bean.Analysis;
import shixi.bean.AnalysisSet;

public interface ScoreAnalysisService {

	AnalysisSet analyse(AnalysisSet analysisSet, Integer class_id,
			Integer test_id, Integer classTopx, Integer schoolTopx);

	Map<String, Object> getResult1(Integer at_grade, Integer test_id,
			String type, Integer class_id, Integer[] Topx,
			List<Map<String, Object>> Lines);

	Map<String, Object> getResult2(Integer at_grade, Integer test_id,
			String type, Integer[] Topx, List<Map<String, Object>> Lines);
	
	
	/**成绩分析函数
	 * @param type 分析类型 class或者grade
	 * @param at_grade 所在年级
	 * @param test_id 考试ID
	 * @param Topx 前x名数组
	 * @param Lines 各科分数线
	 * @return
	 */
	Map<String,Object> getResult(String type,Integer at_grade, Integer test_id,
			 Integer[] Topx, Map<String, Object>[] Lines);
	
	Map<String,Object> getResult(Analysis analysis);
	public Map<Integer,Object> getAllClassesAnalysis(Integer test_id,
			Integer at_grade, Integer[] topx, Map<String, Object>[] lines);
	public Map<String,Object> getGradeAnalysis(Integer test_id,
			Integer at_grade, Integer[] topx, Map<String, Object>[] lines);
}
