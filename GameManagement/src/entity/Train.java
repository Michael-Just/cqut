package entity;

public class Train {
    private int tno;
    private String sname;
    private String tname;
    private String tstarttime;
    private String tendtime;

    public int getTno() {
        return tno;
    }

    public void setTno(int tno) {
        this.tno = tno;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname;
    }

    public String getTstarttime() {
        return tstarttime;
    }

    public void setTstarttime(String tstarttime) {
        this.tstarttime = tstarttime;
    }

    public String getTendtime() {
        return tendtime;
    }

    public void setTendtime(String tendtime) {
        this.tendtime = tendtime;
    }

    @Override
    public String toString() {
        return "{" +
                "tno=" + tno +
                ", sname='" + sname + '\'' +
                ", tname='" + tname + '\'' +
                ", tstarttime='" + tstarttime + '\'' +
                ", tendtime='" + tendtime + '\'' +
                '}';
    }
}
