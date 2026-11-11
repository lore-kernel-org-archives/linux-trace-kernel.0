Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386511;
	b=Wq0RhMszeBM4oLIsbgvjsycCrk3bpIgPIT7HG3lKaq9uozf89Ner+EEUOP43NoTxL/2T
	 UYSUhi2Avm4fqXn9Iy5fkf769PHHXJScYnZQ/3p+fcMc2//idgZ4E+aZjVxznNfybwTVH
	 UY6+NgdrmkWyQVdoBy6lJzw0uYDl3OfNvMMCJ7o3kRlPn0hMHKgLb0t+kTri3GNQKGUcW
	 fUp4OYw3zCxDN5VtJphn3PF9zl8YINsNo2gcbTDSW+7LODKrQ/78Oh4cGB9qhxErvy4Tg
	 omUBa+IMJqi31xR+ICc0gR1D2ToT49rzHw7uojD3ZwWuaq82np58uMr/oOGavEwhA7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386511;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1owST+wgPsXbfE9nrXxqO5ssLl/5X3lPPwyQXtf8KnA=;
	b=nT6MS+qM1UlB7CdHXEOObAP8DuBtSrX2Wt63iLNGe/xCxm4ta/f0/WohQ0mzA/60U52c
	 3iwGv92MRdDtBIIxNuerF055x0Y4zKj5SjZxVoXuHt6Et5XXB8ke/uYjKdbihSYWE01py
	 dVbJUmKwQR2sLOGNq8j9hOWkYsJ81ftSCqi4VqLzcZb2WciAl3EOFB0edK518u3TdQbxz
	 OcsVMQc/FIuYuPMPrLY9+UqGul+Gr3zNlJQrWzSFwkTrf/9QpDoLEOZvyfUISMv/JVKhL
	 ljW+r1fjgu5sTPcgQG16ZCDvwYct0zQrcl/LAAGm4jlDLttimC0VSh/1y06ROq8HYXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=KIXOsUfi;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2A1606A31C;
	Wed, 11 Nov 2026 08:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F2A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=KIXOsUfi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=KIXOsUfiwpb8kdQE0FDZwtiqiE7ReKyBcjWj+RgTc5wDamikVpIFMaWENJRAbdUUOsqAzOF8Ru6rT
	 hPYr6uH/9ZTYKtAB4nS06DEErFUbRnXkwin6a/64tayqCgrA0enII1tLxMFYP68W4xyhaGdD91xfsS
	 PVXcLPoc/eIaSYrk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af42a4059e-a2e02;
	Wed, 11 Nov 2026 16:41:38 +0800 (CST)
X-RM-TRANSID:2ee36af42a4059e-a2e02
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af42a40601-d56e4;
	Wed, 11 Nov 2026 16:41:38 +0800 (CST)
X-RM-TRANSID:2ee86af42a40601-d56e4
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: rostedt@goodmis.org
Cc: vdonnefort@google.com,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+53ab168fdda7fba508ba@syzkaller.appspotmail.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] ring-buffer: Mark concurrent accesses to waiter flags
Date: Wed, 11 Nov 2026 16:41:37 +0800
Message-ID: <20261111084137.80941-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Poll and wait paths set the pending waiter flags while ring buffer
writers test and clear them without a common lock. The irq_work callback
also accesses the full-buffer wakeup flags concurrently. These plain
accesses cause KCSAN reports.

Use READ_ONCE() and WRITE_ONCE() for the shared waiter and wakeup flags.
Keep the existing barriers and irq_work wakeup protocol unchanged.

Fixes: 15693458c4bc ("tracing/ring-buffer: Move poll wake ups into ring buffer code")
Fixes: 1e0d6714aceb ("ring-buffer: Do not wake up a splice waiter when page is not full")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 kernel/trace/ring_buffer.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 75cd8df23c1b..18f023cf1d6f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -904,14 +904,14 @@ static void rb_wake_up_waiters(struct irq_work *work)
 	(void)atomic_fetch_inc_release(&rbwork->seq);
 
 	wake_up_all(&rbwork->waiters);
