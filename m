Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237988;
	b=W60CDXnb3trvniO6c4nGy8a9anXYPmr0TAfzi4hAKCUHFvKC2t7Kk2n8LDuGv+Y1hNlx
	 BGv//mjHo7iVhxIAorHGjf1ewBCl7gaFFh7SMg5xb9dx72lxzJA6Qjor2qbW93rHRVtAD
	 n78zU03YbPAVyVdGVSoR0DHBYZQyfhMxnfrqhB/JUcKS4qnZ6NDxVpItRtMCeob9k6NvO
	 4S1B1UVYFzJZzlNCfibn09JTFq6hO861iVBSwFpLFeWWv6IcycVV5vYcgr7iPRqsjk2er
	 FoKPD6P7mcwh82Ll0TakGSH9Mx3mH6bNEWu0U7Q6RtytyrT2qvjGFjGmVmwG+GfvGew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237988;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DWQxbmV0bH8re7GX2QHEPfKuuqupaaE79RPxwBK2nIA=;
	b=pU8ZbQvaS0sn63hQLOTIga4a5Eht4Qobzmn4HHQx9Aj4L7J3bGCcvqAaxFG6UvK9rsJz
	 c2KMO/bSy5SQzJoaNs/bdqHkqQwkMNQbvGrhlP2gKaJ+6uKperi2uWluMCWtbvtmz6kaF
	 Z4E/Gy4Amg4Cft2RkJQJNMTHF5xyfUptOvcIESxossvzF2SUJpp0JE1XbIL+3Dmu4bM+J
	 p/2Wh2xz7w6wTCdJPS9TODyBDUAAJSHYWhnmlSG+fWp1vr/DQhFUEBSO0LrwinlAEpXcZ
	 BNpUjfYSK/R9DQSzh7Ji109PkmE1d7BvfqhvFsI2QrU2YxpuPPp5UEzrE+J0BqvEnaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dumBjmEs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB79606A31C;
	Thu, 29 Oct 2026 01:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dumBjmEs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D6E1F01828;
	Thu, 29 Oct 2026 01:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237988;
	bh=DWQxbmV0bH8re7GX2QHEPfKuuqupaaE79RPxwBK2nIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dumBjmEs4eiLodakeYnT3akEBBb0DysCs9Cor+j8+D1UuNJx7P3luwR2NRZsUKNTK
	 lj3MtlzOOH6UKK9ZLdsjtlLviGhfRyvPkYtfj46Qw9J5+hiCmqMlIFY1UMIYJktdCd
	 yEJaVwguacAUuRGH0nbgloUrcWPG6LhMoF5eMDaW586t6ecZvCVjrjJ+Pw40+XasZL
	 BPoS/rzIMJDwaZz+NUfZ+s+ER9Q76W2ZM1kRVUpusE+kgX0JzzLIpoYZgd+oP2DQ0O
	 LKunZyahiEH6AtjFF71zn4WyM9I+/SfAeyQUEPgDFXmAPxZzJt5aVpeR+HMh3SMeBl
	 k6HphE2eM0MyQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 15/15] selftests/ftrace: Add event filter syntax check test case
Date: Thu, 29 Oct 2026 10:39:44 +0900
Message-ID: <179323798449.740114.5416715723328926616.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179323784538.740114.15323117974242744566.stgit@devnote2>
References: <179323784538.740114.15323117974242744566.stgit@devnote2>
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
Changes in v3:
 - Replace negated pipelines (! cmd) with explicit
   "if cmd; then exit_fail; fi" checks to properly catch unexpected success
   under POSIX sh with set -e.
 - Add test cases for empty string matching (prev_comm == "",
   prev_comm ~ "").
 - Add test cases for out-of-range CPU IDs with CPUS{} comparison.
 - Add test cases for missing operands after operators.
 - Add test cases for empty operands and stray operators.
 - Add test cases for operand type mismatches and brace errors.
 - Add test cases for function event filter syntax checks (including
   INVALID_OP and ILLEGAL_FIELD_OP caret checks).
 - Add test cases for multi-line input validation on event and subsystem
   filters.
---
 .../ftrace/test.d/filter/filter-syntax-check.tc    |  100 ++++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/filter/filter-syntax-check.tc

