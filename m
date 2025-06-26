Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34ED2EB5B9;
	Thu, 26 Jun 2025 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951216; cv=none; b=I5bukDETv4NHk/AubVeoU8VkgDhThstoX3H21SXidDs91NFCfjqyHHBfvhkRbsXurdbQRH/GAqKa2/1py0U9WG8Q9yyp8mogzB3zBXcuW2V2JValaoZp5v2BKEg0C+DN29TqMcXG54ujiK+6qgrhuBmpw5F+csTq20aUGNX3P5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951216; c=relaxed/simple;
	bh=Z4d+7h8BA44y+DQYpqJgetAGHe0PE65fDfDUAVKH6ZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=itExTqpzjkiGYGaJa1990ijLqH8TLy+PyWziDLXM+u4Ym/NvRHXif/6M0F921cdIeCpU8VidY33cbwjBkdIwXAugVNGD41zeTyzgiJUv63CoCyLAuwn6r2dGSyLttJKdv9uBwPfokEZIpdXmaabudewyLUY9QV26pJZmSLDy6IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iNv+64YD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9wFEbSWt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iNv+64YD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9wFEbSWt"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750951212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6gV2YmB3UnV/4qllskTxPTv0rjuHdA9qt4FDUhrbvWA=;
	b=iNv+64YD0tyVmJ7rJhnT/GEtReEUtANmm+38Xq8bYt/XgcINpduPhcGyAUIOcFvKvxmFxF
	OHxcQH9wD8E8zac9bZJ3Sw2Pg5gN28w4zT6Rb+LyYnuJZBVr0jYlQLpoZ9wnd5q/pY/tBG
	OQAIwL00S/rG+OCMJZ9jGyibZAK/2aARrZK68T4parh55DWC32jC0zqRncoVv3gi6Qsjq/
	gu81481I85tKHKFIOeLLQS4/RP7dyHf4KFc6KcZ5NQxf/BPoIB5Xd+P6mNO/M5xHuBPBR0
	lSQZQrHx2PjDWrYPT9aieSz23Qi9SoY06CEGnGgDw6MvaE0uR9e7j+TOudvMUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750951213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6gV2YmB3UnV/4qllskTxPTv0rjuHdA9qt4FDUhrbvWA=;
	b=9wFEbSWtffWSD3WHs8AbQm+ItOQqoUgDrmODvIMlkN2joDKFqvhGgKE5RrUO8zUCRV2tJ6
	uJgGBEGTskhK5SBQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH] tracing: Remove pointless memory barriers
Date: Thu, 26 Jun 2025 17:19:40 +0200
Message-Id: <20250626151940.1756398-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Memory barriers are useful to ensure memory accesses from one CPU appear in
the original order as seen by other CPUs.

Some smp_rmb() and smp_wmb() are used, but they are not ordering multiple
memory accesses.

Remove them.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
This is something I noticed while staring at RV code. And I couldn't
understand them. It seems RV code copied this from trace core, and it also
doesn't make sense to me there.

Memory barriers are useful if we have something like:

CPU1:              CPU2
write A            read B
write B            read A

From this code, if CPU2 reads the new B, then it "should" also read the new
A.

But CPU1 could reorder the writes, and CPU2 sees the new B, but still the
old A.

Memory barrier is useful here:

CPU1:              CPU2
write A            read B
smp_wb()           smp_rb()
write B            read A

Then if CPU2 sees the new B, and it will also see the new A.

However, the memory barriers I see in kernel/trace/ do not resemble the
above pattern. Therefore I think they are redundant.

Please let me know if there is an unobvious reason for them.

 kernel/trace/rv/rv.c | 6 ------
 kernel/trace/trace.c | 7 -------
 2 files changed, 13 deletions(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index e4077500a91db..c04a49da43286 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -675,8 +675,6 @@ static bool __read_mostly monitoring_on;
  */
 bool rv_monitoring_on(void)
 {
-	/* Ensures that concurrent monitors read consistent monitoring_on */
-	smp_rmb();
 	return READ_ONCE(monitoring_on);
 }
=20
@@ -696,8 +694,6 @@ static ssize_t monitoring_on_read_data(struct file *fil=
p, char __user *user_buf,
 static void turn_monitoring_off(void)
 {
 	WRITE_ONCE(monitoring_on, false);
-	/* Ensures that concurrent monitors read consistent monitoring_on */
-	smp_wmb();
 }
=20
 static void reset_all_monitors(void)
@@ -713,8 +709,6 @@ static void reset_all_monitors(void)
 static void turn_monitoring_on(void)
 {
 	WRITE_ONCE(monitoring_on, true);
-	/* Ensures that concurrent monitors read consistent monitoring_on */
-	smp_wmb();
 }
=20
 static void turn_monitoring_on_with_reset(void)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 95ae7c4e58357..0dff4298fc0e5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -936,7 +936,6 @@ int tracing_is_enabled(void)
 	 * return the mirror variable of the state of the ring buffer.
 	 * It's a little racy, but we don't really care.
 	 */
-	smp_rmb();
 	return !global_trace.buffer_disabled;
 }
=20
@@ -1107,8 +1106,6 @@ void tracer_tracing_on(struct trace_array *tr)
 	 * important to be fast than accurate.
 	 */
 	tr->buffer_disabled =3D 0;
-	/* Make the flag seen by readers */
-	smp_wmb();
 }
=20
 /**
@@ -1640,8 +1637,6 @@ void tracer_tracing_off(struct trace_array *tr)
 	 * important to be fast than accurate.
 	 */
 	tr->buffer_disabled =3D 1;
-	/* Make the flag seen by readers */
-	smp_wmb();
 }
=20
 /**
@@ -2710,8 +2705,6 @@ void trace_buffered_event_enable(void)
=20
 static void enable_trace_buffered_event(void *data)
 {
-	/* Probably not needed, but do it anyway */
-	smp_rmb();
 	this_cpu_dec(trace_buffered_event_cnt);
 }
=20
--=20
2.39.5

