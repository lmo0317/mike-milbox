 #ifndef MikeMooly_FCWorldData_h
#define MikeMooly_FCWorldData_h

#include <map>
#include <vector>

struct FCWorldData
{
public:
    
    FCWorldData();
    ~FCWorldData();
    
    void Copy(FCWorldData* pFieldItem);
    
    void SetName(NSString* strName);
    NSString* GetName();
    
    void SetGroup(NSString* strGroup) {m_strGroup = strGroup;}
    NSString* GetGroup() {return m_strGroup;}
    
    void SetType(NSString* strType) {m_strType = strType;}
    NSString* GetType() {return m_strType;}
    
    void SetBGM(NSString* strBGM) {m_strBGM = strBGM;}
    NSString* GetBGM() {return m_strBGM;}
    
    void SetTime(const int nTime) {m_nTime = nTime;}
    const int GetTime(){return m_nTime;}
    
    void SetUIStageName(NSString* strUIStageName) {m_strUIStageName = strUIStageName;}
    NSString* GetUIStageName() {return m_strUIStageName;}
    
    void SetUIStageSprite(NSString* strUIStageSprite) {m_strUIStageSprite = strUIStageSprite;}
    NSString* GetUIStageSprite() {return m_strUIStageSprite;}
    
    void SetGroupEnd(const bool bGroupEnd) {m_bGroupEnd = bGroupEnd;}
    const bool GetGroupEnd() {return m_bGroupEnd;}
    
    void SetGroupFirst(const bool bGroupFirst) {m_bGroupFirst = bGroupFirst;}
    const bool GetGroupFirst() {return m_bGroupFirst;}
    
    void SetMissionTime(const int nMissionTime) {m_nMissionTime = nMissionTime;}
    const int GetMissionTime() {return m_nMissionTime;}

    void SetMissionDamage(const int nMissionDamage) {m_nMissionDamage = nMissionDamage;}
    const int GetMissionDamage() {return m_nMissionDamage;}
    
    void AddSoundPreload(NSString* strSoundPreload);
    std::vector<NSString*>* GetSoundPreload() {return &m_vecSoundPreload;}
            
private:
    NSString* m_strName;
    NSString* m_strGroup;
    NSString* m_strType;
    NSString* m_strBGM;
    
    NSString* m_strUIStageName;
    NSString* m_strUIStageSprite;
    
    int m_nTime;
    bool m_bGroupEnd;
    bool m_bGroupFirst;
    
    int m_nMissionTime;
    int m_nMissionDamage;
    
    std::vector<NSString*> m_vecSoundPreload;
};

#endif
