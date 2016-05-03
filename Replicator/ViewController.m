//
//  ViewController.m
//  Replicator
//
//  Created by Justin Madewell on 8/28/15.
//  Copyright © 2015 Justin Madewell. All rights reserved.
//

#import "ViewController.h"
#import "JDMUtility.h"
#import <pop/POP.h>



// From Article about Replicator Layer
#define SUBLAYER_WIDTH  50
#define SUBLAYER_HEIGHT 50
#define INTERSPACE      8
#define XINSTANCES      4
#define YINSTANCES      6



@interface ViewController ()

@property CALayer *layerToReplicate;
@property NSArray *replicatedLayers;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    [self setupForReplicatorLayer];
    
    
}

-(UIView*)hudView
{
    UIView *hudView = [[UIView alloc]init];
    int kDefaultHUDSide = ScreenSmaller() * 0.90;
    
    hudView.bounds = CGRectMake(0, 0, kDefaultHUDSide, kDefaultHUDSide);
    hudView.layer.cornerRadius = 10.;
    hudView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    hudView.layer.borderColor = [[UIColor whiteColor] CGColor];
    hudView.layer.borderWidth = 1.0;
    hudView.center = CGPointMake(CGRectGetMidX([self.view frame]),
                                 CGRectGetMidY([self.view frame]));
    
    hudView.clipsToBounds = YES;
   
    return hudView;
}


-(void)setupForReplicatorLayer
{
    UIView *hudView = [self hudView];
    
    [self.view addSubview:hudView];
    
    int flatGridNumber = 4;
    
    int actualGridCount = (flatGridNumber*2)-1;
    
    CGFloat spacePerLayerSize =  hudView.frame.size.width/actualGridCount ;
    
    CGFloat padding = spacePerLayerSize/12;
    
    CGFloat totalPadding = actualGridCount * padding;
    CGFloat layerSize = (hudView.frame.size.width - totalPadding) / actualGridCount;
    
    [self replicateLayer:[self makeShapeLayer:layerSize] toGridOfSize:SCNVector3Make(flatGridNumber, flatGridNumber, flatGridNumber) insideOfLayer:hudView.layer];
}



-(CAShapeLayer*)makeLayerToReplicateOfSize:(CGFloat)size
{
//    int layerSize = size;
//    CALayer *layer = [CALayer layer];
//    layer.bounds = CGRectMake(0, 0, layerSize, layerSize);
//    
//    UIColor *layerC = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
//    
//    layer.backgroundColor = layerC.CGColor;
//    layer.cornerRadius = layerSize/4;
//    
//    layer.shadowColor = [[UIColor blackColor] CGColor];
//    layer.shadowRadius = 4.0f;
//    layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
//    
//    //layer.shadowOpacity = 0.8;
//    //layer.opacity = 0.8;
//    
//    layer.borderColor = [[UIColor lightGrayColor] CGColor];
//    layer.borderWidth = 2.0;
//    
//    [layer ensureAnchorPointIsSetToZero];
    
    
    return [self makeShapeLayer:size];

}




