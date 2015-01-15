//
//  FoodDataController.h
//  Food
//
//  Created by MDR on 14/07/14.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReviewsDataController.h"
#import "RequestResponse.h"

@interface FoodDataController : NSObject
//Grid/List
@property NSInteger fID;
@property(copy) NSString *fName;
@property(copy) NSString *fShortDescription;
@property(copy) UIImage *Item_thumbnail;
@property(copy) NSArray *fFilterIDArray;
//Details
@property(copy) NSString *fBriefDescription;
@property(copy) NSArray *fImagesArray;
@property NSInteger rating;
@property BOOL isRecomendedByChef;
@property BOOL isItemOfTheDay;

-(NSMutableDictionary *) GetAllFoodItems;//Include all details. Say all parameters. Read from appdelegate object
-(FoodDataController *) GetFoodItemDetailsByID : (NSInteger) itemID; //occasional use! Might not be useful
-(NSMutableArray *) GetFoodItemsByGroupID : (NSInteger) groupID;
-(NSMutableDictionary *) GetFoodItemsFromDB; //Read from DB and set to appdelegate
- (void) requestResponseDidRecieveData:(NSString *) resultString withService:(RequestResponseServiceType)serviceType;
@end
