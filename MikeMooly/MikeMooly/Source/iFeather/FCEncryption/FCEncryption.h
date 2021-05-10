#ifndef MikeMooly_FCEncryption_h
#define MikeMooly_FCEncryption_h

@interface FCEncryption : NSObject 
{
    
};

-(void)Init;
- (NSData *)decryptDES:(NSData *)decodedData;
- (NSData *)encryptDES:(NSData *)data;

@end

#endif
