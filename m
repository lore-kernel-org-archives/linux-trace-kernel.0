Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E973CBE8C;
	Wed, 11 Mar 2026 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224185; cv=none; b=bFPiEa+6jR5fCc7wB6vqnwEgsHsofdHJj2eSqFkidiMEzP7ymz8LYwL7A5NxGKgSqp4/Xqt1buqlhuuqsNWiPzWPtTQiJ0IJVLWFy8ZcdWxAsvDRo/FOsyV+VUxyL/ekaHS3ApeHkHcrruJToxJ5wK0hD5ktH5KlR8YZMNnlFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224185; c=relaxed/simple;
	bh=1qtoqo5zEbz0ht2GwSDm3/A9ci+SOUFm+t1wY8L/jXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m8H/NlAMxIaG2/6X9v5ezSvE53nQAdVIhP0ITzyKIL8gyWHR1mrpfjMDfGr1XdMW3m0Kv48fAgZc91xO9lYZuyHrVSmXTEYt0bsHhxqxIcEFhsdxQp365Stuve39SGpH8o/oDq2wfHJ29r6dex6hIfr4AmVUq1VoNAYwIyLpRmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IRs4u4BX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Q3zIioR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IRs4u4BX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Q3zIioR"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773224182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8YRmhI3LAEwurtSkmPWvRPwNYsqDJWBN45KTy2yCTjc=;
	b=IRs4u4BXtCzaoSQS4mh4kxs1Lzzp/M5cqZ0FGD+ysqs6dOmXN3G1HozDmRVxb4gwxkVXYc
	6UjlwbqOvrnxdBotp5eYBPiYKI+OdYyeM5BvNLLdk4hQP81s0OlUmMNbHr9iGdGfcal0Nf
	PUX27xKYsKrHmZipkhMSPmGmko3EYZCDEl2MJBmICGCyoPXQIPOdqWedRgS0cNqjN8n7XX
	XaydxXzW+NVOo6dTLNyOffDQtyYvViaJuzm5ZIYd4ljXy1TvCm/5ZE6SkG3TLQ8PuRkscC
	cjAQiMxLTRbffpDA4mbgtKl8PmsvTnO/dIfbm42sCe5j2asVuV8KgHlqbphBcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773224182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8YRmhI3LAEwurtSkmPWvRPwNYsqDJWBN45KTy2yCTjc=;
	b=+Q3zIioR+ORPjeC9538kVIa40rxNk02Mh+9jePYlzSPyv/YjeTFLfouBaZ7VKMQoeCZwuy
	7nvpusr+0CrA25Dw==
Date: Wed, 11 Mar 2026 11:15:16 +0100
Subject: [PATCH 07/12] hrtimer: Don't zero-initialize ret in
 hrtimer_nanosleep()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-hrtimer-cleanups-v1-7-095357392669@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224171; l=795;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=1qtoqo5zEbz0ht2GwSDm3/A9ci+SOUFm+t1wY8L/jXI=;
 b=8D4F5Z8NRArCmMy6UsNTwapseSXa+g/VM9E46O4O2XFZVwZFSrcCd775L7XFqk2BiOifqxHWx
 2wrUbdnXKD2BM/2MRbH6y+hSPX864Qu88r7I/xDhR0d1mEjo17n2y1b
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The value will be assigned to before any usage.
No other function in hrtimer.c does such a zero-initialization.

Signed-off-by: Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b94bd56b739f..226cac8c82cc 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2328,7 +2328,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode, const clockid
 {
 	struct restart_block *restart;
 	struct hrtimer_sleeper t;
-	int ret = 0;
+	int ret;
 
 	hrtimer_setup_sleeper_on_stack(&t, clockid, mode);
 	hrtimer_set_expires_range_ns(&t.timer, rqtp, current->timer_slack_ns);

-- 
2.53.0

