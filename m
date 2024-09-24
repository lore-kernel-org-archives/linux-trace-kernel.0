Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5B6482D8
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171632; cv=none; b=AIt8OghAPWjTruQrVSG0i5Pfg1NyZiPUHaYE8kOg+mB0FZrY7MNVZ3chbMMYOKaUNZk8CUrvf5/agRVB4/9XhKtsscSJqnIAZBix8Lt8xnKrs45n3GT0TC/3mDuavHr1I4scIx0k/Tl5zL2OGgZ122Mb0x0thbU+/umQQBT/7m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171632; c=relaxed/simple;
	bh=0Ui2ljAR/w50xPuEf3VpL87GSUBeC8ecWbJvjJ8Gd4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzXIPY3zG6chhTBOjMSyYs6X1f9nzQmOBgVxDpItbD2q06FCIym+yBfi3lDL7joQQJBNcR+YgTQKvcq3bBW/TSC7Hn5RSWG2cNipJvNUaGNZ8gYCf8I9Xj5MUaGbh8/JcOFNChPT2MGTWS2SrYNwnpqqp/UUJ5+y/kmo0aoCs30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XCZsl0Bc9zySBd;
	Tue, 24 Sep 2024 17:52:43 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id EB09D140393;
	Tue, 24 Sep 2024 17:53:42 +0800 (CST)
Received: from ubuntu-20-04.huawei.com (10.175.103.91) by
 kwepemd100024.china.huawei.com (7.221.188.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Sep 2024 17:53:42 +0800
From: Wei Li <liwei391@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>
CC: <linux-trace-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>
Subject: [PATCH 2/5] tracing/timerlat: Drop interface_lock in stop_kthread()
Date: Tue, 24 Sep 2024 17:45:12 +0800
Message-ID: <20240924094515.3561410-3-liwei391@huawei.com>
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

stop_kthread() is the offline callback for "trace/osnoise:online", since
commit 5bfbcd1ee57b ("tracing/timerlat: Add interface_lock around clearing
of kthread in stop_kthread()"), the following ABBA deadlock scenario is
introduced:

T1                            | T2 [BP]               | T3 [AP]
osnoise_hotplug_workfn()      | work_for_cpu_fn()     | cpuhp_thread_fun()
                              |   _cpu_down()         |   osnoise_cpu_die()
  mutex_lock(&interface_lock) |                       |     stop_kthread()
                              |     cpus_write_lock() |       mutex_lock(&interface_lock)
  cpus_read_lock()            |     cpuhp_kick_ap()   |

As the interface_lock here in just for protecting the "kthread" field of
the osn_var, use xchg() instead to fix this issue. Also use
for_each_online_cpu() back in stop_per_cpu_kthreads() as it can take
cpu_read_lock() again.

Fixes: 5bfbcd1ee57b ("tracing/timerlat: Add interface_lock around clearing of kthread in stop_kthread()")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 kernel/trace/trace_osnoise.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 934a14bc72e6..ddc9afb9b7d4 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1953,12 +1953,8 @@ static void stop_kthread(unsigned int cpu)
 {
 	struct task_struct *kthread;
 
-	mutex_lock(&interface_lock);
-	kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
+	kthread = xchg_relaxed(&(per_cpu(per_cpu_osnoise_var, cpu).kthread), NULL);
 	if (kthread) {
-		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
-		mutex_unlock(&interface_lock);
-
 		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask) &&
 		    !WARN_ON(!test_bit(OSN_WORKLOAD, &osnoise_options))) {
 			kthread_stop(kthread);
@@ -1972,7 +1968,6 @@ static void stop_kthread(unsigned int cpu)
 			put_task_struct(kthread);
 		}
 	} else {
-		mutex_unlock(&interface_lock);
 		/* if no workload, just return */
 		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
 			/*
@@ -1994,8 +1989,12 @@ static void stop_per_cpu_kthreads(void)
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	cpus_read_lock();
+
+	for_each_online_cpu(cpu)
 		stop_kthread(cpu);
+
+	cpus_read_unlock();
 }
 
 /*
-- 
2.25.1

