global class ContagionSchedulable implements Schedulable
{
    global void execute(SchedulableContext SC)
    {
        System.Database.executeBatch(new ContagiarBatchable(),100);
    }
    
}