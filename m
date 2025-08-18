Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056426B942;
	Mon, 18 Aug 2025 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503525; cv=none; b=th24gNffq93OzLewDs3LI/ox6HJXONoR//C1iEWLQ2v3LztmIidqvVfrP+08pwZFSXB7Lz65ExGZI9+isq123C2JPZbIsLe+1AwXeI1otb33EeXOXQTBraOspvqpp8T3WFAgaQ+lES5PvZkrIYLTkXE78Q4Cc6d2EqAHwpYEVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503525; c=relaxed/simple;
	bh=z2smK6xAm8mG+5SS7qS5KBINR52sJGF/BRqzgrG3g0o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KkirnP5pGNYE7JnLXHPwqMblr8mgSodXC90VnwAXJ5WCYnV0ePv3HYNpBgrjH8khGyZiAaKX/gsLS1haH6Uv+ELa1+5c2raAb4Bp5vI0cD/JERhKwNdMUXdZIS03SPjCCNjqgII/yCI8EIF0i2rt44JT9XLpG4+SHjuiU9JIBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c54Z26421z2CgD4;
	Mon, 18 Aug 2025 15:47:38 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id AA3C21A016C;
	Mon, 18 Aug 2025 15:52:00 +0800 (CST)
Received: from kwepemn100005.china.huawei.com (7.202.194.108) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 15:52:00 +0800
Received: from huawei.com (10.67.174.49) by kwepemn100005.china.huawei.com
 (7.202.194.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Aug
 2025 15:51:59 +0800
From: Ye Weihua <yeweihua4@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ye Weihua <yeweihua4@huawei.com>
Subject: [PATCH -next] trace/fgraph: Fix the warning caused by missing unregister notifier
Date: Mon, 18 Aug 2025 07:33:32 +0000
Message-ID: <20250818073332.3890629-1-yeweihua4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100005.china.huawei.com (7.202.194.108)

This warning was triggered during testing on v6.16:

notifier callback ftrace_suspend_notifier_call already registered
WARNING: CPU: 2 PID: 86 at kernel/notifier.c:23 notifier_chain_register+0x44/0xb0
...
Call Trace:
 <TASK>
 blocking_notifier_chain_register+0x34/0x60
 register_ftrace_graph+0x330/0x410
 ftrace_profile_write+0x1e9/0x340
 vfs_write+0xf8/0x420
 ? filp_flush+0x8a/0xa0
 ? filp_close+0x1f/0x30
 ? do_dup2+0xaf/0x160
 ksys_write+0x65/0xe0
 do_syscall_64+0xa4/0x260
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

When writing to the function_profile_enabled interface, the notifier was
not unregistered after start_graph_tracing failed, causing a warning the
next time function_profile_enabled was written.

Fixed by adding unregister_pm_notifier in the exception path.

Fixes: 4a2b8dda3f870 ("tracing/function-graph-tracer: fix a regression while suspend to disk")
Signed-off-by: Ye Weihua <yeweihua4@huawei.com>
---
 kernel/trace/fgraph.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index c5b207992fb4..dac2d58f3949 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1391,10 +1391,11 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 error:
 	if (ret) {
 		ftrace_graph_active--;
 		gops->saved_func = NULL;
 		fgraph_lru_release_index(i);
+		unregister_pm_notifier(&ftrace_suspend_notifier);
 	}
 	return ret;
 }
 
 void unregister_ftrace_graph(struct fgraph_ops *gops)
-- 
2.34.1

