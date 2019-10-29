//
//  FYChartView.m
//
//  sina weibo:http://weibo.com/zbflying
//
//  Created by zbflying on 13-11-27.
//  Copyright (c) 2013年 zbflying All rights reserved.
//

#import "FYChartView.h"

@interface FYChartView ()

@property (nonatomic, retain) NSMutableArray *valueItemArray;
@property (nonatomic, retain) UIView *descriptionView;
@property (nonatomic, retain) UIView *slideLineView;

@end

@implementation FYChartView
{
    @private
    BOOL    isLoaded;                   //is already load
    float   horizontalItemWidth;        //horizontal item width
    float   verticalItemHeight;         //vertical item width
    float   maxVerticalValue;           //max vertical value
    CGSize  verticalTextSize;           //vertical text size
    int     verticalRow;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //default line width
        self.rectanglelineWidth = 0.5f;
        self.lineWidth = 0.5f;
        
        //default line color
        self.rectangleLineColor = [UIColor blackColor];
        self.lineColor = [UIColor blueColor];
        
        self.hideDescriptionViewWhenTouchesEnd = NO;
        
        verticalRow = 10;   //10行
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (isLoaded)   return;
    
    //draw data line
    [self drawValueLine:rect];
    
    //draw rectangle line and vertical text
    [self drawRectangleAndVerticalText:rect];
    
    isLoaded = YES;
}

- (void)dealloc
{

}

/**
 *  draw rectangle
 */
- (void)drawRectangleAndVerticalText:(CGRect)rect
{
    rect.origin.x = verticalTextSize.width;
    rect.origin.y = verticalTextSize.height;
    rect.size.width -= verticalTextSize.width;
    rect.size.height -= (verticalTextSize.height * 2);
    
    //draw rectangle
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextAddPath(currentContext, path);
    [[UIColor clearColor] setFill];
    [[UIColor clearColor] setStroke];
    CGContextSetStrokeColorWithColor(currentContext, self.rectangleLineColor.CGColor);
    CGContextSetLineWidth(currentContext, self.rectanglelineWidth);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    CGPathRelease(path);
    
    //draw lines and vertical text
    [self.rectangleLineColor setFill];
    CGContextSetLineWidth(currentContext, self.rectanglelineWidth);
    
    CGFloat item_num = 5.f;
    CGFloat item_width = rect.size.width/item_num;
    for (int i=0; i<item_num; i++) {
        
        if (i > 3) {
            break;
        }
        CGContextMoveToPoint(currentContext, rect.origin.x+item_width*(i+1), rect.origin.y);
        CGContextAddLineToPoint(currentContext, rect.origin.x+item_width*(i+1), rect.size.height + verticalTextSize.height);
        CGContextClosePath(currentContext);
        CGContextStrokePath(currentContext);
    }
    
    
    float itemHeight = rect.size.height / verticalRow;
    for (int i = 1; i <= verticalRow; i++)
    {
        if (i != verticalRow)
        {
            CGContextMoveToPoint(currentContext, rect.origin.x, rect.size.height - itemHeight * i + verticalTextSize.height);
            CGContextAddLineToPoint(currentContext,
                                    rect.size.width + verticalTextSize.width,
                                    rect.size.height - itemHeight * i +verticalTextSize.height);
            CGContextClosePath(currentContext);
            CGContextStrokePath(currentContext);
        }
        
        CGFloat v = i * (maxVerticalValue / verticalRow);
        v = [[SystemManager shareManager] tempConvertFahrenheit:v];
        
        NSString *text = [NSString stringWithFormat:@"%.1f", v];
        
        CGPoint point = CGPointMake(.0f, rect.size.height - itemHeight * i + verticalTextSize.height - verticalTextSize.height * 0.5f);
        NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:10.0f]};
        [text drawAtPoint:point withAttributes:attr];
    }
}

/**
 *  draw data line
 */
