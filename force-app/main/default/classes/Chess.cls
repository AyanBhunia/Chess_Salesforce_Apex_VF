public class Chess {

    public class pair {
        public Integer x;
        public integer y;
        
        public Pair(Integer x, Integer y) {
            this.x = x;
            this.y = y;
        }

        // Override equals method
        public Boolean equals(Object obj) {
            if (obj == null) {
                return false;
            }
            if (!(obj instanceof Pair)) {
                return false;
            }
            Pair other = (Pair) obj;
            return this.x == other.x && this.y == other.y;
        }

        // Override hashCode method
        public Integer hashCode() {
            return 31 * x.hashCode() + y.hashCode();
        }

        public override String toString() {
            return '(x=' + x + ', y=' + y + ')';
        }
    }

    public class pair_list{
        public list<pair> list_x;
        public list<pair> list_y;

        public pair_list(list<pair> list_x, list<pair> list_y) {
            this.list_x = list_x;
            this.list_y = list_y;
        }
    }

    
    public static Integer getValueAt(Integer rowIndex, Integer colIndex) {
        if (rowIndex >= chessBoardRecords.size() || rowIndex < 0) {
            throw new IllegalArgumentException('row out of bound '+rowIndex);
        }

        Decimal temp;
        switch on colIndex{
            when 0 {
                temp = chessBoardRecords[rowIndex].A__c;
            }
            when 1 {
                temp = chessBoardRecords[rowIndex].B__c;
            }
            when 2 {
                temp = chessBoardRecords[rowIndex].C__c;
            }
            when 3 {
                temp = chessBoardRecords[rowIndex].D__c;
            }
            when 4 {
                temp = chessBoardRecords[rowIndex].E__c;
            }
            when 5 {
                temp = chessBoardRecords[rowIndex].F__c;
            }
            when 6 {
                temp = chessBoardRecords[rowIndex].G__c;
            }
            when 7 {
                temp = chessBoardRecords[rowIndex].H__c;
            }
            when else{
                throw new IllegalArgumentException('column out of bound '+colIndex);}
        }

        return (Integer)temp;
    }

    public static void setValueAt(Integer rowIndex, Integer colIndex, integer value) {
        if (rowIndex >= chessBoardRecords.size() || rowIndex < 0) {
            throw new IllegalArgumentException('row out of bound '+rowIndex);
        }

        Decimal temp;
        switch on colIndex{
            when 0 {
                chessBoardRecords[rowIndex].A__c=value;
            }
            when 1 {
                chessBoardRecords[rowIndex].B__c=value;
            }
            when 2 {
                chessBoardRecords[rowIndex].C__c=value;
            }
            when 3 {
                chessBoardRecords[rowIndex].D__c=value;
            }
            when 4 {
                chessBoardRecords[rowIndex].E__c=value;
            }
            when 5 {
                chessBoardRecords[rowIndex].F__c=value;
            }
            when 6 {
                chessBoardRecords[rowIndex].G__c=value;
            }
            when 7 {
                chessBoardRecords[rowIndex].H__c=value;
            }
            when else{
                throw new IllegalArgumentException('column out of bound '+colIndex);}
        }
    }

    public static String getPieceSymbol(Integer pieceValue) {
        switch on pieceValue {
            when 1 {
                return '♟︎'; // Black Pawn
            }
            when 2 {
                return '♜'; // Black Rook
            }
            when 3 {
                return '♞'; // Black Knight
            }
            when 4 {
                return '♝'; // Black Bishop
            }
            when 5 {
                return '♛'; // Black Queen
            }
            when 6 {
                return '♚'; // Black King
            }
            when 11 {
                return '♙'; // White Pawn
            }
            when 12 {
                return '♖'; // White Rook
            }
            when 13 {
                return '♘'; // White Knight
            }
            when 14 {
                return '♗'; // White Bishop
            }
            when 15 {
                return '♕'; // White Queen
            }
            when 16 {
                return '♔'; // White King
            }
            when else {
                return '#'; // invalid piece values
            }
        }
    }


    public static List<pair> avail_array = new List<pair>();
    public static List<pair> enemy_array = new List<pair>();

    public static Integer check=0;
    public static List<Integer> list_to_iterate{get;set;}
    
    public static List<List<integer>> board {get;set;}
    public static List<chessBoard__c> chessBoardRecords = new List<chessBoard__c>();

    public static list<chessBoardMove__c> chess_moves {get;set;}
    public static List<String> blacklist {get;set;}
    public static List<String> whitelist {get;set;}

    public Chess(){
        initialize_board();
    }

    public static void initialize_board(){
        chessBoardRecords = [SELECT row__c,A__c, B__c, C__c, D__c,E__c,F__c,G__c,H__c FROM chessBoard__c ORDER BY row__c ASC];

        board= new List<List<integer>>();
        list_to_iterate = new List<Integer>{0,1,2,3,4,5,6,7};

        for (chessBoard__c record : chessBoardRecords) {
            List<Integer> row = new List<Integer>{(Integer)record.A__c, (Integer)record.B__c, (Integer)record.C__c, (Integer)record.D__c, (Integer)record.E__c, (Integer)record.F__c,(Integer) record.G__c, (Integer)record.H__c};
            board.add(row);
        }

        chess_moves =new list<chessBoardMove__c>();
        chess_moves= [SELECT row__c,color__c, piece_type__c, text__c,capture__c FROM chessBoardMove__c ORDER BY name ASC];
        // system.debug(chess_moves);    
        blacklist=new List<String>();
        whitelist=new List<String>();
        for (chessBoardMove__c row : chess_moves) {
            if (row.capture__c!=0) {
                if (row.capture__c<10) {
                    blacklist.add(getPieceSymbol((Integer)row.capture__c));
                }
                else {
                    whitelist.add(getPieceSymbol((Integer)row.capture__c));
                }
            }
        }

        System.debug('initial');
    }


    public static void setnewboard(){
        initialize_board();
        board.clear();
        board.add(new List<integer>{2,3,4,5,6,4,3,2});
        board.add(new List<integer>{1,1,1,1,1,1,1,1});
        board.add(new List<integer>{0,0,0,0,0,0,0,0});
        board.add(new List<integer>{0,0,0,0,0,0,0,0});
        board.add(new List<integer>{0,0,0,0,0,0,0,0});
        board.add(new List<integer>{0,0,0,0,0,0,0,0});
        board.add(new List<integer>{11,11,11,11,11,11,11,11});
        board.add(new List<integer>{12,13,14,15,16,14,13,12});

        for(Integer i=0;i<8;i++)
        {
            chessBoardRecords[i].row__c=i+1;
            chessBoardRecords[i].A__c = board[i][0];
            chessBoardRecords[i].B__c = board[i][1];
            chessBoardRecords[i].C__c = board[i][2];
            chessBoardRecords[i].D__c = board[i][3];
            chessBoardRecords[i].E__c = board[i][4];
            chessBoardRecords[i].F__c = board[i][5];
            chessBoardRecords[i].G__c = board[i][6];
            chessBoardRecords[i].H__c = board[i][7];

            update chessBoardRecords[i];
        }

        delete [SELECT Id FROM chessBoardMove__c];
        
    }
     
    public static void updateChessBoardRecord(Integer fromX, Integer fromY, Integer toX, Integer toY) 
    {
        setValueAt(toX,toY,getValueAt(fromX,fromY));
        update chessBoardRecords[tox];

        setValueAt(fromX,fromY,0);
        update chessBoardRecords[fromX];
    }

    @RemoteAction
    public static String updateBoard(Integer fromX, Integer fromY, Integer toX, Integer toY) {
        initialize_board();
        System.debug('entered update board');
        System.debug('x= '+fromX+', y='+fromY+'; 1st='+board[fromX][fromY]+', p='+toX+', q='+toY+'; 2nd='+board[toX][toY]);
        system.debug(math.mod(board[fromX][fromY],10));

        Boolean check_if_valid=false;
        
        switch on math.mod(board[fromX][fromY],10)
        {
            when 1
            {
                Pawn pawn=new Pawn();
                pawn.path(fromX, fromY);
                if(avail_array.contains(new pair(toX,toY)))
                {
                    System.debug('contain pawn');
                    updateChessBoardRecord(fromX,fromY,toX,toY);
                    check_if_valid=true;
                }
            }
            when 2
            {
                Rock rock=new Rock();
                rock.path(fromX, fromY);
                if(avail_array.contains(new pair(toX,toY)))
                {
                    System.debug('contain rock');
                    updateChessBoardRecord(fromX,fromY,toX,toY);
                    check_if_valid=true;
                }
            }
            when 3
            {
                Knight knight=new Knight();
                knight.path(fromX, fromY);
                if(avail_array.contains(new pair(toX,toY)))
                {
                    System.debug('contain knight');
                    updateChessBoardRecord(fromX,fromY,toX,toY);
                    check_if_valid=true;
                }
            }
            when 4
            {
                Bishop bishop =new Bishop();
                bishop.path(fromX, fromY);
                if(avail_array.contains(new pair(toX,toY)))
                {
                    System.debug('contain bishop');
                    updateChessBoardRecord(fromX,fromY,toX,toY);
                    check_if_valid=true;
                }
            }
            when 5
            {
                Queen queen=new Queen();
                queen.path(fromX, fromY);
                if(avail_array.contains(new pair(toX,toY)))
                {
                    System.debug('contain queen');
                    updateChessBoardRecord(fromX,fromY,toX,toY);
                    check_if_valid=true;
                }
            }
            when 6
            {
                King king=new King();
                king.path(fromX, fromY);
                if(avail_array.contains(new pair(toX,toY)))
                {
                    System.debug('contain king');
                    updateChessBoardRecord(fromX,fromY,toX,toY);
                    check_if_valid=true;
                }
            }
        }

        if(check_if_valid)
        {
            integer count =[select count() from chessBoardMove__c];

            chessBoardMove__c new_move=new chessBoardMove__c();

            new_move.row__c=count+1;
            new_move.color__c=board[fromX][fromY]/10;
            new_move.piece_type__c=math.mod(board[fromX][fromY],10);
            new_move.from_x__c=fromX;
            new_move.from_y__c=fromY;
            new_move.to_x__c=toX;
            new_move.to_y__c=toY;
            new_move.capture__c=board[toX][toY];
            new_move.check__c= check;

            insert new_move;


            return 'okay';
        }
        
        system.debug(avail_array);
        system.debug('enteret update board '+fromX+','+fromY + ',' +',' +toX + ',' +toY);

        return 'no need to update';
    }

    @RemoteAction
    public static pair_list updateAvailable(Integer fromX, Integer fromY) {
        initialize_board();
        System.debug('entered update board');
        System.debug('x= '+fromX+', y='+fromY+'; 1st='+board[fromX][fromY]);
        system.debug(math.mod(board[fromX][fromY],10));
        
        switch on math.mod(board[fromX][fromY],10)
        {
            when 1
            {
                Pawn pawn=new Pawn();
                pawn.path(fromX, fromY);
            }
            when 2
            {
                Rock rock=new Rock();
                rock.path(fromX, fromY);
            }
            when 3
            {
                Knight knight=new Knight();
                knight.path(fromX, fromY);
            }
            when 4
            {
                Bishop bishop =new Bishop();
                bishop.path(fromX, fromY);
            }
            when 5
            {
                Queen queen=new Queen();
                queen.path(fromX, fromY);
            }
            when 6
            {
                King king=new King();
                king.path(fromX, fromY);
            }
        }
        system.debug('enteret update board '+fromX+','+fromY);

        return new pair_list(avail_array,enemy_array);
    }   



    public abstract class pieces{
        // integer num;
        // string color{get;set;}
        // string name;
        integer n=0;
        public string temp;
        public abstract void path(integer x, integer y);
        
        public string valid_check(integer x,integer y,integer p,integer q){
            if(p<0 || p>7 || q<0 || q>7)
            {
                return 'next';
            }
            if(board[p][q]==0)
            {
                avail_array.add(new pair(p,q));
                return 'next';
            }
            else
            {
                if(board[x][y]/10 == board[p][q]/10)
                {
                    return 'block';
                }
                else {
                    avail_array.add(new pair(p,q));
                    if (math.mod(board[p][q],10)==6) {
                        check=1;
                    }
                    enemy_array.add(new pair(p,q));
                    return 'attack';
                }
            }
        }
        
        
        
    }
    
    public class Pawn extends pieces{
        public override void path(integer x, integer y){
            if(board[x][y]<10) //black
            {
                if (x==1  && board[x+2][y]==0) {
                    valid_check(x, y, x+2, y);
                }
                if (x<7) {
                    if (board[x+1][y]==0) {
                        valid_check(x, y, x+1, y);
                    }
                
                    if (y<7 && board[x+1][y+1]>10){
                        valid_check(x, y, x+1, y+1);
                    }
                    if (y>0 && board[x+1][y-1]>10){
                        valid_check(x, y, x+1, y-1);
                    }
                }
                // if(x==6)
                // {
                //     //promote
                // }
            }
            else if(board[x][y]>10) //white
            {
                if (x==6  && board[x-2][y]==0) {
                    valid_check(x, y, x-2, y);
                }
                if (x>0) {
                    if (board[x-1][y]==0) {
                        valid_check(x, y, x-1, y);
                    }
                
                    if (y<7 && board[x-1][y+1]<10 && board[x-1][y+1]!=0){
                        valid_check(x, y, x-1, y+1);
                    }
                    if (y>0 && board[x-1][y-1]<10 && board[x-1][y-1]!=0){
                        valid_check(x, y, x-1, y-1);
                    }
                }
                // if(x==6)
                // {
                //     //promote
                // }
            }
        }
    }
    
    public class Rock extends pieces{
        public override void path(integer x, integer y){
            for(n=1; x-n>=0; n++)
            {
                temp=valid_check(x, y, x-n, y);
                if (temp!='next') {
                    break;
                }
            }
            for(n=1; x+n<=7; n++)
            {
                temp=valid_check(x, y, x+n, y);
                if (temp!='next') {
                    break;
                }
            }
            for(n=1; y-n>=0; n++)
            {
                temp=valid_check(x, y, x, y-n);
                if (temp!='next') {
                    break;
                }
            }
            for(n=1; y+n<=7; n++)
            {
                temp=valid_check(x, y, x, y+n);
                if (temp!='next') {
                    break;
                }
            }
        }
    }
    
    public class Knight extends pieces{
        public override void path(integer x, integer y){
            valid_check(x, y,x-2,y-1);
            valid_check(x, y,x-1,y-2);
            valid_check(x, y,x+1,y-2);
            valid_check(x, y,x+2,y-1);
            valid_check(x, y,x-2,y+1);
            valid_check(x, y,x-1,y+2);
            valid_check(x, y,x+1,y+2);
            valid_check(x, y,x+2,y+1);
        }
    }
    
    public class Bishop extends pieces{
        public override void path(integer x, integer y){
            for(n=1; x-n>=0 && y-n>=0; n++)
            {
                temp=valid_check(x, y, x-n, y-n);
                if(temp!='next')
                {
                    break;
                }
            }
            for(n=1; x+n<=7 && y-n>=0; n++)
            {
                temp=valid_check(x, y, x+n, y-n);
                if(temp!='next')
                {
                    break;
                }
            }
            for(n=1; x+n<=7 && y+n<=7; n++)
            {
                temp=valid_check(x, y, x+n, y+n);
                if(temp!='next')
                {
                    break;
                }
            }
            for(n=1; x-n>=0 && y+n<=7; n++)
            {
                temp=valid_check(x, y, x-n, y+n);
                if(temp!='next')
                {
                    break;
                }
            }
        }
    }
    
    public class Queen extends pieces{
        public override void path(integer x, integer y){
            new rock().path( x,  y);
            new bishop().path( x,  y);
        }
    }
    
    public class King extends pieces{
        public override void path(integer x, integer y){
            valid_check(x, y,x-1,y-1);
            valid_check(x, y,x-1,y);
            valid_check(x, y,x-1,y+1);
            valid_check(x, y,x,y-1);
            valid_check(x, y,x,y+1);
            valid_check(x, y,x+1,y-1);
            valid_check(x, y,x+1,y);
            valid_check(x, y,x+1,y+1);
        }
    }
    
    public class start_game{
        // black    0
        // white    1

        // Pawn pawn=new Pawn();           // 1
        // Rock rock=new Rock();           // 2
        // Knight knight=new Knight();     // 3
        // Bishop bishop =new Bishop();    // 4
        // Queen queen=new Queen();        // 5
        // King king=new King();           // 6

        // public void piece_move(integer a,integer b,integer p,integer q){

        //     
        // }
    }
}
