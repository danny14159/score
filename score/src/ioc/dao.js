var ioc={
		dataSource : {
			type : "org.apache.commons.dbcp.BasicDataSource",
			fields : {
				driverClassName : 'com.mysql.jdbc.Driver',
				url : 'jdbc:mysql://115.28.158.206/courseselecting?characterEncoding=utf8',
				username : 'cs',
				password : 'csAdmin'

			},
			events : {
				depose : "close"
			}

		},
		dao : {
			type : "org.nutz.dao.impl.NutDao",
			args : [ {
				refer : "dataSource"
			} ]

		}
}