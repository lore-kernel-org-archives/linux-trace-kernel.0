Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BAF13C816;
	Wed, 20 Aug 2025 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680434; cv=none; b=K2w3AMfamq1pJ5Wp3SEJrWIfhxKVPSV+LqCYPPBbXYyrlDbf1mjwFvg0+5xQc3kUey/RdXGjcClvOf3vQ/8U4qkcGplYEgc71Ca22Y9ZuaPSM+TyXtoXJlDew4n0r04+W26TPWYFzG61gCqvJ3ft5XIo3U646DFd2ibany6n5/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680434; c=relaxed/simple;
	bh=R3yfDPxehjuYfsd99Fu7QrZq0lSS2Wlmj1idbjeLmYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dgrOD/Pz/WR48FE/dqzcaubswC4Uh82Dw0yOsaJnsowSiPACqO6Nwz2WqgOKC5HsRwBVjkEARWWTwVHMHrn9LPH/Glo6h3TNquWDxMAIq+oMeY9cBEi7eb2V8G+tF0tkUAV9DtgMCb7n3FuzXsnA0lXsNnOYxBrCa24Me/jMUWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c6L583Ss7zKHNpK;
	Wed, 20 Aug 2025 17:00:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E64111A0CE7;
	Wed, 20 Aug 2025 17:00:27 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP4 (Coremail) with SMTP id gCh0CgCHURKkjqVonnY8EQ--.11889S2;
	Wed, 20 Aug 2025 17:00:27 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@elte.hu>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH -next] ftrace: Fix potential warning in trace_printk_seq during ftrace_dump
Date: Wed, 20 Aug 2025 09:00:17 +0000
Message-Id: <20250820090017.2978279-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHURKkjqVonnY8EQ--.11889S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFykArW8Ar18tF1ktFW8WFg_yoW5AF1UpF
	9xK3srJr4kAFsrtFn8uF4xGw1xJay0qry7WrsrJw1rAan8Ar4j9rnxtwnaqFyfC398G3sI
	yFWjy3yDCw129FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUU
	UUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

When calling ftrace_dump_one() concurrently with reading trace_pipe,
a WARN_ON_ONCE() in trace_printk_seq() can be triggered due to a race
condition.

The issue occurs because:

CPU0 (ftrace_dump)                              CPU1 (reader)
echo z > /proc/sysrq-trigger

!trace_empty(&iter)
trace_iterator_reset(&iter) <- len = size = 0
                                                cat /sys/kernel/tracing/trace_pipe
trace_find_next_entry_inc(&iter)
  __find_next_entry
    ring_buffer_empty_cpu <- all empty
  return NULL

trace_printk_seq(&iter.seq)
  WARN_ON_ONCE(s->seq.len >= s->seq.size)

In the context between trace_empty() and trace_find_next_entry_inc()
during ftrace_dump, the ring buffer data was consumed by other readers.
This caused trace_find_next_entry_inc to return NULL, failing to populate
`iter.seq`. At this point, due to the prior trace_iterator_reset, both
`iter.seq.len` and `iter.seq.size` were set to 0. Since they are equal,
the WARN_ON_ONCE condition is triggered.

Add a non-NULL check on the return value of trace_find_next_entry_inc
prior to invoking trace_printk_seq, ensuring the `iter.seq` is properly
populated before subsequent operations.

Furthermore, per the seq_buf specification, the condition len == size
indicates a full buffer, which constitutes a valid state. Consequently,
the equality check and size - 1 adjustment in WARN_ON_ONCE() are redundant
and should be eliminated.

Fixes: d769041f8653 ("ring_buffer: implement new locking")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 kernel/trace/trace.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4283ed4e8f59..61c5d389dbd3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10521,8 +10521,8 @@ trace_printk_seq(struct trace_seq *s)
 	 * PAGE_SIZE, and TRACE_MAX_PRINT is 1000, this is just
 	 * an extra layer of protection.
 	 */
-	if (WARN_ON_ONCE(s->seq.len >= s->seq.size))
-		s->seq.len = s->seq.size - 1;
+	if (WARN_ON_ONCE(s->seq.len > s->seq.size))
+		s->seq.len = s->seq.size;
 
 	/* should be zero ended, but we are paranoid. */
 	s->buffer[s->seq.len] = 0;
@@ -10617,6 +10617,7 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
 	 */
 
 	while (!trace_empty(&iter)) {
+		void *ent;
 
 		if (!cnt)
 			printk(KERN_TRACE "---------------------------------\n");
@@ -10625,17 +10626,18 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
 
 		trace_iterator_reset(&iter);
 		iter.iter_flags |= TRACE_FILE_LAT_FMT;
+		ent = trace_find_next_entry_inc(&iter);
 
-		if (trace_find_next_entry_inc(&iter) != NULL) {
+		if (ent) {
 			int ret;
 
 			ret = print_trace_line(&iter);
 			if (ret != TRACE_TYPE_NO_CONSUME)
 				trace_consume(&iter);
+
+			trace_printk_seq(&iter.seq);
 		}
 		touch_nmi_watchdog();
-
-		trace_printk_seq(&iter.seq);
 	}
 
 	if (!cnt)
-- 
2.34.1

