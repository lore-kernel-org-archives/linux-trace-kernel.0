Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CB279DAD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792646; cv=none; b=sJQlPPDRM7lCUwWBvsN74EwuNdL5CjVrRSDhuxZOkGxzABh63oc9OAEoepyAQayZ97Oi0uDBedbqxFrjseneP+f7l7A5x0zv6DwouoEV7GF2qhEvpnhOypVztWYwI8UXa82zbZt9X5F4yoOUGF6ICPbVmIL2PYPjiUJqqiJEhbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792646; c=relaxed/simple;
	bh=JF6+F5+AYlPr3XZARG3RggWEKB5pA9Os5BWchj7XHxM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzR1BFxKxV24rxwv6FE3gRahCBEivE1VK05gSS0m672S6kRbfVPa7D18jhHB7n9xlYaCZdw/tJdj+HamhHFHjp2j0WKkWuwHJjP57dhclizssSruXj52T7Xu5smGjinPKZVFE1eORIq0ZblpDEanJqOColbj2kqWp0rfBSNJhfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0wF0nWt; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0wF0nWt"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b0246b27b2so3410243b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792637; x=1763397437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xci1h+5LLX8h0ueKKgEGcPTmlGP88Cc5ZUWnC1Z7B10=;
        b=k0wF0nWtM//Sd97/ySB2HxCf4+leQEnK3IH6FZZ+gLR7io5I3SZF4VgPexqCNW4DG6
         dxTnzIQQzD90r2k4IHjzPeFk+iPmKwkJkTefqJ+eFU07kF24Ybkv1HycBwYx+U5IjPUg
         cOnq4KQTms5RX0TbgKmXf2hcRWw6TkhUofLLIW0WO++Vp48kI9A6YJ4nnYvaOEml/llu
         QVrfeExL0j2s1h8BXZs9jW3MQqfq9yYhGYOVkWYI54J/KROsvea1N0f4KDF+jsAQSwML
         LFvOhzZ1EMToks84N1QMUpj5a9+DXD3LqgQJ+ChgGalO1yrO9Rz1ZejO1LaRJlxMVkUD
         gA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792637; x=1763397437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xci1h+5LLX8h0ueKKgEGcPTmlGP88Cc5ZUWnC1Z7B10=;
        b=pREvCiW/PnCYk8E7SET9tjmwfrZHo0YOxt0dHQFu6QfPxZQy174q7chHNQFtFVQr2u
         C/zjom0rWzu5NyfCpN5RxBfmryiRDIVWFHiY/GiHPPhhGcYsLG/LJWUb15Q1ZmjvrxVE
         rPhEnj19pG7RKcNmRObkyU18dqKs3Hk/BzqeX9VXFfnfm42x59sVFSxhPKb7mcFLIXx5
         1r3dxw7w/anlDfElb9Er7pVpXlMv73Fcdoe/JfKuyzrE2++2rgPmtxD9kW4uX2qF3ARh
         kXAGCSBpbz0w7EwTA1ipkNCeYqEP0tvWkO2j4MdRA7ftYTU+wjGtKAREWHIzfM1a3c5P
         qnEw==
X-Forwarded-Encrypted: i=1; AJvYcCUs4HHYf/LVklKdnNKgTlfOK1DOeIq9TjiTDLaryYVa6h+mf/llqki2/UH9f47qxw5IDoo9VpRkirhKCTN62X4qnKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyffxgtnHWl2htiGzxkZCXHb2BLnxoM3io+ajypbQ6mU9Q0nxO5
	NDgzNRCArepc96ujzsj+D7C+l9MCT/hfScDKpYppqgN+a/yL6xCklUjm
