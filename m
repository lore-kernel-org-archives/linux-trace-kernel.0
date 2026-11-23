Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473157;
	b=NGAuzZ5Y/OjoeF43qOVZ4+C18IB7v4Q2Urt5F7ridxvSDO7fpOGa4tzS8Gdkn+qFDzVK
	 eajjJAhSswK0oip2PWa/eN33eB5AE7vIjjbKt8SZ4m7H/kQkaAATa7PFZdzBJcNHYz5WW
	 nVRG6ytV31ocNnhXE4gjciWyJ3Q4b7Oe/YQhcbN7HLBRBxCWze4veSkgf1AnvITzMb8Fc
	 Gcy9CH+ykiLG5DCzomkUReZWYThMkrtwr2sODtdEGLR4TDPld/ot6W3CBkGXtMCLZlhEf
	 gWGtebT0tgPeB0aw5J5+2w8+IMz/pdYlo6DCxuGm7Ljoa0o+c9+mtXaZ4LTjGmh6fyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473157;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VZBmX+wJbHFR1TFVelBEGt/GVLJYNNJoOLGKVI23VUs=;
	b=L4xG+eCTlYZHrmoehOGK7iXdAzu1m8Jq4t+rDombrHalXS6qCbgX9RyFtyvRq7+RyvHn
	 GWaGDaG3qAlctI5WTiSivhwoee+qsb8jOTW1PVC0wGVusMN8XOsd/nX9HfPX0xORbfm90
	 MprGZsIxN4m4guo14tt0k8u8eL8UuMzfEj3V2zg9Q+xjIsNNt45wAV1cIRe1WYsO4ZgjO
	 sB9hQlcT/REZoepztIlwXhdMH0Jv6pVAPr3J1dEZ6HfUcNi/DEJDSw5ep5ffRqm9b0Krt
	 CuzfDgZtg+FSES7SM9qtFiiDe78kUgHYbKjACS87WwaYy4UE5nwh5xTJYOvscEkyvZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ph/1n0yx";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46365606A31E;
	Mon, 23 Nov 2026 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ph/1n0yx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EB31F000C0;
	Mon, 23 Nov 2026 22:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795473156;
	bh=VZBmX+wJbHFR1TFVelBEGt/GVLJYNNJoOLGKVI23VUs=;
	h=From:To:Cc:Subject:Date;
	b=Ph/1n0yx+rsyjeZERwwNt6HBU9wJtqFiLdUYajjIqk5gcPQhHvyXJFz2FdeKEflAG
	 scJ3R7Frhzw3GDTuoq6TUwpjuT6T821KI4RHCa6/Zt5Js9SFuYxcH4asTsgBQuCpuM
	 7VOJ+7I7ETKMm9BkBMfgTG9g08cLkKQfgv7v/JnBrqF4l9QqHq3mHMgR8/IUyRHQOZ
	 oB1hBemONwpgkpF2LvbAbUaBsQg30ZOngEf2OUTAgSYHffMLD5XOdMsYxljueOxwEi
	 oqztnJ6f+y4ek2RhU+7gf0L5E3ybUdd8w5u3qeGRnTIBzE4tgMwdtUtuIKFxBMHRZd
	 kA3Wy9+vnWmww==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Remove non-existent CONFIG_RESERVE_MEM from config
Date: Tue, 24 Nov 2026 07:32:32 +0900
Message-ID: <179547315291.329986.16935545207857031949.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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

From: Masami Hiramatsu <mhiramat@kernel.org>

CONFIG_RESERVE_MEM does NEVER exist in Kconfig. The reserve_mem= boot
parameter and reserve_mem_find_by_name() are built unconditionally in
mm/memblock.c, and persistent ring buffer instances via trace_instance=
do not require a separate Kconfig option either.

Remove the non-existent CONFIG_RESERVE_MEM=y entry from the ftrace
selftest config fragment and the boottime test README.

Fixes: e666e6528359 ("selftests/ftrace: Add generic boot tracing test framework")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/boottime/README |    1 -
 tools/testing/selftests/ftrace/config          |    1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/boottime/README b/tools/testing/selftests/ftrace/boottime/README
index 1eb0191d75d4..5371907c7f0d 100644
--- a/tools/testing/selftests/ftrace/boottime/README
+++ b/tools/testing/selftests/ftrace/boottime/README
@@ -45,7 +45,6 @@ Additional feature-specific config options enable respective testcases:
 - `CONFIG_EPROBE_EVENTS=y` (for eprobe tests)
 - `CONFIG_FPROBE_EVENTS=y` (for fprobe and tracepoint probe tests)
 - `CONFIG_FUNCTION_TRACER=y` (for tracer options)
-- `CONFIG_RESERVE_MEM=y` (for persistent ring buffer tests)
 
 Usage
 -----
diff --git a/tools/testing/selftests/ftrace/config b/tools/testing/selftests/ftrace/config
index 29f05f7c6e2c..c43f24755c64 100644
--- a/tools/testing/selftests/ftrace/config
+++ b/tools/testing/selftests/ftrace/config
@@ -22,7 +22,6 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_PREEMPTIRQ_DELAY_TEST=m
 CONFIG_PREEMPT_TRACER=y
 CONFIG_PROBE_EVENTS_BTF_ARGS=y
-CONFIG_RESERVE_MEM=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLE_FTRACE_DIRECT=m
 CONFIG_SAMPLE_TRACE_EVENTS=m

