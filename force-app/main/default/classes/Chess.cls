public class Chess {

    public class pair {
        public Integer x;
        public integer y;
        
        public Pair(Integer x, Integer y) {
            this.x = x;
            this.y = y;
        }

        public Integer getX() {
            return x;
        }

        public Integer getY() {
            return y;
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
        public list<pair> list_z;

        public pair_list(list<pair> list_x, list<pair> list_y, list<pair> list_z) {
            this.list_x = list_x;
            this.list_y = list_y;
            this.list_z=list_z;
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
    public static List<pair> avail_2nd_array = new List<pair>();
    
    public static Integer game_type=0; // game type 0 - normal, 1 - portal
    
    public static pair check {get;set;}
    public static List<Integer> list_to_iterate{get;set;}
    
    public static List<List<integer>> board {get;set;}
    public static List<chessBoard__c> chessBoardRecords = new List<chessBoard__c>();

    public static list<chessBoardMove__c> chess_moves {get;set;}
    public static List<String> blacklist {get;set;}
    public static List<String> whitelist {get;set;}

    public Chess(){
        initialize_board();
        initialize_board_moves();
    }

    public static void initialize_board(){
        chessBoardRecords = [SELECT row__c,A__c, B__c, C__c, D__c,E__c,F__c,G__c,H__c FROM chessBoard__c ORDER BY row__c ASC];

        board= new List<List<integer>>();
        list_to_iterate = new List<Integer>{0,1,2,3,4,5,6,7};

        for (chessBoard__c record : chessBoardRecords) {
            List<Integer> row = new List<Integer>{(Integer)record.A__c, (Integer)record.B__c, (Integer)record.C__c, (Integer)record.D__c, (Integer)record.E__c, (Integer)record.F__c,(Integer) record.G__c, (Integer)record.H__c};
            board.add(row);
        }

        check=new pair(0,0); // black,white 
    }

    public static void initialize_board_moves(){
        chess_moves =new list<chessBoardMove__c>();
        chess_moves= [SELECT row__c,color__c, piece_type__c, text__c,capture__c,check__c FROM chessBoardMove__c ORDER BY name ASC];

        if (chess_moves.size()>0) {
            check=new pair((Integer)chess_moves[chess_moves.size()-1].check__c/10,(Integer)chess_moves[chess_moves.size()-1].check__c);
        }
        

        system.debug(check);   

        blacklist=new List<String>();
        whitelist=new List<String>();
        for (chessBoardMove__c row : chess_moves) {
            if (row.capture__c!=0) {
                if (row.color__c==1) {
                    blacklist.add(getPieceSymbol((Integer)row.capture__c));
                }
                else {
                    whitelist.add(getPieceSymbol((Integer)row.capture__c+10));
                }
            }
        }
    }

    @RemoteAction
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
        
        initialize_board_moves();
    }

    @RemoteAction
    public static Integer chech_if_board_okay()
    {
        integer c=[SELECT count() FROM chessBoard__c];
        if(c!=8)
        {
            delete [SELECT id FROM chessBoard__c];
            board= new List<List<integer>>();
            List<chessBoard__c> testData = new List<chessBoard__c>{
                new chessBoard__c(row__c = 1, A__c = 2, B__c = 3, C__c = 4, D__c = 5, E__c = 6, F__c = 4, G__c = 3, H__c = 2),
                new chessBoard__c(row__c = 2, A__c = 1, B__c = 1, C__c = 1, D__c = 1, E__c = 1, F__c = 1, G__c = 1, H__c = 1),
                new chessBoard__c(row__c = 3, A__c = 0, B__c = 0, C__c = 0, D__c = 0, E__c = 0, F__c = 0, G__c = 0, H__c = 0),
                new chessBoard__c(row__c = 4, A__c = 0, B__c = 0, C__c = 0, D__c = 0, E__c = 0, F__c = 0, G__c = 0, H__c = 0),
                new chessBoard__c(row__c = 5, A__c = 0, B__c = 0, C__c = 0, D__c = 0, E__c = 0, F__c = 0, G__c = 0, H__c = 0),
                new chessBoard__c(row__c = 6, A__c = 0, B__c = 0, C__c = 0, D__c = 0, E__c = 0, F__c = 0, G__c = 0, H__c = 0),
                new chessBoard__c(row__c = 7, A__c = 11, B__c = 11, C__c = 11, D__c = 11, E__c = 11, F__c = 11, G__c = 11, H__c = 11),
                new chessBoard__c(row__c = 8, A__c = 12, B__c = 13, C__c = 14, D__c = 15, E__c = 16, F__c = 14, G__c = 13, H__c = 12)
            };
            insert testData;

            return 1;
        }

        return 0;
    }

    @RemoteAction
    public static list<chessBoardMove__c> previous_moves_data()
    {
        chess_moves =new list<chessBoardMove__c>();
        chess_moves= [select row__c ,color__c, check__c,from_x__c,from_y__c,to_x__c,to_y__c from chessBoardMove__c ORDER BY row__c DESC limit 1];

        return chess_moves;
    }

    @RemoteAction
    public static void back_back()
    {
        initialize_board();

        chess_moves =new list<chessBoardMove__c>();
        chess_moves= [SELECT row__c,color__c, from_x__c,from_y__c,to_x__c,to_y__c,capture__c,check__c FROM chessBoardMove__c ORDER BY row__c DESC LIMIT 1];
        
        if (chess_moves.size()==0) {
            return;
        }

        setValueAt((Integer)chess_moves[0].from_x__c,(Integer)chess_moves[0].from_y__c,getValueAt((Integer)chess_moves[0].to_x__c,(Integer)chess_moves[0].to_y__c));
        setValueAt((Integer)chess_moves[0].to_x__c,(Integer)chess_moves[0].to_y__c,(Integer)chess_moves[0].capture__c);

        update chessBoardRecords[(Integer)chess_moves[0].to_x__c];
        update chessBoardRecords[(Integer)chess_moves[0].from_x__c];

        delete chess_moves[0];
    }
     

    public static void check_if_check()
    {
        
        Integer b_king_check = 0;
        Integer w_king_check = 0;
        check.x=0;
        check.y=0;

        King king=new King();

        integer t=2;
        for (Integer x = 0; x < 8 && t!=0; x++) {
            for (Integer y = 0; y < 8 && t!=0; y++) {
                if (board[x][y]==6) // check for black
                { 
                    b_king_check=king.check_check(0, x, y);
                    t=t-1;
                    if (b_king_check==1) {
                        check.x=1;
                    }
                }
                if (board[x][y]==16) // check for white
                {
                    w_king_check=king.check_check(1, x, y);
                    t=t-1;
                    if (w_king_check==1) {
                        check.y=1;
                    }
                }
            }
        }
    }

    @RemoteAction
    public static String updateBoard(Integer fromX, Integer fromY, Integer toX, Integer toY, Integer cvalue) {

        
        initialize_board();
        if(board[fromX][fromy]/10 != cvalue)
        {
            return 'need to update';
        }
        
        find_available_positions(fromX, fromY);
        
        toX=Math.mod(ToX+8,8);

        if(avail_array.contains(new pair(toX,toY)) || avail_2nd_array.contains(new pair(toX,toY)))
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
            new_move.capture__c=math.mod(board[toX][toY],10);
            new_move.check__c= 0;

            setValueAt(toX,toY,getValueAt(fromX,fromY));
            setValueAt(fromX,fromY,0);
            board[tox][toY]=board[fromX][fromY];
            board[fromX][fromY]=0;
            
            if(game_type==0)
            {
            	check_if_check();
            }
            
            system.debug('check '+check);
            system.debug(new_move);
            if (check.x==1) {
                if (new_move.color__c == 0) {
                    System.debug('black is gone in self check ');
                    return 'need to update';
                }
                else {
                    System.debug('black got check ');
                    new_move.check__c+=10;
                }
            }
            else if (check.y==1) {
                if (new_move.color__c == 1) {
                    System.debug('white is gone in self check ');
                    return 'need to update';
                }
                else {
                    System.debug('white got check ');
                    new_move.check__c+=1;
                }
            }
            
            update chessBoardRecords[tox];
            update chessBoardRecords[fromX];
            insert new_move; 

            system.debug('inserted new move'); 

            string fen = board_to_fen(String.valueof(new_move.row__c),(Integer)new_move.color__c);

            return check.x+''+check.y+' '+fen;
        }
        
        // system.debug(avail_array);
        // system.debug('enteret update board '+fromX+','+fromY + ',' +',' +toX + ',' +toY);

        return 'need to update';
    }

    @RemoteAction
    public static String postChessData(String data) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://chess-api.com/v1'); // Replace with your API endpoint
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(data);

        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            return response.getBody();
        } else {
            throw new AuraHandledException('Error from API: ' + response.getStatus() + ' - ' + response.getStatusCode());
        }
    }


    @RemoteAction
    public static pair_list updateAvailable(Integer fromX, Integer fromY) {

        
        initialize_board();
        find_available_positions(fromX, fromY);
        
        // system.debug('enteret update available '+fromX+','+fromY);

        return new pair_list(avail_array,enemy_array,avail_2nd_array);
    }   

    public static void find_available_positions(Integer fromX, Integer fromY)
    {
        // System.debug('entered avaiable');
        // System.debug('x= '+fromX+', y='+fromY+'; 1st='+board[fromX][fromY]);
        // system.debug(math.mod(board[fromX][fromY],10));
        
        switch on math.mod(board[fromX][fromY],10)
        {
            when 1
            {
                Pawn pawn=new Pawn();
                pawn.path(board[fromX][fromY]/10,fromX, fromY);
            }
            when 2
            {
                Rock rock=new Rock();
                rock.path(board[fromX][fromY]/10,fromX, fromY);
            }
            when 3
            {
                Knight knight=new Knight();
                knight.path(board[fromX][fromY]/10,fromX, fromY);
            }
            when 4
            {
                Bishop bishop =new Bishop();
                bishop.path(board[fromX][fromY]/10,fromX, fromY);
            }
            when 5
            {
                Queen queen=new Queen();
                queen.path(board[fromX][fromY]/10,fromX, fromY);
            }
            when 6
            {
                King king=new King();
                king.path(board[fromX][fromY]/10,fromX, fromY);
            }
        }
    }

    @RemoteAction
    public static string share_fen()
    {
        initialize_board();
        chess_moves =new list<chessBoardMove__c>();
        chess_moves= [select row__c ,color__c from chessBoardMove__c ORDER BY row__c DESC limit 1];

        String tottal_moves='0';
        Integer color=0;

        if (chess_moves.size()>0)
        {
            tottal_moves=String.valueof(chess_moves[0].row__c);
            color=(Integer)chess_moves[0].color__c;
        }


        return board_to_fen(tottal_moves,color);
    }

    public static string board_to_fen(string move_count, integer color)
    {
        string fen='';
        integer x,y,count;
        for(x=0;x<8;x++)
        {
            count=0;
            for(y=0;y<8;y++)
            {
                if (board[x][y]==0) {
                    count+=1;
                } 
                else {
                    if(count>0)
                    {
                        fen+=count+'';
                        count=0;
                    }
                    
                    switch on board[x][y]
                    {
                        when 1 {
                            fen+='p'; count=0; // Black Pawn
                        }
                        when 2 {
                            fen+='r'; count=0; // Black Rook
                        }
                        when 3 {
                            fen+='n'; count=0; // Black Knight
                        }
                        when 4 {
                            fen+='b'; count=0; // Black Bishop
                        }
                        when 5 {
                            fen+='q'; count=0; // Black Queen
                        }
                        when 6 {
                            fen+='k'; count=0; // Black King
                        }
                        when 11 {
                            fen+='P'; count=0; // White Pawn
                        }
                        when 12 {
                            fen+='R'; count=0; // White Rook
                        }
                        when 13 {
                            fen+='N'; count=0; // White Knight
                        }
                        when 14 {
                            fen+='B'; count=0; // White Bishop
                        }
                        when 15 {
                            fen+='Q'; count=0; // White Queen
                        }
                        when 16 {
                            fen+='K'; count=0; // White King
                        }
                    }
                }
            }
            if(count>0)
            {
                fen+=count+'';
                count=0;
            }
            if (x<7) {
                fen+='/';
            }
        }
        fen+=' ';
        fen+=color==1?'b':'w';
        fen+=' - - 0 ';
        if(move_count=='0')
        {
            fen+='1';
        }
        else {
            fen+=move_count;   
        }

        // System.debug(board);
        // System.debug(fen);

        return fen;
    }

    @RemoteAction
    public static string check_for_check()
    {
        initialize_board();
        check_if_check();
        return check.x+''+check.y;
    }


    public abstract class pieces{
        // integer num;
        // string color{get;set;}
        // string name;
        integer n=0;
        public string temp;
        public abstract void path(integer color,integer x, integer y);
        
        public string valid_check(integer color,integer x,integer y,integer p,integer q){
            
                system.debug(p);
            if(p>=0 && p<=7)
            {
            system.debug('sdsdsdsdsd');
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
                    if(color == board[p][q]/10)
                    {
                        return 'block';
                    }
                    else {
                        avail_array.add(new pair(p,q));
                        enemy_array.add(new pair(p,q));
                        return 'attack';
                    }
                }
            }
            system.debug('dfg');
            if(game_type==1)
            {
                
                system.debug('jjj'+q);
                if(p<-8 || p>15 || q<0 || q>7)
                {
                    return 'next';
                }

                p=math.mod(p+8,8);

                if(board[p][q]==0)
                {
                    avail_2nd_array.add(new pair(p,q));
                    return 'next';
                }
                else
                {
                    if(color == board[p][q]/10)
                    {
                        return 'block';
                    }
                    else {
                        // avail_array.add(new pair(p,q));
                        // enemy_array.add(new pair(p,q));
                        return 'attack';
                    }
                }
            }
                return 'else';
            
        }
        
        
        
        
    }
    
    public class Pawn extends pieces{
        public override void path(integer color,integer x, integer y){
            if(color==0) //black
            {
                if (x==1  && board[x+2][y]==0 && board[x+1][y]==0) {
                    valid_check(color,x, y, x+2, y);
                }
                if (x<7) {
                    if (board[x+1][y]==0) {
                        valid_check(color,x, y, x+1, y);
                    }
                
                    if (y<7 && board[x+1][y+1]>10){
                        valid_check(color,x, y, x+1, y+1);
                    }
                    if (y>0 && board[x+1][y-1]>10){
                        valid_check(color,x, y, x+1, y-1);
                    }
                }
                // if(x==6)
                // {
                //     //promote
                // }
            }
            else if(color==1) //white
            {
                if (x==6  && board[x-2][y]==0 && board[x-1][y]==0) {
                    valid_check(color,x, y, x-2, y);
                }
                if (x>0) {
                    if (board[x-1][y]==0) {
                        valid_check(color,x, y, x-1, y);
                    }
                
                    if (y<7 && board[x-1][y+1]<10 && board[x-1][y+1]!=0){
                        valid_check(color,x, y, x-1, y+1);
                    }
                    if (y>0 && board[x-1][y-1]<10 && board[x-1][y-1]!=0){
                        valid_check(color,x, y, x-1, y-1);
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
        public override void path(integer color,integer x, integer y){
            for(n=1; x-n>=-8; n++)
            {
                temp=valid_check(color,x, y, x-n, y);
                if (temp!='next') {
                    break;
                }
            }
            for(n=1; x+n<=15; n++)
            {
                temp=valid_check(color,x, y, x+n, y);
                if (temp!='next') {
                    break;
                }
            }
            for(n=1; y-n>=0; n++)
            {
                temp=valid_check(color,x, y, x, y-n);
                if (temp!='next') {
                    break;
                }
            }
            for(n=1; y+n<=7; n++)
            {
                temp=valid_check(color,x, y, x, y+n);
                if (temp!='next') {
                    break;
                }
            }
        }
    }
    
    public class Knight extends pieces{
        public override void path(integer color,integer x, integer y){
            valid_check(color,x, y,x-2,y-1);
            valid_check(color,x, y,x-1,y-2);
            valid_check(color,x, y,x+1,y-2);
            valid_check(color,x, y,x+2,y-1);
            valid_check(color,x, y,x-2,y+1);
            valid_check(color,x, y,x-1,y+2);
            valid_check(color,x, y,x+1,y+2);
            valid_check(color,x, y,x+2,y+1);
        }
    }
    
    public class Bishop extends pieces{
        public override void path(integer color,integer x, integer y){
            for(n=1; x-n>=-8 || y-n>=0; n++)
            {
                temp=valid_check(color,x, y, x-n, y-n);
                if(temp!='next')
                {
                    break;
                }
            }
            for(n=1; x+n<=15 || y-n>=0; n++)
            {
                temp=valid_check(color,x, y, x+n, y-n);
                if(temp!='next')
                {
                    break;
                }
            }
            for(n=1; x+n<=-8 || y+n<=7; n++)
            {
                temp=valid_check(color,x, y, x+n, y+n);
                if(temp!='next')
                {
                    break;
                }
            }
            for(n=1; x-n>=15 || y+n<=7; n++)
            {
                temp=valid_check(color,x, y, x-n, y+n);
                if(temp!='next')
                {
                    break;
                }
            }
        }
    }
    
    public class Queen extends pieces{
        public override void path(integer color,integer x, integer y){
            new Rock().path( color, x,  y);
            new Bishop().path( color, x,  y);
        }
    }
    
    public class King extends pieces{
        public override void path(integer color,integer x, integer y){
            valid_check(color,x, y,x-1,y-1);
            valid_check(color,x, y,x-1,y);
            valid_check(color,x, y,x-1,y+1);
            valid_check(color,x, y,x,y-1);
            valid_check(color,x, y,x,y+1);
            valid_check(color,x, y,x+1,y-1);
            valid_check(color,x, y,x+1,y);
            valid_check(color,x, y,x+1,y+1);
        }

        public integer check_check(integer color,integer x,integer y){
            enemy_array.clear();
            new Rock().path( color, x,  y);
            for (pair t : enemy_array) {
                if (color==1 && (board[t.x][t.y]==2 || board[t.x][t.y]==5) || 
                color==0 && (board[t.x][t.y]==12 || board[t.x][t.y]==15)) {
                    return 1;
                }
            }
            enemy_array.clear();

            new Knight().path( color, x,  y);
            for (pair t : enemy_array) {
                if (color==1 && (board[t.x][t.y]==3) || 
                color==0 && (board[t.x][t.y]==13)) {
                    return 1;
                }
            }
            enemy_array.clear();

            new Bishop().path( color, x,  y);
            for (pair t : enemy_array) {
                if (color==1 && (board[t.x][t.y]==4 || board[t.x][t.y]==5) || 
                color==0 && (board[t.x][t.y]==14 || board[t.x][t.y]==15)) {
                    return 1;
                }
            }
            enemy_array.clear();

            new Pawn().path( color, x,  y);
            for (pair t : enemy_array) {
                if (color==1 && (board[t.x][t.y]==1) || 
                color==0 && (board[t.x][t.y]==11)) {
                    return 1;
                }
            }
            enemy_array.clear();

            new King().path( color, x,  y);
            for (pair t : enemy_array) {
                if (color==1 && (board[t.x][t.y]==6) || 
                color==0 && (board[t.x][t.y]==16)) {
                    return 1;
                }
            }

            return 0;
        }
    }
    
}