X-Gm-Gg: ASbGncuZBucqG1VCdw45K5E/k8/W34s+UmElb45Yax+SBO5mJdIgQOSZYr/gGpOo7uS
	rtitEbLe3b9eqNADcc0wCizaFnLmrLhJtUkcNY0+BZFDTWeuiJMWJMi8q6nUBaXDgrDEw8daU+p
	0zPhKv9p1Pyw7Cx3uLh7ot3P93PLn59JRK4siZbW6IXOkY/yNNFVvKF8zEC7VPE+o3cxLrGyHYC
	KBKnBxvnKWRdlPQ4QLpvYaNbB48wTVEO5B6LEaX0zjdGWnnKLlpI3bNbc+k39uZPJmjBly2Sujn
	J8yo/jyyQvMVZtQQnBjMT1gK+yI0kE5kn68f5ZSFGALScU7sJ3TQijZRyCqGWG296xwhKQ2I0S7
	IdXrt1p/neMJ/WhiSeFmT1iXXzCRl5l9bYttNEpCIYjag5bGEbkHHDBSuUTCAJjEZag5ybN1Mfs
	pJjVyeztPM5DEZTw9VJYJT+xkzmyXeT++n
X-Google-Smtp-Source: AGHT+IEGWB34N8M9pAG46FEM6eUFu44tr8SQ44nAFlldnOd0ujaAQ7y38dVr1Lx0wQIkS529Z8I+TQ==
X-Received: by 2002:a17:903:1a44:b0:298:68e:4057 with SMTP id d9443c01a7336-298068e42a0mr86330195ad.59.1762792636805;
        Mon, 10 Nov 2025 08:37:16 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba901e312a2sm13029584a12.31.2025.11.10.08.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:37:16 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	David Kaplan <david.kaplan@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Rong Xu <xur@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	workflows@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v8 08/27] mm/ksw: Add atomic watchpoint management api
Date: Tue, 11 Nov 2025 00:36:03 +0800
Message-ID: <20251110163634.3686676-9-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110163634.3686676-1-wangjinchao600@gmail.com>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add three functions for atomic lifecycle management of watchpoints:
- ksw_watch_get(): Acquires a watchpoint from a llist.
- ksw_watch_on(): Enables the watchpoint on all online CPUs.
- ksw_watch_off(): Disables the watchpoint and returns it to the llist.

For cross-CPU synchronization, updates are propagated using direct
modification on the local CPU and asynchronous IPIs for remote CPUs.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/kstackwatch.h |  4 ++
 mm/kstackwatch/watch.c      | 85 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/include/linux/kstackwatch.h b/include/linux/kstackwatch.h
index eb9f2b4f2109..d7ea89c8c6af 100644
--- a/include/linux/kstackwatch.h
+++ b/include/linux/kstackwatch.h
@@ -44,11 +44,15 @@ const struct ksw_config *ksw_get_config(void);
 /* watch management */
 struct ksw_watchpoint {
 	struct perf_event *__percpu *event;
+	call_single_data_t __percpu *csd;
 	struct perf_event_attr attr;
 	struct llist_node node; // for atomic watch_on and off
 	struct list_head list; // for cpu online and offline
 };
 int ksw_watch_init(void);
 void ksw_watch_exit(void);
+int ksw_watch_get(struct ksw_watchpoint **out_wp);
+int ksw_watch_on(struct ksw_watchpoint *wp, ulong watch_addr, u16 watch_len);
+int ksw_watch_off(struct ksw_watchpoint *wp);
 
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index 4947eac32c61..3817a172dc25 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -27,11 +27,83 @@ static void ksw_watch_handler(struct perf_event *bp,
 		panic("Stack corruption detected");
 }
 
