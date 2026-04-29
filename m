Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EFA388375;
	Wed, 29 Apr 2026 03:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777433417; cv=none; b=Wp2bHOH8KB3L9dhW+QbgLZFXFYBxIUEFN0KjN33JSUwdUjhfnlDPYbCVyVVXdDrO9MaHSdptQ0QWvX8ElmoGbvFzQ6y3cYi+2o1jgFRuwzepKd6XzYxrORtiZ3cqZzpldviwxOq51F1jqJN0aTyPg2SLWdkB1K+aFQDJstFftpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777433417; c=relaxed/simple;
	bh=kRxU95rJ3DV180R82N+DoVhtICDfmhpX/oAxsPmWWko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FKHb5WGclW/z3tNoai0YwfbvRx+qpNphTn2g9xElt3tE1f1RYLCZUcNuTyHUl7+zsnDfOI0NCXi1HvIQLpmmpy7adbJ9YR0pNTjGSLTB5bI8JrLOTHSWSVtpLC1aL8Iy5DgYUzIBP72gu3RwrjM+fuojQThodWRwruBNfeHHs6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=RKW7OaWT; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="RKW7OaWT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1777433377;
	bh=hZfys6wjgVGxU4fmAUhen7VpMWxrBduRVJYf6Kph8IU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=RKW7OaWTV+lURvim9k+4fMHkuJHBei6slQKUfXnoOjjd0A8C+zaA4hT2puuMLynuB
	 UW7lIi3Didxk5FH8HTI8n7XzUOAxqSq3owALavdsBntm3WoeJB8EW7SZtC7lM61uzL
	 V6mWiJG4HtTURkavIBkno5h/ZIUf+tf+62fXgPWU=
X-QQ-mid: zesmtpip4t1777433372te02a7186
X-QQ-Originating-IP: GKJiPLjuF3aBqjXU0f3x2P1ZyO8Lv6Y2U/hPFIY2sJU=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Apr 2026 11:29:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14940813661177981426
EX-QQ-RecipientCnt: 8
From: Shijia Hu <hushijia1@uniontech.com>
To: mhiramat@kernel.org,
	naveen@kernel.org,
	davem@davemloft.net
Cc: ananth@in.ibm.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	hushijia1@uniontech.com
Subject: [PATCH] kprobes: Remove dead child probes from aggrprobe list on module unload
Date: Wed, 29 Apr 2026 11:29:19 +0800
Message-Id: <20260429032919.208790-1-hushijia1@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MC+kTSDGUQEXZUQKDod+XqgM72ORVuEA2WdiH6ppyQplAcEcHU8mv43W
	Gl0DhOMlHcCIMcnqOyAusIm+JeAdr4GduSCCjVGIQjim9Xv0yaHyJGVdPFuezfK38Y+rXXR
	SiR3MT5+2ZfUWcGKZEqqs2nTI7anvCXPGWyUmEBXcBbzbyy/4V4pP7B2bj4WPccf0qDQ3F7
	CdCdJX0eRPkDZjBHU+k1bs3tqiN6Gswr0fy2qHo0NdDVw5t05wZmh8UyAyLB2GygQPvViBs
	0gvSv8M7vSBGtHuddicIGgzvTNl1tWfYIYZXdnLc0uKvX89Y6apa8CEw/oAzE2gWPM3tVB5
	IT+uAk3uy8SiL4c0RQfmZHy5sJkxBerQ9TJ+AQV+/Dyta9LsC11HroMicTE6ZkZHgGHbuGq
	gxTrrjFSjxu9h5QSVNc3zyqjS0CnJR0/fCbQo3prcKk6aGXDQMR/5PSTCbbjtLy2hWsgqtw
	0KBm73Y7paK9lglftphuAYcWX6mh5Fwk7FaK/3FwS1bj/T1Hh/2ZGV3jwoJcSPmjOzuYCOJ
	1/kRPzunwWNjtxzf6rt3/UBMW2zMXw9n4/SzQyuE53jDr50yc4HbUUo7ILRx9i7Lt/Wwx3Y
	M0MHMGpzAvRW2NHCX36WxfsX/kYjhMGCPyrsKUBdRimN5hMDF72HjD3x/XDIBqUpjpaR5P7
	nEGCNfOp9xx6oPP/zWEqcrA6dwlwK2ope9/thxGrCKGnDDfKN9zurJiZkRkXO/khEK4QcqO
	tfErR/QDrGMWB3mhl7EUdChSudcx7OznBHZTzkzI6sHqO4m39chwLjWYYk3SYOeDO1dO3y9
	rR1pxXxPSbtfaQeok3eCA47KF452xZgMXSAOI0B8r+x9loQkPpqo5QLymDioiKbb2d49X6r
	FFMexFquNvyj05VENg9v2lFJ+60XgIx6SUjLP/zGNdGOAdu/Ck542HXoXvaNjkxDN0ds1vn
	4z2NSb1HzWpYiY1dAWmUfoonpcndaBBU4/shA8SW5xPBMLTC0K1N4DzenpMPrH4+Z2NzBTe
	k/AqoL4w==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

