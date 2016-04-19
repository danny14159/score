package shixi.module;

import java.util.List;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import shixi.bean.Score;
import shixi.dao.ScoreDao;
import shixi.service.ScoreService;
import shixi.service.ScoreStatService;

@At("/score")
@IocBean
public class ScoreModule {
	@Inject
	private ScoreService scoreServiceImpl;

	@Inject
	private ScoreStatService scoreStatServiceImpl;

	@Inject
	private ScoreDao scoreDao;

	@At("/")
	@Ok("jsp:score/ScoreQuery")
	public void toScore() {

	}
	
	@At("/analyseScore")
	@Ok("jsp:score/ScoreAnalyse")
	public void analyse() {

	}
	

	@At("/editScore")
	@Ok("jsp:score/ScoreEdit")
	public void toScore2() {

	}

	@At("/inputBefore")
	public void inputBefore(@Param("class_id")Integer class_id, @Param("test_id")Integer test_id) {
		scoreServiceImpl.inputBefore(class_id, test_id);
	}
	
	@At("/inputAfter")
	public void inputAfter(@Param("..") Score score) {
		scoreServiceImpl.inputAfter(score);
	}

	@At("/delete")
	public void delete(@Param("id")int id) {
		scoreServiceImpl.delete(id);
	}

	@At("/update")
	public void update(@Param("..")Score score) {
		scoreServiceImpl.update(score);
	}

	@At("/query1")
	@Ok("json")
	public float query(@Param("studentid")int studentid, @Param("testid")int testid, @Param("subjectid")Integer subjectid) {
		return scoreServiceImpl.query(studentid, testid, subjectid);

	}

	@At("/query2")
	public List<Score> query(@Param("studentid")int studentid, @Param("testid")int testid) {
		return scoreServiceImpl.query(studentid, testid);
	}

	@At("/batch")
	public void batch(@Param("scores") List<Score> list) {
		scoreServiceImpl.batch(list);
	}

}
