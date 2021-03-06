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

    public var buried:Bool;

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

        life = maxLife;
    }

    public function reset()
    {
        life = maxLife;
        timeUntilNextAttack = attackTime;

        buried = false;
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
        timeUntilNextAttack = attackTime;
    }

    public function log()
    {
        Log.color(LogColor.White);
        Log.write(name);

        for(i in 0...(25 - name.length))
        {
            Log.write(' ');
        }

        Log.color(LogColor.LightGray);
        Log.write(' [');

        Log.color(LogColor.Green);

        var size = 40;
        var l = Std.int((life / maxLife) * size);

        for(i in 0...l)
        {
            Log.write('#');
        }

        for(i in 0...(size - l))
        {
            Log.write(' ');
        }

        Log.color(LogColor.LightGray);
        Log.write('] ');
        Log.write(Std.int(life) + "/" + Std.int(maxLife));
        Log.write(' | Lvl:' + level + ' (' + xp + ')');

        Log.write(" | Att:" +  Utils.round(mainAttack, 0) + " | APS:" + Utils.round(attackPerSecond));
        Log.flush();
    }

    public inline function isDead()
    {
        return life <= 0;
    }

    public function update(context:BattleContext, dt:Float)
    {
        var currentTarget = context.targetMap[this];
        timeUntilNextAttack -= dt;

        if(timeUntilNextAttack <= 0)
        {
            if(currentTarget == null || currentTarget.isDead())
            {
                var heroes = context.heroes;
                currentTarget = null;

                if(heroes.length > 1)
                {
                    do
                    {
                        currentTarget = heroes[Std.random(heroes.length)];
                    }
                    while(currentTarget == this || currentTarget.isDead());
                }
            }

            if(currentTarget != null)
            {
                attack(currentTarget);
            }

            timeUntilNextAttack = attackTime;
        }

        context.targetMap[this] = currentTarget;
    }

    public function attack(other:Hero)
    {
        var damage = 0.0;

        computeMainAttack();

        damage = mainAttack /* + bonus */;
        damage *= (1 - (0.06 * other.armor / (1 + 0.06 * other.armor)));

        other.life -= mainAttack;

        other.life = Math.max(0, other.life);

        if(other.isDead())
        {
            gainXp(Std.int((other.level / level) * other.level * 2));
        }
    }
}
