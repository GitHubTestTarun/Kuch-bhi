global class RemindOppoOwnersScheduleable implements Schedulable {
	
    global void execute(SchedulableContext SContext) {
        List<Opportunity> Opportunities = [SELECT Id, Name, OwnerId, CloseDate FROM Opportunity WHERE  IsClosed = False AND CloseDate < TODAY];
        //we are remindinf those oppor whose are not closed and closedate is less than today's date 
        TaskUtilsScheduleable.RemindOwners(Opportunities);
    }
    
}