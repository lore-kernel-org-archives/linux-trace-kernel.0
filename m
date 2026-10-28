Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148357;
	b=bTIKAPaH78BHFIerDFUwhtrlCeJmMr6iBK8YAPUXbQrgDUNlHtTWDputVM1Jh8adSp2D
	 7W/3QpDodHERUgUXGaJcIzRkTHwpBbSIwQIumN871FDsG1Yr7VXf0pOcS2q0tzQ/qdZ/X
	 +N1yKrTBnSPyyK2eO4RD0/MRRqHuYN14p/bLWWGK4rJPF6LBriT0TO0+4SXEFii5unZzl
	 G4YrJ2KaakjWjnkcRW5Dp9wUScidRbqYMTKWfbTqfXjm8VaxD9Yx/HFxiCYaEqpSC4RTx
	 qLdB4OuB7J2iEe+lioL9CkW8LIuIwTU1RSiwVAhROj1LD5juqLvsVD8qJ+yu63cJo9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148357;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DWQxbmV0bH8re7GX2QHEPfKuuqupaaE79RPxwBK2nIA=;
	b=CsVSjVNw7PUdI9AvVc53F8kyEs4EYOAWjox2dQCLyS+QY9kjLSo/0VOgrbhl93Mm0RR9
	 LVIIQW4hIDU2ZBVfnCbXMchwdr0lXu3jibVyZfejROwC2HzkmzlrwN8sTYs/x0+0XL27G
	 GswTIH7vGWBKSwYiL10VAhlmGW2JEpMoqo42NxoiHgxRiaOKQgjzWLQptRpf5ghvLyZoX
	 spTRIqA3A9q6clWux1KUXPDe5002HDZyvUF6pHom+6f8CYVUux2cIod5e6seoOBlbSK/r
	 U+1QEBZe+7dESueZvCSOlIc6InA8g5Wjlf0tNDuG3nW876vhWEZpCC2qbJ+mQM4lTyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gu6mJ4RA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF4F606A31A;
	Wed, 28 Oct 2026 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gu6mJ4RA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720501F031E1;
	Wed, 28 Oct 2026 00:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148357;
	bh=DWQxbmV0bH8re7GX2QHEPfKuuqupaaE79RPxwBK2nIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gu6mJ4RAip16wkYgzDoTlI/LTzy82ccA1thYJeU6eprt/XgYoDTPw2ePddUizGfI/
	 GvSN038TE3K5uru6mfy1QD2rrEtQh/jKbUTAdl+9nN/HnhLZHA2sNgJwzaUAAK3mwD
	 FeI8371SOf/QDrcmb0yl4wvRLjwyyDXBiLmFYucVJV3AGeW6IXx1GfogKuFeGzBXTk
	 IjsNKo/aIzBVuo2qLnWTxw/ire+CWYIWVMj865ijMA5soUYl6L1P9bQomz5PuTls99
	 evsvFj67wdfAnhmHOa8CrNV7hDbOzfNjw7gZTzrQTou80jINKnqdfyGOjcFDd3LsQO
	 lj7pOjSVgewLw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 16/16] selftests/ftrace: Add event filter syntax check test case
Date: Wed, 28 Oct 2026 09:45:53 +0900
Message-ID: <179314835316.684037.6225998891000249085.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179314820431.684037.4147763044424284198.stgit@devnote2>
References: <179314820431.684037.4147763044424284198.stgit@devnote2>
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

