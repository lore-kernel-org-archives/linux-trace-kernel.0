Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03F2320A3F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792693; cv=none; b=jhrXeRQpeysdyKMOHmeZAERF4EKmGUxBRL8pEPB+0e+qF8dgogFQIOqYmIgN34MwTVru0Bl4GfIkvqrsVYKEEhHZllzHvVoF56sFGmSqZDkL3d+8sTNSUKtrGbP5RTwX5EuYHA+K9ByU0VSEMY3EvW/tkEA66gkC2OPioro3nC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792693; c=relaxed/simple;
	bh=hgEfzLMYGp8CwN/e9f7FjAIj6pt9xNamhCZCRYBRqQA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNgxfi00T9+XstsJRPDDQRPpbqsgxfQctnTCh4MbyrfbpGNbEgJNXHmRSNtvcTKa6cqgLYB7zMiNcaD6yrZ01Z+QJ7NU7LVD5W+ScUxz1xFaxt0IKLgCg3eCBZT4QYDDrUZPVmW5f3nGlqIyGyHLi1Qfuts5/+hXvV89eBrhPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTRPvRp+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTRPvRp+"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so2631901b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792691; x=1763397491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjEoXPNXhfVJUSFrtIZUZPOp73U+hEWiDpkQ2qC/SvQ=;
        b=WTRPvRp+nyHQ+BzVfs502SSQi3Rbgab5rfHcbvwAuza0fLAUFJ8Z/QoeFAF2sDrrFm
         9F2wZt/veLF0y+UnYcODjEBb9317RYByPySO6C4BKYlzlZxrUviSr4aQmxmTQMtysysZ
         yv5P96wGDrV4nTpCBKHuEVgWW1pnViQYZntJRcqnSz76rZAR9UbdYcIe/wtm/0qrlCIT
         B7WBYgY3KL9KbV88KUSfErHzpesQNOLB3zZ/lQN0uXS6BO/Rl6j55CwQjEDZT4i/od2L
         2cN0m1TyPHY4jSPSS9ABnj12kQXOADGSq6xFBWwvRiz/RT3NVKMtqYqd1+amA1KZz7W5
         1YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792691; x=1763397491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tjEoXPNXhfVJUSFrtIZUZPOp73U+hEWiDpkQ2qC/SvQ=;
        b=XBi4Wfzx1VWBbJvEGAWPV9Xhe3nmnA7vsNg0NU07PNih9aozx6oEUeGk/Or9WH2o5j
         KnAJDkzitIEEUPStJICAv0wGPSmqI5Y0/8MEUgauT1nGwiBOb9PBYguhV02LG6/VD4Lt
         y+dEgt0iFnZTnXvIhKdKZv36oJ9FWIGIyFGyMdILyLT31wtVcD9f5kxCjUBFVWFOY/7A
         Gchi00cS4ZwFZtZLgsNGdt6CRhbQxNiNEbG3CXYlNDMhH03e56QD4HR5l4mRaZTOg9H3
         gx7AyG6b1NkAjQTxa2kAk/VXzIbQxNyMlxzyakdKt/O4T3sdBTWPrrUykljE2+8WjQDq
         Y+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtUAszdFbEqgtku8O/kkYhel+uOm3yHHrjLU+g88sGeTTJaGYORM8IccblyVb2m3ttJf4lncypt6oySPE3ytxmHS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo+VKsJ1UEhkDx2DT2Qc309ohpuQJ+aSI54DXO7s3J+ium7tMH
	BdmLWY/BrGajDHcgwrFJoyM9751UpexaW/6UetVArH0jB+HaTJCVGLkA
X-Gm-Gg: ASbGncsVT4mlGgpfdsnO0jG9SE90fERGHyyzyRvOaMNxxy1ldq7uNHoq7TQfcjKtXbD
	kGE4xyMNVi/fuCzDkLPb5QNAckyVRjgqunkBUKJBzbD/d6Ar1CW0zh1BdHLQI7fPwr6BPI3tyAH
	gHUcZHqIASgXtHItGRnb7UOnQpmsNtC1BmfrpAEWuxM/VnkZQvygAMkyx8dIwcsXsOyl7QiVZxv
	OE5Vl/7KgluoKrLmdY9ts8ra6Jjby/lW/NUqLrT3HhC+i/qPs5BGqQr3viTi6uKgsxfXIEppLgT
	85RHj8bjfbs673PqkMx5hgmJcPVLRriJ+vN0yCBDwMRVPC7CqiPvS07nSswJJ/GyQXjCbpTXP7t
	z6Yim1r44ygCM0lV/FlO+SZFMouUIxw1JR2OkVOwEE7CqRMRcPbyEuxYTJTPfrKgU3sDTi6aR02
	hvKrLBthCja4U=
X-Google-Smtp-Source: AGHT+IGgGEjFRVaat56XCDxopiL8+SM4HXr1TFRgWsca/knmSVG340IyJkWxuGKU2hwaDE2EKORtXQ==
X-Received: by 2002:a17:903:244a:b0:25c:8745:4a58 with SMTP id d9443c01a7336-297e53f933cmr112300665ad.3.1762792690825;
        Mon, 10 Nov 2025 08:38:10 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d0aee149sm8572006a91.1.2025.11.10.08.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:38:10 -0800 (PST)
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
Subject: [PATCH v8 20/27] mm/ksw: add self-debug helpers
Date: Tue, 11 Nov 2025 00:36:15 +0800
Message-ID: <20251110163634.3686676-21-wangjinchao600@gmail.com>
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

Provide two debug helpers:

- ksw_watch_show(): print the current watch target address and length.
- ksw_watch_fire(): intentionally trigger the watchpoint immediately
  by writing to the watched address, useful for testing HWBP behavior.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/kstackwatch.h |  2 ++
 mm/kstackwatch/watch.c      | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/kstackwatch.h b/include/linux/kstackwatch.h
index ce3882acc5dc..6daded932ba6 100644
--- a/include/linux/kstackwatch.h
+++ b/include/linux/kstackwatch.h
@@ -60,5 +60,7 @@ void ksw_watch_exit(void);
 int ksw_watch_get(struct ksw_watchpoint **out_wp);
 int ksw_watch_on(struct ksw_watchpoint *wp, ulong watch_addr, u16 watch_len);
 int ksw_watch_off(struct ksw_watchpoint *wp);
+void ksw_watch_show(void);
+void ksw_watch_fire(void);
 
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index c2aa912bf4c4..a298c31848a2 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -273,3 +273,37 @@ void ksw_watch_exit(void)
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

