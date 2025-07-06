package entity;

public class Player {
    private String pno;
    private String pteam;
    private String pname;
    private String page;
    private String pheight;
    private String pweight;

    public String getPno() {
        return pno;
    }

    public void setPno(String pno) {
        this.pno = pno;
    }

    public String getPteam() {
        return pteam;
    }

    public void setPteam(String pteam) {
        this.pteam = pteam;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getPage() {
        return page;
    }

    public void setPage(String page) {
        this.page = page;
    }

    public String getPheight() {
        return pheight;
    }

    public void setPheight(String pheight) {
        this.pheight = pheight;
    }

    public String getPweight() {
        return pweight;
    }

    public void setPweight(String pweight) {
        this.pweight = pweight;
    }

    @Override
    public String toString() {
        return "{" +
                "pno='" + pno + '\'' +
                ", pteam='" + pteam + '\'' +
                ", pname='" + pname + '\'' +
                ", page='" + page + '\'' +
                ", pheight='" + pheight + '\'' +
                ", pweight='" + pweight + '\'' +
                '}';
    }
}
