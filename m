Received: from out-182.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF561474CC
	for <linux-trace-kernel@vger.kernel.org>; Sun,  9 Aug 2026 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786295473; cv=none; b=c+kz/aI7vQ7M5qOahHR3uf37JNduSyKykVahemL+9Nv7aJFDrqo5dnLKIF12AT+AS6/6R3Xf/J1KWvFfua1hsJCnLdm+ESj4qFuHkRpEaIynItQjoKeeUgyPzMPdxnGowDAd2wjnX26mjJDsqgNcC4W7Tu/6RGEG0ep2e/phZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786295473; c=relaxed/simple;
	bh=c1gUrWjTy4h7QtYQ5HE07DtR8x4SaBsVSQpOeOpvmlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OywENF7QeN/bOIS1ARqVuEJ7J0IhmfCc3rejBhQgbyhxu+VK5MzuM1Z6AHZ1qMcfKah6POptPSNiLscYkR/ZYfw2m3KKf6EBbCgKnlH5EEY/hfNObyUTP0HUVOdQ5sGcnhA3MKdDKsQFTO3IItPjNt4wbgbLor7/CjpH99AVxlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gfpXjL+M; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gfpXjL+M"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786295469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XpBp+WbQsCcpWpuQO9GCleO3iIrhhT4MJgEdXq+DRcE=;
	b=gfpXjL+MZ850Mbfg64iLeZ+NLNghktQm360N/y4elGeAiH6y987ivzhNKwGku7ImCyYw65
	Y/3P083F+8F1bZbk8D0t9O/tZZb84u0mZx7eVk0v8JYs0MS1TRbhmf/GnB6EkAB/ascWrK
	RmXpec829QDivW0WHgqPvNIU260g258=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH v3 1/4] rv/reactors: use context-sensitive lockdep wait type in rv_react()
Date: Mon, 10 Aug 2026 01:10:38 +0800
Message-Id: <26526e555baa5118325b2383e9f7f0f8f9b6a199.1786294920.git.wen.yang@linux.dev>
In-Reply-To: <cover.1786294920.git.wen.yang@linux.dev>
References: <cover.1786294920.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Reactors must not explicitly take locks, so they should comply with
LD_WAIT_FREE.  However, reactor callbacks can run with preemption
enabled on any kernel (not just PREEMPT_RT).  If a timer interrupt
fires during the callback, the interrupt exit path schedules and
acquires rq->__lock (LD_WAIT_SPIN) while the lockdep override map that
declared LD_WAIT_FREE is still held, triggering a spurious
"Invalid wait context" warning:

    [ BUG: Invalid wait context ]
    context-{5:5}
    1 lock held by kunit_try_catch/209:
     #0: (rv_react_map-wait-type-override){+.+.}-{1:1}
    kunit_try_catch/209 is trying to lock:
    ffff8a743ed3e8a0 (&rq->__lock){-...}-{2:2}

Fixes: 69d8895cb9a9 ("rv: Add explicit lockdep context for reactors")
Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/trace/rv/rv_reactors.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 2f5fc8d18dea..5830229210e8 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -465,18 +465,28 @@ int init_rv_reactors(struct dentry *root_dir)
 
 void rv_react(struct rv_monitor *monitor, const char *msg, ...)
 {
-	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
+	/*
+	 * Reactors must not explicitly take locks, so they should be
+	 * LD_WAIT_FREE.  However, reactor callbacks can run with preemption
+	 * enabled, meaning the preempting code (e.g. the scheduler taking
+	 * rq->__lock at LD_WAIT_SPIN) may violate that constraint.  Use
+	 * LD_WAIT_SPIN in preemptible contexts to avoid false-positive lockdep
+	 * reports; keep LD_WAIT_FREE in NMI/hardirq where preemption is
+	 * disabled and the scheduler cannot run.
+	 */
+	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map,        LD_WAIT_SPIN);
+	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map_atomic, LD_WAIT_FREE);
+	struct lockdep_map * __maybe_unused map;
 	va_list args;
 
 	if (!rv_reacting_on() || !monitor->react)
 		return;
 
+	map = (in_nmi() || in_hardirq()) ? &rv_react_map_atomic : &rv_react_map;
 	va_start(args, msg);
-
-	lock_map_acquire_try(&rv_react_map);
+	lock_map_acquire_try(map);
 	monitor->react(msg, args);
-	lock_map_release(&rv_react_map);
-
+	lock_map_release(map);
 	va_end(args);
 }
 EXPORT_SYMBOL_GPL(rv_react);
-- 
2.25.1

