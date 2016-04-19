package shixi.service.serviceImpl;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;

import shixi.bean.Analysis;
import shixi.bean.AnalysisSet;
import shixi.bean.Class;
import shixi.bean.Score;
import shixi.bean.ScoreStat;
import shixi.bean.Student;
import shixi.dao.ClassDao;
import shixi.dao.ScoreDao;
import shixi.dao.ScoreStatDao;
import shixi.dao.StudentDao;
import shixi.dao.SubjectDao;
import shixi.dao.TestDao;
import shixi.service.ScoreAnalysisService;

@IocBean
public class ScoreAnalysisServiceImpl implements ScoreAnalysisService {
	@Inject
	private ScoreDao scoreDao;
	@Inject
	private StudentDao studentDao;
	@Inject
	private TestDao testDao;
	@Inject
	private ScoreStatDao scoreStatDao;
	@Inject
	private ClassDao classDao;
	@Inject
	private SubjectDao subjectDao;

	@Override
	public AnalysisSet analyse(AnalysisSet analysisSet, Integer class_id,
			Integer test_id, Integer classTopx, Integer schoolTopx) {

		int stuTotalNumber = studentDao.queryByClass(class_id).size();
		AnalysisSet analysisSet2 = analysisSet;

		// 将某班学生成绩优秀率、及格率、差胜率插入rates中
		List<Map<String, Object>> rates = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> lines = analysisSet.getLines();

		for (Map<String, Object> map : lines) {
			for (Entry<String, Object> entry : map.entrySet()) {
				List<String> f = (List<String>) entry.getValue();
				float goodRate = scoreDao.queryStuNumber(
						Integer.parseInt(entry.getKey()), test_id,
						Float.parseFloat(f.get(0)), stuTotalNumber, class_id);
				float commonRate = scoreDao.queryStuNumber(
						Integer.parseInt(entry.getKey()), test_id,
						Float.parseFloat(f.get(1)), stuTotalNumber, class_id);
				float badRate = scoreDao.queryStuNumber(
						Integer.parseInt(entry.getKey()), test_id,
						Float.parseFloat(f.get(2)), stuTotalNumber, class_id);
				float[] f2 = new float[3];
				f2[0] = goodRate;
				f2[1] = commonRate;
				f2[2] = badRate;
				Map<String, Object> map2 = new HashMap<>();
				map2.put(entry.getKey(), f2);
				rates.add(map2);
			}
		}
		analysisSet2.setRates(rates);

		// 获取班级前topX名次的学生成绩信息
		analysisSet2.setClassTopX(this.classTopx(class_id, test_id, classTopx));
		// 获取某班在学校排名前十的学生成绩信息
		analysisSet2.setSchoolTopX(this.schoolTopx(class_id, test_id,
				schoolTopx));
		return analysisSet2;
	}

	/**
	 * 获取班级前topX名次的学生成绩信息 Integer
	 * 
	 * @param class_id
	 * @param test_id
	 * @param top
	 * @return 获取班级前topX名次的学生成绩信息
	 */
	public List<Map<String, Object>> classTopx(Integer class_id,
			Integer test_id, Integer classTopx) {
		List<ScoreStat> scoreStats = scoreStatDao.queryTop(class_id, test_id,
				classTopx);
		List<Map<String, Object>> classTopX = new ArrayList<>();

		for (ScoreStat scoreStat : scoreStats) {
			Map<String, Object> classTopXMap = new HashMap<>();
			classTopXMap.put("stu_id", scoreStat.getStu_id());
			classTopXMap.put("stu_name",
					studentDao.queryById(scoreStat.getStu_id()).get(0)
							.getName());
			classTopXMap.put("total_score", scoreStat.getTatal_score());
			classTopXMap.put("class_order", scoreStat.getClass_order());
			classTopX.add(classTopXMap);
		}
		return classTopX;
	}

