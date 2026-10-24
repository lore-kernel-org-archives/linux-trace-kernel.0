Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859147;
	b=JjfP683jlKNDk0wzU2THw14Bv10W/BiszKRI1MSQe+q5jaMf8QEsz6ndFi3xahGAkyuR
	 PR7QIzwNkdI/NNTSjd/UdyaXn61RWVemBYFwwU3Y2WEjVbvyMqiEaOai3dy5rEEKnERfr
	 /FLYj71Ypd8RwtpJ3T8rnxYRNxi+CjSparJWukv8Vj343i11xDffADQFExkBTq3ZX30QV
	 IVlGGeBCFseJbozSdxLCyw9NpPSFsJGeKWFpNrR3hMSS3z0H4g/+JhEsm6dSU5JSRMXVR
	 4H1wYIuaXVGaWec8ijjXHSvjIRV0EFL65hlCFhIC/zJHi5OqHJaC53aZ2KLCRnV5rPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859147;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8+7QML/MTirhKCJ2JXKlhX3yt6vot1PNexqDkPxeiVU=;
	b=ElZMmu6sKQ/WHa2Fnk00tVy2ZQoQtGsCas2hy18wRvv1GfINdzNR10cEH/ZCeUhkG2ji
	 +rMrZBCXKQ3cYsbIbh9uAuxUS8hFm+Ny7iMiRdHRSRndxMtiNsujnAzZzMheV/eITKPyv
	 vh4IpT35kkrQB5xshcIvk8vsUjQVN3yFAfqQHx7M+YZhZb2Mw8+aJhAXqPJ4iQMmV7cPe
	 3+NpR3okUOAqCK2DkUF20/NXRxx6SrRNl+lkl6cIcQ/cnUw5bijnN+/pRNBkNjmq1b5nG
	 45tWTlPAx4CNm2ahOW5mtqi4bqA8rWnLQM3Z/cdeCUtJMJuVsz8EOynad9WkNlpwL0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZsGKfJX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B97606A31E;
	Sat, 24 Oct 2026 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XZsGKfJX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE521F01825;
	Sat, 24 Oct 2026 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859146;
	bh=8+7QML/MTirhKCJ2JXKlhX3yt6vot1PNexqDkPxeiVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XZsGKfJXNKTs91gAm0E9k+Jhggh8S7t7r3Vf+jk7VoPooUsV/xCcAiob7iCEa5rhw
	 JJoxc0tBHudD0m95/zlBqWbh8cKGX8D4wadCRENkmEeRZ9gAo5b8QflWICaix5kmWV
	 9hOgWYGMx58tSbQk6pMBUxZX273v8QGPQn79pn42lWrUpubUF6wTZYPJKt78Kxy4xx
	 AFsIcrMEJTkWdrkHS11Y8r2KkxfGrdzwxR3eYMcbuM53jZizdfcUgQNqa+Z4rQ9JY4
	 XRGn577uFPGcMoJG1oXCgyxKMOgw4z3AvLIvlxXIw/D9xcI3Kq+eXTLjsUY5UCCws/
	 kj7Ie5SPYTH6g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 02/10] tracing/filters: Fix false success return in process_system_preds()
Date: Sun, 25 Oct 2026 01:25:42 +0900
Message-ID: <179285914279.466249.18363232291728825688.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179285912318.466249.7425922682086130057.stgit@devnote2>
References: <179285912318.466249.7425922682086130057.stgit@devnote2>
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
index 18ce3ec00d34..c2c35b4de85e 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2332,8 +2332,10 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 			filter_disable(file);
 			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 			append_filter_err(tr, pe, filter);
-		} else
+		} else {
 			event_set_filtered_flag(file);
+			fail = false;
+		}
 
 
 		filter_item = kzalloc_obj(*filter_item);
@@ -2348,8 +2350,6 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 		filter_item->filter = event_filter(file);
 		event_set_filter(file, filter);
 		filter = NULL;
-
-		fail = false;
 	}
 
 	if (fail)
@@ -2364,14 +2364,17 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
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