//-(void)handlePan:(UIPanGestureRecognizer*)recognizer
//{
//    UIView *view = (UIView *)[recognizer view];
//    CGPoint pointOfTouchInside = [recognizer locationInView:view];
//    
//    CGPoint touchAnchor = CGPointClamp_AGK(CGPointConvertToAnchorPoint_AGK(pointOfTouchInside, view.bounds), 0.0, 1.0, 0.0, 1.0);
//    
//    for (CAShapeLayer *shapeLayer in _replicatedLayers) {
//        
//        AGKQuad desiredQuad = AGKQuadMakeWithCGRect(RectFromShapeLayer(shapeLayer));
//        
//        if(recognizer.state != UIGestureRecognizerStateEnded)
//        {
//            const CGFloat maxInsetX = 0.06;
//            const CGFloat maxInsetY = 0.06;
//            
//            desiredQuad.tl.x = AGKInterpolate(desiredQuad.tl.x, desiredQuad.tr.x, AGKRemap(touchAnchor.x, 0.0, 1.0, maxInsetX, 0.03));
//            desiredQuad.tl.y = AGKInterpolate(desiredQuad.tl.y, desiredQuad.bl.y, AGKRemap(touchAnchor.x, 0.0, 1.0, maxInsetY, 0.03));
//            desiredQuad.tr.x = AGKInterpolate(desiredQuad.tr.x, desiredQuad.tl.x, AGKRemap(touchAnchor.x, 1.0, 0.0, maxInsetX, 0.03));
//            desiredQuad.tr.y = AGKInterpolate(desiredQuad.tr.y, desiredQuad.br.y, AGKRemap(touchAnchor.x, 1.0, 0.0, maxInsetY, 0.03));
//            
////            desiredQuad.bl.x = AGKInterpolate(desiredQuad.bl.x, desiredQuad.br.x, AGKRemap(touchAnchor.y, 1.0, 0.0, maxInsetX, 0.03));
////            desiredQuad.bl.y = AGKInterpolate(desiredQuad.bl.y, desiredQuad.tr.y, AGKRemap(touchAnchor.y, 1.0, 0.0, maxInsetY, 0.03));
////            desiredQuad.br.x = AGKInterpolate(desiredQuad.br.x, desiredQuad.bl.x, AGKRemap(touchAnchor.y, 0.0, 1.0, maxInsetX, 0.03));
////            desiredQuad.br.y = AGKInterpolate(desiredQuad.br.y, desiredQuad.tl.y, AGKRemap(touchAnchor.y, 0.0, 1.0, maxInsetY, 0.03));
//            
//            
//        }
//        
//        NSArray *cornersForProperties = @[kPOPLayerAGKQuadTopLeft, kPOPLayerAGKQuadTopRight, kPOPLayerAGKQuadBottomRight, kPOPLayerAGKQuadBottomLeft];
//        
//        for(int cornerIndex = 0; cornerIndex < 4; cornerIndex++)
//        {
//            NSString *propertyName = cornersForProperties[cornerIndex];
//            
//            POPSpringAnimation *anim = [shapeLayer pop_animationForKey:propertyName];
//            if(anim == nil)
//            {
//                anim = [POPSpringAnimation animation];
//                anim.property = [POPAnimatableProperty AGKPropertyWithName:propertyName];
//                [shapeLayer pop_addAnimation:anim forKey:propertyName];
//            }
//            
//            anim.springSpeed = 14;
//            anim.springBounciness = 15;
//            
//            switch (cornerIndex) {
//                case 0:
//                    anim.toValue = [NSValue valueWithCGPoint:desiredQuad.tl];
//                    break;
//                case 1:
//                    anim.toValue = [NSValue valueWithCGPoint:desiredQuad.tr];
//                    break;
//                case 2:
//                    anim.toValue = [NSValue valueWithCGPoint:desiredQuad.br];
//                    break;
//                case 3:
//                    anim.toValue = [NSValue valueWithCGPoint:desiredQuad.bl];
//                    break;
//                default:
//                    break;
//            }
//        }
//        
//        
//    }
//    
//    
//    if (recognizer.state == UIGestureRecognizerStateEnded) {
//        // do something once gesture ends
//    }
//    
//    
//    
//}

