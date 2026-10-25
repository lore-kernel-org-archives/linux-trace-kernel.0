Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792917480;
	b=ijeRkw++xnNI8/WYT9fM5G5+bmX/wWITZTTFIT0LTwZKKkKCyiAd5L21Z+hSrqEjeOLA
	 BgnVl85JuWF5OdDL3Vws4bE2NjNYzImY/L4nkElnRYx1pcpuJX5iH4ZPtGW8QfVrXPECy
	 KwNqc14ltLTNfxaSBFNaWALXz5XbmfG474kbt0Nb+T9fWH304Tap3vszNBxI8TfpCxIIu
	 mNZJTK4G3vu7/WtgNDSjZvgBsR41sVoYhwb0zCIkWC/dkef5KXvlLjIU4lzr2iWPKtPGp
	 iecQMc+b1AarAZQiNhJ55fVa1wp726yXf4WMl3xl71ZELcHJ2r56GCqu4Fqc7pg6OHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792917480;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=I23/71ZTtl/t5h/xAt3w7M2YNVWBcjjHJX2DJ58UAHs=;
	b=OCUtOGMbdbIfFXdRfFKzmBEIT5myg/3cljCqR5yxmQtPUoHH9K4bl/jBS/hId87bInil
	 xhR+W4QIImjW4Qoc3P50aymFdIy+TfZUUVO/TKEx/VzykRfb5kFWaKpHU4UiuZoDWBRSs
	 hKDIc6fxfUiLNXxM8BFsSOElKWD4W3hkw+HzyS7X3GsLLOF50AHETIQ/38Yh0/rL7kVJK
	 fiFe7+Oslb4YzVQSckfCxUia4CpiK09xfHInrZ4u8N9SvxyNxQgSEhHy/H+egAOkeI8iX
	 QlEupcdYJLlZRLud0awc1uAjVy/nuzQ9IDvNFdysweecD943Tx4EqhT73sDUSsxarhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZmM5k5Lw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9543B606A31D;
	Sun, 25 Oct 2026 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZmM5k5Lw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C571F01825;
	Sun, 25 Oct 2026 08:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792917480;
	bh=I23/71ZTtl/t5h/xAt3w7M2YNVWBcjjHJX2DJ58UAHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZmM5k5LwTkzdkGBrNz2iPdYrFNY9Eq5t1pt0s3LvUczsBVIYhLkstsjt/UEThSnQh
	 gi1QAAUQ4WpgrgzEYsq1uWpNl+p2FU7Mta02byptDgSYKcJT42lWFSdGRU6zDzgtcr
	 w42dYc9pbHZEqeF8+yqh3b8vvxx+YFtJvbKxLqbEQy2xWpxnZLRyj/KggSO8APGI4I
	 FNHtIbrVVI9srMGGj5dsRPssZzENrJAVFA0yCmnFb5oCpuQ+YJRmrV6uARi+VeRzGV
	 LOKC200RHZBWvpqW8igF018+LjjvXKFhkmhyedyn+1pZd4u6pXRwS4adqWQ0ztv57Y
	 HcYLqye3pBVEQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 5/9] tracing/filters: Fix function event operand parsing in parse_pred()
Date: Sun, 25 Oct 2026 17:37:56 +0900
Message-ID: <179291747675.492959.6739928041718890503.stgit@devnote2>
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

In parse_pred(), the ftrace_event_is_function(call) branch has several
bugs when parsing the string operand:

1. The loop 'for (i++; str[i]; i++)' unconditionally increments 'i' before
   checking whether str[i] is the NUL terminator. When the operand is empty
   (e.g. 'ip == '), this advances 'i' past the NUL terminator and reads
   out-of-bounds memory until another zero byte is encountered.

2. When the operand is quoted (q != 0), the loop breaks with str[i] at the
   closing quote, but 'i' is never incremented past it (unlike the regular
   string literal parser which does 'i++'). Furthermore, it does not check
   for a missing closing quote (!str[i]). Returning 'i' at the closing
   quote causes predicate_parse() to immediately re-invoke parse_pred() on
   the closing quote and fail with FILT_ERR_TOO_MANY_PREDS.

3. If the operand length is 0 (e.g. 'ip == )' or 'ip == ""'), it accepts an
   empty pattern instead of rejecting it with FILT_ERR_INVALID_VALUE.

4. When the operand is unquoted (q == 0), stray quotes or '(' inside the
   operand are consumed as part of the pattern, desynchronizing
   parse_pred() from calc_stack().

Fix this by advancing 'i' and 's' past the opening quote before the loop,
starting the loop at the current 'i' without a blind increment, checking
for missing closing quotes, advancing 'i' past the closing quote, and
rejecting empty operands or stray quotes/'(' in unquoted operands.

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_filter.c |   37 ++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index cc3a53e7cdbd..3bd0b47a627f 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1834,22 +1834,39 @@ static int parse_pred(const char *str, void *data,
 		 * Quotes are not required, but if they exist then we need
 		 * to read them till we hit a matching one.
 		 */
-		if (str[i] == '\'' || str[i] == '"')
-			q = str[i];
-		else
+		if (str[i] == '\'' || str[i] == '"') {
+			q = str[i++];
+			s = i;
+		} else {
 			q = 0;
+		}
 
-		for (i++; str[i]; i++) {
+		for (; str[i]; i++) {
 			if (q && str[i] == q)
 				break;
-			if (!q && (str[i] == ')' || str[i] == '&' ||
-				   str[i] == '|'))
-				break;
+			if (!q) {
+				if (str[i] == ')' || str[i] == '&' ||
+				    str[i] == '|')
+					break;
+				if (str[i] == '(' || str[i] == '\'' ||
+				    str[i] == '"') {
+					parse_error(pe, FILT_ERR_INVALID_VALUE,
+						    pos + i);
+					goto err_free;
+				}
+			}
+		}
+		if (q && !str[i]) {
+			parse_error(pe, FILT_ERR_MISSING_QUOTE, pos + i);
+			goto err_free;
 		}
-		/* Skip quotes */
-		if (q)
-			s++;
 		len = i - s;
+		if (q)
+			i++;
+		if (!len) {
+			parse_error(pe, FILT_ERR_INVALID_VALUE, pos + i);
+			goto err_free;
+		}
 		if (len >= MAX_FILTER_STR_VAL) {
 			parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i);
 			goto err_free;

