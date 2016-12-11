package common;

class Log
{
    static private var line:String = "";
    static private var colors = [
        LogColor.Default => '\033[0;39m',
        LogColor.Black => '\033[0;30m',
        LogColor.Red => '\033[0;31m',
        LogColor.Green => '\033[0;32m',
        LogColor.Yellow => '\033[0;33m',
        LogColor.Blue => '\033[0;34m',
        LogColor.Magenta => '\033[0;35m',
        LogColor.Cyan => '\033[0;36m',
        LogColor.LightGray => '\033[0;37m',
        LogColor.DarkGray => '\033[1;90m',
        LogColor.LightRed => '\033[1;91m',
        LogColor.LightGreen => '\033[1;92m',
        LogColor.LightYellow => '\03393m',
        LogColor.LightBlue => '\033[1;94m',
        LogColor.LightMagenta => '\033[1;95m',
        LogColor.LightCyan => '\033[1;96m',
        LogColor.White => '\033[1;37m',
    ];

    static public function color(c:LogColor)
    {
        line += colors[c];
    }

    static public function write(str:String)
    {
        line += str;
    }

    static public function clear()
    {
        trace('\033c');
    }

    static public function flush()
    {
        line += colors[LogColor.Default];
        trace(line);
        line = "";
    }
}
