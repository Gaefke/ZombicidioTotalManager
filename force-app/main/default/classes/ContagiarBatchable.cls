public with sharing class ContagiarBatchable implements Database.Batchable<sObject>{
    public ContagiarBatchable() {}

    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT id, Criatura__c.RecordTypeId, bunker__r.DefesaEfetivaBunker__c, bunker__c, (select id, acrescimoDefesa__c from RecursosCriatura__r) FROM Criatura__c ');
     }
  
     public void execute(Database.BatchableContext BC, List<sObject> scope)
     {
        List<Criatura__c> hum = preenchelistaCriaturaRecordtype();
        List<Criatura__c> zom = new List<Criatura__c>();
     }

     private List<Criatura__c> preenchelistaCriaturaRecordtype(id recordtype, List<Criatura__c> listaP)
     {
         List<Criatura__c> cri = new List<Criatura__c>();
         for(Criatura__c crip: listaP)
         {
             if(crip.recordTypeId == recordtype) cri.add(crip);
         }
         return cri;
     }
  
     public void finish(Database.BatchableContext BC){
     }
}