When a kernel module that registered kprobes is unloaded without calling
unregister_kprobe(), kprobes_module_callback() calls kill_kprobe() to
mark the probe(s) GONE.  If the probe is an aggrprobe, kill_kprobe()
also marks all child probes GONE, but it does not remove them from
the aggrprobe's list.

The problem is that child probes whose struct kprobe resides in the
unloading module's memory are freed along with the module, yet they
remain on the aggrprobe's list.  Later, when another caller registers
a kprobe at the same address, __get_valid_kprobe() walks that list
and dereferences the freed child probe, causing a use-after-free.

Reproduction steps:

    1) Load module A which registers two kprobes on the same kernel
       function address (e.g., do_nanosleep), causing them to be
       aggregated under one aggrprobe.

    2) Unload module A without calling unregister_kprobe().
       Module A's memory is freed, but its two child probes remain
       on the aggrprobe's list as dangling pointers.

    3) Load module B and register a kprobe on the same address
       (e.g., do_nanosleep). register_kprobe() -> __get_valid_kprobe()
       traverses the aggrprobe's list and dereferences the freed child
       probe from module A, triggering a use-after-free and kernel panic.

The resulting crash looks like:
    [  464.950864] BUG: kernel NULL pointer dereference, address: 0000000000000000
    [  464.950872] #PF: supervisor read access in kernel mode
    [  464.950874] #PF: error_code(0x0000) - not-present page
    ...
    [  464.950915] Call Trace:
    [  464.950922]  <TASK>
    [  464.950923]  register_kprobe+0x65/0x2e0
    [  464.950928]  ? __pfx_stage2_init+0x10/0x10 [kprobe_leak_stage2]
    [  464.950933]  stage2_init+0x37/0xff0 [kprobe_leak_stage2]
    [  464.950938]  ? __pfx_stage2_init+0x10/0x10 [kprobe_leak_stage2]
    [  464.950942]  do_one_initcall+0x56/0x2e0
    [  464.950948]  do_init_module+0x60/0x230
    ...

  Fix this by adding selective cleanup in kprobes_module_callback():
  after calling kill_kprobe() on the aggrprobe, iterate its child list
  and remove any child probe whose struct kprobe is inside the going
  module's memory range (within_module_init / within_module_core).

  This is done in kprobes_module_callback() rather than kill_kprobe()
  because kill_kprobe()'s semantic is "the probed code is going away,
  mark probes GONE".  The lifetime of a probe is bound to the probed
  code, not to the module containing the struct kprobe.  Child probes
  owned by other still-loaded modules or by kmalloc (ftrace, perf,
  kprobe-events) must stay on the list so they can be unregistered
  later.  Only child probes whose memory is about to be freed need to
  be removed from the list to prevent dangling pointers.

Fixes: e8386a0cb22f4 ("kprobes: support probing module __exit function")
Signed-off-by: Shijia Hu <hushijia1@uniontech.com>
---
 kernel/kprobes.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index bfc89083daa9..ff277314183c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2664,6 +2664,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
 				   unsigned long val, void *data)
 {
 	struct module *mod = data;
+	struct hlist_node *tmp;
 	struct hlist_head *head;
 	struct kprobe *p;
 	unsigned int i;
@@ -2685,7 +2686,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	 */
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
-		hlist_for_each_entry(p, head, hlist)
+		hlist_for_each_entry_safe(p, tmp, head, hlist) {
 			if (within_module_init((unsigned long)p->addr, mod) ||
 			    (checkcore &&
 			     within_module_core((unsigned long)p->addr, mod))) {
@@ -2702,6 +2703,26 @@ static int kprobes_module_callback(struct notifier_block *nb,
 				 */
 				kill_kprobe(p);
 			}
+
+			/*
+			 * Child probes are not on the kprobe hash list, so
+			 * the above loop can not find them. If a child probe
+			 * is allocated in the module's memory, it will become
+			 * a dangling pointer after the module is freed.
+			 */
+			if (kprobe_aggrprobe(p)) {
+				struct kprobe *kp, *kptmp;
+
+				list_for_each_entry_safe(kp, kptmp, &p->list, list) {
+					if (within_module_init((unsigned long)kp, mod) ||
+					    (checkcore &&
+					     within_module_core((unsigned long)kp, mod))) {
+						kp->flags |= KPROBE_FLAG_GONE;
+						list_del_rcu(&kp->list);
+					}
+				}
+			}
+		}
 	}
 	if (val == MODULE_STATE_GOING)
 		remove_module_kprobe_blacklist(mod);
-- 
2.20.1

