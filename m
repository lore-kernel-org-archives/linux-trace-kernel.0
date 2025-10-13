Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE987262D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361370; cv=none; b=N/PbfHBHW3jTL8snfEqEaQrIh1A8RgRspjxVr7l2pV7gKjMDgoSndrZ7D90iv7oU3ZBywtLeZOjC9PidwNAXohPU1W7Fw/N8STAnNupRtqYHD4+LyL0MaNwjDnwmpROSq5pgWKWMxZEPpDaBRsEQPtmgdWmid4I9gVuM8H+fi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361370; c=relaxed/simple;
	bh=883Y4I76q2WhN5ZRrOVdXEtX/TypmR7bW/POuDLlyLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YnpAD6rUYDEPm+Mh8L6VTYjcbeM1Z7asD2whSX1O52D5Ww7Ya83i94/nnGa86ZDcTZm2VEGx51QEkmUfzWDBj8bXvDOw/R6sxxtSkCyzQpFAOHRq5dnh5oKe90VNrX+rnTyiWp69i+HIal+e77q5vrH6awe4XWhyT7sr5uMJ6dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGsESs7k; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGsESs7k"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27c369f898fso57959355ad.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760361368; x=1760966168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o3wGb0jvMfnlPMFXFLvmSed44BB541lVzsxTRhu5UnU=;
        b=RGsESs7kUknXUmCScJQKWxIEsIED+hNI9Y1ag5Gugw+/OvEMPHXBjyhPnHm+ccaM0y
         JbUGCBXrcCRf1pDKY3DJEYB+dXco9iA+uiEaf9g4wpZHZVgSMJ45Io6SQfa5B+TRL7m2
         BS4wJ1uqLdx6XBql4kmbSlgw8Q+5ApmqffsDsuRRq+q5PUXIKfE2Z0PaurIkAYudvbiL
         x751ysfvohWl3mfSG4FS/7c5HNLvgHl8w2wbareL7uMjLqTSCEEQLcl54OrsaAnHLDS7
         Pilr+rB8pFhsVtHnvRhYc5rDTvyP2CpjNgjIGboPJwZlnftNVi2/lMjyALNcd9aADC1W
         4EMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760361368; x=1760966168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3wGb0jvMfnlPMFXFLvmSed44BB541lVzsxTRhu5UnU=;
        b=SPHIwhqIPoHkFNP2QjbuQtGN7HGXYYmUQnF1TdYjDwBX9e+ybb9NWLkm8CvD3sFNRq
         QxnFjjMBxRp0oGOfqNNCLtBy7abqoij4n9Fktyva+1/oqI+ZJAjrvT7lXH/i0ILkMbyO
         mdEvzQFlMtB7225CkFAuIFIC8+sUNSrQOZM3WKLA1OAvFfdHpgYDzuS1sVIpSyEcVm8G
         UlDvp/W0gyyylhiOWXjByHMl3j/P/rQ6Nz1ee7p54UUE6IFMk4MuHFZeHanfeuMwy24g
         NPvEofvnZHD3q9a6di7ZjRQyy06t5uQQsF+RmCaTXtvkPEvQVHJYdK+4OTYDnx3jo2Og
         rcUA==
X-Forwarded-Encrypted: i=1; AJvYcCX/dOf+ygW9XhupocKg6uXbpnj788ECVzZ1PTHtOsq0krckUnK/bBwhaA/kLXXiz8PSrWIvpfB98xJRgxB5YEi5eCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDJ2Wr7j6K4biFJVo0fH8rJrjbPdVYQwqX5BpmPp2gNFxvfAA
	4JLNiHFp2A/PWSgm67Gwch3tzZSFhKNnFcZDu0tH4mzN3qdHV/RYJf6c
