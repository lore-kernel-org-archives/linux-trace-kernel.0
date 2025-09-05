Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF4BEEBD;
	Fri,  5 Sep 2025 03:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757042737; cv=none; b=V0e3IQHKcsFaj+1HmCZCkU0H9cddPNEBUfQUW//tQxj5pZwBOSZRqbmrluplHDekJsgYgxgWGOV5f0AJTfG2DmaCl9QlntUc06oDhF+faWELxP5uOxrLgCLpk39ROQVB6MVJVMB94UrBJm9RZ1ZV5T8eUJKzgnbLkXS83P5u6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757042737; c=relaxed/simple;
	bh=y+c+psw4AkFMd2zCG9/KDIdtVs0a3W/Q+/DG9IdoKCs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qJSsj9l/1ujm+gdA3ZXTyl2YMWe+UEacD2Z1kX443rhI8GXobRfS0rleTaqjz/12qdmocy6vLOJ5GjT6g2ZNTqQgo47mekL6/k1kZg13oBSWkfpFRSBQe1P60mn1vMUPw3t8KUfW9bZ2fjHOtBiKUEn4cGZjOUoNckyRblI3oyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cJ1p505Gfz2CgSb;
	Fri,  5 Sep 2025 11:21:01 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id CC5651401F4;
	Fri,  5 Sep 2025 11:25:30 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 5 Sep
 2025 11:25:29 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <tglozar@redhat.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <linux-trace-kernel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] tracing/osnoise: fix null-ptr-deref in bitmap_parselist
Date: Fri, 5 Sep 2025 11:25:44 +0800
Message-ID: <20250905032544.231962-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500016.china.huawei.com (7.185.36.197)

A crash was observed with the following output:

BUG: kernel NULL pointer dereference, address: 0000000000000010
Oops: Oops: 0000 [#1] SMP NOPTI
CPU: 2 UID: 0 PID: 92 Comm: osnoise_cpus Not tainted 6.17.0-rc4-00201-gd69eb204c255 #138 PREEMPT(voluntary)
RIP: 0010:bitmap_parselist+0x53/0x3e0
Call Trace:
 <TASK>
 osnoise_cpus_write+0x7a/0x190
 vfs_write+0xf8/0x410
 ? do_sys_openat2+0x88/0xd0
 ksys_write+0x60/0xd0
 do_syscall_64+0xa4/0x260
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

This issue can be reproduced by below code:

fd=open("/sys/kernel/debug/tracing/osnoise/cpus", O_WRONLY);
write(fd, "0-2", 0);

When user pass 'count=0' to osnoise_cpus_write(), kmalloc() will return
ZERO_SIZE_PTR (16) and cpulist_parse() treat it as a normal value, which
trigger the null pointer dereference. Add check for the parameter 'count'.

Fixes: 17f89102fe23 ("tracing/osnoise: Allow arbitrarily long CPU string")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 kernel/trace/trace_osnoise.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index fd259da0aa64..edf5178d0317 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2322,6 +2322,9 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	int running, err;
 	char *buf __free(kfree) = NULL;
 
+	if (count < 1)
+		return -EINVAL;
+
 	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-- 
2.33.0

