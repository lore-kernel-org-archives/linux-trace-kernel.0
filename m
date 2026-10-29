Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237887;
	b=OWYAphazvUdkA7sv42R4mA173xLT7Y9oS1uGFCJtjaI+1KMzPXDI1h3OzOvH5/f0dZi8
	 zV6/R51m4wj/ezuN6pFdLne9u0jg2ff584GxfYkiCogA4uBb8L+Mjab8V0B1wHVUChCJr
	 Eh+JUNttA7IVLEcvaCzc2YYMHJgRDB9SFw77nI60uagja+UAmxIbaN2wHeFClCw4p/+S0
	 tMZX2UMYGvW2G4/LGF1OjAL5LC/ZbWtCX6Rikzq3FdBP8OUyfBgHQzrvJwbxjgD7Z7G2c
	 G+HxTMl4TB96+XUybZ1NhTGrrpPybzcYCrA/bge3eJAXb8IC9hVbmQHzXpNecqEwsqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237887;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ubvpn8j78IfzbbYb7qgf7pvemO0PgjSo9fUA3k+J5/w=;
	b=QhR7qCigAbHCJQ9xDuE2y7IMioKfkYBIAbebhGke9eRNfTejzpAxm3BSrPth/zS94gIa
	 hUxqOTKCQqk031GkGcrHQCyIOEPLnFLm/ObyRCc8Ganx0ANmdjcv0O2AubSGAVyiDPIsC
	 DCA2zn6w772RBXilb7NTosqUaazN/GjdNBQs+UPwb7XnDv7iCiEzUBQmu/ObwA4NQTWgy
	 AIKT8Wo9nsWk+jjBw3h1joqB9K6+RvIVs2WdP4ECsULMxWWclrOdd6nlCvRw2qkszBapA
	 B7IPYBK+r/L8myymeF4YVTm5JZPNKuanYCYIr27nhjEplsu20IImGavBKdEVhwHHlog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtqYuza0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99AA606A31D;
	Thu, 29 Oct 2026 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtqYuza0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01E11F01825;
	Thu, 29 Oct 2026 01:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237886;
	bh=ubvpn8j78IfzbbYb7qgf7pvemO0PgjSo9fUA3k+J5/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mtqYuza0EV2K1RLwFEktwnd9g8HpzXokKhufS94zU9c7iQWlxnBWRiWQCGYeTaqlB
	 pKNyaBQnB8gEB/kuURW+7H9v0d6zEFXO0M2brSZEhBxRWc+hcg8cM8Tp4cFPEYCGep
	 y6gh4GC6BAIKszoWMJZhq1rlfN+lJk0gBYM+JrxOzs6h1hfKCgTFoDDSKvpANXfw9i
	 sCuBrBh3b0JOJM+DONeBsqKyheskVUZfyLblwpz7Vrr68kgU8JMoG5NY5UfIc4eXIj
	 CsEUte1ncjZ4da963hIWReHdkfBW9FAyTrHu635OpDPgJ/JxuTI6TYbbZMulntLc6E
	 m3+fhjOUQfyRQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 04/15] tracing/filters: Report parse error on all -EINVAL paths in filter parsing
Date: Thu, 29 Oct 2026 10:38:02 +0900
Message-ID: <179323788261.740114.13501865461835259995.stgit@devnote2>
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

Several error paths in filter parsing return -EINVAL (or -1) without
calling parse_error() to set pe->lasterr:

1. In parse_pred(), when an invalid token is encountered where a field name
   is expected (e.g., "common_pid == 1 || (common_pid == 2 && )"), len is 0
   and it returns -1 without calling parse_error().
2. In process_preds(), when !nr_preds (e.g., empty or whitespace-only
   filter), it returns -EINVAL before predicate_parse() can set
   FILT_ERR_NO_FILTER.
3. In predicate_parse(), when op_stack overflows or the jump target check
   fails, it returns -EINVAL without calling parse_error().

Because pe->lasterr remains 0 on these paths, append_filter_err() falls
back to printing an uninformative "Error: (0)" instead of reporting the
diagnostic and error position.

Call parse_error() with the appropriate error code on all of these paths.

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_filter.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 3f0c73819365..b8d765ca9f1a 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -515,6 +515,8 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 		switch (*next) {
 		case '(':					/* #2 */
 			if (top - op_stack > nr_parens) {
+				parse_error(pe, FILT_ERR_TOO_MANY_OPEN,
+					    next - str);
 				ret = -EINVAL;
 				goto out_free;
 			}
@@ -638,6 +640,7 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 		prog[i].when_to_branch = invert;
 		/* Make sure the program always moves forward */
 		if (WARN_ON(prog[i].target <= i)) {
+			parse_error(pe, FILT_ERR_INVALID_FILTER, 0);
 			ret = -EINVAL;
 			goto out_free;
 		}
@@ -1709,8 +1712,10 @@ static int parse_pred(const char *str, void *data,
 
 	len = i - s;
 
-	if (!len)
-		return -1;
+	if (!len) {
+		parse_error(pe, FILT_ERR_INVALID_FILTER, pos + i);
+		return -EINVAL;
+	}
 
 	field_name = kmemdup_nul(str + s, len, GFP_KERNEL);
 	if (!field_name)
@@ -2306,8 +2311,10 @@ static int process_preds(struct trace_event_call *call,
 		return ret;
 	}
 
-	if (!nr_preds)
+	if (!nr_preds) {
+		parse_error(pe, FILT_ERR_NO_FILTER, 0);
 		return -EINVAL;
+	}
 
 	prog = predicate_parse(filter_string, nr_parens, nr_preds,
 			       parse_pred, call, pe);

