Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209BD246762;
	Mon,  9 Feb 2026 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770629481; cv=none; b=mpKFD89CWpCO27YYrHoz1/UhXXuQYVGkBxcjFi4j8z6OVGk5mHeJwER8Zs571qGCdYEprGJWh8sgbaS+VNL37F62YH0ZTuRABkf+8ywyp89MOom/vZ+NBGERSqnaOXW39C3J01cJPH8UpbXEu0ZK8p+GsO5ZkPh+YEdi+SsNjF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770629481; c=relaxed/simple;
	bh=dWPIyAinjJJgLyRH3NRk8yFrvm44VyykuKnYZ554Ovw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sv0N+vaQrwj8F9fWqotSZt+XCQA1zLU/d7vEuyyD/PqC3CmwCc7A0Z1fPN8ci4t9Bc/swRq1ZOC2x8sLJRxJTBPgha7XLLe46MLw9qrr/rlnkSYNgZr6mwuhR0FrIEdhfpcwCu+I4hhX+UEZaj9+N4UCGkWOzzzG53P+H9cTO/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f8fYm1mpszYQtnh;
	Mon,  9 Feb 2026 17:30:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 83B9A4058A;
	Mon,  9 Feb 2026 17:31:17 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP1 (Coremail) with SMTP id cCh0CgCHPuRZqYlp5UrVGg--.57503S2;
	Mon, 09 Feb 2026 17:31:17 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@kernel.org>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH] tracing: Fix soft lockup when lseeking trace file
Date: Mon,  9 Feb 2026 17:31:01 +0800
Message-Id: <20260209093101.1623454-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCHPuRZqYlp5UrVGg--.57503S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AryxAFWDJF1DXw1DZry7ZFb_yoW8Gw1rpF
	Za9FZxGr4UGF4jyFWF9F4xWryavwnFg347KF9rGw4FvFyDJr15ursFgF1Yg3y5ur9Yy34a
	vFWYv34UWwnrZFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUU
	UUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

A soft lockup may occur when accessing trace file via lseek while
tracing is active and a large offset is provided. The call trace
is shown below:

watchdog: BUG: soft lockup - CPU#3 stuck for 26s! [poc:141]
CPU: 3 UID: 0 PID: 141 Comm: poc Not tainted 6.19.0 #1 PREEMPT(none)
Call Trace:
  ring_buffer_iter_peek
  peek_next_entry
  __find_next_entry
  trace_find_next_entry_inc
  s_next
  traverse.part.0
  seq_lseek
  tracing_lseek
  __x64_sys_lseek
  do_syscall_64
  entry_SYSCALL_64_after_hwframe

The root cause is that the lseek implementation for trace files
is based on seq_lseek, which contains a loop that repeatedly calls
show() and next() functions until the position reaches the target
offset. Since no scheduling point is set within this loop, a large
offset can cause the CPU to be stuck in the loop for an extended
period, triggering the soft lockup detector.

Fixed by adding cond_resched() in s_next().

Fixes: bc0c38d139ec ("ftrace: latency tracer infrastructure")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8bd4ec08fb36..3afe148ef683 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3928,6 +3928,8 @@ static void *s_next(struct seq_file *m, void *v, loff_t *pos)
 
 	iter->pos = *pos;
 
+	cond_resched();
+
 	return ent;
 }
 
-- 
2.34.1

