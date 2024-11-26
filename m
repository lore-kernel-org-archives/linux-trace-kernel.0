Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A67D1D4613;
	Tue, 26 Nov 2024 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629427; cv=none; b=TYQgETXRYL8PTDgDdt+/xfsVPOcPbMaR/SR1ko8JLZA3RlS/BZg0ZQ0rRS3+bUJJLrUnOqhOjTstCrrd+xl0+wot8GZqmVEA+n0nCmIXpz65CY2qAHqF5EhL5VB957cqrcDcsRnfA5CRCfE9UiMnxoiRTnhEOLYfSh4wUNia04E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629427; c=relaxed/simple;
	bh=WFkIPpXulUXbAywnDNU8HT3l+4sMs3bGc3TO2sEeTkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJFsGuShmIRAue3Vnx1ETrgkvJ4DDsF0nWCdauYHefxfkfikqXPoSAj5uv5SJNTViz/f9dQxaJ8Bz9VQdMrtuaUGLcw0SjQfvzircQ02fkxYnwBd15i6Afhd8S4Lydc346BxifKom+eWBCcD1pkcU4jqCbym9T1i1RdjtFdLbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn94L6mB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn94L6mB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734FDC4CECF;
	Tue, 26 Nov 2024 13:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732629426;
	bh=WFkIPpXulUXbAywnDNU8HT3l+4sMs3bGc3TO2sEeTkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fn94L6mBZekdpjbnN6bbgvs+9AjyN6o/0PmteQDtGn6dGryJHx+r78oHhNXBZMg6t
	 ysjIQ7YJfFn5l6IO5Lxo1a5PienTJVMr/fRjAEffVKgOaSvJ/fOlcvEeNYJJKBI7oS
	 JuwkxmRXU9144GykOzOdrQ7b8ZT4ThyTSSsNxEO6tcdDzB5UvijscucpaodqczT2Nc
	 l8DkUHIbQ7cAedrJfwelrxxkiLVvu524/nNKxzy5meK3TELLmuMW2vfnQj2b/gcX0m
	 V5EF6xGFZ5zAoF7ogj3sunXfjjKnrlPHChBEr2GrNtHTY7gKo4Aw5BhwVjeMZLfvtN
	 oCoLm8P1we6HA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Naveen N Rao <naveen@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 5/6] tracing/eprobe: Adopt guard() and scoped_guard()
Date: Tue, 26 Nov 2024 22:57:02 +0900
Message-ID: <173262942206.8323.3406875795803588002.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173262937038.8323.5774362855789721936.stgit@devnote2>
References: <173262937038.8323.5774362855789721936.stgit@devnote2>
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

Use guard() or scoped_guard() in eprobe events for critical sections
rather than discrete lock/unlock pairs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |   36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index be8be0c1aaf0..82fd637cfc19 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -917,10 +917,10 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 		goto error;
 	}
 
-	mutex_lock(&event_mutex);
-	event_call = find_and_get_event(sys_name, sys_event);
-	ep = alloc_event_probe(group, event, event_call, argc - 2);
-	mutex_unlock(&event_mutex);
+	scoped_guard(mutex, &event_mutex) {
+		event_call = find_and_get_event(sys_name, sys_event);
+		ep = alloc_event_probe(group, event, event_call, argc - 2);
+	}
 
 	if (IS_ERR(ep)) {
 		ret = PTR_ERR(ep);
@@ -952,23 +952,21 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	if (ret < 0)
 		goto error;
 	init_trace_eprobe_call(ep);
-	mutex_lock(&event_mutex);
-	ret = trace_probe_register_event_call(&ep->tp);
-	if (ret) {
-		if (ret == -EEXIST) {
-			trace_probe_log_set_index(0);
-			trace_probe_log_err(0, EVENT_EXIST);
+	scoped_guard(mutex, &event_mutex) {
+		ret = trace_probe_register_event_call(&ep->tp);
+		if (ret) {
+			if (ret == -EEXIST) {
+				trace_probe_log_set_index(0);
+				trace_probe_log_err(0, EVENT_EXIST);
+			}
+			goto error;
+		}
+		ret = dyn_event_add(&ep->devent, &ep->tp.event->call);
+		if (ret < 0) {
+			trace_probe_unregister_event_call(&ep->tp);
+			goto error;
 		}
-		mutex_unlock(&event_mutex);
-		goto error;
-	}
-	ret = dyn_event_add(&ep->devent, &ep->tp.event->call);
-	if (ret < 0) {
-		trace_probe_unregister_event_call(&ep->tp);
-		mutex_unlock(&event_mutex);
-		goto error;
 	}
-	mutex_unlock(&event_mutex);
 	return ret;
 parse_error:
 	ret = -EINVAL;

