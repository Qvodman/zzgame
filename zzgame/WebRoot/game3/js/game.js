"use strict"
var g_minSpeed = 1.0 ;
var g_maxSpeed = 3.0 ;
var Game = function(containerId, width, height){

	this.width = width-10;
	this.height = height-10;
	this.renderer = new THREE.WebGLRenderer( { antialias: true } );
	this.renderer.setSize( this.width, this.height );
	this.renderer.setClearColor( 0xFFFFFF );
	
	this.container = document.getElementById( containerId );
	this.container.appendChild( this.renderer.domElement );
	
	this.dirSize = 100;
	this.nowDirIndex = 0;
	this.dirNum = Math.ceil(this.width/this.dirSize);
	this.dir = [] ;
	this.speed = g_minSpeed ;
	this.score = 0 ;
	this.goalScore = 100;
	
	this.Start = false ;
	this.bGameOver = false;
	
	this.startTime = Date.now();
	this.lastTime = Date.now();
	
	this.CenterLine = this.height - 100 - this.dirSize ;
	this.CenterHeight = this.dirSize*2 ;
	this.CenterRedWidth = 10;
	this.CenterRedX = Math.ceil(this.width/5);
	this.DirGap = Math.ceil(this.width/10);
	
	this.clear();
	this.addObj();
	this.addEventListener();
	this.addText();
	this.animate();
	
};

//界面大小改变
Game.prototype.resize = function() {
	this.width = window.innerWidth - 10 ;
	this.height = window.innerHeight - 10 ;
	
	this.move();
	
	this.camera.right = this.width;
	this.camera.top = this.height;
	this.camera.updateProjectionMatrix();
	this.renderer.setSize( this.width, this.height );
}

//初始化
Game.prototype.clear = function() {
	this.camera = new THREE.OrthographicCamera( 0, this.width , this.height, 0 , 1, 1000 );
	this.camera.position.x = 0;
	this.camera.position.y = 0;
	this.camera.position.z = 600;
	this.camera.up.x = 0;
	this.camera.up.y = 1;
	this.camera.up.z = 0;
	this.camera.lookAt({
		x : 0,
		y : 0,
		z : 0
	});
	
	this.scene = new THREE.Scene();
}


Game.prototype.addText = function() {
	
	this.ScoreCanvas = document.getElementById('ScoreCanvas'); 
	this.ScoreCanvas.width = 150; 
	this.ScoreCanvas.height = 40;
	this.ScoreCtx = this.ScoreCanvas.getContext("2d");
	this.ScoreCtx.font="20px Arial";
}

//刷新
Game.prototype.animate = function() {
	requestAnimationFrame( this.animate.bind(this) );
	
	//刷新分数
	var txt = "Score: " + this.score ;
	this.ScoreCtx.clearRect(0,0,150,40);
	this.ScoreCtx.fillText(txt,5,20);
	txt = "Goal Score: " + this.goalScore ;
	this.ScoreCtx.fillText(txt,5,40);
	
	if(this.Start == true && this.bGameOver == false)
	{
		this.update();
	}
	this.renderer.render( this.scene, this.camera );

}


Game.prototype.update = function() {
	var len = this.dir.length;
	
	var time = Date.now() ;
	var elapsedTime = time - this.lastTime ;
	
	
	var s = this.speed*elapsedTime*0.06 ;
//	if(s >= 1)
	{
		this.lastTime = time ;
		
		for(var i = 0 ; i < len ; i ++)
		{
			this.dir[i].obj.position.x -= s;
	//		console.log(""+this.dir[i].obj.position.x);

			if(this.dir[i].obj.position.x + this.dirSize/2 < this.CenterRedX)
			{
				this.dir[i].obj.position.x += this.dirNum*(this.dirSize + this.DirGap) ;
				this.nowDirIndex++ ;
				this.nowDirIndex = this.nowDirIndex%this.dirNum ;
				
				this.gameOver();
			}
		}
	}
	
	
}

Game.prototype.gameOver = function()
{
	alert("游戏结束!\n得分："+this.score+"\n时间："+Math.ceil((Date.now()-this.startTime)/1000)+"s");
	this.bGameOver = true;
}

Game.prototype.gameWin = function()
{
	alert("游戏胜利!"+"\n用时："+Math.ceil((Date.now()-this.startTime)/1000)+"s");
	this.bGameOver = true;
}

