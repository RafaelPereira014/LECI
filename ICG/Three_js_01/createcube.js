
function create(edgelegnth,x,y,z,color,flag,scene){

    var geometry = new THREE.BoxBufferGeometry(edgelegnth, edgelegnth, edgelegnth);
    var material = new THREE.MeshBasicMaterial({ color, wireframe:flag});
    var cube = new THREE.Mesh(geometry, material);

    cube.position.set(x,y,z);


    scene.add(cube);

}