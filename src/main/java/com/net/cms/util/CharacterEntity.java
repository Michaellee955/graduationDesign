package com.net.cms.util;

import org.springframework.util.StringUtils;

public enum CharacterEntity {
//	CN("cn"), 
	EQ("="), 
	NE("!="), 
	LT("<"), 
	GT(">"); 
//	BW("bw"), 
//	EW("ew");	
	private String Character;
	private CharacterEntity(String character) {
		setCharacter(character);
	}
	public String getCharacter() {
		return Character;
	}
	public void setCharacter(String character) {
		Character = character;
	}
	
	public static String getOperater(String ce){
		if(StringUtils.isEmpty(ce)){
			return null;
		}else if(ce.toUpperCase().equals(EQ.toString())){
			return EQ.getCharacter();
		}else if(ce.toUpperCase().equals(NE.toString())){
			return NE.getCharacter();
		}else if(ce.toUpperCase().equals(LT.toString())){
			return LT.getCharacter();
		}else if(ce.toUpperCase().equals(GT.toString())){
			return GT.getCharacter();
		}else{
			return null;
		}		
	}
	
}