Game.prototype.move = function(){
	this.dirButtonSize = Math.min( Math.ceil((this.width - 40)/3) , 80 );
	
	document.getElementById("ssButton").style.width = Math.ceil(this.width/4)+'px';
	document.getElementById("ssButton").style.height = Math.ceil(this.width/8);+'px';
	document.getElementById("ssButton").style.top = '30px';
	document.getElementById("ssButton").style.right = (30)+'px';
	
	document.getElementById("TopButton").style.width = this.dirButtonSize+'px';
	document.getElementById("TopButton").style.height = this.dirButtonSize+'px';
	document.getElementById("TopButton").style.bottom = (30+this.dirButtonSize*2)+'px';
	document.getElementById("TopButton").style.left = (Math.ceil(this.width/2) - Math.ceil(this.dirButtonSize/2))+'px';
	
	document.getElementById("BottomButton").style.width = this.dirButtonSize+'px';
	document.getElementById("BottomButton").style.height = this.dirButtonSize+'px';
	document.getElementById("BottomButton").style.bottom = '10px';
	document.getElementById("BottomButton").style.left = (Math.ceil(this.width/2) - Math.ceil(this.dirButtonSize/2))+'px';
	
	document.getElementById("LeftButton").style.width = this.dirButtonSize+'px';
	document.getElementById("LeftButton").style.height = this.dirButtonSize+'px';
	document.getElementById("LeftButton").style.bottom = (20+this.dirButtonSize)+'px';
	document.getElementById("LeftButton").style.left = (Math.ceil(this.width/2) - (this.dirButtonSize+10) - Math.ceil(this.dirButtonSize/2))+'px';
	
	document.getElementById("RightButton").style.width = this.dirButtonSize+'px';
	document.getElementById("RightButton").style.height = this.dirButtonSize+'px';
	document.getElementById("RightButton").style.bottom = (20+this.dirButtonSize)+'px';
	document.getElementById("RightButton").style.left = (Math.ceil(this.width/2) + (this.dirButtonSize+10) - Math.ceil(this.dirButtonSize/2))+'px';

	
//	document.getElementById("CenterButton").style.width = this.dirButtonSize+'px';
//	document.getElementById("CenterButton").style.height = this.dirButtonSize+'px';
//	document.getElementById("CenterButton").style.bottom = (20+this.dirButtonSize)+'px';
//	document.getElementById("CenterButton").style.left = (Math.ceil(this.width/2) - Math.ceil(this.dirButtonSize/2))+'px';

	this.blackMesh.position.x = this.width/2 ;
	this.blackMesh.position.y = this.CenterLine;
	this.blackMesh.position.z = 0 ;
	
	this.redMesh.position.x = this.CenterRedX; 
	this.redMesh.position.y = this.CenterLine;
	this.redMesh.position.z = 0 ;
}
Game.prototype.addEventListener = function(){
//	var _t = this;
	
	this.dirButtonSize = Math.min( Math.ceil((this.width - 40)/3) , 80 );
	window.addEventListener('resize', this.resize.bind(this), true);
	
	document.getElementById("ssButton").addEventListener('click',this.eventSsButton.bind(this),false);
	document.getElementById("TopButton").addEventListener('click',this.eventTopButton.bind(this),false);
	document.getElementById("BottomButton").addEventListener('click',this.eventBottomButton.bind(this),false);
	document.getElementById("LeftButton").addEventListener('click',this.eventLeftButton.bind(this),false);
	document.getElementById("RightButton").addEventListener('click',this.eventRightButton.bind(this),false);
//	document.getElementById("CenterButton").addEventListener('click',this.eventCenterButton.bind(this),false);
	
	this.move();
	
	document.getElementById("TopButton").style.backgroundImage="url(../game3/textures/keys_t.png)";
	document.getElementById("BottomButton").style.backgroundImage="url(../game3/textures/keys_b.png)";
	document.getElementById("LeftButton").style.backgroundImage="url(../game3/textures/keys_l.png)";
	document.getElementById("RightButton").style.backgroundImage="url(../game3/textures/keys_r.png)";
//	document.getElementById("CenterButton").style.backgroundImage="url(textures/keys_c.png)";
	
}

