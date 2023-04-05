public class ContactTriggerHelper {

    public static void afterInsert(Map<Id, Contact> newContacts, Map<Id,Contact> oldContacts) {
        handler(newContacts, oldContacts);
    }

    public static void afterUpdate(Map<Id,Contact> newContacts, Map<Id,Contact> oldContacts) {
        handler(newContacts, oldContacts);
    }

    public static void afterDelete(Map<Id, Contact> newContacts, Map<Id, Contact> oldContacts) {
        handler(newContacts, oldContacts);
    }

    private static void handler(Map<Id,Contact> newContacts, Map<Id,Contact> oldContacts) {
   
         Set<Id> accountIds = new Set<Id>();
         List<Contact> contacts = new List<Contact>();

         contacts = (Trigger.isInsert || Trigger.isUpdate ) ? newContacts.values(): oldContacts.values();
         for(Contact contact :contacts) {
             if(Trigger.isInsert || Trigger.isDelete) {
                 if(contact.AccountId != null && contact.Amount__c!=null) {
                     accountIds.add(contact.AccountId);
                 }
             }
             if(Trigger.isUpdate){
                 if(contact.AccountId != oldContacts.get(contact.Id).AccountId){
                     accountIds.add(contact.AccountId);
                     accountIds.add(oldContacts.get(contact.Id).AccountId);
                 }
                 if(contact.Amount__c != oldContacts.get(contact.Id).Amount__c ) {
                     accountIds.add(contact.AccountId);
                 }
             }
         }

         if(!accountIds.isEmpty()) {

             contactTriggerService.updateTotalAmount(accountIds);
         }
    }
}