Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793603490;
	b=sN3wFXJ6nu/1nNVDRMd5Yr78v2J9dbCjNIqZIQVsNgjO8im647hiqMdTSph99B0sbtP5
	 FcN5oEv8IYqNDGHTTPldkr0fgyOwt6qnq6DEGQCL2FawvWij/siV2ackRHvfcKFRF4rc0
	 0498gLnwvvQ5F7gXxFfY7WudIIq8EwFx+/zIw2oqybbvfrnfvTUJEVjuXzsf2wwg41pee
	 8sLb3nr6E6bYaCrvxlNSa/ii/7fL0ARRVzT5ad/9pTAgbMRpMVXpQchj9tMTCLMaK8hYj
	 HRfUm+CHf61RJuJnig7ao3Q/z8MPv0U448j3hJRU2BnCDflbJCltKoayPas2F6zhiQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793603490;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZV0tab7VysaykfUEfxp751GYptchpJHxcMrTzqLLZ4o=;
	b=KF7p8/g8/s5vFpwWA40B8D5hFt27A862BTmfVX7YLM6y3J/ZkiMb6Cg+WAFiUfNBK4GS
	 ZHf6OhgonLDNn9rxv1N3KGeb+UdTaaulvIa7eoRGM97DFICNFTAPU8/SRGob96R2roZtu
	 x+yepAgVv7smE1l13PnH2ebF+kg27CBDj6sMWEdTy70//tEQFOphjomMnh+9fSRAAFxze
	 H9dRoCnP7bNGdw1+MHJXe/p5rbivX/zSZh/Z+yQFgHDi2szTIkTFgGj5wEKgL0uu/TYXI
	 nsKkJ0hZ7dL1EGMDOFuhm3CWDc7ytfUjF7h2Gcj6/6KT7dJWofu7nP8aJgwiH3PQ3sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elp9ahrs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C437606A326;
	Mon,  2 Nov 2026 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elp9ahrs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED431F000C1;
	Mon,  2 Nov 2026 07:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793603489;
	bh=ZV0tab7VysaykfUEfxp751GYptchpJHxcMrTzqLLZ4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=elp9ahrsIrEjpgWnlZp5Cp9aX93TOL93VsWU/VvpfbLp16hlzNeViKjMHY+5I0oP8
	 T8pM9M83/RNIRfEdKbL7Pp7hv5K2/nfyFVZaZ8/YtKoig7DRlh+DvDyPxNMW7sZnTw
	 p0eRKrV+4dx9Rq40iYUz2qjlMvr0fKGBdCKjHOUa3VgN4UG3enaFMCHxXqprXA1E0W
	 gNXozluPXqrwRkqlI4s/e+PUswMl/ANR5m6Kn2pUXRb1l602YC3AqO2dXTWMsIWLrT
	 +6VVyHr6lN1rF8VzXN8aQ0Z+pFhlXxuI4n62Gk71FNAb0mhVZhOQnh586U4rLdjwP8
	 TCNEbto7lVE9A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 3/3] docs: trace: Warn against using printk() in probe handlers
Date: Mon,  2 Nov 2026 16:11:25 +0900
Message-ID: <179360348516.115681.16358304979974648339.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179360345418.115681.193455787480210412.stgit@devnote2>
References: <179360345418.115681.193455787480210412.stgit@devnote2>
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

Probe handlers (kprobes, kretprobes, and fprobes) execute in atomic or
non-preemptible contexts. Because handlers do not run in NMI context
(especially when jump-optimized or ftrace-based), calling printk()
directly can attempt to synchronously acquire console driver locks or
scheduler locks (via console_unlock()), risking a deadlock if the probed
or interrupted context already holds those locks.

Document this restriction in both kprobes.rst and fprobe.rst, and
recommend using trace_printk() instead to safely log messages to the
ftrace buffer.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Documentation/trace/fprobe.rst  |    5 +++++
 Documentation/trace/kprobes.rst |   11 +++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index 46dd46a97c1f..72e0fd9e1808 100644
--- a/Documentation/trace/fprobe.rst
+++ b/Documentation/trace/fprobe.rst
@@ -101,6 +101,11 @@ handler.
 If the entry callback function returns !0, the corresponding exit callback
 will be cancelled.
 
+Since the callbacks run with preemption disabled under ftrace recursion
+protection, calling printk() or pr_*() from these callbacks is not safe
+and can cause deadlocks on console driver or scheduler locks. Use
+trace_printk() instead to log debugging output.
+
 @fp
         This is the address of `fprobe` data structure related to this handler.
         You can embed the `fprobe` to your data structure and get it by
diff --git a/Documentation/trace/kprobes.rst b/Documentation/trace/kprobes.rst
index 5e606730cec6..19c04a91a664 100644
--- a/Documentation/trace/kprobes.rst
+++ b/Documentation/trace/kprobes.rst
@@ -563,8 +563,8 @@ course, has no way to distinguish the deliberately injected faults
 from the accidental ones.  Don't drink and probe.
 
 Kprobes makes no attempt to prevent probe handlers from stepping on
-each other -- e.g., probing printk() and then calling printk() from a
-probe handler.  If a probe handler hits a probe, that second probe's
+each other -- e.g., probing trace_printk() and then calling trace_printk()
+from a probe handler.  If a probe handler hits a probe, that second probe's
 handlers won't be run in that instance, and the kprobe.nmissed member
 of the second probe will be incremented.
 
@@ -579,6 +579,13 @@ which depends on the architecture and optimization state.  (e.g.,
 kretprobe handlers and optimized kprobe handlers run without interrupt
 disabled on x86/x86-64).  In any case, your handler should not yield
 the CPU (e.g., by attempting to acquire a semaphore, or waiting I/O).
+Furthermore, probe handlers should avoid calling printk() or pr_*().
+Because probe handlers execute in atomic/non-preemptible contexts without
+being in NMI context (especially when jump-optimized or ftrace-based),
+calling printk() may attempt to synchronously acquire console driver locks
+or scheduler locks via console_unlock(), risking a deadlock if the probed
+or interrupted context already holds those locks. Use trace_printk()
+instead to safely output messages to the trace buffer.
 
 Since a return probe is implemented by replacing the return
 address with the trampoline's address, stack backtraces and calls

