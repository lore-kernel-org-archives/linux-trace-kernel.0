Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148301;
	b=yYaKPvPOwQ5XZZ6uOabYaDSLEmNQ/X42NLzqcnyiAqY6IqdA3JdQtpJOYeuL7g7wTHIp
	 jLtAZP33VMJlZk+e59riRYPgLZIgrUJKuWMB33NUXxGnGw2ZYt6GSbggkDnKf7SqC9eRc
	 EjkhAnVmOtccG441JgySsMCaGX3OAVSLeEQUlxaG2cfstq2GKdGsshKIRGGQhAST8iuSi
	 pAHf+/7RTNfuXA7dH94cGLKGcQj2d+uHT6jWDWbWgoXl/qANQ3O92OgOmbHNuqBo+UZF7
	 193GK1yRuUt+szImJzJ2ea+mVGCV8zCXBVjgILWMfQJZFnb99qJB+w1/ox84EuG+w/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148301;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=q/njGe7Kw40L+HnZLFGu8svbnw5WSLAGRQjHu8QW6Go=;
	b=5bTacNFX+STNcWEqtN67i2eaVZQ85FFbufZ2ou7/zhOxfOaYlGJRIFo7jcIiX0mGgrJa
	 6Ntb4PA78T5o6t80/9jIFp7AQH34z55sTOzAtZLc4USXAneylAYrt8d/8pkZnXb6mJK48
	 AQkKOWUri4pIjJHScb0xd6D7iwUsVS28mPfl7iTOXG4B5i6dHM9GsrNPWFpHuTrmJRNIT
	 Qw6SFz9DCBZpSn9N+d59o4ino2Z7T64YUt0UfxsVlHHzyNLpOtgkfE9dJgedOKbqbHwMx
	 DQbDPZIL9ytT85poaPlZImTTV6qXIrorQdIL0ZpYY0jrWdBfYE/vkKQ6eXEkXUOIzRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1J9+niT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC0606A323;
	Wed, 28 Oct 2026 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1J9+niT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6231F031E1;
	Wed, 28 Oct 2026 00:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148301;
	bh=q/njGe7Kw40L+HnZLFGu8svbnw5WSLAGRQjHu8QW6Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k1J9+niTBoHQBMbcoALxY3B30ByfykjVkF+fbRUJKj1mpKu21W/cLWxr1fcNJyfgM
	 hP8mKlz07wbU3ogwfGBrTcMzHU1RmvAaYeEKK1nZjwDCimtBZXXY3GDO9YeTFC8RKx
	 Tf3tJFDQ7F9DfYAFn7Aw0JRN6u8yF7dfTBLHDUFkvxk3+zFLdqNYrfyKsoHSLjkXMs
	 y4OQtGLLThZTtnOb8TnwmQsH1Z9U/tklD8FJn2Vpjv4zP6PbHytF8iL6YBrX7N+GOI
	 njetyI1MWFMocLj0UrGnbdY6/CkrkN/AW/SA5+FgoJBrly05w+161lhO7NLOUCuEAY
	 4b43R4Ch7grZw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 10/16] tracing/filters: Reject unsupported field sizes in parse_pred()
Date: Wed, 28 Oct 2026 09:44:57 +0900
Message-ID: <179314829749.684037.9027529978212126421.stgit@devnote2>
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

Prior to commit 80765597bc58 ("tracing: Rewrite filter logic to be simpler
and faster"), parse_pred() checked whether select_comparison_fn() returned
NULL and failed with FILT_ERR_INVALID_OP and -EINVAL. That check was lost
during the rewrite, and commit 3cbec9d7b93d ("tracing/filters: Enable
filtering a scalar field by a cpumask") similarly omitted a default error
case when matching field->size for CPUS{} comparisons.

If a non-string field (FILTER_OTHER) has a size other than 1, 2, 4, or 8
(such as a fixed-size integer array field), pred->fn_num remains
FILTER_PRED_FN_NOP (0) and parse_pred() returns success. Subsequently,
update_preds() rejects FILTER_PRED_FN_NOP via WARN_ON_ONCE() and returns
-EINVAL without setting a parse_error() message, triggering a kernel
warning from user-supplied filter input.

Restore the check for FILTER_PRED_FN_NOP in both the numeric scalar and
CPUS{} branches of parse_pred() and report FILT_ERR_INVALID_OP.

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Fixes: 3cbec9d7b93d ("tracing/filters: Enable filtering a scalar field by a cpumask")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_filter.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 48e16d75be74..9d1446464058 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2015,6 +2015,10 @@ static int parse_pred(const char *str, void *data,
 				break;
 			}
 		}
+		if (pred->fn_num == FILTER_PRED_FN_NOP) {
+			parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
+			goto err_free;
+		}
 
 	/* This is either a string, or an integer */
 	} else if (str[i] == '\'' || str[i] == '"') {
@@ -2164,6 +2168,10 @@ static int parse_pred(const char *str, void *data,
 		else {
 			pred->fn_num = select_comparison_fn(pred->op, field->size,
 							    field->is_signed);
+			if (pred->fn_num == FILTER_PRED_FN_NOP) {
+				parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
+				goto err_free;
+			}
 			if (pred->op == OP_NE)
 				pred->not = 1;
 		}

