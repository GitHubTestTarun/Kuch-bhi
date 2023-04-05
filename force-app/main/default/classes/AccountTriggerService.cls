public class AccountTriggerService {

    public static void updateOpportunity(Set<Id> accountIds) {

        List<Opportunity> opportunities = [SELECT ID, Name, AccountId, StageName FROM Opportunity WHERE AccountId IN :accountIds];
        List<Opportunity> updatedOpportunities = new List<Opportunity>();

        for(Opportunity opportunity : opportunities) {
            if(opportunity.StageName != 'Closed Won') {
                opportunity.StageName = 'Closed Won';
                updatedOpportunities.add(opportunity);
            }
        }
        update updatedOpportunities;
    }
}