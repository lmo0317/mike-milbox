#ifndef MikeMooly_FCMotionData_h
#define MikeMooly_FCMotionData_h

#include <vector>
#include <map>
struct FCMotionDataEffect
{
    int nFrame;
    NSString* pValue;
};

struct FCMotionDataSound
{
    int nFrame;
    NSString* pValue;
};

struct FCMotionDataShoot
{
    int nFrame;
    NSString* pModelName;
};

struct FCMotionDataHit
{
    int nFrame;
    NSString* pModelName;
};

class FCMotionData
{
public:
    void SetName(NSString* strName);
    NSString* GetName();    
    void Copy(FCMotionData* pMotionData);
    
    void AddEffectData(const int nFrame,NSString* pValue);
    void AddSoundData(const int nFrame,NSString* pValue);
    void AddShootData(const int nFrame,NSString* pModelName);
    void AddHitData(const int nFrame,NSString* pModelName);
    
    std::vector<FCMotionDataEffect*>*   GetMotionDataEffect();
    std::vector<FCMotionDataSound*>*    GetMotionDataSound();
    std::vector<FCMotionDataShoot*>*    GetMotionDataShoot();
    std::vector<FCMotionDataHit*>*      GetMotionDataHit();
    
private:
    
    NSString* m_strName;
    
    std::vector<FCMotionDataEffect*> m_vecMotionDataEffect;
    std::vector<FCMotionDataSound*> m_vecMotionDataSound;
    std::vector<FCMotionDataShoot*> m_vecMotionDataShoot;
    std::vector<FCMotionDataHit*> m_vecMotionDataHit;
};

#endif