X-Gm-Gg: ASbGncv6PpvyuE8b4UdwWv/tNXUkU3Ue5RKKAbblablYYNExojFb1dJpkLcPo9lso5e
	8XsnJCyg4RKx6ul0LofGxB/DEA7GtHsyIuTP8VWjqsh+OjaygapNli2+mepbrhL3wwOW2WkA/nz
	7I2z/qw0NdbDAJBx6ySf7x5jRNxotJE/PHAPVVboLgagQvu1FfjSR47U+NXCLhSR+5XwjzCOp/3
	6xu2CnVWVud/Ni1nOpmdL9dpsvh4IZwfnpXgjnUE99XqpBLgZLQFCwJqDLdC9ViLdv32fcL0N8b
	+yiaINWZ3Mm3KcVV+7ZHkmDzrimOVyUjkoSe86rJGdmZQlSZjICEUEkvlwgfsxLXO1LlupJLj1Q
	pLRkrONrz8jaD8d1H4GAk/0G9217PTjLnlAz+S//xl5aRjeRL/lLo0tac1Nup/ZR0maqs
X-Google-Smtp-Source: AGHT+IEMiwZV+2vIKAiwExBNs2tsmz2gfFwGpAA1vz1ORQ1womMq9/95xrQ4f6Tr24wzbJhEBTDRgA==
X-Received: by 2002:a17:903:1984:b0:26a:8171:dafa with SMTP id d9443c01a7336-2902723fc6bmr282140815ad.21.1760361367694;
        Mon, 13 Oct 2025 06:16:07 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29055badc54sm67746225ad.37.2025.10.13.06.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 06:16:06 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: andrii@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Song Liu <song@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize btf_find_by_name_kind lookup
Date: Mon, 13 Oct 2025 21:15:37 +0800
Message-Id: <20251013131537.1927035-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Currently, when the funcgraph-args feature is in use, the
btf_find_by_name_kind function is invoked quite frequently. However,
this function only supports linear search. When the number of btf_type
entries to search through is large, such as in the vmlinux BTF which
contains over 80,000 named btf_types, it consumes a significant amount
of time.

This patch optimizes the btf_find_by_name_kind lookup by sorting BTF
types according to their names and kinds. Additionally, it modifies
the search direction. Now, it first searches the BTF and then its base.

It should be noted that this change incurs some additional memory and
boot-time overhead. Therefore, the option is disabled by default.

Here is a test case:

 # echo 1 > options/funcgraph-args
 # echo function_graph > current_tracer

Before:
 # time cat trace | wc -l
 124176

 real    0m16.154s
 user    0m0.000s
 sys     0m15.962s

After:
 # time cat trace | wc -l
 124176

 real    0m0.948s
 user    0m0.000s
 sys     0m0.973s

An improvement of more than 20 times can be observed.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 include/linux/btf.h |   1 +
 kernel/bpf/Kconfig  |  13 ++++
 kernel/bpf/btf.c    | 160 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 165 insertions(+), 9 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f06976ffb63f..ddc53a7ac7cd 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -220,6 +220,7 @@ bool btf_is_module(const struct btf *btf);
 bool btf_is_vmlinux(const struct btf *btf);
 struct module *btf_try_get_module(const struct btf *btf);
 u32 btf_nr_types(const struct btf *btf);
+u32 btf_type_cnt(const struct btf *btf);
 struct btf *btf_base_btf(const struct btf *btf);
 bool btf_type_is_i32(const struct btf_type *t);
 bool btf_type_is_i64(const struct btf_type *t);
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index eb3de35734f0..01d9d766c1dc 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -101,4 +101,17 @@ config BPF_LSM
 
 	  If you are unsure how to answer this question, answer N.
 
