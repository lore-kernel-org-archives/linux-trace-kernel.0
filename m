Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148274;
	b=wZQsYBHwQ6KrDHAfNKWKz/XRkCD9sSH2lte+6nUzHv5b33EyvZe/piZ+JoN2LkP8lFni
	 QTJmhuGXyoR7XTIMRL6QPM6mJDurMBmQLIJUy+oJcFlVYoElH7GyCmY5HDUPjERWJrVhT
	 nXmjqvqHaOQD4XRdxm2wogdGXA6negiZwuCNrtYPR5dtSZ8vSuPGjTslh9lTH/KFlSg1F
	 niUf2P9xGfgKFUhuReMZWs5+m1oWyHO6+axYStCakBG2Z0WhzJzQYJP0w9tVtd6vTELf9
	 3+milsHStNoOXQDrydv3dvl674LWh+dmqsVOf8xFXhL+eHlF91P/h6xrlrEncr1CLLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148274;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0AjV6bYWF1r75TLZarB0zqfpDpujBtOqdxX7XWbSDaU=;
	b=UgxMTY5JoJHDLC5+rerBxymrioTKudOC7uyKrjH2VWb8ngjh3zFOC+3ROP+gU0rNNfGj
	 3ojH4yMmrmcdtlDOEsttpagohmX2G/adFNcgqAsVGUwYNpmF8eGFYbYp1KQOTuUzF8k8K
	 MxrRC3UDejGTj8jCmVsbpqsp1oJlZyUBNneaLvN/O6IPKQa8frZDApwV5Wn+oPI6ygWRk
	 I8/kjwLkvBMuIK5X+REoTw8TabC9QQE30JSjCEva0y3DbOhnTyoaw0KQ4vTozbNMZ2G7T
	 CyDi0y79L7NmQIj1uJZGQUU176J0g1WQkffFVcPEoeWiskiZPFnppreu0K6Ua7ZF1gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oDZmL+B/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3735D606A31D;
	Wed, 28 Oct 2026 00:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDZmL+B/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D5A1F01828;
	Wed, 28 Oct 2026 00:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148273;
	bh=0AjV6bYWF1r75TLZarB0zqfpDpujBtOqdxX7XWbSDaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oDZmL+B/euwFBNO6Y2kCdU6/tw62kL2qtTGWdtjlqeVujTwGEjpf0R2AxM8dbwBVF
	 jEW1pb4qRe8aF6AdhhMBAUCx4VfvF9gEz4JX+VyKnfxzp1Ti8Snfhqtyr5LTgqtIHN
	 epsNUagd4rBsuiN2rvg+BAydoElm93P8+tBxLOOcz2jIhNur/bqxmGiz10/6uHr8M2
	 kMlMo7t7FMme1qGgwihOmzbBfW//WGVIyEPJqVrunY/Os9Lw0bkTzVtH+SbY4ww3Rm
	 cx5vyla2IsELtjySiwjgTgSSOuebwjW217SH25QBt3rzjGQLLLYerQVPI/qlxklIBY
	 RHwP9BX5Y9MVQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 07/16] tracing/filters: Fix quoted operand parsing in function event filter
Date: Wed, 28 Oct 2026 09:44:30 +0900
Message-ID: <179314826994.684037.9596014447755216572.stgit@devnote2>
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

In parse_pred(), when parsing a quoted operand for function events (e.g.
ip == "schedule"):
1. The loop 'for (i++; str[i]; i++)' breaks when str[i] matches the
   closing quote, but 'i' is never incremented past the closing quote.
   As a result, parse_pred() returns 'i' pointing at the closing quote,
   causing the caller predicate_parse() to immediately re-parse the
   closing quote as the start of the next token and fail with
   FILT_ERR_TOO_MANY_PREDS.
2. If the closing quote is missing (e.g. ip == "schedule), the loop stops
   at the NUL terminator without reporting an error.
3. The loop started with 'i++', which was intended to skip the opening
   quote, but also unconditionally skipped the first character of unquoted
   function operands.

Fix this by advancing 'i' and setting 's = i' past the opening quote
before the loop, starting the loop at 'i' without unconditional
increment, reporting FILT_ERR_MISSING_QUOTE if the closing quote is
missing, and advancing 'i' past the closing quote.

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Split from the monolithic function event parsing patch.
 - Allow empty quoted operand ("") as valid syntax per Steven Rostedt.
---
 kernel/trace/trace_events_filter.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 3d2a075ec425..170d51ff337c 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1853,22 +1853,27 @@ static int parse_pred(const char *str, void *data,
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
 			if (!q && (str[i] == ')' || str[i] == '&' ||
 				   str[i] == '|'))
 				break;
 		}
-		/* Skip quotes */
-		if (q)
-			s++;
+		if (q && !str[i]) {
+			parse_error(pe, FILT_ERR_MISSING_QUOTE, pos + i);
+			goto err_free;
+		}
 		len = i - s;
+		if (q)
+			i++;
 		if (len >= MAX_FILTER_STR_VAL) {
 			parse_error(pe, FILT_ERR_OPERAND_TOO_LONG, pos + i);
 			goto err_free;

