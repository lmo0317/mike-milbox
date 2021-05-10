#import "FCObject.h"
#import "AppDelegate.h"
#import "ActionLayer.h"
#import "LHSettings.h"

FCObject::FCObject():
m_pLevelHelper(NULL),
m_pSprite(NULL),
m_pBody(NULL),
m_pBottomFixture(NULL),
m_pTopFixture(NULL),
m_pRightFixture(NULL),
m_pLeftFixture(NULL),
m_vecDirection(CGPointZero),    
m_dCurTime(0),
m_nContactTopFixture(0),
m_nContactLeftFixture(0),
m_nContactRightFixture(0),
m_nContactBottomFixture(0),
m_nContactTopFixtureToPlayer(0),
m_nContactLeftFixtureToPlayer(0),
m_nContactRightFixtureToPlayer(0),
m_nContactBottomFixtureToPlayer(0),
m_nContactTopFixtureToAI(0),
m_nContactLeftFixtureToAI(0),
m_nContactRightFixtureToAI(0),
m_nContactBottomFixtureToAI(0),
m_nContactLeftBanisterFixture(0),
m_nContactRightBanisterFixture(0),
m_bDelete(false),
m_bCreateSensor(false),
m_pChildSprite(NULL),
m_bOneShot(false)
//m_pMotionData(NULL)
{
    m_strCurMotionName = @"";
    m_strPreveMotionName = @"";
    m_strCurSoundName = @"";
    m_strPreveSoundName = @"";
}

FCObject::~FCObject()
{
    
}

void FCObject::Init()
{
}

void FCObject::SetLevelHelper(MyLevelHelperLoader * pLevelHelper)
{
    m_pLevelHelper = pLevelHelper;
}

LHSprite* FCObject::GetSprite() 
{
    return m_pSprite;
}

b2Body* FCObject::GetBody() 
{
    return m_pBody;
}

void FCObject::SetDirection(CGPoint vecDirection) 
{
    m_vecDirection = vecDirection;
}

CGPoint FCObject::GetDirection()
{
    return m_vecDirection;
}

CGPoint FCObject::GetPos() 
{
    return m_pSprite.position;
}

b2Fixture* FCObject::GetBottomFixture() 
{
    return m_pBottomFixture;
}
b2Fixture* FCObject::GetTopFixture() 
{
    return m_pTopFixture;
}
b2Fixture* FCObject::GetLeftFixture() 
{
    return m_pLeftFixture;
}
b2Fixture* FCObject::GetRightFixture() 
{
    return m_pRightFixture;
}
void FCObject::SetContactTopFixture(const int nContact) 
{
    m_nContactTopFixture = nContact;
}
void FCObject::SetContactLeftFixture(const int nContact) 
{
    m_nContactLeftFixture = nContact;
}
void FCObject::SetContactRightFixture(const int nContact) 
{
    m_nContactRightFixture = nContact;
}
void FCObject::SetContactBottomFixture(const int nContact) 
{
    m_nContactBottomFixture = nContact;
}

NSString * FCObject::GetCurMotionName()
{
    return m_strCurMotionName;
}

const int FCObject::GetContactTopFixture() 
{
    return m_nContactTopFixture;
}
const int FCObject::GetContactLeftFixture() 
{
    return m_nContactLeftFixture;
}
const int FCObject::GetContactRightFixture() 
{
    return m_nContactRightFixture;
}
const int FCObject::GetContactBottomFixture() 
{
    return m_nContactBottomFixture;
}

b2Fixture *FCObject::GetMainFixture() 
{
    return m_pMainFixture;
}

