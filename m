Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558548;
	b=ZWUA/46A4MVvgC0VK9LXD5ZzU0WOk/kB8HA28SJ+fEs8t4X2fAkT2+pIacSu7XklKCiV
	 MzYuB5UhCuZC4cMX8lRmO/25z580kIDK5ZMWu2Dv4UsjEXZr9slRo6L2EM1Q31qGIKwwJ
	 l+5DItFKH7NR1hw+DCh4ow5hFFWKwszfbf6k+X7V0nLGDs/I5gBUL4eehb6UwT1XdYdiX
	 z9hrhfOB4XJZbdvxSFJsSej21xPABVUc5Stud8TiFkSjwqCQQHRiGWtoZuj1YSZx9dxSL
	 QYkXdWMO4xXoW9z84JQ6DgwEXGWSu1ATchpL+T3Q8bCgqXosAaxy/BK6lNlWR3NeD2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558548;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1AwWcvkeRud93GDBMae6LrZrlFU0fyzvM6nJxF8yh7w=;
	b=QiQcR8KtCUXCjBxeXQ7MwkPA3LwLZyb5SaJEfIKAR1RFPImQBkEl0dBF+TvpxAmn6iVW
	 Pz5qsthq+C/GLzcaj4dmZfIHi9P+S8BwfDSo2hWRPSbgZohzzydCrFZjAUAXfzhsKLv7c
	 pB9XsUdLlRxfyT0mWmcsQYYBKz2cRKuHFXW+RpV4L5bMCtxKtY7fw1hC4fr2KYaf67osL
	 A9255abBuf/j8u2F/KnCHjMaVCwo6sKbDM81YunM1YKH++sUDk9JpIRZuthsZ/qY8euWW
	 uJU5zi1CLlNz6IRWMooQPOyDCvDAfZqLVYMJSQLYFIMt7uF1qIe04/AirXqrWuRrz1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R5B/pbVL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7588E606A8A7;
	Fri, 13 Nov 2026 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R5B/pbVL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517041F000D3;
	Fri, 13 Nov 2026 08:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794558547;
	bh=1AwWcvkeRud93GDBMae6LrZrlFU0fyzvM6nJxF8yh7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R5B/pbVLN7KrBsm1Op8rM+yUjmiz/o5MLwgaYxxjd05LhSXl7zxYtwJQWApOH2fdD
	 t2/EzxKHNqu7M4aAIV88CnIkiv0pYOmyIteX4qGWlaEz4NtewDCAy9c36V0rmOJsBw
	 0WZhxu8ZbMcO/g6S1tbIFOxPcgPOqO3iEbC4brww3HulRXm04jw5mCzhRRDtuprnGQ
	 RE3LYEIHytD7/fHkn4lNUh4RkeXeQZXvvWJhDAWVaKIi3KNCodFHWu4cdWOKpug0RH
	 81EV+cW82OeuUixHxbbg1iJS8S3DLfCm4m6t2TAeE8ZZnqfotYyLhKrxqGdq+AqkPm
	 90E1b+AO7CJkw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 07/13] tracing/probes: Fix user-space dereference string array store type
Date: Fri, 13 Nov 2026 17:29:04 +0900
Message-ID: <179455854396.403392.18073771811100192405.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179455847934.403392.15146485751358774349.stgit@devnote2>
References: <179455847934.403392.15146485751358774349.stgit@devnote2>
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

When finalizing a string array argument (e.g. +0u(%reg):string[N]),
finalize_fetch_insn() advances the instruction pointer to a new slot
for the store operation before checking whether the preceding operation
was FETCH_OP_UDEREF. As a result, user-space dereference string arrays
with type "string" emit FETCH_OP_ST_STRING (kernel memory read) instead
of FETCH_OP_ST_USTRING.

Check for FETCH_OP_UDEREF before advancing the instruction pointer.

Fixes: e65f7ae7f4da ("tracing/probe: Support user-space dereference")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index b8f6a36ee0d4..eee5353ef5c7 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1956,6 +1956,8 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 
 	/* Store operation */
 	if (parg->type->is_string) {
+		bool is_uderef;
+
 		/* Check bad combination of the type and the last fetch_insn. */
 		if (!strcmp(parg->type->name, "symstr")) {
 			if (code->op != FETCH_OP_REG && code->op != FETCH_OP_STACK &&
@@ -1975,6 +1977,7 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 			}
 		}
 
+		is_uderef = (code->op == FETCH_OP_UDEREF);
 		if (!strcmp(parg->type->name, "symstr") ||
 		    (code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
 		     code->op == FETCH_OP_IMMSTR) || code->op == FETCH_OP_TP_ARG ||
@@ -1995,8 +1998,7 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 		}
 
 		/* If op == DEREF, replace it with STRING */
-		if (!strcmp(parg->type->name, "ustring") ||
-		    code->op == FETCH_OP_UDEREF)
+		if (!strcmp(parg->type->name, "ustring") || is_uderef)
 			code->op = FETCH_OP_ST_USTRING;
 		else if (!strcmp(parg->type->name, "symstr"))
 			code->op = FETCH_OP_ST_SYMSTR;