-(CALayer*)replicateLayer:(CAShapeLayer*)layerToReplicate toGridOfSize:(SCNVector3)gridSize insideOfLayer:(CALayer*)containerLayer
{
    CALayer *baseLayer = [CALayer layer];
    
    BOOL shouldUseColorOffset = NO;
    
    // setup variables for gridBuilding
    int horizontalInstances = (int)gridSize.x;
    int verticalInstances = (int)gridSize.y;
    int depthInstances = (int)gridSize.z;
    
    UIBezierPath *shapePath = [UIBezierPath bezierPathWithCGPath:layerToReplicate.path];
    CGRect shapePathRect = PathBoundingBox(shapePath);
    
    int instancedWidth = shapePathRect.size.width;
    int instancedHeight = shapePathRect.size.height;
    
    int gridPadding = shapePathRect.size.width/12;
    
    CGSize containerSize = CGSizeMake(containerLayer.bounds.size.width, containerLayer.bounds.size.height);
    CGRect containerRect = CGRectMake(0, 0, containerSize.width, containerSize.height);
    
    CGFloat horizontalDelay = 1.5/5;
    //CGFloat verticalDelay = .256;
    CGFloat depthDelay = .25;
   
    // Setup for Replicators
    CGFloat replicatedSize = instancedWidth;
    
    CGFloat x = containerLayer.bounds.size.width*0.5;
    CGFloat y = containerLayer.bounds.size.height*0.5;
    
    CGPoint firstLayerPosition = CGPointMake(x-instancedWidth/2,y-instancedHeight/2);

    CGFloat offset = 0 ;
    
    if (shouldUseColorOffset) {
        offset = 1.0 / horizontalInstances ;
    }

    
    CGFloat verticalTransform = instancedHeight+gridPadding;
    CGFloat horizontalTransform = instancedWidth+gridPadding;
    
    // create the Horizontal Layer (X)
    CAReplicatorLayer *rightHorizontalLayer = [CAReplicatorLayer layer];
    rightHorizontalLayer.instanceCount = horizontalInstances;
    rightHorizontalLayer.instanceDelay = horizontalDelay;
    
    rightHorizontalLayer.instanceGreenOffset = -offset/2;
    rightHorizontalLayer.instanceRedOffset = -offset/4;
    rightHorizontalLayer.instanceBlueOffset = -offset/2;
    
    rightHorizontalLayer.instanceTransform = CATransform3DMakeTranslation(horizontalTransform, 0, 0);
    
    CAReplicatorLayer *leftHorizontalLayer = [CAReplicatorLayer layer];
    leftHorizontalLayer.instanceCount = horizontalInstances;
    leftHorizontalLayer.instanceDelay = horizontalDelay;
    
    leftHorizontalLayer.instanceGreenOffset = -offset/2;
    leftHorizontalLayer.instanceRedOffset = -offset/4;
    leftHorizontalLayer.instanceBlueOffset = -offset;
    
    leftHorizontalLayer.preservesDepth = YES;
    leftHorizontalLayer.instanceTransform = CATransform3DMakeTranslation(-horizontalTransform, 0, 0);
    
    CAReplicatorLayer *rightHorizontalLayer_B = [CAReplicatorLayer layer];
    rightHorizontalLayer_B.instanceCount = horizontalInstances;
    rightHorizontalLayer_B.instanceDelay = horizontalDelay;
    rightHorizontalLayer_B.instanceGreenOffset = -offset;
    rightHorizontalLayer_B.instanceRedOffset = -offset;
    rightHorizontalLayer_B.instanceBlueOffset = -offset;
    rightHorizontalLayer_B.instanceTransform = CATransform3DMakeTranslation(horizontalTransform, 0, 0);
    
    CAReplicatorLayer *leftHorizontalLayer_B = [CAReplicatorLayer layer];
    leftHorizontalLayer_B.instanceCount = horizontalInstances;
    leftHorizontalLayer_B.instanceDelay = horizontalDelay;
    leftHorizontalLayer_B.instanceGreenOffset = -offset;
    leftHorizontalLayer_B.instanceRedOffset = -offset;
    leftHorizontalLayer_B.instanceBlueOffset = -offset;
    leftHorizontalLayer_B.preservesDepth = YES;
    leftHorizontalLayer_B.instanceTransform = CATransform3DMakeTranslation(-horizontalTransform, 0, 0);

    
    // create Depth Layer (Z)
    CAReplicatorLayer *depthLayer = [CAReplicatorLayer layer];
    depthLayer.instanceCount = depthInstances;
    depthLayer.instanceDelay = depthDelay;
    depthLayer.preservesDepth = YES;
    depthLayer.instanceGreenOffset = .5;
    depthLayer.instanceRedOffset = .5;
    depthLayer.instanceBlueOffset = .5;
    depthLayer.instanceTransform = CATransform3DMakeTranslation(0, 0, -32);
    depthLayer.bounds = containerRect;
    depthLayer.position = RectGetCenter(containerRect);
    
    // create Root Layer to stack the CAReplicator Layers in
    CALayer *rootLayer = [CALayer layer];
    rootLayer.bounds = containerRect;
    rootLayer.position = RectGetCenter(containerRect);
    rootLayer.backgroundColor = [[UIColor darkGrayColor] CGColor];
    
    // set the perspective transform on the Root Layer
    CATransform3D tI = CATransform3DIdentity;
    tI.m34 = 1.0 / -900.0;
    rootLayer.sublayerTransform = tI;
    
    // Stack the Replication layers to create the 3d gridlike effect.
    
    CALayer *top_horizontalLayers = [CALayer layer];
    CALayer *bottom_horizontalLayers = [CALayer layer];
    CALayer *replicatedLayers = [CALayer layer];
    
    // make a top replication layer
    int topAndBottomInstances = verticalInstances;
    
    CAReplicatorLayer *topReplicatedLayer = [CAReplicatorLayer layer];
    topReplicatedLayer.instanceCount = topAndBottomInstances;
    topReplicatedLayer.instanceDelay = 0.0;
    topReplicatedLayer.preservesDepth = YES;
    CGFloat topTransform = verticalTransform;
    topReplicatedLayer.instanceTransform = CATransform3DMakeTranslation(0,-topTransform,0);
    topReplicatedLayer.instanceGreenOffset = 0;
    topReplicatedLayer.instanceRedOffset = 0;
    topReplicatedLayer.instanceBlueOffset = 0;

    
    // Make Bottom Replication Layer
    CAReplicatorLayer *bottomReplicatedLayer = [CAReplicatorLayer layer];
    bottomReplicatedLayer.instanceCount = topAndBottomInstances;
    bottomReplicatedLayer.instanceDelay = 0.0;
    bottomReplicatedLayer.preservesDepth = YES;
    CGFloat bottomTransform = verticalTransform;
    bottomReplicatedLayer.instanceTransform = CATransform3DMakeTranslation(0,bottomTransform,0);
    bottomReplicatedLayer.instanceGreenOffset = 0;
    bottomReplicatedLayer.instanceRedOffset = 0;
    bottomReplicatedLayer.instanceBlueOffset = 0;


    // (X)
    CAShapeLayer *leftCloneLayer = [self makeShapeLayer:replicatedSize];
    leftCloneLayer.position = firstLayerPosition;
    
    CAShapeLayer *rightCloneLayer =  [self makeShapeLayer:replicatedSize];
    rightCloneLayer.position = firstLayerPosition;
    
    CAShapeLayer *leftCloneLayer_B =  [self makeShapeLayer:replicatedSize];
    leftCloneLayer_B.position = firstLayerPosition;
    
    CAShapeLayer *rightCloneLayer_B = [self makeShapeLayer:replicatedSize];
    rightCloneLayer_B.position = firstLayerPosition;
    
    [leftHorizontalLayer addSublayer:leftCloneLayer];
    [rightHorizontalLayer addSublayer:rightCloneLayer];
    
    [leftHorizontalLayer_B addSublayer:leftCloneLayer_B];
    [rightHorizontalLayer_B addSublayer:rightCloneLayer_B];
    
    top_horizontalLayers.sublayers = @[leftHorizontalLayer,rightHorizontalLayer];
    bottom_horizontalLayers.sublayers = @[leftHorizontalLayer_B,rightHorizontalLayer_B];
    
    [topReplicatedLayer addSublayer:top_horizontalLayers];
    [bottomReplicatedLayer addSublayer:bottom_horizontalLayers];
    
    replicatedLayers.sublayers = @[topReplicatedLayer,bottomReplicatedLayer];
    
    [depthLayer addSublayer:replicatedLayers];
    
    NSArray *rootSublayers = @[depthLayer,];
    
    // Last Layer addition
    rootLayer.sublayers = rootSublayers;
    [containerLayer addSublayer:rootLayer];
    layerToReplicate.position = firstLayerPosition;
    
    // Animations
    
    NSArray *clonedLayers = @[leftCloneLayer,leftCloneLayer_B,rightCloneLayer,rightCloneLayer_B];
    
    [self fillAnimationForLayer:leftCloneLayer];

    [self fillAnimationForLayer:leftCloneLayer_B];

    [self fillAnimationForLayer:rightCloneLayer];

    [self fillAnimationForLayer:rightCloneLayer_B];
    
    [depthLayer addAnimation:[self waveAnimation] forKey:@"wave"];

    _replicatedLayers = clonedLayers;
     
    baseLayer = rootLayer;
    return baseLayer;
}





