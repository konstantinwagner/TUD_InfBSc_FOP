package bowling;

import org.junit.Before;
import org.junit.Test;

import java.util.Arrays;

import static org.junit.Assert.*;

/**
 * Represents a bowling game test. It tests bowling specific implementations
 *
 * @author Alexander Siegler
 * @author Paul Konstantin Wagner
 * @author lost
 * @author Marcel Lackovic
 */
public class BowlingTest {

    private Bowling bowling;
    //first player of each round
    private Player activePlayer;

    @Before
    public void setUp() throws Exception {
        bowling = new Bowling(4);
        bowling.addPlayer("Player1");
        bowling.addPlayer("Player2");
        bowling.addPlayer("Player3");

        bowling.startGame();

        activePlayer = bowling.getActivePlayer();
    }

    @Test
    public void testThrowNormal() {
        //test the start condition
        assertEquals("Throw number doesn't start with one", 1, bowling.getThrow());

        //you could also hit nothing
        assertTrue(bowling.throwBall(0));
        assertTrue(bowling.throwBall(3));
        assertEquals(0 + 3, bowling.getScore(activePlayer)[0]);

        //you could only do max 2 throws - so it should reset it for the next player
        assertEquals(1, bowling.getThrow());
        assertNotEquals(activePlayer, bowling.getActivePlayer());
    }

    @Test
    public void testSpare() {
        assertTrue(bowling.throwBall(5));
        assertTrue(bowling.throwBall(5));

        GameTest.skipRound(bowling);
        bowling.throwBall(3);
        bowling.throwBall(2);

        //current round counted as normal
        assertEquals(5 + 5, bowling.getScore(activePlayer)[0]);
        //for a spare the next throw is added on top to the 10 points
        assertEquals((5 + 5) + (3 + 2) + 3, bowling.getScore(activePlayer)[1]);
    }

    @Test
    public void testStrike() {
        assertTrue(bowling.throwBall(10));

        GameTest.skipRound(bowling);
        bowling.throwBall(3);
        bowling.throwBall(2);

        //current round counted as normal
        assertEquals(10, bowling.getScore(activePlayer)[0]);
        //for a strike the next two throws are added on top to the 10 points
        assertEquals(10 + (3 + 2) + (3 + 2), bowling.getScore(activePlayer)[1]);
    }

    @Test
    public void testLastRoundNormal() {
        GameTest.skipToLastRound(bowling);

        //test normal for the first player
        assertTrue(bowling.throwBall(3));
        assertTrue(bowling.throwBall(2));
        assertEquals(3 + 2, Arrays.stream(bowling.getScore(activePlayer)).sum());

        //should be the next player, because this wasn't a spare or strike - only two throws should be allowed
        assertNotEquals(activePlayer, bowling.getActivePlayer());
    }

    @Test
    public void lastRoundSpare() {
        GameTest.skipToLastRound(bowling);

        assertTrue(bowling.throwBall(5));
        assertTrue(bowling.throwBall(5));

        //could still make his/her third throw
        assertEquals(3, bowling.getThrow());
        assertTrue(bowling.throwBall(7));

        //on the last round the spare is counted as normal
        assertEquals((5 + 5) + 7, bowling.getScore(activePlayer)[9]);
    }

    @Test
    public void lastRoundStrike() {
        GameTest.skipToLastRound(bowling);

        assertTrue(bowling.throwBall(10));
        assertTrue(bowling.throwBall(10));

        //could still make his/her third throw
        assertEquals(3, bowling.getThrow());
        assertTrue(bowling.throwBall(10));

        //on the last round the strike is counted as normal
        assertEquals(3 * 10, bowling.getScore(activePlayer)[9]);
    }

    @Test
    public void testWinner() {
        for (int round = 1; round <= 10; round++) {
            //first player - spare always
            bowling.throwBall(5);
            bowling.throwBall(5);
            if (round == 10) {
                //on a spare you can make three throws in the last round
                bowling.throwBall(3);
            }

            //second player - strike always
            bowling.throwBall(10);
            if (round == 10) {
                //on a strike you can make three throws in the last round
                bowling.throwBall(2);
                bowling.throwBall(1);
            }

            //always skip the third player with zero points
            GameTest.skipRound(bowling);
        }

        assertEquals("Player2", bowling.getWinner().getName());
    }

    @Test
    public void testWinnerSame() {
        for (int round = 1; round <= 10; round++) {
            for (int i = 0; i < 2 * 3; i++) {
                bowling.throwBall(3);
            }
        }

        //same points it should return the first player
        assertEquals("Player1", bowling.getWinner().getName());
    }
}