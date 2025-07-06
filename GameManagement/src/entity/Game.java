package entity;

public class Game {
    private int gno;
    private String tname;
    private String sname;
    private String rno;
    private String rname;
    private String tname2;
    private String gtime;
    private String gscore;

    public int getGno() {
        return gno;
    }

    public void setGno(int gno) {
        this.gno = gno;
    }

    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public String getRno() {
        return rno;
    }

    public void setRno(String rno) {
        this.rno = rno;
    }

    public String getRname() {
        return rname;
    }

    public void setRname(String rname) {
        this.rname = rname;
    }

    public String getTname2() {
        return tname2;
    }

    public void setTname2(String tname2) {
        this.tname2 = tname2;
    }

    public String getGtime() {
        return gtime;
    }

    public void setGtime(String gtime) {
        this.gtime = gtime;
    }

    public String getGscore() {
        return gscore;
    }

    public void setGscore(String gscore) {
        this.gscore = gscore;
    }

    @Override
    public String toString() {
        return "{" +
                "gno=" + gno +
                ", tname='" + tname + '\'' +
                ", sname='" + sname + '\'' +
                ", rno='" + rno + '\'' +
                ", rname='" + rname + '\'' +
                ", tname2='" + tname2 + '\'' +
                ", gtime='" + gtime + '\'' +
                ", gscore='" + gscore + '\'' +
                '}';
    }
}
