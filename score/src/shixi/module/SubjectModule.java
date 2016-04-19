package shixi.module;

import java.util.List;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import shixi.bean.Subject;
import shixi.service.SubjectService;

@At("/subject")
@IocBean
public class SubjectModule {
	@Inject
	private SubjectService subjectServiceImpl;

	@At("/")
	@Ok("jsp:Subject")
	public void toSubject(){
		
	}
	@At("/add")
	public void add(@Param("..")Subject sub) {
		subjectServiceImpl.add(sub);
	}

	@At("/delete")
	public void delete(@Param("id")int id) {
		subjectServiceImpl.delete(id);
	}

	@At("/update")
	public void update(@Param("..")Subject sub) {
		subjectServiceImpl.update(sub);
	}

	@At("/query")
	@Ok("json")
	public List<Subject> query() {
		return subjectServiceImpl.query();
	}

	@At("/fetch")
	@Ok("json")
	public Subject fetch(@Param("id")int id) {
		return subjectServiceImpl.fetch(id);
	}
}
