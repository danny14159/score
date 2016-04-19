package shixi.service.serviceImpl;

import java.util.Date;
import java.util.List;

import org.nutz.dao.QueryResult;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import shixi.bean.Subject;
import shixi.bean.Test;
import shixi.bean.TestSubject;
import shixi.dao.TestDao;
import shixi.service.TestService;

@IocBean
public class TestServiceImpl implements TestService {
	@Inject
	private TestDao testDao;

	@Override
	public void add(Test test) {
		testDao.add(test);

	}

	@Override
	public void delete(int id) {
		testDao.delete(id);

	}

	@Override
	public void update(Test test) {
		testDao.update(test);

	}

	@Override
	public List<Test> query(int id) {
		return testDao.query(id);
	}

	@Override
	public List<Test> queryByDN(Date date, String name) {
		return testDao.queryByDN(date, name);
	}

	@Override
	public List<Subject> querysubject(int testid) {
		return testDao.querysubject(testid);
	}

	@Override
	public QueryResult query(Date date1, Date date2, String name,
			int pageNumber, int pageSize) {
		if (date1 == null && date2 == null && name == null) {
			return testDao.query(pageNumber, pageSize);
		} else if (date1 == null && date2 == null && name != null) {
			return testDao.queryByName(name, pageNumber, pageSize);
		} else if (date1 != null && date2 == null && name == null) {
			return testDao.queryByDate(date1, pageNumber, pageSize);

		} else if (date1 != null && date2 != null && name == null) {
			return testDao
					.queryByPeriodDate(date1, date2, pageNumber, pageSize);
		} else {
			return null;
		}
	}

	@Override
	public void addwith(Test test, TestSubject[] lt) {
		testDao.addwith(test, lt);
		
	}

}
