Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237868;
	b=YT/thSZZ/tsJ3Xsa4bvmgMLiUt4sYkthXLDv9V8wnXkJ6tODwVDNcobnC/DXahdzMYin
	 dSWpvZeJKItiDKAnnDf+83OGqQRRyIq12ekUMA3DP0p0PTUWG1h5v7TY2PUg7EVpoyOg6
	 sqBpWccX7Lv8OvVYJAdop//GIrwzF7hJ0390YjCIcMETosSK9yXozWNaQsdyqvMz+Qnai
	 hYQzYEdGQfN8GAvd9XHzxp/fy8xB/7fo69eCOzRoGty2yiGW0g1sJJDKVZgDULAKGCjSa
	 TMkpDbM5PApheylSOBzeYqFzK9vNmxitKMYnAV7V5jI0OgOUCcHCBYzhgZrHbuLbeTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237868;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Hm/LU+xBnvIW6AdvjFqtlfYuJIABoLozBb88sV9RfLk=;
	b=NaRRJDfWY+6kWWuap4P1C3OmgAeYwcEv5dX/fCPGwAkiW5JPtQblAhtTK9fj6hBR2iLE
	 Iu3AtIS5jO2qGq+3cnRmDgc12x16Fnyc+RPsEYQGNLsixkdpAP+XB/+DrE3lzywCSVdwu
	 kN6m5r37RsZgQPgflvjxaXbPI4RmwSZy9PXUxNZ40dWVVppcADUPqS3qSuq/VWQVK+vX/
	 7/Ry6S7YstHJ0Ci1D/Eom8/rfWEm5aRUWZ6ZSWinXr5h1H3OwO8KLr7ajha2SDoKwafkv
	 Ihn9H2dpTKZCmu9/7zN2dVLZSmoGqfSEx59cb8twh8ZMEtNy6koxufgIpd5MGO4AFWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZg7k4LJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E013606A31A;
	Thu, 29 Oct 2026 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZg7k4LJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865131F01829;
	Thu, 29 Oct 2026 01:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237868;
	bh=Hm/LU+xBnvIW6AdvjFqtlfYuJIABoLozBb88sV9RfLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EZg7k4LJodNr7XFwMSi1C88b9jcqEpS+1Q2keOqO9Sqq4Y/zvWfyl4cz4Vnh4JVQW
	 KMTIGGviG5aQ9niW6GiHDAf5haA2e5H79hQEQyxwDQzMVrRDYjcGdNXYZYPUHX92qK
	 7kaZRjMgYCQmk//PcnHf34ydZUzd68gShC2YtJCJVtpQf+o0ZwoIF0hG1dMYxLtTpP
	 127HhQHTEiyZnHBRRbljMOwTCzpvFrlKI1wDl97kel2GC2KV3TvBwdhDlzO7VM4Brj
	 mAtWOn1sTu/+pvxugxzMqB4WP2TsoIWFMiS7xSpQwQJXSWYAa86kKJFYBKo4vaDVKD
	 vkWHhuP3lRCpw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 02/15] tracing/filters: Fix false success return in process_system_preds()
Date: Thu, 29 Oct 2026 10:37:44 +0900
Message-ID: <179323786427.740114.10413984130946236850.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179323784538.740114.15323117974242744566.stgit@devnote2>
References: <179323784538.740114.15323117974242744566.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

In process_system_preds(), "fail" was initialized to true to indicate
whether any event in the subsystem successfully applied the filter.
However, "fail = false;" was placed at the end of the event loop outside
the error check, unconditionally clearing "fail" on every iteration even
when process_preds() returned an error.

As a result, if every event in the subsystem fails to match the filter
(e.g., an invalid field), process_system_preds() returns 0 (success)
instead of -EINVAL. Consequently, create_system_filter() considers the
operation successful and silently resets the subsystem filter display to
the default global filter message instead of reporting the parse error.

Replace "fail" with "ret", clearing it to 0 only when at least one event
filter succeeds. If "ret" is still non-zero after the loop, jump to
"fail" to report FILT_ERR_BAD_SUBSYS_FILTER and fall through to
"fail_mem". In "fail_mem", free any replaced filters via
delay_free_filter() if !list_empty(&filter_list->list), or via
free_filter_list() otherwise, consolidating the cleanup paths.

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v4:
 - Clean up process_system_preds() by replacing the 'fail' boolean with
   'ret' and consolidating the cleanup logic between fail and fail_mem,
   as suggested by Steven Rostedt.
---
 kernel/trace/trace_events_filter.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 28977d10e60b..b35ecb01697b 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2337,7 +2337,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	struct filter_list *filter_item;
 	struct event_filter *filter = NULL;
 	struct filter_head *filter_list;
-	bool fail = true;
+	int ret = -ENOMEM;
 	int err;
 
 	filter_list = kmalloc_obj(*filter_list);
@@ -2364,8 +2364,10 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 			filter_disable(file);
 			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 			append_filter_err(tr, pe, filter);
-		} else
+		} else {
 			event_set_filtered_flag(file);
+			ret = 0;
+		}
 
 
 		filter_item = kzalloc_obj(*filter_item);
@@ -2380,11 +2382,9 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 		filter_item->filter = event_filter(file);
 		event_set_filter(file, filter);
 		filter = NULL;
-
-		fail = false;
 	}
 
-	if (fail)
+	if (ret)
 		goto fail;
 
 	/*
@@ -2396,19 +2396,18 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	return 0;
  fail:
 	/* No call succeeded */
-	free_filter_list(filter_list);
 	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
-	return -EINVAL;
+	ret = -EINVAL;
  fail_mem:
 	__free_filter(filter);
 
-	/* If any call succeeded, we still need to sync */
-	if (!fail)
+	/* If any filter was replaced, we still need to sync */
+	if (!list_empty(&filter_list->list))
 		delay_free_filter(filter_list);
 	else
 		free_filter_list(filter_list);
 
-	return -ENOMEM;
+	return ret;
 }
 
 static int create_filter_start(char *filter_string, bool set_str,

