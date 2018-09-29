// rnd.today=new Date(); 
// rnd.seed=rnd.today.getTime(); 
// function rnd() { 
// 　　　　rnd.seed = (rnd.seed*9301+49297) % 233280; 
// 　　　　return rnd.seed/(233280.0); 
// }; 
// function rand(number) { 
// 　　　　return Math.ceil(rnd()*number); 
// }; 

// function myInit()
// {

    // $all_images = glob("/your/directory/{*.jpg, *.JPG, *.JPEG, *.png, *.PNG}", GLOB_BRACE);

    // shuffle($all_images); // uncomment this line to randomize the images

    // $images = array();

    // foreach ($all_images as $index => $image) 
    // {
    //     if ($index == 15) break;  // Only print 15 images
    //     $image_name = basename($image);
    //     echo "<img src='/public/directory/{$image_name}' />";
// }
var glob = require("glob")
$images = glob("./assets/headers/{*.jpg, *.JPG, *.JPEG, *.png, *.PNG}", GLOB_BRACE);
// foreach(array_rand($images,10) as $key) //display 10 image
// {
    $key = array_rand($images,10)
    // console.log('<img src="'.$images[$key].'" />');
    console.log('.$images[$key].');
// }

// }