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
 Representation of an existing git repository, including all its object contents
 */
public struct Repository {

    let pointer: OpaquePointer?

    private init(pointer: OpaquePointer?) {
        self.pointer = pointer
    }

    /**
     Opens an existing git repository.
 
     This function will automatically detect if `path` is a normal or bare repository or fail if `path` is neither.
 
     - Parameter path: points to either a git repository folder, or an existing work directory
     - Throws: `GitError` if path is not a valid git repository
     */
    public init(path: NSURL) throws {
        var pointer: OpaquePointer?

        guard !git_repository_open(&pointer, path.fileSystemRepresentation).isError() else {
            throw GitError.last()
        }

        self.init(pointer: pointer)
    }

}

extension Repository {

    /**
     Look for a git repository and return its path.

     The lookup starts from `startPath` and walks across parent directories if nothing has been found. The lookup ends
     when the first repository is found, or when reaching a directory referenced in ceiling_dirs or when the filesystem
     changes (in case `acrossFileSystems` is true).

     The function will automatically detect if the repository is bare (if there is a repository).

     - Parameter startPath: The base path where the lookup starts
     - Parameter acrossFileSystems: If `true`, then the lookup will not stop when a filesystem device change is detected
                                    while exploring parent directories.
     - Parameter ceilingDirectories: a collection of paths.  The lookup will stop when any of these paths are reached. 
                                     Note that the lookup always performs on `startPath` even if `startPath` appears in
                                    `ceilingDirectories`
     - Returns: The path of the git repository
     - Throws: `GitError` if an error is encourntered
     */
    public static func discover(startPath: NSURL, acrossFileSystems: Bool, ceilingDirectories: NSURL...) throws -> NSURL? {
        var buffer = git_buf()
        defer {
            git_buf_free(&buffer)
        }

        guard !git_repository_discover(&buffer, startPath.fileSystemRepresentation, acrossFileSystems.toInt(), ceilingDirectories.asGitPathList()).isError() else {
            throw GitError.last()
        }

        let path = String(cString: buffer.ptr)
        guard !path.isEmpty else {
            return nil
        }

        return NSURL(fileURLWithPath: path)
    }

}

extension Array where Element: NSURL {

    func asGitPathList() -> String {
        return self
            .filter { url -> Bool in url.isFileURL }
            .map { url -> String in url.absoluteString! }
            .joined(separator: ":")
    }

}
