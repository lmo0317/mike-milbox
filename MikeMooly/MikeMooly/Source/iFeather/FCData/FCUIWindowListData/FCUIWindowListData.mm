#import "FCUIWindowListData.h"


FCUIWindowListData::FCUIWindowListData()
{
    
}

FCUIWindowListData::~FCUIWindowListData()
{
    
}

void FCUIWindowListData::Copy(FCUIWindowListData* pUIWindowListData)
{
    if(pUIWindowListData == NULL)
        return;
    
    m_strName = pUIWindowListData->GetName();
}

NSString* FCUIWindowListData::GetName()
{
    return m_strName;
}

void FCUIWindowListData::SetName(NSString* strName)
{
    m_strName = strName;
}