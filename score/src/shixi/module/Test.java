package shixi.module;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;

import shixi.bean.Subject;
import shixi.bean.TestSubject;


public class Test {
	
	@At("/main")
	@Ok("jsp:temp")
	public void test(){
		
	}
	
	@At("/test3")
	@Ok("json")
	public List<TestSubject> test2(Integer test_id){
		List<TestSubject> list=new ArrayList<>();
		Date d=new Date();
		
		TestSubject ts=new TestSubject();
		ts.setStart_time(d);
		ts.setSubject_id(1);
		ts.setEnd_time(d);
		
		TestSubject ts1=new TestSubject();
		ts1.setStart_time(d);
		ts1.setSubject_id(2);
		ts1.setEnd_time(d);
		
		TestSubject ts2=new TestSubject();
		ts2.setStart_time(d);
		ts2.setSubject_id(3);
		ts2.setEnd_time(d);
		
		list.add(ts);list.add(ts1);list.add(ts2);
		return list;
	}
	
	@At("/getSub")
	@Ok("json")
	public List<Subject> getSubject(Integer test_id){
		List<Subject> list=new ArrayList<>();
		for (int i = 0; i < 4; i++) {
			Subject sub =new Subject();
			sub.setId(i+1);
			sub.setName("科目"+(i+1));
			list.add(sub);
		}
		return list;
	}
}
