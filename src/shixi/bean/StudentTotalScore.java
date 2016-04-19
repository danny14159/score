package shixi.bean;

public class StudentTotalScore {

	private int studentId;
	
	private String studentName;
	
	private String subjectScore;
	
	private float totalScore;
	
	private int classOrder;
	
	private int gradeOrder;
	

	public int getStudentId() {
		return studentId;
	}

	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}

	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public String getsubjectScore() {
		return subjectScore;
	}

	public void setSubjectScore(String subjectScore) {
		this.subjectScore = subjectScore;
	}

	public float getTotalScore() {
		return totalScore;
	}

	public void setTotalScore(float totalScore) {
		this.totalScore = totalScore;
	}

	public int getClassOrder() {
		return classOrder;
	}

	public void setClassOrder(int classOrder) {
		this.classOrder = classOrder;
	}

	public int getGradeOrder() {
		return gradeOrder;
	}

	public void setGradeOrder(int gradeOrder) {
		this.gradeOrder = gradeOrder;
	}

}
