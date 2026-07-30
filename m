Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78B274FE3;
	Thu, 30 Jul 2026 01:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374378; cv=none; b=VZLewB7uIanfNxzlYZhNyaaH5xCC47nZD0r0vCBwNQr8BKHaYkssStdD1YNWmahVkqoBWw7TjoXocy71T1KnAqds3/6LbrzgLrKlgPGQdDa3vJu97i4xdpAqVRLqBpVM9cTsoxV9Ww5+PX72MxEb4L379AdSv2LWO7YkQ7RBYmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374378; c=relaxed/simple;
	bh=p9NlAKgMlFRB0/sfUgbU8JqwmI99F/0uYxlSs5Aph8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=isR0kZY81oT4GpIGrfyDg/vge0yeAw9y67fKwQKGVYxhYuDYg9eQEq3OoDHmSxVhxtBqWWr3td8rufawdOravABhgS2pyfWQAf+pk8tPa8aZ4kjMtA7yFzheLuzZkCMqalduc2/Z3W9l7QEe/Ixe1ySNIjGy9lyoZ2coRj4ZiVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h9WYS3Z37zKHLyF;
	Thu, 30 Jul 2026 09:18:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 69A0540A5F;
	Thu, 30 Jul 2026 09:19:32 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgC3ptKdpmpqAxq_AQ--.33036S2;
	Thu, 30 Jul 2026 09:19:32 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH] tracing/snapshot: Avoid CPU buffer swap during reserve/commit
Date: Thu, 30 Jul 2026 01:19:12 +0000
Message-Id: <20260730011912.2325121-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC3ptKdpmpqAxq_AQ--.33036S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWUtF4UuF4DurykGw45KFg_yoW5ZFW8pr
	15KrWUKrs8ZF4Iy3yUCa1rZFyFqFn8Wry7ur4DG34fXw4UJFnFqr4fKFnxXr4YkrZ2g3s0
	vFWUZa4rGa4jvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUehL0UU
	UUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Commit 3163f635b20e ("tracing: Fix race issue between cpu buffer write
and swap") fixed most of the race conditions between snapshot's
ring_buffer_swap_cpu and ring_buffer_lock_{reserve, commit}. It achieved
this by replacing the asynchronous swap with smp_call_function_single to
trigger an interrupt on the target CPU to handle the swap.

However, this interrupt can still break in at any point during
ring_buffer_lock_{reserve, commit}. Currently, ring_buffer_swap_cpu()
relies on a cooperative check where cpu_buffer->committing is combined
with a condition in rb_reserve_next_event() that verifies if
READ_ONCE(cpu_buffer->buffer) != buffer to ensure state consistency. In
principle, once the execution passes this conditional check, no issues
should arise as long as cpu_buffer->committing remains non-zero.
Unfortunately, there is a window where cpu_buffer->committing can drop
to zero, which subsequently triggers a warning during rb_commit:

    ring_buffer_lock_reserve
        cpu_buffer = buffer->buffers[cpu];       // cpu_buffer_a
        rb_reserve_next_event
            rb_start_commit // inc committing
            if (unlikely(READ_ONCE(cpu_buffer->buffer) != buffer)) {...}
            __rb_reserve_next
                rb_move_tail
                    rb_end_commit(cpu_buffer);   // dec committing => 0
                    /* smp_call interrupt hits here, successfully swaps! */
                    local_inc(&cpu_buffer->committing);

    ring_buffer_unlock_commit
        cpu_buffer = buffer->buffers[cpu];      // cpu_buffer_b
        rb_commit
            rb_end_commit
            RB_WARN_ON(cpu_buffer, !local_read(&cpu_buffer->committing))
                                                // triggers warning

Instead of maintaining fragile complexity to allow the swap to intervene at
arbitrary points, simply replace smp_call_function_single with work_on_cpu.
This ensures the swap operation runs in a process context on the target
CPU, guaranteeing it only executes after ring_buffer_lock_{reserve, commit}
has fully completed.

Fixes: 3163f635b20e ("tracing: Fix race issue between cpu buffer write and swap")
Cc: stable@vger.kernel.org
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

