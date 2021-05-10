
#import "FCZipArchive.h"

@implementation FCZipArchive
@synthesize filePath;

-(id)initWithFilePath:(NSString*)initPath
{
	self = [super init];
	if (self != nil) {
		if (initPath != nil) {
			self.filePath = initPath;
		}
	}
	return self;
}

-(void)Init
{
    
}

-(BOOL)releaseZipFile
{
	NSFileManager* fileManager = [NSFileManager defaultManager];
	NSString* documentsDir = [filePath stringByDeletingLastPathComponent];
	NSString *mapPath = [documentsDir stringByAppendingPathComponent:@"map"];
    
    NSError *error;
    [fileManager createDirectoryAtPath:mapPath withIntermediateDirectories:NO attributes:nil error:&error]; 
	
    ZipArchive *zip = [[ZipArchive alloc] init];	
	BOOL result = NO;
	if([zip UnzipOpenFile:filePath]) 
    {
		if ([zip UnzipFileTo:mapPath overWrite:YES]) 
        {
			NSLog(@"Archive unzip Success");
			result= YES;
		} 
        else 
        {
			NSLog(@"Failure To Extract Archive, maybe password?");
		}
	} 
    else  
    {
		NSLog(@"Failure To Open Archive");
	}
    
	[zip release];
	return result;
}

-(void)compressZipFile
{
    ZipArchive *zip = [[ZipArchive alloc] init];	
	[zip CreateZipFile:self.filePath];
    
    ///[zip addFileToZip:@"farm_1.plhs" newname: @"farm_1.plhs"];
    
    [zip CloseZipFile2];
	[zip release];
}


@end