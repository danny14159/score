package shixi.module;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.lang.Files;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import shixi.bean.Analysis;
import shixi.bean.AnalysisSet;
import shixi.dao.ClassDao;
import shixi.dao.ClassSubjectDao;
import shixi.dao.ScoreDao;
import shixi.dao.ScoreStatDao;
import shixi.dao.StudentDao;
import shixi.dao.SubjectDao;
import shixi.dao.TestDao;
import shixi.bean.Class;
import shixi.service.ScoreAnalysisService;

@IocBean
@At("/writeExcel")
public class WriteExcel {
	@Inject
	private StudentDao studentDao;
	@Inject
	private ClassDao classDao;
	@Inject
	private ScoreDao scoreDao;
	@Inject
	private TestDao testDao;
	@Inject
	private SubjectDao subjectDao;

	@Inject
	private ClassSubjectDao classSubjectDao;

	@Inject
	private ScoreStatDao scoreStatDao;

	@Inject
	private ScoreAnalysisService scoreAnalysisServiceImpl;

	/**
	 * 将某班级学生信息写入excel表并导出
	 * 
	 * @param class_id
	 * @param studentItem
	 * @return 某班级的学生信息excel表
	 * @throws IOException
	 */
	@At("/getStudentExcel")
	@Ok("raw")
	public File getStudentExcel(@Param("class_id") Integer class_id,
			@Param("studentItem") String[] studentItem) throws IOException {
		String fileName = null;
		fileName = classDao.fetch(class_id).getName() + "学生信息" + ".xls";
		HSSFWorkbook workbook = new HSSFWorkbook();

		HSSFSheet sheet = workbook.createSheet("表一");
		HSSFRow row = sheet.createRow(0);
		HSSFCellStyle cell_Style = workbook.createCellStyle();// 设置字体样式
		cell_Style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		for (int i = 0; i < studentItem.length; i++) {
			HSSFCell cell = row.createCell(i);
			cell.setCellStyle(cell_Style);
			cell.setCellValue(studentItem[i]);
		}
		for (int x = 0; x < studentDao.queryByClass(class_id).size(); x++) {

			row = sheet.createRow(x + 1);

			HSSFCell cell0 = row.createCell(0);
			cell0.setCellStyle(cell_Style);
			cell0.setCellValue(studentDao.queryByClass(class_id).get(x).getId());
			HSSFCell cell1 = row.createCell(1);
			cell1.setCellStyle(cell_Style);
			cell1.setCellValue(studentDao.queryByClass(class_id).get(x)
					.getName());
			String sex = null;

			HSSFCell cell2 = row.createCell(2);
			cell2.setCellStyle(cell_Style);
			if ("男".equals(String.valueOf(studentDao.queryByClass(class_id)
					.get(x).getSex()))) {
				sex = "男";

				cell2.setCellValue(sex);
			} else {
				sex = "女";
				cell2.setCellValue(sex);
			}

		}
		File excelfile = Files.createFileIfNoExists(fileName);
		FileOutputStream fileout = new FileOutputStream(excelfile);

		try {
			fileout.flush();
			workbook.write(fileout);

			fileout.close();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("Output   is   closed ");
		}
		return excelfile;
	}

