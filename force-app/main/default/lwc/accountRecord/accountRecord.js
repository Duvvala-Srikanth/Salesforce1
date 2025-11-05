import { LightningElement,wire,api } from 'lwc';
import getAccountbyId from '@salesforce/apex/AccountController.getAccountbyId';
export default class AccountRecord extends LightningElement {
    @api recordId;
    accounts;

    col=[
        { label:'AccountName', fieldName:'Name'},
        {label: 'AnnualRevenue', fieldName:'AnnualRevenue'},
        {label:'Industry', fieldName:'Industry', type:'text'}
  ];
  connectedCallback(){
    console.log('recordId: ',this.recordId);
  }

    @wire(getAccountbyId, {accountId:'$recordId'}) //$ symbol tells Salesforce that recordId is reactive.
    wiredAccounts({error,data}){
        console.log('output: data', JSON.stringify(data));
        console.log('output: error', JSON.stringify(error));
        
        if (data){
            this.accounts=[data];
            console.log('data founded : ',data)
        }
        else if(error){
            console.log('error founded : ',error);
        }
    }
}