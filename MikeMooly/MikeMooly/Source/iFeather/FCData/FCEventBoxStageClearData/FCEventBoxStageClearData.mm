#import "FCEventBoxStageClearData.h"


FCEventBoxStageClearData::FCEventBoxStageClearData():
m_strNextStage(NULL)
{
    
}

FCEventBoxStageClearData::~FCEventBoxStageClearData()
{
    
}

void FCEventBoxStageClearData::Copy(FCEventBoxStageClearData* pEventBoxStageClearData)
{
    if(pEventBoxStageClearData == NULL)
        return;
    
    m_strName = pEventBoxStageClearData->GetName();
}

NSString* FCEventBoxStageClearData::GetName()
{
    return m_strName;
}

void FCEventBoxStageClearData::SetName(NSString* strName)
{
    m_strName = strName;
}

void FCEventBoxStageClearData::AddStateData(NSString* pID,const int nCategory,NSString *pValue)
{
    m_StateDataManager.AddStateData(pID,nCategory,pValue);
}

NSString* FCEventBoxStageClearData::GetStateData(NSString* pID,const int nCategory)
{
    return m_StateDataManager.GetStateData(pID,nCategory);
}