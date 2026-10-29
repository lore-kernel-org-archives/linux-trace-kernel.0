Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237859;
	b=ppdphM6COGat/aPdWXPuMmKOBeOv6thxZsPYzhtwkqF8fH/Ix/w8pZwSI6HtvmrbEP0F
	 Wdte3unk/o6B1S5GExRd4X7mAjlmCeaK1yFHG8R6yHvbuIBnP1Vfy5m48hSSpy4fDonQd
	 LpMwZPf76Ewot2PrcpJyK14cTNjCO1AcLHHMOrgbgCA6BXdPGvdwNiLTiTXIuv28EQm3v
	 pKSCRl/UAv4YMiOOe04DfVoaCbbFLuiPr9s4KcbTCIBRybMK4/Ap91UEome9mkpUuo/jW
	 8JyuwRdjewjL0YIIe8w2r5Pmigzxj09olyEQVhj/xQPkxo7zPSXqvzrGfLfLsZzzAEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237859;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=J2z1kqcboxS0Q8UstyJFX9nASO7mnd6jFcF4M5Sjtrg=;
	b=LwGNNIIZfWyoUIdh8CHN/oukyB7muJkMKWTyuMktl6w7SBPGIAJCvQ0Uom/SnSfp5ceF
	 q6YQBHdIsPbTyuH3Lz3qY3ROe4yTZU1+JTmnhrWqM7gpncc4biH60IsZVQkBaQekZiohk
	 gj5uyPkpiZEbd4caekelA85YqVJ1IP6HBpc2YS7aBa6jV7dcstydnrRwY0AGkyOAvnmQA
	 CtNsGP8Hp6PNxM+mA2GjROz2NkGZs0rj3VraaFtEUgye+c1VpKr3rXEk4BESGE4BNiJqk
	 3c3bWXxUjBZk16H+Nj5tj7f8zbeQMzECfjnQT2ggXb9qp+TcX9yMw8QvQ7d1SIlIs/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBG5vrVv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04577606A31A;
	Thu, 29 Oct 2026 01:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MBG5vrVv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126361F01829;
	Thu, 29 Oct 2026 01:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237858;
	bh=J2z1kqcboxS0Q8UstyJFX9nASO7mnd6jFcF4M5Sjtrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MBG5vrVvzfdUVqB+Irq9fLxAO/B3+Ad8r+h+x1C0SYt6u8gyyCHCDp1Smz+6zaKo1
	 jn6MLtYg3JCPMC2OUjhPooYloWKzW4VKma9UxgxVbCsYddIaLdZAIF8xJrRbdBvPYG
	 sLn07JsNB9SpoU614DbGsdPlO1gFZwg6mY1DbbnoXIfEwkRhbZzP201c+XHBDxiWgf
	 bDIsfPuzxSVHPH2gmFoQMktHqz2KSIC5gJqiCbfx7FV2obuvb3RuGD0eW+Bm9Xj7O5
	 lkhn56EU6yTwsQHFy0ZR61zelzRMTIr7KxImj6eJIXR4uHMUV7Gz0i0GFyjn3+TSqv
	 JIWaTniWucpfA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 01/15] tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings
Date: Thu, 29 Oct 2026 10:37:35 +0900
Message-ID: <179323785497.740114.7643531772387726730.stgit@devnote2>
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

regex_match_end() calculates string length as "len - 1", assuming @len
is the string length including trailing '\0'. For dynamic strings
(filter_pred_strloc) and pointer strings (filter_pchar), this assumption
holds and allows O(1) constant-time suffix matching.

However, for fixed-size string fields (FILTER_STATIC_STRING) and "comm"
(FILTER_COMM), the callers pass the buffer capacity rather than the
actual string length (field->size for filter_pred_string, and
TASK_COMM_LEN for filter_pred_comm). Because these buffers hold
null-terminated strings (e.g. prev_comm in sched_switch holding "bash"
in a 16-byte buffer), regex_match_end() tests against the tail of the
buffer capacity (typically trailing '\0' padding at offset 13) rather
than the actual string end. Consequently, suffix matching like
comm ~ "*sh" or prev_comm ~ "*sh" fails for all strings shorter than
the buffer capacity.

Furthermore, for trace events like ftrace/print (trace_marker), the
"buf" field is defined with size 0, denoting an unbounded NUL-terminated
string. regex_match_end() and regex_match_end_str() return 0 when len
is 0, causing suffix matching to fail on ftrace/print events as well.

To fix this without penalizing dynamic and pointer strings with an
unnecessary scan on every event:
- Introduce regex_match_end_str() using strnlen(str, len) for fixed-size
  buffers (FILTER_COMM and FILTER_STATIC_STRING with field->size > 0).
- Introduce regex_match_end_dynstr() using strlen(str) for unbounded
  strings (FILTER_STATIC_STRING with field->size == 0).

Assign these match callbacks in parse_pred() when MATCH_END_ONLY is
requested.

Fixes: a3291c14ecf0 ("tracing/filters: Fix MATCH_END_ONLY filter matching")
Fixes: 10f20e9f9da9 ("tracing: Have zero size length in filter logic be full string")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v4:
 - Drop the separate zero-length string fix patch as redundant per
   review from Sashiko.
 - Introduce regex_match_end_dynstr() for FILTER_STATIC_STRING fields
   with size == 0 (e.g. ftrace/print buf) as suggested by Sashiko.
Changes in v3:
 - Split from zero-length string fix into a dedicated patch.
 - Introduce regex_match_end_str() for fixed-size buffers and assign
   it in parse_pred() for FILTER_COMM and FILTER_STATIC_STRING, avoiding
   strnlen() overhead for dynamic and pointer strings in regex_match_end().
---
 kernel/trace/trace_events_filter.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 5e74d2dae40a..28977d10e60b 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1083,6 +1083,30 @@ static int regex_match_end(char *str, struct regex *r, int len)
 	return 0;
 }
 
+static int regex_match_end_str(char *str, struct regex *r, int len)
+{
+	int slen;
+
+	if (len < r->len)
+		return 0;
+
+	slen = strnlen(str, len);
+	if (slen >= r->len &&
+	    memcmp(str + slen - r->len, r->pattern, r->len) == 0)
+		return 1;
+	return 0;
+}
+
+static int regex_match_end_dynstr(char *str, struct regex *r, int len)
+{
+	int slen = strlen(str);
+
+	if (slen >= r->len &&
+	    memcmp(str + slen - r->len, r->pattern, r->len) == 0)
+		return 1;
+	return 0;
+}
+
 static int regex_match_glob(char *str, struct regex *r, int len)
 {
 	return glob_match_len(r->pattern, str, len) ? 1 : 0;
@@ -2022,10 +2046,18 @@ static int parse_pred(const char *str, void *data,
 
 		if (field->filter_type == FILTER_COMM) {
 			pred->fn_num = FILTER_PRED_FN_COMM;
+			if (pred->regex->match == regex_match_end)
+				pred->regex->match = regex_match_end_str;
 
 		} else if (field->filter_type == FILTER_STATIC_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRING;
 			pred->regex->field_len = field->size;
+			if (pred->regex->match == regex_match_end) {
+				if (!field->size)
+					pred->regex->match = regex_match_end_dynstr;
+				else
+					pred->regex->match = regex_match_end_str;
+			}
 
 		} else if (field->filter_type == FILTER_DYN_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRLOC;

