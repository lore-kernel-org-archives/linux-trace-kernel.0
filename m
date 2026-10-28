Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148219;
	b=DLE19Gz2nzrHQfA7dwChojnOLqcrZpo+xBZDCD1akiz6GfM+kef6zpeFt4wORvhCxuHg
	 bVvnWpvPY52ZZ0O5Ei7wk/efVShh1XgAQMPrEllDixD7Uc062HFiWbsCZSOQilN1jGY6C
	 17gH4qXx6U43MXDf3aJmsUdBlT3VMgJ65F+c5p8YNACwh/Dok7OqU/8nIB02aiZNG4V1p
	 UiSUHt+JZymqqJIbB+ORqbK3Q3rMcz7RdSFDJ7wXU8vSE0TJLN5u+Xz7rRTz5K0ak1d29
	 9sh0zsSoYnZ6dazfGc2FPMF4WtJ+efjrGI0VD5MDDxp1FmYb0Emw+wyf8CtlHjSf4QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148219;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AiC08d3m816gIHqKU7HJRxn9Il7ydcrjohKw2hy3myQ=;
	b=TwE/pPbLmuwYayzxdMT5rpUwStRC+dT19lbnDCJgOQagAK15uXztQRv17s3ZPqsDVRSH
	 8wBsUwG3dyE8phdFTa2rYgO1MtPW1HPWZ1lqfS2gQad0h/y0YTvr84HcLrD+0ONo0ErRR
	 dnOAReofacbrkbup4zxPY43yIonxYbI47jz+YhEz3chlpey4dM6DZv3Ohm7PpWLCf0tuw
	 SoTLqJk8H6pHCxQDu/OWjKAkrrVp4ACIh6AIfqTxtIVOmIFXme0eqbYF5zF6wM2lrFCYS
	 ZlX2RJ/poksE9JgxJjsSYNLbC+oVAPqlnvVJOKbXe50Mnwq8xTUv2eZhjzPaE9qtiXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvJj9jEI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78EB606A31A;
	Wed, 28 Oct 2026 00:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvJj9jEI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29261F01828;
	Wed, 28 Oct 2026 00:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148218;
	bh=AiC08d3m816gIHqKU7HJRxn9Il7ydcrjohKw2hy3myQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hvJj9jEI5ZfvRFffEVRr4kUibHKRBWMuE5fvNmqDHzfMOxdt77opramnKvgxQYbiN
	 kC3m4MetCud2Wer1v0KsD/ecbqbPZcXbphQAVeRU6EHcK/kkRP03QdASioKxVPYnmV
	 FWy+iSwH/ryGCCYDGpBvFrmPwNMlvSYxiFgBepNi58txIva4jUHY3m/5ZAF6VhAAum
	 NEJOeicWDyg261KzBB9UYl6DDv4NgY5TVtPxIlEJz4G4EGYzjkHdHEHBELmZDL2q/t
	 SeuA8uoSq/W91KNMHkQvSxhhYaG7RdMJ9M5Khbp9grGwCPU46OM5LNNOdoIEvz7uoE
	 AssSQbROhF8jg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 01/16] tracing/filters: Fix regex_match_end() for zero-length strings
Date: Wed, 28 Oct 2026 09:43:34 +0900
Message-ID: <179314821463.684037.6329696159956371930.stgit@devnote2>
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

regex_match_end() calculates string length as "len - 1", assuming @len
is the string length including trailing '\0'. However, if @len is 0
(denoting an empty dynamic array where the size of @str is 0), "len - 1"
underflows to -1.

Furthermore, if the string length @len is less than or equal to the
pattern length r->len, the string contains fewer characters than the
pattern and cannot match.

Add a check for "len <= r->len" to safely return 0 without accessing
@str when @len is 0 or smaller than the pattern.

Fixes: a3291c14ecf0 ("tracing/filters: Fix MATCH_END_ONLY filter matching")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Split zero-length string out-of-bounds fix from fixed-size string
   matching.
 - Return 0 immediately if "len <= r->len" without scanning the string.
Changes in v2:
 - Check "len < r->len" to guard against negative lengths and avoid
   calling strnlen() when the buffer capacity is smaller than pattern.
 - Use strnlen(str, len) directly instead of calling strlen(str) when
   len is 0, avoiding an out-of-bounds read on 0-length dynamic arrays.
---
 kernel/trace/trace_events_filter.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 5e74d2dae40a..59a0d3ba7274 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1075,8 +1075,12 @@ static int regex_match_middle(char *str, struct regex *r, int len)
 
 static int regex_match_end(char *str, struct regex *r, int len)
 {
-	int strlen = len - 1;
+	int strlen;
 
+	if (len <= r->len)
+		return 0;
+
+	strlen = len - 1;
 	if (strlen >= r->len &&
 	    memcmp(str + strlen - r->len, r->pattern, r->len) == 0)
 		return 1;

