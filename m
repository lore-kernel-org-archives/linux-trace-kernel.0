Received: from mta0.migadu.com (out-74.mta0.migadu.com [91.218.175.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E611C3ACEE0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789413242; cv=none; b=e4zyO7zN8nWmJIu33E8Qoa62fnIiu0e1WdinZByix1TIYRCIrnyGjHjBa72/mlUI1E3+arPVyv5ZEbqAUendmhZgfOHPt0jnMBlRqR3y/rioXVIyQNaqWg4BbHJnQo1bNywMLaNcRVI4gPdXEgcYWx6QaiM9LGBI5Atuwo3K4so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789413242; c=relaxed/simple;
	bh=+4kR8MIFX6t5QidLegcaQ2NHPJ54cO3nz9NAO9k7Jtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWXkESl9MOre/oNnsd10kkSmKc6n7aXyydmdDGcrfVJWjt89jUrbGlOZNv10vPi/CIWgUsAR6IDkpiQCzVIs7Qmg0fQDkMllwB4IlDBkJ4jrI6FixFLYw8hHKVElRIGnwoGM8z9Nh/qCSxPHh38CysuQ6u2t3sLmA8ZuYS9PPGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FLJAM3Hg; arc=none smtp.client-ip=91.218.175.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FLJAM3Hg"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+4kR8MIFX6t5QidLegcaQ2NHPJ54cO3nz9NAO9k7Jtc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789413234; v=1; x=1790018034;
 b=FLJAM3HgLUre2b7FRUVga6aPVoCsw03u17EeF6gxeC5+5r/VceviZN+JqBk/HL4pyQuC1Oid
 GF0ZWsqp2iogor2TXJbEX4QIhy6szGpFst6jDrGz62EHOlQUyuCwlr2D+/oSd+ObaMEbIaAghwM
 KXEoTOx6evekxP74FPbXQgzc=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 72d3a83f1702b20c;
	Mon, 14 Sep 2026 19:13:54 +0000
X-Mizu-Trace-ID: 72d3a83f1702b20c
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH v6 1/4] rv/reactors: use LD_WAIT_SPIN as the reactor lockdep wait type
Date: Tue, 15 Sep 2026 03:13:34 +0800
Message-Id: <5586dd00789a0f904cc299cd8889744b8c6f8dc9.1789412799.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1789412799.git.wen.yang@linux.dev>
References: <cover.1789412799.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

rv_react() overrides the lockdep wait type to LD_WAIT_FREE to enforce
that reactor callbacks take no locks. But callbacks run in the context
of the triggering tracepoint, which can be preemptible task context on
any kernel. A timer interrupt firing during the callback makes the
interrupt-exit path schedule and take rq->__lock (LD_WAIT_SPIN) while
the LD_WAIT_FREE override is still held, producing a spurious
"Invalid wait context" warning:

    [ BUG: Invalid wait context ]
    context-{5:5}
    1 lock held by kunit_try_catch/209:
     #0: (rv_react_map-wait-type-override){+.+.}-{1:1}
    kunit_try_catch/209 is trying to lock:
    ffff8a743ed3e8a0 (&rq->__lock){-...}-{2:2}

Use LD_WAIT_SPIN instead of LD_WAIT_FREE, which causes false-positive
warnings in preemptible contexts due to scheduler preemption taking
rq->__lock.

Fixes: 69d8895cb9a9 ("rv: Add explicit lockdep context for reactors")
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/trace/rv/rv_reactors.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 2f5fc8d18dea..ff7d478227c3 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -465,7 +465,15 @@ int init_rv_reactors(struct dentry *root_dir)
 
 void rv_react(struct rv_monitor *monitor, const char *msg, ...)
 {
-	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
+	/*
+	 * Reactors must not explicitly take locks, so they should be
+	 * LD_WAIT_FREE.  However, reactor callbacks can run with preemption
+	 * enabled, meaning the preempting code (e.g. the scheduler taking
+	 * rq->__lock at LD_WAIT_SPIN) may violate that constraint.  Use
+	 * LD_WAIT_SPIN to avoid false-positive lockdep reports.
+	 * But you should still NOT be using locks in reactors.
+	 */
+	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_SPIN);
 	va_list args;
 
 	if (!rv_reacting_on() || !monitor->react)
-- 
2.25.1

