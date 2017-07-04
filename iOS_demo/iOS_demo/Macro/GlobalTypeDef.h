//
//  GlobalTypeDef.h
//  PowerStation
//
//  Created by wyao on 2017/5/6.
//  Copyright © 2017年 wyao. All rights reserved.
//

#ifndef GlobalTypeDef_h
#define GlobalTypeDef_h
#import <UIKit/UIKit.h>
typedef void(^NILBlock)(void);//空block
typedef void(^INdexBlock)(NSInteger index);//参数类型为常亮
typedef void(^OBJBlock)(id responObject);//参数为id类型的block
typedef void(^ERRORBlock)(NSError *error);//参数为error的block
typedef void (^ERRORCODEBlock)(NSInteger errCode,NSString *errorMsg);//参数为解析后error的block

#endif /* GlobalTypeDef_h */
