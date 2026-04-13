Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD639B94B;
	Mon, 13 Apr 2026 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119747; cv=none; b=DlTqp9B0cGqqZzQazKDBqyrkux9PPkltNqdIDacwONCh5p+lopsCxp1t1wDSFc7r9cmqlIDYfj1knle1Ot4SDn8Lhc7xk3VsliSJrpiCP3Id5ISVM/dixmo04s9YscCC3FR0+irIrOCyLD6hPvN77HniQ2gvXLSLmy8LXgtmHbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119747; c=relaxed/simple;
	bh=cJPr/eewsDXnwslvZ/wfB8ztK5whnIbWUfpm+NdLHlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuXrJW2ta75PtUxrdE6apcvqR4jCe5qjqE6fVRExNeCm54oz2YvvV0rBQ8kN/DzoPfJYBcSkztBQF1NLBCIpKNU75udevhmhgX6lXsnawSkO69f6OnJ5WD6B3XWJAU52z8SS71VxFMq/Uc/p+uHt4IooFbhyadKRxA6s8lwNsjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pc0VFNHr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc0VFNHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DE7C2BCB5;
	Mon, 13 Apr 2026 22:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776119747;
	bh=cJPr/eewsDXnwslvZ/wfB8ztK5whnIbWUfpm+NdLHlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pc0VFNHrynioaDOlfr6265PkbrpHPIysMu2Y5LnOKPKlS5olZcWrGiFUHNaZacd1z
	 k8TOs5yEILD49kKNWKOZpuLiPAhJwBd+/Vj+VFLIVjEZ5DNxs29g5Drm9IBoM5efGd
	 koQgCMZjIGtY5r8W1K+0ohjLriAdeSKgAev0aiCHV5LG5npiPpMGyxAwo5k5wJCyAT
	 3AzYofiQmkF3zMKvb1TYDOSZEvCp8fSnbBu5RwD/t9BxFhZVxXFcEOByxr85TIZYh2
	 j84q3M+BexeQpya4OzLSHHc4rSYP1yKZEUsBXNGIVewN6dOq4lByyQ4DQIvvNjdksM
	 +HByacM3otTMA==
From: Tom Zanussi <zanussi@kernel.org>
To: rostedt@goodmis.org
Cc: pengpeng@iscas.ac.cn,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/ftrace: Add test case for fully-qualified variable references
Date: Mon, 13 Apr 2026 17:35:38 -0500
Message-ID: <ce9d96aeb84b2d40bd469fe9a346e225442873b1.1776112478.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776112478.git.zanussi@kernel.org>
References: <cover.1776112478.git.zanussi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test adds a variable (ts0) to two events (sched_waking and
sched_wakeup) and uses a fully-qualified variable reference to
expicitly choose a particular one (sched_wakeup.$ts0) when calculating
the wakeup latency.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 .../trigger-fully-qualified-var-ref.tc        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-fully-qualified-var-ref.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-fully-qualified-var-ref.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-fully-qualified-var-ref.tc
new file mode 100644
index 000000000000..8d12cdd06f1d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-fully-qualified-var-ref.tc
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test fully-qualified variable reference support
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
+
+fail() { #msg
+    echo $1
+    exit_fail
+}
+
+echo "Test fully-qualified variable reference support"
+
+echo 'wakeup_latency u64 lat; pid_t pid; int prio; char comm[16]' > synthetic_events
+echo 'hist:keys=comm:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_waking/trigger
+echo 'hist:keys=comm:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/sched_wakeup/trigger
+echo 'hist:keys=next_comm:wakeup_lat=common_timestamp.usecs-sched.sched_wakeup.$ts0:onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,sched.sched_waking.prio,next_comm) if next_comm=="ping"' > events/sched/sched_switch/trigger
+echo 'hist:keys=pid,prio,comm:vals=lat:sort=pid,prio' > events/synthetic/wakeup_latency/trigger
+
+ping $LOCALHOST -c 3
+if ! grep -q "ping" events/synthetic/wakeup_latency/hist; then
+    fail "Failed to create inter-event histogram"
+fi
+
+if ! grep -q "synthetic_prio=prio" events/sched/sched_waking/hist; then
+    fail "Failed to create histogram with fully-qualified variable reference"
+fi
+
+echo '!hist:keys=next_comm:wakeup_lat=common_timestamp.usecs-sched.sched_wakeup.$ts0:onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid,sched.sched_waking.prio,next_comm) if next_comm=="ping"' >> events/sched/sched_switch/trigger
+
+if grep -q "synthetic_prio=prio" events/sched/sched_waking/hist; then
+    fail "Failed to remove histogram with fully-qualified variable reference"
+fi
+
+exit 0
-- 
2.43.0

