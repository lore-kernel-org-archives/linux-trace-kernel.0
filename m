Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2063AD505;
	Mon, 20 Jul 2026 10:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544227; cv=none; b=dksH+77EYmUQu4FmWFpRx3v8qt/belDK3u1uBtsPAUrE9U1t1EU1Ov6OnDHWFqo0LuVbhUL4u0zKrSy67LiR4hkVAJCrAlkE9Mb9jsBQjlaFHIMiJWjksvSZGm3dgkRHHqz0MQi9vc91NZSKYxgeAptlFRGDn7F1HF0wQLVDI9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544227; c=relaxed/simple;
	bh=2mZXoIzvSAZokoGoDXcnNZuL3xYCxPOTGwEJnRO533o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqOfbjMj2jDhWSyHs9K7Da4KBBuwAxTa2vtgP6zOppQLzpxife5rXhwa+6OfaXR4yyrSPcb+X7+swt8PC3f7gQ+efxSNCjGkAs/Y0jXkDH9Y7MOMqeV9fSyeGjsK4QeNyRDoDvXUzUYMXwSX45QUYz/PYsZL2PpHAE+HAE+sACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJvR+K8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJvR+K8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837EA1F000E9;
	Mon, 20 Jul 2026 10:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544222;
	bh=9ThXQ25nS188ePU8Js7Kwou012mg2AJOuu/gKi5oCfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DJvR+K8N+t+jY87ADBshiqzfUTMzSe7XvmDtAZa8iCqzRM2cqJVgICtya28xQfIED
	 2pDQUbqpWXjL9+vm00INBlgoZSKiIEqELjvDam/lwbhY1HIEgdkcG9PMi+WmYTtj7H
	 mLrrwZc+kNz89uIZtYeeaK1QW3mk76VMTrcKx2GS7STCQpgUCBRfo6J0mmyeMhQkqC
	 o3on7iSC9CuXVYdEDWOQA/VlQDjhsdeyBobOXBkK1ktX2qAKkCuw/rQDTuPBoicYiw
	 yHez9bhdhm+C8JQhet3AUAF3I3SoTeS3ZhGwjFrPv/rdKA/B4muwS+N6EjkBOEHaxR
	 P1JVdOtRHC8WQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 01/10] tracing/probes: Remove duplicate MAX_ARRAY_LEN macro definition
Date: Mon, 20 Jul 2026 19:43:39 +0900
Message-ID: <178454421926.296567.6649983666070787570.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178454420994.296567.10239174745865301350.stgit@devnote2>
References: <178454420994.296567.10239174745865301350.stgit@devnote2>
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

MAX_ARRAY_LEN is defined twice in trace_probe.h. Remove the redundant
definition.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index ebdc706e7cb6..b3571c85abb1 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -220,7 +220,6 @@ DECLARE_BASIC_PRINT_TYPE_FUNC(symbol);
 	_ASSIGN_FETCH_TYPE(#ptype, ptype, ftype, sizeof(ftype), sign, atype)
 
 #define ASSIGN_FETCH_TYPE_END {}
-#define MAX_ARRAY_LEN	64
 
 #ifdef CONFIG_KPROBE_EVENTS
 bool trace_kprobe_on_func_entry(struct trace_event_call *call);