#pragma mark - Replicator Animations
- (CAAnimationGroup*)changeColorGroupAnimation
{
    NSValue *toValue = @(-1.0);
    NSValue *fromValue = @(1.0);
    
    CABasicAnimation *greenAnimation = [CABasicAnimation animationWithKeyPath:@"instanceGreenOffset"];
    greenAnimation.fromValue =fromValue;
    greenAnimation.toValue = toValue;
    greenAnimation.beginTime = 3.0;
    greenAnimation.autoreverses = YES;
    greenAnimation.repeatCount = HUGE_VAL;
    greenAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *redAnimation = [CABasicAnimation animationWithKeyPath:@"instanceRedOffset"];
    redAnimation.fromValue = fromValue;
    redAnimation.toValue = toValue;
    redAnimation.beginTime = 2;
    redAnimation.autoreverses = YES;
    redAnimation.repeatCount = HUGE_VAL;
    redAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    CABasicAnimation *blueAnimation = [CABasicAnimation animationWithKeyPath:@"instanceBlueOffset"];
    blueAnimation.fromValue = fromValue;
    blueAnimation.toValue = toValue;
    blueAnimation.beginTime = 0.250;
    blueAnimation.autoreverses = YES;
    blueAnimation.repeatCount = HUGE_VAL;
    blueAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[ greenAnimation, redAnimation, blueAnimation ];
    group.duration = 6;
    group.autoreverses = YES;
    group.repeatCount = HUGE_VAL;
    
    return group;
    

}


