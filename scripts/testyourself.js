// For the test part of the app.

var mydict=null;
var myrandword=null;

function getCard() {
	var dict = new Array();
	var count;
	for (count=0;count < 20;count++)		//iniitlize array
		dict[count]=new Array();
		
	dict[0][0] = "img_room"; dict[0][1]="la chambre";
	dict[1][0] = "img_stay"; dict[1][1]=" rester";
	dict[2] [0]= "img_reserve"; dict[2][1]="reserve";
	dict[3] [0]= "img_deposit";dict[3][1]="la caution";
	dict[4] [0]= "img_cancel";dict[4][1]="annuler";
	dict[5] [0]= "img_available";dict[5][1]="disponible";
	dict[6] [0]= "img_arrive";dict[6][1]="arriver";
	dict[7] [0]= "img_night";dict[7][1]="la nuit";
	dict[8] [0]= "img_train";dict[8][1]="le train";
	dict[9] [0]= "img_next";dict[9][1]="prochain";
	dict[10] [0]= "img_missedthetrain";dict[10][1]="raté le train";
	dict[11] [0]= "img_ticket";dict[11][1]="le billet";
	dict[12] [0]= "img_buy";dict[12][1]="acheter";
	dict[13] [0]= "img_howmuch";dict[13][1]="combien?";
	dict[14] [0]= "img_twotickets";dict[14][1]="deux billets";
	dict[15] [0]= "img_single";dict[15][1]="aller simple";
	dict[16] [0]= "img_return";dict[16][1]="aller retour";
	dict[17] [0]= "img_boat";dict[17][1]="le bateau";
	dict[18] [0]= "img_plane";dict[18][1]="l'avion";
	dict[19] [0]= "img_departure";dict[19][1]="le départ";
		
	
	var random = Math.floor(Math.random() * dict.length);	
	
	
	//document.getElementById ("questionImg").src = "images/characters/"+dict[random]+".gif"; 
	mydictcard =dict[0][random];
	//myrandword=dict[0,1];
	myrandword=dict[random][1];
	
	alert(mydictcard);
	alert(myrandword);
	var cardsrc="images/review/"+ mydictcard +".jpg";
	//alert(cardsrc);
	document.getElementById ("answerImg").src = cardsrc;
	
}

function getNewCard (){	
	alert('new ');
	var flashcard = document.getElementById("card")
	flashcard.className = "card"
	setTimeout("getCard()",200);
}

function flip (event){
   //alert('flipping card - use jQuery to diaplsy the word?');
	var element = event.currentTarget;
	element.className = (element.className == "card") ? "card flipped" : "card";
	document.getElementById ("translation").innerHTML='<H1>' + myrandword + '</H1>';
	
}

getCard();