+config BPF_SORT_BTF_BY_NAME_KIND
+	bool "Sort BTF type by name and kind"
+	depends on DEBUG_INFO_BTF
+	default n
+	help
+	  Sort BTF types by name and kind to enable binary search, improving
+	  the performance of btf_find_by_name_kind. Currently applies to
+	  vmlinux and kernel module BTFs. Note that this option introduces
+	  extra memory and boot-time overhead.
+
+	  For instance, a BTF file with 80,000 named btf_types consumes
+	  approximately 312 KB of additional memory.
+
 endmenu # "BPF subsystem"
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..aed7349e30b8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -250,6 +250,11 @@ struct btf_struct_ops_tab {
 	struct bpf_struct_ops_desc ops[];
 };
 
+struct btf_sorted_ids {
+	u32 cnt;
+	u32 ids[];
+};
+
 struct btf {
 	void *data;
 	struct btf_type **types;
@@ -268,6 +273,9 @@ struct btf {
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
 	struct btf_struct_metas *struct_meta_tab;
 	struct btf_struct_ops_tab *struct_ops_tab;
+#ifdef CONFIG_BPF_SORT_BTF_BY_NAME_KIND
+	struct btf_sorted_ids *sorted_ids;
+#endif
 
 	/* split BTF support */
 	struct btf *base_btf;
@@ -470,6 +478,9 @@ static int btf_resolve(struct btf_verifier_env *env,
 static int btf_func_check(struct btf_verifier_env *env,
 			  const struct btf_type *t);
 
+static int cmp_name_kind(const char *sa, u8 ka,
+			 const char *sb, u8 kb);
+
 static bool btf_type_is_modifier(const struct btf_type *t)
 {
 	/* Some of them is not strictly a C modifier
@@ -544,22 +555,59 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+u32 btf_type_cnt(const struct btf *btf)
+{
+	return btf->start_id + btf->nr_types;
+}
+
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
 {
 	const struct btf_type *t;
+	struct btf_sorted_ids *sorted_ids = NULL;
 	const char *tname;
 	u32 i, total;
 
-	total = btf_nr_types(btf);
-	for (i = 1; i < total; i++) {
-		t = btf_type_by_id(btf, i);
-		if (BTF_INFO_KIND(t->info) != kind)
-			continue;
+	do {
+#ifdef CONFIG_BPF_SORT_BTF_BY_NAME_KIND
+		sorted_ids = btf->sorted_ids;
+#endif
+		if (sorted_ids) {
+			/* binary search */
+			u32 start, end, mid;
+			u32 *ids = sorted_ids->ids;
+			int ret;
+
+			start = 0;
+			end = sorted_ids->cnt - 1;
+			while (start <= end) {
+				mid = start + (end - start) / 2;
+				t = btf_type_by_id(btf, ids[mid]);
+				tname = btf_name_by_offset(btf, t->name_off);
+				ret = cmp_name_kind(tname, BTF_INFO_KIND(t->info),
+						    name, kind);
+				if (ret < 0)
+					start = mid + 1;
+				else if (ret > 0)
+					end = mid - 1;
+				else
+					return ids[mid];
+			}
+		} else {
+			/* linear search */
+			total = btf_type_cnt(btf);
+			for (i = btf->start_id; i < total; i++) {
+				t = btf_type_by_id(btf, i);
+				if (BTF_INFO_KIND(t->info) != kind)
+					continue;
+
+				tname = btf_name_by_offset(btf, t->name_off);
+				if (!strcmp(tname, name))
+					return i;
+			}
+		}
 
-		tname = btf_name_by_offset(btf, t->name_off);
-		if (!strcmp(tname, name))
-			return i;
-	}
+		btf = btf->base_btf;
+	} while (btf);
 
 	return -ENOENT;
 }
@@ -1737,12 +1785,29 @@ static void btf_free_struct_ops_tab(struct btf *btf)
 	btf->struct_ops_tab = NULL;
 }
 
