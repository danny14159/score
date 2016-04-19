package shixi.service.serviceImpl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import shixi.bean.ScoreStat;
import shixi.bean.Student;
import shixi.bean.Subject;
import shixi.dao.ClassDao;
import shixi.dao.ScoreDao;
import shixi.dao.ScoreStatDao;
import shixi.dao.StudentDao;
import shixi.dao.TestDao;
import shixi.service.ScoreStatService;

@IocBean
public class ScoreStatServiceImpl implements ScoreStatService {
	@Inject
	private ScoreStatDao scoreStatDao;

	@Inject
	private ScoreDao scoreDao;
	@Inject
	private StudentDao studentDao;

	@Inject
	private ClassDao classDao;

	@Inject
	private TestDao testDao;

	@Override
	public void add(ScoreStat scorestat) {
		scoreStatDao.add(scorestat);
	}

	@Override
	public void batch(List<ScoreStat> list) {
		scoreStatDao.batch(list);
	}

	@Override
	public void delete(Integer student_id, Integer test_id) {
		scoreStatDao.delete(student_id, test_id);

	}

	@Override
	public void update(ScoreStat scorestat) {
		scoreStatDao.update(scorestat);

	}

	@Override
	public ScoreStat queryById(Integer student_id, Integer test_id) {
		return scoreStatDao.queryById(student_id, test_id);
	}

	@Override
	public List<ScoreStat> query(Integer class_id, Integer at_grade,
			Integer test_id) {
		
		if (class_id != null && at_grade == null) {
			return scoreStatDao.queryByClass(class_id, test_id);
		} 
		else if (at_grade != null && class_id == null) {
			return scoreStatDao.queryByGrade(at_grade, test_id);
		} 
		else if (class_id == null && at_grade == null && test_id == null) {
			return scoreStatDao.query();
		} 
		else {
			return null;
		}
	}

