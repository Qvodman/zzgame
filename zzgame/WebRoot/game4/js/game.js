"use strict"

var Game = function(containerId, width, height){

	this.width = width - 10;
	this.height = height - 10;
	this.renderer = new THREE.WebGLRenderer( { antialias: true } );
	this.renderer.setSize( this.width, this.height );
	this.renderer.setClearColor( 0x000000 );
	this.container = document.getElementById( containerId );
	this.container.appendChild( this.renderer.domElement );
	this.bullet = [] ;
	this.speed = g_minSpeed ;
	this.bulletNum = 2;
	this.startTime = Date.now();
	this.lastTime = Date.now();
	this.score = 0 ;
	this.nowType = -1 ;
	this.TypeBullet = [];
	
	g_BulletSize[0] = g_BulletSize[0]*this.width/400;
	g_BulletSize[1] = g_BulletSize[1]*this.width/400;
	g_BulletSize[2] = g_BulletSize[2]*this.width/400;
	
	window.addEventListener('resize', this.resize.bind(this), true);
	window.addEventListener('touchstart', this.touches.bind(this), true);
	window.addEventListener('touchend', this.touches.bind(this), true);
	window.addEventListener('touchmove', this.touches.bind(this), true);
	
//	this.stats = new Stats();
//	this.stats.domElement.style.position = 'absolute';
//	this.stats.domElement.style.top = '0px';
//	document.body.appendChild(this.stats.domElement);
	
	this.clear();
	this.createAllTypeBullet();
	this.addObj();
	this.updateNowType();
	this.animate();
};

