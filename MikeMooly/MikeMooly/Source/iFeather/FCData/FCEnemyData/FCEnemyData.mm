#import "FCEnemyData.h"


FCEnemyData::FCEnemyData():
m_nHP(c_nHP),
m_fWalkSpeed(c_fWalkSpeed),
m_fJumpMoveSpeed(c_fJumpMoveSpeed),
m_fJumpSpeed(c_fJumpSpeed),
m_fJump2Speed(c_fJump2Speed),
m_fBounceSpeed(c_fBounceSpeed),
m_fDamageBounceSpeed(c_fDamageBounceSpeed),
m_bCanDeath(false),
m_nCulling(0)
{
    
}

FCEnemyData::~FCEnemyData()
{
    
}

void FCEnemyData::Copy(FCEnemyData* pEnemyData)
{
    if(pEnemyData == NULL)
        return;
    
    m_strName = pEnemyData->GetName();
}

NSString* FCEnemyData::GetName()
{
    return m_strName;
}

void FCEnemyData::SetName(NSString* strName)
{
    m_strName = strName;
}

NSString* FCEnemyData::GetAIName()
{
    return m_strAIName;
}

void FCEnemyData::SetAIName(NSString* strAIName)
{
    m_strAIName = strAIName;
}

void FCEnemyData::SetWalkMotionName(NSString* strWalkMotionName)
{
    m_strWalkMotionName = strWalkMotionName;
}

void FCEnemyData::SetStayMotionName(NSString* strStayMotionName)
{
    m_strStayMotionName = strStayMotionName;
}

void FCEnemyData::SetDamageMotionName(NSString* strDamageMotionName)
{
    m_strDamageMotionName = strDamageMotionName;
}

void FCEnemyData::SetJumpMotionName(NSString* strJumpMotionName)
{
    m_strJumpMotionName = strJumpMotionName;
}

void FCEnemyData::SetJump2MotionName(NSString* strJump2MotionName)
{
    m_strJump2MotionName = strJump2MotionName;
}

void FCEnemyData::SetFallMotionName(NSString* strFallMotionName)
{
    m_strFallMotionName = strFallMotionName;
}

void FCEnemyData::SetDyingMotionName(NSString* strDyingMotionName)
{
    m_strDyingMotionName = strDyingMotionName;
}

void FCEnemyData::SetAttackMotionName(NSString* strAttackMotionName)
{
    m_strAttackMotionName = strAttackMotionName;
}

NSString* FCEnemyData::GetWalkMotionName()
{
    return m_strWalkMotionName;
}

NSString* FCEnemyData::GetStayMotionName()
{
    return m_strStayMotionName;
}

NSString* FCEnemyData::GetDamageMotionName()
{
    return m_strDamageMotionName;
}

NSString* FCEnemyData::GetJumpMotionName()
{
    return m_strJumpMotionName;
}

NSString* FCEnemyData::GetJump2MotionName()
{
    return m_strJump2MotionName;
}

NSString* FCEnemyData::GetFallMotionName()
{
    return m_strFallMotionName;
}

NSString* FCEnemyData::GetDyingMotionName()
{
    return m_strDyingMotionName;
}

NSString* FCEnemyData::GetAttackMotionName()
{
    return m_strAttackMotionName;
}

void FCEnemyData::SetHP(const int nHP)
{
    m_nHP = nHP;
}

void FCEnemyData::SetWalkSpeed(const float fWalkSpeed)
{
    m_fWalkSpeed = fWalkSpeed;
}

void FCEnemyData::SetJumpMoveSpeed(const float fJumpMoveSpeed)
{
    m_fJumpMoveSpeed = fJumpMoveSpeed;
}

void FCEnemyData::SetJumpSpeed(const float fJumpSpeed)
{
    m_fJumpSpeed = fJumpSpeed;
}

void FCEnemyData::SetJump2Speed(const float fJump2Speed)
{
    m_fJump2Speed = fJump2Speed;
}

void FCEnemyData::SetBounceSpeed(const float fBounceSpeed)
{
    m_fBounceSpeed = fBounceSpeed;
}

void FCEnemyData::SetDamageBounceSpeed(const float fDamageBounceSpeed)
{
    m_fDamageBounceSpeed = fDamageBounceSpeed;
}

void FCEnemyData::SetCanDeath(const bool bDeath)
{
    m_bCanDeath = bDeath;
}

const bool FCEnemyData::GetCanDeath()
{
    return m_bCanDeath;
}

void FCEnemyData::SetCulling(const int nCulling)
{
    m_nCulling = nCulling;
}

const int FCEnemyData::GetCulling()
{
    return m_nCulling;
}

const int FCEnemyData::GetHP()
{
    return m_nHP;
}

const float FCEnemyData::GetWalkSpeed()
{
    return m_fWalkSpeed;
}

const float FCEnemyData::GetJumpMoveSpeed()
{
    return m_fJumpMoveSpeed;
}

const float FCEnemyData::GetJumpSpeed()
{
    return m_fJumpSpeed;
}

const float FCEnemyData::GetJump2Speed()
{
    return m_fJump2Speed;
}

const float FCEnemyData::GetBounceSpeed()
{
    return m_fBounceSpeed;
}

const float FCEnemyData::GetDamageBounceSpeed()
{
    return m_fDamageBounceSpeed;
}

void FCEnemyData::AddStateData(NSString* pID,const int nCategory,NSString *pValue)
{
    m_StateDataManager.AddStateData(pID,nCategory,pValue);
}

NSString* FCEnemyData::GetStateData(NSString* pID,const int nCategory)
{
    return m_StateDataManager.GetStateData(pID,nCategory);
}

