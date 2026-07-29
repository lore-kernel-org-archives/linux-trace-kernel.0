Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD169231C91;
	Wed, 29 Jul 2026 00:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785284884; cv=none; b=dUP7y4k6bVnPKKuauzj6pwJMrEgjQ/cf6sSmhNvS5YBFytNP3H3RumE5NzC73fuC8HJKKwVR1kLKTvuK0Ax00SgWi6RYVZxL3g69FaFwH+4NtN2WszFuU2AsDaJRCL5V97xueFrFvMnY1s5IWlTBHc/32XbgBx/VL7xrVg9IygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785284884; c=relaxed/simple;
	bh=SJM/rbXXghSEhFRjdNCWGHyPQkb3lM0RJkb+mJSf/S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSP3XfxG9NxdOJZdCLgU9Yi0MYH1OSTCSN4k5einQHU6qSpn1sCgrxu6Iul2Uzaxl02AQywFm+At0IxhrXWoZvOt5xF998MNRyWmm6yxQdLmdEqz7gFX1iONXlKhbpFyzWGzK51nA+DjkBfYaCPKfF6K7yhM5slvdtFWl3o+5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/+aikha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/+aikha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395351F000E9;
	Wed, 29 Jul 2026 00:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785284882;
	bh=tnjIRJfgkeEhkOivigyV6hxMYc+GhIm71QRqwZihsiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a/+aikhav81vhrKyCC9M7QNLJvidhbBcSckSJupfmAAW2N3ICwK9g9plptYKP357f
	 TRjLocRrptGL/U3Y1j+hn4d66CKhEu+a6gv+9DnMW3K7LsPsF5ZVsZL1V4ehF0W/Lz
	 moLoNiaLYZ2zGEO7CZd0DAtbzRuQ122MX6z6ZrtNY4N0NbCHaa2gwQiRUzqDRYT8S9
	 21u4+Vd7Sdr96/JYFCI6r/3wZkQv2cS0Vnd92Qw6eyS6feQP64gUS+on7mmmkmdzVl
	 rf25d8WlzLV/oxFS7BJ+csqbHGmJHKRVz1Yc0q+DRvfdk+pb/T+M+7Ixsh0+KTTIFM
	 lC+g8ToQKLnPA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing: Check return value of __register_event() in trace_module_add_events()
Date: Wed, 29 Jul 2026 09:27:58 +0900
Message-ID: <178528487878.124250.14170824576025743236.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178528486942.124250.10437463913796837242.stgit@devnote2>
References: <178528486942.124250.10437463913796837242.stgit@devnote2>
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

trace_module_add_events() ignores the return value of __register_event()
and unconditionally calls __add_event_to_tracers() for each event.

If __register_event() fails (for example, if event_init() fails), the
trace_event_call is not added to ftrace_events list, but
__add_event_to_tracers() still creates a trace_event_file pointing to it.
If module loading subsequently fails and module memory is freed, tracing
state retains a stale trace_event_call pointer in trace_event_file,
leading to a use-after-free when tracefs or tracing subsystem operations
are later executed.

Fix this by checking the return value of __register_event() and only
calling __add_event_to_tracers() if event registration succeeded.

Fixes: ae63b31e4d0e ("tracing: Separate out trace events from global variables")
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 956692856fa8..c01b10b99f67 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3933,8 +3933,8 @@ static void trace_module_add_events(struct module *mod)
 	end = mod->trace_events + mod->num_trace_events;
 
 	for_each_event(call, start, end) {
-		__register_event(*call, mod);
-		__add_event_to_tracers(*call);
+		if (!__register_event(*call, mod))
+			__add_event_to_tracers(*call);
 	}
 
 	update_cache_events(mod);

