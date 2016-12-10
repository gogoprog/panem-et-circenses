package common;

class RandomNameGenerator
{
    static private var generatedNames = new Map<String, Bool>();
    static private var titles = [
        "Dark",
        "Lord",
        "Sir",
        "King",
        "Baron",
        "Duke",
        "Prince"
    ];

    static private var nouns = [
        "Death",
        "Cold",
        "Blood",
        "Fire",
        "Freeze",
        "Blade",
        "Sword",
        "Axe",
        "Fear",
        "White",
        "Black",
        "Brown",
        "Life"
    ];

    static private var nouns2 = [
        "bringer",
        "slaughter",
        "killer",
        "crusher",
        "saver",
        "freezer",
        "burner",
        "stopper",
        "blower",
        "land",
        "strong",
        "bridge",
        "mond",
        "taker",
        "ington"
    ];

    static public function createRandomName():String
    {
        var name;

        do
        {
            name = titles[Std.random(titles.length)] + " " + nouns[Std.random(nouns.length)] + nouns2[Std.random(nouns2.length)];
        }
        while(generatedNames.exists(name));

        generatedNames.set(name, true);

        return name;
    }
}
