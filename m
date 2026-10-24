Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859138;
	b=3juwrIOfHuJ0lua3EYi/xRtv5emRKHXiebKTqSz+gT+SBkxtkfChx9o5ht5AubGxXljH
	 mK9QUhogBJUND7oqy8Z371aOpvzwIdhFgmONzefx1SK0mQaaqtSnjVhr4iZEWQDhJnCTN
	 vgnp/2m+J7w2rJ1qO9NWEaa0ug6dIzzYozKbjrAScWHLibMcqhmfsGyYvNvHMQzuOt+lq
	 g3mvScKJl6thRypOrsnnmYbbqKvXz++8d1jpfnOq2ev05xH/tQ6R7lnEIqVQb03x20P3S
	 +C6LowvE8rf2C8aeiFvEQfCB0eiuh4k499Dt/9m47tiBVSPPqfFJINmULM7kki5kIAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859138;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=b1zo6Tke0W4D3cqOhBnOl0B3urwoXtxoWUxyN83ZYO0=;
	b=VOWDjLIZoSKU/R1SIisVWVpOrMw86mIfdNGqHDDk4eDwQeS3kSjzshMgL2k6zD5tBB+7
	 O3K69pMiCTAADlKvdo7tvPIC34ZCsssMzaEaaSceIWA3kjPwJ5sDFMpHqUo4GMoZjDahX
	 7lKwNm8QXAOXPXSlKMG42VaipIeQdeadbc3UGxcD9yCxq0NZfNxv3CAW0z1GTq+UL2W8T
	 ZUR5DAc0pr62bR1rDIBSsmgGHVAKAqSKz1nDpwkdCuW7oVIm11crlz2KWbPm/O2byv02k
	 PKAHIj5g6LOeOkyjnAhTOF68NrzY9tLgQOjy5AUwGFuuacGoDrQu+uj4fk9pYzH4uvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRdtLukb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA62C606A323;
	Sat, 24 Oct 2026 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRdtLukb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972AF1F031E2;
	Sat, 24 Oct 2026 16:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859137;
	bh=b1zo6Tke0W4D3cqOhBnOl0B3urwoXtxoWUxyN83ZYO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NRdtLukbE74jRSaFFbXpgVyZCQJTQ2+mxUmxriDxyKAob9Mrw6AMZMa83iP9/Ny1L
	 Ch0vcxO/Gm7fmnj0FXkuYyISUuVAe6WKh0E3S4/9Jj+BkWBZA2zP1gDO+A7ZeeV9co
	 jb8ttEfFuNWkc5tmivekLHvPJsiqeiT52K3EG/n9bFJ3aOj87EkOFGDCNOLZdmUAkE
	 +5dFD3v5YXvzMqvecTcFSZMVc/zAI+8wy727Zcfg1MQ0Nbnq458i570bjKXFLIF4tx
	 Kng7xSDLSQggYLXPIVB2bNdGjcDNMjNXSQdI6oeUQd/BIFLbf5WSKT+ZXcFxrK1GNm
	 86CKLrq5GkITg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 01/10] tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings
Date: Sun, 25 Oct 2026 01:25:33 +0900
Message-ID: <179285913336.466249.16045710288666912574.stgit@devnote2>
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

regex_match_end() calculated string length as "len - 1", assuming @len is
the string length including trailing '\0'. However, for fixed-size string
fields, filter_pred_string() passes field->size as @len, and for "comm",
filter_pred_comm() passes TASK_COMM_LEN as @len.

Because @len in these cases represents the buffer capacity rather than the
actual length of the string, regex_match_end() tests against the tail of
the buffer (typically trailing '\0' padding) rather than the end of the
string. Furthermore, if @len is 0 (denoting a dynamic string ending with
'\0'), "len - 1" underflows to -1 and never matches.

Compute the actual string length using strnlen(str, len) when @len is
non-zero, and strlen(str) when @len is zero.

Fixes: a3291c14ecf0 ("tracing/filters: Fix MATCH_END_ONLY filter matching")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_filter.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 5e74d2dae40a..18ce3ec00d34 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1075,10 +1075,10 @@ static int regex_match_middle(char *str, struct regex *r, int len)
 
 static int regex_match_end(char *str, struct regex *r, int len)
 {
-	int strlen = len - 1;
+	int slen = len ? strnlen(str, len) : strlen(str);
 
-	if (strlen >= r->len &&
-	    memcmp(str + strlen - r->len, r->pattern, r->len) == 0)
+	if (slen >= r->len &&
+	    memcmp(str + slen - r->len, r->pattern, r->len) == 0)
 		return 1;
 	return 0;
 }

