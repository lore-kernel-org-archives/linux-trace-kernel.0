Received: from mta0.migadu.com (out-13.mta0.migadu.com [91.218.175.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAFE48C3EF
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854988; cv=none; b=n0NcgZ6DlMlQR0dD3lnmFJmF+ZbWPqtGNAOA22LFkcm7Yy1/PgJGZXvrvAirlli0J89SS5tAb95cS7ITx1lgssaprC2e9NS4OIkBuj4+Exd1dZYsdhaLgLHQNAbFl6+iP4HHvNUsR/okBX90Pz8q/gOnfv0igsJwoXzuxKkkuck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854988; c=relaxed/simple;
	bh=8cCS/yHD0Hxn9OGFpeTmmVcyFPIB1KOkunFFvBFQ880=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIZVgsv26dDG/lBbYhhab2Jmpln7+5zQ8SME92KKd6zmnyDy1R0OEhmM51aP7hOYj3RliQPsOehO0XndeKz3Y7uf9JJDcVzNoB4JspqCo7hHR+8qLk+tGrLsaJAYR8+QyN/tS5fd0vXNV+vIqvRjM7ifD7AOSllBh++W4Mjwrdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HV+iovnn; arc=none smtp.client-ip=91.218.175.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HV+iovnn"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8cCS/yHD0Hxn9OGFpeTmmVcyFPIB1KOkunFFvBFQ880=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787854983; v=1; x=1788459783;
 b=HV+iovnnYiFMRsuW2VgmY4ab6e6nlmPsBITnW9eXaTPpW6ruBiKp9EXlSCOFL0bQ2AqEEVQD
 tPE/JSRL0j+TDsms/2s5rIsaJVCd+y9xDOjJw72xb3AcHs2yINUvG4I95cNlj8Uz02qqfuQyoSw
 wx17/fYBQTeTNkT7qmqEKOAU=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 293872663368d0fc;
	Thu, 27 Aug 2026 18:23:03 +0000
X-Mizu-Trace-ID: 293872663368d0fc
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH v4 1/4] rv/reactors: use LD_WAIT_SPIN as the reactor lockdep wait type
Date: Fri, 28 Aug 2026 02:22:43 +0800
Message-Id: <7bfe97bd497a2641de36b35e17f69e6f3f291c2a.1787854397.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1787854397.git.wen.yang@linux.dev>
References: <cover.1787854397.git.wen.yang@linux.dev>
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
rq->__lock. Add documentation to runtime-verification.rst.

Fixes: 69d8895cb9a9 ("rv: Add explicit lockdep context for reactors")
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 Documentation/trace/rv/monitor_synthesis.rst | 20 ++++++++++++++++++++
 kernel/trace/rv/rv_reactors.c                |  6 +++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/rv/monitor_synthesis.rst b/Documentation/trace/rv/monitor_synthesis.rst
index 2c1b5a0ae154..aab4b0342d5f 100644
--- a/Documentation/trace/rv/monitor_synthesis.rst
+++ b/Documentation/trace/rv/monitor_synthesis.rst
@@ -365,6 +365,26 @@ but higher overhead. The timer wheel (``HA_TIMER_WHEEL``) is a good alternative
 for monitors with several instances (e.g. per-task) that achieves lower
 overhead with increased latency, yet without compromising precision.
 
+Reactors
+--------
+
+A reactor is a callback triggered by a monitor when a violation is
+detected. Reactors are registered via ``/sys/kernel/tracing/rv/reactors/``
+and enabled per monitor.
+
+Reactor Locking Rules
++++++++++++++++++++++
+
+A reactor callback may be invoked from various contexts (process,
+softirq, hardirq, NMI) depending on the tracepoint to which its
+monitor is attached.
+
+Lockdep uses a fixed wait type: ``LD_WAIT_SPIN``. This allows
+``raw_spinlock_t`` but disallows sleepable locks. ``LD_WAIT_FREE`` is
+not viable in preemptible contexts because scheduler preemption takes
+``rq->__lock`` (``LD_WAIT_SPIN``), which would cause false-positive
+warnings.
+
 Final remarks
 -------------
 
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 2f5fc8d18dea..afc97d097109 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -465,7 +465,11 @@ int init_rv_reactors(struct dentry *root_dir)
 
 void rv_react(struct rv_monitor *monitor, const char *msg, ...)
 {
-	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
+	/*
+	 * Use LD_WAIT_SPIN uniformly for deterministic lockdep checking.
+	 * See Documentation/trace/rv/runtime-verification.rst.
+	 */
+	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_SPIN);
 	va_list args;
 
 	if (!rv_reacting_on() || !monitor->react)
-- 
2.25.1

