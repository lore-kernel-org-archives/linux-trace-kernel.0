Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40D3366562;
	Tue, 23 Jun 2026 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221405; cv=none; b=cF8kRj18tADg6GkgE/x4M1rTYo2x9+ysCB2Wsq/Y2WoRUxgZt7P9W6b8RQbgt0MJTo8YQZYNXSbzAXS6k8zk7RmpX1Cjt0707fqfCwkjQiAnSXPjuyO2Qpn2EIbH35q3tkeO5sUtl8ZiTVqaMxaklWuRRAA/bpP5yGJQZRfPRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221405; c=relaxed/simple;
	bh=Kvq3ohziYfNoxLc9yuJ1MGlLQHJXS1KkEJiYP/DBS/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zvzkt2+fsddWyY8SwqQORGgvg+Hdji2weRbfTuyG8m1qecz5P2ypj86wbxw7Ha4SlWQR2FnaaDVHwNbfFUZ8qRU20RGvzGysw42YzlJ0Lim99mFGa+mV477jkSc7renMVfMn58yRNFBcexjQoogAZKS98iikHCdT/LUcloWBbVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-209-184-216.092.209.pools.vodafone-ip.de ([92.209.184.216] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wc1CL-000000008pB-3ZXj;
	Tue, 23 Jun 2026 15:29:53 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] tracing/probes: ignore id update from btf_type_skip_modifiers
Date: Tue, 23 Jun 2026 15:29:32 +0200
Message-ID: <20260623132937.3494895-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can pass NULL as id pointer to btf_type_skip_modifiers if we do not
need the id of the returned btf_type.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 kernel/trace/trace_probe.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 9b3219e755cb..78bca283763f 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -360,9 +360,8 @@ static bool btf_type_is_char_ptr(struct btf *btf, const struct btf_type *type)
 {
 	const struct btf_type *real_type;
 	u32 intdata;
-	s32 tid;
 
-	real_type = btf_type_skip_modifiers(btf, type->type, &tid);
+	real_type = btf_type_skip_modifiers(btf, type->type, NULL);
 	if (!real_type)
 		return false;
 
@@ -379,14 +378,13 @@ static bool btf_type_is_char_array(struct btf *btf, const struct btf_type *type)
 	const struct btf_type *real_type;
 	const struct btf_array *array;
 	u32 intdata;
-	s32 tid;
 
 	if (BTF_INFO_KIND(type->info) != BTF_KIND_ARRAY)
 		return false;
 
 	array = (const struct btf_array *)(type + 1);
 
-	real_type = btf_type_skip_modifiers(btf, array->type, &tid);
+	real_type = btf_type_skip_modifiers(btf, array->type, NULL);
 
 	intdata = btf_type_int(real_type);
 	return !(BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED)
@@ -589,7 +587,6 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 	struct btf *btf = ctx_btf(ctx);
 	char *next;
 	int is_ptr;
-	s32 tid;
 
 	do {
 		if (!is_struct) {
@@ -600,7 +597,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 			}
 
 			/* Convert a struct pointer type to a struct type */
-			type = btf_type_skip_modifiers(btf, type->type, &tid);
+			type = btf_type_skip_modifiers(btf, type->type, NULL);
 			if (!type) {
 				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 				return -EINVAL;
@@ -640,7 +637,7 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 				ctx->last_bitsize = 0;
 			}
 
-			type = btf_type_skip_modifiers(btf, field->type, &tid);
+			type = btf_type_skip_modifiers(btf, field->type, NULL);
 			if (!type) {
 				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 				return -EINVAL;
@@ -759,7 +756,7 @@ static int parse_btf_arg(char *varname,
 	return -ENOENT;
 
 found:
-	type = btf_type_skip_modifiers(ctx->btf, tid, &tid);
+	type = btf_type_skip_modifiers(ctx->btf, tid, NULL);
 found_type:
 	if (!type) {
 		trace_probe_log_err(ctx->offset, BAD_BTF_TID);
-- 
2.43.7

