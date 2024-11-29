Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C9819D084;
	Fri, 29 Nov 2024 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898914; cv=none; b=r+eJygqowudkHDW2jrqIfqwYIgcgDJg0/M3YFC5XImwbrqLRqe4Ti2gyj+rIf3UW3KbVoo61JiMkeAb1qrJvELNuv4vfRWorQDsdEp4wsQ98Q4/E/DeDTefbdk9I2WsD+UcnmObS0sBaE8gqL2iDvFzPP/WDNRKG9OaMAnc8AM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898914; c=relaxed/simple;
	bh=WFkIPpXulUXbAywnDNU8HT3l+4sMs3bGc3TO2sEeTkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BbdgR6lE1ctGBA2uSy0BOG+udVMtzL/Z9LfIb/TnGdfTtbDf5vFHbJaGv5ejgcNhBkaxBq+LHTBzBDOMjTTYhIHpeXcw2PgzjItx9xxH6OhQ8ld0SNItfVbEGXT7PQ3qSzBOdASQzG/9dZh0RfGt4lx8puwfTwS0zSDmyBLZmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qi4/eRSy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qi4/eRSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F022AC4CECF;
	Fri, 29 Nov 2024 16:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732898914;
	bh=WFkIPpXulUXbAywnDNU8HT3l+4sMs3bGc3TO2sEeTkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qi4/eRSy/UFINbJk3GZv08ieXTkR4Z7ysx1ZF5yGNSTdhtwH3mrzzDp7PLtLM6KEn
	 vmt7/VfYHa1Kx3YjbO8sCRApT9HaG/6uZd4YtuW6o0UKPkKL7m//e3sTSubfwYZFgl
	 5O9bHvC8L1lgJ/Gcc1E0mmfYSWHX0Ev64v+lDE0KAYA8jY2gWS1mXDhnMbuoin+IXk
	 tc+CRWcJz2kYoz0VVxFZWDKNXYlqjBo2rhJVEDNtotkajtwdIXcT5Dvblfe0rg3rIK
	 Hed/YC41bSIM3/nNh+qq5/kVlSQFNXV/5GlRvs6qEO0DtZQsIHt/0jRCf5a7zWIL51
	 jaYgj41tGIZ1g==
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
Subject: [PATCH v2 5/6] tracing/eprobe: Adopt guard() and scoped_guard()
Date: Sat, 30 Nov 2024 01:48:30 +0900
Message-ID: <173289890996.73724.17421347964110362029.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173289885627.73724.13632317993038475335.stgit@devnote2>
References: <173289885627.73724.13632317993038475335.stgit@devnote2>
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