	/**
	 * 将某班级学生成绩信息写入excel表并导出
	 * 
	 * @param class_id
	 * @param test_id
	 * @return 某班级的学生成绩信息excel表
	 * @throws IOException
	 */
	@At("/getClassScoreExcel")
	@Ok("raw")
	public File getClassScoreExcel(@Param("class_id") Integer class_id,
			@Param("test_id") Integer test_id) throws IOException {
		String fileName = null;
		fileName = classDao.fetch(class_id).getName() + "成绩信息" + ".xls";
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet("表一");
		HSSFRow row = sheet.createRow(0);
		HSSFCellStyle cell_Style = workbook.createCellStyle();// 设置字体样式
		cell_Style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		// 从第一行第一个单元格开始填充学生属性
		HSSFCell cell0 = row.createCell(0);
		cell0.setCellStyle(cell_Style);
		cell0.setCellValue("学号");

		HSSFCell cell1 = row.createCell(1);
		cell1.setCellStyle(cell_Style);
		cell1.setCellValue("姓名");
		// 从第一行第三个单元哥开始，将数据库中根据考试id查询出的考试科目填充进去，直到将所有考试科目填充完毕为止
		for (int i = 0; i < testDao.querysubject(test_id).size(); i++) {
			HSSFCell cell = row.createCell(i + 2);
			cell.setCellStyle(cell_Style);
			cell.setCellValue(testDao.querysubject(test_id).get(i).getName());
		}
		// 第一行考试科目填充完毕之后，在其后开始填充其余头信息
		int count = testDao.querysubject(test_id).size() + 2;
		HSSFCell cellcount1 = row.createCell(count);
		cellcount1.setCellStyle(cell_Style);
		cellcount1.setCellValue("总分");
		HSSFCell cellcount2 = row.createCell(count + 1);
		cellcount2.setCellStyle(cell_Style);
		cellcount2.setCellValue("班级排名");
		HSSFCell cellcount3 = row.createCell(count + 2);
		cellcount3.setCellStyle(cell_Style);
		cellcount3.setCellValue("年级排名");
		// 从第二行开始，向单元格内填充数据
		for (int i = 0; i < studentDao.queryByClass(class_id).size(); i++) {
			HSSFRow row1 = sheet.createRow(i + 1);
			HSSFCell cell0OfRow1 = row1.createCell(0);
			cell0OfRow1.setCellStyle(cell_Style);
			cell0OfRow1.setCellValue(studentDao.queryByClass(class_id).get(i)
					.getId());
			HSSFCell cell1OfRow1 = row1.createCell(1);
			cell1OfRow1.setCellStyle(cell_Style);
			cell1OfRow1.setCellValue(studentDao.queryByClass(class_id).get(i)
					.getName());
			for (int j = 0; j < testDao.querysubject(test_id).size(); j++) {
				HSSFCell cell2OfRow1 = row1.createCell(j + 2);
				cell2OfRow1.setCellStyle(cell_Style);
				cell2OfRow1.setCellValue(scoreDao.queryById1(studentDao
						.queryByClass(class_id).get(i).getId(), test_id,
						testDao.querysubject(test_id).get(j).getId()));
			}
			int count1 = testDao.querysubject(test_id).size() + 2;
			HSSFCell cell3OfRow1 = row1.createCell(count1);
			cell3OfRow1.setCellStyle(cell_Style);
			cell3OfRow1.setCellValue(scoreDao.querySum(
					studentDao.queryByClass(class_id).get(i).getId(), test_id));
			HSSFCell cell4OfRow1 = row1.createCell(count1 + 1);
			cell4OfRow1.setCellStyle(cell_Style);
			cell4OfRow1.setCellValue((scoreStatDao.queryByClass(class_id,
					test_id)).get(i).getClass_order());
			HSSFCell cell5OfRow1 = row1.createCell(count1 + 2);
			cell5OfRow1.setCellStyle(cell_Style);
			cell5OfRow1.setCellValue((scoreStatDao.queryByClass(class_id,
					test_id)).get(i).getSchool_order());
		}
		File excelfile = Files.createFileIfNoExists(fileName);
		FileOutputStream fileout = new FileOutputStream(excelfile);

		try {
			fileout.flush();
			workbook.write(fileout);

			fileout.close();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("Output   is   closed ");
		}
		return excelfile;
	}

