import * as THREE from 'three';

import {OrbitControls} from 'three/examples/jsm/controls/OrbitControls';
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader.js';
import { Mesh } from 'three';
import { SpotLightHelper } from 'three';



const loader2 = new GLTFLoader();
const ladyski = new GLTFLoader();
const snowy = new GLTFLoader();
const road = new GLTFLoader();
const snow_rock = new GLTFLoader();
const snow_ground = new GLTFLoader();
const snow_house = new GLTFLoader();
const cars = new GLTFLoader();
const tower = new GLTFLoader();



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

 

 var ambientLight = new THREE.AmbientLight(0xffffff, 0.8);
 scene.add(ambientLight);

 const spotLight = new THREE.SpotLight(0xffffff, 0.8);
 scene.add(spotLight);

spotLight.angle = 0.8;

spotLight.position.set(0, 25, 0);
const SpotLightHelper = new THREE.SpotLightHelper(spotLight);
scene.add(SpotLightHelper);

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

 //cable car line
 // Create a line between the two mountains
 const material = new THREE.LineBasicMaterial( { color: 0x000000 } );
 const points = [];
 points.push( new THREE.Vector3( -20, 3, -19 ) );
 points.push( new THREE.Vector3( 15, -1, 35 ) );
 const geometry = new THREE.BufferGeometry().setFromPoints( points );
 const line = new THREE.Line( geometry, material );
 scene.add( line );

 // Add orbit controls to the camera
 var controls = new OrbitControls(camera, renderer.domElement);

 // Create the terrain
 var loader = new THREE.TextureLoader();
 loader.load('snow.jpg', function (texture) {
   texture.wrapS = THREE.RepeatWrapping;
   texture.wrapT = THREE.RepeatWrapping;
   texture.repeat.set(64, 64);
   var geometry = new THREE.PlaneGeometry(50, 50);
   var material = new THREE.MeshPhongMaterial({ map: texture });
   var terrain = new THREE.Mesh(geometry, material);
   terrain.rotation.x = -Math.PI / 2;
   terrain.position.y = -15;
   scene.add(terrain);
 });

  

   ladyski.load("asserts/skiing_lady/scene.gltf", function(gltf){
    const model = gltf.scene;
    scene.add(model)
    model.scale.set(1,1,1)
    model.position.set(-16,-13,-5)
    model.rotation.set(0,1.6,0)
   });

  // Define the two points
const startPosition = new THREE.Vector3(-20, 0, -19);
const endPosition = new THREE.Vector3(15, -3, 35);

// Define the teleferico model
const teleferico = new GLTFLoader();
teleferico.load("asserts/teleferico/scene.gltf", function(gltf){
  const model = gltf.scene;
  scene.add(model);
  model.scale.set(1,1,1);
  model.position.copy(startPosition);
  model.rotation.set(0,2.15,0);

  // Define the animation loop
  const duration = 20000; // Duration of one back-and-forth animation cycle in ms
  let startTime = null;
  function animateTeleferico(time) {
    if (!startTime) startTime = time;
    const progress = (time - startTime) % duration / duration; // Progress through the animation cycle as a value between 0 and 1
    const position = new THREE.Vector3().lerpVectors(startPosition, endPosition, progress); // Interpolate between the start and end positions
    model.position.copy(position);
    requestAnimationFrame(animateTeleferico);
  }

  // Start the animation loop
  requestAnimationFrame(animateTeleferico);
});



   snow_rock.load("asserts/snow_rock/scene.gltf", function(gltf){
    const model = gltf.scene;
    scene.add(model)
    model.scale.set(0.7,0.7,0.7)
    model.position.set(-13,-16.5,-10)
    model.rotation.set(0,4.5,0)
   });

   snow_ground.load("asserts/patch_of_old_snow/scene.gltf", function(gltf){
    const model = gltf.scene;
    scene.add(model)
    model.scale.set(50,50,50)
    model.position.set(-5,-15,-4)
    model.rotation.set(0,0,0)
   });

   snow_house.load("asserts/x_house/scene.gltf", function(gltf){
    const model = gltf.scene;
    scene.add(model)
    model.scale.set(1.5,1.5,1.5)
    model.position.set(15,-14,-10)
    model.rotation.set(0,0,0)
   });

   tower.load("asserts/watch_tower/scene.gltf", function(gltf){
    const model = gltf.scene;
    scene.add(model)
    model.scale.set(0.015,0.015,0.015)
    model.position.set(-20,-16.5,-19)
    model.rotation.set(0,4,0)
   });

   



  const models = [];
  let x = 15;


  road.load("asserts/snowy_road/scene.gltf", function(gltf){
      for (let i = 0; i < 38; i++) {
          const model = gltf.scene.clone();
          model.scale.set(2, 2, 2);
          const y = x--;
          model.position.set(y,-13.5,23);
          model.rotation.set(0, 1.6, 0);
          models.push(model);
          scene.add(model);
      }
      for (let i = 0; i <48; i++) {
        const model = gltf.scene.clone();
        model.scale.set(2, 2, 2);
        const y = x++;
        model.position.set(y,-13.5,23);
        model.rotation.set(0, 1.6, 0);
        models.push(model);
        scene.add(model);
    }
  });

  cars.load("asserts/cars/scene.gltf", function(gltf){
    const model = gltf.scene;
    scene.add(model)
    model.scale.set(1,1,1)
    model.position.set(3,-13.7,23)
    model.rotation.set(0,3.1,0)
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


 // Render the scene
 var animate = function() {
   requestAnimationFrame(animate);

  
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
   ladyski.crossOrigin = "anonymous";

   renderer.render(scene, camera);
 };

 animate();
}