+static void ksw_watch_on_local_cpu(void *info)
+{
+	struct ksw_watchpoint *wp = info;
+	struct perf_event *bp;
+	ulong flags;
+	int cpu;
+	int ret;
+
+	local_irq_save(flags);
+	cpu = raw_smp_processor_id();
+	bp = per_cpu(*wp->event, cpu);
+	if (!bp) {
+		local_irq_restore(flags);
+		return;
+	}
+
+	ret = modify_wide_hw_breakpoint_local(bp, &wp->attr);
+	local_irq_restore(flags);
+	WARN(ret, "fail to reinstall HWBP on CPU%d ret %d", cpu, ret);
+}
+
+static void ksw_watch_update(struct ksw_watchpoint *wp, ulong addr, u16 len)
+{
+	call_single_data_t *csd;
+	int cur_cpu;
+	int cpu;
+
+	wp->attr.bp_addr = addr;
+	wp->attr.bp_len = len;
+
+	cur_cpu = raw_smp_processor_id();
+	for_each_online_cpu(cpu) {
+		/* remote cpu first */
+		if (cpu == cur_cpu)
+			continue;
+		csd = per_cpu_ptr(wp->csd, cpu);
+		smp_call_function_single_async(cpu, csd);
+	}
+	ksw_watch_on_local_cpu(wp);
+}
+
+int ksw_watch_get(struct ksw_watchpoint **out_wp)
+{
+	struct ksw_watchpoint *wp;
+	struct llist_node *node;
+
+	node = llist_del_first(&free_wp_list);
+	if (!node)
+		return -EBUSY;
+
+	wp = llist_entry(node, struct ksw_watchpoint, node);
+	WARN_ON_ONCE(wp->attr.bp_addr != (u64)&holder);
+
+	*out_wp = wp;
+	return 0;
+}
+int ksw_watch_on(struct ksw_watchpoint *wp, ulong watch_addr, u16 watch_len)
+{
+	ksw_watch_update(wp, watch_addr, watch_len);
+	return 0;
+}
+
+int ksw_watch_off(struct ksw_watchpoint *wp)
+{
+	WARN_ON_ONCE(wp->attr.bp_addr == (u64)&holder);
+	ksw_watch_update(wp, (ulong)&holder, sizeof(ulong));
+	llist_add(&wp->node, &free_wp_list);
+	return 0;
+}
+
 static int ksw_watch_alloc(void)
 {
 	int max_watch = ksw_get_config()->max_watch;
 	struct ksw_watchpoint *wp;
+	call_single_data_t *csd;
 	int success = 0;
+	int cpu;
 	int ret;
 
 	init_llist_head(&free_wp_list);
@@ -41,6 +113,16 @@ static int ksw_watch_alloc(void)
 		wp = kzalloc(sizeof(*wp), GFP_KERNEL);
 		if (!wp)
 			return success > 0 ? success : -EINVAL;
+		wp->csd = alloc_percpu(call_single_data_t);
+		if (!wp->csd) {
+			kfree(wp);
+			return success > 0 ? success : -EINVAL;
+		}
+
+		for_each_possible_cpu(cpu) {
+			csd = per_cpu_ptr(wp->csd, cpu);
+			INIT_CSD(csd, ksw_watch_on_local_cpu, wp);
+		}
 
 		hw_breakpoint_init(&wp->attr);
 		wp->attr.bp_addr = (ulong)&holder;
@@ -50,6 +132,7 @@ static int ksw_watch_alloc(void)
 							ksw_watch_handler, wp);
 		if (IS_ERR((void *)wp->event)) {
 			ret = PTR_ERR((void *)wp->event);
+			free_percpu(wp->csd);
 			kfree(wp);
 			return success > 0 ? success : ret;
 		}
@@ -71,6 +154,7 @@ static void ksw_watch_free(void)
 	list_for_each_entry_safe(wp, tmp, &all_wp_list, list) {
 		list_del(&wp->list);
 		unregister_wide_hw_breakpoint(wp->event);
+		free_percpu(wp->csd);
 		kfree(wp);
 	}
 	mutex_unlock(&all_wp_mutex);
@@ -84,7 +168,6 @@ int ksw_watch_init(void)
 	if (ret <= 0)
 		return -EBUSY;
 
-
 	return 0;
 }
 
-- 
2.43.0

