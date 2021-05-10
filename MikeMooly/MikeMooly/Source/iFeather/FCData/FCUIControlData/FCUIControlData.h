#ifndef MikeMooly_FCUIControlData_h
#define MikeMooly_FCUIControlData_h

#include <vector>
#include <map>

class FCUIControlData
{
public:
    
    FCUIControlData();
    ~FCUIControlData();

    void SetID(NSString* pID) {m_pID = pID;}
    NSString* GetID() {return m_pID;}
    
    void SetType(NSString* pType) {m_pType = pType;}
    NSString* GetType() {return m_pType;}

    void SetImg1(NSString* pImg1) {m_pImg1 = pImg1;}
    NSString* GetImg1() {return m_pImg1;}
    
    void SetImg2(NSString* pImg2) {m_pImg2 = pImg2;}
    NSString* GetImg2() {return m_pImg2;}
    
    void SetImg3(NSString* pImg3) {m_pImg3 = pImg3;}
    NSString* GetImg3() {return m_pImg3;}
    
    void SetX(const int nX) {m_nX = nX;}
    const int GetX() {return m_nX;}
    
    void SetY(const int nY) {m_nY = nY;}
    const int GetY() {return m_nY;}
    
    void SetZ(const int nZ) {m_nZ = nZ;}
    const int GetZ() {return m_nZ;}
    
    void SetU(const int nU) {m_nU = nU;}
    const int GetU() {return m_nU;}
    
    void SetV(const int nV) {m_nV = nV;}
    const int GetV() {return m_nV;}
    
    void SetWidth(const int nWidth) {m_nWidth = nWidth;}
    const int GetWidth() {return m_nWidth;}
    
    void SetHeight(const int nHeight) {m_nHeight = nHeight;}
    const int GetHeight() {return m_nHeight;}
    
    void SetFntFile(NSString* pFntFile) {m_pFntFile = pFntFile;}
    NSString* GetFntFile() {return m_pFntFile;}
    
    void SetDefault(NSString* pDefault) {m_pDefault = pDefault;}
    NSString* GetDefault() {return m_pDefault;}
    
    void SetAnchorX(const float fAnchorX) {m_fAnchorX = fAnchorX;}
    const float GetAnchorX() {return m_fAnchorX;}
    
    void SetAnchorY(const float fAnchorY) {m_fAnchorY = fAnchorY;}
    const float GetAnchorY() {return m_fAnchorY;}
    
    void SetR(const int nR) {m_nR = nR;}
    const int GetR() {return m_nR;}
    
    void SetG(const int nG) {m_nG = nG;}
    const int GetG() {return m_nG;}
    
    void SetB(const int nB) {m_nB = nB;}
    const int GetB() {return m_nB;}
    
    void SetShowEvent(NSString* strShowEvent) {m_strShowEvent = strShowEvent;}
    NSString* GetShowEvent() {return m_strShowEvent;}
    
    void SetClickEvent(NSString* strClickEvent) {m_strClickEvent = strClickEvent;}
    NSString* GetClickEvent() {return m_strClickEvent;}
    
private:
    
    NSString* m_pID;
    NSString* m_pType;
    NSString* m_pImg1;
    NSString* m_pImg2;
    NSString* m_pImg3;
    NSString* m_pFntFile;
    NSString* m_pDefault;
    NSString* m_strShowEvent;
    NSString* m_strClickEvent;
    
    int m_nX;
    int m_nY;
    int m_nZ;
    int m_nU;
    int m_nV;
    int m_nWidth;
    int m_nHeight;
    int m_nFontSize;
    float m_fAnchorX;
    float m_fAnchorY;
    
    int m_nR;
    int m_nG;
    int m_nB;
};

#endif
