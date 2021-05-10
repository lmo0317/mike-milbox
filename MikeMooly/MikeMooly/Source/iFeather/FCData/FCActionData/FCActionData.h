#ifndef MikeMooly_FCActionData_h
#define MikeMooly_FCActionData_h

#include <map>
#include <vector>
#import "FCActionElementSequenceDataManager.h"

struct FCActionData
{
public:
    
    FCActionData();
    ~FCActionData();
    
    void Copy(FCActionData* pAction);
    
    void SetName(NSString* strName);
    NSString* GetName();
    
    void SetRepeat(const int nRepeat) {m_nRepeat = nRepeat;}
    const int GetRepeat() {return m_nRepeat;}
        
    FCActionElementSequenceData* AddActionElementSequenceData();
    std::vector<FCActionElementSequenceData*>* GetActionElementSequenceDataVector() {return m_ActionElementSequenceDataManager.GetActionElementSequenceDataVector();}

private:
    NSString* m_strName;   
    int m_nRepeat;
    FCActionElementSequenceDataManager m_ActionElementSequenceDataManager;
};

#endif
