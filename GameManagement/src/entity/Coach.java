package entity;

public class Coach {
    private String cno;
    private String cname;
    private String cage;

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

    public String getCage() {
        return cage;
    }

    public void setCage(String cage) {
        this.cage = cage;
    }

    @Override
    public String toString() {
        return "{" +
                "cno='" + cno + '\'' +
                ", cname='" + cname + '\'' +
                ", cage='" + cage + '\'' +
                '}';
    }
}
