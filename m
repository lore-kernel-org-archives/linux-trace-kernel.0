Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237923;
	b=iaxiQI2idYvU7+taLQiiIQOGyq9QCcDY0KaaxPpEp4jXAfl98UqRaXnqu0Nl3AVoFD5i
	 NoZ65wCZZ3rs+9QFFLJuXat7FrugWM/d2t+zH/v0T8BySgsp0OW3bRQ2++u39nb1j5cN6
	 0E2xCG2elQlQ3uZ8V0AHCd1nRX9h4NTayClBQNiZvlVhpszWneMOud5bl2qS9md6g3wZg
	 QV4jdbGuRfUk2TiHOgDmTy9xJeS0Wise/k0soPgRnNaU9w0kKRlO1UQcsID3Y4WK7RQmB
	 9+w9j9TmSrJaoB+n0oMNPTuk4TdpIFRNkqlklqzLc/49B9dRaAo3GNJRTyAIesiaX8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237923;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OLL862GTE4BjNDDddVpNTNr+bDBbLOLZjyFOrZndT0o=;
	b=qXsucm2VlaDvZpcaO3osHkdqjuZH0WWqxLkX0SXPOzUqrgscMopinwAkSomIyDXed+Xw
	 yjM1e7d+auBoBX32K3dlREgfLD47Po+qSf0cuh+xD1c8H4fHXnW2HYsTdYCPiOyWqEfO2
	 BnfVgbWGdMKueBN7whCFGAVFOarxYGeffdJTyM6f87AQKw02FsXu1ymiNTOrpzkAkNahp
	 758LHMVfW6QFh8z3huNZelWcSw7P/SpJuDVR/9R7G+fHoMJvGNtGLMa726NoHl5cLF6n2
	 IPa3W2qStfMIb2yOmv7/6f1Dt5+oAnC29dTFx+i+RGRe7agWOgLizBSVIFolKZ7lWtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Scys4KRj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54787606A31A;
	Thu, 29 Oct 2026 01:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Scys4KRj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AABE1F01828;
	Thu, 29 Oct 2026 01:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237923;
	bh=OLL862GTE4BjNDDddVpNTNr+bDBbLOLZjyFOrZndT0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Scys4KRjN86WUrFFTRi+enm5L/l8fPq9jptsvIvQau3nc823AaN3UMNGxRwNUWCam
	 w0zjeR/ZjlLgzHDMj4Rl2C2KTpSGpmzk82CR0iHncieRO105y7Z0nq8qGYrk8KH7We
	 ZArDVhmE5jv4SBvj4HtAdIpY8QCdiIwq9NTA7UJW8VFOvBYMBeHR1QI9bb+pc0oR7/
	 ytduiy/X1pexk7mLFbmZ12NQmXkah+jb0QXKyx/M1CgIF1zYPnh0Gd2w+gIP09LDrl
	 Jrr96gRZNTUDuZYDQGar2vyJEZzpPYlq9T/4Rme5BNxSWV7VObeTxqfNlnfv0DDJr0
	 VU3w+l9yp27Rw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 08/15] tracing/filters: Reject unsupported field sizes in parse_pred()
Date: Thu, 29 Oct 2026 10:38:39 +0900
Message-ID: <179323791927.740114.2174706496595446472.stgit@devnote2>
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
index a645af9eb1f8..40efcef94e02 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2013,6 +2013,10 @@ static int parse_pred(const char *str, void *data,
 				break;
 			}
 		}
+		if (pred->fn_num == FILTER_PRED_FN_NOP) {
+			parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
+			goto err_free;
+		}
 
 	/* This is either a string, or an integer */
 	} else if (str[i] == '\'' || str[i] == '"') {
@@ -2166,6 +2170,10 @@ static int parse_pred(const char *str, void *data,
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