-(void)fillAnimationForLayer:(CAShapeLayer*)layer
{
    CGRect workRect = RectFromShapeLayer(layer);
    CGPoint center = RectGetCenter(workRect);
  
    CGSize startSize = CGSizeMake(0.01, 0.01);
    CGSize endSize = CGSizeMake(workRect.size.width+.01,workRect.size.width+.01);
    
    UIBezierPath *startShape = [UIBezierPath bezierPathWithRoundedRect:RectAroundCenter(center, startSize) cornerRadius:startSize.width/2];
    UIBezierPath *endShape = [UIBezierPath bezierPathWithRoundedRect:RectAroundCenter(center, endSize) cornerRadius:endSize.width/2];
    
    CAShapeLayer *fillShapeLayer = [CAShapeLayer layer];
    fillShapeLayer.fillColor = [UIColor whiteColor].CGColor;
    fillShapeLayer.path = startShape.CGPath;
    
    //[fillShapeLayer ensureAnchorPointIsSetToZero];
    
    [layer addSublayer:fillShapeLayer];
    
    [fillShapeLayer addAnimation:[self changeFillColor] forKey:@"changeFillColor"];
    
    // change the model
    fillShapeLayer.path = endShape.CGPath;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = 2.0;
    pathAnimation.fromValue =  (__bridge id _Nullable)(startShape.CGPath);
    pathAnimation.toValue = (__bridge id _Nullable)(endShape.CGPath);
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.autoreverses = NO;
    pathAnimation.repeatCount = HUGE_VAL;
    
    [fillShapeLayer addAnimation:pathAnimation forKey:@"pathFill"];
    
}

-(CAKeyframeAnimation*)changeFillColorForMainLayer
{
    // Animation 2
    CAKeyframeAnimation* fillColorAnim = [CAKeyframeAnimation animationWithKeyPath:@"fillColor"];
    NSArray* colorValues = [NSArray arrayWithObjects:(id)[UIColor blueColor].CGColor,
                            (id)[UIColor redColor].CGColor, (id)[UIColor greenColor].CGColor,  nil];
    fillColorAnim.values = colorValues;
    fillColorAnim.calculationMode = kCAAnimationPaced;
    
    fillColorAnim.duration = 9;
    fillColorAnim.autoreverses = NO;
    fillColorAnim.repeatCount = HUGE_VALF;
    
    return fillColorAnim;
}


