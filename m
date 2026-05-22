Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D3786329
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779485205; cv=none; b=PE9GQHbJLmht0AJThKODpB46qaqxS6iWK9WTqd3x6E8v5Wm2KUFGpcp2WicJJ0yZaLTYaZGchi3+zBXuVvTo0fZEhisBpCPdeyTKXMQaJtBMYMGsnlS4aJiYOs+HIIB9LV7et8cIqiArbulOrcL8wQQ5KRWrMmsoGmbDIpLVd9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779485205; c=relaxed/simple;
	bh=47XSb3xLtkJNOjKqO7HnZ+Ci/OB4Hy2ENzGsXGeHBU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pApLQF1K1cdOInkAo9Z5YEl2Xl+vjdyjBNoZ/KbuzPbvH6qy+ryrYRbX/x2FkR/0lPtb1SMw9U3A7Wc4SxgTQzvE9KJlIRf8dJdpY0+BYVdeYB8XZakdW3AEojUFYCQLKnt9ISl6FA5XUk86V1HlQewrQ7/MV+QNE6MLJkC08NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPuyZ6nC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPuyZ6nC"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2baca4df358so48634375ad.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779485204; x=1780090004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1+HSE4Kp3DxOfOzMRAc5EZvyDuO0MEYQBfq97P4omUo=;
        b=OPuyZ6nCn9EWao7XtpncZu/ZjFPRMp5IITxmYOw1hdzK9Y+Prf1kKOAHCWWKx906HN
         RZfg7poIM3Nd7OcIb/dVNeMzFfVjyAYfS68Dy9nL+bIx2JjQkAbgEiw22npRkMwgfH1v
         lkyTAA2efLX4Ooj3mOpEF4bxMMsWDAlHHLAD/nZOUGxcOpSF9WuAKUxHMcxi3wmYpniu
         ybWbozdMEvl32UB85oCzA3Ya3bfobnPvWHsb8hntrcliHxts4WbQRR+I4XNAuiALV5Gb
         z2Qsbd8lAtbFyPDm9rX6CGVZ6yQVwk5Ellb40KAnznH1v+BdW1suryDvGSC8PF+rMlKY
         7IVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779485204; x=1780090004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+HSE4Kp3DxOfOzMRAc5EZvyDuO0MEYQBfq97P4omUo=;
        b=MEKQyXX90XVlUeCPDVqkuUWEhSAt8+ih8VHAeqc7cDV3LdnaA+4r9TSYT6xytFSXJz
         nNDscEsVxZm/20GtFsV5hGqw3gUDm0Dxr5aM+IzlUvBYu1FJ99A/7k6lUJoA+74EDCfv
         4hKvyo5WG/hAupxxuDU6D7d/zbst7ZpaeceT/OiVEI7gYGp66Tnp7y1EhL0ey1dRIM9u
         VGy+lO0l9EoR0EZl6+HIH/knjb7ETP03PS1V9aRaUaqHnjnmASx2sGeCAdWpySR48+55
         8/hWq4ZVili7ET9tuNz9ALXe8Eexb0ltP/OsCC6iyGDu/XtK4E77tsTGcamw1edipfbB
         WvGA==
X-Gm-Message-State: AOJu0YyINPDvdTekmbuqv/UkvMwK+o8mAhlHfxL1zUeeK7Ni1PTSj/IP
	nEKz3dvce4UzMbnDF/htY77rCyu//IFLzPYC9xXoy0cFF+6j4iPIok4T0Hn3XA==
