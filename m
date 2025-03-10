Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9264042A80;
	Mon, 10 Mar 2025 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741587253; cv=none; b=RrBbmAoAQXngq7xt58vL16Km4osaJhTtuFPk5ResQXBGrp5+WBNKGqtJp9jiYLppNAHOkXdoVKqpANVoBcvwU64HcY67vuFynuQKioiYEsTap5j526QkSATUOdjnLrw5QvCyiFvDLRwFdEY0C6712Br91SU270Z1ghR1/UJWL/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741587253; c=relaxed/simple;
	bh=XD0x4Ii/IotKmi77mKPJjxcvFwakp1wA/tNz4JU9oys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ICdQxZPzdLewyc0dlqUZUnjO6Jg5uVisPYMh7D5A7baPnIxZ//4p8cvLDlYeKENjS4zDn52wm1ZiNck9ooLz7+lyJY9DixiDsZCtp19vt0GHaPlgMKWRO459MA3prkRVJavtTVy8oMvQAB/R7yWUeAJPa+YmFkVYcEmOtu3KH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=px5WJJYg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="px5WJJYg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4312FC4CEE5;
	Mon, 10 Mar 2025 06:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741587253;
	bh=XD0x4Ii/IotKmi77mKPJjxcvFwakp1wA/tNz4JU9oys=;
	h=From:To:Cc:Subject:Date:From;
	b=px5WJJYgnFHOgkfaV0OBQsfSwma3DpJxYSlTfpJjU2dvnsYRWFE+96g9Ht3kGPgbo
	 jyQ6QXujQwwwie9aIf7FfGaFQ7DSIWKGeE0eMuDlgJn0x6+xkC8xWA4g45gsDTtSYM
	 5MmxSYyhN228kBvAd8gwX4Ckaj1XOX+218qi2ETQp/1+izUCkvqEuvx9nzN6ewtpg4
	 HAJlmjyjUeJTg+pAr41ercjC/mj0HyVhggrL3pu3DtquiDsb73CcLvMb8BxjO0cBXs
	 pZ4dS0E0W/iiZ/u/WpkntxMDsz9o+qNGkuIBdcA8OwK4CU1UAVXYgaZ2sLAkJw2Woa
	 bNa5CRmCFYXqQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: tprobe-events: Fix to clean up tprobe correctly when module unload
Date: Mon, 10 Mar 2025 15:14:09 +0900
Message-ID:  <174158724946.189309.15826571379395619524.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
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

This unregisters the fprobe and tracepoint callback when module is
unloaded but marks the fprobe-event is tprobe-event.

Fixes: 57a7e6de9e30 ("tracing/fprobe: Support raw tracepoints on future loaded modules")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
   - Do not use unregister_trace_fprobe() but directly unregister
     fprobe and tracepoint in the callback.
---
 kernel/trace/trace_fprobe.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index e27305d31fc5..88a80953ae5e 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1008,10 +1008,13 @@ static int __tracepoint_probe_module_cb(struct notifier_block *self,
 					reenable_trace_fprobe(tf);
 			}
 		} else if (val == MODULE_STATE_GOING && tp_mod->mod == tf->mod) {
-			tracepoint_probe_unregister(tf->tpoint,
+			unregister_fprobe(&tf->fp);
+			if (trace_fprobe_is_tracepoint(tf)) {
+				tracepoint_probe_unregister(tf->tpoint,
 					tf->tpoint->probestub, NULL);
-			tf->tpoint = NULL;
-			tf->mod = NULL;
+				tf->tpoint = TRACEPOINT_STUB;
+				tf->mod = NULL;
+			}
 		}
 	}
 	mutex_unlock(&event_mutex);

