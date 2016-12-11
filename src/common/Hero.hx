package common;

class Hero
{
    public var name:String;

    public var life:Float;
    public var maxLife:Float;

    public var strength:Float;
    public var agility:Float;

    public var mainAttack:Float;
    public var attackTime:Float;
    public var attackPerSecond:Float;

    public var armor:Float;

    public var xp:Int;
    public var level:Int;

    public var items:Array<Item> = new Array<Item>();

    public var baseStrength:Float;
    public var baseAgility:Float;
    public var baseArmor:Float;
    public var gainStrength:Float;
    public var gainAgility:Float;
    public var baseMinAttack:Float;
    public var baseMaxAttack:Float;
    public var baseLife:Float;
    public var baseAttackTime:Float;

    public var timeUntilNextAttack:Float;

    private var currentTarget:Hero;

    public function new()
    {
        xp = 0;
        level = 1;
    }

    public function randomizeName()
    {
        name = RandomNameGenerator.createRandomName();
    }

    public function randomizeStats()
    {
        baseStrength = 1 + Std.random(10);
        baseAgility = 1 + Std.random(10);
        gainStrength = 1 + Math.random();
        gainAgility = 1 + Math.random();
        baseArmor = 1 + Math.random() * 2;
        baseMinAttack = 1 + Std.random(10);
        baseMaxAttack = baseMinAttack + Std.random(10);
        baseLife = Std.random(200);
        baseAttackTime = 0.8 + Math.random();

        compute();
    }

    public function reset()
    {
        life = maxLife;
        timeUntilNextAttack = attackTime;
    }

    public function gainXp(amount:Int)
    {
        xp += amount;

        level = Std.int(Math.max(Math.floor(8.7 * Math.log(xp + 111) - 40), 1));
        compute();
    }

    public function compute()
    {
        strength = baseStrength + gainStrength * level;
        agility = baseAgility + gainAgility * level;
        armor = baseArmor + agility * 0.5;
        maxLife = baseLife + strength * 20;

        var ias = agility;

        attackTime = baseAttackTime / ((100 + ias) * 0.01);
        attackPerSecond = 1 / attackTime;

        computeMainAttack();
    }

    public inline function computeMainAttack()
    {
        mainAttack = baseMinAttack + Math.random() * (baseMaxAttack - baseMinAttack) + Math.max(strength, agility);
    }

    public function log()
    {
        trace(name + " Attack: " +  Utils.round(mainAttack) + "  APS: " + Utils.round(attackPerSecond));
    }

    public inline function isDead()
    {
        return life <= 0;
    }

    public function update(battle:Battle, dt:Float)
    {
        timeUntilNextAttack -= dt;

        if(timeUntilNextAttack <= 0)
        {
            if(currentTarget == null || currentTarget.isDead())
            {
                var heroes = battle.heroes;
                currentTarget = null;

                if(heroes.length > 1)
                {
                    do
                    {
                        currentTarget = heroes[Std.random(heroes.length)];
                    }
                    while(currentTarget == this);
                }
            }

            if(currentTarget != null)
            {
                attack(currentTarget);
            }

            timeUntilNextAttack = attackTime;
        }
    }

    public function attack(other:Hero)
    {
        computeMainAttack();

        other.life -= mainAttack;

        trace(name + " hit " + other.name + " (" + mainAttack + ")");
    }
}
