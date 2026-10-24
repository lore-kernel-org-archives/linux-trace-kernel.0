Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859220;
	b=Cnr7FU+nynZARcCAOoJjO3EnbwoIUsQOquWvEnWsYufPTYXXvzqBKuFpt8pHve23lQ61
	 bMCnYJSqNqZxLcrk1+XsRXDtFF2/b4U4LRURDEcNwU9d8ORjRCgu2HGC8RN0KQ9vmaLr4
	 yd/ORRI/HVzn2zApWMsRofjdkXNA+0ta0eKTGZEDM4W+SQVo+lV1WoNBxO43j2tSB5i3q
	 rhhfqEfw4I1GtqDikHrBgQpUtBgjXQ6vZc/qnsPKWWtXDzmkGLoEMWqKbFfc+qfMO25Qm
	 bREnOghb9pjL5IQbjszQ+rHhxxW8jKI67LG7vasyknvfdz5fEDwKrc6xNzbxIHuOc2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859220;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=A/Elg2VGIiiKUhU95MSseS/kc7VdURgqQOZScaQReX0=;
	b=nIOIDpo+a1uFjH1bgr6sBr8DWg4NaQp59MizgcjcTqofRnFErttMo4S76s+4l9JcuZmO
	 fHnSgh4MgW7GbKueWoLIqgJM2IdQryU7/hUS4EapcIJCbzTj61mdOYetRPqekegALb/ju
	 F6czafN52GRog93tOyB5UmlJCucxSyB/0Sy77kM3ompc0a/yJxFZskowuQmw2twIH68K3
	 BPztxbfvggBWupsFSRkpqnntaXIT+4p7nVkf91nuEvP+PLZReIJk5wb+y50agWXPUlDkW
	 y6yZufodugjeicAumWCa/d2f8bRRvyPqPI0T8o3gLMvDLjKw5GmFmFElthczg69FcFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3UHEVNS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EAE606A31A;
	Sat, 24 Oct 2026 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G3UHEVNS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6D11F01828;
	Sat, 24 Oct 2026 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859219;
	bh=A/Elg2VGIiiKUhU95MSseS/kc7VdURgqQOZScaQReX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G3UHEVNSaks1iOmIJrWm8Q6ociwN6rNuXS4p4MAPXnc/A4Aa3I4c/sCauVLreSNjd
	 T7Lix7lZVHzJsgqy9d53yxlsiGra1zeAJLX1N/yua7ZPz5wz8fftLpFDLGQgD027ht
	 Cm/9r71KvNv+rxfatYahs8rKI4o05QCZoy1SysNvLFpNLcOmIl4bNIpVmLOds7dELT
	 gqOk/Y95yHk9ZLcHywJEkM3S62J8br+Sln0gOccjOSZGyYNpQAJClBS32YlydUMVS/
	 no7nll/soCk7RSXrEcINNUWPxTrgSuQSvB3h3tqrCKCwHiwN5ZOdLSpeUSXl9Sqmcx
	 njIU4uNzh9LDg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 10/10] selftests/ftrace: Add event filter syntax check test case
Date: Sun, 25 Oct 2026 01:26:56 +0900
Message-ID: <179285921665.466249.3671034793634001868.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179285912318.466249.7425922682086130057.stgit@devnote2>
References: <179285912318.466249.7425922682086130057.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add a new ftracetest test case (filter-syntax-check.tc) to verify valid
event filter expressions, error_log caret reporting for malformed filter
expressions (empty filters, missing fields, unbalanced parentheses and
quotes, dangling logical operators, invalid fields/values/cpulists),
newline truncation on multi-line filter input, and error returns on
invalid subsystem filters.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/filter/filter-syntax-check.tc    |   52 ++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/filter/filter-syntax-check.tc

diff --git a/tools/testing/selftests/ftrace/test.d/filter/filter-syntax-check.tc b/tools/testing/selftests/ftrace/test.d/filter/filter-syntax-check.tc
new file mode 100644
index 000000000000..68c8accc5ffd
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/filter/filter-syntax-check.tc
@@ -0,0 +1,52 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event filter - test filter syntax error check
+# requires: set_event events/sched/sched_switch/filter error_log
+# flags: instance
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'event filter parse error' "$1" 'events/sched/sched_switch/filter'
+}
+
+# Valid filter expressions
+echo '(common_pid == 0)' > events/sched/sched_switch/filter
+echo '((common_pid == 0) && (prev_pid == 0))' > events/sched/sched_switch/filter
+echo 'prev_comm ~ "*sh"' > events/sched/sched_switch/filter
+echo 'common_pid == CPUS{0}' > events/sched/sched_switch/filter
+echo 'common_pid != CPUS{0}' > events/sched/sched_switch/filter
+echo 0 > events/sched/sched_switch/filter
+
+# Empty or meaningless filter expressions
+check_error '^()'						# NO_FILTER
+check_error '=^= 1'						# INVALID_FILTER
+
+# Unbalanced parentheses and quotes
+check_error '^(common_pid == 1'					# TOO_MANY_OPEN
+check_error 'common_pid == 1^)'					# TOO_MANY_CLOSE
+check_error 'prev_comm == ^"bash'				# MISSING_QUOTE
+
+# Dangling logical operators
+check_error 'common_pid == 1 &&^'				# TOO_MANY_PREDS
+check_error 'common_pid == 1 ||^'				# TOO_MANY_PREDS
+check_error 'common_pid == 1 || (common_pid == 2 && )^'		# INVALID_FILTER
+
+# Invalid field, operator, or operand value
+check_error 'no_such_field ^== 1'				# FIELD_NOT_FOUND
+check_error 'common_pid == @^'					# INVALID_VALUE
+check_error 'common_pid == CPUS0}^'				# MISSING_BRACE_OPEN
+check_error 'common_pid == CPUS{}^'				# INVALID_CPULIST
+
+# Multi-line input must be truncated at the first newline
+echo > error_log
+! ( printf "common_pid == CPUS{0\n\"} && common_pid == 0 && common_pid == CPUS{0\n\"}" | \
+    dd of=events/sched/sched_switch/filter bs=4096 ) 2> /dev/null
+grep -q "Missing '}'" error_log
+! grep -q "Missing matching quote" error_log
+
+# Subsystem filter must fail on invalid filter expressions
+echo 'common_pid >= 0' > events/sched/filter
+! echo 'no_such_field == 1' > events/sched/filter
+! echo 'common_pid == 1 &&' > events/sched/filter
+echo 0 > events/sched/filter
+
+exit 0

