import * as THREE from 'three';

import {OrbitControls} from 'three/examples/jsm/controls/OrbitControls';
import * as dat from 'dat.gui';
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader.js';
import { Mesh } from 'three';
import { SpotLightHelper } from 'three';

init();

function init(){ 
 // Set up the scene
 var scene = new THREE.Scene();
 var camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
 camera.position.set(0, 10, 50);
 var renderer = new THREE.WebGLRenderer();
 renderer.setSize(window.innerWidth, window.innerHeight);
 renderer.setClearColor(0xF2F3F5);
 document.body.appendChild(renderer.domElement);

 // Add lighting to the scene
 var rightLight = new THREE.PointLight(0xffffff, 0.3, 0);
 rightLight.position.set(10, 20, 7);

 var leftLight = new THREE.PointLight(0xffffff, 0.3, 0);
 leftLight.position.set(-10, 20, 7);

 var ambientLight = new THREE.AmbientLight(0xffffff, 0.8);
 scene.add(rightLight);
 scene.add(leftLight);
 scene.add(ambientLight);

 //snow
 var flakeCount = 20000;
 var flakeGeometry = new THREE.TetrahedronGeometry(0.035); // radius
 var flakeMaterial = new THREE.MeshPhongMaterial({ color: 0xffffff });
 var snow = new THREE.Group();

 for (let i = 0; i < flakeCount; i++) {
 var flakeMesh = new THREE.Mesh(flakeGeometry, flakeMaterial);
 flakeMesh.position.set(
     (Math.random() - 0.5) * 100,
     (Math.random() - 0.5) * 40,
     (Math.random() - 0.5) * 75
 );
 snow.add(flakeMesh);
 }
 
 scene.add(snow);

 var flakeArray = snow.children;

 //mountains
 const mountainGeometry = new THREE.ConeGeometry(5, 10,64);
 const textureLoader = new THREE.TextureLoader();
 const grassTexture = textureLoader.load('snow.jpg');
 const mountainMaterial = new THREE.MeshBasicMaterial({ map: grassTexture });
 const mountainMesh = new THREE.Mesh(mountainGeometry, mountainMaterial);
 mountainMesh.position.set(-10, -12, -5);

 const mountainGeometry2 = new THREE.ConeGeometry(5, 10,64);
 const textureLoade2r = new THREE.TextureLoader();
 const grassTexture2 = textureLoader.load('snow.jpg');
 const mountainMaterial2 = new THREE.MeshBasicMaterial({ map: grassTexture2 });
 const mountainMesh2 = new THREE.Mesh(mountainGeometry2, mountainMaterial2);
 mountainMesh2.position.set(10, -12, 12);

 scene.add(mountainMesh);
 scene.add(mountainMesh2);


 //cable car line
 // Create a line between the two mountains
 const material = new THREE.LineBasicMaterial( { color: 0x000000 } );
 const points = [];
 points.push( new THREE.Vector3( - 10, -6, -5 ) );
 points.push( new THREE.Vector3( 8, -13, 10 ) );
 const geometry = new THREE.BufferGeometry().setFromPoints( points );
 const line = new THREE.Line( geometry, material );
 scene.add( line );

 // Create a cable car
 const cableCarGeometry = new THREE.BoxGeometry(2, 2, 2);
 const cableCarMaterial = new THREE.MeshBasicMaterial({ color: 0xFFFFFF });
 const cableCar = new THREE.Mesh(cableCarGeometry, cableCarMaterial);
 const cableCarGeometry2 = new THREE.BoxGeometry(2, 2, 2);
 const cableCarMaterial2 = new THREE.MeshBasicMaterial({ color: 0xFF0000 });
 const cableCar2 = new THREE.Mesh(cableCarGeometry2, cableCarMaterial2);
 cableCar.position.set(-10, -6, -5); // Set the cable car's initial position
 cableCar2.position.set(10,-12,12)
 var speed = 0.05; // Speed of movement
 var direction = new THREE.Vector3(2, -1, 1.69); // Direction of movement
 var direction2 = new THREE.Vector3(2, 1, 1.69); // Direction of movement
 scene.add(cableCar);
 scene.add(cableCar2);

 // Add orbit controls to the camera
 var controls = new THREE.OrbitControls(camera, renderer.domElement);

 // Create the terrain
 var loader = new THREE.TextureLoader();
 loader.load('https://cdn.rawgit.com/mrdoob/three.js/r127/examples/textures/floors/FloorsCheckerboard_S_Diffuse.jpg', function (texture) {
   texture.wrapS = THREE.RepeatWrapping;
   texture.wrapT = THREE.RepeatWrapping;
   texture.repeat.set(64, 64);
   var geometry = new THREE.PlaneGeometry(50, 50, 10, 150);
   var material = new THREE.MeshPhongMaterial({ map: texture });
   var terrain = new THREE.Mesh(geometry, material);
   terrain.rotation.x = -Math.PI / 2;
   terrain.position.y = -15;
   scene.add(terrain);
 });

 const loader2 = new GLTFLoader();
       loader2.load('./great_mountain/scene.gltf', function(gltf){
       const model = gltf.scene;
       scene.add(model)
       model.scale.set(3,3,3)
       model.position.set(0,50,0)
       
   });
   
 // Create houses
 var houseCount = 3;
 var houseGeometry = new THREE.BoxGeometry(3, 3, 3); // size of house
 var houseMaterial = new THREE.MeshPhongMaterial({ color: 0xFFFFFF });
 var houses = new THREE.Group();

 for (var i = 0; i < houseCount; i++) {
   var houseMesh = new THREE.Mesh(houseGeometry, houseMaterial);
   houseMesh.position.set(
     (Math.random() - 0.5) * 40,
     -13.5,
     (Math.random() - 0.5) * 40
   );
   houses.add(houseMesh);
 }

 scene.add(houses);

 // Render the scene
 var animate = function() {
   requestAnimationFrame(animate);

   // Update the cube's position
   cableCar.position.x += direction.x * speed;
   cableCar.position.y += direction.y * speed;
   cableCar.position.z += direction.z * speed;

  
   // Reverse direction if the cableCar goes out of bounds
 
   if (cableCar.position.y < -16 ) {
       //restart
       //wait 5 seconds
       cableCar.position.set(-10, -6, -5);
   }
   if(cableCar2.position.y > 12){
       cableCar2.position.set(10,-12,12)
   }
  
   for (i = 0; i < flakeArray.length / 2; i++) {
       flakeArray[i].rotation.y += 0.01;
       flakeArray[i].rotation.x += 0.02;
       flakeArray[i].rotation.z += 0.03;
       flakeArray[i].position.y -= 0.018;
       if (flakeArray[i].position.y < -4) {
         flakeArray[i].position.y += 10;
       }
     }
     for (i = flakeArray.length / 2; i < flakeArray.length; i++) {
       flakeArray[i].rotation.y -= 0.03;
       flakeArray[i].rotation.x -= 0.03;
       flakeArray[i].rotation.z -= 0.02;
       flakeArray[i].position.y -= 0.016;
       if (flakeArray[i].position.y < -4) {
         flakeArray[i].position.y += 9.5;
       }
   
       snow.rotation.y -= 0.0000005;
     }

   controls.update();

   renderer.render(scene, camera);
 };

 animate();
}