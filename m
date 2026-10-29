Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237896;
	b=YiOhNrFuifnXkGXM3FEyomVDqFuyNd6nwUWLzyWambtiMot3RAGs2gmU5TTbKpp1xN/v
	 VqyV58FYGX/+XxLOp08E9QyGGi63B20AA46rAZX4RpF1fZ5NLuJdCu+fmbxIuJpjQmEtR
	 ckOlgZyZVKYi/tRjsvQdgznRt99pNh+r7gSfWDI+fDRt5iXNHQruWabE5/dS5xYo/BBeK
	 H3h1w75Hb+01PsnUSdVAvavhj0Ssm6A0F4aZxyAt0NDcKsphF4ZFUbnMGhpKp2l24SCxB
	 MclWb6hpzWovJSIheEny4+hZUKunfR9xa0aX0QwHmrqw7BDX9DrU8O/WiNBlJOIFOkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237896;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hRhmKkCw+4uGKMkh3X9YIRZBdi4um4ip/IbrjTfTHAI=;
	b=RPLzpLpHpXBy1t+47aUy1Asz0ATR0VZ8pwGBZ51F4aR5Wj5s/n2CKtVHqX3L+JIJWV4H
	 dlRTc2E5fRDAUkdKV8ySxdYC6dy+xMaAbeEvrGnEuWrmJmTHlYSYLxOkQD8KjEoLspnbn
	 W/3KoYIC96l63pvu44bhbNPJl73CezOpFdV6kiO5AVpsnBA5eXsmZ2WohjBWdhTxaAkWO
	 XL0B428KV8lPjrozouJnka4OkCVzHUQvY2owA81syl9Dc0ZV/AOyUZxv78PtFpjSSkYa7
	 6WeoUxXfyOO7rQt17ur8RP6d9lH/uhRdafRT8qY2X6yLWvhTBU1g1paGWyS6yL2eHUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwPEJ8sw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01927606A31A;
	Thu, 29 Oct 2026 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwPEJ8sw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A8A1F01825;
	Thu, 29 Oct 2026 01:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237895;
	bh=hRhmKkCw+4uGKMkh3X9YIRZBdi4um4ip/IbrjTfTHAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dwPEJ8swgJIaiIxMk0mgoSXD/0cr0tSPJlnPw0Ke4vC2UYeUpXu7szi+areBHhVaF
	 MuCJGnScwYTv5zriEqiGusZN0xaKFs1DBvYRC/dlbr3ij4auWfbi8R2qTJJFk+B1kP
	 R5rHPFtrZOfIVc5T5wpIC72PHW7kKeB2s3CI4ShRO6XTS81PGFeaFGZq4+zcd85eHq
	 LAqr1Yq7fFLfVnwO6Xcv7rnkwBCfPYLVV6fT7Mc5IRCAz8NMMjEOsIMpqa2WXE6cI+
	 eNkbOtt8bt8kGujgaIiCCtuEkRZ0B2sY78qpHEbumywrRa537HaO1WQSstq82200TM
	 XoqsMeR1qgRag==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 05/15] tracing/filters: Check for missing operand after operator in parse_pred()
Date: Thu, 29 Oct 2026 10:38:11 +0900
Message-ID: <179323789181.740114.16161070743864669086.stgit@devnote2>
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

In parse_pred(), after matching the operator and skipping whitespace,
the filter string may terminate (str[i] == '\0') if the operand is
missing (e.g. "ip ==" or "common_pid ==").

For function events, the loop 'for (i++; str[i]; i++)' unconditionally
increments 'i' past the NUL terminator, causing an out-of-bounds read.
For other event types, allocating a predicate only to fail later during
value parsing is wasteful.

Check if 'str[i]' is NUL immediately after skipping whitespace after
the operator, and report FILT_ERR_INVALID_FILTER.

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Split from the monolithic function event parsing patch.
 - Check if str[i] is NUL immediately after skipping whitespace after
   the operator in parse_pred() across all event types, as suggested
   by Steven Rostedt.
---
 kernel/trace/trace_events_filter.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index b8d765ca9f1a..a7a89e0f9b87 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1762,6 +1762,11 @@ static int parse_pred(const char *str, void *data,
 	while (isspace(str[i]))
 		i++;
 
+	if (!str[i]) {
+		parse_error(pe, FILT_ERR_INVALID_FILTER, pos + i);
+		goto err_free;
+	}
+
 	s = i;
 
 	pred = kzalloc_obj(*pred);