	public List<Map<String, Object>> schoolTopx(Integer class_id,
			Integer test_id, Integer schoolTopx) {
		List<ScoreStat> scoreStats = scoreStatDao.queryTop(class_id, test_id,
				schoolTopx);
		List<Map<String, Object>> schoolTopX = new ArrayList<>();

		for (ScoreStat scoreStat : scoreStats) {
			Map<String, Object> schoolTopXMap = new HashMap<>();
			schoolTopXMap.put("stu_id", scoreStat.getStu_id());
			schoolTopXMap.put("stu_name",
					studentDao.queryById(scoreStat.getStu_id()).get(0)
							.getName());
			schoolTopXMap.put("total_score", scoreStat.getTatal_score());
			schoolTopXMap.put("school_order", scoreStat.getSchool_order());
			schoolTopX.add(schoolTopXMap);
		}
		return schoolTopX;
	}

	/*
	 * 分析班级成绩信息
	 */
	@Override
	public Map<String, Object> getResult1(Integer at_grade, Integer test_id,
			String type, Integer class_id, Integer[] Topx,
			List<Map<String, Object>> Lines) {
		System.out.println(Json.toJson(Topx));
		System.out.println(Json.toJson(Lines));
		int stuTotalNumber = studentDao.queryByClass(class_id).size();
		Map<String, Object> map2 = new HashMap<>();
		for (int i = 0; i < Lines.size(); i++) {
			Map<String, Object> map = Lines.get(i);
			for (Entry<String, Object> entry : map.entrySet()) {
				List<String> f = (List<String>) entry.getValue();
				float goodRate = scoreDao.queryStuNumber(
						Integer.parseInt(entry.getKey()), test_id,
						Float.parseFloat(f.get(0)), stuTotalNumber, class_id);
				float commonRate = scoreDao.queryStuNumber(
						Integer.parseInt(entry.getKey()), test_id,
						Float.parseFloat(f.get(1)), stuTotalNumber, class_id);
				float badRate = scoreDao.queryStuNumber(
						Integer.parseInt(entry.getKey()), test_id,
						Float.parseFloat(f.get(2)), stuTotalNumber, class_id);
				// float[] f2 = new float[3];
				// f2[0] = goodRate;
				// f2[1] = commonRate;
				// f2[2] = badRate;
				Object[] f3 = new Object[8];
				f3[0] = subjectDao.fetch(Integer.parseInt(entry.getKey()))
						.getName();
				f3[1] = goodRate;
				f3[2] = goodRate * stuTotalNumber;
				f3[3] = commonRate;
				f3[4] = commonRate * stuTotalNumber;
				f3[5] = badRate;
				f3[6] = badRate * stuTotalNumber;
				f3[7] = 0;
				Object[][] f4 = new Object[Lines.size()][];
				f4[i] = f3;

				map2.put("TableRateRecord", f4);
				Integer[] f5 = new Integer[Topx.length];
				for (int j = 0; j < Topx.length; j++) {
					f5[j] = this.schoolTopx(class_id, test_id, Topx[j]).size();
				}
				Object[][] f6 = new Object[Topx.length][];

				f6[i] = f5;
				map2.put("TableTopRecord", f5);
			}
		}
		return map2;
	}

	/*
	 * 分析年级成绩信息
	 */
	@Override
	public Map<String, Object> getResult2(Integer at_grade, Integer test_id,
			String type, Integer[] Topx, List<Map<String, Object>> Lines) {
		List<Class> list = classDao.query(at_grade);
		Map<String, Object> map = new HashMap<>();
		for (Class class1 : list) {
			// int stuTotalNumber =
			// studentDao.queryByClass(class1.getId()).size();

			Map<String, Object> map2 = this.getResult1(at_grade, test_id, type,
					class1.getId(), Topx, Lines);
			Object[][] f4 = (Object[][]) map2.get("TableRateRecord");
			Map<String, Object> map3 = new HashMap<>();

			for (int i = 0; i < f4.length; i++) {
				Object[] f3 = new Object[f4.length];
				f3 = f4[i];
				f4[i][0] = classDao.fetch(class1.getId()).getName();
				// f3[i]=classDao.fetch(class1.getId()).getName();
				map3.put((String) f3[0], f4);
			}
			map.put("Rate", map3);
			Integer[][] f5 = (Integer[][]) map2.get("TableTopRecord");
			Object[][] f6 = new Object[f5.length + 1][];
			for (int i = 0; i < f6.length; i++) {
				f6[i][0] = classDao.fetch(class1.getId()).getName();
				for (int j = 1; j < f6[i].length; j++) {
					f6[i][j] = f5[i][j-1];
				}
			}
			map.put("Top", f6);
		}

		return map;
	}

