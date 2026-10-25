Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792917515;
	b=1w12mkuNuCJGf+1vbfwDQoZ1l5mazCVh9+oTD6JijvP/nqIKLrO1cNqxWbPKGG3mXPz9
	 GukXcnmrU1C72g4zcbzNQmTRxYxc5yhBvl71QxtHldza7ghUX/Djka2a77MqjTK/f+KYY
	 UR0aiRKCa16/4+La1KrK8E5sxITvFEymcAf8FLYWwXZlNbgbiipn1qQF3lwsfFugEiDUP
	 Y+gnYvYGGwNwfU7cHukrHdFE1Hj+/bMGggO7caLFXYv80xm28NYL/Ys3EV1yYzGY507p4
	 8OYiwu/jCVo/1SsCc/mmC4aaESqriGoXTUrDzoEUADjz03vJzo/Wns3MXzUiDGP7O4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792917515;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=A/Elg2VGIiiKUhU95MSseS/kc7VdURgqQOZScaQReX0=;
	b=UhDILMPX/wHl4bGOxzELiKMXuaAGhvRpv+RKwvt9KsXub2tEhSXAbwYLAIuFMnhDeMMD
	 EJCAXjebYVBj25B/SWzGQ501bqvgfdGWLEw+BQMRodEr4yVf1GprOZUBNFn+Lw1vSOpWh
	 A1dHtP9GoJ3BNfctegjzKrmqjhyaoxo0KsiH9OSwz5CKmSPpPWfrzDHhXwDvrFfMKn6Pj
	 ZeoRQWOju/IXLqvE0ydwkqN6O5F+IrizlOaB8uM/ZZMRTn0v3stE4q3GLc0JctpcPPbJ/
	 8HbXz38hhSKOPsanNaw+B8bnunK0GL+3zLX8ieUV7orGOBpSzSzDWaj5yT7QUkfXkWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ms2qoi63;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F61606A31D;
	Sun, 25 Oct 2026 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ms2qoi63
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449B91F01825;
	Sun, 25 Oct 2026 08:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792917514;
	bh=A/Elg2VGIiiKUhU95MSseS/kc7VdURgqQOZScaQReX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ms2qoi63lBBFJ7PjZe7eadwYRkKadPH9FFLg2JXvA4lUCfr4s6n6ft2r0XY31B8bF
	 4gqyAZGdu/EYTGE0b/+UzuRgTkFnmhCwMLp0LzPGMV95qW1RnsitGrV/T6Ysi7j531
	 VzXiTqo+kFTpPAxq7nV77rV7NR2X/psVxlALdKD0HgWRHWnzX+aRYgpKbep3sLCJLK
	 YLvS75w6vFx/Ert3DDRoDAmkIWJMxTSD59i93MLA5DmsrKWwu2L7IMs3Pd2ezz53RF
	 6CPd5VnynW9k6aO1cWR/HTp2gTKnre/i9DXNeK/rTJJaPtFjc4/+vbd3eivvv+Rw4n
	 EuFh8WZWr0ywA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 9/9] selftests/ftrace: Add event filter syntax check test case
Date: Sun, 25 Oct 2026 17:38:31 +0900
Message-ID: <179291751117.492959.1147654467208615243.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179291742944.492959.11659339795290028998.stgit@devnote2>
References: <179291742944.492959.11659339795290028998.stgit@devnote2>
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

