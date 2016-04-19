package shixi.module;

import java.util.Date;
import java.util.List;

import org.nutz.dao.QueryResult;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.GET;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import shixi.bean.Subject;
import shixi.bean.Test;
import shixi.bean.TestSubject;
import shixi.service.TestService;
import shixi.service.TestSubjectService;

@At("/test")
@IocBean
public class TestModule {
	@Inject
	private TestService testServiceImpl;

	@Inject
	private TestSubjectService testSubjectServiceImpl;

	@At("/")
	@Ok("jsp:Exam")
	public void toExam() {

	}

	@At("/new")
	@Ok("jsp:newExam")
	public void newExam() {

	}

	@At("/listPage")
	@Ok("jsp:ScoreType")
	@GET
	public void listPage() {

	}

	@At("/add")
	public void add(@Param("..") Test test) {
		testServiceImpl.add(test);
	}

	@At("/delete")
	public void delete(@Param("id")int id) {
		testServiceImpl.delete(id);
	}

	@At("/update")
	public void update(@Param("test") Test test,
			@Param("subjects") TestSubject[] testSubjects) {
		testServiceImpl.update(test);

		if (testSubjectServiceImpl.query(test.getId()).equals(null)) {
			for (TestSubject testSubject : testSubjects) {
				testSubject.setTest_id(test.getId());
				testSubjectServiceImpl.add(testSubject);
			}
		}
		else {
			testSubjectServiceImpl.delete(test.getId());
			for (TestSubject testSubject : testSubjects) {
				testSubject.setTest_id(test.getId());
				testSubjectServiceImpl.add(testSubject);
			}
		}

	}

	@At("/queryById")
	@Ok("JSON")
	public List<Test> queryById(int id) {
		return testServiceImpl.query(id);
	}

	@At("/query")
	@Ok("json")
	public QueryResult query(Date date1, Date date2, String name,
			int pageNumber, int pageSize) {
		return testServiceImpl.query(date1, date2, name, pageNumber, pageSize);
	}

	@At("/queryByDN")
	public List<Test> queryByDN(Date date, String name) {
		return testServiceImpl.queryByDN(date, name);
	}

	@At("/querysubject")
	@Ok("json")
	public List<Subject> querysubject(int testid) {
		return testServiceImpl.querysubject(testid);
	}

	@At("/addwith")
	public void addwith(@Param("test") Test test,
			@Param("subjects") TestSubject[] testSubjects) {
		testServiceImpl.addwith(test, testSubjects);
		return;
	}

}
