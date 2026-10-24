Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859202;
	b=XNmxeWoelP4Bc7pPTJWxJVvieURJybbSHJOtwjSeAFMAsk1M3M06tkv/pWz6Fwc+IgZy
	 WgV/LUwTKbvYocMM2JnuMo1gVSjAYSbvGFXNn2bAOKJKQaJ2YHpqi7u3xqgvvnBRxis7t
	 tO7SqA3WQUefBxkVrsNbQAh7oA4QfZ3yesl32OJZduUYMrsK0SudQ82f8c/cbNxKVJbs5
	 SejP+uQIl6yGrWQ7r4jKJ9DpyX/lH7gNh1LE6NeZYY26o9Y0TpIhvYLW3sKjod0+LF9XR
	 wr5h+htuRp8z6k1X7wvLX7pvEkGHD4YhAwwoU5Cj0uZwFHE3Iz+1tuac92Ebdh5iXDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859202;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NzwxAfdW/i7OFOnTa+V9Z3EY89HcCRwjTnYJtteeI/A=;
	b=1pZjx6bG4+DXTaqNFyel2qlXjizrYix9iqkW3X4QGruKmp2tcm0zwH92Ih0ou41y8uQt
	 xQbEb2dkGT5nNYC6f3ATrbvlrdpIBh9R/2ZTGHvHK/gSUAtiX2gbJJam6pO8yi5QH+B1A
	 tzcuWJn/GMViyXxwDAX84Alpc0KQoCsvvUiMr97HR5xYMjIzdg9YQ8PLtLxrhaxWm7w3j
	 l6Aq6vqVTqj/bFqTvBwyTHjvWVTjugOdKgNTlii8dGVnO4LPcnS2EJQAU/Ux+gcj2Ru9L
	 o6wKGAK0xizCCghyPU65UGAd2dDW0QwaZWtPbanB3Y1nbWrw3uBbh6sY2IxWlcxgJ5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a17/D36g";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EB7606A322;
	Sat, 24 Oct 2026 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a17/D36g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFF21F01825;
	Sat, 24 Oct 2026 16:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859202;
	bh=NzwxAfdW/i7OFOnTa+V9Z3EY89HcCRwjTnYJtteeI/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a17/D36gZKHKMUaIAazc6VU5kHeLTJwN+t9aHUi9MWpv42pVfrzRPXGYH6G4CLqoE
	 /YLAiIFwnZS6GRxvhEeCAgTXzqxmOJDVoIQx+xTCDAAtrpqkjzhnMS5X437lPvdR07
	 p5gxyK18UsvDIyOvOxD0VUBq1/cu6UkyxYD2AcsU0VNPFKPG2QpUcZLNcRKR1Icf4k
	 XnNNneYn1R6I6qLVblSsDMEKNr3WL6S8QWXhB9eJxVxIBc1niNcUi37bxwR108V1aD
	 0YXXgKic9Z2al+Gbr5qA0s3PBl6yG37E8fyxtY6HQ54L+PjFwhopsHXwYovu2RRtD+
	 1InH2k+3vMFkA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 08/10] tracing/filters: Reject unsupported field sizes in parse_pred()
Date: Sun, 25 Oct 2026 01:26:38 +0900
Message-ID: <179285919830.466249.18083674557666121987.stgit@devnote2>
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
index e734d8664444..89f4e119628f 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1995,6 +1995,10 @@ static int parse_pred(const char *str, void *data,
 				break;
 			}
 		}
+		if (pred->fn_num == FILTER_PRED_FN_NOP) {
+			parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
+			goto err_free;
+		}
 
 	/* This is either a string, or an integer */
 	} else if (str[i] == '\'' || str[i] == '"') {
@@ -2140,6 +2144,10 @@ static int parse_pred(const char *str, void *data,
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