	/**
	 * 将某年级学生成绩信息写入excel表并导出(分为多个sheet)
	 * 
	 * @param at_grade
	 * @param test_id
	 * @return 某年级学生成绩信息excel表
	 * @throws IOException
	 */
	@At("/getSchoolScoreExcel")
	@Ok("raw")
	public File getSchoolScoreExcel(@Param("at_grade") Integer at_grade,
			@Param("test_id") Integer test_id) throws IOException {
		String fileName = null;
		fileName = at_grade + "年级成绩信息" + ".xls";
		HSSFWorkbook workbook = new HSSFWorkbook();
		List<shixi.bean.Class> list = classDao.query(at_grade);
		for (int i = 0; i < list.size(); i++) {
			HSSFSheet sheet = workbook.createSheet(list.get(i).getName());
			HSSFRow row = sheet.createRow(0);

			HSSFCellStyle cell_Style = workbook.createCellStyle();

			cell_Style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			HSSFCell cell0 = row.createCell(0);
			cell0.setCellStyle(cell_Style);
			cell0.setCellValue("学号");

			HSSFCell cell1 = row.createCell(1);
			cell1.setCellStyle(cell_Style);
			cell1.setCellValue("姓名");

			for (int j = 0; j < testDao.querysubject(test_id).size(); j++) {
				HSSFCell cell = row.createCell(j + 2);
				cell.setCellStyle(cell_Style);
				cell.setCellValue(testDao.querysubject(test_id).get(j)
						.getName());
			}
			int count = testDao.querysubject(test_id).size() + 2;
			HSSFCell cellcount1 = row.createCell(count);
			cellcount1.setCellStyle(cell_Style);
			cellcount1.setCellValue("总分");
			HSSFCell cellcount2 = row.createCell(count + 1);
			cellcount2.setCellStyle(cell_Style);
			cellcount2.setCellValue("班级排名");
			HSSFCell cellcount3 = row.createCell(count + 2);
			cellcount2.setCellStyle(cell_Style);
			cellcount3.setCellValue("年级排名");

			for (int j = 0; j < studentDao.queryByClass(list.get(i).getId())
					.size(); j++) {
				HSSFRow row1 = sheet.createRow(j + 1);
				HSSFCell cell0OfRow = row1.createCell(0);
				cell0OfRow.setCellStyle(cell_Style);
				cell0OfRow.setCellValue(studentDao
						.queryByClass(list.get(i).getId()).get(j).getId());
				HSSFCell cell1OfRow = row1.createCell(1);
				cell1OfRow.setCellStyle(cell_Style);
				cell1OfRow.setCellValue(studentDao
						.queryByClass(list.get(i).getId()).get(j).getName());
				for (int x = 0; x < testDao.querysubject(test_id).size(); x++) {
					HSSFCell cell2OfRow = row1.createCell(x + 2);
					cell2OfRow.setCellStyle(cell_Style);
					cell2OfRow.setCellValue(scoreDao.queryById1(studentDao
							.queryByClass(list.get(i).getId()).get(j).getId(),
							test_id, testDao.querysubject(test_id).get(x)
									.getId()));
				}
				int count1 = testDao.querysubject(test_id).size() + 2;
				HSSFCell cell3OfRow = row1.createCell(count1);
				cell3OfRow.setCellStyle(cell_Style);
				cell3OfRow.setCellValue(scoreDao.querySum(studentDao
						.queryByClass(list.get(i).getId()).get(j).getId(),
						test_id));
				HSSFCell cell4OfRow = row1.createCell(count1 + 1);
				cell4OfRow.setCellStyle(cell_Style);
				cell4OfRow.setCellValue((scoreStatDao.queryByClass(list.get(i).getId(),
						test_id)).get(j).getClass_order());
				HSSFCell cell5OfRow = row1.createCell(count1 + 2);
				cell5OfRow.setCellStyle(cell_Style);
				cell5OfRow.setCellValue((scoreStatDao.queryByClass(list.get(i).getId(),
						test_id)).get(j).getSchool_order());
			}
		}
		File excelfile = Files.createFileIfNoExists(fileName);
		FileOutputStream fileout = new FileOutputStream(excelfile);

		try {
			fileout.flush();
			workbook.write(fileout);

			fileout.close();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("Output   is   closed ");
		}
		return excelfile;
	}

