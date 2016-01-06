//
//       \\     //    ========     \\    //
//        \\   //          ==       \\  //
//         \\ //         ==          \\//
//          ||          ==           //\\
//          ||        ==            //  \\
//          ||       ========      //    \\
//
/*
 DB config
 */

#ifndef YUDBObject_DBConfig_h
#define YUDBObject_DBConfig_h

/*
 *  Support multiple data using FALASE OR TRUE
 
 *  Set TRUE customizable dbFolder () and dbName (), custom database location and file name
 
 *  Folder Path
    +(NSString*)dbFolder;
 *
 *  Database name
    +(NSString*)dbName;
 */
#define SupportMultipleDB TRUE


/*
 * Open DBObject framework console log
 * TRUE Open, FALASE closed
 */
#define DBLogOpen 1


#define YUDBLogOpen 0

#endif
