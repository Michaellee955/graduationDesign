package com.net.cms.base;

public class PagerFilter {
  private String sidx;
  private String sord;
  private Integer page = Integer.valueOf(1);

  private Integer rows = Integer.valueOf(15);
  private Integer records;
  private Integer total;
  private String tenantId;

  public Integer getPage()
  {
    return this.page;
  }

  public Integer getRecords() {
    return this.records;
  }

  public Integer getRows() {
    return this.rows;
  }

  public String getSidx() {
    return this.sidx;
  }

  public String getSord() {
    return this.sord;
  }

  public String getTenantId() {
    return this.tenantId;
  }

  public Integer getTotal() {
    return this.total;
  }

  public void setPage(Integer page) {
    this.page = page;
  }

  public void setRecords(Integer records) {
    this.records = records;
  }

  public void setRows(Integer rows) {
    this.rows = rows;
  }

  public void setSidx(String sidx) {
    this.sidx = sidx;
  }

  public void setSord(String sord) {
    this.sord = sord;
  }

  public void setTenantId(String tenantId) {
    this.tenantId = tenantId;
  }

  public void setTotal(Integer total) {
    this.total = total;
  }
}
