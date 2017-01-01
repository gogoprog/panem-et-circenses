package common;

class BattleContext
{
    public var targetMap = new Map<Hero, Hero>();
    public var eventCallback:String->Dynamic->Void = null;
    public var heroes:Array<Hero>;

    public function new()
    {

    }
}
