#ifndef MikeMooly_FCZipArchive_h
#define MikeMooly_FCZipArchive_h

#import "ZipArchive.h"
#define kFileExtension @"zip"

@interface FCZipArchive : NSObject 
{
    NSString* filePath;
};

@property (nonatomic, retain) NSString* filePath;

-(void)Init;
-(id)initWithFilePath:(NSString*)initPath;
-(BOOL)releaseZipFile;
-(void)compressZipFile;


@end

#endif
