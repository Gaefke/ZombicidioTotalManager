public class CriaturaTriggerHandler extends TriggerHandler
{
    public override void beforeUpdate()
    {
        system.debug('BeforeUpdate');
    }

}
// Identificar os bunkers
	Map<id,Bunker__c> bunkersUpdateMap = new Map<id,Bunker__c>();
	
    for(Criatura__c cr: trigger.new)
    {
        Criatura__c nova = cr;
        Criatura__c antiga = trigger.oldMap.get(nova.id);
        if(nova.Bunker__c != antiga.Bunker__c)
        {
            if (nova.Bunker__c != null)
                bunkersUpdateMap.put(nova.Bunker__c, new Bunker__c(id = nova.bunker__c));
            if (antiga.Bunker__c != null)
                bunkersUpdateMap.put(antiga.Bunker__c, new Bunker__c(id = antiga.bunker__c));

            bunkersUpdateMap.put(cr.Bunker__c,new Bunker__c(id = cr.bunker__c));    
        }
    }
	for(Criatura__c cr: trigger.old)
    {
        if(trigger.isDelete && cr.Bunker__c != null)
            bunkersUpdateMap.put(cr.Bunker__c, new Bunker__c(id = cr.bunker__c));
    }
    
    system.debug(bunkersUpdateMap);
    
    List<Bunker__c> bkList = [select id, (Select id from Criaturas__r) from bunker__c where id in :  bunkersUpdateMap.keySet()];
	for(Bunker__c bk : bkList)
    {
        bunkersUpdateMap.get(bk.id).Populacao__c = bk.Criaturas__r.size();
    }

	update bunkersUpdateMap.values();  
 