Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148228;
	b=JtG9YfW78LkruiVrRie13c7Le7h6BTECksEQDRXu+S3SSq+WRf6RkrIVdfUpmnCPUGrx
	 0S4sFKw/WSPwzKAoYDUQWuS+UMgYZyWlLuWbyMZRhYjoIspgxvQPAx9hqjxBNEQOnWumt
	 uI6napM1/B1R9g+7ORo/q69+r5Ky5keQbRc1l85mguQ45k/fBAnrD44ryym3KlxrPYbBO
	 eU6EnFC/wsnl8l8tyl79CUWtCGrg6hD0w7Mk62IgDmizlYzmvWt09u2z8XkyoCOBVnKKU
	 /SU3euBVwDF1SP3FRKOk4ii9AgDdQfl7IpDFPPfpTO/8se/mQvrOxnQKeUy1LGz4Evg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148228;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qkXvnQeDr3o2Osn+PFE7gXCH6PjN120/QyJlXvXFSPE=;
	b=JWuLpccVgswzG8VIGUqNHTt27k6OCyLnJoguRFj+j8id5MdKnBE90+6xgcjx99iHdac9
	 PFWWHh3lvM6V0sp9fv/vyacHwxaA+mKfgpNa615CR+Frky3YyIMv9pxR8Ce/JM1lGfqVj
	 nueCmkSAJIpYDZQe73a+MA8N1zhqoBk1vs8e4sy6Xa2+92QdBRyGMp7z9kTZimF7XQpo6
	 rfKk/LVb8GnJldtg5ic76YwoOORcc4Ep3PZbrv+31BakHthxaumpstEiz1M/5vt3qm77i
	 sRKbVUpevD1diTAiKXcuHlU53fP4VlkdVGi12n/a24+RQtPA6NL6IeSLy/ZsUIsV07A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oc63TZ5z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23A606A31A;
	Wed, 28 Oct 2026 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oc63TZ5z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63281F01828;
	Wed, 28 Oct 2026 00:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148227;
	bh=qkXvnQeDr3o2Osn+PFE7gXCH6PjN120/QyJlXvXFSPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oc63TZ5zKUkPYoRonvAl6yg6YuTeLMl6AZdpDccZW9XPb+IoVMFpPONDjGkBauC0t
	 Lmnc1T6OxrWLt4HCO5EE50AX28/gRYbHA7oUatVmYTt7QuRxoSqoDn5wyjaDb5WaAH
	 CtdEA70/Y6Nz9uLqZXGbSQ3khnbqfDRV6GYhN3uobFYCA7LvJnDeXmTre19Do4dGLV
	 997KoL5D0CZddMv0M/y8EfekM3F+aaopDo3YvcGVQXHC2sV1uStNeJmaKNRvEYDYXc
	 go94LUb+YLuR+OhFaHjZZLhN5p+l8cI1QWGNWrGat7ICHeIhC7iiHXEshDSDTLkpDF
	 qc5qo7H3d2z/A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 02/16] tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings
Date: Wed, 28 Oct 2026 09:43:43 +0900
Message-ID: <179314822364.684037.9099512445135198750.stgit@devnote2>
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
is the string length including trailing '\0'. For dynamic strings
(filter_pred_strloc) and pointer strings (filter_pchar), this assumption
holds and allows O(1) constant-time suffix matching.

However, for fixed-size string fields (FILTER_STATIC_STRING) and "comm"
(FILTER_COMM), the callers pass the buffer capacity rather than the
actual string length (field->size for filter_pred_string, and
TASK_COMM_LEN for filter_pred_comm). Because these buffers hold
null-terminated strings (e.g. prev_comm in sched_switch holding "bash"
in a 16-byte buffer), regex_match_end() tests against the tail of the
buffer capacity (typically trailing '\0' padding at offset 13) rather
than the actual string end. Consequently, suffix matching like
comm ~ "*sh" or prev_comm ~ "*sh" fails for all strings shorter than
the buffer capacity.

To fix this without penalizing dynamic and pointer strings with an
unnecessary strnlen() scan on every event, introduce a dedicated match
function regex_match_end_str() for fixed-size buffers that uses
strnlen(str, len) to locate the string end within the buffer capacity.
In parse_pred(), assign regex_match_end_str to pred->regex->match for
FILTER_COMM and FILTER_STATIC_STRING fields when MATCH_END_ONLY is
requested.

Fixes: a3291c14ecf0 ("tracing/filters: Fix MATCH_END_ONLY filter matching")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Split from zero-length string fix into a dedicated patch.
 - Introduce regex_match_end_str() for fixed-size buffers and assign
   it in parse_pred() for FILTER_COMM and FILTER_STATIC_STRING, avoiding
   strnlen() overhead for dynamic and pointer strings in regex_match_end().
---
 kernel/trace/trace_events_filter.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 59a0d3ba7274..f7c067a58ba4 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1087,6 +1087,20 @@ static int regex_match_end(char *str, struct regex *r, int len)
 	return 0;
 }
 
+static int regex_match_end_str(char *str, struct regex *r, int len)
+{
+	int slen;
+
+	if (len < r->len)
+		return 0;
+
+	slen = strnlen(str, len);
+	if (slen >= r->len &&
+	    memcmp(str + slen - r->len, r->pattern, r->len) == 0)
+		return 1;
+	return 0;
+}
+
 static int regex_match_glob(char *str, struct regex *r, int len)
 {
 	return glob_match_len(r->pattern, str, len) ? 1 : 0;
@@ -2026,10 +2040,14 @@ static int parse_pred(const char *str, void *data,
 
 		if (field->filter_type == FILTER_COMM) {
 			pred->fn_num = FILTER_PRED_FN_COMM;
+			if (pred->regex->match == regex_match_end)
+				pred->regex->match = regex_match_end_str;
 
 		} else if (field->filter_type == FILTER_STATIC_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRING;
 			pred->regex->field_len = field->size;
+			if (pred->regex->match == regex_match_end)
+				pred->regex->match = regex_match_end_str;
 
 		} else if (field->filter_type == FILTER_DYN_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRLOC;

