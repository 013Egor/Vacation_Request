public class DateController {
	public static Integer getWorkingDays (Date startDate, Date endDate) {
		return endDate.daysBetween(startDate);
	}
}