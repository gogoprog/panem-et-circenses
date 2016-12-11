package common;

class Battle
{
    public var heroes:Array<Hero>;

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
    }

    public function update(time:Float)
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
                    hero.update(this, minTime);
                }
            }
        }
    }

    public function end()
    {
        trace("Battle ended.");
    }
}
