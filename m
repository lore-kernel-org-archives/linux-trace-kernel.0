Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2840D40F8CB
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541917; cv=none; b=RbFQOWYnLL9buTWKeoKosVmlCO8G2vv5fAFKV0Pfy3bj7lKwVCTUx/hW3/hZqWTuT46bmFUdaq+RPtLGIQbBfQeYIr3PhQefGpwkAf51DOTFZsGu+pKAuopFe20jXNbhn71RrlpWBrLlxF/ALJNXEHbToLhgsoWz2Nw/I6JCOJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541917; c=relaxed/simple;
	bh=1dTOkjWvoYDjs250BrOV7EEV/NEB7IEyYzz5Sj4EZvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lk+1cc3+TGki60/SVEMv1PqU1IvuhstEsNcHstfTyQ0U49pA7g5PKIP30OHBij5E675x4m6n0byjT91egmk9zyoLxbYu6A/89Q9elJlNHF25tkl6xbhCkukNCgqF8Os/kwKdzOpnMNks8fu3bM53SlCDq2n9Uoz2Iq8WlHWsyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X5qa88uk; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X5qa88uk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781541914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbMnV1YLBtIqFNk2V7QM3lnwrP4x0eIN/FBmsd24OcM=;
	b=X5qa88ukK9t9CznDxdjpnw8fjdEIU8L1X3kYP7/TdafazXV2NToGQrr1IkWrZocBh0WMw0
	2vOfzWCd/jUxuByrG0WkNYU6UKStV5yXB6TzAUzQQca+84p6koHv9Zl9GiGeEKa7S4zFhI
	aVeBJ1qkO+mqVW2SDdlWAn1Hy5B1eoI=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH 1/3] rv/reactors: fix lockdep "Invalid wait context" in rv_react()
Date: Tue, 16 Jun 2026 00:44:48 +0800
Message-Id: <bc01343ae74acf6bdf142434aeaa4e6b40aa72a9.1781541556.git.wen.yang@linux.dev>
In-Reply-To: <cover.1781541556.git.wen.yang@linux.dev>
References: <cover.1781541556.git.wen.yang@linux.dev>
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

The DEFINE_WAIT_OVERRIDE_MAP() macro creates a lockdep map with
wait_type_inner = LD_WAIT_CONFIG, which inherits the outer context's
wait type.  When rv_react() is called from a LD_WAIT_FREE context
(e.g., a KUnit test with busy-wait), and the reactor callback triggers
a timer interrupt during the busy-loop, the interrupt exit path attempts
to schedule (preempt_schedule_irq -> __schedule -> rq->__lock), which is
LD_WAIT_SPIN.  Lockdep then reports:

    [ BUG: Invalid wait context ]
    context-{5:5}
    1 lock held by kunit_try_catch/209:
     #0: rv_react_map-wait-type-override at rv_react+0x9d/0xf0

The wait_type_override map allowed the outer LD_WAIT_FREE to propagate
inward, but scheduling from an interrupt is LD_WAIT_SPIN, violating the
constraint.

Fix by explicitly setting wait_type_inner = LD_WAIT_SPIN, which is the
tightest constraint rv_react() callbacks must satisfy: they may not
sleep (LD_WAIT_SLEEP) or use mutexes, but can use spinlocks and be
interrupted. This matches the documented LD_WAIT_FREE constraint.

Fixes: 69d8895cb9a9 ("rv: Add explicit lockdep context for reactors")
Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/trace/rv/rv_reactors.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 460af07f7aba..423f843bbd68 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -465,7 +465,13 @@ int init_rv_reactors(struct dentry *root_dir)
 
 void rv_react(struct rv_monitor *monitor, const char *msg, ...)
 {
-	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
+#ifdef CONFIG_LOCKDEP
+	static struct lockdep_map rv_react_map = {
+		.name = "rv_react",
+		.wait_type_outer = LD_WAIT_FREE,
+		.wait_type_inner = LD_WAIT_SPIN,
+	};
+#endif
 	va_list args;
 
 	if (!rv_reacting_on() || !monitor->react)
-- 
2.25.1

