//
//  ViewController.m
//
//  Created by Ben Harris on 4/21/12.
//

#import "ViewController.h"
#import "CIFaceFeature+FaceRotation.h"

@implementation ViewController
@synthesize imageView;
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
        
    [self hipster];
}

- (void)hipster {
    UIImage *image = self.imageView.image;
    UIImage *glasses = [UIImage imageNamed:@"glasses.png"];
    
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    for (CIFaceFeature *feature in self.features) {
        CGFloat glassesWidth = feature.bounds.size.width;
        CGSize glassesSize = CGSizeMake(glassesWidth, (glassesWidth / glasses.size.width) * glasses.size.height);
                
        CGContextTranslateCTM(context, image.size.width / 2, image.size.height / 2);
        CGContextRotateCTM(context, -[feature faceRotation]);
        CGContextTranslateCTM(context, -image.size.width / 2, -image.size.height / 2);

        
        CGPoint eyesMidPoint = CGPointMake((feature.rightEyePosition.x + feature.leftEyePosition.x) / 2,
                                           (feature.rightEyePosition.y + feature.leftEyePosition.y) / 2);
        
        CGRect glassesRect = CGRectMake(eyesMidPoint.x - glassesSize.width / 2,
                                        image.size.height - eyesMidPoint.y - glassesSize.height / 2,
                                        glassesSize.width, glassesSize.height);
        
        [glasses drawInRect:glassesRect];
        
        CGContextTranslateCTM(context, image.size.width / 2, image.size.height / 2);
        CGContextRotateCTM(context, [feature faceRotation]);
        CGContextTranslateCTM(context, -image.size.width / 2, -image.size.height / 2);
    }
        
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.imageView.image = newImage;
}

- (void)dealloc {
    self.imageView = nil;
    self.features = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

@end
