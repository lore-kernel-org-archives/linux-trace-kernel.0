Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A49047DFB5
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523936; cv=none; b=Gyj7nPUUbYtuh++i5j20wDd0vI1xLWFc4GI2nR8egNXXFSlGJclQY84AT8oq5N/vJjNc9wkzuAE2XvNKMB0HbRUaBHzglyHmpYm3IhRJTD45Jvwd5v0B50XHUQ9m7RGDfRByFsXacbKCl1QaK+93pWg4Y2Z6nC+xxA5ivb78Vok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523936; c=relaxed/simple;
	bh=P4iAu2y1WYRKIWrbM8V+pf5m9s4kdbFvRct0dVmz3mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ml7PwcKXcWAR6AocXCYtIqZ58JxlP2NmOERP9KOyNJdEI2ISvBWTPyoLLxsMSzTGoTJLgn06pi+7zwNmKWeF9GpEYrQJ1z/vSVNEzELRksoOaP2W/9wyp5rErnLV1B+x86vC+Oc1i8FmxcYOVefPlqEgq+CeDobtHd/ax5hSNMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TLT0uH/e; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TLT0uH/e"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778523933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ltI/qJggpko9gP6TfxD/MZJvsOySJfuz1/BGvhgs6fE=;
	b=TLT0uH/eGuM7vfWexGAXC3IuIJjuyuEtUv4XeAL+1BP5hHGpvxQCAP8fBakPUVMY3xmYeG
	90NSzrs30vM0BqQsqngxkKUtObrQmojul7bFcHqj5DssQjz6mJq3J5FssBCvQG5f/nDYMy
	XJrHOUeZNdd1DgPRzbvkrQoeshx3Yjo=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH v2 07/10] rv/tlob: add tlob model DOT file
Date: Tue, 12 May 2026 02:24:53 +0800
Message-Id: <5ed278ec33f219bb646a5bd37d6b55da7dcbbd8a.1778522945.git.wen.yang@linux.dev>
In-Reply-To: <cover.1778522945.git.wen.yang@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Add the Graphviz DOT specification for the tlob (task latency over
budget) hybrid automaton.

The model defines three states: running (initial), waiting
(in the scheduler runqueue), and sleeping (blocked on a
resource), with the transitions:

  running  --(sleep)-------> sleeping
  running  --(preempt)-----> waiting
  sleeping --(wakeup)------> waiting
  waiting  --(switch_in)--> running

A single clock invariant clk_elapsed < BUDGET_NS() is active in all
three states.  The HA framework enforces it via a per-task hrtimer;
expiry emits error_env_tlob and resets the monitor automatically.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com> 
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 MAINTAINERS                        |  3 +++
 tools/verification/models/tlob.dot | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 tools/verification/models/tlob.dot

diff --git a/MAINTAINERS b/MAINTAINERS
index 74c86cf9bc65..beb7224d08ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23317,7 +23317,10 @@ S:	Maintained
 F:	Documentation/trace/rv/
 F:	include/linux/rv.h
 F:	include/rv/
+F:	include/uapi/linux/rv.h
 F:	kernel/trace/rv/
+F:	samples/rv/
+F:	tools/testing/selftests/rv/
 F:	tools/testing/selftests/verification/
 F:	tools/verification/
 
diff --git a/tools/verification/models/tlob.dot b/tools/verification/models/tlob.dot
new file mode 100644
index 000000000000..8421b1120e80
--- /dev/null
+++ b/tools/verification/models/tlob.dot
@@ -0,0 +1,21 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_running"};
+	{node [shape = ellipse] "running"};
+	{node [shape = plaintext] "running"};
+	{node [shape = plaintext] "waiting"};
+	{node [shape = plaintext] "sleeping"};
+	"__init_running" -> "running" [ label = "reset(clk_elapsed)" ];
+	"running"  [label = "running\nclk_elapsed < BUDGET_NS()",  color = green3];
+	"waiting"  [label = "waiting\nclk_elapsed < BUDGET_NS()"];
+	"sleeping" [label = "sleeping\nclk_elapsed < BUDGET_NS()"];
+	"running"  -> "sleeping" [ label = "sleep" ];
+	"running"  -> "waiting"  [ label = "preempt" ];
+	"waiting"  -> "running"  [ label = "switch_in" ];
+	"sleeping" -> "waiting"  [ label = "wakeup" ];
+	{ rank = min ;
+		"__init_running";
+		"running";
+	}
+}
-- 
2.25.1