Game.prototype.eventSsButton = function(){
//	alert("eventSsButton");
	if(this.Start == false)
	{
		document.getElementById("ssButton").innerText = "Stop";
		this.Start = true ;
		this.lastTime = Date.now();
	}
	else{
		document.getElementById("ssButton").innerText = "Continue";
		this.Start = false ;
	}
	
}
Game.prototype.resetDir = function(index){
	
	this.dir[index].obj.position.x += this.dirNum*(this.dirSize + this.DirGap) ;
	this.nowDirIndex++ ;
	this.nowDirIndex = this.nowDirIndex%this.dirNum ;
	
	
	this.speed = g_minSpeed + (g_maxSpeed - g_minSpeed)*this.score/this.goalScore ;
	
	if(this.score >= this.goalScore)
	{
		this.gameWin();
	}
	
//	console.log(""+this.speed);
}
Game.prototype.eventTopButton = function(){
//	alert("eventTopButton");
	var f = false;
	if(Math.abs(this.dir[this.nowDirIndex].obj.position.x-this.CenterRedX) <= (this.dirSize+this.CenterRedWidth)/2)
		f = true;
	if(f && this.nowDirIndex>=0 && this.nowDirIndex < this.dirNum)
	{
		if(this.dir[this.nowDirIndex].dir == 2)
		{
			this.score ++ ;
			this.resetDir(this.nowDirIndex);
		}
		else{
			this.gameOver();
		}
	}
}
Game.prototype.eventBottomButton = function(){
//	alert("eventBottomButton");
	var f = false;
	if(Math.abs(this.dir[this.nowDirIndex].obj.position.x-this.CenterRedX) <= (this.dirSize+this.CenterRedWidth)/2)
		f = true;
	if(f && this.nowDirIndex>=0 && this.nowDirIndex < this.dirNum)
	{
		if(this.dir[this.nowDirIndex].dir == 4)
		{
			this.score ++ ;
			this.resetDir(this.nowDirIndex);
		}
		else{
			this.gameOver();
		}
	}
}
Game.prototype.eventLeftButton = function(){
//	alert("eventLeftButton");
	var f = false;
	if(Math.abs(this.dir[this.nowDirIndex].obj.position.x-this.CenterRedX) <= (this.dirSize+this.CenterRedWidth)/2)
		f = true;
	if(f && this.nowDirIndex>=0 && this.nowDirIndex < this.dirNum)
	{
		if(this.dir[this.nowDirIndex].dir == 3)
		{
			this.score ++ ;
			this.resetDir(this.nowDirIndex);
		}
		else{
			this.gameOver();
		}
	}
}
Game.prototype.eventRightButton = function(){
//	alert("eventRightButton");
	var f = false;
	if(Math.abs(this.dir[this.nowDirIndex].obj.position.x-this.CenterRedX) <= (this.dirSize+this.CenterRedWidth)/2)
		f = true;
	if(f && this.nowDirIndex>=0 && this.nowDirIndex < this.dirNum)
	{
		if(this.dir[this.nowDirIndex].dir == 1)
		{
			this.score ++ ;
			this.resetDir(this.nowDirIndex);
		}
		else{
			this.gameOver();
		}
	}
}
Game.prototype.eventCenterButton = function(){
//	alert("eventCenterButton");
}

Game.prototype.addObj = function()
{
	//add black
	var geometry = new THREE.PlaneGeometry( this.width, this.CenterHeight, 1, 1 );
	geometry.vertices[0].uv = new THREE.Vector2(0,0);
	geometry.vertices[1].uv = new THREE.Vector2(1,0);
	geometry.vertices[2].uv = new THREE.Vector2(1,1);
	geometry.vertices[3].uv = new THREE.Vector2(0,1);
	
	var texture = THREE.ImageUtils.loadTexture("../game3/textures/black.png",null,function(t){});
	var material = new THREE.MeshBasicMaterial({map:texture});
	this.blackMesh = new THREE.Mesh( geometry,material );
	this.scene.add(this.blackMesh);
	
	//add red
	geometry = new THREE.PlaneGeometry( this.CenterRedWidth, this.CenterHeight, 1, 1 );
	geometry.vertices[0].uv = new THREE.Vector2(0,0);
	geometry.vertices[1].uv = new THREE.Vector2(1,0);
	geometry.vertices[2].uv = new THREE.Vector2(1,1);
	geometry.vertices[3].uv = new THREE.Vector2(0,1);
	
	texture = THREE.ImageUtils.loadTexture("../game3/textures/red.png",null,function(t){});
	material = new THREE.MeshBasicMaterial({map:texture});
	this.redMesh = new THREE.Mesh( geometry,material );
	this.scene.add(this.redMesh);
	
	//add dir
	for(var i = 0 ; i < this.dirNum ; i++)
	{
		var newDir = new Dir(this.dirSize);
		this.dir.push(newDir);
		this.scene.add(newDir.obj);
		
		newDir.obj.position.x = this.width + i*(this.dirSize + this.DirGap) ;
		newDir.obj.position.y = this.CenterLine ;
		newDir.obj.position.z = 0 ;
		newDir.obj.rotation.set(0,0,((newDir.dir-1)/2)*Math.PI);		
	}
	
}

//随机生成方向
var Dir = function(size){
	
	this.dir = Math.ceil(Math.random()*4);
	this.dir = Math.min(4,Math.max(1,this.dir));

	this.obj =  addDir(size);
	//坐标
	this.position = new THREE.Vector3(0,0,0);
	
	this.obj.position.x = 0;
	this.obj.position.y = 0;
	this.obj.position.z = 0;
	
};

var addDir = function(size) {
	var geometry = new THREE.PlaneGeometry( size, size, 1, 1 );
	geometry.vertices[0].uv = new THREE.Vector2(0,0);
	geometry.vertices[1].uv = new THREE.Vector2(1,0);
	geometry.vertices[2].uv = new THREE.Vector2(1,1);
	geometry.vertices[3].uv = new THREE.Vector2(0,1);
	
	var texture = THREE.ImageUtils.loadTexture("../game3/textures/iconpng.png",null,function(t){});
			
	var material = new THREE.MeshBasicMaterial({map:texture});
	material.transparent = true;
	
	return new THREE.Mesh( geometry,material );
}
