public class OppoProcessorBatch implements Database.Batchable<sObject>, Database.stateful{
	
    public integer recordCount = 0;
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        
        return Database.getQueryLocator([SELECT Id, Name FROM Opportunity]);
    }
    public void execute(Database.BatchableContext bc, List<Opportunity> Opportunities) {
        	
        for(Opportunity opportunity : Opportunities) {
            opportunity.LeadSource = 'Web';
        }
        update Opportunities;
        recordCount +=  Opportunities.size();
    }	
    
    public void finish(Database.BatchableContext bc) {
        System.debug('Total record Processed are '+recordCount);
    }
}