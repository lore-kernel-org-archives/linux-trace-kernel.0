Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C519FCA0EC3
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 12 Sep 2023 03:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbjILDgm (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 11 Sep 2023 23:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjILDgc (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:36:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50681C522
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:36:02 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rl7006rchzNnPV;
        Tue, 12 Sep 2023 10:32:16 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 12 Sep 2023 10:35:59 +0800
Message-ID: <b538b3f9-2ba1-5329-6af9-c5b75bab4fd5@huawei.com>
Date:   Tue, 12 Sep 2023 10:35:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] eventfs: Fix the NULL pointer dereference bug in
 eventfs_remove_rec()
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC:     <linux-trace-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ajay Kaher <akaher@vmware.com>
References: <20230911052818.1020547-1-ruanjinjie@huawei.com>
 <20230911205125.da905de7b6616ecef3811d7f@kernel.org>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230911205125.da905de7b6616ecef3811d7f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org



On 2023/9/11 19:51, Masami Hiramatsu (Google) wrote:
> Hi Jinjie,
> 
> On Mon, 11 Sep 2023 13:28:17 +0800
> Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> Inject fault while probing btrfs.ko, if kstrdup() fails in
>> eventfs_prepare_ef() in eventfs_add_dir(), it will return ERR_PTR
>> to assign file->ef. But the eventfs_remove() check NULL in
>> trace_module_remove_events(), which causes the below NULL
>> pointer dereference.
>>
>> As both Masami and Steven suggest, allocater side should handle the
>> error carefully and remove it, so fix the places where it failed.
> 
> Thanks for update, but this is too much. Sorry if I confused you.
> 
> I meant just *one site* must be fixed. *The returning error code is not
> a bad idea*, as far as it is used in temporary variable.
> 
> e.g. 
> 
> 	dir->ef = eventfs_add_subsystem_dir(name, parent);
> 	if (IS_ERR(dir->ef)) {
> 		...
> 	}
> 
> This smells *bad* because if the eventfs_add_subsystem_dir() can return
> the error code, 'dir->ef' will be kept and may be referred by another
> code.
> 
> Instead,
> 
> 	ef = eventfs_add_subsystem_dir(name, parent);
> 	if (IS_ERR(ef)) {
> 		...
> 	} else
> 		dir->ef = ef;
> 
> This is safer, because 'dir->ef' always has NULL (unintialized) or a
> valid address (initialized). So the error code is alyways assigned to
> the temporary variable 'ef', and the caller can handle error correctly
> by checking the error code.

Thank you! I'll fix it sooner.

> 
> Thank you,
> 
>>
>>  Could not create tracefs 'raid56_write' directory
>>  Btrfs loaded, zoned=no, fsverity=no
>>  Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
>>  Mem abort info:
>>    ESR = 0x0000000096000004
>>    EC = 0x25: DABT (current EL), IL = 32 bits
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>>    FSC = 0x04: level 0 translation fault
>>  Data abort info:
>>    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>  user pgtable: 4k pages, 48-bit VAs, pgdp=0000000102544000
>>  [000000000000001c] pgd=0000000000000000, p4d=0000000000000000
>>  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>>  Dumping ftrace buffer:
>>     (ftrace buffer empty)
>>  Modules linked in: btrfs(-) libcrc32c xor xor_neon raid6_pq cfg80211 rfkill 8021q garp mrp stp llc ipv6 [last unloaded: btrfs]
>>  CPU: 15 PID: 1343 Comm: rmmod Tainted: G                 N 6.5.0+ #40
>>  Hardware name: linux,dummy-virt (DT)
>>  pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>  pc : eventfs_remove_rec+0x24/0xc0
>>  lr : eventfs_remove+0x68/0x1d8
>>  sp : ffff800082d63b60
>>  x29: ffff800082d63b60 x28: ffffb84b80ddd00c x27: ffffb84b3054ba40
>>  x26: 0000000000000002 x25: ffff800082d63bf8 x24: ffffb84b8398e440
>>  x23: ffffb84b82af3000 x22: dead000000000100 x21: dead000000000122
>>  x20: ffff800082d63bf8 x19: fffffffffffffff4 x18: ffffb84b82508820
>>  x17: 0000000000000000 x16: 0000000000000000 x15: 000083bc876a3166
>>  x14: 000000000000006d x13: 000000000000006d x12: 0000000000000000
>>  x11: 0000000000000001 x10: 00000000000017e0 x9 : 0000000000000001
>>  x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffffb84b84289804
>>  x5 : 0000000000000000 x4 : 9696969696969697 x3 : ffff33a5b7601f38
>>  x2 : 0000000000000000 x1 : ffff800082d63bf8 x0 : fffffffffffffff4
>>  Call trace:
>>   eventfs_remove_rec+0x24/0xc0
>>   eventfs_remove+0x68/0x1d8
>>   remove_event_file_dir+0x88/0x100
>>   event_remove+0x140/0x15c
>>   trace_module_notify+0x1fc/0x230
>>   notifier_call_chain+0x98/0x17c
>>   blocking_notifier_call_chain+0x4c/0x74
>>   __arm64_sys_delete_module+0x1a4/0x298
>>   invoke_syscall+0x44/0x100
>>   el0_svc_common.constprop.1+0x68/0xe0
>>   do_el0_svc+0x1c/0x28
>>   el0_svc+0x3c/0xc4
>>   el0t_64_sync_handler+0xa0/0xc4
>>   el0t_64_sync+0x174/0x178
>>  Code: 5400052c a90153b3 aa0003f3 aa0103f4 (f9401400)
>>  ---[ end trace 0000000000000000 ]---
>>  Kernel panic - not syncing: Oops: Fatal exception
>>  SMP: stopping secondary CPUs
>>  Dumping ftrace buffer:
>>     (ftrace buffer empty)
>>  Kernel Offset: 0x384b00c00000 from 0xffff800080000000
>>  PHYS_OFFSET: 0xffffcc5b80000000
>>  CPU features: 0x88000203,3c020000,1000421b
>>  Memory Limit: none
>>  Rebooting in 1 seconds..
>>
>> Fixes: 5bdcd5f5331a ("eventfs: Implement removal of meta data from eventfs")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>> ---
>> v3:
>> - Fix the places where it failed instead of IS_ERR_OR_NULL()
>> - Update the commit message.
>> v2:
>> - Use IS_ERR_OR_NULL() to check instead of IS_ERR() as suggested.
>> - Update the commit message.
>> ---
>>  fs/tracefs/event_inode.c    | 22 +++++++++++-----------
>>  kernel/trace/trace_events.c |  4 ++--
>>  2 files changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
>> index 237c6f370ad9..72bf40484244 100644
>> --- a/fs/tracefs/event_inode.c
>> +++ b/fs/tracefs/event_inode.c
>> @@ -447,12 +447,12 @@ static struct eventfs_file *eventfs_prepare_ef(const char *name, umode_t mode,
>>  
>>  	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
>>  	if (!ef)
>> -		return ERR_PTR(-ENOMEM);
>> +		return NULL;
>>  
>>  	ef->name = kstrdup(name, GFP_KERNEL);
>>  	if (!ef->name) {
>>  		kfree(ef);
>> -		return ERR_PTR(-ENOMEM);
>> +		return NULL;
>>  	}
>>  
>>  	if (S_ISDIR(mode)) {
>> @@ -460,7 +460,7 @@ static struct eventfs_file *eventfs_prepare_ef(const char *name, umode_t mode,
>>  		if (!ef->ei) {
>>  			kfree(ef->name);
>>  			kfree(ef);
>> -			return ERR_PTR(-ENOMEM);
>> +			return NULL;
>>  		}
>>  		INIT_LIST_HEAD(&ef->ei->e_top_files);
>>  	} else {
>> @@ -539,14 +539,14 @@ struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
>>  	struct eventfs_file *ef;
>>  
>>  	if (!parent)
>> -		return ERR_PTR(-EINVAL);
>> +		return NULL;
>>  
>>  	ti_parent = get_tracefs(parent->d_inode);
>>  	ei_parent = ti_parent->private;
>>  
>>  	ef = eventfs_prepare_ef(name, S_IFDIR, NULL, NULL, NULL);
>> -	if (IS_ERR(ef))
>> -		return ef;
>> +	if (!ef)
>> +		return NULL;
>>  
>>  	mutex_lock(&eventfs_mutex);
>>  	list_add_tail(&ef->list, &ei_parent->e_top_files);
>> @@ -570,11 +570,11 @@ struct eventfs_file *eventfs_add_dir(const char *name,
>>  	struct eventfs_file *ef;
>>  
>>  	if (!ef_parent)
>> -		return ERR_PTR(-EINVAL);
>> +		return NULL;
>>  
>>  	ef = eventfs_prepare_ef(name, S_IFDIR, NULL, NULL, NULL);
>> -	if (IS_ERR(ef))
>> -		return ef;
>> +	if (!ef)
>> +		return NULL;
>>  
>>  	mutex_lock(&eventfs_mutex);
>>  	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
>> @@ -622,7 +622,7 @@ int eventfs_add_events_file(const char *name, umode_t mode,
>>  	ei = ti->private;
>>  	ef = eventfs_prepare_ef(name, mode, fop, NULL, data);
>>  
>> -	if (IS_ERR(ef))
>> +	if (!ef)
>>  		return -ENOMEM;
>>  
>>  	mutex_lock(&eventfs_mutex);
>> @@ -661,7 +661,7 @@ int eventfs_add_file(const char *name, umode_t mode,
>>  		mode |= S_IFREG;
>>  
>>  	ef = eventfs_prepare_ef(name, mode, fop, NULL, data);
>> -	if (IS_ERR(ef))
>> +	if (!ef)
>>  		return -ENOMEM;
>>  
>>  	mutex_lock(&eventfs_mutex);
>> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
>> index ed367d713be0..86956e23ac49 100644
>> --- a/kernel/trace/trace_events.c
>> +++ b/kernel/trace/trace_events.c
>> @@ -2330,7 +2330,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
>>  		__get_system(system);
>>  
>>  	dir->ef = eventfs_add_subsystem_dir(name, parent);
>> -	if (IS_ERR(dir->ef)) {
>> +	if (!dir->ef) {
>>  		pr_warn("Failed to create system directory %s\n", name);
>>  		__put_system(system);
>>  		goto out_free;
>> @@ -2432,7 +2432,7 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
>>  
>>  	name = trace_event_name(call);
>>  	file->ef = eventfs_add_dir(name, ef_subsystem);
>> -	if (IS_ERR(file->ef)) {
>> +	if (!file->ef) {
>>  		pr_warn("Could not create tracefs '%s' directory\n", name);
>>  		return -1;
>>  	}
>> -- 
>> 2.34.1
>>
> 
> 
