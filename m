Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61EB39524E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779316282; cv=none; b=YZO0jPvE6E6vMu1/UEMpb6nxNlq5ps+ksnhNbWy5pztD9O6i/80BC2B0/2SJByGSPjIDro+OvL/pk04VW2+EDKIfgXKjD6O4JtzoYoaHfwE0z/der9WSdkslIar+MErUlgaTWys+zBevw1qtXfsXhmUFtsFOZg5fHlQWlh9yss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779316282; c=relaxed/simple;
	bh=I3ZxjS8Vwloppz1bU2Aco1ST2M0WIV6j4BH8WvqiYGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gl4ZVbiFUp0b4JO2hR/+fLp7fti6IIfQUbkkpkfkhdGzNSg8XYrvs4YnLGv/GS476/J4vvxTJa9VAHl9g5su74LA4+8ffdOohDdGtmAdmySTarSagfHllbb+TItvSZ7P7Z69BnRSehiAuIDC1cF/Ni6fZQNl+sPlbqNOGjuTyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qHQv+4tc; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHQv+4tc"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c802803ac17so2370912a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 15:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779316280; x=1779921080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=toNA9xjifNFqKWiUch4MwW+wbIQ7pcksxXHgHNBY+Qc=;
        b=qHQv+4tcOzTYMEQw5IXp7BEVppcg3MmSuPQIINXnQWqG6gtIpEblfwKd/wa/2eLlsz
         tUFW//jzynJVKaBcBWLYBBFp2wQBjVO3mslLom9bdhqmBVTyHsUc42N823ijFz40XYdy
         Cc555g1qA4N15AllYOQoe8oWb+rn0bgEizPnAHOtXPwe9+mvtboJqHrszC9dIArs2hpy
         lR/6SaeL9oH/M/Y/UmxG32uvM/1YVMWqqULDJ5xzzQqdaz3Ao2Frh1ojK2w5c9jiJNsN
         ZizJ7Uc5h8uqgpdUMoaNqWMlll4akKuEulbNT3BasWEfZ+ChwPeeUhIsE/HZp++9jhSE
         CnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779316280; x=1779921080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toNA9xjifNFqKWiUch4MwW+wbIQ7pcksxXHgHNBY+Qc=;
        b=YqA85a1jXMH5fP6YuUDB+AKyudsABos3a0Z6cI7gYWDp4RJEgatSn/aYMunTupGbIr
         eigIMW1IOmQmlTqJb1qnr7nXj4KPSEjAb+X1qgYV2R5Lty5CKUXugMSH/XGGReXFXcnk
         +09A0dB7BZCY3Icak28HXOWZzAHtCC4/qxFLN544yUZnvH7YToGfyNdTQt9FqjCC9t91
         JHpBee56nKKIE9VinB8UPR4xxx8+eHXMfzPuIhk179YpK4PmPgjOBiT/WK8EpHbYW3a9
         6ZOFL7VvRvSEXbgy0ectxT8q02vtXLxNZU/NBt+firBTc+hIxpjlmvrWCn6Ffe4s7vix
         i52g==
X-Gm-Message-State: AOJu0YwbNpjtAg9Q/y6O3251ryDcHjVIQGTGO+j7sPggK0ixWvuHBMGB
	QKPJwhnXkr+mIdxCuO+Sp41Y3nyIC2cqCNk+o1B9WW7Clr3fVFEN22mHt0Q6AQ==
X-Gm-Gg: Acq92OHXiXGTNoGDntJLq+NauHyJnw/phfVnoJ+HMhy18GvhK/JbHYEQsETKByfPbu6
	ukw/xsm5TT7KagU/8YWp+jTep2Fok/4hsoga0nOmiGRXy+/faJidCteafi/vtPX4XE7sQXTEqk9
	FvqI3NTNWNhqtVJ/h+u8VxiotNrZETUlKzBEdoRH8Tq9jtkv5NpA42mhDKF7kBW6iWvQ5mHORRe
	1IgYDOgzIp8kbYtDOrFWTJhkkupHPBUgF15EHQT+B4SEDbq0WeHN/cBUaSHKm3m8kRG25p0AYbp
	5M5g+PBSGzWLr/NsKJiSPyxmurMGuscOGKEqvU5q9zTAcRZ0mii36p5P2K61yjRqO4Wbj63EJ9c
	C++/WGDU4glu1wcD6il+UWlHqKBHsNHMrH0iqfZL+xaXqHhxw9PaaW2k2ea2JnfBFOD7oVZrnwl
	Ywx/wGm1RfXT3BL/kHhwMUP8U5XrkV3P9IVUqWaqSrKaWN8dGk0CDaieR5Dk3FRpdlkFWu/KiKA
	/Lg/M4uXGjzYdqeKRG4piSuTE29qsJBtPA=
X-Received: by 2002:a17:903:2390:b0:2bd:b50f:c1bf with SMTP id d9443c01a7336-2bea31cda5dmr880555ad.38.1779316279957;
        Wed, 20 May 2026 15:31:19 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11ce67sm236719345ad.74.2026.05.20.15.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:31:19 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH] trace: allocate fields with elt struct
Date: Wed, 20 May 2026 15:31:01 -0700
Message-ID: <20260520223101.34710-1-rosenp@gmail.com>
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
 kernel/trace/tracing_map.c | 41 ++++++++++++++++----------------------
 kernel/trace/tracing_map.h |  8 ++++----
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 1404bf752d99..97f7e3cde262 100644
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
@@ -385,7 +385,6 @@ static void tracing_map_elt_free(struct tracing_map_elt *elt)
 
 	if (elt->map->ops && elt->map->ops->elt_free)
 		elt->map->ops->elt_free(elt);
-	kfree(elt->fields);
 	kfree(elt->vars);
 	kfree(elt->var_set);
 	kfree(elt->key);
@@ -397,7 +396,7 @@ static struct tracing_map_elt *tracing_map_elt_alloc(struct tracing_map *map)
 	struct tracing_map_elt *elt;
 	int err = 0;
 
-	elt = kzalloc_obj(*elt);
+	elt = kzalloc_flex(*elt, fields, map->n_fields);
 	if (!elt)
 		return ERR_PTR(-ENOMEM);
 
@@ -409,12 +408,6 @@ static struct tracing_map_elt *tracing_map_elt_alloc(struct tracing_map *map)
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
@@ -848,10 +841,10 @@ static int cmp_entries_sum(const void *A, const void *B)
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
@@ -879,10 +872,10 @@ static int cmp_entries_key(const void *A, const void *B)
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

