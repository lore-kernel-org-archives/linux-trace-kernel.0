Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148255;
	b=jrUS2QqItdEtP2BncbjdnVlEZBIiTxAjeBaXM4bPZWac9iyfrkG164cgVlI3iUvYY+Aa
	 1PY09XLfV9d+KJVBLiV39ltky0ZdD2WMgi1L67haob00n2EfNmh1Q1QdztkaZwnQ28QvF
	 kRa4gXwM6u7EhGAjU6pXKr0BG4IwnOtkREqX3ycXC81Y/jPQXBLukoqF/KrwiqM7EVkb6
	 u1AV1g/njblE6QpCO8t+z79I/8phqAgBhRG1hrpLE1cArZ/w0DE+n+5kzsku27DgBFKPX
	 852D1+Uw0KbN0WviwZpp0Q28kE13MSMB63gRnXXty4SGF74ru/PiSXtYHAX8TN2rrTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148255;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KXpgXX/EcP8tfGMvBOopICmRKy9FiFaZDRlaGR5/maE=;
	b=5DOPUdorQGEIWqMcsZz/B11dlEaN+72qMQtYKYm9ntnG7Vc83SlG9tOvmM6Mehj8hqQU
	 KvVD7J2yzyRHUJ7Th9S3+ZAE2fno9DZEMU+USwMa1HB+oOyWq6vWERKZbw9taJCsYHe89
	 UjnatSNxFZw/gRQsM8297GIy8CMMspjnF1Yh3nKOlRFNJQ/DJzn3YHUxp2C6iR++6Kh8c
	 Tpx5U4aVx0vyA/w7wAhTvBWlLwyG1AT8YoItc1PTylF0Hzhw42OR8X2hIbqLa2m2xUCwK
	 ijDfoLf6XP6/ZMXcI/rbd/JBMEPHE08pUTquV7SpZZzDJTY7ekrjodiD3KvMnxFG8iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+U8MlSt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6311E606A320;
	Wed, 28 Oct 2026 00:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+U8MlSt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BDC1F031E0;
	Wed, 28 Oct 2026 00:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148255;
	bh=KXpgXX/EcP8tfGMvBOopICmRKy9FiFaZDRlaGR5/maE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F+U8MlStVW9cTP+gXOoZYsXaLJ0eMj3zx07edRUqkBtaOV6x5brAHs4LHZg1FfsZA
	 toUPshfEROrY4cS8qHfI+wlsmlsTa3PZLCd8cqEL49U26El8sxM7p9QQd61FBAjWIJ
	 +GWOXbsw+CFTbtEfUVnbCT4y1lDwKl+m+IbjVQlg6BSX6gN9+5UrkJlfyhCeWoqYrZ
	 cxlmSEyk91pKNs4pd6c005KCn/RgXpx0T5qze5wzxyyhXCZVkOIir4ee/mWPlZFJvh
	 obiEZBxVJP79M1UE+AcDgmxdYmvikWjW/YxJlIykAYJIflgy1bAZd/WL6WHAuRY3LX
	 XbsEHYSq+iqCA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 05/16] tracing/filters: Report parse error on all -EINVAL paths in filter parsing
Date: Wed, 28 Oct 2026 09:44:11 +0900
Message-ID: <179314825153.684037.11489088137525338406.stgit@devnote2>
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

Several error paths in filter parsing return -EINVAL (or -1) without
calling parse_error() to set pe->lasterr:

1. In parse_pred(), when an invalid token is encountered where a field name
   is expected (e.g., "common_pid == 1 || (common_pid == 2 && )"), len is 0
   and it returns -1 without calling parse_error().
2. In process_preds(), when !nr_preds (e.g., empty or whitespace-only
   filter), it returns -EINVAL before predicate_parse() can set
   FILT_ERR_NO_FILTER.
3. In predicate_parse(), when op_stack overflows or the jump target check
   fails, it returns -EINVAL without calling parse_error().

Because pe->lasterr remains 0 on these paths, append_filter_err() falls
back to printing an uninformative "Error: (0)" instead of reporting the
diagnostic and error position.

Call parse_error() with the appropriate error code on all of these paths.

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_filter.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 3f56e234a02c..2554120ff6d6 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -515,6 +515,8 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 		switch (*next) {
 		case '(':					/* #2 */
 			if (top - op_stack > nr_parens) {
+				parse_error(pe, FILT_ERR_TOO_MANY_OPEN,
+					    next - str);
 				ret = -EINVAL;
 				goto out_free;
 			}
@@ -638,6 +640,7 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 		prog[i].when_to_branch = invert;
 		/* Make sure the program always moves forward */
 		if (WARN_ON(prog[i].target <= i)) {
+			parse_error(pe, FILT_ERR_INVALID_FILTER, 0);
 			ret = -EINVAL;
 			goto out_free;
 		}
@@ -1703,8 +1706,10 @@ static int parse_pred(const char *str, void *data,
 
 	len = i - s;
 
-	if (!len)
-		return -1;
+	if (!len) {
+		parse_error(pe, FILT_ERR_INVALID_FILTER, pos + i);
+		return -EINVAL;
+	}
 
 	field_name = kmemdup_nul(str + s, len, GFP_KERNEL);
 	if (!field_name)
@@ -2296,8 +2301,10 @@ static int process_preds(struct trace_event_call *call,
 		return ret;
 	}
 
-	if (!nr_preds)
+	if (!nr_preds) {
+		parse_error(pe, FILT_ERR_NO_FILTER, 0);
 		return -EINVAL;
+	}
 
 	prog = predicate_parse(filter_string, nr_parens, nr_preds,
 			       parse_pred, call, pe);

