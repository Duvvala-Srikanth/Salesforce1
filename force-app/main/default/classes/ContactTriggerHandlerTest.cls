@isTest
Private class ContactTriggerHandlerTest {
    @isTest
    Static Void Sizeofcontactstest(){
        List<Contact> conList=new List<Contact>();
        Account acc =new Account(Name='Srikanth');
        insert acc;
        
        for (integer i=0;i<=3;i++){
            conList.add(new Contact(LastName='test_Contact'+i, AccountId=acc.Id, HomePhone='934792155'+String.valueof(i)));
        }
        //List<Account> acclIst=[SELECT ID, TotalContactsCount__c from Account where Name ='srikanth'];
        Test.Starttest();
        insert ConList;
        Test.StopTest();
        List<Account> accchecklist=[SELECT ID, TotalContactsCount__c from Account where Name ='srikanth'];
        System.assertEquals(4,acccheckList[0].TotalContactscount__c,
                            'total contacts on account is not updated');
    }
}