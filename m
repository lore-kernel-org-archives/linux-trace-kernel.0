Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148237;
	b=DuvQxA5VCedSehluexnuRPkJcOOf9jUh27XZMQUQxC0XKCkzUkjH35VQz1IbhOUS4cav
	 ALs1y0zFT4i3TEDTDtvXF3gVEWm4dOxJwWy4AkOR77eOkc7dnzae7dVy7WAXMoBb0Gu22
	 3jh5hfTuHWNvNCGh5zO8ztnR2AszYSXL9OZA7YEdt61WJUMeMxIBZ/wNQGQFNi6yet3z6
	 zTFPnx8ej5yEkmR36vQ7bKVEkb4LCwct8rI3cmZ1qSEMkvIxZku0naULcWPyV5yC8Tnwp
	 zx+XEFWi74bcpVGZwUS204uwEnR/oKdQmRNAfsLNDkftvKOg1fs1Zfskm3XCPNYQYZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148237;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=L2DjDOOow0Z6M10Ard9PeQ85YXhOLMxYznqJ8Yq98tc=;
	b=ecMuNPi0TfpO14aJiSfzM4F5NgQdoxYGP6B2aKcP89HUbJgTMIpqdlds0pt6anocP5+V
	 nce6IIpWXgL+S7BTKzRSmDk+ZIvmCiHEPQ6IIu/Mt7eA3T8RLz56B3eiCfg3ngYpg+yiY
	 ZKTgiY4MjMhDsVVyn2xCBxavrUHl5QOM/dM2XbHYLRS7tHaYr6k4HiHfAckcr3zZC/Gc6
	 TTnTDmhCSjVt/BJ4hR26yOXNgWEZiJhXtGdYsW3PGA47r5LZoDJ+uPtTMcP8PzL3IdC7T
	 c0BZSUrlHSNJKzKthAr8of6VKZhFeQ/ptDzao39gACsSUIfXydJsS019lQa6Eea7sQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ixLTM/9l";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E286A606A31D;
	Wed, 28 Oct 2026 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixLTM/9l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DD01F01828;
	Wed, 28 Oct 2026 00:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148236;
	bh=L2DjDOOow0Z6M10Ard9PeQ85YXhOLMxYznqJ8Yq98tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ixLTM/9lltV1dHTpsRw4OrQDGucq44jO8QGahKaj7Wt8wMwdvv9H1KUVBtqACS+8H
	 FBj6dkqdBAZ4uTH3d8YTwPEA+usNvZj7C48UCOlclk1ScAFAuJOgOd7krrBVHzeTZO
	 RGleFBlvXji1JqxJEhU4+L6/cmWLjeAlWDrFp71FJbblpwu6/bQ9dIKRe4YuosajsO
	 7l4Quq1Ko1CX35z4DinFXBrNGuFsqCd2bd0CwxXpVnJGOshZob8/uE7oWvaI2rAgpf
	 s6tVFZ0kiJjzxtQStAzbXrk+kYILpo6mqs+0HMNnBUfpReY8F2KeDu+z3bmsrQn5gY
	 17D21kmK8PvKQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 03/16] tracing/filters: Fix false success return in process_system_preds()
Date: Wed, 28 Oct 2026 09:43:53 +0900
Message-ID: <179314823296.684037.17602272705996028005.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179314820431.684037.4147763044424284198.stgit@devnote2>
References: <179314820431.684037.4147763044424284198.stgit@devnote2>
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

In process_system_preds(), "fail" is initialized to true to indicate
whether any event in the subsystem successfully applied the filter.
However, "fail = false;" was placed at the end of the event loop outside
the error check, unconditionally clearing "fail" on every iteration even
when process_preds() returned an error.

As a result, if every event in the subsystem fails to match the filter
(e.g., an invalid field), process_system_preds() returns 0 (success)
instead of -EINVAL. Consequently, create_system_filter() considers the
operation successful and silently resets the subsystem filter display to
the default global filter message instead of reporting the parse error.

Move "fail = false;" into the else branch of the error check so that
"fail" is only cleared when at least one event filter succeeds. Because
file->filter is still replaced even when process_preds() fails, check
!list_empty(&filter_list->list) on the fail and fail_mem paths so any
replaced old filters are freed after an RCU grace period via
delay_free_filter().

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_filter.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index f7c067a58ba4..617bc3c0bb0c 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2354,8 +2354,10 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 			filter_disable(file);
 			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 			append_filter_err(tr, pe, filter);
-		} else
+		} else {
 			event_set_filtered_flag(file);
+			fail = false;
+		}
 
 
 		filter_item = kzalloc_obj(*filter_item);
@@ -2370,8 +2372,6 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 		filter_item->filter = event_filter(file);
 		event_set_filter(file, filter);
 		filter = NULL;
-
-		fail = false;
 	}
 
 	if (fail)
@@ -2386,14 +2386,17 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	return 0;
  fail:
 	/* No call succeeded */
-	free_filter_list(filter_list);
+	if (!list_empty(&filter_list->list))
+		delay_free_filter(filter_list);
+	else
+		free_filter_list(filter_list);
 	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 	return -EINVAL;
  fail_mem:
 	__free_filter(filter);
 
-	/* If any call succeeded, we still need to sync */
-	if (!fail)
+	/* If any filter was replaced, we still need to sync */
+	if (!list_empty(&filter_list->list))
 		delay_free_filter(filter_list);
 	else
 		free_filter_list(filter_list);

