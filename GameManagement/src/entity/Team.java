package entity;

public class Team {
    private String tname;
    private String cno;
    private String cname;
    private String tcity;
    private String ttime;

    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname;
    }

    public String getCno() {
        return cno;
    }

    public void setCno(String cno) {
        this.cno = cno;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getTcity() {
        return tcity;
    }

    public void setTcity(String tcity) {
        this.tcity = tcity;
    }

    public String getTtime() {
        return ttime;
    }

    public void setTtime(String ttime) {
        this.ttime = ttime;
    }

    @Override
    public String toString() {
        return "{" +
                "tname='" + tname + '\'' +
                ", cno='" + cno + '\'' +
                ", cname='" + cname + '\'' +
                ", tcity='" + tcity + '\'' +
                ", ttime='" + ttime + '\'' +
                '}';
    }
}
