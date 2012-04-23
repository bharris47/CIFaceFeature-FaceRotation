CIFaceFeature+FaceRotation
==========================

Category for calculating the rotation of a face detected with CoreImage face detection.

How to use it?
==============

It's simple. Detecting faces in iOS gives youa CIFaceFeature object which usually has CGPoints for the eyes and mouth.

This category uses those points to determine the angle of tilt to the face. 

0 would represent a perfectly up and down face.

![Screenshot](http://needgoodcode.com/images/face.png "Tilty Face")


License
=======
CIFaceFeature+FaceRotation is available under the MIT license. See the LICENSE file for more info.