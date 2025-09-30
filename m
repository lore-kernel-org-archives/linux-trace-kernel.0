Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BDC261B95
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200345; cv=none; b=s7ITPGmQGYudVYECDL4KusTlZ4YWdUHd25ZnVEPEVk1fD9vtp0oBjWj6OmDaQVnY6UI3cZYT8zmGGHa0kPlCQZCG1bgOrTRaIvEtk3YvrdjaJB9222imvSoE2cJ5nsG39gkE7W/qsyQLjqrPZmcJQ76rUtzgiymfjkwG8NZ1gDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200345; c=relaxed/simple;
	bh=zgbvGJBSx4YBKNkqO/qzz/La9XfnZ3vAatfFaQMoL7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKdNsqg47ShV4CwLDIzxU9vZWW1F+nYJIGEIfSrSQD4T3shVx4b3hyz1lNGIdR9102urJEMQUzqhJlCBWSpMlBlC4pRix9ngXpGvxtMbUcDCKtNeE4Wkl9qyC/FNrFr7nG1qFIy5DuxGf4C323wIopNBfUuQ+/oHq6UNXCAMKFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKJOEc+9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKJOEc+9"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781997d195aso1892821b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200341; x=1759805141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmaGbmiuxIsK0xKTEWJ/f7gfwC2bw8p0SOLh4b9Z4FY=;
        b=VKJOEc+94AKnpJiVOpWnQ6DKSsWX1R1XbyHo5/r/AG6aDGAWk9wPLSshoMM+livdS+
         MyEuw5bGfLyFLEN+CymB1AYeyMGWWzvzslOuckXZNL+LkSjQP5bzS2nXeQjKnytOTkYn
         I3znRL92dI+MXIBc0Fotj3NpYAr6hAMRbuIxDzLO9p6jaZ0voXC2/ADIbtgpiE45AqYk
         6KiAb/IiOHKoiHWF38rhEnx8s7VaaJkf9vC+I5pJNvNIGogQNziLULRwmmnUmEFUMU9c
         FfGiRCJb+mhy38xk1bCLHPsMgriXv6C+zhRwB5OmgZb8gtGClZpvwOrAEAqybrDgc9kW
         ouvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200341; x=1759805141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmaGbmiuxIsK0xKTEWJ/f7gfwC2bw8p0SOLh4b9Z4FY=;
        b=prKDJx/Z+zPGvh2mPlADrp33vbZUfKNQ+5fpnoZUXPynIjJp7EEIjJ2WQCsOwbCyU3
         lhdlzNjJfiJA8tMfWvVZL+7ML85Lud4oIX7ceGxTKhvMNgSW0MTND/U2gZ0owZ9Qk0Vv
         nmHTDfpyRSuFf4AliuzM6KjTxELU+TWu++ue+IlgUw9G9x5whwEFulgcJshoDTVyIk32
         PJUe4gKJcAYi7R4RwPd9vr6SyGZhYEpjiEvkRTs/3H0YRYfjWevOmBg5Y0T47GZrtlTi
         veFQKy2B65jn53FjpFEqe2ypRhekIiezqfOXY1vsxQ1lFfaj3YpZRZqZ/qAmhMYpq99P
         Lpnw==
X-Forwarded-Encrypted: i=1; AJvYcCWia+DxE3wTwBcBykDCXpVVdrMToFV5l79ViNdZzdIIa6znGgz0iLuXH9ly1SETD3tgLu6pXKpECRbeVZiQNwEaxek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvUKmIE/WZHgzz4wbF242FzDMzxse6RTw/Wb2mFv0cXMJgLHVU
	Z1MHcsYhDQDF7GgrDJ4fgN2fVk4o2RsJ3aRXfCNy1yJdwxLE7kqMtckQ
X-Gm-Gg: ASbGncvvpk0VGxKo/qKyamXwdZKeIlGEl4QthBof6/3Nn5Yt4vuwIBjXRTwyfHhuq7P
	/vu6O0eabszP0GamWElIbCa83/OJ6EfjkL1wczUgWH6IMYrfbI4gULEapFNY7azD1kZfPgZxK56
	vFfONamrEilIrXqN9rVR3Z40vBLQ0PnlvrIaC9/oiSZK8cS26J5NibTFAB0Pvizo0PCeq2ABTrs
	9cYyRBscJR/xrj+DPnSzIhO1NkEDTD2fuQUNMHa6CwvGK/61ky90SuCG77lM5jsbE4lvqrZ069N
	75O/sAkC4ZjwFKzIPsysXyaBgEgfLlUFaXdc+os3wWhH62eG0EpgZPvP0Q9jVWyeEQkTssd3RdH
	s5DXeoWDitX26qT+TSjCHByCDCn881Po4riBRRiwlmODdF7ex8IocIXZgnJhKJ1S+WaLO/oIYVS
	mM
X-Google-Smtp-Source: AGHT+IE0ZzT2Ls3FLJQKvDsDE35NvUvpfAF/CKszp2PRAknfZulRv/lUTsOjo2MTaS5CdAlTIrrq4A==
X-Received: by 2002:a05:6a00:26ed:b0:781:2ba:ef14 with SMTP id d2e1a72fcca58-78102baf1e4mr14490364b3a.25.1759200341230;
        Mon, 29 Sep 2025 19:45:41 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b64cc6sm12378142b3a.71.2025.09.29.19.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:45:40 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v6 16/23] mm/ksw: add self-debug helpers
Date: Tue, 30 Sep 2025 10:43:37 +0800
Message-ID: <20250930024402.1043776-17-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930024402.1043776-1-wangjinchao600@gmail.com>
References: <20250930024402.1043776-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide two debug helpers:

- ksw_watch_show(): print the current watch target address and length.
- ksw_watch_fire(): intentionally trigger the watchpoint immediately
  by writing to the watched address, useful for testing HWBP behavior.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  2 ++
 mm/kstackwatch/watch.c       | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 4045890e5652..528001534047 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -52,5 +52,7 @@ void ksw_watch_exit(void);
 int ksw_watch_get(struct ksw_watchpoint **out_wp);
 int ksw_watch_on(struct ksw_watchpoint *wp, ulong watch_addr, u16 watch_len);
 int ksw_watch_off(struct ksw_watchpoint *wp);
+void ksw_watch_show(void);
+void ksw_watch_fire(void);
 
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index f32b1e46168c..9837d6873d92 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -269,3 +269,37 @@ void ksw_watch_exit(void)
 {
 	ksw_watch_free();
 }
+
+/* self debug function */
+void ksw_watch_show(void)
+{
+	struct ksw_watchpoint *wp = current->ksw_ctx.wp;
+
+	if (!wp) {
+		pr_info("nothing to show\n");
+		return;
+	}
+
+	pr_info("watch target bp_addr: 0x%llx len:%llu\n", wp->attr.bp_addr,
+		wp->attr.bp_len);
+}
+EXPORT_SYMBOL_GPL(ksw_watch_show);
+
+/* self debug function */
+void ksw_watch_fire(void)
+{
+	struct ksw_watchpoint *wp;
+	char *ptr;
+
+	wp = current->ksw_ctx.wp;
+
+	if (!wp) {
+		pr_info("nothing to fire\n");
+		return;
+	}
+
+	ptr = (char *)wp->attr.bp_addr;
+	pr_warn("watch triggered immediately\n");
+	*ptr = 0x42; // This should trigger immediately for any bp_len
+}
+EXPORT_SYMBOL_GPL(ksw_watch_fire);
-- 
2.43.0

