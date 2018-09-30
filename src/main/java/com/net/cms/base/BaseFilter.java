package com.net.cms.base;

import java.io.Serializable;

import com.net.cms.shiro.util.Securitys;

public class BaseFilter implements Serializable
{
  private String sidx;
  private String sord;
  private Integer page = Integer.valueOf(1);

  private Integer rows = Integer.valueOf(15);
  private Integer records;
  private Integer total;
  private String manuCode;

  public static final void setLocal(BaseFilter baseFilter)
  {
    JqgridResponse jqgridResponse = (JqgridResponse)JqgridResponseContext.get("jqgridResponse");
    if (jqgridResponse == null) {
      jqgridResponse = new JqgridResponse();
    }
    jqgridResponse.setPage(baseFilter.getPage());
    jqgridResponse.setTotal(baseFilter.getTotal());
    jqgridResponse.setRecords(baseFilter.getRecords());
    JqgridResponseContext.set("jqgridResponse", jqgridResponse);
  }

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

  public void setTotal(Integer total) {
    this.total = total;
  }

  public String toString()
  {
    return "BaseFilter [sidx=" + this.sidx + ", sord=" + this.sord + ", page=" + this.page + ", rows=" + this.rows + "]";
  }

	public String getManuCode() {
		return Securitys.getManuCode();
	}
}
