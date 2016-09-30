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
 Submodule ignore values
 
 These values represent settings for the `submodule.$name.ignore` configuration value which says how deeply to look at
 the working directory when getting submodule status.
 
 You can override this value in memory on a per-submodule basis with `git_submodule_set_ignore()` and can write the 
 changed value to disk with `git_submodule_save()`.  If you have overwritten the value, you can revert to the on disk
 value by using `GIT_SUBMODULE_IGNORE_RESET`.
 */
public enum SubmoduleIgnore: Int {

    /**
     Use the submodule's configuration
     */
    case Unspecified = -1

    /**
     Don't ignore any change - i.e. even an untracked file, will mark the submodule as dirty.  Ignored files are still
     ignored, of course.
     */
    case None = 1

    /**
     Ignore untracked files; only changes to tracked files, or the index or the HEAD commit will matter.
     */
    case Untracked

    /**
     Ignore changes in the working directory, only considering changes if the HEAD of submodule has moved from the value
     in the superproject.
     */
    case Dirty

    /**
     Never check if the submodule is dirty
     */
    case All
    
}
