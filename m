Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792995601;
	b=gff9rra4ZsQkBQypftGFO9b9MfbecDnCity84kjt3nMPAk1MKuqybB4SDON4EFtIVkXZ
	 FrQScsBAunjER85SRNnWrQ6Z7CrJZ72JrZFsEWUT4IUXTyKjug/+Q1Js6UgBfeCjI6IwO
	 ZqGGLuFZMAKl80vyVtE53bMe/CZiY5S2Tqo8T64cZHWOkQEp5kIbvJwgdvrmSAM1rzo2c
	 qHDtKA13bzCR0oJnfT3vDFqDAPFGV5vDOFwdeW54EoH3t6zMEd3SBcORTHGk77TUYt/BS
	 Ou6v9m8pj2rO9QUOEqwKg+bCeqHp9vBNB+6jPE0efVgRWA5L8ABOdAaFTdeCVvd8aHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792995601;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=eWYTpnbKgq6YSvxhRQRRmJfkpPH9s6eNR652ZchARzo=;
	b=PthFwofiN5N+O0W6lEI362I8TnL2S+aCRK4keJbv3qYScsfK+e+sQng1PtFOFMZNLtXa
	 PMky6TOL/psIHW4ZlBhaKSlx4ks3FhzsWZl/st22hrg/1lMcWSWFciAlEx8ZFW2V6rSsl
	 oYeKoSnJmomwEbyfrbX5wLMnv8filbws8gTYLEYaJbHA0aaMC/mOzJHoHIRK1rMO1AHvT
	 Z1Ho5IY3dUrrmqN+vf8EkuK1nA3j3JJj4GjYWvhchKLBpMxjVGGt0W8AzsmzGbPzTZ92N
	 8EGR9bk0XY5DhNgHQfdhGiOLDbnVXUmDUB4/zlS0ePvuUmgPKRX5GrtgWyCKxO4NEjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Lif6GUzG;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091B606A31B;
	Mon, 26 Oct 2026 06:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C091B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Lif6GUzG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=eWYTpnbKgq6YSvxhRQRRmJfkpPH9s6eNR652ZchARzo=;
	b=Lif6GUzGj59CeHQUi4JEyseEkSthdzndNzUnMOx7piEmUugLgPrK7hRuD2tSF4
	YfvqdinOsmCMr/PxcGogwgNJZT4CtA90PXDfYpw1NkuLlsEJTxACqALPLipImzNB
	UJxve88M7gJOKIZEF4JZzRWfFIhpnIk3c+x3SYa4nokNk=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: don't reference jiffies from writeback TP_printk()
Date: Mon, 26 Oct 2026 14:17:18 +0800
Message-ID: <179299543891.294518.18224691820856958686@163.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Rx7Y8N5q9zrDCg--.34996S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFyUCF4UXFW8WrykXw15CFg_yoWrWFyfpF
	ZFyryagw4ktrW7K3Wkua1jvr1Uu3ykuFW7KF17WFy7Z3Z5XFs5KFyjgr1jvwn8Ar9a9ry2
	va90vr95A3W5XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joJP_UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xrEOmre8NrfNAAA3y

From: Chaosheng Qu <quchaosheng000406@163.com>
Subject: [PATCH] tracing: don't reference jiffies from writeback TP_printk()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
    "Matthew Wilcox (Oracle)" <willy@infradead.org>,
    Jan Kara <jack@suse.cz>,
    linux-trace-kernel@vger.kernel.org,
    linux-kernel@vger.kernel.org

writeback_sb_inodes_requeue and writeback_single_inode_start/() compute
the inode age with:

	(jiffies - __entry->dirtied_when) / HZ

inside TP_printk().  TP_printk() is not part of the recorded event: it
runs when the trace is read back, so the expression is evaluated at
formatter time, not at the time the event was recorded.  The formatted
output therefore reports the interval between recording and reading,
not the age of the inode when it was traced.

It is also evaluated outside of the kernel: tracefs renders the format
string once and userspace re-evaluates it.  A tool that has to resolve
every symbol in the expression (trace-cmd and the parser in LISA both
do) resolves the bare "jiffies" to its address, so the printed age
becomes ((unsigned long)&jiffies - dirtied_when) / HZ, which is
nonsense.  This was reported as a wrong "age" value in trace-cmd
output:

  https://bugzilla.kernel.org/show_bug.cgi?id=219839

Nothing in TP_printk() may depend on the state of the machine at read
time, which is the same rule that keeps ktime_get() and friends out of
it.  writeback_queue_io already does the right thing and stores the age
in TP_fast_assign(); make these two events do that as well.

The new __entry->age field is appended after the existing fields, so
no existing field changes offset and trace consumers that index the
event by offset keep working.  The "age=%lu" placeholder keeps its
position in the output text.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219839
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 include/trace/events/writeback.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 13ee076..23d107c 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -745,6 +745,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 		__field(u64, cgroup_ino)
 		__field(unsigned long, state)
 		__field(unsigned long, dirtied_when)
+		__field(unsigned long, age)
 	),
 
 	TP_fast_assign(
@@ -753,6 +754,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode_state_read_once(inode);
 		__entry->dirtied_when	= inode->dirtied_when;
+		__entry->age		= (jiffies - __entry->dirtied_when) / HZ;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(inode_to_wb(inode));
 	),
 
@@ -761,7 +763,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 		  __entry->ino,
 		  show_inode_state(__entry->state),
 		  __entry->dirtied_when,
-		  (jiffies - __entry->dirtied_when) / HZ,
+		  __entry->age,
 		  __entry->cgroup_ino
 	)
 );
@@ -784,6 +786,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 		__field(unsigned long, writeback_index)
 		__field(unsigned long, wrote)
 		__field(long, nr_to_write)
+		__field(unsigned long, age)
 	),
 
 	TP_fast_assign(
@@ -795,6 +798,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 		__entry->writeback_index = inode->i_mapping->writeback_index;
 		__entry->nr_to_write	= nr_to_write;
 		__entry->wrote		= nr_to_write - wbc->nr_to_write;
+		__entry->age		= (jiffies - __entry->dirtied_when) / HZ;
 		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
 	),
 
@@ -804,7 +808,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 		  __entry->ino,
 		  show_inode_state(__entry->state),
 		  __entry->dirtied_when,
-		  (jiffies - __entry->dirtied_when) / HZ,
+		  __entry->age,
 		  __entry->writeback_index,
 		  __entry->nr_to_write,
 		  __entry->wrote,
-- 
2.43.0

