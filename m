Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF953E555;
	Sat, 29 Mar 2025 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743230403; cv=none; b=rrJfD7qey/lIa7vnlsKiihkgKZVpsNtTeufJXOWncxFaZkO41bP4Jore/8ovNdPcrqlnwjVJGHQwiw2yfWUD1MXIXJ6br6+EVilUVUo2ZwTAWrV3eYzQhof6KvxFUqHbxUfWDAt5ulL/0Wt/zm/bfUAw1bHYJNjesc5whBBnk2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743230403; c=relaxed/simple;
	bh=pMpA2B5z3LG5BbQROBxhQWWTWt7Lvh3R7olBMfMQCQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cuuTSu2gg5u5s6S3SGkUeaQtc3zLeOT+I2PpQdyAyLLDEs3BOtkM2XwFz++f8OB5ocBXiLcL3AjWzJzK3ShOk1VyWufkHbDRgKTv5AHz2mFxxN0bg1BoFjVc8YT7lBaZQBpba0l2Xf3d6dT7bqo0bIqqXafZBLXAD9zqmeNgPRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZSxGPK5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZSxGPK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E17C4CEE2;
	Sat, 29 Mar 2025 06:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743230403;
	bh=pMpA2B5z3LG5BbQROBxhQWWTWt7Lvh3R7olBMfMQCQ0=;
	h=From:To:Cc:Subject:Date:From;
	b=jZSxGPK5tfnkF8/hgS47gz1M4d20E/jTHQKiInR4fDqfYJxoIT9u+Yd58d5pcleow
	 5v7juvTRl99KvVzIftqhnhHSzWaaTKM9w+aYHr4jRbu3q6t2q69KZj4o/p0QUcBzs+
	 5B17VQmFKfI/wvyeTrjvKSmYILE1KVVcWGVlFhmP4FMzzCGw/UcXuREN5GEEDxEx6a
	 BaBFq8eN1qdWrf99ISreTunvbbKvXQmVwB1QQaR8q8VkAVXV0e2cAPWJdfSaCkehy9
	 8etYyFFpuvkoo2kNGkA4zuW25/x8mtO8o5y4LvaNSWTa5MwMHBN9Xz14vg98NV11xE
	 mic5oe5jpPisQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: probe-events: Cleanup entry-arg storing code
Date: Sat, 29 Mar 2025 15:39:59 +0900
Message-ID: <174323039929.348535.4705349977127704120.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Cleanup __store_entry_arg() so that it is easier to understand.
The main complexity may come from combining the loops for finding
stored-entry-arg and max-offset and appending new entry.

This split those different loops into 3 parts, lookup the same
entry-arg, find the max offset and append new entry.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Rewrite comments to clarify what is required.
  - Do not loop on code array twice.
  - Use the last offset for the basement of the new offset.
