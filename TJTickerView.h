

#import <UIKit/UIKit.h>


@interface TJTickerView : UIView {
    

	NSArray *tickerStrings;

	int currentIndex;

	float tickerSpeed;

	BOOL loops;

	BOOL running;
	
    BOOL firstString;

	UIButton *tickerLabel;
	

	UIFont *tickerFont;
}

@property(nonatomic, retain) NSArray *tickerStrings;
@property(nonatomic) float tickerSpeed;
@property(nonatomic) BOOL loops;
-(void)doAnimation:(id)sender;
-(void)start;
-(void)pause;
-(void)resume;

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@end
