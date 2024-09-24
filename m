Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A39315884D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171634; cv=none; b=EcZ4ovIuXZb+hTQkZoxPiVZ/hjjMoTvL/hAF3kF4LOJIhOtHOItVNEJHoRRTiWNEW4XRVhZVsY2NK5pLU0xfdNfnP186umRkmmlDxIbNL/fkJOxgYAwOehmIJum1c6arqY+4d0fvSFJZcxA4GEsrUwcc+X6jALwxJEzaNCZlvfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171634; c=relaxed/simple;
	bh=EC8X3+UaNzudnYqucqUr2vw07O9Tg8gwI4s0TE74nUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6yI+QiQ8W93yPpFw86cON+ix7DRCWL5WMWIq8x4bU+tf2Sjr2Ai8gVyf5KxtfNgeNE0CmocpNd5TdJHpVeZB1dFRLfSDCh4/d07cBnVrN8wcn9xBpXoCikEMa3ZhJxMPFuhY8uHJJ0zwgMkHayLknfHKCUS/XYsY5qpjPhNH2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XCZtW358Bz20pNW;
	Tue, 24 Sep 2024 17:53:23 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 93CDC140119;
	Tue, 24 Sep 2024 17:53:43 +0800 (CST)
Received: from ubuntu-20-04.huawei.com (10.175.103.91) by
 kwepemd100024.china.huawei.com (7.221.188.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Sep 2024 17:53:42 +0800
From: Wei Li <liwei391@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>
CC: <linux-trace-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>
Subject: [PATCH 3/5] tracing/timerlat: Fix a race during cpuhp processing
Date: Tue, 24 Sep 2024 17:45:13 +0800
Message-ID: <20240924094515.3561410-4-liwei391@huawei.com>
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

There is another found exception that the "timerlat/1" thread was
scheduled on CPU0, and lead to timer corruption finally:

```
ODEBUG: init active (active state 0) object: ffff888237c2e108 object type: hrtimer hint: timerlat_irq+0x0/0x220
WARNING: CPU: 0 PID: 426 at lib/debugobjects.c:518 debug_print_object+0x7d/0xb0
Modules linked in:
CPU: 0 UID: 0 PID: 426 Comm: timerlat/1 Not tainted 6.11.0-rc7+ #45
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:debug_print_object+0x7d/0xb0
...
Call Trace:
 <TASK>
 ? __warn+0x7c/0x110
 ? debug_print_object+0x7d/0xb0
 ? report_bug+0xf1/0x1d0
 ? prb_read_valid+0x17/0x20
 ? handle_bug+0x3f/0x70
 ? exc_invalid_op+0x13/0x60
 ? asm_exc_invalid_op+0x16/0x20
 ? debug_print_object+0x7d/0xb0
 ? debug_print_object+0x7d/0xb0
 ? __pfx_timerlat_irq+0x10/0x10
 __debug_object_init+0x110/0x150
 hrtimer_init+0x1d/0x60
 timerlat_main+0xab/0x2d0
 ? __pfx_timerlat_main+0x10/0x10
 kthread+0xb7/0xe0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2d/0x40
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
```

After tracing the scheduling event, it was discovered that the migration
of the "timerlat/1" thread was performed during thread creation. Further
analysis confirmed that it is because the CPU online processing for
osnoise is implemented through workers, which is asynchronous with the
offline processing. When the worker was scheduled to create a thread, the
CPU may has already been removed from the cpu_online_mask during the offline
process, resulting in the inability to select the right CPU:

T1                       | T2
[CPUHP_ONLINE]           | cpu_device_down()
osnoise_hotplug_workfn() |
                         |     cpus_write_lock()
                         |     takedown_cpu(1)
                         |     cpus_write_unlock()
[CPUHP_OFFLINE]          |
    cpus_read_lock()     |
    start_kthread(1)     |
    cpus_read_unlock()   |

To fix this, skip online processing if the CPU is already offline.

Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 kernel/trace/trace_osnoise.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index ddc9afb9b7d4..6ed4008e6d62 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2097,6 +2097,8 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 	mutex_lock(&interface_lock);
 	cpus_read_lock();
 
+	if (!cpu_online(cpu))
+		goto out_unlock;
 	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
 		goto out_unlock;
 
-- 
2.25.1

