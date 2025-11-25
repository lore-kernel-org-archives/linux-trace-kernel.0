Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9877A2AF1D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764036344; cv=none; b=YLst6uKwBqw5/xpe40bw8N1Gpls0f0uN4rIy+5HgCD+DCXhrkZhQLr5NP3hj8RGHSIqa0JrW6DWswmKeufiC4Rk8xk1vByEOQyZgnh3YCqGqrmb/MWDL15kDBlZc0RiwYrPTL4go+NIICv5N98jR4bJRDLcTUfyH2W9mYuGfv7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764036344; c=relaxed/simple;
	bh=dZjXvJnibtItwWIioXjKcotY09LQeM55ul7U6W69Zuk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E1jFVxZwIaiu/4nhk+CBmR+uwiCQZ7NsuN1pzpRr+Zyol4kqBFJlC3kTF3dKLJa1rBuXUzVLyEJm5kOsnpoXLpvmxz7Ce787W+l/TiV+//p4CXA0IvO/CgfpiLDgbZlPayBz5+gKABZ9771vl0/KUIO3efO2JaJHqDrRFWTQyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dFmH13PBbzKHMK9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 10:05:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0F6C31A0E52
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 10:05:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP2 (Coremail) with SMTP id Syh0CgCH5XvwDiVp6nSyBw--.36038S4;
	Tue, 25 Nov 2025 10:05:37 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: naveen@kernel.org,
	davem@davemloft.net,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: yebin@huaweicloud.com,
	yebin10@huawei.com
Subject: [PATCH] kprobes: avoid crash when rmmod/insmod modules after ftrace_disabled
Date: Tue, 25 Nov 2025 10:05:36 +0800
Message-Id: <20251125020536.2484381-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCH5XvwDiVp6nSyBw--.36038S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyUWw17tryrCFy5WFWUCFg_yoW5Xw1fpr
	yDJ3y5Gr48XF1avFW7Aw45Jr1Fkr4xAay7Jrn7Wr1rA3WDG34UWr1xJ3y5XF98Wr4jqry3
	Jrn8Xr40grZxJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

There's a issue as follows when rmmod modules after ftrace disabled:
BUG: unable to handle page fault for address: fffffbfff805000d
PGD 817fcc067 P4D 817fcc067 PUD 817fc8067 PMD 101555067 PTE 0
Oops: Oops: 0000 [#1] SMP KASAN PTI
CPU: 4 UID: 0 PID: 2012 Comm: rmmod Tainted: G        W  OE
Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
RIP: 0010:kprobes_module_callback+0x89/0x790
RSP: 0018:ffff88812e157d30 EFLAGS: 00010a02
RAX: 1ffffffff805000d RBX: dffffc0000000000 RCX: ffffffff86a8de90
RDX: ffffed1025c2af9b RSI: 0000000000000008 RDI: ffffffffc0280068
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed1025c2af9a
R10: ffff88812e157cd7 R11: 205d323130325420 R12: 0000000000000002
R13: ffffffffc0290488 R14: 0000000000000002 R15: ffffffffc0280040
FS:  00007fbc450dd740(0000) GS:ffff888420331000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff805000d CR3: 000000010f624000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 notifier_call_chain+0xc6/0x280
 blocking_notifier_call_chain+0x60/0x90
 __do_sys_delete_module.constprop.0+0x32a/0x4e0
 do_syscall_64+0x5d/0xfa0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The above issue occurs because the kprobe was not removed from the hash
list after ftrace_disable.
To prevent the system from restarting unexpectedly after ftrace_disable,
in such cases, unregister_kprobe() ensures that the probe is removed from
the hash list, preventing subsequent access to already freed memory.

Fixes: 6f0f1dd71953 ("kprobes: Cleanup disabling and unregistering path")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/kprobes.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ab8f9fc1f0d1..d735a608b810 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1731,8 +1731,30 @@ static int __unregister_kprobe_top(struct kprobe *p)
 
 	/* Disable kprobe. This will disarm it if needed. */
 	ap = __disable_kprobe(p);
-	if (IS_ERR(ap))
-		return PTR_ERR(ap);
+	if (IS_ERR(ap)) {
+		int ret = PTR_ERR(ap);
+
+		/*
+		 * If ftrace disabled we need to delete kprobe node from
+		 * hlist or aggregation list. If nodes are not removed when
+		 * modules are removed, the already released nodes will
+		 * remain in the linked list. Subsequent access to the
+		 * linked list may then trigger exceptions.
+		 */
+		if (ret != -ENODEV)
+			return ret;
+
+		ap = __get_valid_kprobe(p);
+		if (!ap)
+			return ret;
+
+		if (ap == p)
+			hlist_del_rcu(&ap->hlist);
+		else
+			list_del_rcu(&p->list);
+
+		return ret;
+	}
 
 	WARN_ON(ap != p && !kprobe_aggrprobe(ap));
 
-- 
2.34.1

