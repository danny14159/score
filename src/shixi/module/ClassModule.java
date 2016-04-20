package shixi.module;

import java.util.List;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import shixi.bean.Class;
import shixi.bean.Subject;
import shixi.service.ClassService;

@At("/class")
@IocBean
public class ClassModule {
	@Inject
	private ClassService classServiceImpl;

	@At("/")
	@Ok("jsp:Class")
	public void toClass(){
		
	}
	@At("/add")
	public void add(@Param("..")Class clz) {
		System.out.println("####"+Json.toJson(clz));
		classServiceImpl.add(clz);

	}

	@At("/delete")
	public void delete(int id) {
		classServiceImpl.delete(id);

	}

	@At("/update")
	public void update(@Param("..")Class clz) {
		classServiceImpl.update(clz);
	}

	@At("/fetch")
	@Ok("json")
	public Class fetch(int id) {
		return classServiceImpl.fetch(id);

	}

	@At("/query")
	@Ok("json")
	public List<Class> query(Integer grade) {
		//System.out.println("========"+Json.toJson(classServiceImpl.query(grade)));
		return classServiceImpl.query(grade);
		
	}

	@At("/addSubject")
	public void addSubject(int classid, int subjectid) {
		classServiceImpl.addSubject(classid, subjectid);
	}

	@At("/delSubject")
	public void delSubject(int classid, int subjectid) {
		classServiceImpl.delSubject(subjectid, subjectid);
	}

	@At("/querySubject")
	@Ok("json")
	public List<Subject> querySubject(int classid) {
		return classServiceImpl.querySubject(classid);

	}
}
