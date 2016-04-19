package shixi.service.serviceImpl;

import java.util.List;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import shixi.bean.Class;
import shixi.bean.Subject;
import shixi.dao.ClassDao;
import shixi.dao.ClassSubjectDao;
import shixi.service.ClassService;

@IocBean
public class ClassServiceImpl implements ClassService {
	@Inject
	private ClassDao classDao;
	@Inject
	private ClassSubjectDao classSubjectDao;

	@Override
	public void add(Class clz) {
		classDao.add(clz);

	}

	@Override
	public void delete(int id) {
		classSubjectDao.clear(id);
		classDao.delete(id);
	}

	@Override
	public void update(Class clz) {
		classDao.update(clz);
	}

	@Override
	public Class fetch(int id) {
		return classDao.fetch(id);
	}

	@Override
	public List<Class> query(Integer grade) {
		if (grade != null) {
			return classDao.query(grade);
		} else {
			return classDao.query();
		}
	}

	@Override
	public void addSubject(int classid, int subjectid) {
		classSubjectDao.addSubject(classid, subjectid);
	}

	@Override
	public void delSubject(int classid, int subjectid) {
		classSubjectDao.deletesubject(classid, subjectid);

	}

	@Override
	public List<Subject> querySubject(int classid) {
		return classSubjectDao.querysubject(classid);
	}

}
