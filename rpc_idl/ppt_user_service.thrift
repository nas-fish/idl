namespace go user_service

// ============== Enums ==============

enum IdentityType {
    RESIDENT = 1,
    MERCHANT = 2,
    HELPER = 4
}

enum ApplyStatus {
    PENDING = 0,
    APPROVED = 1,
    REJECTED = 2
}

enum SysRoleType {
    SUPER_ADMIN = 1,
    OPERATOR = 2,
    COMMITTEE = 3
}

enum TokenType {
    APP = 1,
    ADMIN = 2
}

// ============== Common Structs ==============

struct User {
    1: required i64 id
    2: required string openId
    3: optional string unionId
    4: optional string nickname
    5: optional string avatarUrl
    6: optional string mobile
    7: required i32 roleMask
    8: required string currentIdentity
    9: required i32 status
    10: optional i64 createTime
    11: optional i64 updateTime
}

struct SysUser {
    1: required i64 id
    2: required string username
    3: required string password
    4: required string roleType
    5: optional i64 communityId
    6: required string salt
    7: required i32 status
    8: optional i64 createTime
}

struct Community {
    1: required i64 id
    2: required string name
    3: optional string regionCode
    4: required string address
    5: optional string serviceRadius
    6: optional string contactJuwei
    7: optional string contactOperator
    8: required i32 status
    9: optional i64 createTime
}

struct IdentityApply {
    1: required i64 id
    2: required i64 userId
    3: required i64 communityId
    4: required i32 applyType
    5: required string applyData
    6: required i32 status
    7: optional string auditReason
    8: optional i64 auditorId
    9: optional i64 auditTime
    10: optional i64 createTime
}

struct MerchantProfile {
    1: required i64 id
    2: required i64 userId
    3: required string shopName
    4: required string shopAddress
    5: optional string locationLat
    6: optional string locationLng
    7: optional string licenseImg
    8: required i64 communityId
    9: optional string balance
    10: required i32 status
    11: optional i64 createTime
}

struct HelperProfile {
    1: required i64 id
    2: required i64 userId
    3: required string realName
    4: optional string skillTags
    5: optional string intro
    6: optional string certImgs
    7: required i64 communityId
    8: required i32 serviceStatus
    9: optional i64 createTime
}

struct IdentityInfo {
    1: required string identity
    2: required string name
    3: required string status
}

struct CommunityAuditStatus {
    1: required i64 communityId
    2: required string communityName
    3: required string status
    4: optional string reason
}

// ============== C端认证接口 ==============

struct WechatLoginReq {
    1: required string code
}

struct WechatLoginResp {
    1: required string token
    2: required i64 userId
    3: required bool isNewUser
}

struct BindPhoneReq {
    1: required string token
    2: optional string encryptedData
    3: optional string iv
    4: optional string mobile
}

struct BindPhoneResp {
}

// ============== C端用户接口 ==============

struct GetProfileReq {
    1: required string token
}

struct GetProfileResp {
    1: required i64 userId
    2: optional string nickname
    3: optional string avatarUrl
    4: optional string mobile
    5: required i32 roleMask
    6: required string currentIdentity
    7: required list<IdentityInfo> identities
}

struct UpdateProfileReq {
    1: required string token
    2: optional string nickname
    3: optional string avatarUrl
}

struct UpdateProfileResp {
}

struct SwitchIdentityReq {
    1: required string token
    2: required string targetIdentity
}

struct SwitchIdentityResp {
}

// ============== C端申请接口 ==============

struct MerchantApplyReq {
    1: required string token
    2: required string shopName
    3: required string contactPhone
    4: required string shopAddress
    5: optional string latitude
    6: optional string longitude
    7: required string licenseImg
    8: optional string shopFrontImg
    9: required list<i64> communityIds
}

struct MerchantApplyResp {
}

struct HelperApplyReq {
    1: required string token
    2: required string realName
    3: optional list<string> skillTags
    4: optional string intro
    5: optional list<string> certImgs
    6: required i64 communityId
}

struct HelperApplyResp {
}

struct GetLatestApplyReq {
    1: required string token
}

struct GetLatestApplyResp {
    1: optional i64 applyId
    2: optional string applyType
    3: optional string applyData
    4: optional i64 createTime
    5: optional list<CommunityAuditStatus> auditDetails
}

struct GetMerchantApplyDetailReq {
    1: required string token
}

struct GetMerchantApplyDetailResp {
    1: optional i64 applyId
    2: optional string status
    3: optional string auditReason
    4: optional string applyData
}

// ============== C端公共接口 ==============

struct ListCommunitiesReq {
}

struct ListCommunitiesResp {
    1: required list<CommunityInfo> communities
}

