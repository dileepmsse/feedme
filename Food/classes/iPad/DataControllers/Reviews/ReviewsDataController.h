//
//  ReviewsDataController.h
//  Food
//
//  Created by MDR on 14/07/14.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReviewsDataController : NSObject

-(NSMutableArray *) GetReviewsbyItemID :(NSInteger) fID; //Used for lazy loading
-(NSMutableDictionary*) GetAllReviews;
-(NSMutableDictionary *) GetAllReviewsFromDB; //Read from DB and set to appdelegate
-(void) UpdateAllReviews; //Used to update all reviews when Universal update is triggered /////// Might not be used
@end
