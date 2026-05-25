Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8492853FD;
	Mon, 25 May 2026 02:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779675679; cv=none; b=XPG3fIqhTpDi2isBs36zQT3r5U57omwXpQsghRmouYPiXES7Yuqp194AYEA+vKjICbR2r7SI9xGzVUb5vYJFpxtSo4UrabhVILs8wfeq5/6bkhLLTHXNG728sddc6Vgwc4NRNCZZW8RoKGC47xZgLTv2RcNfPwj8+fkvCzq/rfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779675679; c=relaxed/simple;
	bh=AwPzc6WQaEuKk15MZfiOHNLaEW8Iw4/2Iv59YwWJATg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SGEG6CIoerR/ZZSyv2wHj7rI4cPK7t0rdQ1cDbRMRiaVb+S2qNfeMW7M7qNbxZADX5BsC7girPzwVgTqEQC2EKYRh4CwpalgtQhX/vIN263U0RtxtN8/NVt/+tYEoEpVA87vilsYVr02IdfMi5u+i7bmFhqBWhXy9dOG92qbohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0UbNc5H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0UbNc5H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFDE1F000E9;
	Mon, 25 May 2026 02:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779675678;
	bh=8H+/mwgTDWRz94P3YnfwQbYHhECkqRVHbHWby5SNq0g=;
	h=From:To:Cc:Subject:Date;
	b=k0UbNc5HoRaHuTfkHbZcmDwihZgedR8IAeDPzVi5X0bGmVtinUDEnlu6jaASW31PN
	 na2zGTH8kTvX7pGgOlAcEpU2/gUE1IIbBaovVxBnB6nX4gyI0hWWFjm8VBbGc+Qvne
	 BtKbAv/pXzrI2vOhnw4mxD6pUe4bSFjVHnfv7ldGzkDDvLxiwvE1VK31zJk9Zk9A7v
	 f7lxbKlD+H4mIojp8whijalnn7sPeiE7q3vINCjD0oTf25iVkcaRdpvNQM6+TmuO0I
	 qZ2tNhn+ST+kMls8PR8kEkXEF0aFZ2j6ZkJxA7YQRmCbzdLpQT+67qJEJYK2L5lK+a
	 IrKXsQBqLyMew==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] tracing/probes: Point the error offset correctly for eprobe argument error
Date: Mon, 25 May 2026 11:21:14 +0900
Message-ID: <177967567399.209006.1451571244515632097.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fix to point the error offset correctly for eprobe argument error.
In the cleanup commit 1b8b0cd754cd ("tracing/probes: Move event parameter
fetching code to common parser"), due to incorrect backward compatibility
aimed at conforming to the test specifications, the error location was set
to 0 when a non-existent formal parameter was specified for Eprobe.
However, this should be corrected in both the test and the implementation
to point correct error position.

Fixes: 1b8b0cd754cd ("tracing/probes: Move event parameter fetching code to common parser")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c                         |    2 --
 .../test.d/dynevent/eprobes_syntax_errors.tc       |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 39f040c863e8..695310571b08 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -957,8 +957,6 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
 			code->op = FETCH_OP_COMM;
 			return 0;
 		}
-		/* backward compatibility */
-		ctx->offset = 0;
 		goto inval;
 	}
 
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
index 4f5e8c665156..2a680c086047 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc
@@ -20,7 +20,7 @@ check_error 'e:foo/^123456789012345678901234567890123456789012345678901234567890
 check_error 'e:foo/^bar.1 syscalls/sys_enter_openat'	# BAD_EVENT_NAME
 
 check_error 'e:foo/bar syscalls/sys_enter_openat arg=^dfd'	# BAD_FETCH_ARG
-check_error 'e:foo/bar syscalls/sys_enter_openat ^arg=$foo'	# BAD_ATTACH_ARG
+check_error 'e:foo/bar syscalls/sys_enter_openat arg=^$foo'	# BAD_ATTACH_ARG
 
 if grep -q '<attached-group>\.<attached-event>.*\[if <filter>\]' README; then
   check_error 'e:foo/bar syscalls/sys_enter_openat if ^'	# NO_EP_FILTER

