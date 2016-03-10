//
//  AccountModel.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/10.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

//account model
#import "TKJSONSerializedModel.h"

@interface AccountModel : TKJSONSerializedModel

//id
@property (nonatomic, strong) NSNumber *sid;
//name
@property (nonatomic, copy) NSString *sname;
//sex
@property (nonatomic, copy) NSString *ssex;
//account
@property (nonatomic, copy) NSString *saccount;
//password
@property (nonatomic, copy) NSString *spassword;
//type
@property (nonatomic, copy) NSString *stype;
//inductionTime
@property (nonatomic, strong) NSDate *sinductiontime;
//birthday
@property (nonatomic, strong) NSDate *sbirth;
//status
@property (nonatomic, copy) NSString *sstatus;

@end
