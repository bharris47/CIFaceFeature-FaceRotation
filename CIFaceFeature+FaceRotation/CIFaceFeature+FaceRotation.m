//
//  CIFaceFeature+FaceRotation.h
//
//  Created by Ben Harris on 4/21/12.
//

#import "CIFaceFeature+FaceRotation.h"

struct CGLine {
    CGPoint p1;
    CGPoint p2;
};
typedef struct CGLine CGLine;

static CGLine CGLineMake(CGPoint point1, CGPoint point2) {
    CGLine line;
    line.p1 = point1;
    line.p2 = point2;
    
    return line;
}

@implementation CIFaceFeature (FaceRotation)

- (CGFloat)faceRotation {
    if (!self.hasLeftEyePosition || !self.hasRightEyePosition || !self.hasMouthPosition) {        
        return 0;
    }
        
    CGPoint eyesMidPoint = CGPointMake((self.rightEyePosition.x + self.leftEyePosition.x) / 2,
                                       (self.rightEyePosition.y + self.leftEyePosition.y) / 2);
    
    CGPoint originEndPoint = CGPointMake(self.mouthPosition.x, eyesMidPoint.y);
    
    CGLine eyeLine = CGLineMake(self.mouthPosition, eyesMidPoint);
    CGLine originLine = CGLineMake(self.mouthPosition, originEndPoint);
    
    CGFloat angle1 = atan2f(eyeLine.p1.y - eyeLine.p2.y, eyeLine.p1.x - eyeLine.p2.x);
    CGFloat angle2 = atan2f(originLine.p1.y - originLine.p2.y, originLine.p1.x - originLine.p2.x);
    
    return angle1 - angle2;
}

@end
