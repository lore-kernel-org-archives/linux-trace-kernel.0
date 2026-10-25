Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792917443;
	b=H2nNQ4O3LVUQzdEoTwH3FrR3cAiltGAapm3BlY0DN9O4Q6nJ/330X70EzFI8dip8DCAZ
	 01D/JUcZGl8cjnQ+ctlF3fOcYfbS08fx6z9Y9agBtlFPyYjABwTmnoBp2memw/larTl7F
	 1EcNjvs9hOmOthWk/1Uhg0aTJQWUot3/0dR+1V4XEMAZJSQXfcZFiXgixY1kWOqDvy1nf
	 PnMN+yreK/wi+y9CzNGkBOJ4vLSnLGHZFSO+s9KGRhmLIBVv/M8cMoT7qxmZ+7Q8e+xuJ
	 G1IWM7brDoPTPrnOjHMdO1pkcvoI3XxVtHpoLWVFrzucwIgHhU3qjxYSZuVvDEOcMng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792917443;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=B3hLjQcszDnYcry0Oa5yE1ZzuZf9IVuvgfRk4cyy8MU=;
	b=B9qhXz+C/6e31Sk4zWCAwCsD/cgFzUp4xh2DBlh9Jbfb3+M7G49U5eZ/uFwm2oXzTjJ2
	 dNc7j3PtIteYPJoe/lpcimVWk4yOYxmcmhrPU95IRqtihdVgH5/1qEy1YRaP91+fkGtuK
	 +fZI3y9mC2NU4E4LqkQ4HTNkWOYm85+6Q95yCXpuJubFQSNSjYuSbho7oLEj2L+pSF4rQ
	 uu01wgpPlFMlRXs1fJIEVuJJfiEzoXqGsgHuYODtMyQDhNzzJQSjXEodqIDHT7bpIcXwq
	 MIEaGEQWs9laMNCl7eesMnR0dW6TarYZOYCjLwYtSmfINbOvR9X5zR5Ukk+Ad5OJuPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hekazTaY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D09606A31A;
	Sun, 25 Oct 2026 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hekazTaY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932B91F01825;
	Sun, 25 Oct 2026 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792917443;
	bh=B3hLjQcszDnYcry0Oa5yE1ZzuZf9IVuvgfRk4cyy8MU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hekazTaYqdOzBhfLhrms86mt4TLz4vdMBm+lKSx3lAUPjli+k102oQdaTUbMpdCH6
	 uS2dBecFAf93/9Bf93csWbfJ9eOC+F0xVx2zTDAmtKxbNIYKn/Fcuiootf2BsK14b+
	 l33kPDHa3Qselp4nEr8pM0iM7TxnwKS7X8X/I55J4yddT82AO0wZrhkH92feqlxhGk
	 8Zk1y3t4p2YMx02XgnoZarwEgMyNfQtv1OMBTs4g8rZ86zyN466DTj/JLjxXbH9eC4
	 QWmWgPhNwAuuVjqOZoYqoAAFFVItG9kyQYXyJvjeVR5/9Jo0qMTybRH1hE90Q3lgRE
	 fQKEahreIrxXg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/9] tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings
Date: Sun, 25 Oct 2026 17:37:19 +0900
Message-ID: <179291743946.492959.9624495647021680807.stgit@devnote2>
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

regex_match_end() calculated string length as "len - 1", assuming @len is
the string length including trailing '\0'. However, for fixed-size string
fields, filter_pred_string() passes field->size as @len, and for "comm",
filter_pred_comm() passes TASK_COMM_LEN as @len.

Because @len in these cases represents the buffer capacity rather than the
actual length of the string, regex_match_end() tests against the tail of
the buffer (typically trailing '\0' padding) rather than the end of the
string. Furthermore, if @len is 0 (denoting an empty dynamic array without
trailing '\0'), "len - 1" underflows to -1.

First check "len < r->len" and return 0, which safely rejects negative
lengths and cases where the buffer capacity is smaller than the pattern.
Then compute the actual string length using strnlen(str, len), which
bounds the scan by @len (stopping at the first '\0') without dereferencing
past the buffer.

Fixes: a3291c14ecf0 ("tracing/filters: Fix MATCH_END_ONLY filter matching")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
 - Check "len < r->len" to guard against negative lengths and avoid
   calling strnlen() when the buffer capacity is smaller than the pattern.
 - Use strnlen(str, len) directly instead of calling strlen(str) when
   len is 0, avoiding an out-of-bounds read on 0-length dynamic arrays.
---
 kernel/trace/trace_events_filter.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 5e74d2dae40a..fac51a2953dd 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1075,10 +1075,14 @@ static int regex_match_middle(char *str, struct regex *r, int len)
 
 static int regex_match_end(char *str, struct regex *r, int len)
 {
-	int strlen = len - 1;
+	int slen;
 
-	if (strlen >= r->len &&
-	    memcmp(str + strlen - r->len, r->pattern, r->len) == 0)
+	if (len < r->len)
+		return 0;
+
+	slen = strnlen(str, len);
+	if (slen >= r->len &&
+	    memcmp(str + slen - r->len, r->pattern, r->len) == 0)
 		return 1;
 	return 0;
 }

