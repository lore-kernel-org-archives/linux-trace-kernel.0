Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793241016;
	b=k7j3lLoPxbnLTiHzWgCYzHYi4zCXTRRhcR1CHLAQ5fKXwo0hXDjfmSO677WXTDX5cdkq
	 2nfRbEPxu3PxucIsyptAs6Q0IavDmJLbz1TCVauY77LqeJGsnqxS86zeYu6yDdLyBpLtm
	 oAQ56ws7gBSNhn/pJogM+EVM5EJVK14Lnw7L+MSPUEnP8QQHGZS4n3/e2BICHYCuD2x0f
	 afFhpRuWxFMP5lKGMtPboYFelkR9LNq5c22v0V1kSap5xW0E9XUt0xWATEILDL3xy/Hl5
	 YTxpfTPDmfQd0L+N2cFGBv/tV+U9+YSi6kZoNKPvpKV8b7AXhXnObWOy93ASc32I1VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793241016;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9fy076pAcz5orhmpfztB9xT2wFCRJQvV1U6xK17MGms=;
	b=ahgfkozSXcCdn59Y3kDsKywCVPU1Q8HkCWt7OClSBRe7U/Qqvj8eFqVeBm6uTtHgOeaz
	 5D4Ar0uFkvVSsIzaQN12q05FTAGUrsncr0wqF6m0lml8/QFgWlLsGgTQy8o7JXyAsm/NN
	 Kgu6qgnMbWg/ZWFZhlI2ODrAY9rDgACyz9vm5YBRnbcKs5ZouStmL5PTG9rAEaPtEFghj
	 H+vnTBpZLm9V/jP8CYbo6TYaw+3Th/gaTkjp4u0/x6MwEaEHjLgWCQA5QWF+xd84iwqD5
	 WD6yxG4jpoDfd+Xj6Tji3pMHbdhh6qm3RDxali1vD6hxni52ArQZU0bwjJWxIXUMi/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4cfbUY+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A1606A320;
	Thu, 29 Oct 2026 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4cfbUY+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E681F01829;
	Thu, 29 Oct 2026 02:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793241015;
	bh=9fy076pAcz5orhmpfztB9xT2wFCRJQvV1U6xK17MGms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l4cfbUY+vxh3vT/fMqbxtLwKN0Ckz+LXHsWUzDqOjWQCfBkzQclI3QB6gaqsRSE2/
	 rNpFSIQO7X0TnOa7chkmJSC5WfXcByk7mINpswxAlaQuZxB+ZB6Zt59omLlT7tUh25
	 TcjCal624msc6l29AgCVDXldMGRAd46TlPyzoAlBwxU8CnT9vIjhHgwbeKLl4KlH3H
	 WUQabcJgVJr6glP72zbdlvPI9Zk29sxJ1gKb1mLQaij73XCdxKGWfq2cHimJq/ZUsu
	 YQmMKWXvM6cedtnYWmUKMTrcGUpevv6p8+BFE7vf8E0lPsvK8Xyxt/qRlM0XmcUXs1
	 J9mN1+Uqz9PQQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4.1 02/15] tracing/filters: Fix false success return in process_system_preds()
Date: Thu, 29 Oct 2026 11:30:11 +0900
Message-ID: <179324101176.752804.17624386967710135045.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-188613@kernel.org>
References: <sashiko-outbox-188613@kernel.org>
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

Fix this by clearing "fail" only when at least one event filter succeeds.
Consolidate the cleanup logic in fail and fail_mem by using ret
initialized to -ENOMEM, setting ret to -EINVAL in fail, and falling
through to fail_mem, freeing any replaced filters via delay_free_filter()
if !list_empty(&filter_list->list).

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v4.1:
 - Recover 'fail' flag instead of clearing 'ret'.
Changes in v4:
 - Clean up process_system_preds() by replacing the 'fail' boolean with
   'ret' and consolidating the cleanup logic between fail and fail_mem,
   as suggested by Steven Rostedt.
---
 kernel/trace/trace_events_filter.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 28977d10e60b..981cddf01e65 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2338,6 +2338,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	struct event_filter *filter = NULL;
 	struct filter_head *filter_list;
 	bool fail = true;
+	int ret = -ENOMEM;
 	int err;
 
 	filter_list = kmalloc_obj(*filter_list);
@@ -2364,9 +2365,10 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 			filter_disable(file);
 			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 			append_filter_err(tr, pe, filter);
-		} else
+		} else {
 			event_set_filtered_flag(file);
-
+			fail = false;
+		}
 
 		filter_item = kzalloc_obj(*filter_item);
 		if (!filter_item)
@@ -2380,8 +2382,6 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 		filter_item->filter = event_filter(file);
 		event_set_filter(file, filter);
 		filter = NULL;
-
-		fail = false;
 	}
 
 	if (fail)
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

