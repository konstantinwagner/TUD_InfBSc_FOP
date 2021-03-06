package freezer;

/**
 * Represents the energy efficiency class for a freezer
 *
 * @author Alexander Siegler
 * @author Paul Konstantin Wagner
 * @author lost
 * @author Marcel Lackovic
 */
public class EnergyClass {

    private final String name;
    private final double minEfficiency;

    /**
     * Creates a new energy class
     *
     * @param name name of this class type
     * @param minEfficiency the min efficiency that this class fulfills
     */
    public EnergyClass(String name, double minEfficiency) {
        this.name = name;
        this.minEfficiency = minEfficiency;
    }

    /**
     * Gets the minimal efficiency by this class
     *
     * @return minimal efficiency by this class
     */
    public double getMinEfficiency() {
        return minEfficiency;
    }

    @Override
    public String toString() {
        return name;
    }

    //this have to be public in order to provide access from the given StudentTests
    public static final EnergyClass Appp = new EnergyClass("A+++", 0.2);
    public static final EnergyClass App = new EnergyClass("A++", 0.18);
    public static final EnergyClass Ap = new EnergyClass("A+", 0.16);
    public static final EnergyClass A = new EnergyClass("A", 0.14);
    public static final EnergyClass B = new EnergyClass("B", 0.12);
    public static final EnergyClass C = new EnergyClass("C", 0.1);
    public static final EnergyClass D = new EnergyClass("D", 0);

    /**
     * Gets the efficiency class that reflects the given efficiency
     *
     * @param efficiency freezer efficiency
     * @return the energy efficiency class for the given efficiency
     */
    public static EnergyClass getEnergyClass(double efficiency) {
        if (efficiency >= EnergyClass.Appp.getMinEfficiency())
            return EnergyClass.Appp;
        else if (efficiency >= EnergyClass.App.getMinEfficiency())
            return EnergyClass.App;
        else if (efficiency >= EnergyClass.Ap.getMinEfficiency())
            return EnergyClass.Ap;
        else if (efficiency >= EnergyClass.A.getMinEfficiency())
            return EnergyClass.A;
        else if (efficiency >= EnergyClass.B.getMinEfficiency())
            return EnergyClass.B;
        else if (efficiency >= EnergyClass.C.getMinEfficiency())
            return EnergyClass.C;
        else
            return EnergyClass.D;
    }
}