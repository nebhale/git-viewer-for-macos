/**
 Copyright 2016 Ben Hale

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation
import Git2

/**
 Error classes
 */
public enum GitError: Error {

    case Unknown(message: String)

    case None(message: String)

    case NoMemory(message: String)

    case OS(message: String)

    case Invalid(message: String)

    case Reference(message: String)

    case ZLib(message: String)

    case Repository(message: String)

    case Config(message: String)

    case RegularExpression(message: String)

    case ObjectDatabase(message: String)

    case Index(message: String)

    case Object(message: String)

    case Network(message: String)

    case Tag(message: String)

    case Tree(message: String)

    case Indexer(message: String)

    case SSL(message: String)

    case Submodule(message: String)

    case Thread(message: String)

    case Stash(message: String)

    case Checkout(message: String)

    case FetchHead(message: String)

    case Merge(message: String)

    case SSH(message: String)

    case Filter(message: String)

    case Revert(message: String)

    case Callback(message: String)

    case CherryPick(message: String)

    case Describe(message: String)

    case Rebase(message: String)

    case FileSystem(message: String)

}

extension GitError {

    /**
     Returns the last error from the underlying Git framework

     - Returns: One of `GitError`.  If there is no last error, then `Error.None` is returned.
    */
    public static func last() -> GitError {
        guard let error = giterr_last()?.pointee else {
            return None(message: "No error")
        }

        giterr_clear()

        let message = String(cString: error.message)

        switch error.klass {
        case 0:
            return None(message: message)
        case 1:
            return NoMemory(message: message)
        case 2:
            return OS(message: message)
        case 3:
            return Invalid(message: message)
        case 4:
            return Reference(message: message)
        case 5:
            return ZLib(message: message)
        case 6:
            return Repository(message: message)
        case 7:
            return Config(message: message)
        case 8:
            return RegularExpression(message: message)
        case 9:
            return ObjectDatabase(message: message)
        case 10:
            return Index(message: message)
        case 11:
            return Object(message: message)
        case 12:
            return Network(message: message)
        case 13:
            return Tag(message: message)
        case 14:
            return Tree(message: message)
        case 15:
            return  Indexer(message: message)
        case 16:
            return SSL(message: message)
        case 17:
            return Submodule(message: message)
        case 18:
            return Thread(message: message)
        case 19:
            return Stash(message: message)
        case 20:
            return Checkout(message: message)
        case 21:
            return FetchHead(message: message)
        case 22:
            return Merge(message: message)
        case 23:
            return SSH(message: message)
        case 24:
            return Filter(message: message)
        case 25:
            return Revert(message: message)
        case 26:
            return Callback(message: message)
        case 27:
            return CherryPick(message: message)
        case 28:
            return Describe(message: message)
        case 29:
            return Rebase(message: message)
        case 30:
            return FileSystem(message: message)
        default:
            return Unknown(message: message)
        }
    }
    
}
