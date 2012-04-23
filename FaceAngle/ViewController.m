//
//  ViewController.m
//
//  Created by Ben Harris on 4/21/12.
//

#import "ViewController.h"
#import "CIFaceFeature+FaceRotation.h"

@implementation ViewController
@synthesize imageView;
@synthesize rotationInfo;
@synthesize features;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self detectFaces];
}

- (void)detectFaces {
    UIImage *image = [UIImage imageNamed:@"face.jpg"];
    self.imageView.image = image;
    
    CIDetector *faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace 
                                                  context:nil 
                                                  options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh 
                                                                                      forKey:CIDetectorAccuracy]];
    
    self.features = [faceDetector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    
    NSMutableString *rotations = [NSMutableString string];
    
    // show the face angle in degrees
    if (self.features.count > 0) {
        for (CIFaceFeature *feature in self.features) {
            CIFaceFeature *faceFeature = (CIFaceFeature *) feature;               
            [rotations appendFormat:@"%f, ", [faceFeature faceRotation] * 180/M_PI];
        }
    }
        
    if (rotations.length > 0) {
        self.rotationInfo.text = [rotations substringWithRange:NSMakeRange(0, rotations.length-2)];
    }
    
    [self traceAngle];
}

- (void)traceAngle {
    UIImage *image = self.imageView.image;
    
    // only draws the first detected face angle
    CIFaceFeature *feature = [self.features objectAtIndex:0];
    
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        
    CGPoint eyesMidPoint = CGPointMake((feature.rightEyePosition.x + feature.leftEyePosition.x) / 2,
                                       (feature.rightEyePosition.y + feature.leftEyePosition.y) / 2);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 10.0);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, eyesMidPoint.x, image.size.height - eyesMidPoint.y);
    CGContextAddLineToPoint(context, feature.mouthPosition.x, image.size.height - feature.mouthPosition.y);
    CGContextAddLineToPoint(context, feature.mouthPosition.x, image.size.height - eyesMidPoint.y);
    CGContextStrokePath(context);
        
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.imageView.image = newImage;
}

- (void)dealloc {
    self.imageView = nil;
    self.rotationInfo = nil;
    self.features = nil;
    [super dealloc];
}
@end
