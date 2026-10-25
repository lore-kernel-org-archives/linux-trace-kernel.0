Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792917472;
	b=s+feDLxohYGmufWJ88GehOmXV4T+bsmAJFq/jogdenw5+6Vj+VwFAS+sHfU3MhmOLSaj
	 nTcs4rKn96nJDX1g3HzGhkfckHsETmFtpEKvt93umNJXFqE4702FtchOFg8kAdWBej+L6
	 OnysqT7ruV0wyKFgwuwBVt0XHFcqc3/280cKz9t7UaLzA75+YW352fR6+/z0j4IYgdDzL
	 13TXSMsmF1if2+pSj9WFaVKya3PrGCsCI8RLK0yMgfUgpo3LNVjLiTdKcndP/diDrnOGH
	 x5HxYSXtpo7XwRCdL6bKrHLkLbPOEDA/4ERAvRnlxYtZkR/BAEMJwG3mkfJ05lojpNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792917472;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NjDxTZDEMfhrLKzSYL3qSCXub1i7IlCZBA7rv49lltw=;
	b=eFIPN0mTYeI0eYFOyuAa5eRE39AxpKi12WeVW05Ar8GmndkcTERBWKSIkD3wIJpxPQ8J
	 yIY3zegJb+gUhU3+wCQEKHJG0bFd0nHTUi6VpsVufjfY0I+FY2OlhXdHschiZIcnJWogD
	 IyWyk+TuE+MzoowFbOrZACbsTM8xNyAc1FY1joqKPrbWZjfKIU7haOjT6OgVJy/ikNkOT
	 SGYYst5qSlB85w2H7aI8tPBtZbKKpTvYYNxEuaSWIbE5RYZVHLy/HQ1fjsxuFh/n9uQw/
	 gZlWS+zBW2h/gd6o0vOCY4ONwsIy1EbpKkYgHtGJnUTsSr1rsxmUbEGno5EjIqZuvFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LikmfnNH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5214606A31A;
	Sun, 25 Oct 2026 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LikmfnNH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD46D1F031E0;
	Sun, 25 Oct 2026 08:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792917471;
	bh=NjDxTZDEMfhrLKzSYL3qSCXub1i7IlCZBA7rv49lltw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LikmfnNHKunA3o0724j1VBmcswmtwvE+vcfdCPHQu/kEKS8RI6VNEy0C+0pkbetnt
	 nPhOkkNksN4b5bHy7RKMA70wI+aD9xZMKXnIwDYROxv2ySfYY6JKu5vBVd30RKXxlH
	 Mc4Jv1XbjNmh5RGzzmWe+BZom0QI8Z0iddp80TZ13mgpQENs7p3JpZ6cPL84k1VyEQ
	 IqoP9rSSoDEfQWuuN82K+8S6yqU+riNiLxwBpWyCHn4+Trfb0KIMHXaqy+hi0rwNnv
	 KqE1RntQZOshLkiexF1zSNQM8VuMerGk/oQEIrlzeYdcrxhdhKpC4Wu3jVwBiHTbf3
	 JGeJwlRL3uNvg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 4/9] tracing/filters: Report parse error on all -EINVAL paths in filter parsing
Date: Sun, 25 Oct 2026 17:37:47 +0900
Message-ID: <179291746762.492959.9910173945577366779.stgit@devnote2>
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
index 44ca7772ed2c..cc3a53e7cdbd 100644
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
@@ -1689,8 +1692,10 @@ static int parse_pred(const char *str, void *data,
 
 	len = i - s;
 
-	if (!len)
-		return -1;
+	if (!len) {
+		parse_error(pe, FILT_ERR_INVALID_FILTER, pos + i);
+		return -EINVAL;
+	}
 
 	field_name = kmemdup_nul(str + s, len, GFP_KERNEL);
 	if (!field_name)
@@ -2278,8 +2283,10 @@ static int process_preds(struct trace_event_call *call,
 		return ret;
 	}
 
-	if (!nr_preds)
+	if (!nr_preds) {
+		parse_error(pe, FILT_ERR_NO_FILTER, 0);
 		return -EINVAL;
+	}
 
 	prog = predicate_parse(filter_string, nr_parens, nr_preds,
 			       parse_pred, call, pe);