	/**
	 * 将某班学生成绩统计结果信息写入excel表并导出
	 * 
	 * @param analysisSet
	 * @param class_id
	 * @param test_id
	 * @return 某班学生成绩统计结果excel表
	 * @throws IOException
	 */
	@At("/getScoreAnalysisExcel")
	@Ok("raw")
	public File getScoreAnalysisExcel(
			@Param("analysisSet") AnalysisSet analysisSet,
			@Param("class_id") Integer class_id,
			@Param("test_id") Integer test_id,
			@Param("classTopx") Integer classTopx,
			@Param("schoolTopx") Integer schoolTopx) throws IOException {
		AnalysisSet analysisSet2 = scoreAnalysisServiceImpl.analyse(
				analysisSet, class_id, test_id, classTopx, schoolTopx);
		String fileName = null;
		fileName = classDao.fetch(class_id).getName() + "学生成绩统计信息" + ".xls";
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFCellStyle cell_Style = workbook.createCellStyle();// 设置字体样式
		cell_Style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		// 创建表一
		HSSFSheet sheet0 = workbook.createSheet("班级整体情况");
		workbook.setSheetName(0, "班级整体情况");

		HSSFRow row0 = sheet0.createRow(0);
		// 合并第一行前四个单元格
		sheet0.addMergedRegion(new Region(0, (short) 0, 0, (short) 3));
		// 设置第一行数据并居中
		HSSFCell cellTop1 = row0.createCell(0);
		cellTop1.setCellStyle(cell_Style);
		cellTop1.setCellValue("班级整体情况");
		// 设置第二行数据
		HSSFRow row1 = sheet0.createRow(1);
		HSSFCell cell0 = row1.createCell(0);
		sheet0.autoSizeColumn((short) 0); // 调整第一列宽度
		cell0.setCellStyle(cell_Style);
		cell0.setCellValue("学科");
		HSSFCell cell1 = row1.createCell(1);
		cell1.setCellStyle(cell_Style);
		sheet0.autoSizeColumn((short) 1); // 调整第二列宽度
		sheet0.setColumnWidth(1, 6000);
		cell1.setCellValue("优秀率（优秀线以上）");
		HSSFCell cell2 = row1.createCell(2);
		cell2.setCellStyle(cell_Style);
		sheet0.autoSizeColumn((short) 2); // 调整第三列宽度
		sheet0.setColumnWidth(2, 6000);
		cell2.setCellValue("及格率（及格线以上）");
		HSSFCell cell3 = row1.createCell(3);
		cell3.setCellStyle(cell_Style);
		sheet0.autoSizeColumn((short) 3); // 调整第四列宽度
		sheet0.setColumnWidth(3, 6000);
		cell3.setCellValue("差分率（差分线以下）");

		List<Map<String, Object>> rates = analysisSet2.getRates();
		List<String> keyList = new ArrayList<>();
		List<String[]> list2 = new ArrayList<String[]>();

		for (Map<String, Object> map : rates) {
			for (Entry<String, Object> entry : map.entrySet()) {
				NumberFormat nf = NumberFormat.getPercentInstance();
				nf.setMaximumFractionDigits(2);
				float[] f = (float[]) entry.getValue();
				String[] f2 = new String[3];
				f2[0] = nf.format(f[0]);
				f2[1] = nf.format(f[1]);
				f2[2] = nf.format(f[2]);
				keyList.add(entry.getKey());
				list2.add(f2);
			}
		}
		for (int i = 0; i < analysisSet2.getRates().size(); i++) {
			HSSFRow row = sheet0.createRow(i + 2);

			HSSFCell cell = row.createCell(0);
			cell.setCellStyle(cell_Style);
			cell.setCellValue(subjectDao
					.fetch(Integer.parseInt(keyList.get(i))).getName());
			for (int j = 0; j < 3; j++) {
				HSSFCell cellx = row.createCell(j + 1);
				cellx.setCellStyle(cell_Style);
				cellx.setCellValue(list2.get(i)[j]);
			}
		}
		// 创建表二
		HSSFSheet sheet1 = workbook.createSheet("年级前" + schoolTopx + "（共"
				+ analysisSet2.getSchoolTopX().size() + "人）");
		workbook.setSheetName(1, "年级前" + schoolTopx + "（共"
				+ analysisSet2.getSchoolTopX().size() + "人）");
		// 合并第一行前四个单元格
		HSSFRow rowx0 = sheet1.createRow(0);
		sheet1.addMergedRegion(new Region(0, (short) 0, 0, (short) 3));
		// 设置第一行数据并居中
		HSSFCell cellTop2 = rowx0.createCell(0);
		cellTop2.setCellStyle(cell_Style);
		cellTop2.setCellValue("年级前" + schoolTopx + "（共"
				+ analysisSet2.getSchoolTopX().size() + "人）");
		// 设置第二行数据
		HSSFRow rowx1 = sheet1.createRow(1);
		HSSFCell cellx0 = rowx1.createCell(0);
		cellx0.setCellStyle(cell_Style);
		cellx0.setCellValue("学号");
		HSSFCell cellx1 = rowx1.createCell(1);
		cellx1.setCellStyle(cell_Style);
		cellx1.setCellValue("姓名");
		HSSFCell cellx2 = rowx1.createCell(2);
		cellx2.setCellStyle(cell_Style);
		cellx2.setCellValue("总分");
		HSSFCell cellx3 = rowx1.createCell(3);
		cellx3.setCellStyle(cell_Style);
		cellx3.setCellValue("年级排名");

		List<Map<String, Object>> schoolTopX = analysisSet2.getSchoolTopX();
		for (int i = 0; i < schoolTopX.size(); i++) {
			HSSFRow rowy2 = sheet1.createRow(i + 2);
			HSSFCell celly0 = rowy2.createCell(0);
			celly0.setCellStyle(cell_Style);
			celly0.setCellValue(Double.parseDouble(String.valueOf(schoolTopX
					.get(i).get("stu_id"))));
			HSSFCell celly1 = rowy2.createCell(1);
			celly1.setCellStyle(cell_Style);
			celly1.setCellValue((String) schoolTopX.get(i).get("stu_name"));
			HSSFCell celly2 = rowy2.createCell(2);
			celly2.setCellStyle(cell_Style);
			celly2.setCellValue(Double.parseDouble(String.valueOf(schoolTopX
					.get(i).get("total_score"))));
			HSSFCell celly3 = rowy2.createCell(3);
			celly3.setCellStyle(cell_Style);
			celly3.setCellValue(Double.parseDouble(String.valueOf(schoolTopX
					.get(i).get("school_order"))));
		}

		// 创建表三

		HSSFSheet sheet2 = workbook.createSheet("班级前" + classTopx + "（共"
				+ analysisSet2.getClassTopX().size() + "人）");
		workbook.setSheetName(2, "班级前" + classTopx + "（共"
				+ analysisSet2.getClassTopX().size() + "人）");
		// 合并第一行前四个单元格
		HSSFRow rowm0 = sheet2.createRow(0);
		sheet2.addMergedRegion(new Region(0, (short) 0, 0, (short) 3));
		// 设置第一行数据并居中
		HSSFCell cellTop3 = rowm0.createCell(0);
		cellTop3.setCellStyle(cell_Style);
		cellTop3.setCellValue("班级前" + classTopx + "（共"
				+ analysisSet2.getClassTopX().size() + "人）");
		// 设置第二行数据
		HSSFRow rowm1 = sheet2.createRow(1);
		HSSFCell cellm0 = rowm1.createCell(0);
		cellm0.setCellStyle(cell_Style);
		cellm0.setCellValue("学号");
		HSSFCell cellm1 = rowm1.createCell(1);
		cellm1.setCellStyle(cell_Style);
		cellm1.setCellValue("姓名");
		HSSFCell cellm2 = rowm1.createCell(2);
		cellm2.setCellStyle(cell_Style);
		cellm2.setCellValue("总分");
		HSSFCell cellm3 = rowm1.createCell(3);
		cellm3.setCellStyle(cell_Style);
		cellm3.setCellValue("班级排名");

		List<Map<String, Object>> classTopX = analysisSet2.getClassTopX();
		for (int i = 0; i < classTopX.size(); i++) {
			HSSFRow rowy2 = sheet2.createRow(i + 2);
			HSSFCell celly0 = rowy2.createCell(0);
			celly0.setCellStyle(cell_Style);
			celly0.setCellValue(Double.parseDouble(String.valueOf(classTopX
					.get(i).get("stu_id"))));
			HSSFCell celly1 = rowy2.createCell(1);
			celly1.setCellStyle(cell_Style);
			celly1.setCellValue((String) classTopX.get(i).get("stu_name"));
			HSSFCell celly2 = rowy2.createCell(2);
			celly2.setCellStyle(cell_Style);
			celly2.setCellValue(Double.parseDouble(String.valueOf(classTopX
					.get(i).get("total_score"))));
			HSSFCell celly3 = rowy2.createCell(3);
			celly3.setCellStyle(cell_Style);
			celly3.setCellValue(Double.parseDouble(String.valueOf(classTopX
					.get(i).get("class_order"))));
		}
		File excelfile = Files.createFileIfNoExists(fileName);
		//     新建一输出文件流
		FileOutputStream fileout = new FileOutputStream(excelfile);

		try {
			// 把相应的Excel 工作簿存盘
			workbook.write(fileout);
			fileout.flush();
			// 操作结束，关闭文件
			fileout.close();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("Output   is   closed ");
		}
		return excelfile;
	}

