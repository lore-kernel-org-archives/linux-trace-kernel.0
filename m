Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859184;
	b=f5CuGpTp7/mTpgVRAdCj56QPRjA83Z9PuihXjrfuYRXIeYgaaDfN7FpjdpEchsU6kMgr
	 I5yU/eDpoQUB2yCaJfLZKCiISmOKN58x+zpVAMYwvB6S8oQ85k0X//CPaySMwnx0JLpBa
	 WeyJYxzo7n9zd/++unpasueoeCCO1DvCSPA68FjCFnuEgTxs1ol14is9nCPaZ3mGR6hYC
	 Twc7txopPYgyCCyK2IK6xXG3tXySmjOmGKrvCxyP1DooYFgJ+BlX5rQmO+Ipsi/MkJuyv
	 xFxA0TgZkfYIurkp1LqSIW8YXH3jaGi4bI3tnFBqIn356QDYkVNwEXmIxoEVyT7jxHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859184;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=x2K+JcgEXwjAprRXTw7X+lnifU24Dsjycf8GetwMrOQ=;
	b=lHYZ8GDjUmGZ8ouqo6/lZQm2DP1jiZdWdHsivGs8urUKANIWBZXnVASKUTK6cDU55/2J
	 a+VpNsaXkCW8YlvGoJRZX5QOFdPMSPTtNDOTQ+9p2ucdO7YAVwSfMYc92zkxnGCJp1f5U
	 Adq5mnEkDzxqc+Mi+4T2X5oPXm9ztusx+xSrk5M2kqbIky2ghf6KbP1MMz3Okrn++gvPY
	 7TpmSdObbQ6fRWB3/eaNuOQITL9quvf7l7FQnlWIyJrIbzhKBRcBmuNezxyD5gey+h6zC
	 pUIxVeAqwh1EyG9LYGW9l2wgLneYD6dFXdsGx13tFouFTuxEZQUf5mg95kucJlh8lVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fcFIVXgc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D37606A31B;
	Sat, 24 Oct 2026 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fcFIVXgc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C27F1F031E6;
	Sat, 24 Oct 2026 16:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859183;
	bh=x2K+JcgEXwjAprRXTw7X+lnifU24Dsjycf8GetwMrOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fcFIVXgchmUWbCb+FUuU6Cqyi5HGlRCYqJISKGkNbqII4DFJ61xML9CiBAMprxI/X
	 2gx6yQD0FouPMLbwGL45ukx/noJpfCxNGglLWVFVwEs2eISKje0NFPnE5DFXtUIJF/
	 4Y6pNsksd4RoNDivoqPfatue0IYHmq6cmmz9agYCYAVy6J6Rfu04PuwdGe+A9N3wbh
	 Ihm/zxb0w5IzjMavgs3MmZO1CKznaz/dQAPKXwSlBPrEzXjvXxV39t/H2U2wvFW5lx
	 2qSRdJTV2FVGiYCeY6nQCSPtcB3kU1SxD3XQgXusXUbbJcZiwORmyoX2KucaNBxgz4
	 6GiGGhl8gKcFA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 06/10] tracing/filters: Fix function event operand parsing in parse_pred()
Date: Sun, 25 Oct 2026 01:26:19 +0900
Message-ID: <179285917977.466249.218328175465077201.stgit@devnote2>
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
index 7e119c7164f0..96eac7ccd488 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1833,22 +1833,39 @@ static int parse_pred(const char *str, void *data,
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