- (void)drawValueLine:(CGRect)rect
{
    if (!self.dataSource)   return;
    
    //item count
    NSInteger numberOfHorizontalItemCount = [self.dataSource numberOfValueItemCountInChartView:self];
    if (!numberOfHorizontalItemCount)   return;
    NSMutableArray *valueItems = [NSMutableArray array];
    for (int i = 0; i < numberOfHorizontalItemCount; i++)
    {
        float value = [self.dataSource chartView:self valueAtIndex:i];
        [valueItems addObject:[NSNumber numberWithFloat:value]];
        
        if (value >= maxVerticalValue)  maxVerticalValue = value;
    }
    
    maxVerticalValue = ceilf(maxVerticalValue) * 2;
    verticalTextSize = [[NSString stringWithFormat:@"%.2f", maxVerticalValue] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f]}];
    self.valueItemArray = valueItems;
    numberOfHorizontalItemCount = MAX(numberOfHorizontalItemCount, 300);
    horizontalItemWidth = (rect.size.width - verticalTextSize.width) / (numberOfHorizontalItemCount - 1);
    verticalItemHeight = (rect.size.height - verticalTextSize.height * 2) / maxVerticalValue;
    
    for (int i = 0; i < valueItems.count - 1; i++)
    {
        float value = [(NSNumber *)valueItems[i] floatValue];
        CGPoint point = [self valuePoint:value atIndex:i];
        
        float nextValue = [(NSNumber *)valueItems[i + 1] floatValue];
        CGPoint nextPoint = [self valuePoint:nextValue atIndex:i + 1];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(context, point.x, point.y);
        CGContextAddLineToPoint(context, nextPoint.x, nextPoint.y);
        CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextClosePath(context);
        CGContextStrokePath(context);
    }
    
    //draw horizontal title
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfHorizontalItemCountInChartView:)]) {
        NSInteger horizontalTitleNumber = [self.dataSource numberOfHorizontalItemCountInChartView:self];
        CGFloat item_width = (rect.size.width - verticalTextSize.width)/(horizontalTitleNumber-1);
        
        for (int i = 0; i < horizontalTitleNumber; i++)
        {
            NSString *title = [self.dataSource chartView:self horizontalTitleAtIndex:i];
            if (title)
            {
                CGPoint point = CGPointMake(verticalTextSize.width + item_width*i, rect.size.height);
                
                UIFont *font = [UIFont systemFontOfSize:10.0f];
                CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:font}];
                
                HorizontalTitleAlignment alignment = HorizontalTitleAlignmentCenter;
                
                if (i == (horizontalTitleNumber - 1)){
                    alignment = HorizontalTitleAlignmentRight;
                }
                
                if (alignment == HorizontalTitleAlignmentLeft)
                {
                    [title drawAtPoint:CGPointMake(point.x, rect.size.height - size.height) withAttributes:@{NSFontAttributeName:font}];
                }
                else if (alignment == HorizontalTitleAlignmentCenter)
                {
                    [title drawAtPoint:CGPointMake(point.x - size.width * 0.5f, rect.size.height - size.height) withAttributes:@{NSFontAttributeName:font}];
                }
                else if (alignment == HorizontalTitleAlignmentRight)
                {
                    [title drawAtPoint:CGPointMake(point.x - size.width, rect.size.height - size.height) withAttributes:@{NSFontAttributeName:font}];
                }
            }
        }
    }
}

#pragma mark - custom method

/**
 *  value item point at index
 */
- (CGPoint)valuePoint:(float)value atIndex:(int)index
{
    CGPoint retPoint = CGPointZero;
    
    retPoint.x = index * horizontalItemWidth + verticalTextSize.width;
    retPoint.y = self.frame.size.height - verticalTextSize.height - value * verticalItemHeight;
    
    return retPoint;
}

/**
 *  display description view
 */
- (void)descriptionViewPointWithTouches:(NSSet *)touches
{
    CGSize size = self.frame.size;
    CGPoint location = [[touches anyObject] locationInView:self];
    if (location.x >= 0 && location.x <= size.width && location.y >= 0 && location.y <= size.height)
    {
        int intValue = location.x / horizontalItemWidth;
        float remainder = location.x - intValue * horizontalItemWidth;
        
        int index = intValue + (remainder >= horizontalItemWidth * 0.5f ? 1 : 0);
        if (index < self.valueItemArray.count)
        {
            float value = [(NSNumber *)self.valueItemArray[index] floatValue];
            CGPoint point = [self valuePoint:value atIndex:index];
            
            if ([self.dataSource respondsToSelector:@selector(chartView:descriptionViewAtIndex:)])
            {
                UIView *descriptionView = [self.dataSource chartView:self descriptionViewAtIndex:index];
                CGRect frame = descriptionView.frame;
                if (point.x + frame.size.width > size.width)
                {
                    frame.origin.x = point.x - frame.size.width;
                }
                else
                {
                    frame.origin.x = point.x;
                }
                
                if (frame.size.height + point.y > size.height)
                {
                    frame.origin.y = point.y - frame.size.height;
                }
                else
                {
                    frame.origin.y = point.y;
                }
                
                descriptionView.frame = frame;
                
                if (self.descriptionView)   [self.descriptionView removeFromSuperview];
                
                if (!self.slideLineView)
                {
                    //slide line view
                    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(.0f,
                                                                                 verticalTextSize.height,
                                                                                 1.0f,
                                                                                 self.frame.size.height - verticalTextSize.height * 2)];
                    lineView.backgroundColor = [UIColor redColor];
                    lineView.hidden = YES;
                    self.slideLineView = lineView;
                    [self addSubview:self.slideLineView];
                }
                
                //draw line
                CGRect slideLineViewFrame = self.slideLineView.frame;
                slideLineViewFrame.origin.x = point.x;
                self.slideLineView.frame = slideLineViewFrame;
                self.slideLineView.hidden = NO;
                
                [self addSubview:descriptionView];
                self.descriptionView = descriptionView;
                
                //delegate
                if (self.delegate && [self.delegate respondsToSelector:@selector(chartView:didMovedToIndex:)])
                {
                    [self.delegate chartView:self didMovedToIndex:index];
                }
            }
        }
    }
}

- (void)reloadData
{
    isLoaded = NO;
    [self.valueItemArray removeAllObjects];
    horizontalItemWidth = .0f;
    verticalItemHeight = .0f;
    maxVerticalValue = .0f;
    if (self.descriptionView)   [self.descriptionView removeFromSuperview];
    if (self.slideLineView)   self.slideLineView.hidden = YES;
    [self setNeedsDisplay];
}

#pragma mark - touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.valueItemArray || !self.valueItemArray.count || !self.dataSource) return;
    
    [self descriptionViewPointWithTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self descriptionViewPointWithTouches:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.descriptionView && self.hideDescriptionViewWhenTouchesEnd)   [self.descriptionView removeFromSuperview];
}

@end