-(CAKeyframeAnimation*)changeBezierPathTo:(NSArray*)bezierPaths
{
    CAKeyframeAnimation *bezierPathAnimation = [CAKeyframeAnimation animation];
    bezierPathAnimation.keyPath = @"path";
    bezierPathAnimation.values = bezierPaths;
    //bezierPathAnimation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    bezierPathAnimation.duration = 12.0;
    bezierPathAnimation.autoreverses = NO;
    bezierPathAnimation.repeatCount = HUGE_VALF;
    
    // bezierPathAnimation.additive = YES;

    return bezierPathAnimation;
}



-(CAKeyframeAnimation*)changeFillColor
{
    // Animation 2
    CAKeyframeAnimation* fillColorAnim = [CAKeyframeAnimation animationWithKeyPath:@"fillColor"];
    NSArray* colorValues = [NSArray arrayWithObjects:(id)[UIColor greenColor].CGColor,
                            (id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor,  nil];
    fillColorAnim.values = colorValues;
    fillColorAnim.calculationMode = kCAAnimationPaced;
    
    fillColorAnim.duration = 9;
    fillColorAnim.autoreverses = NO;
    fillColorAnim.repeatCount = HUGE_VALF;
    
    return fillColorAnim;
}



-(CAAnimationGroup*)changeColorGroup
{
    // Animation 1
    CAKeyframeAnimation* widthAnim = [CAKeyframeAnimation animationWithKeyPath:@"lineWidth"];
    NSArray* widthValues = [NSArray arrayWithObjects:@1.0, @2.0, @4.0, @6.0, @8.0, @10.0, @9.0, @7.0, @4.5, @2.0, @1.0,nil];
    //  NSArray* widthValues = [NSArray arrayWithObjects:@1.0, @2.0, @4.0, @6.0, @8.0, @6.0,@4.0,@2.0,@1.0,nil];
    widthAnim.values = widthValues;
    widthAnim.calculationMode = kCAAnimationPaced;
    
    
    
    // Animation 2
    CAKeyframeAnimation* colorAnim = [CAKeyframeAnimation animationWithKeyPath:@"fillColor"];
    NSArray* colorValues = [NSArray arrayWithObjects:(id)[UIColor greenColor].CGColor,
                            (id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor,  nil];
    colorAnim.values = colorValues;
    colorAnim.calculationMode = kCAAnimationPaced;

    
//    // Animation 2
//    CAKeyframeAnimation* colorAnim = [CAKeyframeAnimation animationWithKeyPath:@"backgroundColor"];
//    NSArray* colorValues = [NSArray arrayWithObjects:(id)[UIColor greenColor].CGColor,
//                            (id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor,  nil];
//    colorAnim.values = colorValues;
//    colorAnim.calculationMode = kCAAnimationPaced;

    
    
    // Animation group
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:colorAnim,widthAnim, nil];
    group.autoreverses = YES;
    group.repeatCount = HUGE_VAL;
    group.duration = 9;
    
    return group;
    
    
}


-(CAKeyframeAnimation*)colorChangeKeyFrameAnimation
{
    // Animation 2
    CAKeyframeAnimation* colorAnim = [CAKeyframeAnimation animationWithKeyPath:@"backgroundColor"];
    NSArray* colorValues = [NSArray arrayWithObjects:(id)[UIColor greenColor].CGColor,
                            (id)[UIColor redColor].CGColor, (id)[UIColor blueColor].CGColor,  nil];
    colorAnim.values = colorValues;
    colorAnim.calculationMode = kCAAnimationPaced;
    
    return colorAnim;

}


-(NSArray*)makePathsForSize:(CGFloat)size
{
    CGRect pathRect = CGRectMake(0, 0, size, size);
    
    UIBezierPath *triaglePath = PathOfPolygonPoints(3, size);
    UIBezierPath *squarePath = PathOfPolygonPoints(4, size);
    UIBezierPath *octogonPath = PathOfPolygonPoints(8, size);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:pathRect];
    
    return @[
      (id)triaglePath.CGPath,
      (id)squarePath.CGPath,
      (id)octogonPath.CGPath,
      (id)circlePath.CGPath,
      ];
 }




