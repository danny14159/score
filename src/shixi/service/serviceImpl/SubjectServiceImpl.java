package shixi.service.serviceImpl;

import java.util.List;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import shixi.bean.Subject;
import shixi.dao.SubjectDao;
import shixi.service.SubjectService;

@IocBean
public class SubjectServiceImpl implements SubjectService {
	@Inject
	private SubjectDao subjectDao;

	@Override
	public void add(Subject sub) {
		subjectDao.add(sub);
	}

	@Override
	public void delete(int id) {
		subjectDao.delete(id);
	}

	@Override
	public void update(Subject sub) {
		subjectDao.update(sub);
	}

	@Override
	public List<Subject> query() {
		return subjectDao.query();
	}

	@Override
	public Subject fetch(int id) {
		return subjectDao.fetch(id);
	}

}