-	if (rbwork->full_waiters_pending || rbwork->wakeup_full) {
+	if (READ_ONCE(rbwork->full_waiters_pending) || READ_ONCE(rbwork->wakeup_full)) {
 		/* Only cpu_buffer sets the above flags */
 		struct ring_buffer_per_cpu *cpu_buffer =
 			container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
 
 		scoped_guard(raw_spinlock_irqsave, &cpu_buffer->reader_lock) {
-			rbwork->wakeup_full = false;
-			rbwork->full_waiters_pending = false;
+			WRITE_ONCE(rbwork->wakeup_full, false);
+			WRITE_ONCE(rbwork->full_waiters_pending, false);
 
 			/* Waking up all waiters, they will reset the shortest full */
 			cpu_buffer->shortest_full = 0;
@@ -1023,9 +1023,9 @@ rb_wait_cond(struct rb_irq_work *rbwork, struct trace_buffer *buffer,
 	 * a task has been queued. It's OK for spurious wake ups.
 	 */
 	if (full)
-		rbwork->full_waiters_pending = true;
+		WRITE_ONCE(rbwork->full_waiters_pending, true);
 	else
-		rbwork->waiters_pending = true;
+		WRITE_ONCE(rbwork->waiters_pending, true);
 
 	return false;
 }
@@ -1153,12 +1153,12 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 		 * full_waiters_pending doesn't leak up into the above.
 		 */
 		smp_mb();
-		rbwork->full_waiters_pending = true;
+		WRITE_ONCE(rbwork->full_waiters_pending, true);
 		return 0;
 	}
 
 	poll_wait(filp, &rbwork->waiters, poll_table);
-	rbwork->waiters_pending = true;
+	WRITE_ONCE(rbwork->waiters_pending, true);
 
 	/*
 	 * There's a tight race between setting the waiters_pending and
@@ -4378,14 +4378,14 @@ rb_irq_work_queue(struct rb_irq_work *irq_work)
 static __always_inline void
 rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 {
-	if (buffer->irq_work.waiters_pending) {
-		buffer->irq_work.waiters_pending = false;
+	if (READ_ONCE(buffer->irq_work.waiters_pending)) {
+		WRITE_ONCE(buffer->irq_work.waiters_pending, false);
 		/* irq_work_queue() supplies it's own memory barriers */
 		rb_irq_work_queue(&buffer->irq_work);
 	}
 
-	if (cpu_buffer->irq_work.waiters_pending) {
-		cpu_buffer->irq_work.waiters_pending = false;
+	if (READ_ONCE(cpu_buffer->irq_work.waiters_pending)) {
+		WRITE_ONCE(cpu_buffer->irq_work.waiters_pending, false);
 		/* irq_work_queue() supplies it's own memory barriers */
 		rb_irq_work_queue(&cpu_buffer->irq_work);
 	}
@@ -4396,7 +4396,7 @@ rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 	if (cpu_buffer->reader_page == cpu_buffer->commit_page)
 		return;
 
-	if (!cpu_buffer->irq_work.full_waiters_pending)
+	if (!READ_ONCE(cpu_buffer->irq_work.full_waiters_pending))
 		return;
 
 	cpu_buffer->last_pages_touch = local_read(&cpu_buffer->pages_touched);
@@ -4404,8 +4404,8 @@ rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 	if (!full_hit(buffer, cpu_buffer->cpu, cpu_buffer->shortest_full))
 		return;
 
-	cpu_buffer->irq_work.wakeup_full = true;
-	cpu_buffer->irq_work.full_waiters_pending = false;
+	WRITE_ONCE(cpu_buffer->irq_work.wakeup_full, true);
+	WRITE_ONCE(cpu_buffer->irq_work.full_waiters_pending, false);
 	/* irq_work_queue() supplies it's own memory barriers */
 	rb_irq_work_queue(&cpu_buffer->irq_work);
 }
-- 
2.51.0