void FCObject::CreateSensor()
{
     b2AABB collisionAABB = m_pMainFixture->GetAABB(0);
     b2Vec2 vecPos = m_pBody->GetPosition();
     b2BodyDef groundBodyDef;
     groundBodyDef.position.Set(0,0);
     
     b2PolygonShape groundBox;
     b2FixtureDef groundBoxDef;
     groundBoxDef.shape = &groundBox;
    
     const float fFlat = 0.15;
     const float fSizeFlat = 0.4;
    
     b2Vec2 size(collisionAABB.upperBound.x - collisionAABB.lowerBound.x,collisionAABB.upperBound.y - collisionAABB.lowerBound.y);
     
    //TOP
    //-------------------------------------------------------------------------
    float x = size.x * fSizeFlat;
    float y = fFlat;
    b2Vec2 center = b2Vec2(0,size.y/2 + fFlat/2);
    float angle = 0;

    groundBox.SetAsBox(x,y,center,angle);
    m_pTopFixture = m_pBody->CreateFixture(&groundBoxDef);
    m_pTopFixture->SetSensor(true);

    //BOTTOM
    //-------------------------------------------------------------------------

    x = size.x * fSizeFlat;
    y = fFlat;
    center = b2Vec2(0,-(size.y/2 + fFlat/2));
    angle = 0;

    groundBox.SetAsBox(x,y,center,angle);
    m_pBottomFixture = m_pBody->CreateFixture(&groundBoxDef);
    m_pBottomFixture->SetSensor(true);
    
    //LEFT
    //------------------------------------------------------------------------- 

    x = size.x * fSizeFlat;
    y = fFlat;
    center = b2Vec2(-(size.x/2 + fFlat/2),0);
    angle = M_PI_2;

    groundBox.SetAsBox(x,y,center,angle);
    m_pLeftFixture = m_pBody->CreateFixture(&groundBoxDef);
    m_pLeftFixture->SetSensor(true);
    
    //RIGHT
    //------------------------------------------------------------------------- 

    x = size.x * fSizeFlat;
    y = fFlat;
    center = b2Vec2((size.x/2 + fFlat/2),0);
    angle = M_PI_2;

    groundBox.SetAsBox(x,y,center,angle);
    m_pRightFixture = m_pBody->CreateFixture(&groundBoxDef);
    m_pRightFixture->SetSensor(true);
    
    //LEFT BANISTER
    //-------------------------------------------------------------------------

    x = fFlat;
    y = fFlat;
    center = b2Vec2(-(size.x + fFlat),-(size.y/2 + fFlat/2));
    angle = 0;

    groundBox.SetAsBox(x,y,center,angle);
    m_pLeftBanisterFixture = m_pBody->CreateFixture(&groundBoxDef);
    m_pLeftBanisterFixture->SetSensor(true);
    
    //RIGHT BANISTER
    //-------------------------------------------------------------------------

    x = fFlat;
    y = fFlat;
    center = b2Vec2((size.x + fFlat),-(size.y/2 + fFlat/2));
    angle = 0;

    groundBox.SetAsBox(x,y,center,angle);
    m_pRightBanisterFixture = m_pBody->CreateFixture(&groundBoxDef);
    m_pRightBanisterFixture->SetSensor(true);
    //-------------------------------------------------------------------------
}

void FCObject::Delete()
{
    LHPathNode* pPathNode = [m_pSprite pathNode];
    if(pPathNode)
    {
        [pPathNode removeFromParentAndCleanup:YES];
    }
    
    if(m_pSprite)
    {
        [m_pSprite removeBodyFromWorld];
        [m_pLevelHelper removeSprite:m_pSprite];
    }
}

void FCObject::Create(NSString* NAME)
{
    m_pSprite = [m_pLevelHelper spriteWithUniqueName:NAME];
    assert(m_pSprite != nil);
    
    m_pBody = m_pSprite.body;
    assert(m_pBody != nil);
    
    Create();
}

void FCObject::Create(LHSprite* pSprite)
{
    m_pSprite = pSprite;
    assert(m_pSprite != nil);
    
    m_pBody = m_pSprite.body;
    assert(m_pBody != nil);
    
    Create();
}

void FCObject::Create()
{
    if(m_pBody)
    {
        m_pMainFixture = m_pBody->GetFixtureList();
        m_pBody->SetSleepingAllowed(false);
    }
    
    if(m_bCreateSensor)
    {
        CreateSensor();
    }
}

