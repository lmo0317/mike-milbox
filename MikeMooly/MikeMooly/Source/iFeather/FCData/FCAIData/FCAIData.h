#ifndef MikeMooly_FCAIData_h
#define MikeMooly_FCAIData_h

#include <map>
#include <vector>
#import "FCAIStateData.h"

struct FCAIData 
{
public:
    
    FCAIData();
    ~FCAIData();
    
    void Copy(FCAIData* pAIData);
    void SetName(NSString* strName);
    NSString* GetName();
    
    void AddStateData(NSString* pID,const float fProbability , const float fTime,const bool bPrefix);
    FCAIStateData* GetStateData(NSString* pID);
    
    void SetBanister(const bool bBanister);
    const bool GetBanister();
    
    void SetBanisterCheckHeight(const float fHeight);
    const float GetBanisterCheckHeight();

private:
    NSString* m_strName;
    std::map<NSInteger,FCAIStateData*> m_hashStateData;
    
    bool m_bBanister;
    float m_fBanisterCheckHeight;
};

#endif
