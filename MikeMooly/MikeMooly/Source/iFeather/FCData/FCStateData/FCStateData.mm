#import "FCStateData.h"

void FCStateData::AddValue(const int nCategory,NSString* pValue)
{
    std::map<int,NSString*>::iterator it = m_hashValue.find(nCategory);
    if(it == m_hashValue.end())
    {
        m_hashValue.insert(std::make_pair(nCategory,pValue));
        return;
    }
    
    (*it).second = pValue;
}

void FCStateData::SetValue(const int nCategory,NSString* pValue)
{
    std::map<int,NSString*>::iterator it = m_hashValue.find(nCategory);
    if(it != m_hashValue.end())
    {
        (*it).second = pValue;
    }
}

NSString* FCStateData::GetValue(const int nCategory)
{
    std::map<int,NSString*>::iterator it = m_hashValue.find(nCategory);
    if(it != m_hashValue.end())
    {
        return (*it).second;
    }
    
    return NULL;
}