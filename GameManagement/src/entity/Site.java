package entity;

public class Site {
    private String Sname;
    private String Sscale;
    private String Sposition;

    public String getSname() {
        return Sname;
    }

    public void setSname(String sname) {
        Sname = sname;
    }

    public String getSscale() {
        return Sscale;
    }

    public void setSscale(String sscale) {
        Sscale = sscale;
    }

    public String getSposition() {
        return Sposition;
    }

    public void setSposition(String sposition) {
        Sposition = sposition;
    }

    @Override
    public String toString() {
        return "{" +
                "Sname='" + Sname + '\'' +
                ", Sscale='" + Sscale + '\'' +
                ", Sposition='" + Sposition + '\'' +
                '}';
    }
}
