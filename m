Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814FC3264EF
	for <linux-trace-kernel@vger.kernel.org>; Sun,  2 Aug 2026 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785696214; cv=none; b=n1ifCoCLZoNTNnxg7b+KgZjHHz2H1YW7U8NW141mx7rojwjFz6+/w1Ans15r90iTpfVKq4XCL214kRkKclAM2L6J1FfEZokMX7RV42CcDgxwPlwvDkO/rYeeErotKey+vP+bQarBKxd+pPONeBZlRXEkPblSEu/dREVuIXGkGoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785696214; c=relaxed/simple;
	bh=TxRBgbTF3yjk8RfdptAdirInkEmw8cmqXAbU2gNLvSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oova4aJxPZjP8NJ4PN/bFmy/zAlFlrKR0Z8Qp7ZtRZJsSUEUolDO5U6OYEw0Vw2fdHdeMI8jzd6BNwH6glNhciBnk6q5//Pj7mQWNx5Ii2j5fuSUzoYnej7gMgarnNDl7KFC2ebiOR8Q3+BtE8GCdkEvQLV26M1ORIqVOhxWdcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=chipe/nk; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="chipe/nk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785696210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xfGZ5mxxGbASPb597QUgHIhYoVOQiaIlYyKMsccGqd4=;
	b=chipe/nkubhALK+0VxDuFC/AmMUifQNxMB9sj4VcIlaDoqiiBEqTYRc+D9hCATpRdAJMyO
	ama+D0FOwIyAaK3FXF9ac8QzkeneGJsegTc/UawI3KmAhzAiZEl2nXhv1fuQxO0Wq0pETw
	6eRX3niEtaZQjdLG4833uuhg/b9WI1Q=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH v2 1/4] rv/reactors: use context-sensitive lockdep wait type in rv_react()
Date: Mon,  3 Aug 2026 02:43:02 +0800
Message-Id: <fb4c2c0ab10e32bb02cd7da747a00ef988eaf276.1785695669.git.wen.yang@linux.dev>
In-Reply-To: <cover.1785695669.git.wen.yang@linux.dev>
References: <cover.1785695669.git.wen.yang@linux.dev>
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

The single DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE) in
rv_react() declares wait_type_inner = LD_WAIT_FREE for every execution
context.  In a preemptible context (e.g. CONFIG_PREEMPT_RT or a KUnit
test running on a task), a timer interrupt can fire during a reactor
callback; the interrupt exit path then schedules and acquires rq->__lock
(LD_WAIT_SPIN) while the override map is still held.  Since the map
declares the context to be wait-free, lockdep reports a spurious
"Invalid wait context" warning:

    [ BUG: Invalid wait context ]
    context-{5:5}
    1 lock held by kunit_try_catch/209:
     #0: (rv_react_map-wait-type-override){+.+.}-{1:1}
    kunit_try_catch/209 is trying to lock:
    ffff8a743ed3e8a0 (&rq->__lock){-...}-{2:2}

Use two lockdep override maps, selected by execution context:

  - Preemptible context (task, softirq, PREEMPT_RT irq thread): the
    scheduler may preempt, so use LD_WAIT_SPIN, the tightest wait type
    the scheduler itself uses, to suppress the spurious warning.

  - NMI/hardirq context: preemption is disabled and the scheduler cannot
    run, so the false positive cannot arise.  Keep LD_WAIT_FREE here to
    preserve the original constraint that reactors must not take raw
    spinlocks in atomic context.

Fixes: 69d8895cb9a9 ("rv: Add explicit lockdep context for reactors")
Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/trace/rv/rv_reactors.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 2f5fc8d18dea..cd571b1649f5 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -465,18 +465,25 @@ int init_rv_reactors(struct dentry *root_dir)
 
 void rv_react(struct rv_monitor *monitor, const char *msg, ...)
 {
-	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
+	/*
+	 * A reactor callback can be preempted; the scheduler then takes
+	 * rq->__lock (LD_WAIT_SPIN).  Advertise that in preemptible contexts
+	 * to avoid a spurious lockdep report, and keep LD_WAIT_FREE in atomic
+	 * ones where the scheduler cannot run.
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