X-Gm-Gg: Acq92OEXk9xgjbYUFrHs8d136Hw68wb/SO19s8zXiJ6xzw7tDDhX+tSCLwWWeZNDqpD
	JEpwZNGA2z0gcoLDqKzTP5n312Pt3ZsnvEozDUySPEF/PyrS46JA3JAWBzJc8v38xw32U5JCtVG
	7jRhexvbDC0GcpDipscwaZ0GtFvmDM3TN+mND09Frh72CPEScx2JMR6cyKmftJKf6TXTLbnGPil
	Iqo8v64DIBuOYxPJjvy+TbE/+8MoG3A3BcUlWfnVrpMhlEC+ZeGALYgN2AI5rMtWXOXB6PYZwP0
	N3flsXbS5kEo1sbANEzH3evs3OPuK437LuwVU7D8kNKIgnOyM8jWM5Wm1+P+chHzbsi8VG6dv1a
	CSUagyNhQW97FjJiaZyVt7bGbU78SEnQhC/4LucRzxi8iZj+zqw4lL55EIVpR1AWqryGoVo1Kzs
	DUg0OTWzNOm4/afsSsplsi2fbcdm4a7w4l2w3tXtMlyD3XsY37/ni9ppyi2TkeCcERRO2+s8I6S
	UZjLJH47+3H8wv0uny9n9iHd/u4EL9ypA2ONeImkUTzkQ==
X-Received: by 2002:a17:902:e548:b0:2bc:ac76:c1d3 with SMTP id d9443c01a7336-2beb0770aebmr60033635ad.29.1779485203638;
        Fri, 22 May 2026 14:26:43 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b386esm30195395ad.44.2026.05.22.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:26:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCHv2] trace: allocate fields with elt struct
Date: Fri, 22 May 2026 14:26:27 -0700
Message-ID: <20260522212627.12406-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to embed the fields array in the
tracing_map_elt allocation, reducing the number of allocations
per element.

Since the fields are now embedded in the struct, taking the address
of a field through a const-qualified elt pointer yields a
const-qualified pointer. Rather than adding casts, switch the
comparison functions to take const void * parameters. These are
all read-only operations.

Assisted-by: OpenCode:BigPickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: Rebased.
 kernel/trace/tracing_map.c | 41 ++++++++++++++++----------------------
 kernel/trace/tracing_map.h |  8 ++++----
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index d7922f40dbe2..928948b50737 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -125,32 +125,32 @@ u64 tracing_map_read_var_once(struct tracing_map_elt *elt, unsigned int i)
 	return (u64)atomic64_read(&elt->vars[i]);
 }
 
-int tracing_map_cmp_string(void *val_a, void *val_b)
+int tracing_map_cmp_string(const void *val_a, const void *val_b)
 {
-	char *a = val_a;
-	char *b = val_b;
+	const char *a = val_a;
+	const char *b = val_b;
 
 	return strcmp(a, b);
 }
 
-int tracing_map_cmp_none(void *val_a, void *val_b)
+int tracing_map_cmp_none(const void *val_a, const void *val_b)
 {
 	return 0;
 }
 
-static int tracing_map_cmp_atomic64(void *val_a, void *val_b)
+static int tracing_map_cmp_atomic64(const void *val_a, const void *val_b)
 {
-	u64 a = atomic64_read((atomic64_t *)val_a);
-	u64 b = atomic64_read((atomic64_t *)val_b);
+	u64 a = atomic64_read((const atomic64_t *)val_a);
+	u64 b = atomic64_read((const atomic64_t *)val_b);
 
 	return (a > b) ? 1 : ((a < b) ? -1 : 0);
 }
 
 #define DEFINE_TRACING_MAP_CMP_FN(type)					\
-static int tracing_map_cmp_##type(void *val_a, void *val_b)		\
+static int tracing_map_cmp_##type(const void *val_a, const void *val_b)	\
 {									\
-	type a = (type)(*(u64 *)val_a);					\
-	type b = (type)(*(u64 *)val_b);					\
+	type a = (type)(*(const u64 *)val_a);				\
+	type b = (type)(*(const u64 *)val_b);				\
 									\
 	return (a > b) ? 1 : ((a < b) ? -1 : 0);			\
 }
@@ -383,7 +383,6 @@ static void __tracing_map_elt_free(struct tracing_map_elt *elt)
 	if (!elt)
 		return;
 
