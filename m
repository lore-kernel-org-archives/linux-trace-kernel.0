Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3FC3CCFD1;
	Wed, 11 Mar 2026 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224186; cv=none; b=kd6KGtmOXuo5FfJTVPScqmbE/h+RhIrWUL8PMqG+QS6wj49sm6kATbGLdYlDSuJLf8WylIHLv0sC1PmvF/uKUD67MS+q7FP86j+0qKz8x1rSctrQ9RbyCbR8E8tSlBI7ywS6sABrhLAsyGnjkgL169r1tz8M/suwxz01pHEs0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224186; c=relaxed/simple;
	bh=YJZ29MYyQzOXkBfE1tfhpcdex3lVyVZuxApJtV5ngBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjzAJy32BhSIBkCupDrqC9z7LLAyUlGrZXL6+TzBhDN6BYR3eN+fO4CIQuTN8ZKwXE5GqFhSX3MuNRGm/d+HkxiNnWdczb3VuieF8shPcL2KFTBFSEzOwIiYNUolbHf0Pfx2uoQYhLFauhLDMwfmOLTtu8qgBfOEh37LE5Z5M5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DMya3wPX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aHlf4RyF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DMya3wPX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aHlf4RyF"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773224183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0sWT+/NCSlsPgVDIygbLH7QYDvLN5gFTeqUIZkXBbE=;
	b=DMya3wPXYKWuXQWWLx/w1OV+Jv7sgDsGfHOlXszLFD3YPxQR9qmUpjCLjNIq8pBX0N9bgT
	dXaegJfXoEZst5NLr3+NpepJm8zZqLEWmi2HLHLt/kDmELJSljxS/CXZNVz+GUjKl0HzIE
	hWiws7U56Uq5n4gkoNLiPyand5XUeZZ3ZSU77V10IVhzedZg2gRbgpI13sah8HB3LEKRVL
	BvRtm7X29Nuc6cm73hwv4dlfl8dFoPgZgSELxixyEOZraLvrMDYekAMVo3C/B7wRw9PZNw
	2AN4pxBfC+EaTcOndrYSbW1Odn5KPvXTaqr2VEVpDsLMv0pu2do+ceIS2gWXmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773224183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0sWT+/NCSlsPgVDIygbLH7QYDvLN5gFTeqUIZkXBbE=;
	b=aHlf4RyF4g3539XmFmlZqP0Z2hAlyW06ihpHlyZOT4po156GZeNaVSulAPSjt8wdI7OweY
	5hbIeHE6UqXUVWBg==
Date: Wed, 11 Mar 2026 11:15:18 +0100
Subject: [PATCH 09/12] hrtimer: Drop unnecessary pointer indirection in
 hrtimer_expire_entry event
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-hrtimer-cleanups-v1-9-095357392669@linutronix.de>
References: <20260311-hrtimer-cleanups-v1-0-095357392669@linutronix.de>
In-Reply-To: <20260311-hrtimer-cleanups-v1-0-095357392669@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>, 
 Kieran Bingham <kbingham@kernel.org>, John Stultz <jstultz@google.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224171; l=2302;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=YJZ29MYyQzOXkBfE1tfhpcdex3lVyVZuxApJtV5ngBA=;
 b=EHnK40lHZaBKI6F9QrN2/AdAvKdZ4xY+TZu4b4d5ZFXRRm2cIZvKV1JCm+kv+D0co+1o92qsu
 hchmesgzZugAoBZ/V7qghJh4qV+lKM91GDz+Pg+orgSKjwuUimkONKj
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This pointer indirection is a remnant from when ktime_t was a struct,
today it is pointless.

Drop the pointer indirection.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 include/trace/events/timer.h | 7 +++----
 kernel/time/hrtimer.c        | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index a54613f59e55..07cbb9836b91 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -254,14 +254,13 @@ TRACE_EVENT(hrtimer_start,
 /**
  * hrtimer_expire_entry - called immediately before the hrtimer callback
  * @hrtimer:	pointer to struct hrtimer
- * @now:	pointer to variable which contains current time of the
- *		timers base.
+ * @now:	variable which contains current time of the timers base.
  *
  * Allows to determine the timer latency.
  */
 TRACE_EVENT(hrtimer_expire_entry,
 
-	TP_PROTO(struct hrtimer *hrtimer, ktime_t *now),
+	TP_PROTO(struct hrtimer *hrtimer, ktime_t now),
 
 	TP_ARGS(hrtimer, now),
 
@@ -273,7 +272,7 @@ TRACE_EVENT(hrtimer_expire_entry,
 
 	TP_fast_assign(
 		__entry->hrtimer	= hrtimer;
-		__entry->now		= *now;
+		__entry->now		= now;
 		__entry->function	= ACCESS_PRIVATE(hrtimer, function);
 	),
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 226cac8c82cc..d350bceb3c95 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1884,7 +1884,7 @@ EXPORT_SYMBOL_GPL(hrtimer_active);
  * __run_hrtimer() invocations.
  */
 static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base, struct hrtimer_clock_base *base,
-			  struct hrtimer *timer, ktime_t *now, unsigned long flags)
+			  struct hrtimer *timer, ktime_t now, unsigned long flags)
 	__must_hold(&cpu_base->lock)
 {
 	enum hrtimer_restart (*fn)(struct hrtimer *);
@@ -1989,7 +1989,7 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now,
 			if (basenow < hrtimer_get_softexpires(timer))
 				break;
 
-			__run_hrtimer(cpu_base, base, timer, &basenow, flags);
+			__run_hrtimer(cpu_base, base, timer, basenow, flags);
 			if (active_mask == HRTIMER_ACTIVE_SOFT)
 				hrtimer_sync_wait_running(cpu_base, flags);
 		}

-- 
2.53.0

