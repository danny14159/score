package shixi;

import javax.servlet.http.HttpSession;

import org.nutz.mvc.ActionContext;
import org.nutz.mvc.ActionFilter;
import org.nutz.mvc.Mvcs;
import org.nutz.mvc.View;
import org.nutz.mvc.view.ServerRedirectView;

public class MyActionFilter implements ActionFilter {

	private String name;
    private String path;

    public MyActionFilter(String name, String path) {
        this.name = name;
        this.path = path;
    }
	
	@Override
	public View match(ActionContext actionContext) {
		HttpSession session = Mvcs.getHttpSession(false);
		//排除不需要session判断的请求
		String curl = actionContext.getPath();
		System.out.println("当前请求地址："+curl);
    	if (session == null || null == session.getAttribute(name) ){
    		if( "/users/login".equals(curl) ){
    			return null;
    		}
    		return new ServerRedirectView(path);
    	}
    		
        return null;
	}

}
