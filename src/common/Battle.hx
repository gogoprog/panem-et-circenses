package common;

import haxe.Timer;

class Battle
{
    public var heroes:Array<Hero>;
    public var ranking:Array<Hero>;
    private var finished = false;

    public function new(heroes)
    {
        this.heroes = heroes;
        ranking = new Array<Hero>();
    }

    public function start(timeFactor:Float, context:BattleContext, onEndCallback:Void->Void)
    {
        context.heroes = heroes;

        for(hero in heroes)
        {
            hero.reset();
        }

        finished = false;

        function iter()
        {
            var timeLeft = 1.0;

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
                    else
                    {
                        if(!hero.buried)
                        {
                            ranking.push(hero);
                            hero.buried = true;
                        }
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

            if(context.eventCallback != null)
            {
                context.eventCallback("battleUpdate", this);
            }

            if(!isOver())
            {
                Timer.delay(iter, Std.int((1000 - timeLeft * 1000) / timeFactor));
            }
            else
            {
                if(context.eventCallback != null)
                {
                    context.eventCallback("battleEnd", this);
                }

                if(onEndCallback != null)
                {
                    onEndCallback();
                }
            }
        }

        iter();
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
                ranking.push(hero);
            }
        }

        finished = true;

        ranking.reverse();
    }

    public function logHeroes()
    {
        for(hero in heroes)
        {
            hero.log();
        }
    }
}
