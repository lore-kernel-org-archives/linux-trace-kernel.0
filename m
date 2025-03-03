Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19F01DE3A4;
	Mon,  3 Mar 2025 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992553; cv=none; b=Rp6B0D+hFisarjMKzcoOfObkkCEq05fMDm0XKegZWUHvyKmzlmBHfR/RptlzgDFfmCAJ6AK3J69gss4PkHX/wJ36fWVzy9NWQu9A1fROnKxBcTyxSzdQRI3POcZwW5/6X+aD/2I6U30KPg43uiQUgAMQuT7IR55SmGHyaUfoClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992553; c=relaxed/simple;
	bh=UZAYbtb3BpEfZIxe1rXdNagKd6DUuOCETOtib79EdIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rkqz69MPaL7yvIa8Ai9COzsiW030LhAUHAlD8xrKBTfK7PcfA5I9O2z6fN3YAEOBs74MUioQobgVA8QVie2h5IUs/MAJrXOsdwd+DD5zO+DFz8j2Kwa3o9yGTu8oB6pw4uL0kbQ9saq4ZQGUQtDvKRrZsk7vVspNQA+SNxNL2H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otGi7m45; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otGi7m45"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AD6C4CED6;
	Mon,  3 Mar 2025 09:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740992553;
	bh=UZAYbtb3BpEfZIxe1rXdNagKd6DUuOCETOtib79EdIQ=;
	h=From:To:Cc:Subject:Date:From;
	b=otGi7m45B3/3ZMXej2fl5F3AaeEKlExdM9c3LdYZFiiBWIUjkYKsV0yhjfknilrXO
	 ri5RTiaNSYFfUfHywsk2PFpQNitOAwJJ1H1gG5MyJw1vXgVebimFJd2x3sPybk522q
	 5YGk25itOFPYF2MKONDn/i0GvugDIjtOU1ar9tC0z5zXyJHBbhB9IujF120l2WvXeU
	 ZEkJkkQC5C99/KSZquXO5D0VUu6a/Z+DYc2RO1WOu88byqmBetQPOcYvRIPrM9bTKG
	 SUxY4MFijfyUuRmlZlBq+Y6BD7WgJcsUn7Z0YQJct29a4ct1tGNQaHi95oVgf4OiM8
	 G7ypgRlw0IYEw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: probe-events: Cleanup entry-arg storing code
Date: Mon,  3 Mar 2025 18:02:29 +0900
Message-ID: <174099254917.619976.17555764627143910556.stgit@devnote2>
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
 kernel/trace/trace_probe.c |   85 +++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 2eeecb6c95ee..b2261cab4b94 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -770,6 +770,26 @@ static int check_prepare_btf_string_fetch(char *typename,
 
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
@@ -777,7 +797,6 @@ static int check_prepare_btf_string_fetch(char *typename,
 static int __store_entry_arg(struct trace_probe *tp, int argnum)
 {
 	struct probe_entry_arg *earg = tp->entry_arg;
-	bool match = false;
 	int i, offset;
 
 	if (!earg) {
@@ -795,6 +814,8 @@ static int __store_entry_arg(struct trace_probe *tp, int argnum)
 		for (i = 0; i < earg->size; i++)
 			earg->code[i].op = FETCH_OP_END;
 		tp->entry_arg = earg;
+		store_entry_arg_at(earg->code, argnum, 0);
+		return 0;
 	}
 
 	/*
@@ -806,40 +827,34 @@ static int __store_entry_arg(struct trace_probe *tp, int argnum)
 	 * code array to find the FETCH_OP_ARG which already fetches the 'argnum'
 	 * parameter. If it doesn't match, update 'offset' to find the last
 	 * offset.
-	 * If we find the FETCH_OP_END without matching FETCH_OP_ARG entry, we
-	 * will save the entry with FETCH_OP_ARG and FETCH_OP_ST_EDATA, and
-	 * return data offset so that caller can find the data offset in the entry
-	 * data buffer.
+	 * If we hit the FETCH_OP_END without matching FETCH_OP_ARG entry,
+	 * append the entry with FETCH_OP_ARG and FETCH_OP_ST_EDATA, and
+	 * return data offset so that caller can find the data offset in the
+	 * entry data buffer.
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
+	for (i = 0; i < earg->size - 1 && earg->code[i].op != FETCH_OP_END; i++) {
+		if (earg->code[i].op != FETCH_OP_ARG || earg->code[i].param != argnum)
+			continue;
+
+		if (WARN_ON_ONCE(earg->code[i + 1].op != FETCH_OP_ST_EDATA))
+			continue;
+
+		return earg->code[i + 1].offset;
 	}
-	return -ENOSPC;
+	if (i >= earg->size - 1)
+		return -ENOSPC;
+
+	/* Not found, append new entry if possible. */
+	offset = get_entry_arg_max_offset(earg) + sizeof(unsigned long);
+	store_entry_arg_at(&earg->code[i], argnum, offset);
+	return offset;
 }
 
 int traceprobe_get_entry_data_size(struct trace_probe *tp)
 {
 	struct probe_entry_arg *earg = tp->entry_arg;
-	int i, size = 0;
 
 	if (!earg)
 		return 0;
@@ -854,19 +869,7 @@ int traceprobe_get_entry_data_size(struct trace_probe *tp)
 	 * stored. Thus we need to find the last FETCH_OP_ST_EDATA in the
 	 * code array.
 	 */
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

