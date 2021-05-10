#import "FCPlayerData.h"


FCPlayerData::FCPlayerData():
m_fWalkSpeed(c_fWalkSpeed),
m_fJumpMoveSpeed(c_fJumpMoveSpeed),
m_fJumpSpeed(c_fJumpSpeed),
m_fJump2Speed(c_fJump2Speed),
m_fDeathTime(c_tDeathTime),
m_fBounceSpeed(c_fBounceSpeed),
m_fDamageBounceSpeed(c_fDamageBounceSpeed)
{
    
}

FCPlayerData::~FCPlayerData()
{
    
}

void FCPlayerData::Copy(FCPlayerData* pPlayerData)
{
    if(pPlayerData == NULL)
        return;
    
    m_strName = pPlayerData->GetName();
}

NSString* FCPlayerData::GetName()
{
    return m_strName;
}

void FCPlayerData::SetName(NSString* strName)
{
    m_strName = strName;
}

void FCPlayerData::SetWalkMotionName(NSString* strWalkMotionName)
{
    m_strWalkMotionName = strWalkMotionName;
}

void FCPlayerData::SetStayMotionName(NSString* strStayMotionName)
{
    m_strStayMotionName = strStayMotionName;
}

void FCPlayerData::SetDamageMotionName(NSString* strDamageMotionName)
{
    m_strDamageMotionName = strDamageMotionName;
}

void FCPlayerData::SetJumpMotionName(NSString* strJumpMotionName)
{
    m_strJumpMotionName = strJumpMotionName;
}

void FCPlayerData::SetJump2MotionName(NSString* strJump2MotionName)
{
    m_strJump2MotionName = strJump2MotionName;
}

void FCPlayerData::SetFallMotionName(NSString* strFallMotionName)
{
    m_strFallMotionName = strFallMotionName;
}

void FCPlayerData::SetDyingMotionName(NSString* strDyingMotionName)
{
    m_strDyingMotionName = strDyingMotionName;
}

void FCPlayerData::SetAttackMotionName(NSString* strAttackMotionName)
{
    m_strAttackMotionName = strAttackMotionName;
}

NSString* FCPlayerData::GetWalkMotionName()
{
    return m_strWalkMotionName;
}

NSString* FCPlayerData::GetStayMotionName()
{
    return m_strStayMotionName;
}

NSString* FCPlayerData::GetDamageMotionName()
{
    return m_strDamageMotionName;
}

NSString* FCPlayerData::GetJumpMotionName()
{
    return m_strJumpMotionName;
}

NSString* FCPlayerData::GetJump2MotionName()
{
    return m_strJump2MotionName;
}

NSString* FCPlayerData::GetFallMotionName()
{
    return m_strFallMotionName;
}

NSString* FCPlayerData::GetDyingMotionName()
{
    return m_strDyingMotionName;
}

NSString* FCPlayerData::GetAttackMotionName()
{
    return m_strAttackMotionName;
}

void FCPlayerData::SetWalkSpeed(const float fWalkSpeed)
{
    m_fWalkSpeed = fWalkSpeed;
}

void FCPlayerData::SetJumpMoveSpeed(const float fJumpMoveSpeed)
{
    m_fJumpMoveSpeed = fJumpMoveSpeed;
}

void FCPlayerData::SetJumpSpeed(const float fJumpSpeed)
{
    m_fJumpSpeed = fJumpSpeed;
}

void FCPlayerData::SetJump2Speed(const float fJump2Speed)
{
    m_fJump2Speed = fJump2Speed;
}

void FCPlayerData::SetDeathTime(const float fDeathTime)
{
    m_fDeathTime = fDeathTime;
}

void FCPlayerData::SetBounceSpeed(const float fBounceSpeed)
{
    m_fBounceSpeed = fBounceSpeed;
}

void FCPlayerData::SetDamageBounceSpeed(const float fDamageBounceSpeed)
{
    m_fDamageBounceSpeed = fDamageBounceSpeed;
}

const float FCPlayerData::GetWalkSpeed()
{
    return m_fWalkSpeed;
}

const float FCPlayerData::GetJumpMoveSpeed()
{
    return m_fJumpMoveSpeed;
}

const float FCPlayerData::GetJumpSpeed()
{
    return m_fJumpSpeed;
}

const float FCPlayerData::GetJump2Speed()
{
    return m_fJump2Speed;
}

const float FCPlayerData::GetDeathTime()
{
    return m_fDeathTime;
}

const float FCPlayerData::GetBounceSpeed()
{
    return m_fBounceSpeed;
}

const float FCPlayerData::GetDamageBounceSpeed()
{
    return m_fDamageBounceSpeed;
}

void FCPlayerData::AddStateData(NSString* pID,const int nCategory,NSString *pValue)
{
    m_StateDataManager.AddStateData(pID,nCategory,pValue);
}

NSString* FCPlayerData::GetStateData(NSString* pID,const int nCategory)
{
    return m_StateDataManager.GetStateData(pID,nCategory);
}