+#ifdef CONFIG_BPF_SORT_BTF_BY_NAME_KIND
+static void btf_free_sorted_ids(struct btf *btf)
+{
+	struct btf_sorted_ids *sorted_ids = btf->sorted_ids;
+
+	if (!sorted_ids)
+		return;
+
+	kvfree(sorted_ids);
+	btf->sorted_ids = NULL;
+}
+#else
+static void btf_free_sorted_ids(struct btf *btf)
+{}
+#endif
+
 static void btf_free(struct btf *btf)
 {
 	btf_free_struct_meta_tab(btf);
 	btf_free_dtor_kfunc_tab(btf);
 	btf_free_kfunc_set_tab(btf);
 	btf_free_struct_ops_tab(btf);
+	btf_free_sorted_ids(btf);
 	kvfree(btf->types);
 	kvfree(btf->resolved_sizes);
 	kvfree(btf->resolved_ids);
@@ -6189,6 +6254,81 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
 	return kctx_type_id;
 }
 
+#ifdef CONFIG_BPF_SORT_BTF_BY_NAME_KIND
+static int cmp_name_kind(const char *sa, u8 ka, const char *sb, u8 kb)
+{
+	return strcmp(sa, sb) ?: (ka - kb);
+}
+
+static int btf_compare_name_kind(const void *a, const void *b, const void *priv)
+{
+	const struct btf *btf = priv;
+	const struct btf_type *ba, *bb;
+	u32 ia = *(const u32 *)a;
+	u32 ib = *(const u32 *)b;
+
+	ba = btf_type_by_id(btf, ia);
+	bb = btf_type_by_id(btf, ib);
+
+	return cmp_name_kind(btf_name_by_offset(btf, ba->name_off),
+			     BTF_INFO_KIND(ba->info),
+			     btf_name_by_offset(btf, bb->name_off),
+			     BTF_INFO_KIND(bb->info));
+}
+
+static void btf_sort_by_name_kind(struct btf *btf)
+{
+	const struct btf_type *t;
+	struct btf_sorted_ids *sorted_ids;
+	const char *name;
+	u32 *ids;
+	u32 total, cnt = 0;
+	u32 i, j = 0;
+
+	total = btf_type_cnt(btf);
+	for (i = btf->start_id; i < total; i++) {
+		t = btf_type_by_id(btf, i);
+		name = btf_name_by_offset(btf, t->name_off);
+		if (str_is_empty(name))
+			continue;
+		cnt++;
+	}
+
+	/* Use linear search when the number is below the threshold */
+	if (cnt < 8)
+		return;
+
+	sorted_ids = kvmalloc(struct_size(sorted_ids, ids, cnt), GFP_KERNEL);
+	if (!sorted_ids) {
+		pr_warn("Failed to allocate memory for sorted_ids\n");
+		return;
+	}
+
+	ids = sorted_ids->ids;
+	for (i = btf->start_id; i < total; i++) {
+		t = btf_type_by_id(btf, i);
+		name = btf_name_by_offset(btf, t->name_off);
+		if (str_is_empty(name))
+			continue;
+		ids[j++] = i;
+	}
+
+	sort_r(ids, cnt, sizeof(ids[0]), btf_compare_name_kind, NULL, btf);
+
+	sorted_ids->cnt = cnt;
+	btf->sorted_ids = sorted_ids;
+}
+#else
+static int cmp_name_kind(const char *sa, u8 ka, const char *sb, u8 kb)
+{
+	return 0;
+}
+
+static void btf_sort_by_name_kind(struct btf *btf)
+{
+}
+#endif
+
 BTF_ID_LIST_SINGLE(bpf_ctx_convert_btf_id, struct, bpf_ctx_convert)
 
 static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name,
@@ -6230,6 +6370,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	if (err)
 		goto errout;
 
+	btf_sort_by_name_kind(btf);
 	refcount_set(&btf->refcnt, 1);
 
 	return btf;
@@ -6362,6 +6503,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 		base_btf = vmlinux_btf;
 	}
 
+	btf_sort_by_name_kind(btf);
 	btf_verifier_env_free(env);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
-- 
2.34.1

