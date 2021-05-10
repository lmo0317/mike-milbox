#ifndef MikeMooly_FCSaveWorldData_h
#define MikeMooly_FCSaveWorldData_h

class FCSaveWorldData
{
public:
    FCSaveWorldData();
    ~FCSaveWorldData();
    
    void SetID(NSString* pID) {m_pID = pID;}
    NSString* GetID() {return m_pID;}
    
    void SetOpen(const bool bOpen) {m_bOpen = bOpen;}
    const bool GetOpen() {return m_bOpen;}
    
    void SetLock(const bool bLock) {m_bLock = bLock;}
    const bool GetLock() {return m_bLock;}
    
    void SetMissionTime(const bool bMissionTime) {m_bMissionTime = bMissionTime;}
    const bool GetMissionTime() {return m_bMissionTime;}
        
    void SetMissionDamage(const bool bMissionDamage) {m_bMissionDamage = bMissionDamage;}
    const bool GetMissionDamage() {return m_bMissionDamage;}
    
    void SetMissionItem(bool bSet) {m_bMissionItem = bSet;}
    const bool GetMissionItem() {return m_bMissionItem;}
    
private:
  
    NSString* m_pID;
    bool m_bOpen;
    bool m_bLock;
    
    bool m_bMissionTime;
    bool m_bMissionDamage;
    bool m_bMissionItem;
};


#endif