-(CAShapeLayer*)makeShapeLayer:(CGFloat)size
{
    CGRect faceRect = CGRectMake(0, 0, size, size);
    
    UIBezierPath *shapePath = [UIBezierPath bezierPathWithRoundedRect:faceRect cornerRadius:size/2];
    UIColor *shapeColor = [UIColor whiteColor];
    UIColor *strokeColor = [UIColor whiteColor];
    
    // Make FaceLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.name = @"shaperLayer";
    shapeLayer.path = shapePath.CGPath;
    shapeLayer.fillColor = shapeColor.CGColor;
    shapeLayer.strokeColor = strokeColor.CGColor;

    shapeLayer.borderWidth = 1.0;
    shapeLayer.borderColor = [UIColor whiteColor].CGColor;
    
//    // Make Mask Layer
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.path = shapePath.CGPath;
//    maskLayer.fillColor = [UIColor blackColor].CGColor;
//    maskLayer.strokeColor = [UIColor blackColor].CGColor;
//    
//    shapeLayer.mask = maskLayer;
    
    
    
    
    
    // [shapeLayer ensureAnchorPointIsSetToZero];
    
    [shapeLayer addAnimation:[self changeFillColorForMainLayer] forKey:@"changeFillColor"];
    
    //[shapeLayer addAnimation:[self changeBezierPathTo:[self makePathsForSize:size/2]] forKey:@"changePaths"];
    
    return shapeLayer;
}






-(CABasicAnimation*)greenOffset
{
    CABasicAnimation *greenAnimation = [CABasicAnimation animationWithKeyPath:@"instanceGreenOffset"];
    greenAnimation.fromValue = @(-1.0);
    greenAnimation.toValue = @(1.0);
    greenAnimation.duration = 6.0;
    greenAnimation.beginTime = 0.1;
    greenAnimation.autoreverses = YES;
    greenAnimation.repeatCount = HUGE_VAL;
    greenAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    return greenAnimation;
}



- (CABasicAnimation *)changeColor
{
    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"color"];
    colorAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(SUBLAYER_WIDTH+INTERSPACE, 0, 0)];
    colorAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(SUBLAYER_WIDTH+INTERSPACE+30, 0, 0)];
    colorAnimation.duration = 6.0;
    colorAnimation.autoreverses = YES;
    colorAnimation.repeatCount = HUGE_VAL;
    colorAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return colorAnimation;
}



-(void)ddd
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.4;
    
    animation.additive = YES;
    
    // [form.layer addAnimation:animation forKey:@"shake"];
}

-(POPSpringAnimation*)popRotateAnimation
{
    POPSpringAnimation *rotAnim;
    rotAnim = [POPSpringAnimation animation];
    // rotAnim.property = [POPAnimatableProperty propertyWithName:kPop];
    //rotAnim.fromValue = @(-(M_PI * 0.5));
    rotAnim.toValue = @((M_PI * 0.5));
    rotAnim.springSpeed = 14;
    rotAnim.springBounciness = 15;
    
    rotAnim.repeatForever = YES;
    
    rotAnim.autoreverses = YES;
    //rotAnim.repeatCount = HUGE_VAL;
    
    return rotAnim;
}


- (CABasicAnimation *)rotationAnimation
{
    CABasicAnimation *rotAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D t = CATransform3DIdentity;
    CATransform3D t2 = CATransform3DRotate(t, -0.1, 1, 0, 0);
    rotAnim.fromValue = [NSValue valueWithCATransform3D:t2];
    CATransform3D t3 = CATransform3DRotate(t, 0.1, 1, 0, 0);
    rotAnim.toValue = [NSValue valueWithCATransform3D:t3];
    rotAnim.duration = 2.0;
    rotAnim.autoreverses = YES;
    rotAnim.repeatCount = HUGE_VAL;
    rotAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return rotAnim;
}

- (CABasicAnimation *)waveAnimation
{
    CABasicAnimation *waveAnim = [CABasicAnimation animationWithKeyPath:@"instanceTransform"];
    waveAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, -100)];
    waveAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 100)];
    waveAnim.duration  = 2.5;
    waveAnim.autoreverses = YES;
    waveAnim.repeatCount = HUGE_VAL;
    waveAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return waveAnim;
}
























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
