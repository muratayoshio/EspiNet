# EspiNet
EspiNet a Deep Learning model mased on Faster R-CNN
# Use of EspiNet Matlab Code
EspiNet is a network base don Faster R-CNN able to classify motorcycles in occluded scenarios. For more information ask jeespinosa@elpoli.edu.co.
# Data preparation.
EspiNet uses a Struct file created from a VIPER ground true file (Where the annotations are docummented), and the file system directory location of the frames (independent images) used for training and validation.
# Matlab Code used
In order to use the data images and the annotations from the ground true, it is necessary to call the toFasterRCNN.m this software is based on Fei code for frame evaluation. The file Load the groundtruth and creates a mat structure useful for EspiNet Code.
# EspiNet Code
The Code (EspiNet.m) used for the EspiNet implementation is based on  https://la.mathworks.com/help/vision/examples/object-detection-using-faster-r-cnn-deep-learning.html