	@Override
	public Map<String, Object> getResult(String type, Integer at_grade,
			Integer test_id, Integer[] Topx, Map<String, Object>[] Lines) {
		return null;
	}

	
	public Map<String, Object> getResult(String type, Integer at_grade,
			Integer test_id, Integer class_id,Integer[] topx, Map<String, Object>[] lines) {
		if(type.equals("grade")){
			return getResultOfGrade(test_id,at_grade,topx,lines);
		}else if(type.equals("class")){
			return getResultOfClass(test_id,class_id,topx,lines);
		}
		
		return null;
	}
	
	private Map<String, Object> getResultOfGrade(Integer test_id,
			Integer at_grade, Integer[] topx, Map<String, Object>[] lines) {
		boolean first = true;
		//各学科名字
		String[] sub_names = null;
		List<Class> classes = classDao.query(at_grade);
		String[] class_names = new String[classes.size()];
		Map<String,Integer[]> un_rankOfGrage = new HashMap<>();
		Map<String,Map<String,Object>> un_resultOfGrade = new HashMap<String, Map<String,Object>>();
		//获取各班分析数据
		for(int i = 0;i<classes.size();i++){
			class_names[i] = classes.get(i).getName();
			int class_id = classes.get(i).getId();
			Map<String,Object> resultOfClass = getResultOfClass(test_id, class_id, topx, lines);
			if(first){
				String[][] ss = (String[][])resultOfClass.get("TableRateRecord");
				String[] names_sub = new String[ss.length];
				for(int j = 0;j<names_sub.length;j++)
					names_sub[j] = ss[j][0];
				first = false;
				sub_names = names_sub;
			}
			un_resultOfGrade.put(class_names[i], resultOfClass);
		}
		
		//重析结果
		Map<String,Object> result = new HashMap<String, Object>();
		Map<String,Object> mapR = new HashMap<>(); 
		for(int i = 0;i<sub_names.length;i++){
			String sub_name = sub_names[i];
			String[][] classesOfSub = new String[class_names.length][];
			for(int j = 0;j<class_names.length;j++){
				String[] s = new String[8];
				s[0] = class_names[j];
				Map<String,Object> map = un_resultOfGrade.get(s[0]);
				String[][] ss = (String[][]) map.get("TableRateRecord");
				for(int m = 0;m<ss.length;m++)
					if(ss[m][0].equals(sub_name)){
						for(int k = 1;k<s.length;k++)
							s[k] = ss[m][k];
						break;
					}
				classesOfSub[j] = s;
			}
			mapR.put(sub_name, classesOfSub);
		}
		result.put("Rate", mapR);
		
		//分析重构前X
		String[][] ranks = new String[class_names.length][];
		for(int i = 0;i<class_names.length;i++){
			Map<String,Object> map = un_resultOfGrade.get(class_names[i]);
			Integer[] rankOfClass = (Integer[]) map.get("TableTopRecord");
			String[] rank = new String[rankOfClass.length+1];
			rank[0] = class_names[i];
			for(int j = 1;j<rank.length;j++)
				rank[j] = String.valueOf(rankOfClass[j-1]);
			ranks[i] = rank;
		}
		result.put("Top", ranks);
		return result;
	}

