package common;

class Arena
{
    public var heroes:Array<Hero> = new Array<Hero>();
    public var battles:Array<Battle> = new Array<Battle>();

    public function new()
    {
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

            hero.log();
        }
    }
}
