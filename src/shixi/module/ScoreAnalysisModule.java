package shixi.module;

import java.util.Map;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import shixi.bean.Analysis;
import shixi.bean.AnalysisSet;
import shixi.service.ScoreAnalysisService;
import shixi.service.serviceImpl.ScoreStatServiceImpl;

@At("/scoreAnalysis")
@IocBean
public class ScoreAnalysisModule {

	@Inject
	private ScoreAnalysisService scoreAnalysisServiceImpl;
	
	@Inject
	ScoreStatServiceImpl scoreStatServiceImpl;

	@At("/rate")
	@Ok("json")
	public AnalysisSet rate(@Param("analysisSet") AnalysisSet analysisSet,
			@Param("class_id") Integer class_id,
			@Param("test_id") Integer test_id,
			@Param("classTopx") Integer classTopx,
			@Param("schoolTopx") Integer schoolTopx) {
		return scoreAnalysisServiceImpl.analyse(analysisSet, class_id, test_id,
				classTopx, schoolTopx);

	}

	public Map<String, Object> getResult(@Param("at_grade") Integer at_grade,
			@Param("test_id") Integer test_id, @Param("type") String type,
			@Param("class_id") Integer class_id, @Param("Topx") Integer[] Topx,
			@Param("Lines") Map<String,Object>[] Lines) {
		System.out.println("#######"+Json.toJson(Lines[0]));
		/*if("class".equals(type)){
			return scoreAnalysisServiceImpl.getResult1(at_grade, test_id, type, class_id, Topx, Lines);
		}
		else if("grade".equals(type)){
			return scoreAnalysisServiceImpl.getResult2(at_grade, test_id, type, Topx, Lines);
		}*/
		return scoreAnalysisServiceImpl.getResult(type, at_grade, test_id, Topx, Lines);
	}
	
	@At("/getResult")
	@Ok("json")
	public Map<String, Object> getResult(@Param("param") Analysis param,
			@Param("topx")Integer[] topx,
			@Param("lines")Map<String,Object>[] lines){
		
		if("grade".equals(param.getType())){
			try{
				scoreStatServiceImpl.sortByGrade(null,param.getAt_grade(), param.getTest_id());
			}
			catch(Exception e){
				//e.printStackTrace();
			}
		}
		
		param.setTopx(topx);
		param.setLines(lines);
		return scoreAnalysisServiceImpl.getResult(param);
		//return scoreAnalysisServiceImpl.getResult(analysis);
	}
}
