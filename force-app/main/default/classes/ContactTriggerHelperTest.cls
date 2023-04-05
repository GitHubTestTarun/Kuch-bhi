@isTest
private class ContactTriggerHelperTest {
   
    @testSetup
    static void setupData() {
        Account account = TestDataFactory.insertAccount('Test-0');
    }

    @isTest
    static void singleContactInsertionTest() {
        Account account = [SELECT Id, Name, Total_Amount__c FROM Account];

        System.assertEquals([SELECT COUNT() FROM Contact], 0);

        Test.startTest();
        Contact contact = TestDataFactory.insertContact('Test-', '1', account.Id, 1000, false);
        insert contact;
        Test.stopTest();
        System.assertEquals(1000, contact.Amount__c);
    }

    @isTest
    static void bulkContactInsertionTest() {

        Account account1 = [SELECT Id, Name, Total_Amount__c FROM Account];
        Account account2 = TestDataFactory.insertAccount('Test-1');

        List<Contact> contacts = new List<Contact>();
        for(Integer i = 1; i <= 5; i++) {
            Contact contact = TestDataFactory.insertContact('Test-', ''+i, account1.Id, 1000, false);
            contacts.add(contact);   
        }
        for(Integer i = 6; i <= 10; i++) {
            Contact contact = TestDataFactory.insertContact('Test-', ''+i, account2.Id, 1000, false);
            contacts.add(contact);  
        }
        System.assertEquals([SELECT COUNT() FROM Contact], 0);

        test.startTest();
        insert contacts;
        test.stopTest();
        System.assertEquals([SELECT COUNT() FROM Contact], 10);
    }

    @isTest
    static void singleUpdationTest() {

        Account account1 = [SELECT Id, Name FROM Account WHERE Name = 'Test-0'];
        Account account2 = TestDataFactory.insertAccount('Test-1');

        Contact contact = TestDataFactory.insertContact('Test-Contact', '-1', account1.Id, 1000);
        contact.Amount__c = 10000;

        System.assertEquals([SELECT COUNT() FROM Contact WHERE Amount__c != 1000], 0);
        
        Test.startTest();
        update contact;
        contact.AccountId = account2.Id;
        update contact;
        Test.stopTest();

        System.assertEquals(10000, contact.Amount__c);
        System.assertEquals(account2.Id, contact.AccountId);
    }

    @isTest
    static void bulkUpdationTest() {
        Account account1 = [SELECT Id, Name FROM Account WHERE Name = 'Test-0'];
        Account account2 = TestDataFactory.insertAccount('Test-1');

        List<Contact> contacts = new List<Contact>();
        for(Integer i = 1; i <= 5; i++) {
            Contact contact = TestDataFactory.insertContact('Test-', ''+i, account1.Id, 1000, false);
            contacts.add(contact);   
        }
        for(Integer i = 6; i <= 10; i++) {
            Contact contact = TestDataFactory.insertContact('Test-', ''+i, account2.Id, 1000, false);
            contacts.add(contact);  
        }
        
        System.assertEquals([SELECT COUNT() FROM Contact], 0);

        Test.startTest();
        insert contacts;

        List<Contact> updatedContacts = new List<Contact>();
        for(Contact contact : contacts) {
            contact.Amount__c = 100000;
            updatedContacts.add(contact);
        }

        update updatedContacts;

        updatedContacts = new List<Contact>();
        for(Contact contact : [SELECT Id, Name, AccountId, Amount__c FROM Contact WHERE AccountId =: account1.Id]) {
            contact.AccountId = account2.Id;
            updatedContacts.add(contact);
        }
        update updatedContacts;
        Test.stopTest();

        System.assertEquals([SELECT COUNT() FROM Contact WHERE AccountId =: account2.Id AND Amount__c = 100000], 10);
    }

    @isTest
    static void singleDeletionTest() {
        Account account = [SELECT Id, Name FROM Account WHERE Name = 'Test-0'];
        Contact contact = TestDataFactory.insertContact('Test-', '1', account.Id, 1000);
        System.assertEquals([SELECT COUNT() FROM Contact], 1);
        Test.startTest();
        delete contact;
        Test.stopTest();
        System.assertEquals([SELECT COUNT() FROM Contact], 0);
    }
    
    @isTest
    static void bulkdeletionTest() {
        Account account1 = [SELECT Id, Name FROM Account WHERE Name = 'Test-0'];
        Account account2 = TestDataFactory.insertAccount('Test-1');
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 1; i <= 5; i++) {
            Contact contact = TestDataFactory.insertContact('Test-', ''+i, account1.Id, 1000, false);
            contacts.add(contact);   
        }
        for(Integer i = 6; i <= 10; i++) {
            Contact contact = TestDataFactory.insertContact('Test-', ''+i, account2.Id, 1000, false);
            contacts.add(contact);  
        }
        insert contacts;
        System.assertEquals([SELECT COUNT() FROM Contact], 10);
        Test.startTest();
        delete contacts;
        Test.stopTest();

        System.assertEquals([SELECT COUNT() FROM Contact], 0);
    }
}