	public List<Map<String, Object>> getScoreStat(Integer class_id, Integer test_id,
			Integer at_grade) {
		List<Map<String, Object>> results = null;
/*		if (this.judgeIfNull(class_id, test_id, at_grade)==false) {
			list3 = new ArrayList<>();
		} else {*/
			//this.sortByClass(class_id, test_id);

			//this.sortByGrade(at_grade, test_id);
			List<Student> stus = studentDao.queryByClass(class_id);

			results = new ArrayList<Map<String, Object>>();

			List<Subject> subs = testDao.querysubject(test_id);
			for (Student student : stus) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("student", student);
				for (int i = 0; i < subs.size(); i++) {
					map.put("subjectScore",
							scoreDao.queryById2(student.getId(), test_id));

				}
				//ScoreStat scoreStat = new ScoreStat();
				
				ScoreStat scoreStat = scoreStatDao.queryById(student.getId(), test_id);
				
				if(scoreStat != null){
					scoreStat.setTatal_score(scoreDao.querySum(student.getId(),
						test_id));
					scoreStat.setTest_id(test_id);
					scoreStat.setStu_id(student.getId());
					scoreStat.setClass_order(scoreStat.getClass_order());
					scoreStat.setSchool_order(scoreStat.getSchool_order());
				}
				else scoreStat = new ScoreStat();
				map.put("scoreStat", scoreStat);
				results.add(map);
			}
		//}
		return results.size() == 0 ? new ArrayList<Map<String, Object>>(): results ;

	}

	/** 判断该班的该场考试是否有成绩（即在stat表中有记录）？
	 * @param class_id 
	 * @param test_id
	 * @param at_grade
	 * @return
	 */
	public boolean judgeIfNull(Integer class_id, Integer test_id,
			Integer at_grade) {
		//scoreStatDao.exists(class_id,test_id);
		if (scoreStatDao.queryByClass(class_id, test_id).size() == 0
				&& scoreStatDao.queryByGrade(at_grade, test_id).size() == 0) {
			return false;
		} else {
			return true;
		}
	}

	public List<Map<String, Object>> sortByClassOrder(Integer class_id,
			Integer test_id, Integer at_grade) {
		List<Map<String, Object>> list = null;
		if (this.judgeIfNull(class_id, test_id, at_grade)==false) {
			list = new ArrayList<>();
		} else {
			list = this.getScoreStat(class_id, test_id, at_grade);
			Collections.sort(list, new Comparator<Map<String, Object>>() {

				@Override
				public int compare(Map<String, Object> arg0,
						Map<String, Object> arg1) {
					ScoreStat scoreStat = (ScoreStat) arg0.get("scoreStat");
					ScoreStat scoreStat2 = (ScoreStat) arg1.get("scoreStat");
					
					if(scoreStat!=null && scoreStat2!=null)
						return scoreStat.getClass_order().compareTo(
							scoreStat2.getClass_order());
					else return 0;
				}
			});
		}
		return list;
	}

	public List<Map<String, Object>> sortBySchoolOrder(Integer class_id,
			Integer test_id, Integer at_grade) {
		List<Map<String, Object>> list = null;
		if (this.judgeIfNull(class_id, test_id, at_grade)==false) {
			list = new ArrayList<>();

		} else {
			list = this.getScoreStat(class_id, test_id, at_grade);
			Collections.sort(list, new Comparator<Map<String, Object>>() {

				@Override
				public int compare(Map<String, Object> arg0,
						Map<String, Object> arg1) {
					ScoreStat scoreStat = (ScoreStat) arg0.get("scoreStat");

					ScoreStat scoreStat2 = (ScoreStat) arg1.get("scoreStat");
					if(scoreStat!=null && scoreStat2!=null)
						return scoreStat.getClass_order().compareTo(
							scoreStat2.getClass_order());
					else return 0;
				}
			});
		}
		return list;
	}

	@Override
	public void sortByClass(Integer class_id, Integer test_id) {
		List<Student> stus = studentDao.queryByClass(class_id);

		List<ScoreStat> stats = new ArrayList<ScoreStat>();
		if (stus != null) {
			for (Student student : stus) {
				ScoreStat scoreStat = new ScoreStat();
				scoreStat.setTest_id(test_id);
				scoreStat.setStu_id(student.getId());
				scoreStat.setTatal_score((scoreDao.querySum(student.getId(),
						test_id)));
				stats.add(scoreStat);
			}
		}
		sort(stats);
		int repeadcount = 1;
		for (int i = 0, j = stats.size(); i < j; i = i + repeadcount) {
			repeadcount = 1;
			stats.get(i).setClass_order(i + 1);
			for (int h = i + 1; h < j; h++) {
				// same score,and testid same
				if (stats.get(i).getTatal_score() == stats.get(h)
						.getTatal_score()) {
					stats.get(h).setClass_order(i + 1);
					repeadcount++;
				}
			}
		}
		scoreStatDao.insertpart(stats);
	}
	@Override
	public void sortByGrade(Integer[] class_id, Integer at_grade,
			Integer test_id) {
		if(class_id == null )
			class_id = (Integer[])classDao.query(at_grade).toArray();
		
		List<ScoreStat> stats_All = new LinkedList<ScoreStat>();
		
		for(int k = 0;k<class_id.length;k++){
			stats_All.addAll(sortClass(class_id[k], test_id));
		}
		
		sort(stats_All);
		int repeadcount = 1;
		for (int i = 0, j = stats_All.size(); i < j; i = i + repeadcount) {
			repeadcount = 1;
			stats_All.get(i).setSchool_order(i + 1);
			for (int h = i + 1; h < j; h++) {
				// same score,and testid same
				if (stats_All.get(i).getTatal_score() == stats_All.get(h)
						.getTatal_score()) {
					stats_All.get(h).setSchool_order(i + 1);
					repeadcount++;
				}
			}
		}

		scoreStatDao.insertpart(stats_All);
		
		
	}
	
	private List<ScoreStat> sortClass(Integer class_id, Integer test_id) {
		List<Student> stus = studentDao.queryByClass(class_id);

		List<ScoreStat> stats = new ArrayList<ScoreStat>();
		if (stus != null) {
			for (Student student : stus) {
				ScoreStat scoreStat = new ScoreStat();
				scoreStat.setTest_id(test_id);
				scoreStat.setStu_id(student.getId());
				scoreStat.setTatal_score((scoreDao.querySum(student.getId(),
						test_id)));
				stats.add(scoreStat);
			}
		}
		sort(stats);
		int repeadcount = 1;
		for (int i = 0, j = stats.size(); i < j; i = i + repeadcount) {
			repeadcount = 1;
			stats.get(i).setClass_order(i + 1);
			for (int h = i + 1; h < j; h++) {
				// same score,and testid same
				if (stats.get(i).getTatal_score() == stats.get(h)
						.getTatal_score()) {
					stats.get(h).setClass_order(i + 1);
					repeadcount++;
				}
			}
		}
		return stats;
	}


	private static void sort(List<ScoreStat> list2) {
		Collections.sort(list2, new Comparator<ScoreStat>() {

			@Override
			public int compare(ScoreStat arg0, ScoreStat arg1) {
				Float a = (Float) arg0.getTatal_score();
				Float b = (Float) arg1.getTatal_score();
				return b.compareTo(a);
			}
		});
	}

}
