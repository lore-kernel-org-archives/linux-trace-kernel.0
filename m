Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792917498;
	b=Nfq6Ve8KF01+iNqQ73bWdmFxqoyDPu+VwyNjPt9qTBdKZHH284aHq7j3YkpYpNcO1cBz
	 1rqRNTqeJ1tAA5oPib57eutJ6QrIARl0qrLB1qeQJypRyg9cP12iEPpyENx/pMRlWiHJE
	 gGAHAHOz63dwsqj7LEPlXiYaPCen1zciU5IbZ7rp8uV69WiFd3jsncPurA2RaePkMO1il
	 O5CxVJhvCW04lUSGFhaSTuOhVn+7P4dQtdXfmcdSbGTB7YhnCMMHuW15TnrQ0ay1E+aN+
	 2xNzJHofYgX8FQA8aLYUUQjHKSWb2f3USGnhBMaQh4v32bkp2Px4qXIYReSz79KwPOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792917498;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LyIu8LpFbOKXmQM6qbVFVK3ifzbZIok7wU2+3iYtelg=;
	b=rfPCsAJPuD4HkgywDWRw2ODIVif9qnmEIz8HPQcm0B7Te5XkFYP/Uk5lI3wa11hv/F/A
	 Y9tgkww0PYfElSNB1kaeGL5E6g6D4fvWeg0BIVDr9oJieOb3hC74qXiB2Hu6ZZW9OvjNI
	 wm58wCG45vUPQGv9YlYnx+WDcIUM4aT17K71O41vg+d+BhVLHHM4EqjsgiQySMbRCj5N7
	 NebiHOiow2Ul53dLBAn/5JDenluWErvE4yM76AFAmHqr6c0czElkULD9qmdRSfoI1jS75
	 wa7L/16VSPkxY4b3/SufsXCASCwp79JHhv8eHcE+QKJ+cH7xrBAQmtJjMeHbhOSNCzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8oONPxt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E2D606A338;
	Sun, 25 Oct 2026 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8oONPxt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3B21F01825;
	Sun, 25 Oct 2026 08:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792917497;
	bh=LyIu8LpFbOKXmQM6qbVFVK3ifzbZIok7wU2+3iYtelg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R8oONPxtaYwe7Sr1NLJp/sJgqPotW/TxujTic775D5+LXyjddBNUUtJee7qUGoQr8
	 z1Cke9otckJEVkcxBlxmKbEe/z557zZ8aVSmYf42VOjQKmCbtgnfYkmAkIpw6igjIm
	 x54VAumG7lXWGuYBzgyFsxK7sp4NqJz10FHBlODAoUnJVrdmyIUOPdaZy7duSFQ2RF
	 ZmqXOF/8T8suAzon/jb+Pk0QL4IAIoq+k9Vg8lXYDnyyzXXBB/f0rPq0l0UNdn4I6o
	 c/JIO4cRI1weQf9khiWIXIo4kvffum+/Pw2AVQjadgXL92EHWOan0NEMyOljyRHN31
	 ENjtnGhGfmtbQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 7/9] tracing/filters: Reject unsupported field sizes in parse_pred()
Date: Sun, 25 Oct 2026 17:38:14 +0900
Message-ID: <179291749413.492959.3609855860716668314.stgit@devnote2>
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
index bcd37fd6c109..8d7fb6e9d7f8 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1996,6 +1996,10 @@ static int parse_pred(const char *str, void *data,
 				break;
 			}
 		}
+		if (pred->fn_num == FILTER_PRED_FN_NOP) {
+			parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
+			goto err_free;
+		}
 
 	/* This is either a string, or an integer */
 	} else if (str[i] == '\'' || str[i] == '"') {
@@ -2141,6 +2145,10 @@ static int parse_pred(const char *str, void *data,
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

