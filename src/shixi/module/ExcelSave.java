package shixi.module;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.annotation.AdaptBy;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Param;
import org.nutz.mvc.upload.UploadAdaptor;

import shixi.bean.Score;
import shixi.bean.Student;
import shixi.dao.ClassDao;
import shixi.dao.ScoreDao;
import shixi.dao.StudentDao;
import shixi.dao.SubjectDao;

@IocBean
@At("/excel")
public class ExcelSave {

	private HSSFWorkbook workbook;
	@Inject
	private StudentDao studentDao;
	@Inject
	private SubjectDao subjectDao;
	@Inject
	private ClassDao classDao;
	@Inject
	private ScoreDao scoreDao;

	/**
	 * 将成绩信息excel表导入到数据库中
	 * 
	 * @param excelFile
	 * @param class_id
	 * @return 成绩信息list供页面显示
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	@AdaptBy(type = UploadAdaptor.class)
	@At("/scoreSheet")
	public void getDatasInScoreSheet(@Param("excelFile") File excelFile,
			@Param("test_id") Integer test_id,
			@Param("grade_id") Integer grade_id,
			@Param("class_id") Integer class_id) throws FileNotFoundException,
			IOException {
		workbook = new HSSFWorkbook(new FileInputStream(excelFile));
		List<Score> list = new ArrayList<Score>();
		Map<Integer, Score> map = new HashMap<Integer, Score>();

		// 获得指定的表
		HSSFSheet sheet = workbook.getSheetAt(0);
		// 获得数据总行数
		int rowCount = sheet.getLastRowNum();
		int columnCount = sheet.getRow(0).getLastCellNum();

		for (int i = 1; i < rowCount-1; i++) {
			HSSFRow row =sheet.getRow(i);
			HSSFCell cell=row.getCell(0);
			scoreDao.deleteByst(getCellString(cell),test_id);
		}
		
		// 逐行读取数据
		for (int rowIndex = 0; rowIndex <= rowCount; rowIndex++) {

			// 获得行对象
			HSSFRow row = sheet.getRow(rowIndex);

			// 表头处理
			if (rowIndex == 0) {
				for (int columnIndex = 2; columnIndex < columnCount; columnIndex++) {
					Score score = new Score();
					int sub_id = subjectDao
							.queryid((String) this.getCellString(sheet
									.getRow(0).getCell(columnIndex)));
					score.setSubject_id(sub_id);
					score.setTest_id(test_id);
					score.setAt_grade(grade_id);
					score.setClass_name(classDao.fetch(class_id).getName());
					map.put(columnIndex, score);
				}
			} else {
				for (int columnIndex = 2; columnIndex < columnCount; columnIndex++) {
					HSSFCell cell = row.getCell(columnIndex);
					// 成绩处理
					Score scoreTemp = map.get(columnIndex);

					Score score = new Score();
					score.setSubject_id(scoreTemp.getSubject_id());
					score.setTest_id(scoreTemp.getTest_id());
					score.setAt_grade(scoreTemp.getAt_grade());
					score.setClass_name(scoreTemp.getClass_name());

					score.setScore(Float.parseFloat(String
							.valueOf(getCellString(cell))));
					// 学生基本信息处理
					score.setStu_id(changeFormat(getCellString(row.getCell(0))));
					score.setStu_name(String.valueOf(getCellString(row
							.getCell(1))));
					list.add(score);
				}
			}

		}
		scoreDao.batch(list);

	}

	/**
	 * 将学生信息excel表导入到数据库中
	 * 
	 * @param excelFile
	 * @param class_id
	 * @return 学生信息list供页面显示
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	@AdaptBy(type = UploadAdaptor.class)
	@At("/studentSheet")
	public List<Student> getDatasInStudentSheet(
			@Param("excelFile") File excelFile,
			@Param("class_id") Integer class_id) throws FileNotFoundException,
			IOException {
		workbook = new HSSFWorkbook(new FileInputStream(excelFile));
		List<Student> list = new ArrayList<Student>();

		// 获得指定的表
		HSSFSheet sheet = workbook.getSheetAt(0);
		// 获得数据总行数
		int rowCount = sheet.getLastRowNum();

		// 逐行读取数据
		for (int rowIndex = 1; rowIndex <= rowCount; rowIndex++) {

			// 获得行对象
			HSSFRow row = sheet.getRow(rowIndex);
			// 成绩处理
			Student student = new Student();
			student.setAt_class(class_id);
			student.setName(String.valueOf(getCellString(row.getCell(1))));
			student.setSex(String.valueOf(this.getCellString(row.getCell(2)))
					.charAt(0));
			student.setLocation(getCellString(row.getCell(3))+"");
			student.setAddress(getCellString(row.getCell(4))+"");
			student.setEnterYear(Integer.parseInt(getCellString(row.getCell(5))+""));
			list.add(student);
		}
		studentDao.batch(list);
		return list;
	}

	/**
	 * 获得单元格中的内容
	 * 
	 * @param cell
	 * @return
	 */
	protected Object getCellString(HSSFCell cell) {
		Object result = null;
		if (cell != null) {

			int cellType = cell.getCellType();

			switch (cellType) {

			case HSSFCell.CELL_TYPE_STRING:
				result = cell.getRichStringCellValue().getString();
				break;
			case HSSFCell.CELL_TYPE_NUMERIC:
				result = cell.getNumericCellValue();
				break;
			case HSSFCell.CELL_TYPE_FORMULA:
				result = cell.getNumericCellValue();
				break;
			case HSSFCell.CELL_TYPE_ERROR:
				result = null;
				break;
			case HSSFCell.CELL_TYPE_BOOLEAN:
				result = cell.getBooleanCellValue();
				break;
			case HSSFCell.CELL_TYPE_BLANK:
				result = null;
				break;
			}
		}
		return result;
	}

	public static int changeFormat(Object a) {
		double d = Double.valueOf((String.valueOf(a)));
		int i = (int) d;
		return i;
	}
}