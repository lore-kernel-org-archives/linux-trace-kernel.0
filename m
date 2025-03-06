Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE2C1362;
	Thu,  6 Mar 2025 06:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242108; cv=none; b=LyXhVAxJhZv672B/Tm6bcbQYbfb7n+vFVvZamdOBakNFBNyeusNtIsrr2D6Ik3bqYr2+iJgi/MEM7XahXbtdEUIQrCJ5vz9Y8E14HnH5LEwvEE22Pk3t73IuNZbYcRmOXETMSGucDuV9e580FYt9taHd5+ck8OWFxUNr1ajUvcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242108; c=relaxed/simple;
	bh=k0buHuc2gsPUWIxA15VpGC2wTTMjDQdRwluGNLhTcH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ei9ve7Ev7HXdL/GkoPd7NA9FJpAbFZ5FWD5Ms7LGHq0EOhxo0E4xbwmzjEm7Xb2geDDmoXlv9qDyrVgRBfqRMh5GvkXhpeAfTsdGYA87dSaWTjtZ7mTIKsIkzYb/z1hWNoDLx7NVLtlf54FKJ6YNZLqsKhr4uJo4OVSzwX590PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHL9g/gx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHL9g/gx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE62C4CEE4;
	Thu,  6 Mar 2025 06:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741242107;
	bh=k0buHuc2gsPUWIxA15VpGC2wTTMjDQdRwluGNLhTcH0=;
	h=From:To:Cc:Subject:Date:From;
	b=WHL9g/gxqaL0DNrkW6NbiOvZRLbYg3faNPujzO0i7RKpW6hQZZgrWgyGQOT+MHeee
	 Pwni4TU6c8+5GArtXkQnAuCi3cW9ey1wHxkp13cf8WrfrdnM2hrkXdI9bXxtcRbTv3
	 eldI80DUnmd3DlvDn4coQd5MtGk6DCHZJICdYGff/ocV+caVEu8BAp3w4MDVciOAYR
	 63QwnuURdgDwyv9whZcQlhgLgpEBXP551VwD3hS5QkdWczOPMAkQInPBYaNrb5xURh
	 RTsOT6x6tmnuDZ7NaxdnLcpSKUkpWZwCr06vnXIewZZYOjOnKQqJN0dODIsREqLZtQ
	 G395LDgYj0XsA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: tprobe-events: Fix to clean up tprobe correctly when module unload
Date: Thu,  6 Mar 2025 15:21:44 +0900
Message-ID:  <174124210422.3014222.12363751066695445786.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
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

When unloading module, the tprobe events are not correctly cleaned
up. Thus it becomes `fprobe-event` and never be enabled again even
if loading the same module again.

For example;

 # cd /sys/kernel/tracing
 # modprobe trace_events_sample
 # echo 't:my_tprobe foo_bar' >> dynamic_events
 # cat dynamic_events
t:tracepoints/my_tprobe foo_bar
 # rmmod trace_events_sample
 # cat dynamic_events
f:tracepoints/my_tprobe foo_bar

As you can see, the second time my_tprobe starts with 'f' instead
of 't'.

This cleans up (unregister) the tprobe events when module is
unloaded.

Fixes: 57a7e6de9e30 ("tracing/fprobe: Support raw tracepoints on future loaded modules")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index e27305d31fc5..d5fc0c5bf879 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -775,7 +775,7 @@ static void __unregister_trace_fprobe(struct trace_fprobe *tf)
 		if (trace_fprobe_is_tracepoint(tf)) {
 			tracepoint_probe_unregister(tf->tpoint,
 					tf->tpoint->probestub, NULL);
-			tf->tpoint = NULL;
+			tf->tpoint = TRACEPOINT_STUB;
 			tf->mod = NULL;
 		}
 	}
@@ -1007,12 +1007,8 @@ static int __tracepoint_probe_module_cb(struct notifier_block *self,
 				    trace_probe_is_enabled(&tf->tp))
 					reenable_trace_fprobe(tf);
 			}
-		} else if (val == MODULE_STATE_GOING && tp_mod->mod == tf->mod) {
-			tracepoint_probe_unregister(tf->tpoint,
-					tf->tpoint->probestub, NULL);
-			tf->tpoint = NULL;
-			tf->mod = NULL;
-		}
+		} else if (val == MODULE_STATE_GOING && tp_mod->mod == tf->mod)
+			__unregister_trace_fprobe(tf);
 	}
 	mutex_unlock(&event_mutex);
 

