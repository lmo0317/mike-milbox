#import "FCEncryption.h"
#import <CommonCrypto/CommonCryptor.h>
#import "NSDataAdditions.h"

@implementation FCEncryption

-(void)Init
{
    
}

- (NSData *)encryptDES:(NSData *)data
{
	unsigned char *input = (unsigned char*)[data bytes];
	NSUInteger inLength = [data length];
	NSInteger outLength = ((inLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1));
	unsigned char *output =(unsigned char *)calloc(outLength, sizeof(unsigned char));
	bzero(output, outLength*sizeof(unsigned char));
	size_t additionalNeeded = 0;
	
	unsigned char *iv = (unsigned char *)calloc(kCCBlockSizeDES, sizeof(unsigned char));
	bzero(iv, kCCBlockSizeDES * sizeof(unsigned char));
	
	NSString *key = @"mike_mooly_abcd_efg";
	const void *vkey = (const void *) [key UTF8String];
	
    
	CCCryptorStatus err = CCCrypt(kCCEncrypt,
                                  kCCAlgorithmDES,
                                  kCCOptionPKCS7Padding | kCCOptionECBMode,
                                  vkey,
                                  kCCKeySizeDES,
                                  iv,
                                  input,
                                  inLength,
                                  output,
                                  outLength,
                                  &additionalNeeded); 
    NSLog(@"encrypt err: %d", err);
	
    if(0);
	else if (err == kCCParamError) NSLog(@"PARAM ERROR");
	else if (err == kCCBufferTooSmall) NSLog(@"BUFFER TOO SMALL");
	else if (err == kCCMemoryFailure) NSLog(@"MEMORY FAILURE");
	else if (err == kCCAlignmentError) NSLog(@"ALIGNMENT");
	else if (err == kCCDecodeError) NSLog(@"DECODE ERROR");
	else if (err == kCCUnimplemented) NSLog(@"UNIMPLEMENTED");
	
	NSData *myData = [NSData dataWithBytesNoCopy:output length:(NSUInteger)additionalNeeded freeWhenDone:YES];
	return myData;
}

- (NSData *)decryptDES:(NSData *)decodedData
{
	unsigned char *input = (unsigned char*)[decodedData bytes];
	NSUInteger inLength = [decodedData length];
	NSInteger outLength = ((inLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1));
	unsigned char *output =(unsigned char *)calloc(outLength, sizeof(unsigned char));
	bzero(output, outLength*sizeof(unsigned char));
	size_t additionalNeeded = 0;
	
	
	unsigned char *iv = (unsigned char *)calloc(kCCBlockSizeDES, sizeof(unsigned char));
	bzero(iv, kCCBlockSizeDES * sizeof(unsigned char));
	
	NSString *key = @"mike_mooly_abcd_efg";
	const void *vkey = (const void *) [key UTF8String];
	
    
	CCCryptorStatus err = CCCrypt(kCCDecrypt,
                                  kCCAlgorithmDES,
                                  kCCOptionPKCS7Padding | kCCOptionECBMode,
                                  vkey,
                                  kCCKeySizeDES,
                                  iv,
                                  input,
                                  inLength,
                                  output,
                                  outLength,
                                  &additionalNeeded); 
    NSLog(@"encrypt err: %d", err);
    
	if(0);
	else if (err == kCCParamError) NSLog(@"PARAM ERROR");
	else if (err == kCCBufferTooSmall) NSLog(@"BUFFER TOO SMALL");
	else if (err == kCCMemoryFailure) NSLog(@"MEMORY FAILURE");
	else if (err == kCCAlignmentError) NSLog(@"ALIGNMENT");
	else if (err == kCCDecodeError) NSLog(@"DECODE ERROR");
	else if (err == kCCUnimplemented) NSLog(@"UNIMPLEMENTED");

	NSData *myData = [NSData dataWithBytesNoCopy:output length:(NSUInteger)additionalNeeded freeWhenDone:YES];
	
	return myData;
}

@end