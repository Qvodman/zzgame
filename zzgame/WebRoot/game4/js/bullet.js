"use strict"
//var debug=0;
var g_BulletSize = [16,24,32];
var g_BulletTypeNum = [0,0,0,0,0,0,0,0,0,0];
var g_sizeNum = -1;
var g_typeNum = 0;
var g_maxBullet = 100 ;
var g_scoreGrading = 500 ;
var g_maxSpeed = 15;
var g_minSpeed = 5;
var g_maxScore = g_scoreGrading*g_maxBullet;
//随机生成一个类型的子弹
var Bullet = function(){
	g_sizeNum ++;
	g_typeNum ++;
	
	
	//子弹大小
	this.size = g_BulletSize[g_sizeNum%3];
	//子弹类型
	this.type = g_typeNum%7 ;
	if(this.type == 0)this.type = 7 ;
	//子弹对象
	this.obj =  addBullet(this.type , this.size);
	//坐标
	this.position = new THREE.Vector3(0,0,0);
	//方向
	this.dir = new THREE.Vector3(randomSpeed1(),randomSpeed1(),0);
	
	this.obj.position.x = 0;
	this.obj.position.y = 0;
	this.obj.position.z = 0;
	
	g_BulletTypeNum[this.type] ++ ;
};

var Bullet2 = function(type , size){
	
	//子弹大小
	this.size = size;
	//子弹类型
	this.type = type ;
	//子弹对象
	this.obj =  addBullet(this.type , this.size);
	//坐标
	this.position = new THREE.Vector3(0,0,0);
	
	this.obj.position.x = 0;
	this.obj.position.y = 0;
	this.obj.position.z = 0;
	
};
//添加子弹
var addBullet = function(type , size) {
	var geometry = new THREE.PlaneGeometry( size, size, 1, 1 );
	geometry.vertices[0].uv = new THREE.Vector2(0,0);
	geometry.vertices[1].uv = new THREE.Vector2(1,0);
	geometry.vertices[2].uv = new THREE.Vector2(1,1);
	geometry.vertices[3].uv = new THREE.Vector2(0,1);
	
	var texture = null;
	switch(type){
		case 1:
			texture = THREE.ImageUtils.loadTexture("../game4/textures/orbz_001.png",null,function(t)
			{
			});
			break;
		case 2:
			texture = THREE.ImageUtils.loadTexture("../game4/textures/orbz_002.png",null,function(t)
			{
			});
			break;
		case 3:
			texture = THREE.ImageUtils.loadTexture("../game4/textures/orbz_003.png",null,function(t)
			{
			});
			break;
		case 4:
			texture = THREE.ImageUtils.loadTexture("../game4/textures/orbz_004.png",null,function(t)
			{
			});
			break;
		case 5:
			texture = THREE.ImageUtils.loadTexture("../game4/textures/orbz_005.png",null,function(t)
			{
			});
			break;
		case 6:
			texture = THREE.ImageUtils.loadTexture("../game4/textures/orbz_006.png",null,function(t)
			{
			});
			break;
		case 7:
			texture = THREE.ImageUtils.loadTexture("../game4/textures/orbz_007.png",null,function(t)
			{
			});
			break;
		default:
			texture = THREE.ImageUtils.loadTexture("../game4/textures/orbz_001.png",null,function(t)
			{
			});
			break;
	}
	var material = new THREE.MeshBasicMaterial({map:texture});
	material.transparent = true;
	
	return new THREE.Mesh( geometry,material );
}