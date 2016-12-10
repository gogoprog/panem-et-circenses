package common;

class Utils
{
    public static function round(number:Float, ?precision=2): Float
    {
        number *= Math.pow(10, precision);
        return Math.round(number) / Math.pow(10, precision);
    }
}