	private Map<String, Object> getResultOfClass(Integer test_id,
			Integer class_id, Integer[] topx, Map<String, Object>[] lines) {
		
		Map<String,Object> result = new HashMap<>();
//		class_id = 8;
		List<Student> students = studentDao.queryByClass(class_id);
//		System.out.println((students == null)+"============");
		int all = students.size();
		//获取所有学生的各科成绩
		List<Map<Integer,Float>> scoresOfStudents = new ArrayList<>();
		//获取名次
		int[] ranking = new int[all];
		for(int i = 0;i<all;i++){
			Integer id = students.get(i).getId();
			List<Score> scores = scoreDao.queryById2(id, test_id);
			ScoreStat ss = scoreStatDao.queryById(id, test_id);
			ranking[i] = ss.getSchool_order();
			Map<Integer,Float> map = new HashMap<>();
			
			for(int j = 0;j<scores.size();j++){
				map.put(scores.get(j).getSubject_id(),scores.get(j).getScore());
			}
			scoresOfStudents.add(map);
		}
		
		String[][] results = new String[lines.length][];
		
		//分析各学生
		for(int i = 0;i<lines.length;i++){
			String[] analysisResult = new String[8];
			Set<String> keys = lines[i].keySet();
			Integer sub_id = null;
			String sub_name = null;
			int good = 0,normal = 0,bad =0,sum=0;
			if(keys.size() == 1){
				String[] sub_id_array = new String[1];
				 keys.toArray(sub_id_array);
				 try{
					 sub_id = Integer.parseInt(sub_id_array[0]);
				 }catch(Exception e){
					 System.err.print(e);
				 }
				 ArrayList<String> linesOfOneSubject = (ArrayList<String>) lines[i].get(sub_id_array[0]);
				
				for(int j = 0;j<all;j++){
					float score = scoresOfStudents.get(j).get(sub_id);
					sum+=score;
					if(score >= Integer.parseInt(linesOfOneSubject.get(0)))
						good++;
					else if(score >= Integer.parseInt(linesOfOneSubject.get(1)))
						normal++;
					else if(score < Integer.parseInt(linesOfOneSubject.get(2)))
						bad++;
				}
				sub_name = subjectDao.fetch(sub_id).getName();
			}
			DecimalFormat df = new DecimalFormat("#.#%");
			DecimalFormat df2 = new DecimalFormat("#.#");
			analysisResult[0] = sub_name;
			analysisResult[1] = df.format((double)good/all);
			analysisResult[2] = String.valueOf(good);
			analysisResult[3] = df.format((double)normal/all);
			analysisResult[4] = String.valueOf(normal);
			analysisResult[5] = df.format((double)bad/all);
			analysisResult[6] = String.valueOf(bad);
			analysisResult[7] = df2.format((double)sum/all);
			results[i] = analysisResult;
			
		}
		
		result.put("TableRateRecord", results);
		
		Integer[] countsOfLines = new Integer[topx.length];
		for(int i = 0;i<topx.length;i++)
			countsOfLines[i] = 0;
		for(int i = 0;i<all;i++){
			int rank = ranking[i];
			for(int j = 0;j<topx.length;j++)
				if(rank <= topx[j])
					countsOfLines[j]++;
		}

		result.put("TableTopRecord", countsOfLines);
		return result;
	}

	@Override
	public Map<String, Object> getResult(Analysis analysis) {
		return getResult(analysis.getType(), analysis.getAt_grade(), analysis.getTest_id()
				,analysis.getClass_id(), analysis.getTopx(),analysis.getLines());
	}
	
	@Override
	public Map<Integer,Object> getAllClassesAnalysis(Integer test_id,
			Integer at_grade, Integer[] topx, Map<String, Object>[] lines){
		
		List<Class> classes = classDao.query(at_grade);
		Map<Integer, Object> result = new HashMap<>();
		for(int i = 0;i<classes.size();i++){
			result.put(classes.get(i).getId(), getResultOfClass(test_id, classes.get(i).getId()
					, topx, lines));
		}
		
		return result;
	}
	
	@Override
	public Map<String,Object> getGradeAnalysis(Integer test_id,
			Integer at_grade, Integer[] topx, Map<String, Object>[] lines){
		return getResultOfGrade(test_id, at_grade, topx, lines);
		
	}
}
