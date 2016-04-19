package shixi.service.serviceImpl;

import java.util.List;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import shixi.bean.TSubject;
import shixi.bean.TestSubject;
import shixi.dao.TestSubjectDao;
import shixi.service.TestSubjectService;

@IocBean
public class TestSubjectServiceImpl implements TestSubjectService {

	@Inject
	private TestSubjectDao testSubjectDao;

	@Override
	public List<TSubject> querytime(int testid) {
		return testSubjectDao.querytime(testid);
	}

	@Override
	public void add(TestSubject ts) {
		testSubjectDao.add(ts);

	}

	@Override
	public void adds(List<TestSubject> list) {
		testSubjectDao.adds(list);

	}

	@Override
	public void delete(int testid) {
		testSubjectDao.delete(testid);

	}

	@Override
	public List<TestSubject> query(int test_id) {
		return testSubjectDao.query(test_id);
	}

}
