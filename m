Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECF122D4FF;
	Tue, 16 Sep 2025 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758003523; cv=none; b=DfUkswng7bj0PWcOyyKKG+qh1kNBv2TBVgAT8DOQjIG3NNeEH84osBLLoLmcNdSw/vbeydqWwe2gj8N4SGWOLwjHBIjYDhR9F8kt9QMSBzuWmIn1SP7rCIWGHljlekAVdxDt18SxFe9ReyQv75jL2K4FJbpq3ib+K1tBCqtlIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758003523; c=relaxed/simple;
	bh=DLpDdET4T6+Aw1hNjsryWVaNM/7lFQaDmC3nSTBUlas=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fNEJ4wCOP8vW0UmTzolzBm3daZFBiroaIhgQeVwmJvdHxJa4piYhyyFNsOBpx3BLufj6Z6bwjtuLlgtmE9bBeHOqPZjLaf+ezu69YoM89dpJP0RZ2ucUfiNQy393HVm0hhuroc21/ge71t0YpV9sIYkLY9K3Z2nReZjzRLRZ5vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cQsBl1Cp1ztTlB;
	Tue, 16 Sep 2025 14:17:35 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 54F991402DA;
	Tue, 16 Sep 2025 14:18:29 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 14:18:27 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <tglozar@redhat.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
Subject: [PATCH] tracing/osnoise: Fix slab-out-of-bounds in _parse_integer_limit()
Date: Tue, 16 Sep 2025 14:39:48 +0800
Message-ID: <20250916063948.3154627-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500016.china.huawei.com (7.185.36.197)

When config osnoise cpus by write() syscall, the following KASAN splat may
be observed:

BUG: KASAN: slab-out-of-bounds in _parse_integer_limit+0x103/0x130
Read of size 1 at addr ffff88810121e3a1 by task test/447
CPU: 1 UID: 0 PID: 447 Comm: test Not tainted 6.17.0-rc6-dirty #288 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x55/0x70
 print_report+0xcb/0x610
 kasan_report+0xb8/0xf0
 _parse_integer_limit+0x103/0x130
 bitmap_parselist+0x16d/0x6f0
 osnoise_cpus_write+0x116/0x2d0
 vfs_write+0x21e/0xcc0
 ksys_write+0xee/0x1c0
 do_syscall_64+0xa8/0x2a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

This issue can be reproduced by below code:

const char *cpulist = "1";
int fd=open("/sys/kernel/debug/tracing/osnoise/cpus", O_WRONLY);
write(fd, cpulist, strlen(cpulist));

Function bitmap_parselist() was called to parse cpulist, it require that
the parameter 'buf' must be terminated with a '\0' or '\n'. Fix this issue
by adding a '\0' to 'buf' in osnoise_cpus_write().

Fixes: 17f89102fe23 ("tracing/osnoise: Allow arbitrarily long CPU string")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 kernel/trace/trace_osnoise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 337bc0eb5d71..dc734867f0fc 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2325,12 +2325,13 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	if (count < 1)
 		return 0;
 
-	buf = kmalloc(count, GFP_KERNEL);
+	buf = kmalloc(count + 1, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	if (copy_from_user(buf, ubuf, count))
 		return -EFAULT;
+	buf[count] = '\0';
 
 	if (!zalloc_cpumask_var(&osnoise_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
-- 
2.34.1

