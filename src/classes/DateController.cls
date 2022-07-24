public class DateController {
	public static Integer getWorkingDays (Date startDate, Date endDate) {
		Integer startWeek = startDate.toStartOfWeek().daysBetween(startDate);
		Integer endWeek = endDate.toStartOfWeek().daysBetween(endDate);
		endWeek = endWeek < 5 ? endWeek : 5;
		if (startDate.toStartOfWeek().isSameDay(endDate.toStartOfWeek())) {
			return endWeek - startDate.toStartOfWeek().daysBetween(startDate);
		}
		startWeek = 5 - startWeek;
		Integer weeksAmount = startDate.daysBetween(endDate) / 7 - 1;

		return startWeek + endWeek + weeksAmount * 5;
	}
}