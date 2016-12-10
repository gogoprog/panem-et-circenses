package common;

class RandomNameGenerator
{
    static private var generatedNames = new Map<String, Bool>();
    static private var titles = [
        "Dark",
        "Lord",
        "Sir",
        "King"
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
        "Fear"
    ];

    static private var verbs = [
        "bringer",
        "slaughter",
        "killer",
        "crusher",
        "saver",
        "freezer",
        "burner",
        "stopper",
        "blower"
    ];

    static public function createRandomName():String
    {
        var name;

        do
        {
            name = titles[Std.random(titles.length)] + " " + nouns[Std.random(nouns.length)] + verbs[Std.random(verbs.length)];
        }
        while(generatedNames.exists(name));

        generatedNames.set(name, true);

        return name;
    }
}
