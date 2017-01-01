package common;

class Battle
{
    public var heroes:Array<Hero>;
    public var survivors:Array<Hero>;
    private var finished = false;
    private var context:BattleContext;

    public function new(heroes)
    {
        this.heroes = heroes;
        survivors = new Array<Hero>();
        context = new BattleContext();
        context.heroes = heroes;
    }

    public function begin()
    {
        trace("Battle started.");

        for(hero in heroes)
        {
            hero.reset();
        }

        finished = false;
    }

    public function update(time:Float, targetMap:Map<Hero, Hero>)
    {
        var timeLeft = time;

        while(timeLeft > 0)
        {
            var minTime = timeLeft;
            var aliveCount = 0;

            for(hero in heroes)
            {
                if(!hero.isDead())
                {
                    aliveCount++;
                    minTime = Math.min(hero.timeUntilNextAttack, minTime);
                }
            }

            if(aliveCount <= 1)
            {
                end();
                break;
            }

            for(hero in heroes)
            {
                if(!hero.isDead())
                {
                    hero.update(context, minTime);
                }
            }


            timeLeft -= minTime;
        }
    }

    public function isOver()
    {
        return finished;
    }

    public function end()
    {
        for(hero in heroes)
        {
            if(!hero.isDead())
            {
                survivors.push(hero);
            }
        }

        finished = true;
    }

    public function logHeroes()
    {
        for(hero in heroes)
        {
            hero.log();
        }
    }
}
