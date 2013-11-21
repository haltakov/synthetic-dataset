Framework for generating synthetic ground truth data
====================================================

A driving simulator based on [VDrift](http://vdrift.net/) for generating synthetic ground truth data for stereo, optical flow and semantic segmentation. 

Project page: [http://campar.in.tum.de/Chair/ProjectSyntheticDataset](http://campar.in.tum.de/Chair/ProjectSyntheticDataset)

Please cite the following work if you use the framework or the dataset in your research:

> V. Haltakov , C. Unger, S. Ilic  
> **Framework for generation of synthetic ground truth data for driver assistance applications**  
> *35th German Conference on Pattern Recognition, 3.-6. September 2013*


Driving simulator
-----------------

The basis for the framework is the open-source driving simulator [VDrift](http://vdrift.net/). The original code is modified in order to allow images in different modalities like depth or optical flow to be generated. The original repository of the simulator was forked around April 2012 and therefore the state of the simulator can differ from the current version of VDrift.



Generation of ground truth data
-------------------------------

Several important changes have been made in order to allow for generating ground truth data:

 * Fixed frame rate
 * Modified replay system
 * Modified shaders for the generation of depth and flow maps
 * Modified textures for the generation of depth and flow maps and pixelwise semantic annotations
 * Interface for adding static cars to the scenes

The generation of the ground truth data is controlled via several command line parameters as described below.

 * *-dataset_mode MODE*  
This is the most important parameter specifying the type of images to be rendered. MODE can take the following values: 0 for camera images, 1 for depth maps, 2 and 3 for optical flow maps in X and Y direction respectively, 4 for pixelwise annotations and 5 for camera pose.
 * *-seq ID*  
Number of the sequence - used only in the file name of the generated images.
 * *-record*  
Enables the recording of the images. If this parameter is not specified the images will be rendered in the specified modality, but not saved to the disk.
 * *-dataset_folder PATH*  
A path to a folder where the result images will be saved.
 * *-frames_to_record N*  
Specifies that only every Nth frame should be saved instead of every frame.
 * *-replay PATH*  
A path to a replay file to be played automatically upon startup. If this parameter is specified the simulator will close after the end of replay. This allows multiple sequences to be processed in batch.
 * *-carlist PATH*  
A path to a file specifying the static cars in the scene.
 * *-show_position*  
If this parameter is set, the current pose of the car will be printed continuously in the console.



Usage
-----

The standard way to create the data is as follows:

 1. Drive around a track and select positions for static cars
 2. Create the carlist.txt file with description of the static cars
 3. Configure the camera pose and car parameters
 4. Drive around the track and record a replay
 5. Replay the sequence to generate the ground truth data
 

**1. Drive around a track and select positions for static cars**  
By using the -show_position parameter, the current pose of the car will be printed continuously in the console. This poses can be used to define the positions for the static cars. This step is optional.

**2. Create the carlist.txt file with description of the static cars**  
The carlist.txt file contains a specification of the type, color and pose of the static cars to be added to the scene. Example format:

> 2  
> XGS 0 0 0.1 -35.883125 -281.156189 1.156909 -0.002169 -0.002975 0.701136 0.713019  
> MCS 0 0 0.1 -25.993534 -280.888885 1.156892 -0.002077 -0.003045 0.724339 0.689434

The number N on the first for specifies the number of static cars. The following N rows specify one car each. The first word is the ID of the car, followed by three numbers between 0 and 1 specifying the RGB color of the car paint, 3 numbers for the X, Y and Z coordinates and 4 numbers for the orientation quaternion. This step is optional.


**3. Configure the camera pose and car parameters**  
Play around with the *.car* file of the cars you are going to use (*data\cars\CARID\CARID.car*) in order to change the camera pose and other car parameters. Limiting the RPM is an easy way to make the cars drive at normal speeds and not racing. This step is optional.


**4. Drive around the track and record a replay**  
When starting the game choose *Single race* if you want to add AI driven cars and *Practice game* otherwise. Make sure that *Record session* option is set to **OFF** (the setting in *Practice game* also applies to *Single race*). While driving use the key associated to the *Skip Forward* action (*Options->Controls->Replays*, default q) to start and stop recording. The replays are saved in the folder *settings/replays*.


**5. Replay the sequence to generate the ground truth data**  
Use the command line parameters to generate the images in the required modalities. See the folder *examples* for a sample batch file. See also the [project page](http://campar.in.tum.de/Chair/ProjectSyntheticDataset) for instructions how to interpret the data.



Cars and tracks
---------------

The framework comes with only 3 cars and 6 tracks that are configured for the framework. Additional cars and tracks can be found on the VDrift website ([cars](http://wiki.vdrift.net/index.php?title=Getting_cars) and [tracks](http://wiki.vdrift.net/index.php?title=Getting_tracks)). In order to adapt a track or a car, the segmentation textures should be created and put into a folder *segmentation*. Please see the provided cars and tracks for examples. While creating the segmentation textures make sure that they are not semi transparent. This step is important not only for the pixelwise annotations, but also for the generation of the depth and flow maps.



