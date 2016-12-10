package common;

class Hero
{
    public var life:Float;
    public var maxLife:Float;

    public var strength:Int;
    public var agility:Int;

    public var attack:Float;
    public var defense:Float;

    public var xp:Int;
    public var level:Int;

    public var items:Array<Item> = new Array<Item>();

    public function new()
    {
        xp = 0;
        level = 1;
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
