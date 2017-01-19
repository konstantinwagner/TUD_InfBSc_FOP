package bowling;

import java.util.Arrays;
import java.util.function.Predicate;
import java.util.stream.Stream;

/**
 * Represents a game called 'Tannenbaum-Kegeln'
 *
 * @author Alexander Siegler
 * @author Paul Konstantin Wagner
 * @author Yoshua Hitzel
 * @author Marcel Lackovic
 */
public class TannenbaumKegeln extends Game {
    /**
     * Creates a new game instance with a game mode called 'Tannenbaum-Kegeln'
     *
     * @param maxPlayer The maximum number of players playing in this game
     */
    public TannenbaumKegeln(int maxPlayer) {
        super(maxPlayer);

        this.maxRounds = 100;
        this.maxPins = 9;
        this.maxThrows = 2;
        this.gameMode = "Tannenbaum-Kegeln";
    }

    @Override
    public boolean startGame() {
        if (super.startGame()) {
            this.scores = new int[this.activePlayersCounter][10];
            for (int i = 0; i < this.scores.length; i++)
                this.scores[i] = new int[]{0, 1, 2, 7, 6, 5, 4, 3, 2, 1};

            return true;
        }

        return false;
    }

    @Override
    protected void onThrow(int count) {
        if (this.getThrow() >= this.getMaxThrows(count)) {
            this.scores[this.getActivePlayer().getID()][this.getThrownPins()] -= (this.scores[this.getActivePlayer().getID()][this.getThrownPins()] > 0) ? 1 : 0;

            if (this.checkFirTree(this.getActivePlayer())) {
                // Set current player as winner
                this.finished = true;
                this.winner = this.getActivePlayer();
            }
        }
    }

    @Override
    protected int getMaxThrows(int count) {
        // Was this the last round or did the player achieve a strike?
        // NOTE: pinsLeft was used instead of maxPins to include spares
        if (this.pinsLeft == 0)
            return 0;
        else
            return super.getMaxThrows(count);
    }

    @Override
    public Player getWinner() {
        if (this.winner == null) {
            return getPlayerWithBestFirTree();
        } else
            return this.winner;
    }


    /**
     * Checks if a given user's firTree is empty (game aim)
     *
     * @param player the player whose firTree should be checked
     * @return true if the firTree is empty, false if there are still pending goals
     */
    private boolean checkFirTree(Player player) {
        return Stream.of(scores[player.getID()]).allMatch(Predicate.isEqual(0));
    }

    private Player getPlayerWithBestFirTree() {
        int bestPlayerId = 0, bestPlayerScore = -1;
        for (int i = 0; i < scores.length; i++) {
            int playerScore = Arrays.stream(scores[i]).sum();

            if ((playerScore < bestPlayerScore) || (bestPlayerScore == -1)) {
                bestPlayerId = i;
                bestPlayerScore = playerScore;
            }
        }

        return this.getPlayer(bestPlayerId);
    }
}