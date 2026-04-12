Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5937CD4D
	for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Apr 2026 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022076; cv=none; b=ETTSWjy9IRczGmdd/COvjtlsNsI9g0BMdzTQWdSCIivBRW59JwrvWTcL7vDLFJcwknRXexb9KiX16DqmHJ1VGni0tNENStmiK/FFQA9Yj0TDvC446HHbqDNE0gClNNDXAT8DL7vawRtAixGfaFLB9JFDIconiU96ctzzBysVVSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022076; c=relaxed/simple;
	bh=GdFhYrbIhKqz80UHH45O3JlwzMOM66lrkoZ09yk7ZrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R3rxeHeAa5IqU9eC7Y0wDUV3y/Yb/pdVoyDm3R+KXBLlDXdTMawGvxsBsfIHnhafpXCH0qW4O6P3CsH6FYQKK6v+PJufirBXtXsrzphWfNuOYLQqAEZ0/MWPv+YCRi5D4kFFCZlWaG17awt31CnFSQ8QRx1eH4eL0/yk5SEYvKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Aq4KVV3x; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Aq4KVV3x"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776022073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WmZ7CDJWgi1NBkVgSeei7vSPiJJzLZETjykTdWVNVKM=;
	b=Aq4KVV3xn9Ky+vd3bJUR9TmXtGLS2eMoYelUY9a31+nLI9ym4yyivuZgGW27yQmB+jiOZU
	pdUOSuo9jJcQJyHYouq/0S8uXkfS6zsfEZH9jNfWQZvsYOYuGTPjjeGeO+3LlGwti/LoAF
	3nQRbDJRINe7UdzYYUc+icPfb0osk7Q=
From: wen.yang@linux.dev
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH 1/4] rv/tlob: Add tlob model DOT file
Date: Mon, 13 Apr 2026 03:27:18 +0800
Message-Id: <64122474633aa17d872a7dc6233d7794e80f2784.1776020428.git.wen.yang@linux.dev>
In-Reply-To: <cover.1776020428.git.wen.yang@linux.dev>
References: <cover.1776020428.git.wen.yang@linux.dev>
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
budget) deterministic automaton.

The model has three states: unmonitored, on_cpu, and off_cpu.
trace_start transitions from unmonitored to on_cpu; switch_out and
switch_in cycle between on_cpu and off_cpu; trace_stop and
budget_expired return to unmonitored from either active state.
unmonitored is the sole accepting state.

switch_in, switch_out, and sched_wakeup self-loop in unmonitored;
sched_wakeup self-loops in on_cpu; switch_out and sched_wakeup
self-loop in off_cpu.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 MAINTAINERS                        |  3 +++
 tools/verification/models/tlob.dot | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 tools/verification/models/tlob.dot

diff --git a/MAINTAINERS b/MAINTAINERS
index 9fbb619c6..c2c56236c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23242,7 +23242,10 @@ S:	Maintained
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
index 000000000..df34a14b8
--- /dev/null
+++ b/tools/verification/models/tlob.dot
@@ -0,0 +1,25 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_unmonitored"};
+	{node [shape = ellipse] "unmonitored"};
+	{node [shape = plaintext] "unmonitored"};
+	{node [shape = plaintext] "on_cpu"};
+	{node [shape = plaintext] "off_cpu"};
+	"__init_unmonitored" -> "unmonitored";
+	"unmonitored" [label = "unmonitored", color = green3];
+	"unmonitored" -> "on_cpu" [ label = "trace_start" ];
+	"unmonitored" -> "unmonitored" [ label = "switch_in\nswitch_out\nsched_wakeup" ];
+	"on_cpu" [label = "on_cpu"];
+	"on_cpu" -> "off_cpu" [ label = "switch_out" ];
+	"on_cpu" -> "unmonitored" [ label = "trace_stop\nbudget_expired" ];
+	"on_cpu" -> "on_cpu" [ label = "sched_wakeup" ];
+	"off_cpu" [label = "off_cpu"];
+	"off_cpu" -> "on_cpu" [ label = "switch_in" ];
+	"off_cpu" -> "unmonitored" [ label = "trace_stop\nbudget_expired" ];
+	"off_cpu" -> "off_cpu" [ label = "switch_out\nsched_wakeup" ];
+	{ rank = min ;
+		"__init_unmonitored";
+		"unmonitored";
+	}
+}
-- 
2.43.0

