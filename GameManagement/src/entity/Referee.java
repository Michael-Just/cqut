package entity;

public class Referee {
    private String rno;
    private String rage;
    private String rgrade;
    private String rname;

    public String getRno() {
        return rno;
    }

    public void setRno(String rno) {
        this.rno = rno;
    }

    public String getRage() {
        return rage;
    }

    public void setRage(String rage) {
        this.rage = rage;
    }

    public String getRgrade() {
        return rgrade;
    }

    public void setRgrade(String rgrade) {
        this.rgrade = rgrade;
    }

    public String getRname() {
        return rname;
    }

    public void setRname(String rname) {
        this.rname = rname;
    }

    @Override
    public String toString() {
        return "{" +
                "rno='" + rno + '\'' +
                ", rage='" + rage + '\'' +
                ", rgrade='" + rgrade + '\'' +
                ", rname='" + rname + '\'' +
                '}';
    }
}
