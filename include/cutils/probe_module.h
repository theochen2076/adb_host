/*
 * Copyright (C) 2012 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef _LIBS_CUTILS_PROBEMODULE_H
#define _LIBS_CUTILS_PROBEMODULE_H

#ifdef __cplusplus
extern "C" {
#endif

/* get_default_mod_path() - get the default modules path
 * It checks /system/lib/modules/$(uname -r)/ first. If it doesn't exist,
 * fall back to /system/lib/modules/.
 *
 * def_mod_path: The buffer to be filled
 *
 * return      : def_mod_path
 */
extern char *get_default_mod_path(char *def_mod_path);

/* insmod() - load a kernel module (target) from a file
 *
 * filename   : Filename of the target module.
 *
 * args       : A string of target module's parameters. NOTE: we only
 *              support parameters of the target module.
 *
 */
extern int insmod(const char *filename, const char *args);

/* insmod_by_dep() - load a kernel module (target) with its dependency
 * The module's dependency must be described in the provided dependency file.
 * other modules in the dependency chain will be loaded prior to the target.
 *
 * module_name: Name of the target module. e.g. name "MyModule" is for
 *              module file MyModule.ko.
 *
 * args       : A string of target module's parameters. NOTE: we only
 *              support parameters of the target module.
 *
 * dep_name   : Name of dependency file. If it is NULL, we will look
 *              up /system/lib/modules/modules.dep by default.
 *
 * strip      : Non-zero values remove paths of modules in dependency.
 *              before loading them. The final path of a module will be
 *              base/MyModule.ko. This is for devices which put every
 *              modules into a single directory.
 *
 *              Passing 0 to strip keeps module paths in dependency file.
 *              e.g. "kernel/drivers/.../MyModule.ko" in dep file will
 *              be loaded as base/kernel/drivers/.../MyModule.ko .
 *
 * base       : Base dir, a prefix to be added to module's path prior to
 *              loading. The last character prior to base string's terminator
 *              must be a '/'. If it is NULL, we will take
 *              /system/lib/modules/modules.dep by default.
 *
 * return     : 0 for success; non-zero for any errors.
 *
 * Note:
 * When loading modules, function will not fail for any modules which are
 * already in kernel. The module parameters passed to function will not be
 * effective in this case if target module is already loaded into kernel.
 */
extern int insmod_by_dep(
        const char *module_name,
        const char *args,
        const char *dep_name,
        int strip,
        const char * base);

/* rmmod_by_dep() - remove a module (target) from kernel with its dependency
 * The module's dependency must be described in the provided dependency file.
 * This function will try to remove other modules in the dependency chain too
 *
 * module_name: Name of the target module. e.g. name "MyModule" is for
 *              module file MyModule.ko.
 *
 * dep_name   : Name of dependency file. If it is NULL, we will look
 *              up /system/lib/modules/modules.dep by default.
 *
 * return     : 0 for success; non-zero for any errors.
 */
extern int rmmod_by_dep(const char *module_name, const char *dep_name);

#ifdef __cplusplus
}
#endif

#endif /*_LIBS_CUTILS_PROBEMODULE_H*/