---
 kernel/trace/trace_probe.c |  128 ++++++++++++++++++++++++--------------------
 1 file changed, 69 insertions(+), 59 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 2eeecb6c95ee..4b1df60d73ee 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -770,6 +770,36 @@ static int check_prepare_btf_string_fetch(char *typename,
 
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 
+static void store_entry_arg_at(struct fetch_insn *code, int argnum, int offset)
+{
+	code[0].op = FETCH_OP_ARG;
+	code[0].param = argnum;
+	code[1].op = FETCH_OP_ST_EDATA;
+	code[1].offset = offset;
+}
+
+static int get_entry_arg_max_offset(struct probe_entry_arg *earg)
+{
+	int i, max_offset = 0;
+
+	/*
+	 * earg->code[] array has an operation sequence which is run in
+	 * the entry handler.
+	 * The sequence stopped by FETCH_OP_END and each data stored in
+	 * the entry data buffer by FETCH_OP_ST_EDATA. The FETCH_OP_ST_EDATA
+	 * stores the data at the data buffer + its offset, and all data are
+	 * "unsigned long" size. The offset must be increased when a data is
+	 * stored. Thus we need to find the last FETCH_OP_ST_EDATA in the
+	 * code array.
+	 */
+	for (i = 0; i < earg->size - 1 && earg->code[i].op != FETCH_OP_END; i++) {
+		if (earg->code[i].op == FETCH_OP_ST_EDATA)
+			if (earg->code[i].offset > max_offset)
+				max_offset = earg->code[i].offset;
+	}
+	return max_offset;
+}
+
 /*
  * Add the entry code to store the 'argnum'th parameter and return the offset
  * in the entry data buffer where the data will be stored.
@@ -777,8 +807,7 @@ static int check_prepare_btf_string_fetch(char *typename,
 static int __store_entry_arg(struct trace_probe *tp, int argnum)
 {
 	struct probe_entry_arg *earg = tp->entry_arg;
-	bool match = false;
-	int i, offset;
+	int i, offset, last_offset = 0;
 
 	if (!earg) {
 		earg = kzalloc(sizeof(*tp->entry_arg), GFP_KERNEL);
@@ -795,78 +824,59 @@ static int __store_entry_arg(struct trace_probe *tp, int argnum)
 		for (i = 0; i < earg->size; i++)
 			earg->code[i].op = FETCH_OP_END;
 		tp->entry_arg = earg;
+		store_entry_arg_at(earg->code, argnum, 0);
+		return 0;
 	}
 
 	/*
-	 * The entry code array is repeating the pair of
-	 * [FETCH_OP_ARG(argnum)][FETCH_OP_ST_EDATA(offset of entry data buffer)]
-	 * and the rest of entries are filled with [FETCH_OP_END].
+	 * NOTE: if anyone change the following rule, please rewrite this.
+	 * The entry code array is filled with the pair of
+	 *
+	 * [FETCH_OP_ARG(argnum)]
+	 * [FETCH_OP_ST_EDATA(offset of entry data buffer)]
 	 *
-	 * To reduce the redundant function parameter fetching, we scan the entry
-	 * code array to find the FETCH_OP_ARG which already fetches the 'argnum'
-	 * parameter. If it doesn't match, update 'offset' to find the last
-	 * offset.
-	 * If we find the FETCH_OP_END without matching FETCH_OP_ARG entry, we
-	 * will save the entry with FETCH_OP_ARG and FETCH_OP_ST_EDATA, and
-	 * return data offset so that caller can find the data offset in the entry
-	 * data buffer.
+	 * and the rest of entries are filled with [FETCH_OP_END].
+	 * The offset should be incremented, thus the last pair should
+	 * have the largest offset.
 	 */
-	offset = 0;
-	for (i = 0; i < earg->size - 1; i++) {
-		switch (earg->code[i].op) {
-		case FETCH_OP_END:
-			earg->code[i].op = FETCH_OP_ARG;
-			earg->code[i].param = argnum;
-			earg->code[i + 1].op = FETCH_OP_ST_EDATA;
-			earg->code[i + 1].offset = offset;
-			return offset;
-		case FETCH_OP_ARG:
-			match = (earg->code[i].param == argnum);
-			break;
-		case FETCH_OP_ST_EDATA:
-			offset = earg->code[i].offset;
-			if (match)
-				return offset;
-			offset += sizeof(unsigned long);
-			break;
-		default:
-			break;
-		}
+
+	/* Search the offset for the sprcified argnum. */
+	for (i = 0; i < earg->size - 1 && earg->code[i].op != FETCH_OP_END; i += 2) {
+		if (WARN_ON_ONCE(earg->code[i].op != FETCH_OP_ARG))
+			return -EINVAL;
+
+		if (earg->code[i].param != argnum)
+			continue;
+
+		if (WARN_ON_ONCE(earg->code[i + 1].op != FETCH_OP_ST_EDATA))
+			return -EINVAL;
+
+		return earg->code[i + 1].offset;
 	}
-	return -ENOSPC;
+	/* Not found, append new entry if possible. */
+	if (i >= earg->size - 1)
+		return -ENOSPC;
+
+	/* The last entry must have the largest offset. */
+	if (i != 0) {
+		if (WARN_ON_ONCE(earg->code[i - 1].op != FETCH_OP_ST_EDATA))
+			return -EINVAL;
+		last_offset = earg->code[i - 1].offset;
+	}
+
+	offset = last_offset + sizeof(unsigned long);
+	store_entry_arg_at(&earg->code[i], argnum, offset);
+	return offset;
 }
 
 int traceprobe_get_entry_data_size(struct trace_probe *tp)
 {
 	struct probe_entry_arg *earg = tp->entry_arg;
-	int i, size = 0;
 
 	if (!earg)
 		return 0;
 
-	/*
-	 * earg->code[] array has an operation sequence which is run in
-	 * the entry handler.
-	 * The sequence stopped by FETCH_OP_END and each data stored in
-	 * the entry data buffer by FETCH_OP_ST_EDATA. The FETCH_OP_ST_EDATA
-	 * stores the data at the data buffer + its offset, and all data are
-	 * "unsigned long" size. The offset must be increased when a data is
-	 * stored. Thus we need to find the last FETCH_OP_ST_EDATA in the
-	 * code array.
-	 */
-	for (i = 0; i < earg->size; i++) {
-		switch (earg->code[i].op) {
-		case FETCH_OP_END:
-			goto out;
-		case FETCH_OP_ST_EDATA:
-			size = earg->code[i].offset + sizeof(unsigned long);
-			break;
-		default:
-			break;
-		}
-	}
-out:
-	return size;
+	return get_entry_arg_max_offset(earg) + sizeof(unsigned long);
 }
 
 void store_trace_entry_data(void *edata, struct trace_probe *tp, struct pt_regs *regs)

