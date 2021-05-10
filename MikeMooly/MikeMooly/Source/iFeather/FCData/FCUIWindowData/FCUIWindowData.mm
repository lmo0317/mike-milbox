#import "FCUIWindowData.h"


FCUIWindowData::FCUIWindowData()
{
    
}

FCUIWindowData::~FCUIWindowData()
{
    
}

void FCUIWindowData::Copy(FCUIWindowData* pUIWindowData)
{
    if(pUIWindowData == NULL)
        return;
    
    m_strName = pUIWindowData->GetName();
}

NSString* FCUIWindowData::GetName()
{
    return m_strName;
}

void FCUIWindowData::SetName(NSString* strName)
{
    m_strName = strName;
}

FCUIControlData* FCUIWindowData::AddUIControlData(NSString* pID)
{
    return m_UIControlDataManager.AddUIControlData(pID);
}

FCUIControlData* FCUIWindowData::GetUIControlData(NSString* pID)
{
    return m_UIControlDataManager.GetUIControlData(pID);
}

std::map<NSInteger,FCUIControlData*>* FCUIWindowData::GetUIControlDataHash()
{
    return m_UIControlDataManager.GetUIControlDataHash();
}