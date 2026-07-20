Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54263E0749;
	Mon, 20 Jul 2026 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542369; cv=none; b=hsfBHCCVgDc/Id8y5cA0Wr05Mq/6C6xl1eDh+8zeyQdP6qeKUMtAfv2Uhi2Pbtw/eTHFER2hBHNR5n0Z4n/k/wAMLrubTcBhDnEDzGDcPHhKnhS3e6GFRCeNE4JIYsSyAKr7Eo8nlpvXishWUq7YEqkyYGAV03/7TmoSVoQYgHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542369; c=relaxed/simple;
	bh=wDNlZX4N0mTjaVYhKlMTx430kPWvfP4V810QBypJb5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xfv+VHaX+5v1FGF6Q701gr45KmrAYu+m0pRgF1o6ECQzbpCGdTocwfkrutT+3aFzRoGb9u7KCNUeTZYhURMROPxb8vhEBsFy/9UMNhcG6YWKxz40uKms3l0OB2ZJCa02Ps0mbkX5+aiUTltknl25vaKxMBytV/maW/jU4QpvbAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGOrxmMy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGOrxmMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED891F00A3A;
	Mon, 20 Jul 2026 10:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784542353;
	bh=PJy2QJ5d4MMnuzXMiWK9VOTWPQHlURmP4d7ABbZpQ74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jGOrxmMyM3YTX2Yit9aVnqcgTkbiyeZ5qDP0hX7JrostQVAKDyW14bEkQs1b7Dwwi
	 8ukob3pbUEF3cKwK7dLPCzu2u78Xoi0J348ZfOlUI9/hLzwQE3eLmxYF+6Sn72tn/d
	 FfIHzDKHdCy3skXBOf5U+35dTCKylzeVHOZ+erXN4fEpsJtKFjl2trguUQHPYcFGpY
	 0PUfU7J0ZM4nQ05BL3RpXutsQK14kUQW42OB3AGQttU3edTzXpCyZ2ujr0t1cGawYP
	 ejTJBWIaEDcuJmt0Sdq0yVbsaEa01+6RuRXrDeP3KyM9LJDSKur/OjsOQw8sC/QO3p
	 gioX0ywv7HlIQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/4] tracing/probes: Fix potential underflow in LEN_OR_ZERO macro
Date: Mon, 20 Jul 2026 19:12:29 +0900
Message-ID: <178454234934.290363.15247317871499514139.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178454232006.290363.11301475407231432622.stgit@devnote2>
References: <178454232006.290363.11301475407231432622.stgit@devnote2>
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

In __set_print_fmt(), LEN_OR_ZERO is defined as (len ? len - pos : 0).
If len is non-zero but smaller than pos, len - pos evaluates to a negative
integer. When passed as a size argument to snprintf(), this negative value
is cast to a large unsigned size_t, bypassing buffer size limits.

Ensure len > pos before subtracting to avoid integer underflow.

Fixes: 5bf652aaf46c ("tracing/probes: Integrate duplicate set_print_fmt()")
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 49daa3cc2a45..506e6037e163 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2013,7 +2013,7 @@ int traceprobe_update_arg(struct probe_arg *arg)
 }
 
 /* When len=0, we just calculate the needed length */
-#define LEN_OR_ZERO (len ? len - pos : 0)
+#define LEN_OR_ZERO (len > pos ? len - pos : 0)
 static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 			   enum probe_print_type ptype)
 {

