#ifndef MikeMooly_FCUIWindowListData_h
#define MikeMooly_FCUIWindowListData_h

#include <map>
#include <vector>

struct FCUIWindowListData
{
public:
    
    FCUIWindowListData();
    ~FCUIWindowListData();
    
    void Copy(FCUIWindowListData* pUIWindow);
    
    void SetName(NSString* strName);
    NSString* GetName();
            
private:
    NSString* m_strName;    
};

#endif
