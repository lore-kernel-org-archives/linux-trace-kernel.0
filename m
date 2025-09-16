Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47DB2BAF9;
	Tue, 16 Sep 2025 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008221; cv=none; b=PNVVhklWQgpjD8ACP3cRIPmc0bZ+NWtWzIa5aRWaSnjvrx5KHdOOuvvs6Nl2xztELCgQetryHC/MPoLJRmjm2bGvt9bHvyQhyLqq2l3n+qBwUbEGVgwMD/jdMdcrbFHQJwuFQ8+hVGaDCaAxFo4ICjrlpdoiNsd+m4lsSHqKRQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008221; c=relaxed/simple;
	bh=b4OeSCl29HONl5UBPCi3FIROtsnKS+fun4HjlkLLvQw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dRdVUg0U6gT55aZc8L9kCNSNl9HC3ySp/HjXG2SD8bfg7rHGQfNU0OJKranXEmnvkKrTcTvXlPW9HznmWgUy10c/zxkpolLaGZlJgBOYaIwsCRVEWeqbTItuWepKFo8oywIpXLsmeWAROHBNOrmA9yTOppHCJGx9yqERmOs1yI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cQtrx6zsnzFrdf;
	Tue, 16 Sep 2025 15:32:17 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D3FD140275;
	Tue, 16 Sep 2025 15:36:55 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 15:36:54 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
Subject: [PATCH] tracing: kprobe-event: Fix null-ptr-deref in trace_kprobe_create_internal()
Date: Tue, 16 Sep 2025 15:58:16 +0800
Message-ID: <20250916075816.3181175-1-wangliang74@huawei.com>
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

A crash was observed with the following output:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 2899 Comm: syz.2.399 Not tainted 6.17.0-rc5+ #5 PREEMPT(none)
RIP: 0010:trace_kprobe_create_internal+0x3fc/0x1440 kernel/trace/trace_kprobe.c:911
Call Trace:
 <TASK>
 trace_kprobe_create_cb+0xa2/0xf0 kernel/trace/trace_kprobe.c:1089
 trace_probe_create+0xf1/0x110 kernel/trace/trace_probe.c:2246
 dyn_event_create+0x45/0x70 kernel/trace/trace_dynevent.c:128
 create_or_delete_trace_kprobe+0x5e/0xc0 kernel/trace/trace_kprobe.c:1107
 trace_parse_run_command+0x1a5/0x330 kernel/trace/trace.c:10785
 vfs_write+0x2b6/0xd00 fs/read_write.c:684
 ksys_write+0x129/0x240 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x5d/0x2d0 arch/x86/entry/syscall_64.c:94
 </TASK>

Function kmemdup() may return NULL in trace_kprobe_create_internal(), add
check for it's return value.

Fixes: 33b4e38baa03 ("tracing: kprobe-event: Allocate string buffers from heap")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 kernel/trace/trace_kprobe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index ccae62d4fb91..fa60362a3f31 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -908,6 +908,8 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
 			return -EINVAL;
 		}
 		buf = kmemdup(&argv[0][1], len + 1, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
 		buf[len] = '\0';
 		ret = kstrtouint(buf, 0, &maxactive);
 		if (ret || !maxactive) {
-- 
2.34.1

