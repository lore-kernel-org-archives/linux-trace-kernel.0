Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE7918D62A;
	Fri, 25 Sep 2026 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790309548; cv=none; b=KYN3oYcpAmkW/cdzBZMXvOdC4fAp7Fw7E63tt1tu00tFHFECAoWyoJxDRfgdSdZii+jX2b+jKVAuJm27OEkWIfQsAoqYis0wdTu+wUbmvg3HA96nyh2krAvWT46Zv4WoHRWYMAGgNNytOo1Wc5bzX/T1QFh/VoD4sQmFuKUwEmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790309548; c=relaxed/simple;
	bh=7Hd/HJOnE1lkqzWzjHH4KY/FoP+pKmZw1/RDov5kYJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L2j5lXyxEwkCu7/usZDivTZCwYOI8SlGpjU4xiae6UjS2UWGm6nSU1tQXaBg998qh8dpWMsG4qaq+2ZakKn5e4EjAQpMwwsi0qHHroGtJwBmXJEPBjLr0nzOMR6b3pyALr1vmubG/JuYG71hYAytknr8RFQ8EaQoFGHub3NR1ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4KSGo+M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4KSGo+M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AEC1F000FF;
	Fri, 25 Sep 2026 04:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790309547;
	bh=Z9UBOKN6yLgeTYW8qbnwcVSEUt3kZ2lhNT94i8veq18=;
	h=From:To:Cc:Subject:Date;
	b=F4KSGo+Mjb+H9dL7xPAj1BJXUGpZPTbXckmH7nKkn6gPZqMB9oGRLDlhnPKTeyDyt
	 g1tcxU3J5kB1h+FFYeWOco4MIQxHLm0VHs9MdrrJFFPH47v4/EwCDGhfazOtD8ShDW
	 KrjRJD+06ZeOL1sdwet5ZKb0W2U8y4LK4zXsrcm9r7qtGPVkeIFWa1kc1m+j/O6mq3
	 gmOzblMQQ4yVZI/0KNwxZCi7yRH0S9ugxjmtibYxgASnkf4qiNHBq2VHgIaLdIfak/
	 cf370sngqEeRaX8UY3YElpfHcltLjdyXxNksHLEYYz80weYLqlSAwEOgAdXBGdD/aS
	 jI6qH+jxARVsA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/probes: Clarify btf_find_struct_member() container parameter and add kernel-doc
Date: Fri, 25 Sep 2026 13:12:23 +0900
Message-ID: <179030954365.77418.17193777972248047975.stgit@devnote2>
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

btf_find_struct_member() returns the containing structure or union type
(which can be an inner anonymous struct/union rather than the outer
passed type) via its last parameter. However, the parameter was named
@member_type, which easily confuses readers and static analyzers into
thinking it returns the member field's own datatype.

Rename @member_type to @container_type in the prototype, definition,
and callers to make the relationship explicit. Also convert the comment
above btf_find_struct_member() to standard kernel-doc format, documenting
all parameters and return values.

Assisted-by: LLM
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_btf.c   |   34 ++++++++++++++++++++++++----------
 kernel/trace/trace_btf.h   |    2 +-
 kernel/trace/trace_probe.c |    6 +++---
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index ee7a04886bf6..a534907336ff 100644
--- a/kernel/trace/trace_btf.c
+++ b/kernel/trace/trace_btf.c
@@ -59,19 +59,33 @@ struct btf_anon_stack {
 	u32 offset;
 };
 
-/*
- * Find a member of data structure/union by name and return it.
- * Return NULL if not found, or ERR_PTR(-EINVAL) if parameter is invalid.
- * If the member is a member of an anonymous union/structure, the bit offset
- * of that anonymous union/structure is stored into @anon_offset.
- * If @member_type is non-NULL, the actual containing structure/union type
- * of the found member is stored into @member_type.
+/**
+ * btf_find_struct_member() - Find a member of data structure/union by name
+ * @btf: Pointer to BTF object.
+ * @type: Pointer to the struct/union BTF type to search within.
+ * @member_name: Name of the member to find.
+ * @anon_offset: Pointer to store bit offset of enclosing anonymous union/struct.
+ * @container_type: Pointer to store the actual containing struct/union type.
+ *
+ * Find a member of data structure/union by name, traversing into anonymous
+ * unions and structures if necessary.
+ *
+ * If the member is inside an anonymous union/structure, the bit offset
+ * of that anonymous union/structure from @type is stored into @anon_offset.
+ * If @container_type is non-NULL, the actual struct/union BTF type that
+ * directly contains the found member is stored into @container_type.
+ *
+ * Return:
+ * * Pointer to &struct btf_member on success.
+ * * %NULL if the member was not found.
+ * * %ERR_PTR(-EINVAL) if @type is not a struct/union.
+ * * %ERR_PTR(-ENOMEM) if memory allocation failed.
  */
 const struct btf_member *btf_find_struct_member(struct btf *btf,
 						const struct btf_type *type,
 						const char *member_name,
 						u32 *anon_offset,
-						const struct btf_type **member_type)
+						const struct btf_type **container_type)
 {
 	struct btf_anon_stack *anon_stack;
 	const struct btf_member *member;
@@ -103,8 +117,8 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 			if (name && !strcmp(member_name, name)) {
 				if (anon_offset)
 					*anon_offset = cur_offset;
-				if (member_type)
-					*member_type = type;
+				if (container_type)
+					*container_type = type;
 				goto out;
 			}
 		}
diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
index 4bd26bceae23..68f1d61fefb0 100644
--- a/kernel/trace/trace_btf.h
+++ b/kernel/trace/trace_btf.h
@@ -9,4 +9,4 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 						const struct btf_type *type,
 						const char *member_name,
 						u32 *anon_offset,
-						const struct btf_type **member_type);
+						const struct btf_type **container_type);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 804442b2f7d2..17899ab15171 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -625,7 +625,7 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
 {
 	const struct btf_type *type = *ptype;
 	const struct btf_member *field;
-	const struct btf_type *mtype;
+	const struct btf_type *container_type;
 	struct btf *btf = ctx_btf(ctx);
 	char *fieldname = *pfieldname;
 	int bitoffs = 0;
@@ -641,7 +641,7 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
 
 		anon_offs = 0;
 		field = btf_find_struct_member(btf, type, fieldname,
-						&anon_offs, &mtype);
+						&anon_offs, &container_type);
 		if (IS_ERR(field)) {
 			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 			return PTR_ERR(field);
@@ -654,7 +654,7 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
 		bitoffs += anon_offs;
 
 		/* Accumulate the bit-offsets of the dot-connected fields */
-		if (btf_type_kflag(mtype)) {
+		if (btf_type_kflag(container_type)) {
 			bitoffs += BTF_MEMBER_BIT_OFFSET(field->offset);
 			ctx->last_bitsize = BTF_MEMBER_BITFIELD_SIZE(field->offset);
 		} else {

