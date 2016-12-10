package common;

class Hero
{
    public var life:Float;
    public var maxLife:Float;

    public var strength:Float;
    public var agility:Float;

    public var attack:Float;
    public var defense:Float;

    public var xp:Int;
    public var level:Int;

    public var items:Array<Item> = new Array<Item>();

    public var baseStrength:Float;
    public var baseAgility:Float;
    public var gainStrength:Float;
    public var gainAgility:Float;

    public function new(bs, ba, gs, ga)
    {
        xp = 0;
        level = 1;
        baseStrength = bs;
        baseAgility = ba;
        gainStrength = gs;
        gainAgility = ga;
    }

    public function reset()
    {
        life = maxLife;
    }

    public function gainXp(amount:Int)
    {
        xp += amount;
    }
}
