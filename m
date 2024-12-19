Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B721B3933;
	Thu, 19 Dec 2024 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639183; cv=none; b=B/CaL1KItC9hLIcOW6iezVUJRDq/3SXaTh3kIEypy+ZlQFi1d7w/ZvCK0oBD2AUpjsPiLMc0JJgI4etpebRY1E1QW68hyeGE3zbQJkvVegR25Ll+K0cA0XLFuJDobpy/Wm3bPfOGHtK+u/o/35vb95T9Rnn5eshBkkPNOmshEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639183; c=relaxed/simple;
	bh=TT+6SR3KFAiQFLV78kdj6mcYUeNQ7nvKXGMreMTdiIQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jqxB0TSBcISD1MVOju3a930IM0UDCuuRBHcvNS9CtO3EUe/6IBIaKoZfQuvM1XVJ29qck0MURot0xqOwuTvOelkk3aadYpUjLD/17a85Z3rBanaRmsp3epqsueoBxMy4JIsesHq3kJlLayfziKtLCJtM2YvfWyilOezN6Skn+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A51C4CED6;
	Thu, 19 Dec 2024 20:13:03 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tOMu1-0000000AOHT-018b;
	Thu, 19 Dec 2024 15:13:45 -0500
Message-ID: <20241219201344.854254394@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 19 Dec 2024 15:12:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 02/14] tracing: Return -EINVAL if a boot tracer tries to enable the
 mmiotracer at boot
References: <20241219201158.193821672@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The mmiotracer is not set to be enabled at boot up from the kernel command
line. If the boot command line tries to enable that tracer, it will fail
to be enabled. The return code is currently zero when that happens so the
caller just thinks it was enabled. Return -EINVAL in this case.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 77e9bf271c04..3878e80f55d9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6107,7 +6107,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 	if (system_state < SYSTEM_RUNNING && t->noboot) {
 		pr_warn("Tracer '%s' is not allowed on command line, ignored\n",
 			t->name);
-		return 0;
+		return -EINVAL;
 	}
 
 	/* Some tracers are only allowed for the top level buffer */
-- 
2.45.2


