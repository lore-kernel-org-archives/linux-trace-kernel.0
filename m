Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148339;
	b=f9F5uzy3vCGORDnFm1lbMw4jCebRgzZVCUmdA51BPkArNVVKtZvuxc3RnNlRUIN5Zu4K
	 5RNhKJPTrLTcYmsdqzJqDRz9M1M3o9PjAzqPggC3jJzDHAgRYPjWFwpvD9b9w8g+icyp9
	 BfBBC9Ao5IBopmj8jjutj1qyv4AVSxeyDkoZblCISUBWT/oXgK3d8wLbaL9AhHFxVAZPA
	 HmnS8bajZVv28opLb1twCuAAKeOmpLS25dnycj+MsOXbXf0wayj3izzGZHrhIhsw8xGdM
	 BAh3sSdTy2xRbKSkSbVaSZoY+AZI0M8CsvVJN0Q3M2uqf3wU7KrYPJiVruKOja/28kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148339;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Zikjmxn4blupE0+aVq/9mgn+mL2GyrCryi1Ub9ulwQc=;
	b=FFO5MufPu/T+YU+h9ZCBh+3wQ8+KHIrYfroYXzL8Rh0geqpalpBfHtqX9q8mJwPOuvxP
	 nvFk4GsrBdcaxtF9snXUc9DnK74glwLp3gBz2bCjJObJwAEmflgmJrjUQbIUxR2EHZDLe
	 19vtsXuheioZHClRtZVObvgR4nf0mcqUR3EZigv9ERqpGGH3K0+XZV3ljyItx+sFDTqI+
	 DR9vvWqPlhK88hR4WdUkLh8mDf10ONtcrnj3pRpovazEb1KyiV+s4Z/+vG3rK9n8gZxKQ
	 nfOvu1C6gSTgecKwAVtSTeJChdOtQ7ggT7v3n8gMBHDcgFzxJ5FLmtFUbagTkoLuE2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYYpPTF4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1029606A31D;
	Wed, 28 Oct 2026 00:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYYpPTF4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69BD1F01825;
	Wed, 28 Oct 2026 00:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148338;
	bh=Zikjmxn4blupE0+aVq/9mgn+mL2GyrCryi1Ub9ulwQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WYYpPTF4yChdo+9mswIHuw8bUIX1wVce7VmNfmwRtYdIU6O8ekDSWO/qH/OD7TzEn
	 rLbQQGqCkmBhGjKb71sM5J9w3Dw7X+++ZnKMBGq21B+cCB00BnVA261pW2AZrSJqYd
	 Aanz4shm4XGsn3hOYLofp7iL7CQjn31X3yG4yKMuHMJte6p9MN4kphU89r2IBCknYD
	 w3mRKEEQWNH4GKj3tIpwX1/Yr7h4Nsue0DGBvl0JFCzoIMuNaReGQABGARYqCBAlZL
	 5Lewg2bv3iqlhwWalO2fSk+IpP9GoxRy/bIfrjMfZqVZQ+dvM9sHFXidcjj/4G+ewi
	 yCsrk+Cjxg3uQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 14/16] tracing/filters: Fix error positions for CPUS mask parsing
Date: Wed, 28 Oct 2026 09:45:34 +0900
Message-ID: <179314833461.684037.17086962324116116493.stgit@devnote2>
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

In parse_pred(), CPUS mask error paths report incorrect error positions:
- Checking 'str[i++] != '\'{'\'' post-increments 'i' before calling
  parse_error(), shifting the error caret one character past the
  missing brace position.
- In the CPUS operator check and comparison function selection check,
  'pos + i' points to the CPUS operand or past it instead of the
  unsupported operator.

Check 'str[i] != '\'{'\'' before incrementing 'i', and pass 'pos + op_pos'
for the operator checks so the error caret points accurately.

Fixes: 39f7c41c908b ("tracing/filters: Enable filtering a cpumask field by another cpumask")
Fixes: 3cbec9d7b93d ("tracing/filters: Enable filtering a scalar field by a cpumask")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Group error position fixes for CPUS mask parsing into a single patch
   targeting commit 39f7c41c908b and commit 3cbec9d7b93d.
---
 kernel/trace/trace_events_filter.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index b1b4f1a57dc9..291c9805e119 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1926,16 +1926,17 @@ static int parse_pred(const char *str, void *data,
 		case OP_BAND:
 			break;
 		default:
-			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + op_pos);
 			goto err_free;
 		}
 
 		/* Skip CPUS */
 		i += 4;
-		if (str[i++] != '{') {
+		if (str[i] != '{') {
 			parse_error(pe, FILT_ERR_MISSING_BRACE_OPEN, pos + i);
 			goto err_free;
 		}
+		i++;
 		maskstart = i;
 
 		/* Walk the cpulist until closing } */
@@ -2023,7 +2024,7 @@ static int parse_pred(const char *str, void *data,
 			}
 		}
 		if (pred->fn_num == FILTER_PRED_FN_NOP) {
-			parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
+			parse_error(pe, FILT_ERR_INVALID_OP, pos + op_pos);
 			goto err_free;
 		}
 

