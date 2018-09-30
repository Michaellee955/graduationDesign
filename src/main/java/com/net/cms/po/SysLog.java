package com.net.cms.po;


public class SysLog {
	private String operateModel;
	private String operateAction;
	private String operateDesc;
	private String operator;
	private String operatorId;
	private String createTime;
	public SysLog(){}
	public SysLog(String operateModel,String operateAction,String operateDesc){
		this.operateModel = operateModel;
		this.operateAction = operateAction;
		this.operateDesc = operateDesc;
	}
	public SysLog(String operateModel,String operateAction,String operateDesc,String operator,String operatorId){
		this.operateModel = operateModel;
		this.operateAction = operateAction;
		this.operateDesc = operateDesc;
		this.operator = operator;
		this.operatorId = operatorId;
	}
	public String getOperateModel() {
		return operateModel;
	}
	public void setOperateModel(String operateModel) {
		this.operateModel = operateModel;
	}
	public String getOperateAction() {
		return operateAction;
	}
	public void setOperateAction(String operateAction) {
		this.operateAction = operateAction;
	}
	public String getOperateDesc() {
		return operateDesc;
	}
	public void setOperateDesc(String operateDesc) {
		this.operateDesc = operateDesc;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getOperatorId() {
		return operatorId;
	}
	public void setOperatorId(String operatorId) {
		this.operatorId = operatorId;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
}
