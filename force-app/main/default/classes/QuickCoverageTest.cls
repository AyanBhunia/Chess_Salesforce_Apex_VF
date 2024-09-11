@isTest
public class QuickCoverageTest {
    static string a;
    @testSetup
    static void setupTestData() {
        List<chessBoard__c> testData = new List<chessBoard__c>{
            new chessBoard__c(row__c = 1, A__c = 2, B__c = 3, C__c = 4, D__c = 5, E__c = 6, F__c = 4, G__c = 3, H__c = 2),
            new chessBoard__c(row__c = 2, A__c = 1, B__c = 1, C__c = 1, D__c = 0, E__c = 1, F__c = 1, G__c = 1, H__c = 1),
            new chessBoard__c(row__c = 3, A__c = 0, B__c = 0, C__c = 0, D__c = 0, E__c = 0, F__c = 0, G__c = 0, H__c = 0),
            new chessBoard__c(row__c = 4, A__c = 0, B__c = 0, C__c = 0, D__c = 1, E__c = 0, F__c = 0, G__c = 0, H__c = 0),
            new chessBoard__c(row__c = 5, A__c = 0, B__c = 0, C__c = 0, D__c = 0, E__c = 0, F__c = 11, G__c = 0, H__c = 0),
            new chessBoard__c(row__c = 6, A__c = 0, B__c = 0, C__c = 0, D__c = 0, E__c = 0, F__c = 0, G__c = 0, H__c = 0),
            new chessBoard__c(row__c = 7, A__c = 11, B__c = 11, C__c = 11, D__c = 11, E__c = 11, F__c = 0, G__c = 11, H__c = 11),
            new chessBoard__c(row__c = 8, A__c = 12, B__c = 13, C__c = 14, D__c = 15, E__c = 16, F__c = 14, G__c = 13, H__c = 12)
        };
        insert testData;
    }

    @isTest
    static void testAllMethods() {
        Test.startTest();
        
        Chess.updateAvailable(0,1);
        Chess.updateAvailable(0,2);
        Chess.updateAvailable(0,3);
        Chess.updateAvailable(0,4);
        Chess.updateAvailable(0,5);
        Chess.updateAvailable(0,6);
        Chess.updateAvailable(0,7);
        Chess.updateAvailable(7,1);
        Chess.updateAvailable(7,2);
        Chess.updateAvailable(7,3);
        Chess.updateAvailable(7,4);
        Chess.updateAvailable(7,5);
        Chess.updateAvailable(7,6);
        Chess.updateAvailable(7,7);
        Chess.updateAvailable(1,1);
        Chess.updateAvailable(6,1);
        
        Test.stopTest();
    }

    @isTest
    static void testErrorHandling() {
        Test.startTest();
        a=Chess.share_fen();
        Test.stopTest();
    }
    
    @isTest
    static void dfdfdf234() {
        Test.startTest();
        Chess.back_back();
        Test.stopTest();
    }
    
    @isTest
    static void dfdfdfdggfd234() {
        Test.startTest();
        Chess.check_for_check();
        Test.stopTest();
    }
    
    @isTest
    static void dfdfdfdggfdd234() {
        Test.startTest();
        Chess.previous_moves_data();
        Test.stopTest();
    }

    @isTest
    static void dfdfdfdggfddFG234() {
        Test.startTest();
        Chess.setnewboard();
        Test.stopTest();
    }

    @isTest
    static void dfdfdfdggfddFsG234() {
        Test.startTest();
        Chess.updateBoard(6,4,4,4,1);
        Chess.updateBoard(1,5,3,5,0);
        Chess.updateBoard(7,3,3,7,1);
        Chess.updateBoard(1,6,2,6,0);
        Chess.updateBoard(3,7,5,7,1);
        Chess.updateBoard(6,1,4,1,0);
        Chess.updateBoard(1,1,3,1,0);
        Test.stopTest();
    }

    @isTest
    static void dfdfdfdggfddFssG234() {
        Test.startTest();
        Chess.getPieceSymbol(6);
        Test.stopTest();
    }
}