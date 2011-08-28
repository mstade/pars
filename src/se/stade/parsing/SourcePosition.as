package se.stade.parsing
{
    import se.stade.babbla.formatting.format;

    public class SourcePosition
    {
        public static const Unknown:SourcePosition = SourcePosition.At(0, 0);
        
        public static function At(column:uint, row:uint = 1):SourcePosition
        {
            return new SourcePosition(column, row);
        }
        
        public function SourcePosition(column:uint, row:uint = 1)
        {
            _column = column;
            _row = row;
        }
        
        private var _row:uint;
        public function get row():uint
        {
            return _row;
        }
        
        private var _column:uint;
        public function get column():uint
        {
            return _column;
        }
        
        public function toString():String
        {
            if (this == Unknown)
                return "[?, ?]";
            else
                return format("[{col}, {row}]", { col: column, row: row });
        }
    }
}