	/*
	 * 导出年级统计信息
	 */
	/**
	 * 导出各班Excel
	 * @param analysis
	 * @return
	 * @throws IOException 
	 */
	@At("/getAllClassesAnalysis")
	@Ok("raw")
	public File getAnalysisResultOfAllClasses(@Param("param") Analysis analysis) throws IOException{
		
		 Map<Integer,Object> result = scoreAnalysisServiceImpl.getAllClassesAnalysis(analysis.getTest_id()
				, analysis.getAt_grade(), analysis.getTopx(), analysis.getLines());
		int grade = analysis.getAt_grade();
//		Integer[] topx =  new Integer[]{10,20,50,100};
		Integer[] topx = analysis.getTopx();
//		int grade = 7;
//		 Map<String, Object> maps[] = new  HashMap[3];
//		maps[0] = new HashMap<>();
//		ArrayList<String> list = new ArrayList<>();
//		list.add("90");
//		list.add("60");
//		list.add("30");
//		 maps[0].put("1", list);
//		 maps[1] = new HashMap<>();
//		 maps[1].put("2", list);
//		 maps[2] = new HashMap<>();
//		 maps[2].put("3", list);
//		Map<Integer,Object> result = scoreAnalysisServiceImpl.getAllClassesAnalysis((Integer)1
//					, (Integer)7, topx, maps );
		//Excel操作
		String fileName = null;
		fileName = "各班学生成绩分析信息" + ".xls";
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFCellStyle cell_Style = workbook.createCellStyle();// 设置字体样式
		cell_Style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		// 创建表一
		
		List<Class> classes = classDao.query(grade);
		
		for(int i = 0;i<classes.size();i++){
			String class_name = classes.get(i).getName();
			HSSFSheet sheet0 = workbook.createSheet(class_name+"分析结果");
			workbook.setSheetName(i, class_name+"分析结果");
		
			HSSFRow row0 = sheet0.createRow(0);
			// 合并第一行前四个单元格
			sheet0.addMergedRegion(new Region(0, (short) 0, 0, (short) 7));
			
			// 设置第一行数据并居中
			HSSFCell cellTop1 = row0.createCell(0);
			cellTop1.setCellStyle(cell_Style);
			cellTop1.setCellValue(class_name+"成绩分析表");
			// 设置第二行数据
			HSSFRow row1 = sheet0.createRow(1);
			HSSFCell cell0 = row1.createCell(0);
			sheet0.autoSizeColumn((short) 0); // 调整第一列宽度
			cell0.setCellStyle(cell_Style);
			sheet0.setColumnWidth(0, 6000);
			cell0.setCellValue("学科");
			HSSFCell cell1 = row1.createCell(1);
			cell1.setCellStyle(cell_Style);
			sheet0.autoSizeColumn((short) 1); // 调整第二列宽度
			sheet0.setColumnWidth(1, 6000);
			cell1.setCellValue("优秀率（优秀线以上）");
			// 调整第三列宽度
			HSSFCell cell2 = row1.createCell(2);
			cell2.setCellStyle(cell_Style);
			sheet0.autoSizeColumn((short) 2); 
			sheet0.setColumnWidth(2, 6000);
			cell2.setCellValue("优秀人数");
			// 调整第四列宽度
			HSSFCell cell3 = row1.createCell(3);
			cell3.setCellStyle(cell_Style);
			sheet0.autoSizeColumn((short) 3); 
			sheet0.setColumnWidth(3, 6000);
			cell3.setCellValue("及格率（及格线以上）");
			
			HSSFCell cell4 = row1.createCell(4);
			cell4.setCellStyle(cell_Style);
			sheet0.autoSizeColumn(4);
			sheet0.setColumnWidth(4, 6000);
			cell4.setCellValue("及格人数");
			
			HSSFCell cell5 = row1.createCell(5);
			cell5.setCellStyle(cell_Style);
			sheet0.autoSizeColumn(5);
			sheet0.setColumnWidth(5, 6000);
			cell5.setCellValue("差分率（差分线以下）");
			
			HSSFCell cell6 = row1.createCell(6);
			cell6.setCellStyle(cell_Style);
			sheet0.autoSizeColumn(6);
			sheet0.setColumnWidth(6, 6000);
			cell6.setCellValue("差分人数");
			
			HSSFCell cell7 = row1.createCell(7);
			cell7.setCellStyle(cell_Style);
			sheet0.autoSizeColumn(7);
			sheet0.setColumnWidth(7, 6000);
			cell7.setCellValue("平均分");
			
			String[][] ss = (String[][]) ((Map<String,Object>)result
					.get(classes.get(i).getId())).get("TableRateRecord");
			
			for(int j = 0;j<ss.length;j++){
				HSSFRow rowx = sheet0.createRow(j+2);
				for(int k = 0;k<ss[j].length;k++){
					HSSFCell cellx = rowx.createCell(k);
					cellx.setCellValue(ss[j][k]);
				}
				
			}
			
			Integer[] rank = (Integer[]) ((Map<String,Object>)result
					.get(classes.get(i).getId())).get("TableTopRecord");
			
			
			int part2_start = 2+ss.length+1;
			HSSFRow rown = sheet0.createRow(part2_start);
			
			sheet0.addMergedRegion(new Region(part2_start,(short)0, part2_start, (short)7));
						
			// 设置第一行数据并居中
			HSSFCell cellTop2 = rown.createCell(0);
			cellTop2.setCellStyle(cell_Style);
			cellTop2.setCellValue(class_name+"名次人数分析表");
			
			HSSFRow r = sheet0.createRow(part2_start+1);
			for(int m=0;m<topx.length;m++){
				
				HSSFCell cell = r.createCell(m);
				cell.setCellValue("全校前"+topx[m]+"名");
			}
			
			r = sheet0.createRow(part2_start+2);
			for(int m =0;m<rank.length;m++){
				HSSFCell cell = r.createCell(m);
				cell.setCellValue(String.valueOf(rank[m]));
			}
			
		}
		File excelfile = Files.createFileIfNoExists(fileName);
		//     新建一输出文件流
		FileOutputStream fileout = new FileOutputStream(excelfile);

		try {
			// 把相应的Excel 工作簿存盘
			workbook.write(fileout);
			fileout.flush();
			// 操作结束，关闭文件
			fileout.close();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("Output   is   closed ");
		}
		return excelfile;
	}
	
