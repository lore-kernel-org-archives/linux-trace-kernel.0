Received: from mta1.migadu.com (out-101.mta1.migadu.com [95.215.58.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BE744E66C
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747647; cv=none; b=X7znJiqhNecR54FYjggBvae6zz6n+0DCmq6d6GSrQltcvoTFur5BGC9cF3mliCnFHA1KT6DeVAj4EHi5h+NELFuKYwrBMbILrfChnt7Wt+7qadH3BE63jGwZ2zVg1ssjlE51OMvMK4LVyNStI3JlrnBxs1Qzl+cgsSmgYXYSMQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747647; c=relaxed/simple;
	bh=X8Jh5EH8xL3BV+TF+inqe7PXc7xM9UMIAqG2HCny/8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NFBdZykunUF81CENK9f1AEUQLgsEukfPg19fkIFbr1QCH1jGJx3t47kiGzGiQpiqNNsxW28uQ3UAtpKy9tIHXCZeZJDmHLjwI+Bx+uJE7BqDdgWZx4LpfccjzrTA7+wsM+kEpXDDqKO4fXmslil2B2wh9hijubG65yhRsemlSfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wEQzhoSz; arc=none smtp.client-ip=95.215.58.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wEQzhoSz"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=X8Jh5EH8xL3BV+TF+inqe7PXc7xM9UMIAqG2HCny/8k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791747643; v=1; x=1792352443;
 b=wEQzhoSzpmM+ARoFmUHjOEZuRu+kw/c157SyHluY3ZbZKtkmZ2jhhOMzAlU/3UUsXTLBNlsA
 iaGQl4BOjtUe6V9++XKPJVmXNTRTgEtSV3cdAMCfeVl9GAsd6D/q3tgdLesbbFBo5CnMdyab9rD
 1evnVRpYkzThCg8YhnKVwGVI=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 97d74d0c3dd36158;
	Sun, 11 Oct 2026 19:40:25 +0000
X-Mizu-Trace-ID: 97d74d0c3dd36158
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v7 10/14] rv: Add tlob model DOT file
Date: Mon, 12 Oct 2026 03:39:16 +0800
Message-Id: <1a8527075e4829a4f3e03bd57ba168f324af029b.1791745088.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Add the Graphviz DOT specification of the tlob hybrid automaton to
tools/verification/models/.

The model has four states (stopped, running, waiting, sleeping) and six
events (start, stop, sleep, preempt, wakeup, switch_in).  A single clock
invariant, clk_elapsed < BUDGET_NS(), holds in running, waiting and
sleeping; stopped has no invariant, hence no timer.

wakeup is a self-loop on running and waiting: a task that is already
queued can still be the target of a traced wakeup, either by waking
itself or through ttwu_runnable() while preempted, and neither case ends
the budget window.  stopped takes every scheduler event as a self-loop,
so a task keeps going through the scheduler between windows.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 tools/verification/models/tlob.dot | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 tools/verification/models/tlob.dot

diff --git a/tools/verification/models/tlob.dot b/tools/verification/models/tlob.dot
new file mode 100644
index 000000000000..021a4d823548
--- /dev/null
+++ b/tools/verification/models/tlob.dot
@@ -0,0 +1,27 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_stopped"};
+	{node [shape = plaintext] "running"};
+	{node [shape = plaintext] "waiting"};
+	{node [shape = plaintext] "sleeping"};
+	{node [shape = ellipse] "stopped"};
+	"__init_stopped" -> "stopped";
+	"running"  [label = "running\nclk_elapsed <= BUDGET_NS()"];
+	"waiting"  [label = "waiting\nclk_elapsed <= BUDGET_NS()"];
+	"sleeping" [label = "sleeping\nclk_elapsed <= BUDGET_NS()"];
+	"stopped"  [label = "stopped", color = green3];
+	"running"  -> "sleeping" [ label = "sleep" ];
+	"running"  -> "waiting"  [ label = "preempt" ];
+	"running"  -> "running"  [ label = "wakeup" ];
+	"waiting"  -> "running"  [ label = "switch_in" ];
+	"waiting"  -> "waiting"  [ label = "wakeup" ];
+	"sleeping" -> "waiting"  [ label = "wakeup" ];
+	"running"  -> "stopped"  [ label = "stop" ];
+	"stopped"  -> "running"  [ label = "start;reset(clk_elapsed)" ];
+	"stopped"  -> "stopped"  [ label = "preempt\nsleep\nswitch_in\nwakeup" ];
+	{ rank = min ;
+		"__init_stopped";
+		"stopped";
+	}
+}
-- 
2.25.1

