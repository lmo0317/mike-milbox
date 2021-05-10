#import "FCUtil.h"

double drand(double low, double high)
{
    double d;
    
    d = (double)rand() / ((double) RAND_MAX + 1);
    return (low + d * (high - low));
} 

float VecLength(CGPoint b1,CGPoint b2)
{
    return sqrt(
    ((b2.x - b1.x) * (b2.x - b1.x)) + ((b2.y - b1.y) * (b2.y - b1.y))
    );
}

NSString* GetKey(NSString* strName)
{
    NSString *uniqueName = strName;
    NSArray *strArray = [uniqueName componentsSeparatedByString:@"_"];
    
    return [strArray objectAtIndex:0];
}

CGPoint CGPointMakeBothIPad(float iPhonePoint_X, float iPhonePoint_Y)
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return CGPointMake(iPhonePoint_X/480*1024,iPhonePoint_Y/320*768);
    else
        return CGPointMake(iPhonePoint_X,iPhonePoint_Y);
}

float GetRatio()
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return IPAD_RATIO;
    else
        return 1.f;
}