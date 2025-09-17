Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CFD3195E1;
	Wed, 17 Sep 2025 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113892; cv=none; b=ixzR8R6VDQTxeioPLH1fRiKkF4KXO+SlLC42D589ra3UqGYQi7aTGATZRvmEUFh0LWf7kWu9P78yqMxF3HJRqBMikzCrwH7pLJ6EIYDL08jZbu1norx7u+JN6K9iePV7yV46J+jHpwtkEXkXiz1qQ+JwgzbSct1RoUqdeuAKzTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113892; c=relaxed/simple;
	bh=6xpiu7/YuXxFTFjFUcEaAMXSz9ao5hTEvRWvoz+R0L4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MuQQetJtN8bDFjja4pyMUkWGXwKHJo4oR5zj5ernRvQ/tdCEYSGXglUWwwKokSHt8Pcpu4fJAnOzoQd6vF46dmsaaeHoqVXgqkoQxWMpuY+7hmkeyVwPGEf3dWnnhc9c91ENIUuuEfz/KcbCOYEPDMUEuYo686o+j8PblNs5TCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cRf2Q5h4dzYQv6C;
	Wed, 17 Sep 2025 20:58:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6647E1A116A;
	Wed, 17 Sep 2025 20:58:05 +0800 (CST)
Received: from huaweicloud.com (unknown [7.192.34.199])
	by APP4 (Coremail) with SMTP id gCh0CgC3TYpUsMpoUjRFCw--.43792S2;
	Wed, 17 Sep 2025 20:58:05 +0800 (CST)
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	gmonaco@redhat.com,
	namcao@linutronix.de
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH] rv: Fix boot failure when kernel lockdown is active
Date: Wed, 17 Sep 2025 12:57:33 +0000
Message-ID: <20250917125733.2346923-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3TYpUsMpoUjRFCw--.43792S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1DWr48AryDCF1kCFyDJrb_yoW8uryUpF
	4rG3y3Gr48J3yjvF42krn2kFy5A3WrGF9xCF97CryfAF4DGw4aqFZFqw429F1fKrWrAayS
	vFsFqw4qvay0vw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

From: Xiu Jianfeng <xiujianfeng@huawei.com>

When booting kernel with lockdown=confidentiality parameter, the system
will hang at rv_register_reactor() due to waiting for rv_interface_lock,
as shown in the following log,

INFO: task swapper/0:1 blocked for more than 122 seconds.
      Not tainted 6.17.0-rc6-next-20250915+ #29
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:swapper/0       state:D stack:0     pid:1     tgid:1     ppid:0
Call Trace:
 <TASK>
 __schedule+0x492/0x1600
 schedule+0x27/0xf0
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x538/0x9e0
 ? vprintk+0x18/0x50
 ? _printk+0x5f/0x90
 __mutex_lock_slowpath+0x13/0x20
 mutex_lock+0x3b/0x50
 rv_register_reactor+0x48/0xe0
 ? __pfx_register_react_printk+0x10/0x10
 register_react_printk+0x15/0x20
 do_one_initcall+0x5d/0x340
 kernel_init_freeable+0x351/0x540
 ? __pfx_kernel_init+0x10/0x10
 kernel_init+0x1b/0x200
 ? __pfx_kernel_init+0x10/0x10
 ret_from_fork+0x1fb/0x220
 ? __pfx_kernel_init+0x10/0x10
 ret_from_fork_asm+0x1a/0x30

The root cause is that, when the kernel lockdown is in confidentiality
mode, rv_create_dir(), which is essentially tracefs_create_dir(), will
return NULL. This, in turn, causes create_monitor_dir() to return
-ENOMEM, and finally leading to the mutex not being unlocked.

Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct rv_monitor")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/trace/rv/rv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 1482e91c39f4..e35565dd2dc5 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -805,7 +805,7 @@ int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *parent)
 
 	retval = create_monitor_dir(monitor, parent);
 	if (retval)
-		return retval;
+		goto out_unlock;
 
 	/* keep children close to the parent for easier visualisation */
 	if (parent)
-- 
2.43.0