struct CommunityInfo {
    1: required i64 id
    2: required string name
    3: optional string regionCode
    4: optional string address
    5: optional string serviceRadius
    6: required i32 status
}

// ============== B端认证接口 ==============

struct AdminLoginReq {
    1: required string username
    2: required string password
}

struct AdminLoginResp {
    1: required string token
    2: required i64 userId
    3: required bool isNewUser
}

// ============== B端社区管理接口 ==============

struct CreateCommunityReq {
    1: required string token
    2: required string name
    3: optional string regionCode
    4: required string address
    5: optional string serviceRadius
    6: optional string contactJuwei
    7: optional string contactOperator
}

struct CreateCommunityResp {
    1: required i64 communityId
    2: required string communityName
    3: required string operatorUsername
    4: required string operatorPassword
    5: required string committeeUsername
    6: required string committeePassword
}

struct UpdateCommunityReq {
    1: required string token
    2: required i64 communityId
    3: required string name
    4: optional string regionCode
    5: required string address
    6: optional string serviceRadius
    7: optional string contactJuwei
    8: optional string contactOperator
}

struct UpdateCommunityResp {
}

struct ListCommunityPageReq {
    1: required string token
}

struct ListCommunityPageResp {
    1: required list<CommunityInfo> communities
}

struct GetCommunityAccountsReq {
    1: required string token
    2: required i64 communityId
}

struct AccountInfo {
    1: required i64 id
    2: required string username
    3: required string roleType
    4: required i32 status
}

struct GetCommunityAccountsResp {
    1: required list<AccountInfo> accounts
}

struct ResetPasswordReq {
    1: required string token
    2: required i64 sysUserId
}

struct ResetPasswordResp {
    1: required string newPassword
}

struct ToggleCommunityStatusReq {
    1: required string token
    2: required i64 communityId
    3: required bool enabled
}

struct ToggleCommunityStatusResp {
}

// ============== B端审核接口 ==============

struct GetPendingListReq {
    1: required string token
    2: required i64 communityId
}

struct GetPendingListResp {
    1: required list<IdentityApply> applies
}

struct ProcessAuditReq {
    1: required string token
    2: required i64 applyId
    3: required string action
    4: optional string reason
}

struct ProcessAuditResp {
}

// ============== Token验证接口 ==============

struct ValidateTokenReq {
    1: required string token
}

struct ValidateTokenResp {
    1: required bool valid
    2: optional TokenType tokenType
    3: optional i64 userId
    4: optional i64 sysUserId
    5: optional string roleType
    6: optional i64 communityId
}

// ============== Service Definition ==============

service PPTUserService {
    // C端认证
    WechatLoginResp WechatLogin(1: WechatLoginReq req)
    BindPhoneResp BindPhone(1: BindPhoneReq req)
    
    // C端用户
    GetProfileResp GetProfile(1: GetProfileReq req)
    UpdateProfileResp UpdateProfile(1: UpdateProfileReq req)
    SwitchIdentityResp SwitchIdentity(1: SwitchIdentityReq req)
    
    // C端申请
    MerchantApplyResp CreateMerchantApply(1: MerchantApplyReq req)
    MerchantApplyResp UpdateMerchantApply(1: MerchantApplyReq req)
    HelperApplyResp CreateHelperApply(1: HelperApplyReq req)
    HelperApplyResp UpdateHelperApply(1: HelperApplyReq req)
    GetLatestApplyResp GetLatestApply(1: GetLatestApplyReq req)
    GetMerchantApplyDetailResp GetMerchantApplyDetail(1: GetMerchantApplyDetailReq req)
    
    // C端公共
    ListCommunitiesResp ListCommunities(1: ListCommunitiesReq req)
    
    // B端认证
    AdminLoginResp AdminLogin(1: AdminLoginReq req)
    
    // B端社区管理
    CreateCommunityResp CreateCommunity(1: CreateCommunityReq req)
    UpdateCommunityResp UpdateCommunity(1: UpdateCommunityReq req)
    ListCommunityPageResp ListCommunityPage(1: ListCommunityPageReq req)
    GetCommunityAccountsResp GetCommunityAccounts(1: GetCommunityAccountsReq req)
    ResetPasswordResp ResetPassword(1: ResetPasswordReq req)
    ToggleCommunityStatusResp ToggleCommunityStatus(1: ToggleCommunityStatusReq req)
    
    // B端审核
    GetPendingListResp GetPendingList(1: GetPendingListReq req)
    ProcessAuditResp ProcessAudit(1: ProcessAuditReq req)
    
    // Token验证
    ValidateTokenResp ValidateToken(1: ValidateTokenReq req)
}
