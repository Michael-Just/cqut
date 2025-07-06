package entity;

public class Grade {
    private String tname;

    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname;
    }

    @Override
    public String toString() {
        return "{" +
                "tname='" + tname + '\'' +
                '}';
    }
}
