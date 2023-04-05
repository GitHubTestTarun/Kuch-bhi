public with sharing class DaysCountOfLastLoggedActivity 
{
    public void LatestModifiedDate_ActivityHistory(id accountId)
    {
        
        List<Opportunity> opphistoryList = [Select ID, AccountId, (select LastModifiedDate from ActivityHistories order by LastModifiedDate DESC limit 1), 
                                            (select id,LastModifiedDate from events order by LastModifiedDate DESC limit 1), 
                                            (select id, LastModifiedDate from tasks order by LastModifiedDate DESC limit 1)
                                            From Opportunity where AccountId= :accountId];
        Set<Id> oppId_set = new Set<Id>();
        
        Integer activityHistoryDaysCount=-1; 
        Integer taskDaysCount=-1;
        Integer eventsDaysCount=-1;
        Integer FeedItemDaysCount=-1;
        
        integer i = 0;
        for(Opportunity opp : opphistoryList)
        {
            
            oppId_Set.add(opp.Id);
           
            //Activity History
            if(! opp.ActivityHistories.isEmpty() ){
                for(activityHistory ah : opp.ActivityHistories){
                    if(i == 0){
                        activityHistoryDaysCount = Date.valueOf(ah.LastModifiedDate).daysBetween(system.today());
                    }
                    else{
                        Integer dt2 =   Date.valueOf(ah.LastModifiedDate).daysBetween(system.today());
                        if(activityHistoryDaysCount >  dt2){
                            activityHistoryDaysCount = dt2;
                            
                        }
                    }
                    system.debug('activityHistoryDaysCount:'+ activityHistoryDaysCount);
                }
            }   
            //Events
            if(! opp.events.isEmpty() ){
                for(Event ah : opp.events){
                    if(i == 0){
                        eventsDaysCount =  Date.valueOf(ah.LastModifiedDate).daysBetween(system.today());
                    }
                    else{
                        Integer dt2 =   Date.valueOf(ah.LastModifiedDate).daysBetween(system.today());if(eventsDaysCount >  dt2){
                            eventsDaysCount = dt2;
                            
                        }
                    }
                    system.debug('eventsDaysCount: '+ eventsDaysCount);
                } 
            }
            //Tasks
            if(! opp.tasks.isEmpty() ){
                for(Task ah : opp.tasks){
                    if(i == 0){
                        taskDaysCount =  Date.valueOf(ah.LastModifiedDate).daysBetween(system.today());
                    }
                    else{
                        Integer dt2 =   Date.valueOf(ah.LastModifiedDate).daysBetween(system.today());
                        if(taskDaysCount >  dt2){
                            taskDaysCount = dt2;
                            
                        }
                    }
                    system.debug('taskDaysCount:'+taskDaysCount);
                } 
            }
            i++;
        }

        List<FeedItem> feeditemList = [select id, parentId, type, LastModifiedDate from FeedItem where parentId =: accountId order by LastModifiedDate DESC Limit 1 ];
        system.debug('$$$ feeditemList: '+ feeditemList);
       
        //FeedItem
        for(FeedItem fi : feeditemList) {
            if(!feeditemList.isEmpty())
            {
                if(i ==0){
                    FeedItemDaysCount = Date.valueOf(fi.LastModifiedDate).daysBetween(system.today());
                }
                else{
                    Integer dt2 =   Date.valueOf(fi.LastModifiedDate).daysBetween(system.today());
                        if(FeedItemDaysCount >  dt2){
                            FeedItemDaysCount = dt2;
                            
                        }
                }
                system.debug('FeedItemDaysCount:'+ FeedItemDaysCount);
            }
        }
        
        integer a = activityHistoryDaysCount;//5
        integer f = FeedItemDaysCount;//15
        integer t = taskDaysCount;//4
        integer e = eventsDaysCount;//25
        
        list<Account> account =new List<Account>();
        
        integer finalDayCount = a;
        if(finalDayCount > f && f <> -1){
            finalDayCount = f;
        }
        if(finalDayCount > t && t <> -1){
            finalDayCount = t;
        }
        if(finalDayCount > e && e <> -1){
            finalDayCount = e;
        }
        
        if(finalDayCount < 0){
            Account acc = [Select LastModifiedDate From Account Where Id=:accountId];
            finalDayCount = Date.valueOf(acc.LastModifiedDate).daysBetween(system.today());
        }
        system.debug('### finalDayCount: '+ finalDayCount);
        Account accountToUpdate = new Account(
        	id=accountId,
            Days_since_last_touchpoint__c= finalDayCount
        );
       
        if(!String.isEmpty(accountID)){
            update accountToUpdate;
        }
        
        
    }
}