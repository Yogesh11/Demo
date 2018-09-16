
/** This Class is used to initialize errorTitle, errorMessage and errorCode.
    ** All variables of this class is read only.
        * errortitle    :  Error Title.
        * errorCode     :  Error Code.
        * errorMessage  :  Error Message.
     *
    ** Functions *
        * Initilaize ErrorObject with errorTitle, errorCode, errorMessage. That class contains default initialization for errorTitle, errorCode , errorMessage. So three varibales cant be nil in any point of time *

        * init(error  : Error) :  That function will prepare all variables with the help of ErrorObject. i.e Apple Provided Error Object.

 */

import Foundation

class RError: NSObject {
    /** Only Read only variables */
    private(set) var errortitle   : String!  = "Error"
    private(set) var errorCode    : String!  =  "1"
    private(set) var errorMessage : String!  = "Oops! Something went wrong."

    /** Initializa error object with errorTitle, errorMessage, errorCode */
    init(errortitle   : String? = nil,
         errorMessage : String? = nil,
         errorCode    : String? = nil) {
        super.init()
        /** Prepare error with respective values */
        prepareError(errorTitle     : errortitle,
                     errorMessage   : errorMessage,
                     errorCode      : errorCode)
    }
    
     private override init() {
        super.init()
    }

    /** init with Error Object */
    init(error  : Error) {
        super.init()
        /** Prepare error from Error(Apple provided Error) object. */
        prepareError(errorTitle    : nil,
                     errorMessage  : error.localizedDescription,
                     errorCode     : String((error as NSError).code))
    }



    /** Prepare error with ErrorTitle, ErrorMessage, ErrorCode */
    private func prepareError(errorTitle     :String? ,
                              errorMessage   : String?,
                              errorCode      : String?){
        /* Checking for valid errorTitle */
        if (isAValidString(text: errorTitle)   == true)  {
            self.errortitle  = errorTitle
        }

         /* Checking for valid errorCode */
        if (isAValidString(text: errorCode)   == true)  {
            self.errorCode  = errorCode
        }

        /* Checking for valid errorMessage */
        if (isAValidString(text: errorMessage)   == true)  {
            self.errorMessage  = errorMessage
        }
    }

    /** Check for valid string
            * text : String need to be check.
        That function will retrun a bool value.
     */
    private func isAValidString(text : String?)-> Bool {
        if (text != nil) && text?.isEmpty == false {
            return true
        }
         return false
    }
    
}



