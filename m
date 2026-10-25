Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792917453;
	b=rGp55z0cfDEJEQgDRSGIhLhMLa/EwqGtQevIqGkElxEEQO7ogZIAUzoZv6YWLh0077hS
	 HUsHs8swq7Xyczhr21jltXi0lpQ1Sqw0PTb9DXJQa9sttKLdKC+LPumMvCQ/b1ea6CruJ
	 WY2HQ75nA+oQsLOP7qozw2lqApv3UK+h9zpIOcBTlleIuGM3GYIzIicpBV5f+TVtO54Pw
	 D7QTZV+ocpk4WYMu5m7kRgUrThin4W6ES5w+VdKBZ3E/YJvR5ehKcf4rp2M3RAolx3GVw
	 YUfV9ZBKUIc59NaocE3Zt4O4zTQ8/IBlImpOn92LJvHqGuACvGnn9Ku7JvLBBRUNBVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792917453;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=c11nNE9musyw5SEFU626dEOzX2BE6xGnygyuaASYG9M=;
	b=LTAgNNjBFKEEh1MNa7OkbSwUksifRyr1+wW763bYl61TlMJfFuJ74Wzz/3RKWzQp0yRv
	 yJqBlBJ2WkYCPKaS6ZzgAgRO4saYqGKOQTs3TbrpyDATg5V9u191EPsoKS2B/MeJn6dXf
	 wjOtXzPTI4goAgOB8FtMKa14zF2pm6jHQ4+YjbY0zo0DqyLEj0TXFvlclsN8v2P73/ELt
	 Mlgmw8RGdV+zjZBNzl7MkpLHjUgxWrFJEU4tWnZbpUNLoeiX6AKqitBmDDEblMPYI7T+p
	 bWuGW/dyvZJIzNjIgsYG6lEtEYKEFyv9XPuyDlYS5eTiRzeR4FDJ/P8z4nMFxUatO+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZRy/vpcG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E850606A31B;
	Sun, 25 Oct 2026 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRy/vpcG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155EA1F01825;
	Sun, 25 Oct 2026 08:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792917452;
	bh=c11nNE9musyw5SEFU626dEOzX2BE6xGnygyuaASYG9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZRy/vpcGQpSL/yN17r8brS7ckSPMN+u6eEk1OeSkzeOoowZ9NKWhsdRu2+8HpR5GC
	 vZ8L/5+kT4YUPVoW80Grqlcw5dLOHkJ6Ww8YeNT8Lumj35Jx0GPfJiGvAm4i51dy6P
	 QABH+T5Z7deFSKDecDdfR1PIrQPA7y3CfdGGKqyGiFvp8YTdVfXc25cGamFFZDRHYx
	 RQ+FYDPXg5t122jWs9Mdap5jugw9GQojb4eJEcfAt6UHLgXn8HWO7l8hh0Ur1PGDzF
	 5QzPVBYWoWQaQHaTpLsAo5LV9sNGitVFmA2ha+GznnnhEPGbyT9wOEH/2rKJs3S+DL
	 hDSQmv1VZ8heA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/9] tracing/filters: Fix false success return in process_system_preds()
Date: Sun, 25 Oct 2026 17:37:28 +0900
Message-ID: <179291744858.492959.17508556353244248269.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179291742944.492959.11659339795290028998.stgit@devnote2>
References: <179291742944.492959.11659339795290028998.stgit@devnote2>
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
index fac51a2953dd..54144ef9d0db 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2336,8 +2336,10 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 			filter_disable(file);
 			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 			append_filter_err(tr, pe, filter);
-		} else
+		} else {
 			event_set_filtered_flag(file);
+			fail = false;
+		}
 
 
 		filter_item = kzalloc_obj(*filter_item);
@@ -2352,8 +2354,6 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 		filter_item->filter = event_filter(file);
 		event_set_filter(file, filter);
 		filter = NULL;
-
-		fail = false;
 	}
 
 	if (fail)
@@ -2368,14 +2368,17 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
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

