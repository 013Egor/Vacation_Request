trigger request on Vacation_Request__c (before insert) {
	SObjectField startDate = Vacation_Request__c.StartDate__c;
	List<Vacation_Request__c> rt = new List<Vacation_Request__c>();

	for (Vacation_Request__c request : Trigger.new) {
		Vacation_Request__c v = new Vacation_Request__c();
		v.Name = 'test';
		v.StartDate__c = request.StartDate__c;
		v.EndDate__c =  request.EndDate__c;
		v.RequestType__c = request.RequestType__c;

		rt.add(v);
	}
	insert rt;
}