CIFaceFeature+FaceRotation
==========================

Category for calculating the rotation of a face detected with CoreImage face detection.

How does it work?
=================

It's simple. iOS Face Detection gives you a CIFaceFeature object which usually has CGPoints for the eyes and mouth.

This category uses those points to determine the angle of the face. 

0&#176; would represent a perfectly up and down face.

![Screenshot](http://needgoodcode.com/images/face.png "Tilty Face")

How to use it.
=============

The category adds a method to CIFaceFeature called `faceRotation` which returns the angle of the face in radians.

The angle of the face is positive if tilted left and negative if tilted right.

License
=======
CIFaceFeature+FaceRotation is available under the MIT license. See the LICENSE file for more info.