void FCObject::SetCurMotion(NSString* strMotionName)
{
    m_strPreveMotionName = m_strCurMotionName;
    m_strCurMotionName = strMotionName;
    
    [m_pSprite stopAnimation];
    [m_pLevelHelper mystartAnimationWithUniqueName:m_strCurMotionName onSprite:m_pSprite animationInfo:m_sCurAnimationInfo];
    ResetCurAnimationEventInfo();
}

void FCObject::PlayEffectSound(NSString* strSoundName)
{
    m_strPreveSoundName = m_strCurSoundName;
    m_strCurSoundName = strSoundName;
    
    [[SimpleAudioEngine sharedEngine] playEffect:strSoundName];
}

void FCObject::PlayEffectParticle(NSString* strParticleName)
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);

    CCParticleSystem *pParticle;
    pParticle = [CCParticleSystemQuad particleWithFile:strParticleName];
    float fPTMR = [[LHSettings sharedInstance] lhPtmRatio];
    pParticle.position = ccp(m_pBody->GetPosition().x * fPTMR,m_pBody->GetPosition().y * fPTMR);
    pParticle.positionType = kCCPositionTypeRelative;
    [pActionLayer addChild:pParticle z:10 tag:1];
    
}

void FCObject::AddShoot(NSString* pModelName)
{
    if(pModelName)
    {
        LHSprite *pSprite = [[m_pLevelHelper createPhysicalSpriteWithUniqueName:pModelName] retain];
        if(pSprite)
        {
            float fX = m_pBody->GetPosition().x;
            float fY = m_pBody->GetPosition().y;
            float fAngle = m_pBody->GetAngle();
            
            b2Vec2 point;
            point.x = fX;
            point.y = fY;
            pSprite.body->SetTransform(point,fAngle);
            
            b2Rot qA;
            qA.Set(fAngle);
            b2Vec2 vecVelocity = pSprite.body->GetLinearVelocity();
            vecVelocity = b2Mul(qA,vecVelocity);
            
            pSprite.body->SetLinearVelocity(vecVelocity);
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
            [pActionLayer CreateSpriteReserve:pSprite];
        }
    }
}

void FCObject::AddHitData(NSString* pModelName)
{
    if(pModelName)
    {
        LHSprite *pSprite = [[m_pLevelHelper createPhysicalSpriteWithUniqueName:pModelName] retain];
        if(pSprite)
        {
            float fX = m_pBody->GetPosition().x;
            float fY = m_pBody->GetPosition().y;
            float fAngle = m_pBody->GetAngle();
            b2Vec2 point;
            point.x = fX;
            point.y = fY;
            pSprite.body->SetTransform(point,fAngle);
            
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
            [pActionLayer CreateSpriteReserve:pSprite];
        }
    }
}

void FCObject::ResetCurAnimationEventInfo()
{
    m_dCurAnimationTime = 0;    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    FCDataManager* pDataManager = [appDelegate GetDataManager];
    FCMotionDataManager* pMotionDataManager = [pDataManager GetMotionDataManager];
    
    FCMotionData* pMotionData = pMotionDataManager->GetMotionData(m_strCurMotionName);
    if(pMotionData)
    {
        m_pMotionData = *pMotionData;
    }
}

const bool FCObject::IsEndFrame()
{
    if(m_pSprite == NULL)
        return false;
    
    if(m_sCurAnimationInfo.bLoop)
        return false;
    
    const int nFrame = GetFrame();
    if( nFrame >= m_sCurAnimationInfo.nFrame)
        return true;
    
    return false;
}

const int FCObject::GetFrame()
{
    const int nFrame = m_dCurAnimationTime / m_sCurAnimationInfo.fSpeed;
    if(nFrame > m_sCurAnimationInfo.nFrame)
    {
        return m_sCurAnimationInfo.nFrame;
    }
    
    return nFrame;
}

void FCObject::SetName(NSString* strName)
{
    m_strName = [[NSString stringWithFormat:@"%@",strName] retain];
}

NSString* FCObject::GetName()
{
    return m_strName;
}

void FCObject::FirstEvent()
{
    
}
