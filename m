Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1535214E2F2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 May 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517608; cv=none; b=IoCyywUleLog6t2DCdr6n2dxZRDl8i88Kqaf6tb0Y3ajBrxJYMDWPOsvpWfxpfIILX41Jq2OLBRgYPvVpi9FVrbqkOSOWL8tlzhEOI535/HS7bIiZm8IuDKSwG9/A3xVira9YBU3NgKCFnKJ6wTqgRsVIGOW0RWajgvndgPCA1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517608; c=relaxed/simple;
	bh=Rd02zSSuFk+hbdWBC+6K5Js2vrMxzN+/VXm4vHU2NzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XPUbYghUB8PA2Z7Cq6xHPTqd6vD1FGl89j402uC5oE6w4WleTE8s1ENVHXS7gi4PPyZHmhzftGijpFsImkvze1Ldbn4UtDWSSZMlF5fRHx+cB2nDnXi8WVGR5weTh9xmhnVCa2W4y66ySeLFVXwR9MrCVVvIVzu8PyBzqH07ssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4b7P6Q41RgzYQv8L
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 May 2025 19:19:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A5B861A0C46
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 May 2025 19:19:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl_bQjhoyeN8Nw--.171S5;
	Thu, 29 May 2025 19:19:57 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	linux-trace-kernel@vger.kernel.org
Cc: yebin@huaweicloud.com,
	yebin10@huawei.com
Subject: [PATCH v3 1/2] ftrace: fix UAF when lookup kallsym after ftrace disabled
Date: Thu, 29 May 2025 19:19:54 +0800
Message-Id: <20250529111955.2349189-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529111955.2349189-1-yebin@huaweicloud.com>
References: <20250529111955.2349189-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl_bQjhoyeN8Nw--.171S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWF43Cw4fGFWkJF1DtrWkZwb_yoW5uw4xpr
	yfJrWDCr48JF4qyF4xuw15Ary7t3yjyayUJFn7Gr1Sv3WDGr1jqr1xAF45ZF9rJr48X3sx
	tF1DZw18trW7XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x0JUfDGrUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

There's issue as follows:
BUG: unable to handle page fault for address: ffffffffc05d0218
PGD 1bd66f067 P4D 1bd66f067 PUD 1bd671067 PMD 101808067 PTE 0
Oops: Oops: 0000 [#1] SMP KASAN PTI
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
RIP: 0010:sized_strscpy+0x81/0x2f0
RSP: 0018:ffff88812d76fa08 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffc0601010 RCX: dffffc0000000000
RDX: 0000000000000038 RSI: dffffc0000000000 RDI: ffff88812608da2d
RBP: 8080808080808080 R08: ffff88812608da2d R09: ffff88812608da68
R10: ffff88812608d82d R11: ffff88812608d810 R12: 0000000000000038
R13: ffff88812608da2d R14: ffffffffc05d0218 R15: fefefefefefefeff
FS:  00007fef552de740(0000) GS:ffff8884251c7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffc05d0218 CR3: 00000001146f0000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ftrace_mod_get_kallsym+0x1ac/0x590
 update_iter_mod+0x239/0x5b0
 s_next+0x5b/0xa0
 seq_read_iter+0x8c9/0x1070
 seq_read+0x249/0x3b0
 proc_reg_read+0x1b0/0x280
 vfs_read+0x17f/0x920
 ksys_read+0xf3/0x1c0
 do_syscall_64+0x5f/0x2e0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Above issue may happens as follow:
(1) Add kprobe trace point;
(2) insmod test.ko;
(3) Trigger ftrace disabled;
(4) rmmod test.ko;
(5) cat /proc/kallsyms; --> Will trigger UAF as test.ko already removed;
ftrace_mod_get_kallsym()
...
strscpy(module_name, mod_map->mod->name, MODULE_NAME_LEN);
...

As ftrace_release_mod() judge 'ftrace_disabled' is true will return,
and 'mod_map' will remaining in ftrace_mod_maps. 'mod_map' has no
chance to release. Therefore, this also causes residual resources to
accumulate. To solve above issue, unconditionally clean up'mod_map'.
Of course, the root cause of this problem is the presence of
ftrace_disabled. The fixes tags patch introduces the possibility of
residual resources in the case of ftrace_disabled. The root cause of
the problem is ftrace_disabled. This patch only adds protection when
ftrace_disabled occurs.

Fixes: aba4b5c22cba ("ftrace: Save module init functions kallsyms symbols for tracing")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 kernel/trace/ftrace.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a3d4dfad0cbc..4f9677141d03 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7438,9 +7438,10 @@ void ftrace_release_mod(struct module *mod)
 
 	mutex_lock(&ftrace_lock);
 
-	if (ftrace_disabled)
-		goto out_unlock;
-
+	/*
+	 * To avoid the UAF problem after the module is unloaded, the
+	 * 'mod_map' resource needs to be released unconditionally.
+	 */
 	list_for_each_entry_safe(mod_map, n, &ftrace_mod_maps, list) {
 		if (mod_map->mod == mod) {
 			list_del_rcu(&mod_map->list);
@@ -7451,6 +7452,9 @@ void ftrace_release_mod(struct module *mod)
 		}
 	}
 
+	if (ftrace_disabled)
+		goto out_unlock;
+
 	/*
 	 * Each module has its own ftrace_pages, remove
 	 * them from the list.
-- 
2.34.1