//界面大小改变
Game.prototype.resize = function() {
	this.width = window.innerWidth - 10;
	this.height = window.innerHeight - 10;
	
	
//	this.camera.aspect = this.width / this.height;
//	this.camera.updateProjectionMatrix();
	this.camera.right = this.width;
	this.camera.top = this.height;
	this.camera.updateProjectionMatrix();
//	this.camera = new THREE.OrthographicCamera( 0, this.width , this.height, 0 , 1, 1000 );
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

//添加对象
Game.prototype.addObj = function() {
	this.addBackground();
	 
	 this.addText();
	
	for(var i = 0 ; i < this.bulletNum ; i ++)
	{
		var newBullet = new Bullet();
		this.bullet.push(newBullet);
		this.scene.add(newBullet.obj);
	}
	
	this.addBlackHole();
}

Game.prototype.addText = function() {
	
	this.ScoreCanvas = document.getElementById('ScoreCanvas'); 
	this.ScoreCanvas.width = 150; 
	this.ScoreCanvas.height = 20;
	this.ScoreCtx = this.ScoreCanvas.getContext("2d");
	this.ScoreCtx.font="20px Arial";
	
	this.TimeCanvas = document.getElementById('TimeCanvas'); 
	this.TimeCanvas.width = 150; 
	this.TimeCanvas.height = 20;
	this.TimeCtx = this.TimeCanvas.getContext("2d");
	this.TimeCtx.font="20px Arial";
}
var time = 0 ;
//刷新
Game.prototype.animate = function() {
	requestAnimationFrame( this.animate.bind(this) );
	
	this.updateBullet();
	
	this.blackholeMesh.rotation.set(0,0,time/10);
	
	
	var txt = "Score: " + this.score ;
	this.ScoreCtx.clearRect(0,0,150,20);
	this.ScoreCtx.fillText(txt,5,20);
	
	txt = "Time: " + Math.ceil((Date.now() - this.startTime)/1000)+ " s" ;
	this.TimeCtx.clearRect(0,0,150,20);
	this.TimeCtx.fillText(txt,5,20);
	
//	this.stats.update();
	this.renderer.render( this.scene, this.camera );
	time ++ ;
	if(time >= 100)time = 1;
}

//刷新当前球
Game.prototype.updateNowType = function() {
	if(g_typeNum != 0)
	{
		var type = Math.random();
		type = Math.ceil(type*Math.min(g_typeNum,7));
		
		if(this.nowType != -1)this.TypeBullet[this.nowType-1].obj.position.x = -100000;
		this.nowType = type ;
		if(this.nowType != -1)this.TypeBullet[this.nowType-1].obj.position.x = 50 ;
	}
	
	if(g_typeNum < g_maxBullet)
	{
		var num = g_maxBullet*this.score/g_maxScore;
		
		num = Math.ceil(num);
		if(g_typeNum < num)
		{
			this.speed = g_minSpeed + (num / g_maxBullet)*(g_maxSpeed-g_minSpeed);
			
			var newBullet = new Bullet();
			this.bullet.push(newBullet);
			this.scene.add(newBullet.obj);
		}
	}
}
//创建7种球
Game.prototype.createAllTypeBullet = function() {

	for(var i = 1;i <= 7 ; i++)
	{
		var newBullet = new Bullet2(i,100);
		newBullet.obj.position.x = -100000 ;
		newBullet.obj.position.y = this.height - 100 ;
		this.TypeBullet.push(newBullet);
		this.scene.add(newBullet.obj);
	}
}

//刷新子弹状态
Game.prototype.updateBullet = function() {
	var len = this.bullet.length;
	var time = Date.now() ;
	var elapsedTime = time - this.lastTime ;
	this.lastTime = time ;
//	console.log("Update elapsedTime : "+elapsedTime);
	//刷新坐标
	var s = this.speed*elapsedTime*0.06;
	for(var i = 0 ; i < len ; i++)
	{
		this.bullet[i].obj.position.x += s*this.bullet[i].dir.x;
		this.bullet[i].obj.position.y += s*this.bullet[i].dir.y;
	}
	//判断边界 刷新方向
	var x,y;
	for(var i = 0 ; i < len ; i ++)
	{
		x = this.bullet[i].obj.position.x ;
		y = this.bullet[i].obj.position.y ;
		
		if(x <= 0 )
		{
			this.bullet[i].dir.x = randomSpeed1();
			this.bullet[i].dir.y = randomSpeed2();
		}
		else if(y <= 0)
		{
			this.bullet[i].dir.x = randomSpeed2();
			this.bullet[i].dir.y = randomSpeed1();
		}
		else if(x >= this.width)
		{
			this.bullet[i].dir.x = -randomSpeed1();
			this.bullet[i].dir.y = randomSpeed2();
		}
		else if(y >= this.height)
		{
			this.bullet[i].dir.x = randomSpeed2();
			this.bullet[i].dir.y = -randomSpeed1();
		}
	}
	//判断是否被吃掉
	var bx = this.blackholeMesh.position.x;
	var by = this.blackholeMesh.position.y;
	var bs2 = g_BulletSize[2]*g_BulletSize[2]/4;
	var s2 ;
	for(var i = 0 ; i < len ; i ++)
	{
		x = this.bullet[i].obj.position.x ;
		y = this.bullet[i].obj.position.y ;
		s2 = this.bullet[i].size*this.bullet[i].size/4;
		
		var dis2 = (bx-x)*(bx-x)+(by-y)*(by-y);
		if(dis2<s2+bs2){
			//吃对了 加分
			if(this.nowType == -1 || this.nowType == this.bullet[i].type)
			{
				var score = this.speed*(this.bullet[i].dir.x+this.bullet[i].dir.y+this.bullet[i].dir.z+1)*100/this.bullet[i].size ;
				score = Math.ceil(score);
				this.score += score ;
				console.log("Update score : "+score);
				
				//重置位置
				this.bullet[i].obj.position.x = 0;
				this.bullet[i].obj.position.y = 0;
				
				this.bullet[i].dir.x = randomSpeed1();
				this.bullet[i].dir.y = randomSpeed2();
				
				this.updateNowType();
			}
			//吃错了 游戏结束
			else{
				this.gameOver();
			}
		}
	}
}

Game.prototype.gameOver = function()
{ 
	alert("游戏结束!\n得分："+this.score+"\n时间："+Math.ceil((Date.now()-this.startTime)/1000)+"s");
	window.location.href = "../score.jsp?game4_score="+this.score;
}

var g_touch_x,g_touch_y;
Game.prototype.touches =  function (ev){ 
		event.preventDefault();// 阻止浏览器默认事件，重要 
        if(ev.touches.length==1){ 
            switch(ev.type){ 
                case 'touchstart': 
					g_touch_x = ev.changedTouches[0].clientX;
					g_touch_y = ev.changedTouches[0].clientY;
                    break; 
                case 'touchend': 
                    break; 
                case 'touchmove': 
					this.blackholeMesh.position.x += ev.changedTouches[0].clientX - g_touch_x;
					this.blackholeMesh.position.y -= ev.changedTouches[0].clientY - g_touch_y;
					this.blackholeMesh.position.x = Math.min(Math.max(0,this.blackholeMesh.position.x),this.width);
					this.blackholeMesh.position.y = Math.min(Math.max(0,this.blackholeMesh.position.y),this.height);
					g_touch_x = ev.changedTouches[0].clientX;
					g_touch_y = ev.changedTouches[0].clientY;
                    break; 
                 
            } 
        } 
    }
//添加背景
Game.prototype.addBackground = function() {
	var geometry = new THREE.PlaneGeometry( this.width, this.height , 1, 1 );
	geometry.vertices[0].uv = new THREE.Vector2(0,0);
	geometry.vertices[1].uv = new THREE.Vector2(1,0);
	geometry.vertices[2].uv = new THREE.Vector2(1,1);
	geometry.vertices[3].uv = new THREE.Vector2(0,1);
	
	var texture = THREE.ImageUtils.loadTexture("../game4/textures/background.jpg",null,function(t)
	{
	});
	var material = new THREE.MeshBasicMaterial({map:texture});
	this.backgroundMesh = new THREE.Mesh( geometry,material );
	this.backgroundMesh.position.x = this.width/2;
	this.backgroundMesh.position.y = this.height/2;
	this.backgroundMesh.position.z = 0;
	this.scene.add( this.backgroundMesh );
}

//添加黑洞
Game.prototype.addBlackHole = function() {
	var geometry = new THREE.PlaneGeometry( g_BulletSize[2], g_BulletSize[2] , 1, 1 );
	geometry.vertices[0].uv = new THREE.Vector2(0,0);
	geometry.vertices[1].uv = new THREE.Vector2(1,0);
	geometry.vertices[2].uv = new THREE.Vector2(1,1);
	geometry.vertices[3].uv = new THREE.Vector2(0,1);
	
	var texture = THREE.ImageUtils.loadTexture("../game4/textures/blackhole.png",null,function(t)
	{
	});
	var material = new THREE.MeshBasicMaterial({map:texture});
	material.transparent = true;
	this.blackholeMesh = new THREE.Mesh( geometry,material );
	this.blackholeMesh.position.x = this.width;
	this.blackholeMesh.position.y = this.height;
	this.blackholeMesh.position.z = 0;
	this.scene.add( this.blackholeMesh );
}