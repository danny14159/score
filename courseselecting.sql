/*
Navicat MySQL Data Transfer

Source Server         : 115.28.158.206
Source Server Version : 50548
Source Host           : 115.28.158.206:3306
Source Database       : courseselecting

Target Server Type    : MYSQL
Target Server Version : 50548
File Encoding         : 65001

Date: 2016-06-18 22:06:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_class
-- ----------------------------
DROP TABLE IF EXISTS `t_class`;
CREATE TABLE `t_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL COMMENT '班级名称',
  `at_grade` tinyint(4) DEFAULT NULL COMMENT '所在年级\n1-6小学\n7',
  `del` tinyint(4) NOT NULL DEFAULT '0',
  `teacher` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='班级';

-- ----------------------------
-- Records of t_class
-- ----------------------------
INSERT INTO `t_class` VALUES ('65', '软件1201', '7', '0', '李刚');
INSERT INTO `t_class` VALUES ('66', '计算机1101', null, '0', '');
INSERT INTO `t_class` VALUES ('67', '方法', null, '0', '');
INSERT INTO `t_class` VALUES ('68', '11', null, '0', '');
INSERT INTO `t_class` VALUES ('69', '1', null, '0', '');
INSERT INTO `t_class` VALUES ('70', '计算机1101', null, '0', '');
INSERT INTO `t_class` VALUES ('71', '计算机1101', '8', '0', '');
INSERT INTO `t_class` VALUES ('72', '软件1202', '7', '0', '黎明');
INSERT INTO `t_class` VALUES ('73', '计算机1201班', '7', '0', '张强');

-- ----------------------------
-- Table structure for t_class_subject
-- ----------------------------
DROP TABLE IF EXISTS `t_class_subject`;
CREATE TABLE `t_class_subject` (
  `t_class_id` int(11) NOT NULL,
  `t_subject_id` int(11) NOT NULL,
  `del` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`t_class_id`,`t_subject_id`),
  KEY `fk_t_class_has_t_subject_t_subject1_idx` (`t_subject_id`) USING BTREE,
  KEY `fk_t_class_has_t_subject_t_class1_idx` (`t_class_id`) USING BTREE,
  CONSTRAINT `fk_class` FOREIGN KEY (`t_class_id`) REFERENCES `t_class` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_subject` FOREIGN KEY (`t_subject_id`) REFERENCES `t_subject` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_class_subject
-- ----------------------------
INSERT INTO `t_class_subject` VALUES ('65', '15', '0');

-- ----------------------------
-- Table structure for t_course_selecting
-- ----------------------------
DROP TABLE IF EXISTS `t_course_selecting`;
CREATE TABLE `t_course_selecting` (
  `student_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  PRIMARY KEY (`subject_id`,`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_course_selecting
-- ----------------------------
INSERT INTO `t_course_selecting` VALUES ('312', '9');
INSERT INTO `t_course_selecting` VALUES ('312', '10');
INSERT INTO `t_course_selecting` VALUES ('312', '11');
INSERT INTO `t_course_selecting` VALUES ('312', '12');
INSERT INTO `t_course_selecting` VALUES ('312', '14');
INSERT INTO `t_course_selecting` VALUES ('312', '16');
INSERT INTO `t_course_selecting` VALUES ('312', '17');
INSERT INTO `t_course_selecting` VALUES ('312', '18');
INSERT INTO `t_course_selecting` VALUES ('312', '31');
INSERT INTO `t_course_selecting` VALUES ('312', '36');
INSERT INTO `t_course_selecting` VALUES ('312', '39');
INSERT INTO `t_course_selecting` VALUES ('312', '40');

-- ----------------------------
-- Table structure for t_score
-- ----------------------------
DROP TABLE IF EXISTS `t_score`;
CREATE TABLE `t_score` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stu_name` varchar(20) DEFAULT NULL COMMENT '学生姓名',
  `class_name` varchar(20) DEFAULT NULL COMMENT '班级名称',
  `test_id` int(11) NOT NULL COMMENT '考试ID',
  `subject_id` int(11) NOT NULL COMMENT '学科ID',
  `stu_id` int(11) NOT NULL COMMENT '学号',
  `at_grade` tinyint(4) DEFAULT '1' COMMENT '所在年级',
  `score` float NOT NULL DEFAULT '0' COMMENT '得分',
  `del` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_t_score_t_stu1_idx` (`stu_id`) USING BTREE,
  KEY `fk_t_score_t_score_type1_idx` (`test_id`) USING BTREE,
  KEY `fk_t_score_t_subject1_idx` (`subject_id`) USING BTREE,
  CONSTRAINT `fk_score_stuid` FOREIGN KEY (`stu_id`) REFERENCES `t_stu` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_score_subjectid` FOREIGN KEY (`subject_id`) REFERENCES `t_subject` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_score_testid` FOREIGN KEY (`test_id`) REFERENCES `t_test` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_score
-- ----------------------------

-- ----------------------------
-- Table structure for t_score_stat
-- ----------------------------
DROP TABLE IF EXISTS `t_score_stat`;
CREATE TABLE `t_score_stat` (
  `stu_id` int(11) NOT NULL COMMENT '学生id',
  `total_score` float DEFAULT NULL COMMENT '总分',
  `test_id` int(11) NOT NULL COMMENT '考试ID',
  `class_order` int(11) DEFAULT NULL COMMENT '班级排名',
  `school_order` int(11) DEFAULT NULL COMMENT '学校排名',
  `del` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`stu_id`,`test_id`),
  KEY `fk_t_score_stat_t_stu1_idx` (`stu_id`) USING BTREE,
  KEY `fk_t_score_stat_t_test1_idx` (`test_id`) USING BTREE,
  CONSTRAINT `fk_score_stat_stu` FOREIGN KEY (`stu_id`) REFERENCES `t_stu` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_score_stat_test` FOREIGN KEY (`test_id`) REFERENCES `t_test` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_score_stat
-- ----------------------------

-- ----------------------------
-- Table structure for t_stu
-- ----------------------------
DROP TABLE IF EXISTS `t_stu`;
CREATE TABLE `t_stu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '学号，自动分配的有规律字段',
  `name` varchar(20) NOT NULL COMMENT '学生姓名',
  `at_class` int(11) NOT NULL COMMENT '所在班级',
  `sex` char(1) NOT NULL COMMENT '性别',
  `del` tinyint(4) NOT NULL DEFAULT '0',
  `enterYear` int(11) DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL,
  `location` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk1` (`at_class`) USING BTREE,
  CONSTRAINT `fk1` FOREIGN KEY (`at_class`) REFERENCES `t_class` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20125321 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='学生';

-- ----------------------------
-- Records of t_stu
-- ----------------------------
INSERT INTO `t_stu` VALUES ('312', '马丁', '65', '男', '1', '2006', '', '湖南长沙');
INSERT INTO `t_stu` VALUES ('314', '褚佳傲', '65', '男', '0', '2012', '山东', '山东');
INSERT INTO `t_stu` VALUES ('80111', '张子豪', '65', '男', '0', '2012', '黑龙江', '黑龙江');
INSERT INTO `t_stu` VALUES ('12354546', '提莫队长', '71', '男', '0', '2014', '', '约德尔');
INSERT INTO `t_stu` VALUES ('12354547', '刘世德', '65', '女', '0', '2012', '江西', '江西');
INSERT INTO `t_stu` VALUES ('12354548', '李四', '65', '女', '0', '2012', null, null);
INSERT INTO `t_stu` VALUES ('12354549', '王五', '65', '男', '0', '2016', null, null);
INSERT INTO `t_stu` VALUES ('12354556', '马丁', '65', '男', '0', '2006', '', '湖南长沙');
INSERT INTO `t_stu` VALUES ('12354557', '张三', '65', '女', '0', '2006', '湖南长沙', '湖南长沙');
INSERT INTO `t_stu` VALUES ('12354558', '李四', '65', '女', '0', '2012', 'null', 'null');
INSERT INTO `t_stu` VALUES ('12354559', '王五', '65', '男', '0', '2016', 'null', 'null');
INSERT INTO `t_stu` VALUES ('12354560', '马丁', '65', '男', '0', '2006', '', '湖南长沙');
INSERT INTO `t_stu` VALUES ('12354561', '张三', '65', '女', '0', '2006', '湖南长沙', '湖南长沙');
INSERT INTO `t_stu` VALUES ('12354562', '李四', '65', '女', '0', '2012', 'null', 'null');
INSERT INTO `t_stu` VALUES ('12354563', '王五', '65', '男', '0', '2016', 'null', 'null');
INSERT INTO `t_stu` VALUES ('12354564', '马丁', '65', '男', '0', '2006', '', '湖南长沙');
INSERT INTO `t_stu` VALUES ('12354565', '张三', '65', '女', '0', '2006', '湖南长沙', '湖南长沙');
INSERT INTO `t_stu` VALUES ('12354566', '李四', '65', '女', '0', '2012', 'null', 'null');
INSERT INTO `t_stu` VALUES ('12354567', '王五', '65', '男', '1', '2016', 'null', 'null');
INSERT INTO `t_stu` VALUES ('12354568', '菠萝', '65', '男', '0', null, '', '湖南长沙');
INSERT INTO `t_stu` VALUES ('12354584', '菠萝', '65', '男', '0', null, '', '湖南长沙');
INSERT INTO `t_stu` VALUES ('12354600', '菠萝', '65', '男', '0', null, '', '湖南长沙');
INSERT INTO `t_stu` VALUES ('20125008', '张飞', '65', '男', '0', '2009', '长沙', '湖南');
INSERT INTO `t_stu` VALUES ('20125009', '刘漫琪', '72', '女', '1', '2012', '陕西武功县', '陕西武功县');
INSERT INTO `t_stu` VALUES ('20125010', '付艳', '72', '女', '1', '2012', '江西章贡区', '江西章贡区');
INSERT INTO `t_stu` VALUES ('20125011', '宋盈', '72', '女', '1', '2012', '湖南岳阳市岳阳市区', '湖南岳阳市岳阳市区');
INSERT INTO `t_stu` VALUES ('20125012', '朱冰丽', '72', '女', '0', '2012', '湖南永州市江华县', '湖南永州市江华县');
INSERT INTO `t_stu` VALUES ('20125013', '杨夕', '72', '女', '0', '2012', '湖南湘潭市湘潭县', '湖南湘潭市湘潭县');
INSERT INTO `t_stu` VALUES ('20125014', '申媛媛', '72', '女', '0', '2012', '湖南邵阳市洞口县', '湖南邵阳市洞口县');
INSERT INTO `t_stu` VALUES ('20125015', '郑圣娟', '72', '女', '0', '2012', '湖南怀化市麻阳县', '湖南怀化市麻阳县');
INSERT INTO `t_stu` VALUES ('20125016', '梁青', '72', '女', '0', '2012', '湖南衡阳市衡阳县', '湖南衡阳市衡阳县');
INSERT INTO `t_stu` VALUES ('20125017', '张秋茜', '72', '女', '0', '2012', '湖南常德市澧县', '湖南常德市澧县');
INSERT INTO `t_stu` VALUES ('20125018', '张安琪', '72', '女', '0', '2012', '湖南长沙市雨花区', '湖南长沙市雨花区');
INSERT INTO `t_stu` VALUES ('20125019', '朱蒙蒙', '72', '女', '0', '2012', '河南周口市太康县', '河南周口市太康县');
INSERT INTO `t_stu` VALUES ('20125020', '苏静怡', '72', '女', '0', '2012', '广西柳州市 市辖区', '广西柳州市 市辖区');
INSERT INTO `t_stu` VALUES ('20125021', '李韩川', '72', '男', '0', '2012', '重庆开县岳溪镇', '重庆开县岳溪镇');
INSERT INTO `t_stu` VALUES ('20125022', '闻豪', '72', '男', '0', '2012', '云南泸西县', '云南泸西县');
INSERT INTO `t_stu` VALUES ('20125023', '李晨', '72', '男', '0', '2012', '天津武清区', '天津武清区');
INSERT INTO `t_stu` VALUES ('20125024', '霍腾', '72', '男', '0', '2012', '山西运城市盐湖区', '山西运城市盐湖区');
INSERT INTO `t_stu` VALUES ('20125025', '王焕斌', '72', '男', '0', '2012', '青海城北区', '青海城北区');
INSERT INTO `t_stu` VALUES ('20125026', '史亚旭', '72', '男', '0', '2012', '内蒙古青山区', '内蒙古青山区');
INSERT INTO `t_stu` VALUES ('20125027', '刘世德', '72', '男', '0', '2012', '江西泰和县', '江西泰和县');
INSERT INTO `t_stu` VALUES ('20125028', '任冠青', '72', '男', '1', '2012', '江苏京口区', '江苏京口区');
INSERT INTO `t_stu` VALUES ('20125029', '张萌', '72', '男', '0', '2012', '吉林德惠市', '吉林德惠市');
INSERT INTO `t_stu` VALUES ('20125030', '黎磊', '72', '男', '0', '2012', '湖南株洲市醴陵市', '湖南株洲市醴陵市');
INSERT INTO `t_stu` VALUES ('20125031', '盛敏', '72', '男', '0', '2012', '湖南永州市零陵区', '湖南永州市零陵区');
INSERT INTO `t_stu` VALUES ('20125032', '陈志军', '72', '男', '0', '2012', '湖南益阳市沅江市', '湖南益阳市沅江市');
INSERT INTO `t_stu` VALUES ('20125033', '何嘉伟', '72', '男', '0', '2012', '湖南益阳市赫山区', '湖南益阳市赫山区');
INSERT INTO `t_stu` VALUES ('20125034', '李俊华', '72', '男', '0', '2012', '湖南湘潭市湘潭县', '湖南湘潭市湘潭县');
INSERT INTO `t_stu` VALUES ('20125035', '周胜乐', '72', '男', '0', '2012', '湖南邵阳市邵阳县', '湖南邵阳市邵阳县');
INSERT INTO `t_stu` VALUES ('20125036', '罗彪', '72', '男', '0', '2012', '湖南娄底市新化县', '湖南娄底市新化县');
INSERT INTO `t_stu` VALUES ('20125037', '吴洪念', '72', '男', '0', '2012', '湖南娄底市涟源市', '湖南娄底市涟源市');
INSERT INTO `t_stu` VALUES ('20125038', '魏鹏', '72', '男', '0', '2012', '湖南衡阳市衡阳市区', '湖南衡阳市衡阳市区');
INSERT INTO `t_stu` VALUES ('20125039', '涂磊', '72', '男', '0', '2012', '湖南常德市汉寿县', '湖南常德市汉寿县');
INSERT INTO `t_stu` VALUES ('20125040', '胡文超', '72', '男', '0', '2012', '湖南长沙市长沙县', '湖南长沙市长沙县');
INSERT INTO `t_stu` VALUES ('20125041', '张子豪', '72', '男', '0', '2012', '黑龙江伊春区', '黑龙江伊春区');
INSERT INTO `t_stu` VALUES ('20125042', '回繁宁', '72', '男', '0', '2012', '河北衡水市枣强县', '河北衡水市枣强县');
INSERT INTO `t_stu` VALUES ('20125043', '陶兴', '72', '男', '0', '2012', '贵州普定县', '贵州普定县');
INSERT INTO `t_stu` VALUES ('20125044', '朱麒霖', '72', '男', '0', '2012', '广西柳州市 市辖区', '广西柳州市 市辖区');
INSERT INTO `t_stu` VALUES ('20125045', '杨万', '72', '男', '0', '2012', '甘肃会宁县', '甘肃会宁县');
INSERT INTO `t_stu` VALUES ('20125046', '王嘉豪', '72', '男', '0', '2012', '北京东城区', '北京东城区');
INSERT INTO `t_stu` VALUES ('20125047', '胡佳杰', '72', '男', '0', '2012', '北京海淀区', '北京海淀区');
INSERT INTO `t_stu` VALUES ('20125048', '刘漫琪', '72', '女', '0', '2012', '陕西武功县', '陕西武功县');
INSERT INTO `t_stu` VALUES ('20125049', '付艳', '72', '女', '0', '2012', '江西章贡区', '江西章贡区');
INSERT INTO `t_stu` VALUES ('20125050', '宋盈', '72', '女', '0', '2012', '湖南岳阳市岳阳市区', '湖南岳阳市岳阳市区');
INSERT INTO `t_stu` VALUES ('20125051', '朱冰丽', '72', '女', '0', '2012', '湖南永州市江华县', '湖南永州市江华县');
INSERT INTO `t_stu` VALUES ('20125052', '杨夕', '72', '女', '0', '2012', '湖南湘潭市湘潭县', '湖南湘潭市湘潭县');
INSERT INTO `t_stu` VALUES ('20125053', '申媛媛', '72', '女', '0', '2012', '湖南邵阳市洞口县', '湖南邵阳市洞口县');
INSERT INTO `t_stu` VALUES ('20125054', '郑圣娟', '72', '女', '0', '2012', '湖南怀化市麻阳县', '湖南怀化市麻阳县');
INSERT INTO `t_stu` VALUES ('20125055', '梁青', '72', '女', '0', '2012', '湖南衡阳市衡阳县', '湖南衡阳市衡阳县');
INSERT INTO `t_stu` VALUES ('20125056', '张秋茜', '72', '女', '0', '2012', '湖南常德市澧县', '湖南常德市澧县');
INSERT INTO `t_stu` VALUES ('20125057', '张安琪', '72', '女', '0', '2012', '湖南长沙市雨花区', '湖南长沙市雨花区');
INSERT INTO `t_stu` VALUES ('20125058', '朱蒙蒙', '72', '女', '0', '2012', '河南周口市太康县', '河南周口市太康县');
INSERT INTO `t_stu` VALUES ('20125059', '苏静怡', '72', '女', '0', '2012', '广西柳州市 市辖区', '广西柳州市 市辖区');
INSERT INTO `t_stu` VALUES ('20125060', '李韩川', '72', '男', '0', '2012', '重庆开县岳溪镇', '重庆开县岳溪镇');
INSERT INTO `t_stu` VALUES ('20125061', '闻豪', '72', '男', '0', '2012', '云南泸西县', '云南泸西县');
INSERT INTO `t_stu` VALUES ('20125062', '李晨', '72', '男', '0', '2012', '天津武清区', '天津武清区');
INSERT INTO `t_stu` VALUES ('20125063', '霍腾', '72', '男', '0', '2012', '山西运城市盐湖区', '山西运城市盐湖区');
INSERT INTO `t_stu` VALUES ('20125064', '王焕斌', '72', '男', '0', '2012', '青海城北区', '青海城北区');
INSERT INTO `t_stu` VALUES ('20125065', '史亚旭', '72', '男', '0', '2012', '内蒙古青山区', '内蒙古青山区');
INSERT INTO `t_stu` VALUES ('20125066', '刘世德', '72', '男', '0', '2012', '江西泰和县', '江西泰和县');
INSERT INTO `t_stu` VALUES ('20125067', '任冠青', '72', '男', '0', '2012', '江苏京口区', '江苏京口区');
INSERT INTO `t_stu` VALUES ('20125068', '张萌', '72', '男', '0', '2012', '吉林德惠市', '吉林德惠市');
INSERT INTO `t_stu` VALUES ('20125069', '黎磊', '72', '男', '0', '2012', '湖南株洲市醴陵市', '湖南株洲市醴陵市');
INSERT INTO `t_stu` VALUES ('20125070', '盛敏', '72', '男', '0', '2012', '湖南永州市零陵区', '湖南永州市零陵区');
INSERT INTO `t_stu` VALUES ('20125071', '陈志军', '72', '男', '0', '2012', '湖南益阳市沅江市', '湖南益阳市沅江市');
INSERT INTO `t_stu` VALUES ('20125072', '何嘉伟', '72', '男', '0', '2012', '湖南益阳市赫山区', '湖南益阳市赫山区');
INSERT INTO `t_stu` VALUES ('20125073', '李俊华', '72', '男', '0', '2012', '湖南湘潭市湘潭县', '湖南湘潭市湘潭县');
INSERT INTO `t_stu` VALUES ('20125074', '周胜乐', '72', '男', '0', '2012', '湖南邵阳市邵阳县', '湖南邵阳市邵阳县');
INSERT INTO `t_stu` VALUES ('20125075', '罗彪', '72', '男', '0', '2012', '湖南娄底市新化县', '湖南娄底市新化县');
INSERT INTO `t_stu` VALUES ('20125076', '吴洪念', '72', '男', '0', '2012', '湖南娄底市涟源市', '湖南娄底市涟源市');
INSERT INTO `t_stu` VALUES ('20125077', '魏鹏', '72', '男', '0', '2012', '湖南衡阳市衡阳市区', '湖南衡阳市衡阳市区');
INSERT INTO `t_stu` VALUES ('20125078', '涂磊', '72', '男', '0', '2012', '湖南常德市汉寿县', '湖南常德市汉寿县');
INSERT INTO `t_stu` VALUES ('20125079', '胡文超', '72', '男', '0', '2012', '湖南长沙市长沙县', '湖南长沙市长沙县');
INSERT INTO `t_stu` VALUES ('20125080', '张子豪', '72', '男', '0', '2012', '黑龙江伊春区', '黑龙江伊春区');
INSERT INTO `t_stu` VALUES ('20125081', '回繁宁', '72', '男', '0', '2012', '河北衡水市枣强县', '河北衡水市枣强县');
INSERT INTO `t_stu` VALUES ('20125082', '陶兴', '72', '男', '0', '2012', '贵州普定县', '贵州普定县');
INSERT INTO `t_stu` VALUES ('20125083', '朱麒霖', '72', '男', '0', '2012', '广西柳州市 市辖区', '广西柳州市 市辖区');
INSERT INTO `t_stu` VALUES ('20125084', '杨万', '72', '男', '0', '2012', '甘肃会宁县', '甘肃会宁县');
INSERT INTO `t_stu` VALUES ('20125085', '王嘉豪', '72', '男', '0', '2012', '北京东城区', '北京东城区');
INSERT INTO `t_stu` VALUES ('20125086', '胡佳杰', '72', '男', '0', '2012', '北京海淀区', '北京海淀区');
INSERT INTO `t_stu` VALUES ('20125087', '刘漫琪', '72', '女', '0', '2012', '陕西武功县', '陕西武功县');
INSERT INTO `t_stu` VALUES ('20125088', '付艳', '72', '女', '0', '2012', '江西章贡区', '江西章贡区');
INSERT INTO `t_stu` VALUES ('20125089', '宋盈', '72', '女', '0', '2012', '湖南岳阳市岳阳市区', '湖南岳阳市岳阳市区');
INSERT INTO `t_stu` VALUES ('20125090', '朱冰丽', '72', '女', '0', '2012', '湖南永州市江华县', '湖南永州市江华县');
INSERT INTO `t_stu` VALUES ('20125091', '杨夕', '72', '女', '0', '2012', '湖南湘潭市湘潭县', '湖南湘潭市湘潭县');
INSERT INTO `t_stu` VALUES ('20125092', '申媛媛', '72', '女', '0', '2012', '湖南邵阳市洞口县', '湖南邵阳市洞口县');
INSERT INTO `t_stu` VALUES ('20125093', '郑圣娟', '72', '女', '0', '2012', '湖南怀化市麻阳县', '湖南怀化市麻阳县');
INSERT INTO `t_stu` VALUES ('20125094', '梁青', '72', '女', '0', '2012', '湖南衡阳市衡阳县', '湖南衡阳市衡阳县');
INSERT INTO `t_stu` VALUES ('20125095', '张秋茜', '72', '女', '0', '2012', '湖南常德市澧县', '湖南常德市澧县');
INSERT INTO `t_stu` VALUES ('20125096', '张安琪', '72', '女', '0', '2012', '湖南长沙市雨花区', '湖南长沙市雨花区');
INSERT INTO `t_stu` VALUES ('20125097', '朱蒙蒙', '72', '女', '0', '2012', '河南周口市太康县', '河南周口市太康县');
INSERT INTO `t_stu` VALUES ('20125098', '苏静怡', '72', '女', '0', '2012', '广西柳州市 市辖区', '广西柳州市 市辖区');
INSERT INTO `t_stu` VALUES ('20125099', '李韩川', '72', '男', '0', '2012', '重庆开县岳溪镇', '重庆开县岳溪镇');
INSERT INTO `t_stu` VALUES ('20125100', '闻豪', '72', '男', '0', '2012', '云南泸西县', '云南泸西县');
INSERT INTO `t_stu` VALUES ('20125101', '李晨', '72', '男', '0', '2012', '天津武清区', '天津武清区');
INSERT INTO `t_stu` VALUES ('20125102', '霍腾', '72', '男', '0', '2012', '山西运城市盐湖区', '山西运城市盐湖区');
INSERT INTO `t_stu` VALUES ('20125103', '王焕斌', '72', '男', '0', '2012', '青海城北区', '青海城北区');
INSERT INTO `t_stu` VALUES ('20125104', '史亚旭', '72', '男', '0', '2012', '内蒙古青山区', '内蒙古青山区');
INSERT INTO `t_stu` VALUES ('20125105', '刘世德', '72', '男', '0', '2012', '江西泰和县', '江西泰和县');
INSERT INTO `t_stu` VALUES ('20125106', '任冠青', '72', '男', '0', '2012', '江苏京口区', '江苏京口区');
INSERT INTO `t_stu` VALUES ('20125107', '张萌', '72', '男', '0', '2012', '吉林德惠市', '吉林德惠市');
INSERT INTO `t_stu` VALUES ('20125108', '黎磊', '72', '男', '0', '2012', '湖南株洲市醴陵市', '湖南株洲市醴陵市');
INSERT INTO `t_stu` VALUES ('20125109', '盛敏', '72', '男', '0', '2012', '湖南永州市零陵区', '湖南永州市零陵区');
INSERT INTO `t_stu` VALUES ('20125110', '陈志军', '72', '男', '0', '2012', '湖南益阳市沅江市', '湖南益阳市沅江市');
INSERT INTO `t_stu` VALUES ('20125111', '何嘉伟', '72', '男', '0', '2012', '湖南益阳市赫山区', '湖南益阳市赫山区');
INSERT INTO `t_stu` VALUES ('20125112', '李俊华', '72', '男', '0', '2012', '湖南湘潭市湘潭县', '湖南湘潭市湘潭县');
INSERT INTO `t_stu` VALUES ('20125113', '周胜乐', '72', '男', '0', '2012', '湖南邵阳市邵阳县', '湖南邵阳市邵阳县');
INSERT INTO `t_stu` VALUES ('20125114', '罗彪', '72', '男', '0', '2012', '湖南娄底市新化县', '湖南娄底市新化县');
INSERT INTO `t_stu` VALUES ('20125115', '吴洪念', '72', '男', '0', '2012', '湖南娄底市涟源市', '湖南娄底市涟源市');
INSERT INTO `t_stu` VALUES ('20125116', '魏鹏', '72', '男', '0', '2012', '湖南衡阳市衡阳市区', '湖南衡阳市衡阳市区');
INSERT INTO `t_stu` VALUES ('20125117', '涂磊', '72', '男', '0', '2012', '湖南常德市汉寿县', '湖南常德市汉寿县');
INSERT INTO `t_stu` VALUES ('20125118', '胡文超', '72', '男', '0', '2012', '湖南长沙市长沙县', '湖南长沙市长沙县');
INSERT INTO `t_stu` VALUES ('20125119', '张子豪', '72', '男', '0', '2012', '黑龙江伊春区', '黑龙江伊春区');
INSERT INTO `t_stu` VALUES ('20125120', '回繁宁', '72', '男', '0', '2012', '河北衡水市枣强县', '河北衡水市枣强县');
INSERT INTO `t_stu` VALUES ('20125121', '陶兴', '72', '男', '0', '2012', '贵州普定县', '贵州普定县');
INSERT INTO `t_stu` VALUES ('20125122', '朱麒霖', '72', '男', '0', '2012', '广西柳州市 市辖区', '广西柳州市 市辖区');
INSERT INTO `t_stu` VALUES ('20125123', '杨万', '72', '男', '0', '2012', '甘肃会宁县', '甘肃会宁县');
INSERT INTO `t_stu` VALUES ('20125124', '王嘉豪', '72', '男', '0', '2012', '北京东城区', '北京东城区');
INSERT INTO `t_stu` VALUES ('20125125', '胡佳杰', '72', '男', '0', '2012', '北京海淀区', '北京海淀区');
INSERT INTO `t_stu` VALUES ('20125126', '刘漫琪', '72', '女', '0', '2012', '陕西武功县', '陕西武功县');
INSERT INTO `t_stu` VALUES ('20125127', '付艳', '72', '女', '0', '2012', '江西章贡区', '江西章贡区');
INSERT INTO `t_stu` VALUES ('20125128', '宋盈', '72', '女', '0', '2012', '湖南岳阳市岳阳市区', '湖南岳阳市岳阳市区');
INSERT INTO `t_stu` VALUES ('20125129', '朱冰丽', '72', '女', '0', '2012', '湖南永州市江华县', '湖南永州市江华县');
INSERT INTO `t_stu` VALUES ('20125130', '杨夕', '72', '女', '0', '2012', '湖南湘潭市湘潭县', '湖南湘潭市湘潭县');
INSERT INTO `t_stu` VALUES ('20125131', '申媛媛', '72', '女', '0', '2012', '湖南邵阳市洞口县', '湖南邵阳市洞口县');
INSERT INTO `t_stu` VALUES ('20125132', '郑圣娟', '72', '女', '0', '2012', '湖南怀化市麻阳县', '湖南怀化市麻阳县');
INSERT INTO `t_stu` VALUES ('20125133', '梁青', '72', '女', '0', '2012', '湖南衡阳市衡阳县', '湖南衡阳市衡阳县');
INSERT INTO `t_stu` VALUES ('20125134', '张秋茜', '72', '女', '0', '2012', '湖南常德市澧县', '湖南常德市澧县');
INSERT INTO `t_stu` VALUES ('20125135', '张安琪', '72', '女', '0', '2012', '湖南长沙市雨花区', '湖南长沙市雨花区');
INSERT INTO `t_stu` VALUES ('20125136', '朱蒙蒙', '72', '女', '0', '2012', '河南周口市太康县', '河南周口市太康县');
INSERT INTO `t_stu` VALUES ('20125137', '苏静怡', '72', '女', '0', '2012', '广西柳州市 市辖区', '广西柳州市 市辖区');
INSERT INTO `t_stu` VALUES ('20125138', '李韩川', '72', '男', '0', '2012', '重庆开县岳溪镇', '重庆开县岳溪镇');
INSERT INTO `t_stu` VALUES ('20125139', '闻豪', '72', '男', '0', '2012', '云南泸西县', '云南泸西县');
INSERT INTO `t_stu` VALUES ('20125140', '李晨', '72', '男', '0', '2012', '天津武清区', '天津武清区');
INSERT INTO `t_stu` VALUES ('20125141', '霍腾', '72', '男', '0', '2012', '山西运城市盐湖区', '山西运城市盐湖区');
INSERT INTO `t_stu` VALUES ('20125142', '王焕斌', '72', '男', '0', '2012', '青海城北区', '青海城北区');
INSERT INTO `t_stu` VALUES ('20125143', '史亚旭', '72', '男', '0', '2012', '内蒙古青山区', '内蒙古青山区');
INSERT INTO `t_stu` VALUES ('20125144', '刘世德', '72', '男', '0', '2012', '江西泰和县', '江西泰和县');
INSERT INTO `t_stu` VALUES ('20125145', '任冠青', '72', '男', '0', '2012', '江苏京口区', '江苏京口区');
INSERT INTO `t_stu` VALUES ('20125146', '张萌', '72', '男', '0', '2012', '吉林德惠市', '吉林德惠市');
INSERT INTO `t_stu` VALUES ('20125147', '黎磊', '72', '男', '0', '2012', '湖南株洲市醴陵市', '湖南株洲市醴陵市');
INSERT INTO `t_stu` VALUES ('20125148', '盛敏', '72', '男', '0', '2012', '湖南永州市零陵区', '湖南永州市零陵区');
INSERT INTO `t_stu` VALUES ('20125149', '陈志军', '72', '男', '0', '2012', '湖南益阳市沅江市', '湖南益阳市沅江市');
INSERT INTO `t_stu` VALUES ('20125150', '何嘉伟', '72', '男', '0', '2012', '湖南益阳市赫山区', '湖南益阳市赫山区');
INSERT INTO `t_stu` VALUES ('20125151', '李俊华', '72', '男', '0', '2012', '湖南湘潭市湘潭县', '湖南湘潭市湘潭县');
INSERT INTO `t_stu` VALUES ('20125152', '周胜乐', '72', '男', '0', '2012', '湖南邵阳市邵阳县', '湖南邵阳市邵阳县');
INSERT INTO `t_stu` VALUES ('20125153', '罗彪', '72', '男', '0', '2012', '湖南娄底市新化县', '湖南娄底市新化县');
INSERT INTO `t_stu` VALUES ('20125154', '吴洪念', '72', '男', '0', '2012', '湖南娄底市涟源市', '湖南娄底市涟源市');
INSERT INTO `t_stu` VALUES ('20125155', '魏鹏', '72', '男', '0', '2012', '湖南衡阳市衡阳市区', '湖南衡阳市衡阳市区');
INSERT INTO `t_stu` VALUES ('20125156', '涂磊', '72', '男', '0', '2012', '湖南常德市汉寿县', '湖南常德市汉寿县');
INSERT INTO `t_stu` VALUES ('20125157', '胡文超', '72', '男', '0', '2012', '湖南长沙市长沙县', '湖南长沙市长沙县');
INSERT INTO `t_stu` VALUES ('20125158', '张子豪', '72', '男', '0', '2012', '黑龙江伊春区', '黑龙江伊春区');
INSERT INTO `t_stu` VALUES ('20125159', '回繁宁', '72', '男', '0', '2012', '河北衡水市枣强县', '河北衡水市枣强县');
INSERT INTO `t_stu` VALUES ('20125160', '陶兴', '72', '男', '0', '2012', '贵州普定县', '贵州普定县');
INSERT INTO `t_stu` VALUES ('20125161', '朱麒霖', '72', '男', '0', '2012', '广西柳州市 市辖区', '广西柳州市 市辖区');
INSERT INTO `t_stu` VALUES ('20125162', '杨万', '72', '男', '0', '2012', '甘肃会宁县', '甘肃会宁县');
INSERT INTO `t_stu` VALUES ('20125163', '王嘉豪', '72', '男', '0', '2012', '北京东城区', '北京东城区');
INSERT INTO `t_stu` VALUES ('20125164', '胡佳杰', '72', '男', '0', '2012', '北京海淀区', '北京海淀区');
INSERT INTO `t_stu` VALUES ('20125165', '刘漫琪', '72', '女', '0', '2012', '陕西武功县', '陕西武功县');
INSERT INTO `t_stu` VALUES ('20125166', '付艳', '72', '女', '0', '2012', '江西章贡区', '江西章贡区');
INSERT INTO `t_stu` VALUES ('20125167', '宋盈', '72', '女', '0', '2012', '湖南岳阳市岳阳市区', '湖南岳阳市岳阳市区');
INSERT INTO `t_stu` VALUES ('20125168', '朱冰丽', '72', '女', '0', '2012', '湖南永州市江华县', '湖南永州市江华县');
INSERT INTO `t_stu` VALUES ('20125169', '杨夕', '72', '女', '0', '2012', '湖南湘潭市湘潭县', '湖南湘潭市湘潭县');
INSERT INTO `t_stu` VALUES ('20125170', '申媛媛', '72', '女', '0', '2012', '湖南邵阳市洞口县', '湖南邵阳市洞口县');
INSERT INTO `t_stu` VALUES ('20125171', '郑圣娟', '72', '女', '0', '2012', '湖南怀化市麻阳县', '湖南怀化市麻阳县');
INSERT INTO `t_stu` VALUES ('20125172', '梁青', '72', '女', '0', '2012', '湖南衡阳市衡阳县', '湖南衡阳市衡阳县');
INSERT INTO `t_stu` VALUES ('20125173', '张秋茜', '72', '女', '0', '2012', '湖南常德市澧县', '湖南常德市澧县');
INSERT INTO `t_stu` VALUES ('20125174', '张安琪', '72', '女', '0', '2012', '湖南长沙市雨花区', '湖南长沙市雨花区');
INSERT INTO `t_stu` VALUES ('20125175', '朱蒙蒙', '72', '女', '0', '2012', '河南周口市太康县', '河南周口市太康县');
INSERT INTO `t_stu` VALUES ('20125176', '苏静怡', '72', '女', '0', '2012', '广西柳州市 市辖区', '广西柳州市 市辖区');
INSERT INTO `t_stu` VALUES ('20125177', '李韩川', '72', '男', '0', '2012', '重庆开县岳溪镇', '重庆开县岳溪镇');
INSERT INTO `t_stu` VALUES ('20125178', '闻豪', '72', '男', '0', '2012', '云南泸西县', '云南泸西县');
INSERT INTO `t_stu` VALUES ('20125179', '李晨', '72', '男', '0', '2012', '天津武清区', '天津武清区');
INSERT INTO `t_stu` VALUES ('20125180', '霍腾', '72', '男', '0', '2012', '山西运城市盐湖区', '山西运城市盐湖区');
INSERT INTO `t_stu` VALUES ('20125181', '王焕斌', '72', '男', '0', '2012', '青海城北区', '青海城北区');
INSERT INTO `t_stu` VALUES ('20125182', '史亚旭', '72', '男', '0', '2012', '内蒙古青山区', '内蒙古青山区');
INSERT INTO `t_stu` VALUES ('20125183', '刘世德', '72', '男', '0', '2012', '江西泰和县', '江西泰和县');
INSERT INTO `t_stu` VALUES ('20125184', '任冠青', '72', '男', '0', '2012', '江苏京口区', '江苏京口区');
INSERT INTO `t_stu` VALUES ('20125185', '张萌', '72', '男', '0', '2012', '吉林德惠市', '吉林德惠市');
INSERT INTO `t_stu` VALUES ('20125186', '黎磊', '72', '男', '0', '2012', '湖南株洲市醴陵市', '湖南株洲市醴陵市');
INSERT INTO `t_stu` VALUES ('20125187', '盛敏', '72', '男', '0', '2012', '湖南永州市零陵区', '湖南永州市零陵区');
INSERT INTO `t_stu` VALUES ('20125188', '陈志军', '72', '男', '0', '2012', '湖南益阳市沅江市', '湖南益阳市沅江市');
INSERT INTO `t_stu` VALUES ('20125189', '何嘉伟', '72', '男', '0', '2012', '湖南益阳市赫山区', '湖南益阳市赫山区');
INSERT INTO `t_stu` VALUES ('20125190', '李俊华', '72', '男', '0', '2012', '湖南湘潭市湘潭县', '湖南湘潭市湘潭县');
INSERT INTO `t_stu` VALUES ('20125191', '周胜乐', '72', '男', '0', '2012', '湖南邵阳市邵阳县', '湖南邵阳市邵阳县');
INSERT INTO `t_stu` VALUES ('20125192', '罗彪', '72', '男', '0', '2012', '湖南娄底市新化县', '湖南娄底市新化县');
INSERT INTO `t_stu` VALUES ('20125193', '吴洪念', '72', '男', '0', '2012', '湖南娄底市涟源市', '湖南娄底市涟源市');
INSERT INTO `t_stu` VALUES ('20125194', '魏鹏', '72', '男', '0', '2012', '湖南衡阳市衡阳市区', '湖南衡阳市衡阳市区');
INSERT INTO `t_stu` VALUES ('20125195', '涂磊', '72', '男', '0', '2012', '湖南常德市汉寿县', '湖南常德市汉寿县');
INSERT INTO `t_stu` VALUES ('20125196', '胡文超', '72', '男', '0', '2012', '湖南长沙市长沙县', '湖南长沙市长沙县');
INSERT INTO `t_stu` VALUES ('20125197', '张子豪', '72', '男', '0', '2012', '黑龙江伊春区', '黑龙江伊春区');
INSERT INTO `t_stu` VALUES ('20125198', '回繁宁', '72', '男', '0', '2012', '河北衡水市枣强县', '河北衡水市枣强县');
INSERT INTO `t_stu` VALUES ('20125199', '陶兴', '72', '男', '0', '2012', '贵州普定县', '贵州普定县');
INSERT INTO `t_stu` VALUES ('20125200', '朱麒霖', '72', '男', '0', '2012', '广西柳州市 市辖区', '广西柳州市 市辖区');
INSERT INTO `t_stu` VALUES ('20125201', '杨万', '72', '男', '0', '2012', '甘肃会宁县', '甘肃会宁县');
INSERT INTO `t_stu` VALUES ('20125202', '王嘉豪', '72', '男', '0', '2012', '北京东城区', '北京东城区');
INSERT INTO `t_stu` VALUES ('20125203', '胡佳杰', '72', '男', '0', '2012', '北京海淀区', '北京海淀区');
INSERT INTO `t_stu` VALUES ('20125204', '刘漫琪', '72', '女', '0', '2012', '陕西武功县', '陕西武功县');
INSERT INTO `t_stu` VALUES ('20125205', '付艳', '72', '女', '0', '2012', '江西章贡区', '江西章贡区');
INSERT INTO `t_stu` VALUES ('20125206', '宋盈', '72', '女', '0', '2012', '湖南岳阳市岳阳市区', '湖南岳阳市岳阳市区');
INSERT INTO `t_stu` VALUES ('20125207', '朱冰丽', '72', '女', '0', '2012', '湖南永州市江华县', '湖南永州市江华县');
INSERT INTO `t_stu` VALUES ('20125208', '杨夕', '72', '女', '0', '2012', '湖南湘潭市湘潭县', '湖南湘潭市湘潭县');
INSERT INTO `t_stu` VALUES ('20125209', '申媛媛', '72', '女', '0', '2012', '湖南邵阳市洞口县', '湖南邵阳市洞口县');
INSERT INTO `t_stu` VALUES ('20125210', '郑圣娟', '72', '女', '0', '2012', '湖南怀化市麻阳县', '湖南怀化市麻阳县');
INSERT INTO `t_stu` VALUES ('20125211', '梁青', '72', '女', '0', '2012', '湖南衡阳市衡阳县', '湖南衡阳市衡阳县');
INSERT INTO `t_stu` VALUES ('20125212', '张秋茜', '72', '女', '0', '2012', '湖南常德市澧县', '湖南常德市澧县');
INSERT INTO `t_stu` VALUES ('20125213', '张安琪', '72', '女', '0', '2012', '湖南长沙市雨花区', '湖南长沙市雨花区');
INSERT INTO `t_stu` VALUES ('20125214', '朱蒙蒙', '72', '女', '0', '2012', '河南周口市太康县', '河南周口市太康县');
INSERT INTO `t_stu` VALUES ('20125215', '苏静怡', '72', '女', '0', '2012', '广西柳州市 市辖区', '广西柳州市 市辖区');
INSERT INTO `t_stu` VALUES ('20125216', '李韩川', '72', '男', '0', '2012', '重庆开县岳溪镇', '重庆开县岳溪镇');
INSERT INTO `t_stu` VALUES ('20125217', '闻豪', '72', '男', '0', '2012', '云南泸西县', '云南泸西县');
INSERT INTO `t_stu` VALUES ('20125218', '李晨', '72', '男', '0', '2012', '天津武清区', '天津武清区');
INSERT INTO `t_stu` VALUES ('20125219', '霍腾', '72', '男', '0', '2012', '山西运城市盐湖区', '山西运城市盐湖区');
INSERT INTO `t_stu` VALUES ('20125220', '王焕斌', '72', '男', '0', '2012', '青海城北区', '青海城北区');
INSERT INTO `t_stu` VALUES ('20125221', '史亚旭', '72', '男', '0', '2012', '内蒙古青山区', '内蒙古青山区');
INSERT INTO `t_stu` VALUES ('20125222', '刘世德', '72', '男', '0', '2012', '江西泰和县', '江西泰和县');
INSERT INTO `t_stu` VALUES ('20125223', '任冠青', '72', '男', '0', '2012', '江苏京口区', '江苏京口区');
INSERT INTO `t_stu` VALUES ('20125224', '张萌', '72', '男', '0', '2012', '吉林德惠市', '吉林德惠市');
INSERT INTO `t_stu` VALUES ('20125225', '黎磊', '72', '男', '0', '2012', '湖南株洲市醴陵市', '湖南株洲市醴陵市');
INSERT INTO `t_stu` VALUES ('20125226', '盛敏', '72', '男', '0', '2012', '湖南永州市零陵区', '湖南永州市零陵区');
INSERT INTO `t_stu` VALUES ('20125227', '陈志军', '72', '男', '0', '2012', '湖南益阳市沅江市', '湖南益阳市沅江市');
INSERT INTO `t_stu` VALUES ('20125228', '何嘉伟', '72', '男', '0', '2012', '湖南益阳市赫山区', '湖南益阳市赫山区');
INSERT INTO `t_stu` VALUES ('20125229', '李俊华', '72', '男', '0', '2012', '湖南湘潭市湘潭县', '湖南湘潭市湘潭县');
INSERT INTO `t_stu` VALUES ('20125230', '周胜乐', '72', '男', '0', '2012', '湖南邵阳市邵阳县', '湖南邵阳市邵阳县');
INSERT INTO `t_stu` VALUES ('20125231', '罗彪', '72', '男', '0', '2012', '湖南娄底市新化县', '湖南娄底市新化县');
INSERT INTO `t_stu` VALUES ('20125232', '吴洪念', '72', '男', '0', '2012', '湖南娄底市涟源市', '湖南娄底市涟源市');
INSERT INTO `t_stu` VALUES ('20125233', '魏鹏', '72', '男', '0', '2012', '湖南衡阳市衡阳市区', '湖南衡阳市衡阳市区');
INSERT INTO `t_stu` VALUES ('20125234', '涂磊', '72', '男', '0', '2012', '湖南常德市汉寿县', '湖南常德市汉寿县');
INSERT INTO `t_stu` VALUES ('20125235', '胡文超', '72', '男', '0', '2012', '湖南长沙市长沙县', '湖南长沙市长沙县');
INSERT INTO `t_stu` VALUES ('20125236', '刘漫琪', '72', '女', '0', '2012', '陕西武功县', '陕西武功县');
INSERT INTO `t_stu` VALUES ('20125237', '张子豪', '72', '男', '0', '2012', '黑龙江伊春区', '黑龙江伊春区');
INSERT INTO `t_stu` VALUES ('20125238', '付艳', '72', '女', '0', '2012', '江西章贡区', '江西章贡区');
INSERT INTO `t_stu` VALUES ('20125239', '回繁宁', '72', '男', '0', '2012', '河北衡水市枣强县', '河北衡水市枣强县');
INSERT INTO `t_stu` VALUES ('20125240', '宋盈', '72', '女', '0', '2012', '湖南岳阳市岳阳市区', '湖南岳阳市岳阳市区');
INSERT INTO `t_stu` VALUES ('20125241', '陶兴', '72', '男', '0', '2012', '贵州普定县', '贵州普定县');
INSERT INTO `t_stu` VALUES ('20125242', '朱冰丽', '72', '女', '0', '2012', '湖南永州市江华县', '湖南永州市江华县');
INSERT INTO `t_stu` VALUES ('20125243', '朱麒霖', '72', '男', '0', '2012', '广西柳州市 市辖区', '广西柳州市 市辖区');
INSERT INTO `t_stu` VALUES ('20125244', '杨夕', '72', '女', '0', '2012', '湖南湘潭市湘潭县', '湖南湘潭市湘潭县');
INSERT INTO `t_stu` VALUES ('20125245', '杨万', '72', '男', '0', '2012', '甘肃会宁县', '甘肃会宁县');
INSERT INTO `t_stu` VALUES ('20125246', '申媛媛', '72', '女', '0', '2012', '湖南邵阳市洞口县', '湖南邵阳市洞口县');
INSERT INTO `t_stu` VALUES ('20125247', '王嘉豪', '72', '男', '0', '2012', '北京东城区', '北京东城区');
INSERT INTO `t_stu` VALUES ('20125248', '郑圣娟', '72', '女', '0', '2012', '湖南怀化市麻阳县', '湖南怀化市麻阳县');
INSERT INTO `t_stu` VALUES ('20125249', '胡佳杰', '72', '男', '0', '2012', '北京海淀区', '北京海淀区');
INSERT INTO `t_stu` VALUES ('20125250', '梁青', '72', '女', '0', '2012', '湖南衡阳市衡阳县', '湖南衡阳市衡阳县');
INSERT INTO `t_stu` VALUES ('20125251', '张秋茜', '72', '女', '0', '2012', '湖南常德市澧县', '湖南常德市澧县');
INSERT INTO `t_stu` VALUES ('20125252', '张安琪', '72', '女', '0', '2012', '湖南长沙市雨花区', '湖南长沙市雨花区');
INSERT INTO `t_stu` VALUES ('20125253', '朱蒙蒙', '72', '女', '0', '2012', '河南周口市太康县', '河南周口市太康县');
INSERT INTO `t_stu` VALUES ('20125254', '苏静怡', '72', '女', '0', '2012', '广西柳州市 市辖区', '广西柳州市 市辖区');
INSERT INTO `t_stu` VALUES ('20125255', '李韩川', '72', '男', '0', '2012', '重庆开县岳溪镇', '重庆开县岳溪镇');
INSERT INTO `t_stu` VALUES ('20125256', '闻豪', '72', '男', '0', '2012', '云南泸西县', '云南泸西县');
INSERT INTO `t_stu` VALUES ('20125257', '李晨', '72', '男', '0', '2012', '天津武清区', '天津武清区');
INSERT INTO `t_stu` VALUES ('20125258', '霍腾', '72', '男', '0', '2012', '山西运城市盐湖区', '山西运城市盐湖区');
INSERT INTO `t_stu` VALUES ('20125259', '王焕斌', '72', '男', '0', '2012', '青海城北区', '青海城北区');
INSERT INTO `t_stu` VALUES ('20125260', '史亚旭', '72', '男', '0', '2012', '内蒙古青山区', '内蒙古青山区');
INSERT INTO `t_stu` VALUES ('20125261', '刘世德', '72', '男', '0', '2012', '江西泰和县', '江西泰和县');
INSERT INTO `t_stu` VALUES ('20125262', '任冠青', '72', '男', '0', '2012', '江苏京口区', '江苏京口区');
INSERT INTO `t_stu` VALUES ('20125263', '张萌', '72', '男', '0', '2012', '吉林德惠市', '吉林德惠市');
INSERT INTO `t_stu` VALUES ('20125264', '黎磊', '72', '男', '0', '2012', '湖南株洲市醴陵市', '湖南株洲市醴陵市');
INSERT INTO `t_stu` VALUES ('20125265', '盛敏', '72', '男', '0', '2012', '湖南永州市零陵区', '湖南永州市零陵区');
INSERT INTO `t_stu` VALUES ('20125266', '陈志军', '72', '男', '0', '2012', '湖南益阳市沅江市', '湖南益阳市沅江市');
INSERT INTO `t_stu` VALUES ('20125267', '何嘉伟', '72', '男', '0', '2012', '湖南益阳市赫山区', '湖南益阳市赫山区');
INSERT INTO `t_stu` VALUES ('20125268', '李俊华', '72', '男', '0', '2012', '湖南湘潭市湘潭县', '湖南湘潭市湘潭县');
INSERT INTO `t_stu` VALUES ('20125269', '周胜乐', '72', '男', '0', '2012', '湖南邵阳市邵阳县', '湖南邵阳市邵阳县');
INSERT INTO `t_stu` VALUES ('20125270', '罗彪', '72', '男', '1', '2012', '湖南娄底市新化县', '湖南娄底市新化县');
INSERT INTO `t_stu` VALUES ('20125271', '吴洪念', '72', '男', '0', '2012', '湖南娄底市涟源市', '湖南娄底市涟源市');
INSERT INTO `t_stu` VALUES ('20125272', '魏鹏', '72', '男', '0', '2012', '湖南衡阳市衡阳市区', '湖南衡阳市衡阳市区');
INSERT INTO `t_stu` VALUES ('20125273', '涂磊', '72', '男', '0', '2012', '湖南常德市汉寿县', '湖南常德市汉寿县');
INSERT INTO `t_stu` VALUES ('20125274', '胡文超', '72', '男', '0', '2012', '湖南长沙市长沙县', '湖南长沙市长沙县');
INSERT INTO `t_stu` VALUES ('20125275', '张子豪', '72', '男', '0', '2012', '黑龙江伊春区', '黑龙江伊春区');
INSERT INTO `t_stu` VALUES ('20125276', '回繁宁', '72', '男', '0', '2012', '河北衡水市枣强县', '河北衡水市枣强县');
INSERT INTO `t_stu` VALUES ('20125277', '陶兴', '72', '男', '0', '2012', '贵州普定县', '贵州普定县');
INSERT INTO `t_stu` VALUES ('20125278', '朱麒霖', '72', '男', '0', '2012', '广西柳州市 市辖区', '广西柳州市 市辖区');
INSERT INTO `t_stu` VALUES ('20125279', '杨万', '72', '男', '0', '2012', '甘肃会宁县', '甘肃会宁县');
INSERT INTO `t_stu` VALUES ('20125280', '王嘉豪', '72', '男', '0', '2012', '北京东城区', '北京东城区');
INSERT INTO `t_stu` VALUES ('20125281', '胡佳杰', '72', '男', '0', '2012', '北京海淀区', '北京海淀区');
INSERT INTO `t_stu` VALUES ('20125282', '刘漫琪', '73', '女', '0', '2012', '陕西武功县', '陕西武功县');
INSERT INTO `t_stu` VALUES ('20125283', '付艳', '73', '女', '0', '2012', '江西章贡区', '江西章贡区');
INSERT INTO `t_stu` VALUES ('20125284', '宋盈', '73', '女', '0', '2012', '湖南岳阳市岳阳市区', '湖南岳阳市岳阳市区');
INSERT INTO `t_stu` VALUES ('20125285', '朱冰丽', '73', '女', '0', '2012', '湖南永州市江华县', '湖南永州市江华县');
INSERT INTO `t_stu` VALUES ('20125286', '杨夕', '73', '女', '0', '2012', '湖南湘潭市湘潭县', '湖南湘潭市湘潭县');
INSERT INTO `t_stu` VALUES ('20125287', '申媛媛', '73', '女', '0', '2012', '湖南邵阳市洞口县', '湖南邵阳市洞口县');
INSERT INTO `t_stu` VALUES ('20125288', '郑圣娟', '73', '女', '0', '2012', '湖南怀化市麻阳县', '湖南怀化市麻阳县');
INSERT INTO `t_stu` VALUES ('20125289', '梁青', '73', '女', '0', '2012', '湖南衡阳市衡阳县', '湖南衡阳市衡阳县');
INSERT INTO `t_stu` VALUES ('20125290', '张秋茜', '73', '女', '0', '2012', '湖南常德市澧县', '湖南常德市澧县');
INSERT INTO `t_stu` VALUES ('20125291', '张安琪', '73', '女', '0', '2012', '湖南长沙市雨花区', '湖南长沙市雨花区');
INSERT INTO `t_stu` VALUES ('20125292', '朱蒙蒙', '73', '女', '0', '2012', '河南周口市太康县', '河南周口市太康县');
INSERT INTO `t_stu` VALUES ('20125293', '苏静怡', '73', '女', '0', '2012', '广西柳州市 市辖区', '广西柳州市 市辖区');
INSERT INTO `t_stu` VALUES ('20125294', '李韩川', '73', '男', '0', '2012', '重庆开县岳溪镇', '重庆开县岳溪镇');
INSERT INTO `t_stu` VALUES ('20125295', '闻豪', '73', '男', '0', '2012', '云南泸西县', '云南泸西县');
INSERT INTO `t_stu` VALUES ('20125296', '李晨', '73', '男', '0', '2012', '天津武清区', '天津武清区');
INSERT INTO `t_stu` VALUES ('20125297', '霍腾', '73', '男', '0', '2012', '山西运城市盐湖区', '山西运城市盐湖区');
INSERT INTO `t_stu` VALUES ('20125298', '王焕斌', '73', '男', '0', '2012', '青海城北区', '青海城北区');
INSERT INTO `t_stu` VALUES ('20125299', '史亚旭', '73', '男', '0', '2012', '内蒙古青山区', '内蒙古青山区');
INSERT INTO `t_stu` VALUES ('20125300', '刘世德', '73', '男', '0', '2012', '江西泰和县', '江西泰和县');
INSERT INTO `t_stu` VALUES ('20125301', '任冠青', '73', '男', '0', '2012', '江苏京口区', '江苏京口区');
INSERT INTO `t_stu` VALUES ('20125302', '张萌', '73', '男', '0', '2012', '吉林德惠市', '吉林德惠市');
INSERT INTO `t_stu` VALUES ('20125303', '黎磊', '73', '男', '0', '2012', '湖南株洲市醴陵市', '湖南株洲市醴陵市');
INSERT INTO `t_stu` VALUES ('20125304', '盛敏', '73', '男', '0', '2012', '湖南永州市零陵区', '湖南永州市零陵区');
INSERT INTO `t_stu` VALUES ('20125305', '陈志军', '73', '男', '0', '2012', '湖南益阳市沅江市', '湖南益阳市沅江市');
INSERT INTO `t_stu` VALUES ('20125306', '何嘉伟', '73', '男', '0', '2012', '湖南益阳市赫山区', '湖南益阳市赫山区');
INSERT INTO `t_stu` VALUES ('20125307', '李俊华', '73', '男', '0', '2012', '湖南湘潭市湘潭县', '湖南湘潭市湘潭县');
INSERT INTO `t_stu` VALUES ('20125308', '周胜乐', '73', '男', '0', '2012', '湖南邵阳市邵阳县', '湖南邵阳市邵阳县');
INSERT INTO `t_stu` VALUES ('20125309', '罗彪', '73', '男', '0', '2012', '湖南娄底市新化县', '湖南娄底市新化县');
INSERT INTO `t_stu` VALUES ('20125310', '吴洪念', '73', '男', '0', '2012', '湖南娄底市涟源市', '湖南娄底市涟源市');
INSERT INTO `t_stu` VALUES ('20125311', '魏鹏', '73', '男', '0', '2012', '湖南衡阳市衡阳市区', '湖南衡阳市衡阳市区');
INSERT INTO `t_stu` VALUES ('20125312', '涂磊', '73', '男', '0', '2012', '湖南常德市汉寿县', '湖南常德市汉寿县');
INSERT INTO `t_stu` VALUES ('20125313', '胡文超', '73', '男', '0', '2012', '湖南长沙市长沙县', '湖南长沙市长沙县');
INSERT INTO `t_stu` VALUES ('20125314', '张子豪', '73', '男', '0', '2012', '黑龙江伊春区', '黑龙江伊春区');
INSERT INTO `t_stu` VALUES ('20125315', '回繁宁', '73', '男', '0', '2012', '河北衡水市枣强县', '河北衡水市枣强县');
INSERT INTO `t_stu` VALUES ('20125316', '陶兴', '73', '男', '0', '2012', '贵州普定县', '贵州普定县');
INSERT INTO `t_stu` VALUES ('20125317', '朱麒霖', '73', '男', '0', '2012', '广西柳州市 市辖区', '广西柳州市 市辖区');
INSERT INTO `t_stu` VALUES ('20125318', '杨万', '73', '男', '0', '2012', '甘肃会宁县', '甘肃会宁县');
INSERT INTO `t_stu` VALUES ('20125319', '王嘉豪', '73', '男', '0', '2012', '北京东城区', '北京东城区');
INSERT INTO `t_stu` VALUES ('20125320', '胡佳杰', '73', '男', '0', '2012', '北京海淀区', '北京海淀区');

-- ----------------------------
-- Table structure for t_subject
-- ----------------------------
DROP TABLE IF EXISTS `t_subject`;
CREATE TABLE `t_subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL COMMENT '科目名称',
  `del` tinyint(4) NOT NULL DEFAULT '0',
  `during` varchar(255) DEFAULT NULL COMMENT '上课时间',
  `teacher_id` int(11) DEFAULT NULL COMMENT '教师id',
  `location` varchar(255) DEFAULT NULL,
  `begin_hour` int(11) DEFAULT NULL,
  `begin_min` int(11) DEFAULT NULL,
  `end_hour` int(11) DEFAULT NULL,
  `end_min` int(255) DEFAULT NULL,
  `weekday` char(2) DEFAULT NULL,
  `period` varchar(255) DEFAULT NULL COMMENT '上午或者下午',
  `part` varchar(255) DEFAULT NULL COMMENT '1-2节，3-4节',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_subject
-- ----------------------------
INSERT INTO `t_subject` VALUES ('15', '组合数学', '0', null, '4', 'B楼', '8', '0', '8', '45', '周三', null, '三四节');
INSERT INTO `t_subject` VALUES ('28', 'c语言', '0', null, '11', '宗教A102', '0', '0', '0', '0', '周一', null, '三四节');
INSERT INTO `t_subject` VALUES ('29', '大学体育', '0', null, '13', '田径场', '0', '0', '0', '0', '周一', null, '五六节');
INSERT INTO `t_subject` VALUES ('30', '大学英语', '0', null, '14', '宗教B403', '0', '0', '0', '0', '周一', null, '七八节');
INSERT INTO `t_subject` VALUES ('31', '马克思主义', '0', null, '15', '宗教B301', '0', '0', '0', '0', '周三', null, '七八节');
INSERT INTO `t_subject` VALUES ('32', '高等数学', '0', null, '16', '文科楼A109', '0', '0', '0', '0', '周二', null, '一二节');
INSERT INTO `t_subject` VALUES ('34', '模电', '0', null, '17', 'A', '0', '0', '0', '0', '周三', null, '三四节');
INSERT INTO `t_subject` VALUES ('36', '大学物理', '0', null, '18', '宗教C102', '0', '0', '0', '0', '周三', null, '一二节');
INSERT INTO `t_subject` VALUES ('38', 'XML', '0', null, '19', '理科楼B209', '0', '0', '0', '0', '周四', null, '三四节');
INSERT INTO `t_subject` VALUES ('39', '离散数学', '0', null, '4', '宗教A507', '0', '0', '0', '0', '周五', null, '三四节');
INSERT INTO `t_subject` VALUES ('40', '线性代数', '0', null, '4', '理科楼A107', '0', '0', '0', '0', '周四', null, '七八节');

-- ----------------------------
-- Table structure for t_test
-- ----------------------------
DROP TABLE IF EXISTS `t_test`;
CREATE TABLE `t_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_name` varchar(45) DEFAULT NULL COMMENT '考试名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `date` date DEFAULT NULL COMMENT '考试日期',
  `del` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_test
-- ----------------------------

-- ----------------------------
-- Table structure for t_test_subject
-- ----------------------------
DROP TABLE IF EXISTS `t_test_subject`;
CREATE TABLE `t_test_subject` (
  `subject_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `start_time` datetime DEFAULT NULL COMMENT '科目开始时间，精确到分',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `full_mark` float NOT NULL DEFAULT '100',
  `del` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`subject_id`,`test_id`),
  KEY `fk_t_subject_has_t_test_t_test1_idx` (`test_id`) USING BTREE,
  KEY `fk_t_subject_has_t_test_t_subject1_idx` (`subject_id`) USING BTREE,
  CONSTRAINT `fk_t_subject_has_t_test_t_subject1` FOREIGN KEY (`subject_id`) REFERENCES `t_subject` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_subject_has_t_test_t_test1` FOREIGN KEY (`test_id`) REFERENCES `t_test` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_test_subject
-- ----------------------------

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `sex` char(1) NOT NULL DEFAULT '男',
  `level` tinyint(4) NOT NULL DEFAULT '4',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('4', 'admin1', '111', '13777777777', 'dsa@dsa.hfd12', '男', '4');
INSERT INTO `t_user` VALUES ('6', 'admin', '111', '13688889999', 'dsa@daa.cad', '男', '1');
INSERT INTO `t_user` VALUES ('8', '邓雷', '111', '15352968963', '123@qq.com', '男', '4');
INSERT INTO `t_user` VALUES ('9', 'danny', '666666', '18352861236', '123@qq.com', '男', '3');
INSERT INTO `t_user` VALUES ('10', '', '666666', '', '', '男', '3');
INSERT INTO `t_user` VALUES ('11', '肖晓丽', '666666', '15576889876', '1546789887', '女', '4');
INSERT INTO `t_user` VALUES ('12', '陈倩怡', '666666', '15576889855', '1546789855', '女', '4');
INSERT INTO `t_user` VALUES ('13', '尹天仇', '666666', '14454667890', '1234323432', '男', '4');
INSERT INTO `t_user` VALUES ('14', '王丽萍', '666666', '14454667822', '1234322222', '女', '4');
INSERT INTO `t_user` VALUES ('15', '王丽', '666666', '15543438989', '31132@qq', '男', '4');
INSERT INTO `t_user` VALUES ('16', '刘劲波', '666666', '15543418989', '31132@qq', '男', '4');
INSERT INTO `t_user` VALUES ('17', '廖太常', '666666', '15543898989', '3113da2@qq', '男', '4');
INSERT INTO `t_user` VALUES ('18', '刘凡', '666666', '13389765430', '121242@qq', '男', '4');
INSERT INTO `t_user` VALUES ('19', '黄媛圆', '666666', '13329765430', '1211242@qq', '男', '4');
