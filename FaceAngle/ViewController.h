//
//  ViewController.h
//
//  Created by Ben Harris on 4/21/12.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UILabel *rotationInfo;
@property (retain, nonatomic) NSArray *features;

@end