	@At("/getGrageAnalysis")
	@Ok("raw")
	public File getGradeAnalysis(@Param("param")Analysis analysis) throws IOException{
		
		Map<String, Object> result = scoreAnalysisServiceImpl.getGradeAnalysis(
				analysis.getTest_id(), analysis.getAt_grade()
				, analysis.getTopx(), analysis.getLines());
		
//		int grade = 7;
		int grade = analysis.getAt_grade();
		Integer[] topx =  analysis.getTopx();
		String file_name = grade+"年级分析表.xls";
		HSSFWorkbook book = new HSSFWorkbook();
//		book.setSheetName(0, file_name);
		HSSFCellStyle cell_Style = book.createCellStyle();// 设置字体样式
		cell_Style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
//		Integer[] topx =  new Integer[]{10,20,50,100};
//		
//		 Map maps[] = new  HashMap[3];
//		maps[0] = new HashMap<>();
//		ArrayList<String> list = new ArrayList<>();
//		list.add("90");
//		list.add("60");
//		list.add("30");
//		maps[0].put("1", list);
//		maps[1] = new HashMap<>();
//		maps[1].put("2", list);
//		maps[2] = new HashMap<>();
//		maps[2].put("3", list);

		
		
		Map rate = (Map) result.get("Rate");
		String[][] top = (String[][]) result.get("Top");
		
		Set keys = rate.keySet();
		Object[] sub_names =   keys.toArray();
		for(int i = 0;i<sub_names.length;i++){
			String sub_name = (String) sub_names[i];
			HSSFSheet sheet = book.createSheet();
			book.setSheetName(i, sub_name);
			
			sheet.addMergedRegion(new org.apache.poi.ss.util.Region(0,(short) 0, 0,(short) 7));
			
			HSSFRow r = sheet.createRow(0);
			HSSFCell cell = r.createCell(0);
			cell.setCellValue(sub_name);
			cell.setCellStyle(cell_Style);
			HSSFRow row1 = sheet.createRow(1);
			HSSFCell cell0 = row1.createCell(0);
			sheet.autoSizeColumn((short) 0); // 调整第一列宽度
			cell0.setCellStyle(cell_Style);
			sheet.setColumnWidth(0, 6000);
			cell0.setCellValue("班级");
			HSSFCell cell1 = row1.createCell(1);
			cell1.setCellStyle(cell_Style);
			sheet.autoSizeColumn((short) 1); // 调整第二列宽度
			sheet.setColumnWidth(1, 6000);
			cell1.setCellValue("优秀率（优秀线以上）");
			// 调整第三列宽度
			HSSFCell cell2 = row1.createCell(2);
			cell2.setCellStyle(cell_Style);
			sheet.autoSizeColumn((short) 2); 
			sheet.setColumnWidth(2, 6000);
			cell2.setCellValue("优秀人数");
			// 调整第四列宽度
			HSSFCell cell3 = row1.createCell(3);
			cell3.setCellStyle(cell_Style);
			sheet.autoSizeColumn((short) 3); 
			sheet.setColumnWidth(3, 6000);
			cell3.setCellValue("及格率（及格线以上）");
			
			HSSFCell cell4 = row1.createCell(4);
			cell4.setCellStyle(cell_Style);
			sheet.autoSizeColumn(4);
			sheet.setColumnWidth(4, 6000);
			cell4.setCellValue("及格人数");
			
			HSSFCell cell5 = row1.createCell(5);
			cell5.setCellStyle(cell_Style);
			sheet.autoSizeColumn(5);
			sheet.setColumnWidth(5, 6000);
			cell5.setCellValue("差分率（差分线以下）");
			
			HSSFCell cell6 = row1.createCell(6);
			cell6.setCellStyle(cell_Style);
			sheet.autoSizeColumn(6);
			sheet.setColumnWidth(6, 6000);
			cell6.setCellValue("差分人数");
			
			HSSFCell cell7 = row1.createCell(7);
			cell7.setCellStyle(cell_Style);
			sheet.autoSizeColumn(7);
			sheet.setColumnWidth(7, 6000);
			cell7.setCellValue("平均分");
			
			String[][] ss = (String[][]) rate.get(sub_name);
			for(int j = 0;j<ss.length;j++){
				HSSFRow rx = sheet.createRow(j+2);
				for(int k = 0;k<ss[j].length;k++){
					HSSFCell cellx = rx.createCell(k);
					cellx.setCellValue(ss[j][k]);
				}
			}
		}
		
		
		HSSFSheet sheet= book.createSheet();
		book.setSheetName(sub_names.length, "年级各班名次人数分布");
		
		sheet.addMergedRegion(new org.apache.poi.ss.util.Region(0, (short)0, 0,(short)topx.length));
		HSSFRow r = sheet.createRow(0);
		HSSFCell cell = r.createCell(0);
		cell.setCellValue("年级各班名次人数分布");
		cell.setCellStyle(cell_Style);
		HSSFRow r2 = sheet.createRow(1);
		cell = r2.createCell(0);
		cell.setCellValue("班级");
		for(int j = 0;j<topx.length;j++){
			cell = r2.createCell(j+1);
			cell.setCellValue("年级前"+String.valueOf(topx[j])+"名");
		}
		
		for(int j = 0;j<top.length;j++){
			HSSFRow rx = sheet.createRow(2+j);
			for(int i = 0;i<top[j].length;i++){
				cell = rx.createCell(i);
				cell.setCellValue(top[j][i]);
				
			}
		}
		
		
		File excelfile = Files.createFileIfNoExists(file_name);
		//     新建一输出文件流
		FileOutputStream fileout = new FileOutputStream(excelfile);

		try {
			// 把相应的Excel 工作簿存盘
			book.write(fileout);
			fileout.flush();
			// 操作结束，关闭文件
			fileout.close();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("Output   is   closed ");
		}
		return excelfile;
		
	}
}
