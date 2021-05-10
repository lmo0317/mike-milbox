#import "FCObject.h"

const bool FCObject::IsMyMainFixture(b2Fixture* pFixtrue)
{
    if(m_pBody == nil)
        return false;
    
    if(pFixtrue == m_pMainFixture)
        return true;
    
    return false;
}

const bool FCObject::IsMyFixture(b2Fixture *pFixture)
{
    if(m_pBody == nil)
        return false;
    
    b2Fixture* pMyFixtureList = m_pBody->GetFixtureList();
    while(pMyFixtureList)
    {
        if(pMyFixtureList == pFixture)
        {
            return true;
        }
        
        pMyFixtureList = pMyFixtureList->GetNext();
    }
    
    if(IsMyChildSpriteFixture(pFixture))
        return true;
    
    return false;
}

const bool FCObject::IsMyTopFixture(b2Fixture *pFixture)
{
    if(m_pBody == nil)
        return false;
    
    if(pFixture == m_pTopFixture)
        return true;
    
    return false;
}

const bool FCObject::IsMyBottomFixture(b2Fixture *pFixture)
{
    if(m_pBody == nil)
        return false;
    
    if(pFixture == m_pBottomFixture)
        return true;
    
    return false;
}

const bool FCObject::IsMyLeftFixture(b2Fixture *pFixture)
{
    if(m_pBody == nil)
        return false;
    
    if(pFixture == m_pLeftFixture)
        return true;
    
    return false;
}

const bool FCObject::IsMyRightFixture(b2Fixture *pFixture)
{
    if(m_pBody == nil)
        return false;
    
    if(pFixture == m_pRightFixture)
        return true;
    
    return false;
}

const bool FCObject::IsMyRightBanisterFixture(b2Fixture *pFixture)
{
    if(m_pBody == nil)
        return false;
    
    if(pFixture == m_pRightBanisterFixture)
        return true;
    
    return false;
}

const bool FCObject::IsMyLeftBanisterFixture(b2Fixture *pFixture)
{
    if(m_pBody == nil)
        return false;
    
    if(pFixture == m_pLeftBanisterFixture)
        return true;
    
    return false;
}

void FCObject::SetAllFixtureSensor(const bool bSet)
{
    b2Fixture* pFixtureList = m_pBody->GetFixtureList();
    while(pFixtureList)
    {
        pFixtureList->SetSensor(true);
        pFixtureList = pFixtureList->GetNext();
    }
}

void FCObject::BeginContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{

}

void FCObject::EndContact(b2Fixture *fixtureA,b2Fixture *fixtureB)
{    

}

void FCObject::GetSensorTouch(int &nLeftSensor,int &nTopSensor,int &nRightSensor,int &nBottomSensor)
{
    nLeftSensor = m_nContactLeftFixture;
    nTopSensor = m_nContactTopFixture;
    nRightSensor = m_nContactRightFixture;
    nBottomSensor = m_nContactBottomFixture;
}



const bool FCObject::IsMyChildSpriteFixture(b2Fixture *pFixture)
{
    if(m_pChildSprite == NULL)
        return false;
    
    b2Fixture* pMyFixtureList = m_pChildSprite.body->GetFixtureList();
    return pMyFixtureList == pFixture;
}

