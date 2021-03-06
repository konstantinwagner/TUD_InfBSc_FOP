package freezer.interiors;

import freezer.Freezer;

/**
 * Represents a standard interior
 *
 * @author Alexander Siegler
 * @author Paul Konstantin Wagner
 * @author lost
 * @author Marcel Lackovic
 */
public class Standard extends Interior {
    /**
     * Create a new instance of class Interior using a pre-defined article number and price
     *
     * @param freezer The freezer the interior should fit into
     */
    public Standard(Freezer freezer) {
        super("S", freezer.getInnerVolume() * 0.8);
    }
}
