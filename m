Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BE2EE57E4
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  8 Sep 2023 08:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbjIHI0j (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 8 Sep 2023 04:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjIHI0i (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:26:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFED419A8
        for <linux-trace-kernel@vger.kernel.org>; Fri,  8 Sep 2023 01:26:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0DAC433B8;
        Fri,  8 Sep 2023 08:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694161594;
        bh=dcUdMRk1mpELsWclT5eWTtYOJ9/KV1sKigpwE21JLzo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lSSbKyll5hYD0qPKTa3YKCNoMuPsCpoYnKyGjivqYy0LKeuoA+AUHzlZre+F8qLyD
         DWZfrSmNSfNSgT8V+4YWtKRYKYm5Wd42jpYcHBfxATZsJynN7knCfcBkNDqiX3cEYD
         HcxpaSnRCqz/M9CT2k9KUK07L7YvLhmKbBuii1W4ak8d/crYIk7annhf/khhhz03PR
         u52rwbFVyl77aPMaMDw2lbJcK/3TeuRJGV+RyTFKdZg46u6QsFe3m9dZmVFHWX3l8U
         a81oXGplrjBa/R+RaHSNIFlnDiUTrsd/0ueWWZQUn0J4KQXSsY+geIJDW4V/72hYaN
         HRmkOkGbaT0tg==
Date:   Fri, 8 Sep 2023 17:26:30 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <linux-trace-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH] eventfs: Fix the NULL pointer dereference bug in
 eventfs_remove_rec()
Message-Id: <20230908172630.6f923f31e4e3bb39748c9733@kernel.org>
In-Reply-To: <20230908074903.3724778-1-ruanjinjie@huawei.com>
References: <20230908074903.3724778-1-ruanjinjie@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, 8 Sep 2023 15:49:03 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Inject fault while probing btrfs.ko, if kstrdup() fails in
> eventfs_prepare_ef() in eventfs_add_dir(), it will return ERR_PTR
> to assign file->ef. But the eventfs_remove() check NULL in
> trace_module_remove_events(), which causes the below NULL
> pointer dereference. So use IS_ERR() to check ef
> in eventfs_remove_rec(), and fix the same issue in eventfs_remove().
> 
>  Could not create tracefs 'raid56_write' directory
>  Btrfs loaded, zoned=no, fsverity=no
>  Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
>  Mem abort info:
>    ESR = 0x0000000096000004
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x04: level 0 translation fault
>  Data abort info:
>    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>  user pgtable: 4k pages, 48-bit VAs, pgdp=0000000102544000
>  [000000000000001c] pgd=0000000000000000, p4d=0000000000000000
>  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>  Dumping ftrace buffer:
>     (ftrace buffer empty)
>  Modules linked in: btrfs(-) libcrc32c xor xor_neon raid6_pq cfg80211 rfkill 8021q garp mrp stp llc ipv6 [last unloaded: btrfs]
>  CPU: 15 PID: 1343 Comm: rmmod Tainted: G                 N 6.5.0+ #40
>  Hardware name: linux,dummy-virt (DT)
>  pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : eventfs_remove_rec+0x24/0xc0
>  lr : eventfs_remove+0x68/0x1d8
>  sp : ffff800082d63b60
>  x29: ffff800082d63b60 x28: ffffb84b80ddd00c x27: ffffb84b3054ba40
>  x26: 0000000000000002 x25: ffff800082d63bf8 x24: ffffb84b8398e440
>  x23: ffffb84b82af3000 x22: dead000000000100 x21: dead000000000122
>  x20: ffff800082d63bf8 x19: fffffffffffffff4 x18: ffffb84b82508820
>  x17: 0000000000000000 x16: 0000000000000000 x15: 000083bc876a3166
>  x14: 000000000000006d x13: 000000000000006d x12: 0000000000000000
>  x11: 0000000000000001 x10: 00000000000017e0 x9 : 0000000000000001
>  x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffffb84b84289804
>  x5 : 0000000000000000 x4 : 9696969696969697 x3 : ffff33a5b7601f38
>  x2 : 0000000000000000 x1 : ffff800082d63bf8 x0 : fffffffffffffff4
>  Call trace:
>   eventfs_remove_rec+0x24/0xc0
>   eventfs_remove+0x68/0x1d8
>   remove_event_file_dir+0x88/0x100
>   event_remove+0x140/0x15c
>   trace_module_notify+0x1fc/0x230
>   notifier_call_chain+0x98/0x17c
>   blocking_notifier_call_chain+0x4c/0x74
>   __arm64_sys_delete_module+0x1a4/0x298
>   invoke_syscall+0x44/0x100
>   el0_svc_common.constprop.1+0x68/0xe0
>   do_el0_svc+0x1c/0x28
>   el0_svc+0x3c/0xc4
>   el0t_64_sync_handler+0xa0/0xc4
>   el0t_64_sync+0x174/0x178
>  Code: 5400052c a90153b3 aa0003f3 aa0103f4 (f9401400)
>  ---[ end trace 0000000000000000 ]---
>  Kernel panic - not syncing: Oops: Fatal exception
>  SMP: stopping secondary CPUs
>  Dumping ftrace buffer:
>     (ftrace buffer empty)
>  Kernel Offset: 0x384b00c00000 from 0xffff800080000000
>  PHYS_OFFSET: 0xffffcc5b80000000
>  CPU features: 0x88000203,3c020000,1000421b
>  Memory Limit: none
>  Rebooting in 1 seconds..
> 

Thanks for reporting the bug!

> Fixes: 5bdcd5f5331a ("eventfs: Implement removal of meta data from eventfs")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  fs/tracefs/event_inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 237c6f370ad9..e6efa4078f48 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -693,7 +693,7 @@ static void eventfs_remove_rec(struct eventfs_file *ef, struct list_head *head,
>  {
>  	struct eventfs_file *ef_child;
>  
> -	if (!ef)
> +	if (IS_ERR(ef))
>  		return;

But this is not good. Allocater side should handle the error carefully and remove it.
e.g. 

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 2af92177b765..5a08db957460 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2436,6 +2436,7 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 	file->ef = eventfs_add_dir(name, ef_subsystem);
 	if (IS_ERR(file->ef)) {
 		pr_warn("Could not create tracefs '%s' directory\n", name);
+		file->ef = NULL;
 		return -1;
 	}
 


Or at least, please use IS_ERR_OR_NULL().

>  	/*
>  	 * Check recursion depth. It should never be greater than 3:
> @@ -730,7 +730,7 @@ void eventfs_remove(struct eventfs_file *ef)
>  	struct dentry *dentry_list = NULL;
>  	struct dentry *dentry;
>  
> -	if (!ef)
> +	if (IS_ERR(ef))
>  		return;

Ditto.

Thank you,

>  
>  	mutex_lock(&eventfs_mutex);
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
