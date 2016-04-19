package shixi.service.serviceImpl;

import java.util.List;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import shixi.bean.Score;
import shixi.bean.ScoreStat;
import shixi.bean.Student;
import shixi.bean.Subject;
import shixi.dao.ScoreDao;
import shixi.dao.ScoreStatDao;
import shixi.dao.StudentDao;
import shixi.dao.TestDao;
import shixi.service.ScoreService;

@IocBean
public class ScoreServiceImpl implements ScoreService {
	@Inject
	private ScoreDao scoreDao;

	@Inject
	private StudentDao studentDao;

	@Inject
	private TestDao testDao;

	@Inject
	private ScoreStatDao scoreStatDao;

	@Override
	public void delete(int id) {
		scoreDao.delete(id);

	}

	@Override
	public void update(Score score) {
		scoreDao.update(score);

	}

	@Override
	public float query(int studentid, int testid, Integer subjectid) {
		return scoreDao.queryById1(studentid, testid, subjectid);
	}

	@Override
	public void batch(List<Score> list) {
		scoreDao.batch(list);

	}

	@Override
	public List<Score> query(int studentid, int testid) {
		return scoreDao.queryById2(studentid, testid);
	}

	@Override
	public Score query2(int studentid, int testid, Integer subjectid) {
		return scoreDao.queryById3(studentid, testid, subjectid);
	}

	@Override
	public void inputBefore(Integer class_id, Integer test_id) {


		List<Student> list = studentDao.queryByClass(class_id);
		List<Subject> list2 = testDao.querysubject(test_id);

		for (Student student : list) {
			for (Subject subject : list2) {
				if (scoreDao.queryById3(student.getId(), test_id, subject.getId())==null) {
					Score score = new Score();
					score.setStu_id(student.getId());
					score.setStu_name(student.getName());
					score.setSubject_id(subject.getId());
					score.setTest_id(test_id);
					score.setScore(0);
					scoreDao.input(score);
				}
				if(scoreStatDao.queryById(student.getId(), test_id)==null){
				
					ScoreStat scoreStat=new ScoreStat();
					scoreStat.setStu_id(student.getId());
					scoreStat.setTest_id(test_id);
					scoreStat.setTatal_score(0);
					scoreStatDao.add(scoreStat);
				}
			}
		}
		
	}

	@Override
	public void inputAfter(Score score) {
		this.update(score);
		ScoreStat scoreStat=new ScoreStat();
		scoreStat.setStu_id(score.getStu_id());
		scoreStat.setTest_id(score.getTest_id());
		scoreStat.setTatal_score(scoreDao.querySum(score.getStu_id(), score.getTest_id()));
		scoreStatDao.update(scoreStat);
	}

}
