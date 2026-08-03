Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86B2690F9;
	Mon,  3 Aug 2026 00:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785718621; cv=none; b=B+VNWg/nvuHBTanp86SY2jnjRFrort1cdzQeJezafK49nGqzJc0do3WEJvo6jigFoAsND3aReMMvyDBSkn2zg5+eBiwLQS+5W9wDx2pAV7V05JZMuc5GrNjcouIiBeS0JiWp8t7e5XylyZZC6UL83rUiSGPUWyZGgJkpcKOKxEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785718621; c=relaxed/simple;
	bh=f9DIpOK3yvIQ3v+m4aMsiQtWSsORErWymMOLj90vUWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PybI+h+1mDEBwf8TBmX8ofIAJADY/+GxYpHm+FqQLb4xL3wISLTUG0kUnXuZZbDs04ekIrvpAAwz/SvtZgk2hF1ofJ0Rbm8wzQUvp11v3Lt8Ol41KGGi/wc/3vOPJFjbwndff38ElPrrQyHTmdImnPP9PdZm3zl5e9AjldJc/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hCytW71L6zKHMRV;
	Mon,  3 Aug 2026 08:56:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2F6A54058C;
	Mon,  3 Aug 2026 08:56:54 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3s0JO529qhaulAw--.212S4;
	Mon, 03 Aug 2026 08:56:54 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v2 2/2] tracing/snapshot: Use work_on_cpu to avoid -EBUSY during snapshot swap
Date: Mon,  3 Aug 2026 00:56:40 +0000
Message-Id: <20260803005640.2445666-3-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803005640.2445666-1-wutengda@huaweicloud.com>
References: <20260803005640.2445666-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3s0JO529qhaulAw--.212S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4fCw4fJF1xAF4fWry3Jwb_yoW8Ww4kpr
	4agas7Cr45Ar40v3yxuan7Z34FqrZ5Gry7Cr4DCa1fZwn8AFyYqw1vg3ZFqa4jkrWDK39F
	yrWjyFWrJF42vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r
	1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUULZ2DUUUUU=
	=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The snapshot operation currently uses smp_call_function_single() to
invoke ring_buffer_swap_cpu() on the target CPU. Since interrupt can hit
at any point during the write path, this may return -EBUSY if the target
CPU is actively writing to the buffer, which could be confusing to users
who may not understand the internal state of the ring buffer.

Replace smp_call_function_single() with work_on_cpu() for the snapshot
operation. This ensures that the swap only occurs after the ongoing
write completes.

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 kernel/trace/trace_snapshot.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_snapshot.c b/kernel/trace/trace_snapshot.c
index 07b43c9863a2..22323c97289b 100644
--- a/kernel/trace/trace_snapshot.c
+++ b/kernel/trace/trace_snapshot.c
@@ -625,9 +625,12 @@ static int tracing_snapshot_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
-static void tracing_swap_cpu_buffer(void *tr)
+static long tracing_swap_cpu_buffer(void *tr)
 {
+	local_irq_disable();
 	update_max_tr_single((struct trace_array *)tr, current, smp_processor_id());
+	local_irq_enable();
+	return 0;
 }
 
 static ssize_t
@@ -689,8 +692,7 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 			update_max_tr(tr, current, smp_processor_id(), NULL);
 			local_irq_enable();
 		} else {
-			smp_call_function_single(iter->cpu_file, tracing_swap_cpu_buffer,
-						 (void *)tr, 1);
+			work_on_cpu(iter->cpu_file, tracing_swap_cpu_buffer, (void *)tr);
 		}
 		tracing_disarm_snapshot(tr);
 		break;
-- 
2.34.1

