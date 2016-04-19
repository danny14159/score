 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 

	<!-- BEGIN 数据表格 -->
	 <div class="demo-content">
	    <div class="row">
	      <div class="span16">
	        <div id="grid">
	          
	        </div>
	      </div>
	    </div>
    </div>
	<!-- END 数据表格 -->
	
 
  <script type="text/javascript">
        BUI.use(['bui/grid','bui/data'],function(Grid,Data){
            var Grid = Grid,
          Store = Data.Store,
          columns = [
            {title : '班级ID',dataIndex :'id', width:100},
            {id: '123',title : '班级名称',dataIndex :'name', width:100},
            {title : '人数',dataIndex : 'at_grade',width:200}
          ];
 
        /**
         * 自动发送的数据格式：
         *  1. start: 开始记录的起始数，如第 20 条,从0开始
         *  2. limit : 单页多少条记录
         *  3. pageIndex : 第几页，同start参数重复，可以选择其中一个使用
         *
         * 返回的数据格式：
         *  {
         *     "rows" : [{},{}], //数据集合
         *     "results" : 100, //记录总数
         *     "hasError" : false, //是否存在错误
         *     "error" : "" // 仅在 hasError : true 时使用
         *   }
         * 
         */
        var store = new Store({
            url : 'class/query',
            autoLoad:true, //自动加载数据
            params : { //配置初始请求的参数
              grade : 7
            },
            pageSize:3	// 配置分页数目
          }),
          grid = new Grid.Grid({
            render:'#grid',
            columns : columns,
            loadMask: true, //加载数据时显示屏蔽层
            store: store,
            // 底部工具栏
            bbar:{
                // pagingBar:表明包含分页栏
                pagingBar:true
            }
          });
 
        grid.render();
      });
    </script>
