Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D7ACA0EC3
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 12 Sep 2023 13:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjILNsj (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 12 Sep 2023 09:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjILNsh (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:48:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0960510CE
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:48:32 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RlPy26DW0z1N7tw;
        Tue, 12 Sep 2023 21:46:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 21:48:30 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-trace-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ajay Kaher <akaher@vmware.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH v5] eventfs: Fix the NULL pointer dereference bug in eventfs_remove_rec()
Date:   Tue, 12 Sep 2023 21:47:52 +0800
Message-ID: <20230912134752.1838524-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Inject fault while probing btrfs.ko, if kstrdup() fails in
eventfs_prepare_ef() in eventfs_add_dir(), it will return ERR_PTR
to assign file->ef. But the eventfs_remove() check NULL in
trace_module_remove_events(), which causes the below NULL
pointer dereference.

As both Masami and Steven suggest, allocater side should handle the
error carefully and remove it, so fix the places where it failed.

 Could not create tracefs 'raid56_write' directory
 Btrfs loaded, zoned=no, fsverity=no
 Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
 Mem abort info:
   ESR = 0x0000000096000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x04: level 0 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
 user pgtable: 4k pages, 48-bit VAs, pgdp=0000000102544000
 [000000000000001c] pgd=0000000000000000, p4d=0000000000000000
 Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
 Dumping ftrace buffer:
    (ftrace buffer empty)
 Modules linked in: btrfs(-) libcrc32c xor xor_neon raid6_pq cfg80211 rfkill 8021q garp mrp stp llc ipv6 [last unloaded: btrfs]
 CPU: 15 PID: 1343 Comm: rmmod Tainted: G                 N 6.5.0+ #40
 Hardware name: linux,dummy-virt (DT)
 pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : eventfs_remove_rec+0x24/0xc0
 lr : eventfs_remove+0x68/0x1d8
 sp : ffff800082d63b60
 x29: ffff800082d63b60 x28: ffffb84b80ddd00c x27: ffffb84b3054ba40
 x26: 0000000000000002 x25: ffff800082d63bf8 x24: ffffb84b8398e440
 x23: ffffb84b82af3000 x22: dead000000000100 x21: dead000000000122
 x20: ffff800082d63bf8 x19: fffffffffffffff4 x18: ffffb84b82508820
 x17: 0000000000000000 x16: 0000000000000000 x15: 000083bc876a3166
 x14: 000000000000006d x13: 000000000000006d x12: 0000000000000000
 x11: 0000000000000001 x10: 00000000000017e0 x9 : 0000000000000001
 x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffffb84b84289804
 x5 : 0000000000000000 x4 : 9696969696969697 x3 : ffff33a5b7601f38
 x2 : 0000000000000000 x1 : ffff800082d63bf8 x0 : fffffffffffffff4
 Call trace:
  eventfs_remove_rec+0x24/0xc0
  eventfs_remove+0x68/0x1d8
  remove_event_file_dir+0x88/0x100
  event_remove+0x140/0x15c
  trace_module_notify+0x1fc/0x230
  notifier_call_chain+0x98/0x17c
  blocking_notifier_call_chain+0x4c/0x74
  __arm64_sys_delete_module+0x1a4/0x298
  invoke_syscall+0x44/0x100
  el0_svc_common.constprop.1+0x68/0xe0
  do_el0_svc+0x1c/0x28
  el0_svc+0x3c/0xc4
  el0t_64_sync_handler+0xa0/0xc4
  el0t_64_sync+0x174/0x178
 Code: 5400052c a90153b3 aa0003f3 aa0103f4 (f9401400)
 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Oops: Fatal exception
 SMP: stopping secondary CPUs
 Dumping ftrace buffer:
    (ftrace buffer empty)
 Kernel Offset: 0x384b00c00000 from 0xffff800080000000
 PHYS_OFFSET: 0xffffcc5b80000000
 CPU features: 0x88000203,3c020000,1000421b
 Memory Limit: none
 Rebooting in 1 seconds..

Fixes: 5bdcd5f5331a ("eventfs: Implement removal of meta data from eventfs")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
---
v5:
- Move the ef below dir to keep the "upside-down x-mas tree" format.
v4:
- Not change the returning error code to NULL and simplify the fix.
v3:
- Fix the places where it failed instead of IS_ERR_OR_NULL()
- Update the commit message.
v2:
- Use IS_ERR_OR_NULL() to check instead of IS_ERR() as suggested.
- Update the commit message.
---
 kernel/trace/trace_events.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index ed367d713be0..68b02d6f4fbf 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2297,6 +2297,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 {
 	struct event_subsystem *system, *iter;
 	struct trace_subsystem_dir *dir;
+	struct eventfs_file *ef;
 	int res;
 
 	/* First see if we did not already create this dir */
@@ -2329,13 +2330,14 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
 	} else
 		__get_system(system);
 
-	dir->ef = eventfs_add_subsystem_dir(name, parent);
-	if (IS_ERR(dir->ef)) {
+	ef = eventfs_add_subsystem_dir(name, parent);
+	if (IS_ERR(ef)) {
 		pr_warn("Failed to create system directory %s\n", name);
 		__put_system(system);
 		goto out_free;
 	}
 
+	dir->ef = ef;
 	dir->tr = tr;
 	dir->ref_count = 1;
 	dir->nr_events = 1;
@@ -2415,6 +2417,7 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 	struct trace_event_call *call = file->event_call;
 	struct eventfs_file *ef_subsystem = NULL;
 	struct trace_array *tr = file->tr;
+	struct eventfs_file *ef;
 	const char *name;
 	int ret;
 
@@ -2431,12 +2434,14 @@ event_create_dir(struct dentry *parent, struct trace_event_file *file)
 		return -ENOMEM;
 
 	name = trace_event_name(call);
-	file->ef = eventfs_add_dir(name, ef_subsystem);
-	if (IS_ERR(file->ef)) {
+	ef = eventfs_add_dir(name, ef_subsystem);
+	if (IS_ERR(ef)) {
 		pr_warn("Could not create tracefs '%s' directory\n", name);
 		return -1;
 	}
 
+	file->ef = ef;
+
 	if (call->class->reg && !(call->flags & TRACE_EVENT_FL_IGNORE_ENABLE))
 		eventfs_add_file("enable", TRACE_MODE_WRITE, file->ef, file,
 				  &ftrace_enable_fops);
-- 
2.34.1

