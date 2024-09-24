Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1181482D8
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171634; cv=none; b=U8B6rcjuR2q6MvBHtaJuZwttzeW2bUS7pqETpTD+NOLbx/XYVKldS9HbxSrLSr6AQWhkNmXAg2SMEZBmy4fRBD1oon0V+bFGGbHPb7JXZaM19zY6+TUUi3IyxfTeKpRqk0RXoOfU3vzUH+pHR9/yqioeEVbwg8UERxaYV9wKXrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171634; c=relaxed/simple;
	bh=pHR0UkvKEGYhOkAyV8FTZLacUpWReaRNRwQOAV91g5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcZf/4A8fNo7kDONPZ3AIEOKdjyA5iql79Uqm5wKMMCSUV1EdXHbnfRvzEJrzHZNKyp5yuv4gyD4upXVRnz8VXoE687hdZgxuYYL7q4gYshEwsrO4wVKPEEygEP3T+MUpunOQWQmz/E0o4VL5k2X2kvhRFWpUUhIAqmuQk/VLSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XCZtX3l51zQrQZ;
	Tue, 24 Sep 2024 17:53:24 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id DF6AF180087;
	Tue, 24 Sep 2024 17:53:44 +0800 (CST)
Received: from ubuntu-20-04.huawei.com (10.175.103.91) by
 kwepemd100024.china.huawei.com (7.221.188.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Sep 2024 17:53:44 +0800
From: Wei Li <liwei391@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>
CC: <linux-trace-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>
Subject: [PATCH 5/5] tracing/hwlat: Fix deadlock in cpuhp processing
Date: Tue, 24 Sep 2024 17:45:15 +0800
Message-ID: <20240924094515.3561410-6-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240924094515.3561410-1-liwei391@huawei.com>
References: <20240924094515.3561410-1-liwei391@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100024.china.huawei.com (7.221.188.41)

Another "hung task" error was reported during the test, and i figured out
the deadlock scenario is as follows:

T1 [BP]               | T2 [AP]                     | T3 [hwlatd/1]                  | T4
work_for_cpu_fn()     | cpuhp_thread_fun()          | kthread_fn()                   | hwlat_hotplug_workfn()
  _cpu_down()         |   stop_cpu_kthread()        |                                |   mutex_lock(&hwlat_data.lock)
    cpus_write_lock() |     kthread_stop(hwlatd/1)  |   mutex_lock(&hwlat_data.lock) |
    __cpuhp_kick_ap() |       wait_for_completion() |                                |   cpus_read_lock()

It constitutes ABBA deadlock indirectly between "cpu_hotplug_lock" and
"hwlat_data.lock", make the mutex obtaining in kthread_fn() interruptible
to fix this.

Fixes: ba998f7d9531 ("trace/hwlat: Support hotplug operations")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 kernel/trace/trace_hwlat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 3bd6071441ad..4c228ccb8a38 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -370,7 +370,8 @@ static int kthread_fn(void *data)
 		get_sample();
 		local_irq_enable();
 
-		mutex_lock(&hwlat_data.lock);
+		if (mutex_lock_interruptible(&hwlat_data.lock))
+			break;
 		interval = hwlat_data.sample_window - hwlat_data.sample_width;
 		mutex_unlock(&hwlat_data.lock);
 
-- 
2.25.1

