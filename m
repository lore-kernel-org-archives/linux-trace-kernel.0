Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859174;
	b=uNiINsu3PltF4PUK3JYp36+UPOwrpKlo8ko2dRyYAbYS9fosyBBIbUXGdGBqiwVczUAm
	 CLUj+TP7y7Y+gHNRrgfs7maQZVfb0TzCCTzPOwAnJ5ZXg8ZgVLK8kGqQBorsDe2XiQ9F8
	 3VGh7eV2A2MV68dOJnHFKDhh2rA5YvgAEN5ivLMuRcOrbS35bVBtJdmoyRgsWXvNYfifd
	 gPEIbIfM7zQJV45kWkOFp9SSFPfzPMP91d7aE78U09EKsJXteZpo+9pSq+vdhb7+uDCbs
	 jRsdu6PLdYueQgKW2aWe88oJy7Hx8k3zg1FLgq9qrLJq5sxQV5jMaOGKrtN7zWh5NFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859174;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Lirzxgy2qlCsGDSTcMZz1cbWaINV7NpFI1j9a88VF6w=;
	b=VPY2QqpgR0iRZk/5+KU10cqkHFHALu6PoyCFXoBwlAMZCwFjNWimhx7TES5/C7XbJHk8
	 TuFi8TGbodSsV3+pCZ/IIE8CnwRbCuPcCYrNoO0LYI9hdMHsgXjRGbK+ctCN78oSljfx3
	 uzz00bk5gxrqprgv9Sv+s51FjY5C22aRNDwjK8pzo3W57D0U0hrPzx8AQyHETOoUFrNNY
	 PaFOZ7uZQzxqiajiGS23XgloX9ZAh6As/V/NwzJEqSveEcplU8oF+6GcRlZaz67hb+//+
	 kruD2/Y8ZFU18TtzGopXh9UsePlBhns83O87f2JNg63T0SgPZQkZnnerPCWCuwQDPpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wm8wsSZi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C60606A321;
	Sat, 24 Oct 2026 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wm8wsSZi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD221F031EC;
	Sat, 24 Oct 2026 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859174;
	bh=Lirzxgy2qlCsGDSTcMZz1cbWaINV7NpFI1j9a88VF6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wm8wsSZii41Ydt1CZc3Flh9Q0h+6tEb2JHcHuSvc32RjjouKKUX8KnOEBjzg04jy7
	 bQOSSi4pa5yMuaCkJYq+mVPvHBQFASpE3dDrrZsJ5xc6O4m3acbJZvXKZPZYpfpErH
	 3lbjccGrr9AwDuOgCHEe2m5V/Uk2mkEYRUYSttKZtqR8J07zKfgTpuDHVBCkCL9ApK
	 PQUYAy8AGSt7RHk/1u3WW2zgSIYkDW4CfMmfIRYELJ7vBmSLpoCJrdyFPMOXOurypg
	 IEPS+J3m2qfEeegGldGEJn94GjCh18U2ef56oghzbvcVjGv7Y6FNlNM675WDykhQTG
	 W3Cq5wFEjfpwQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 05/10] tracing/filters: Report parse error on all -EINVAL paths in filter parsing
Date: Sun, 25 Oct 2026 01:26:10 +0900
Message-ID: <179285917054.466249.6580828464905931113.stgit@devnote2>
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
index d9aeeec4ed91..7e119c7164f0 100644
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
@@ -1688,8 +1691,10 @@ static int parse_pred(const char *str, void *data,
 
 	len = i - s;
 
-	if (!len)
-		return -1;
+	if (!len) {
+		parse_error(pe, FILT_ERR_INVALID_FILTER, pos + i);
+		return -EINVAL;
+	}
 
 	field_name = kmemdup_nul(str + s, len, GFP_KERNEL);
 	if (!field_name)
@@ -2277,8 +2282,10 @@ static int process_preds(struct trace_event_call *call,
 		return ret;
 	}
 
-	if (!nr_preds)
+	if (!nr_preds) {
+		parse_error(pe, FILT_ERR_NO_FILTER, 0);
 		return -EINVAL;
+	}
 
 	prog = predicate_parse(filter_string, nr_parens, nr_preds,
 			       parse_pred, call, pe);

