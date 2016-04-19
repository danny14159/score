package shixi.service.serviceImpl;

import java.util.List;

import org.nutz.dao.Cnd;
import org.nutz.dao.QueryResult;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;

import shixi.bean.Student;
import shixi.dao.StudentDao;
import shixi.service.BaseService;
import shixi.service.StudentService;

@IocBean
public class StudentServiceImpl extends BaseService<Student> implements StudentService {

	@Inject
	private StudentDao studentDao;

	@Override
	public void add(Student stu) {
		studentDao.add(stu);

	}

	@Override
	public void batch(List<Student> list) {
		studentDao.batch(list);

	}

	@Override
	public void delete(int id) {
		studentDao.delete((Integer)id);

	}

	@Override
	public QueryResult query(Integer stu_id, Integer atclass, String name,
			int pageNumber, int pageSize) {
		if (name != null) {
			return studentDao.queryByName(name, pageNumber, pageSize);

		} else if (atclass != null) {
			return studentDao.querystu(atclass, pageNumber, pageSize);
		} else {
			return studentDao.query(pageNumber, pageSize);
		}

	}

	public List<Student> query(Integer stu_id, Integer at_class) {
		if (stu_id != null && at_class == null) {
			return studentDao.queryById(stu_id);
		} else if (at_class != null && stu_id == null) {
			return studentDao.queryByClass(at_class);
		} else {
			return null;
		}
	}

	@Override
	public void updateStudent(Student student){
		studentDao.update(student);
	}

	@Override
	public Student loadById(String id) {
		return studentDao.fetch(Cnd.where("id", "=", id));
	}
}
