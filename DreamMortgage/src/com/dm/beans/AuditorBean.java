package com.dm.beans;


public class AuditorBean {
	private String MortgageNumber;
	private String Participant;
	private String Action;
	private String Data;
	private String timeStamp;
	private String currentBlockHask;
	private String previousBlockHash;
	private int num;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getCurrentBlockHask() {
		return currentBlockHask;
	}
	public void setCurrentBlockHask(String currentBlockHask) {
		this.currentBlockHask = currentBlockHask;
	}
	public String getPreviousBlockHash() {
		return previousBlockHash;
	}
	public void setPreviousBlockHash(String previousBlockHash) {
		this.previousBlockHash = previousBlockHash;
	}
	public String getMortgageNumber() {
		return MortgageNumber;
	}
	public void setMortgageNumber(String mortgageNumber) {
		MortgageNumber = mortgageNumber;
	}
	public String getParticipant() {
		return Participant;
	}
	public void setParticipant(String participant) {
		Participant = participant;
	}
	public String getAction() {
		return Action;
	}
	public void setAction(String action) {
		Action = action;
	}
	public String getData() {
		return Data;
	}
	public void setData(String data) {
		Data = data;
	}
	public String getTimeStamp() {
		return timeStamp;
	}
	public void setTimeStamp(String timeStamp) {
		this.timeStamp = timeStamp;
	}
	
	
}
