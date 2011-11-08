//  Tj Ticker View
//
//  Base created as JHTickerView by Jeff Hodnett on 03/05/2011.
//
//
//  Converted into ARC for iOS5, made each string a clickable button and rewrote the animation mechanism so that multiple strings can be on screen at once.
//  by Tj Fallon on 11/08/2011.
//  No Copyright.
//

#import "TJTickerView.h"
#import <QuartzCore/QuartzCore.h>

@interface TJTickerView(Private)
-(void)setupView;
-(void)animateCurrentTickerString;
-(void)pauseLayer:(CALayer *)layer;
-(void)resumeLayer:(CALayer *)layer;
@end

@implementation TJTickerView

@synthesize tickerStrings;
@synthesize tickerSpeed;
@synthesize loops;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self setupView];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
	if( (self = [super initWithCoder:aDecoder]) ) {
		// Initialization code
		[self setupView];
	}
	return self;
}


-(void)setupView {

	
	// Set the font
	tickerFont = [UIFont fontWithName:@"HelveticaNeue-MediumCond" size:14.0];
	/*

	// Set that it loops by default
	loops = YES;
}

-(void)animateCurrentTickerString
{
    
	
    
	if((tickerLabel.frame.size.width+tickerLabel.frame.origin.x+50 <self.frame.size.width || firstString) && running){
        
        firstString = FALSE;
        
        
        
        // Check the index count
        if(currentIndex >= [tickerStrings count]) {
            currentIndex = 0;
            
            // Check if we should loop
            if(!loops) {
                // Set not running
                running = NO;
                
                return;
            }
        }
        
        NSString *currentString = [tickerStrings objectAtIndex:currentIndex];
        
        // Calculate the size of the text and update the frame size of the ticker label
        CGSize textSize = [currentString sizeWithFont:tickerFont constrainedToSize:CGSizeMake(9999, self.frame.size.height) lineBreakMode:UILineBreakModeWordWrap];
        
        // Move off screen
        tickerLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        //or whatever font you're using
       
        [tickerLabel setFrame:CGRectMake(768, 5, textSize.width+10, textSize.height+5)];

        [tickerLabel setBackgroundColor:[UIColor clearColor]];
        [tickerLabel setTitleColor:UIColorFromRGB(0xcccc00) forState:UIControlStateNormal];
        tickerLabel.titleLabel.font = tickerFont;
        [tickerLabel.titleLabel setHidden:NO];
        [tickerLabel setTitle:currentString forState:UIControlStateNormal];
        [tickerLabel addTarget:self action:@selector(labelClicked:) forControlEvents:UIControlEventTouchUpInside];
        [tickerLabel setTag:currentIndex];
		[self addSubview:tickerLabel];
        // Calculate a uniform duration for the item	
        
        [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(doAnimation:) userInfo:tickerLabel repeats:YES];
        // Create a UIView animation

        
        currentIndex++;
    }
}
-(void)labelClicked:(id)sender{
    NSLog(@"%d", [sender tag]);
}
-(void)doAnimation:(id)sender{
    
    UIButton *ticker = [sender userInfo];
    
    if(ticker.frame.origin.x >-ticker.frame.size.width){
        
        CGSize textSize = [ticker.titleLabel.text sizeWithFont:tickerFont constrainedToSize:CGSizeMake(9999, self.frame.size.height) lineBreakMode:UILineBreakModeWordWrap];
        
        float duration = (textSize.width + self.frame.size.width) / tickerSpeed;
        float movement = .3;
        [ticker setFrame:CGRectMake(ticker.frame.origin.x-movement, ticker.frame.origin.y, ticker.frame.size.width, ticker.frame.size.height)];
        //[UIView setAnimationDidStopSelector:@selector(tickerMoveAnimationDidStop:finished:context:)];
       
        
        [UIView commitAnimations];
    }else{
        [sender invalidate];
    }
}
-(void)tickerMoveAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	// Update the index

	// Animate
	[self animateCurrentTickerString];
}

#pragma mark - Ticker Animation Handling
-(void)start {
	
	// Set the index to 0 on starting
	currentIndex = 0;
	firstString = TRUE;
	// Set running
	running = YES;
	
	// Start the animation
	[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animateCurrentTickerString) userInfo:nil repeats:YES];
}

-(void)pause {
	
	// Check if running
	if(running) {
		// Pause the layer
		[self pauseLayer:self.layer];
		
		running = NO;
	}
}

-(void)resume {

	// Check not running
	if(!running) { 
		// Resume the layer
		[self resumeLayer:self.layer];
		
		running = YES;
	}
}

#pragma mark - UIView layer animations utilities
-(void)pauseLayer:(CALayer *)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer *)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

@end