diff --git a/tools/testing/selftests/ftrace/test.d/filter/filter-syntax-check.tc b/tools/testing/selftests/ftrace/test.d/filter/filter-syntax-check.tc
new file mode 100644
index 000000000000..02fb2be6e6eb
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/filter/filter-syntax-check.tc
@@ -0,0 +1,100 @@
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
+echo 'prev_comm ~ "*"' > events/sched/sched_switch/filter
+echo 'prev_comm == ""' > events/sched/sched_switch/filter
+echo 'prev_comm ~ ""' > events/sched/sched_switch/filter
+echo 'common_pid == CPUS{0}' > events/sched/sched_switch/filter
+echo 'common_pid != CPUS{0}' > events/sched/sched_switch/filter
+echo 0 > events/sched/sched_switch/filter
+
+# Empty or meaningless filter expressions
+check_error '^()'						# NO_FILTER
+check_error '^== 1'						# INVALID_FILTER
+check_error 'common_pid ==^'					# INVALID_FILTER
+check_error 'common_pid !=^'					# INVALID_FILTER
+check_error 'common_pid >=^'					# INVALID_FILTER
+
+# Unbalanced parentheses and quotes
+check_error '^(common_pid == 1'					# TOO_MANY_OPEN
+check_error 'common_pid == 1^)'					# TOO_MANY_CLOSE
+check_error 'prev_comm == ^"bash'				# MISSING_QUOTE
+
+# Dangling logical operators and empty operands
+check_error 'common_pid == 1 &&^'				# TOO_MANY_PREDS
+check_error 'common_pid == 1 ||^'				# TOO_MANY_PREDS
+check_error 'common_pid == 1 || (common_pid == 2 && ^)'		# INVALID_FILTER
+check_error '(common_pid == ^)'					# INVALID_VALUE
+check_error 'common_pid == ^&& common_pid == 0'			# INVALID_VALUE
+
+# Invalid field, operator, or operand type
+check_error '^no_such_field == 1'				# FIELD_NOT_FOUND
+check_error 'common_pid == ^@'					# INVALID_VALUE
+check_error 'common_pid == ^"1"'				# EXPECT_DIGIT
+check_error 'prev_comm == ^0'					# EXPECT_STRING
+check_error 'common_pid ^~ 1'					# ILLEGAL_FIELD_OP
+
+# CPUS{} syntax errors
+check_error 'common_pid ^> CPUS{0}'				# ILLEGAL_FIELD_OP
+check_error 'common_pid == CPUS^0}'				# MISSING_BRACE_OPEN
+check_error 'common_pid == CPUS{0^'				# MISSING_BRACE_CLOSE
+check_error 'common_pid == CPUS{^}'				# INVALID_CPULIST
+check_error 'common_pid == CPUS{99999^}'			# INVALID_CPULIST
+
+# Function event filter errors (if supported)
+if [ -f events/kmem/kmem_cache_free/filter ]; then
+    check_kmem_error() {
+        ftrace_errlog_check 'event filter parse error' "$1" 'events/kmem/kmem_cache_free/filter'
+    }
+    check_kmem_error 'call_site.function == non_exist_func^'	# NO_FUNCTION
+    check_kmem_error 'call_site.function ==^'			# INVALID_FILTER
+    check_kmem_error 'call_site.function ^> 0'			# INVALID_OP
+    check_kmem_error 'common_type^.function == 0'		# ILLEGAL_FIELD_OP
+    echo 0 > events/kmem/kmem_cache_free/filter
+fi
+
+# Multi-line input with non-whitespace characters after newline must fail
+if ( printf "common_pid == 0\ncommon_pid == 1" | \
+     dd of=events/sched/sched_switch/filter bs=4096 ) 2> /dev/null; then
+    exit_fail
+fi
+if ( printf "common_pid == CPUS{0\n\"} && common_pid == 0" | \
+     dd of=events/sched/sched_switch/filter bs=4096 ) 2> /dev/null; then
+    exit_fail
+fi
+
+# Trailing whitespace characters after newline are permitted
+printf "common_pid == 0\n  \n\t \n" | \
+    dd of=events/sched/sched_switch/filter bs=4096 2> /dev/null
+echo 0 > events/sched/sched_switch/filter
+
+# Subsystem filter must fail on invalid filter expressions
+echo 'common_pid >= 0' > events/sched/filter
+if echo 'no_such_field == 1' > events/sched/filter 2> /dev/null; then
+    exit_fail
+fi
+if echo 'common_pid == 1 &&' > events/sched/filter 2> /dev/null; then
+    exit_fail
+fi
+if ( printf "common_pid == 0\nfoo" | \
+     dd of=events/sched/filter bs=4096 ) 2> /dev/null; then
+    exit_fail
+fi
+
+# Subsystem filter with trailing whitespace after newline must succeed
+printf "common_pid == 0\n  \n\t \n" | \
+    dd of=events/sched/filter bs=4096 2> /dev/null
+echo 0 > events/sched/filter
+
+exit 0

