Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242E43DE45C;
	Tue, 28 Jul 2026 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243012; cv=none; b=Xn5A8+I+GAgQIzvCP7ymHigR3I6x/5Z+6tQIxsHHQDLOsjqJL4MxewN3IK1Q60KVd/qMyle7xlLBsaSJBiAs8pxgKeR9p+qxqYbBXoClGZpTRh6Ni1Ml713FJuQR3glPQZjFTm2xE8HgGJi+at4qSkMVhn/lQgGGS5mlGs6bjTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243012; c=relaxed/simple;
	bh=7tFzBYGxtPyTEMNfVdoVrIcozUcGIBfaryyGKr/PGNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhd1vZOvwdvsieFD6QvVmkjMfmrF6VC31/v4WKeM3lJ/2Zca5JeAD/N9xOGpbI7ybyeQrGXARijyT228q9LITqCfxKSwhDJzM0XunIg02qO8/+4J6KFxwCPxkM1dUu9laPAxeSbrIGIZA/q8YGxxPUMpR7NZAGEXwfKUZ60jpN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkr474Ek; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkr474Ek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7471F000E9;
	Tue, 28 Jul 2026 12:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785243004;
	bh=LaLFimEMmBrvMfMMx5gNeso5rpc7AUxMwn+69atIkjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gkr474EkHDB2SsGE3JK1XRV2U+kQhMJ+j6uJKSXjjICdD5W19rNtzEwMhimnf9e0L
	 bqFanGzGoGZZGLVA5HG/FObd/ne+erYbSJlR9DiA/8WQDHWlxkh9GBTW8YF8l4AZie
	 70Q8fYTJwsLkGDZrxBHtzCWOvAim6Q75QdLyfhyrr0IQ/CuBqIXdxTZj2aNKaGhw7w
	 4WcHYm/zaoHd9oeWxD9nwj8cAmEw+VKDcz43nRH59srqxktoXvrmVYgCtLbpd5CwPg
	 OSq9IckLjMD8VdusbOYGB5mZwmBUPha8yj9nCBxwitaDHdDMVSXU+dJD/AD/MhUnVL
	 +fNKNBYxi2COA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Pekka Paalanen <ppaalanen@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/4] tracing/mmiotrace: Add NULL check for mmio_trace_array in logging functions
Date: Tue, 28 Jul 2026 21:50:00 +0900
Message-ID: <178524300062.56416.8362487250709962380.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178524298182.56416.7520852015178187644.stgit@devnote2>
References: <178524298182.56416.7520852015178187644.stgit@devnote2>
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

mmio_trace_rw() and mmio_trace_mapping() retrieve mmio_trace_array into
tr and pass it to __trace_mmiotrace_rw() and __trace_mmiotrace_map().
If these functions are invoked while mmio_trace_array is NULL (e.g. before
initialization or after disabled), accessing tr->array_buffer.buffer will
result in a NULL pointer dereference crash.

Fix this by adding an explicit NULL check for tr at the beginning of
__trace_mmiotrace_rw() and __trace_mmiotrace_map().

Fixes: f984b51e0779 ("ftrace: add mmiotrace plugin")
Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_mmiotrace.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index e064ba3f28cb..df8692c2dea8 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -294,11 +294,15 @@ device_initcall(init_mmio_trace);
 static void __trace_mmiotrace_rw(struct trace_array *tr,
 				struct mmiotrace_rw *rw)
 {
-	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	struct trace_buffer *buffer;
 	struct ring_buffer_event *event;
 	struct trace_mmiotrace_rw *entry;
 	unsigned int trace_ctx;
 
+	if (!tr)
+		return;
+
+	buffer = tr->array_buffer.buffer;
 	trace_ctx = tracing_gen_ctx_flags(0);
 	event = trace_buffer_lock_reserve(buffer, TRACE_MMIO_RW,
 					  sizeof(*entry), trace_ctx);
@@ -321,11 +325,15 @@ void mmio_trace_rw(struct mmiotrace_rw *rw)
 static void __trace_mmiotrace_map(struct trace_array *tr,
 				struct mmiotrace_map *map)
 {
-	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	struct trace_buffer *buffer;
 	struct ring_buffer_event *event;
 	struct trace_mmiotrace_map *entry;
 	unsigned int trace_ctx;
 
+	if (!tr)
+		return;
+
+	buffer = tr->array_buffer.buffer;
 	trace_ctx = tracing_gen_ctx_flags(0);
 	event = trace_buffer_lock_reserve(buffer, TRACE_MMIO_MAP,
 					  sizeof(*entry), trace_ctx);

