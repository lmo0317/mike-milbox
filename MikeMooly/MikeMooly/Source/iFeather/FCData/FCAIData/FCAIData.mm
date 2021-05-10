#import "FCAIData.h"


FCAIData::FCAIData():
m_bBanister(false),
m_fBanisterCheckHeight(0.f)
{
    
}

FCAIData::~FCAIData()
{
    
}

void FCAIData::Copy(FCAIData* pAIData)
{
    if(pAIData == NULL)
        return;
    
    m_strName = pAIData->GetName();
}

NSString* FCAIData::GetName()
{
    return m_strName;
}

void FCAIData::SetName(NSString* strName)
{
    m_strName = strName;
}

void FCAIData::AddStateData(NSString* pID,const float fProbability , const float fTime,const bool bPrefix)
{
    std::map<NSInteger,FCAIStateData*>::iterator it = m_hashStateData.find(pID.hash);
    if(it == m_hashStateData.end())
    {
        FCAIStateData* pAIStateData = new FCAIStateData;
        pAIStateData->pID = pID;
        pAIStateData->fProbability = fProbability;
        pAIStateData->fTime = fTime;
        pAIStateData->bPrefix = bPrefix;
        
        m_hashStateData.insert(std::make_pair(pID.hash,pAIStateData));
        return;
    }
    
    FCAIStateData *pAIStateData = (*it).second;
    pAIStateData->pID = pID;
    pAIStateData->fProbability = fProbability;
    pAIStateData->bPrefix = bPrefix;
    pAIStateData->fTime = fTime;
}

FCAIStateData* FCAIData::GetStateData(NSString* pID)
{
    std::map<NSInteger,FCAIStateData*>::iterator it = m_hashStateData.find(pID.hash);
    if(it == m_hashStateData.end())
    {
        return NULL;
    }
    
    return (*it).second;
}

void FCAIData::SetBanister(const bool bBanister)
{
    m_bBanister = bBanister;
}

const bool FCAIData::GetBanister()
{
    return m_bBanister;
}

void FCAIData::SetBanisterCheckHeight(const float fHeight)
{
    m_fBanisterCheckHeight = fHeight;
}

const float FCAIData::GetBanisterCheckHeight()
{
    return m_fBanisterCheckHeight;
}