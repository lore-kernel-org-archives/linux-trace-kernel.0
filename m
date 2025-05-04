Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179612472B5;
	Sun,  4 May 2025 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746383321; cv=none; b=rpXzaBaCFHZasK+zgpKD9qK4sVlsEvp7Tx2Ap2khfjn7rl0Ryz3H0ZuXeWqW2r7ycTHnfGHUIgoE7/9IlSsL0AIcLaAV5Vfb1JnRTLe7AMztHQES/jLf7zC9bBdU3k3UTHPx6UGzgk/7ZN3NdEGlOTe3T1TpZdGuQVldHUsbYrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746383321; c=relaxed/simple;
	bh=biw/YOugtlpuJtFsezEFUKDGzFXeTNhhYYG6c17nWCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bbh8jS+y72JJjM5J5/w4z8wWCe8GvCSvRXc6EF4qP58Aw1oDKfcKS7lI1j5+7+gxBljrn63XRTRaN6nQe9m39YzSCESjDQct9lISj0b+zvVAN6ykD8L+SFD/6no8FbM27Zox3BPIvsdyKN14G2cl08qQ14iC2rR/TPHzQKST834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoYtdbTT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoYtdbTT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94A4AC4CEF0;
	Sun,  4 May 2025 18:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746383320;
	bh=biw/YOugtlpuJtFsezEFUKDGzFXeTNhhYYG6c17nWCc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FoYtdbTTAynKusPgOKC6NGKkyv6RbiP4dUPH+IvYDHoxzgeLEZvdLZ2qJSdCAJ2Rn
	 vHFvRmjEeSozWg14UtCoM/bgRFQgkzDDXKc/qsD36EBBwbp4gPi9cwQBzph5w6U2tB
	 3QqOjzg2ABXVKc7BruZ3CrXj+eXb0TMedSBn62ZocOC80ZXt2rCXLhYiDE9GLZa0L2
	 1LHDD6A7mzUlfTw3ooQdQsGEGdVGBFcJybY32AvT3GEEdlhQDevby4R/Ymg8rEND8m
	 RNTtea/xM1eJZYPd0837YQp3IxrKVbCVv25Zz4n5DVIOqnHnoWtx7TgBKAjFhpQHxY
	 cSLUqqk/WNwsQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850A9C3ABAC;
	Sun,  4 May 2025 18:28:40 +0000 (UTC)
From: Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org>
Date: Sun, 04 May 2025 20:27:53 +0200
Subject: [PATCH v3 2/2] tracing: protect trace_probe_log with mutex
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250504-fix-trace-probe-log-race-v3-2-9e99fec7eddc@gmail.com>
References: <20250504-fix-trace-probe-log-race-v3-0-9e99fec7eddc@gmail.com>
In-Reply-To: <20250504-fix-trace-probe-log-race-v3-0-9e99fec7eddc@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Paul Cacheux <paulcacheux@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746383319; l=2188;
 i=paulcacheux@gmail.com; s=20250422; h=from:subject:message-id;
 bh=JLwkOJEumGD7YD+nexmmI4MTQQL+hh9/f9FKhif6SKY=;
 b=fVewTZB5G2vWsu+/Kz4Ut/he1vI/StVN88Rdda3rjXLMq6aLMqZRKzi5Julu87MoiHFUqbwGK
 KXnbai+dRHTD56OINMEWdcXKsCdj4mMvmKKgRuU/nETJv2mSlto3Dho
X-Developer-Key: i=paulcacheux@gmail.com; a=ed25519;
 pk=8UguSecyECHKHp0YLS7hTEDob0ctFMr3ygBTeAmrFHs=
X-Endpoint-Received: by B4 Relay for paulcacheux@gmail.com/20250422 with
 auth_id=386
X-Original-From: Paul Cacheux <paulcacheux@gmail.com>
Reply-To: paulcacheux@gmail.com

From: Paul Cacheux <paulcacheux@gmail.com>

The shared trace_probe_log variable can be accessed and modified
by multiple processes using tracefs at the same time, this new
mutex will guarantee it's always in a coherent state.

There is no guarantee that multiple errors happening at the same
time will each have the correct error message, but at least this
won't crash.

Fixes: ab105a4fb894 ("tracing: Use tracing error_log with probe events")
Signed-off-by: Paul Cacheux <paulcacheux@gmail.com>
---
 kernel/trace/trace_probe.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 2eeecb6c95eea55502b83af6775b7b6f0cc5ab94..d538964c87a52b06646ec1b8c3469be7399f04fa 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -153,10 +153,19 @@ static const struct fetch_type *find_fetch_type(const char *type, unsigned long
 	return NULL;
 }
 
+/*
+ * The trace_probe_log_lock only protects against the individual
+ * modification of the trace_probe_log. It does not protect against
+ * the log from producing garbage if two probes use it at the same
+ * time. That would only happen if two admins were trying to add
+ * probes simultaneously which they shouldn't be doing.
+ */
+static DEFINE_MUTEX(trace_probe_log_lock);
 static struct trace_probe_log trace_probe_log;
 
 void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
 {
+	guard(mutex)(&trace_probe_log_lock);
 	trace_probe_log.subsystem = subsystem;
 	trace_probe_log.argc = argc;
 	trace_probe_log.argv = argv;
@@ -165,11 +174,13 @@ void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
 
 void trace_probe_log_clear(void)
 {
+	guard(mutex)(&trace_probe_log_lock);
 	memset(&trace_probe_log, 0, sizeof(trace_probe_log));
 }
 
 void trace_probe_log_set_index(int index)
 {
+	guard(mutex)(&trace_probe_log_lock);
 	trace_probe_log.index = index;
 }
 
@@ -178,6 +189,8 @@ void __trace_probe_log_err(int offset, int err_type)
 	char *command, *p;
 	int i, len = 0, pos = 0;
 
+	guard(mutex)(&trace_probe_log_lock);
+
 	if (!trace_probe_log.argv)
 		return;
 

-- 
2.49.0


