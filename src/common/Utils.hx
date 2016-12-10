package common;

class Utils
{
    public static function round(number:Float, ?precision=2): Float
    {
        number *= Math.pow(10, precision);
        return Math.round(number) / Math.pow(10, precision);
    }

    public static function convertToRoman(num)
    {
        var roman = "";
        var values = [1000,900,500,400,100,90,50,40,10,9,5,4,1];
        var literals = ["M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"];

        var i = 0;
        while(i < values.length)
        {
            if(num>=values[i])
            {
                if(5<=num && num<=8)
                    num -= 5;
                else if(1<=num && num<=3)
                    num -= 1;
                else
                    num -= values[i];

                roman += literals[i];
                i--;
            }
            i++;
        }

        return roman;
    }
}
