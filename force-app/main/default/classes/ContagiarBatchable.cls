public with sharing class ContagiarBatchable implements Database.Batchable<sObject>{
    public ContagiarBatchable() {}

    static final integer ZombieSpread = 2;

    private  String ZombieId = Schema.SObjectType.Criatura__c.getRecordTypeInfosByName().get('Zumbi').getRecordTypeId();
    private  String HumanId = Schema.SObjectType.Criatura__c.getRecordTypeInfosByName().get('Humano').getRecordTypeId();

    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT id, Criatura__c.RecordTypeId, bunker__r.DefesaEfetivaBunker__c, bunker__c, (select id, acrescimoDefesa__c from RecursosCriatura__r) FROM Criatura__c ');
     }
  
     public void execute(Database.BatchableContext BC, List<sObject> scope)
     {
        System.debug('Entrou no Execute!');
        List<criatura__c> criList = (List<criatura__c>) scope;
        List<Criatura__c> humList = preenchelistaCriaturaRecordtype(HumanId, criList);
        List<Criatura__c> zumList = preenchelistaCriaturaRecordtype(ZombieId, criList);
        Map<id,Criatura__c> criUpdateList = new Map<id,Criatura__c>();
        for(Criatura__c zum : zumList)
        {
            for(integer i = 0; i < ZombieSpread; i++)
            {
                Criatura__c cri =(Criatura__c) Util.GetRandomItem(humList);
                Decimal defesa = this.getDefense(cri);
                Integer DiceRoll = Math.mod(Integer.valueof(Math.random()*10000),100)+1;
                if(Diceroll > defesa)
                {
                    cri.recordtypeId = ZombieId;
                    cri.DataZumbificacao__c = Date.today();
                    criUpdateList.put(cri.id, cri);
                }
            }
        }
        update criUpdateList.values();
     }

     private decimal getDefense(criatura__c hmn1)
     {
        Decimal defesa = 0;
        if(hmn1.recordtypeId != '0125e000001EADRAA4')
        {
            if (hmn1.bunker__c != null)
            {
                defesa += hmn1.bunker__r.DefesaBunker__c;
            }
            if(hmn1.RecursosCriatura__r != null)
            {
                for(recursoCriatura__c recCri : hmn1.RecursosCriatura__r)
                {
                    defesa += recCri.acrescimoDefesa__c;
                }
            }
        }
        return defesa;
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
