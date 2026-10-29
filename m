Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237979;
	b=oHkqU2VuR/2G5yAQW2LrX0HoyTzB5FXPXMd7E6pSSjS+hY0kHRiGU5hAYmBpZvOqzBeg
	 yNv3osLbdvZ1q+SfyVmTgi5bbut2DPsKVoIODan7911lMSi/ae3ACr6wCR+hWyEnZDmyl
	 sBctGkEdgUjehM0DF6SKzcqkyu0R9csJG+OuiiIyJH61G7lvDUZRhOM88RWZxytev4dn7
	 YZVNdq1TGJhPt4bctvnMgZxN7mETMpe7DOIbz/oPR6Qz0nxasJbUfVdHyRA76/iLrOwA3
	 NqvsJW5sNoHmgR4zTeQonfebKRtVhafl2duzIV9EplgFhV199d9Ucx96vDfYNzdSJ/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237979;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=T8b9kEgTQ/KBKDQOynSVjYHGydeX+Yb4+LNxI2dlkYg=;
	b=Xgvhgo2FZFWODh0BDDaYrnbOoTDH0yL0oTH9U3fGBnFxZNM/5yLPuqw2XLNv3IhMW98Y
	 VCdBavPkl3/YRKSOtJlh17jBzTXF9Pmcw7zJQ8Mwd8yb0tlxJgACTDqzmHzyrF4AGKqcJ
	 ulww4vks26jEPOzDG3fU+9MUYfKQJi6grPbB9gzBy45eIqdoVHIZcTeXAXXL5oDeESM0i
	 Bqdx77kcOW/mCXBY6JQrUdBW9HtWC8355xc9AIFc8zstg/Y6Pq0BaY4/VCAXAsQT58EV7
	 uFkxP33GitHvRs92GxrOC/seoGd/zTn8uchkzNabQj7pN7pSy+YCs8J/HXe2jqcWilw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="de/sAm2T";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67055606A31A;
	Thu, 29 Oct 2026 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=de/sAm2T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603701F01829;
	Thu, 29 Oct 2026 01:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237979;
	bh=T8b9kEgTQ/KBKDQOynSVjYHGydeX+Yb4+LNxI2dlkYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=de/sAm2TihN5UHjEDSXP/akiBXgySrIHnqVu4S8UgyGwwMyKff0WguHowrBqAfOs5
	 gj/NmjHCEZbZNuY+fliz6vtRVbBgwuCFe+qBf2lOX6zlfpFN/M7mF3LbuS2FkeC6kq
	 1/IJF6eBd2WPyA2u6/fQBI2GeGJJGyQmlbtDUPF32jhkg2sMUlOeKfeyiWmaKNEuwF
	 jnsgzX5eggNDuI6g8hY9drFTKJHLP6dmDpT8j4BB8utMCmQCOlS9y6upvNpoL5X8YM
	 Tbi/UQiVKquM7A9HZwEwJKQ3OJxN27VNlUu3ShjuiSVyAQwqMTdnDvxolwksW6yIy8
	 SkzHf9nVdpBzg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 14/15] tracing/filters: Fix error position for within filter operator check
Date: Thu, 29 Oct 2026 10:39:35 +0900
Message-ID: <179323797517.740114.18128311506466612662.stgit@devnote2>
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

In parse_pred(), when the '~' operator is used with a 'within' filter,
'pos + i' points to the closing quote of the operand rather than to
the unsupported '~' operator.

Pass 'pos + op_pos' so the error caret points to the invalid operator.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v4:
 - Drop Fixes and Cc: stable tags since this error position fix is a
   cleanup.
Changes in v3:
 - Newly added to fix error position for within filter operator check.
---
 kernel/trace/trace_events_filter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 1a9a1cc8daa2..1a50de4e7e8d 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2106,7 +2106,7 @@ static int parse_pred(const char *str, void *data,
 			unsigned long func;
 
 			if (op == OP_GLOB) {
-				parse_error(pe, FILT_ERR_GLOB_WITHIN, pos + i);
+				parse_error(pe, FILT_ERR_GLOB_WITHIN, pos + op_pos);
 				goto err_free;
 			}
 

