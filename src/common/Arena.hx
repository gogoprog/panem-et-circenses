package common;

import haxe.Timer;

class Arena
{
    public var heroes:Array<Hero> = new Array<Hero>();
    public var gamblers:Array<Gambler> = new Array<Gambler>();
    public var timeFactor:Float = 1.0;
    public var battleCount = 0;

    public var eventCallback:String->Dynamic->Void = null;
    private var fighting = false;
    private var _isPreBattle = false;
    private var bets:Array<Bet>;

    public function new()
    {
    }

    public function isPreBattle()
    {
        return _isPreBattle;
    }

    public function createRandomHeroes(total:Int)
    {
        for(i in 0...total)
        {
            var hero = new Hero();

            hero.randomizeStats();
            hero.randomizeName();
            hero.compute();

            heroes.push(hero);
        }
    }

    public function start()
    {
        preBattle();
    }

    public function preBattle()
    {
        bets = [];
        _isPreBattle = true;
        eventCallback("preBattle", heroes);
        Timer.delay(startBattle, Std.int(10000 / timeFactor));
    }

    public function startBattle()
    {
        var battle = new Battle(heroes);
        var context = new BattleContext();

        _isPreBattle = false;

        context.eventCallback = eventCallback;
        battle.start(timeFactor, context, function() {
            giveRewards(battle);
            battleCount++;
            fighting = false;
            preBattle();
        });

        fighting = true;
    }

    public function giveRewards(battle:Battle)
    {
        var points = [25, 18, 15, 12, 10, 8, 6, 4, 2, 1];

        for(i in 0...points.length)
        {
            if(i >= battle.ranking.length)
            {
                break;
            }

            battle.ranking[i].gainXp(Std.int(points[i] * (1.0 + battleCount / 10.0)));
        }
    }

    public function addBet(bet:Bet)
    {
        bets.push(bet);
    }
}
