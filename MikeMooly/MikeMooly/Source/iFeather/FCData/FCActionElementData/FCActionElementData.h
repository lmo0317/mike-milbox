#ifndef MikeMooly_FCActionElementData_h
#define MikeMooly_FCActionElementData_h

#include <vector>
#include <map>

class FCActionElementData
{
public:
    
    FCActionElementData();
    ~FCActionElementData();
    
    void SetType(NSString* pType) {m_pType = pType;}
    NSString* GetType() {return m_pType;}
    
    void SetFileName(NSString* pFileName) {m_pFileName = pFileName;}
    NSString* GetFileName() {return m_pFileName;}
    
    void SetCount(const int nCount) {m_nCount = nCount;}
    const int GetCount() {return m_nCount;}
    
    void SetX(const int nX) {m_nX = nX;}
    const int GetX() {return m_nX;}
    
    void SetY(const int nY) {m_nY = nY;}
    const int GetY() {return m_nY;}
    
    void SetDuration(const float fDuration) {m_fDuration = fDuration;}
    const float GetDuration() {return m_fDuration;}
    
    void SetAngle(const float fAngle) {m_fAngle = fAngle;}
    const float GetAngle() {return m_fAngle;}
    
    void SetSkewX(const float fSkewX) {m_fSkewX = fSkewX;}
    const float GetSkewX() {return m_fSkewX;}
    
    void SetSkewY(const float fSkewY) {m_fSkewY = fSkewY;}
    const float GetSkewY() {return m_fSkewY;}
    
    void SetScaleX(const float fScaleX) {m_fScaleX = fScaleX;}
    const float GetScaleX() {return m_fScaleX;}
    
    void SetScaleY(const float fScaleY) {m_fScaleY = fScaleY;}
    const float GetScaleY() {return m_fScaleY;}
    
    void SetHeight(const float fHeight) {m_fHeight = fHeight;}
    const float GetHeight() {return m_fHeight;}
    
    void SetJumps(const int nJumps) {m_nJumps = nJumps;}
    const int GetJumps() {return m_nJumps;}
    
    void SetR(const int nR) {m_nR = nR;}
    const int GetR() {return m_nR;}
    
    void SetG(const int nG) {m_nG = nG;}
    const int GetG() {return m_nG;}
    
    void SetB(const int nB) {m_nB = nB;}
    const int GetB() {return m_nB;}
    
    void SetBlinks(const int nBlinks) {m_nBlinks = nBlinks;}
    const int GetBlinks() {return m_nBlinks;}
    
private:
    
    NSString* m_pType;
    NSString* m_pFileName;
    
    int m_nCount;
    int m_nX;
    int m_nY;
    float m_fDuration;
    float m_fAngle;
    
    float m_fSkewX;
    float m_fSkewY;
    float m_fScaleX;
    float m_fScaleY;
    float m_fHeight;
    int m_nJumps;
    
    int m_nR;
    int m_nG;
    int m_nB;
    int m_nBlinks;
};

#endif
