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
 Initialize the global state

 This function must the called before any other SwiftGit2 function in order to set up global state and threading.
 */
public func initialize() throws {
    guard !git_libgit2_init().isError() else {
        throw GitError.last()
    }
}
/**
 Shutdown the global state

 Clean up the global state and threading context.
 */
public func shutdown() throws {
    guard !git_libgit2_shutdown().isError() else {
        throw GitError.last()
    }
}
