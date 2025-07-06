package entity;

public class Goods {
    private String goodsno;
    private String supplierno;
    private String categoryno;
    private String goodsname;
    private String inprice;
    private String saleprice;
    private String number;
    private String producttime;

    public String getGoodsno() {
        return goodsno;
    }

    public void setGoodsno(String goodsno) {
        this.goodsno = goodsno;
    }

    public String getSupplierno() {
        return supplierno;
    }

    public void setSupplierno(String supplierno) {
        this.supplierno = supplierno;
    }

    public String getCategoryno() {
        return categoryno;
    }

    public void setCategoryno(String categoryno) {
        this.categoryno = categoryno;
    }

    public String getGoodsname() {
        return goodsname;
    }

    public void setGoodsname(String goodsname) {
        this.goodsname = goodsname;
    }

    public String getInprice() {
        return inprice;
    }

    public void setInprice(String inprice) {
        this.inprice = inprice;
    }

    public String getSaleprice() {
        return saleprice;
    }

    public void setSaleprice(String saleprice) {
        this.saleprice = saleprice;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getProducttime() {
        return producttime;
    }

    public void setProducttime(String producttime) {
        this.producttime = producttime;
    }

    @Override
    public String toString() {
        return "Goods{" +
                "goodsno='" + goodsno + '\'' +
                ", supplierno='" + supplierno + '\'' +
                ", categoryno='" + categoryno + '\'' +
                ", goodsname='" + goodsname + '\'' +
                ", inprice='" + inprice + '\'' +
                ", saleprice='" + saleprice + '\'' +
                ", number='" + number + '\'' +
                ", producttime='" + producttime + '\'' +
                '}';
    }
}
