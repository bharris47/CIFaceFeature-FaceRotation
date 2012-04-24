//
//  CIFaceFeature+FaceRotation.h
//
//  Created by Ben Harris on 4/21/12.
//

#import "CIFaceFeature+FaceRotation.h"

@implementation CIFaceFeature (FaceRotation)

- (CGFloat)faceRotation {
    if (!self.hasLeftEyePosition || !self.hasRightEyePosition || !self.hasMouthPosition) {        
        return 0;
    }
        
    CGPoint eyesMidPoint = CGPointMake((self.rightEyePosition.x + self.leftEyePosition.x) / 2,
                                       (self.rightEyePosition.y + self.leftEyePosition.y) / 2);
    
    CGPoint originEndPoint = CGPointMake(self.mouthPosition.x, eyesMidPoint.y);
    
    CGFloat angle1 = atan2f(self.mouthPosition.y - eyesMidPoint.y, self.mouthPosition.x - eyesMidPoint.x);
    CGFloat angle2 = atan2f(self.mouthPosition.y - originEndPoint.y, self.mouthPosition.x - originEndPoint.x);
    
    return angle1 - angle2;
}

@end
