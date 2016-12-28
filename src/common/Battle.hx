package common;

class Battle
{
    public var heroes:Array<Hero>;
    private var finished = false;

    public function new(heroes)
    {
        this.heroes = heroes;
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
                    targetMap[hero] = hero.update(this, minTime, targetMap[hero]);
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
        trace("Battle ended.");
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
