package shixi.module;

import java.util.List;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;

import shixi.bean.TSubject;
import shixi.bean.TestSubject;
import shixi.service.TestSubjectService;

@At("/testSubject")
@IocBean
public class TestSubjectModule {
	@Inject
	private TestSubjectService testSubjectServcieImpl;

	@At("/querytime")
	@Ok("json")
	public List<TSubject> querytime(int testid) {
		return testSubjectServcieImpl.querytime(testid);
	}

	@At("/add")
	public void add(TestSubject ts) {
		testSubjectServcieImpl.add(ts);
	}

	@At("/adds")
	public void adds(List<TestSubject> list) {
		testSubjectServcieImpl.adds(list);
	}

	@At("/delete")
	public void delete(int testid) {
		testSubjectServcieImpl.delete(testid);
	}
}
