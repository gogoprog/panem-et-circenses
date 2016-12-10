package common;

class RandomNameGenerator
{
    static private var generatedNames = new Map<String, Int>();
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
        var i = 0;

        do
        {
            name = titles[Std.random(titles.length)] + " " + nouns[Std.random(nouns.length)] + nouns2[Std.random(nouns2.length)];
            i++;
        }
        while(generatedNames.exists(name) && i <= 3);

        if(generatedNames.exists(name))
        {
            var count = generatedNames.get(name);
            generatedNames.set(name, count + 1);

            name = name + " " + Utils.convertToRoman(count + 1);
        }
        else
        {
            generatedNames.set(name, 1);
        }

        return name;
    }
}
