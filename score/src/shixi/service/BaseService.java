package shixi.service;

import java.util.List;

import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.FieldFilter;
import org.nutz.dao.QueryResult;
import org.nutz.dao.pager.Pager;
import org.nutz.dao.util.Daos;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.service.IdEntityService;

/**
 * 服务基类
 * 
 * @author 陈鹤
 * @version 1.0
 * @see 2014年10月27日
 */
@IocBean(fields = {"dao"})
public abstract class BaseService<T> extends IdEntityService<T> {

    /**
     * 增加对象
     * 
     * @param obj
     */
    public void save(T obj) {
        if( null != obj ){
            Daos.ext(dao(), FieldFilter.create(getEntityClass(), true)).insert(obj);
        }
    }

    /**
     * 更新对象
     * <p>
     * 注：忽略空字段的更新
     * </p>
     * @param obj
     * @return 返回影响的行数
     */
    public int update(T obj) {
        int extRows = 0;
        if( null != obj ){
            extRows = Daos.ext(dao(), FieldFilter.create(getEntityClass(), true)).update(obj);
        }
        return extRows;
    }

    /**
     * 根据ID删除（逻辑删除，更新deleted标识为'Y'）
     * @param id
     * @return 返回影响的行数
     */
    public int deleteById(Object id) {
        int extRows = 0;
        if( null != id ){
            extRows = dao().update(getEntityClass(), Chain.make("deleted", "Y"), Cnd.where("id", "=", id));
        }
        return extRows;
    }

    /**
     * 分页带条件查询
     * 
     * @param page
     * @param pageSize
     * @param cnd
     * @return
     */
    public QueryResult queryListByPage(Integer pageNumber, Integer pageSize, Cnd cnd) {
        
        if( null == pageNumber ){
            pageNumber = 0;
        }
        if( null == pageSize ){
            pageSize = 20;
        }

        Pager pager = dao().createPager(pageNumber, pageSize);
        List<T> list = dao().query(getEntityClass(), cnd, pager);
        pager.setRecordCount(dao().count(getEntityClass(), cnd));

        return new QueryResult(list, pager);
    }

    /**
     * 根据ID查询
     * 
     * @param id
     * @return
     */
    public T queryById(Object id) {
        return dao().fetch(getEntityClass(), Cnd.where("id", "=", id));
    }

}