-	kfree(elt->fields);
 	kfree(elt->vars);
 	kfree(elt->var_set);
 	kfree(elt->key);
@@ -406,7 +405,7 @@ static struct tracing_map_elt *tracing_map_elt_alloc(struct tracing_map *map)
 	struct tracing_map_elt *elt;
 	int err = 0;
 
-	elt = kzalloc_obj(*elt);
+	elt = kzalloc_flex(*elt, fields, map->n_fields);
 	if (!elt)
 		return ERR_PTR(-ENOMEM);
 
@@ -418,12 +417,6 @@ static struct tracing_map_elt *tracing_map_elt_alloc(struct tracing_map *map)
 		goto free;
 	}
 
-	elt->fields = kzalloc_objs(*elt->fields, map->n_fields);
-	if (!elt->fields) {
-		err = -ENOMEM;
-		goto free;
-	}
-
 	elt->vars = kzalloc_objs(*elt->vars, map->n_vars);
 	if (!elt->vars) {
 		err = -ENOMEM;
@@ -857,10 +850,10 @@ static int cmp_entries_sum(const void *A, const void *B)
 {
 	const struct tracing_map_elt *elt_a, *elt_b;
 	const struct tracing_map_sort_entry *a, *b;
-	struct tracing_map_sort_key *sort_key;
-	struct tracing_map_field *field;
+	const struct tracing_map_sort_key *sort_key;
+	const struct tracing_map_field *field;
 	tracing_map_cmp_fn_t cmp_fn;
-	void *val_a, *val_b;
+	const void *val_a, *val_b;
 	int ret = 0;
 
 	a = *(const struct tracing_map_sort_entry **)A;
@@ -888,10 +881,10 @@ static int cmp_entries_key(const void *A, const void *B)
 {
 	const struct tracing_map_elt *elt_a, *elt_b;
 	const struct tracing_map_sort_entry *a, *b;
-	struct tracing_map_sort_key *sort_key;
-	struct tracing_map_field *field;
+	const struct tracing_map_sort_key *sort_key;
+	const struct tracing_map_field *field;
 	tracing_map_cmp_fn_t cmp_fn;
-	void *val_a, *val_b;
+	const void *val_a, *val_b;
 	int ret = 0;
 
 	a = *(const struct tracing_map_sort_entry **)A;
diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
index 18a02959d77b..90a7fde5dd02 100644
--- a/kernel/trace/tracing_map.h
+++ b/kernel/trace/tracing_map.h
@@ -13,7 +13,7 @@
 #define TRACING_MAP_VARS_MAX		16
 #define TRACING_MAP_SORT_KEYS_MAX	2
 
-typedef int (*tracing_map_cmp_fn_t) (void *val_a, void *val_b);
+typedef int (*tracing_map_cmp_fn_t) (const void *val_a, const void *val_b);
 
 /*
  * This is an overview of the tracing_map data structures and how they
@@ -137,11 +137,11 @@ struct tracing_map_field {
 
 struct tracing_map_elt {
 	struct tracing_map		*map;
-	struct tracing_map_field	*fields;
 	atomic64_t			*vars;
 	bool				*var_set;
 	void				*key;
 	void				*private_data;
+	struct tracing_map_field	fields[];
 };
 
 struct tracing_map_entry {
@@ -260,8 +260,8 @@ tracing_map_lookup(struct tracing_map *map, void *key);
 
 extern tracing_map_cmp_fn_t tracing_map_cmp_num(int field_size,
 						int field_is_signed);
-extern int tracing_map_cmp_string(void *val_a, void *val_b);
-extern int tracing_map_cmp_none(void *val_a, void *val_b);
+extern int tracing_map_cmp_string(const void *val_a, const void *val_b);
+extern int tracing_map_cmp_none(const void *val_a, const void *val_b);
 
 extern void tracing_map_update_sum(struct tracing_map_elt *elt,
 				   unsigned int i, u64 n);
-- 
2.54.0

