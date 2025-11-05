public class ContactTriggerHandler {
    /*Whenever the Description field of a Contact is updated, 
• Update the Description field of all related Case records whose Status is not 
"Closed", with the new Contact description. 
• If the Contact has no open Cases, then create a new Case for that Contact and 
set its Description to match the Contact’s Description.*/
    public static void UpdateCaseDesc(Map<Id,Contact>conMap, LIst<Contact>conList){
        Map<ID, String> ConDesc= new Map<Id, String>();
        for (Contact con: ConList){
            if (con.Description !=Null && con.Description !=conMap.get(Con.id).Description){
                ConDesc.put(Con.Id,con.Description);
            }
        }
        List<Case>csList= [select id,Status, Description, ContactID from Case where ContactID IN: ConDesc.keyset()];
        // in CsList only the triggered Contact related Cases will be Stored only of the description changed
        List<Case> CaseToBeUpdates=new List<Case>();// for to UPdate
        List<Case> CaseToBeinsert=new List<Case>();  // for to Insert
        //it is for to track that contacts which have open cases
        set<Id> ConsWithOpenCase=new Set<Id>();
        for (Case cs:csList){
            //if (ConDesc.containskey(cs.ContactId)){
            if (cs.Status!='Closed'){  //only open Cases
                cs.Description=ConDesc.get(cs.ContactId);
                ConsWithOpenCase.add(cs.ContactId);
                CaseToBeUpdates.add(cs);	
            }
        }
        for (Id ConIds:ConDesc.keyset()){
            // it will execute only if the Contact Ids Does not Present in the set
            if (!ConsWithOpenCase.Contains(ConIds)){
                case newCase=new case();
                newCase.Origin='Web';
                newCase.Status='New';
                newCase.ContactId=ConIds;
                newCase.Description=ConDesc.get(ConIds);
                CaseToBeinsert.add(newCase);
            }
        }
        
        if (!CaseToBeUpdates.isEmpty()){
            Update CaseToBeUpdates;
        }
        if (!CaseToBeinsert.isEmpty()){
            insert CaseToBeinsert;
        }
    }
    
    
/*Apex trigger to prevent the creation of duplicate Contacts within the same 
Account that shares the same Email address. */
    public static void SameEmailAddError(List<Contact> ConList){
        set<id> accids=new set<id>();
        for(Contact Con:ConList){
            if (Con.AccountId!=Null && Con.Email!=Null){
                accids.add(Con.AccountId);
            }
        }
        List<Contact> Conaccs = [select id,LastName,AccountId,Email From Contact where AccountId in: accids];
        System.Debug(Conaccs);
        map<Id,List<String>> ConMap= new map<Id,List<String>>();
        for(Contact Con: Conaccs){
            if (ConMap?.Containskey(Con.AccountId) && Con.Email!=null){
                ConMap?.get(Con?.AccountId).add(Con.Email);
            }
            else{
                ConMap.put(Con.AccountId,new List<String>{Con.Email});
            }
        }
        for (Contact Con:ConList){
            if(con.AccountId != null && con.Email != null){
            	if(ConMap.containsKey(con.AccountId) && ConMap.get(con.AccountId).contains(Con.Email)){
                    con.adderror('you are not able to create this contact as another Contact with same Account has this Same Email Id'+
                                 'Try with Another Email ID');
                }
            }
        }
    }
}




// When a contact record is inserted, deleted or undeleted then update 'Total Contact Count' field on related Account.
/* //After INSERT DELETE UNDELETE
public static void TotalContactsCount(List<Contact> conList){
List<Account> accList = new List<Account>();
Set<id> accIds=new Set<id>();
for (Contact con:conList){
if (con.AccountId!=Null){ // it means these contacts is linked with another account must
//these set accIds will collect the all AccountIds No duplicates as it is set
accIds.add(con.AccountId);
}
}
//Account is parent and the child is contact 
for (Account acc:[SELECT Id, (SELECT Id From Contacts) From Account
WHERE id IN: accIds]){
System.debug(acc);
acc.TotalContactsCount__c=acc.contacts.size();
accList.add(acc);
}
if(accList.size()>0){
Update accList;
}
}

public static void SendEmailOnCreate(List<Contact> conList){
List<Messaging.SingleEmailMessage> emails=new List<Messaging.SingleEmailMessage>();
for (Contact con:ConList){
Messaging.singleEmailMessage email= new Messaging.singleEmailMessage();
email.setToaddresses(new String[] {con.Email});
email.setSubject('Your contact is created successfully');
email.SetPlainTextBody('Hello ' + con.FirstName + ',\n\n' +
'We’re excited to let you know that your contact record has been successfully created in our system.\n\n' +
'Best Regards,\nYour Company Name');
emails.add(email);
}
if (!emails.isEmpty()){
Messaging.sendEmail(emails,false);
}
}
public static void preventContactDeletion(List<Contact> conList){
profile p=[Select id from Profile where Name='System Administrator'];
for (Contact con : conList){
if (UserInfo.getProfileId() != p.Id || con.Department=='Education'){
con.addError('this contact is not able to delete as it has the department of education');
}
}
}
}*/