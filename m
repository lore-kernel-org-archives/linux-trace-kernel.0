Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FE0301027
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758715218; cv=none; b=WvXqwbrBWQqSDuM1kPeiXdPm1xaPtiD7gsQ+j5/QMkVHOLTublRsPl1795d4c1gTMmZkc43DRKizrWPl8C+d6KsiWf6ei6/3j3/7aM3UwXLPR1VWHHS3QnMf8TBwXxvzuCrXJKKj2/QTJ8KIR3P4U8DJnyHJsJrfV+BWoaLn1w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758715218; c=relaxed/simple;
	bh=zgbvGJBSx4YBKNkqO/qzz/La9XfnZ3vAatfFaQMoL7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTYUqmQWeE5Rhnk5j3ervnLBFML1G4XeXCeE8NIR78cHLQ29KETqILZPs106IRRj637gyxIzXDiMNtrqNo30qZ3RcTm8XuDDIFE0SC5BXBB/wQONQ0ylQs8RZb0Pb5NS/ngX15tkkW7OPjAqUQfqHiIFVpB1tCb7VEC4NbcMD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fW0ETLeQ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fW0ETLeQ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b551350adfaso5507911a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758715215; x=1759320015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmaGbmiuxIsK0xKTEWJ/f7gfwC2bw8p0SOLh4b9Z4FY=;
        b=fW0ETLeQCFX8OFWb9u250UoVfhDWanBM+gtDWVOLh0/w6XBqCDew2W0/fZkeJNJiZ1
         qMORdyFC2XLNKCYNu4P08Y3EanKlp0FmAiHO0HMpwTd7b/DEMCez4DK/ABIXfF/P81mZ
         np1yGnCd4gD37MIK/3v2bFzRIJz5oKLP5Y4PaxKtE5ctLPwRVByKYVJq53tCe8tb2ffL
         oyYfuzw7BkjT1g4t8DfbYfn2/AJyt1Rwl3ls6piKNdQSaRnZ6gKunmEeh2bohr8NZOkH
         b+sESF4Zql4iaDXIVvlXDxsrmaWTvU2jgUQ5MQqJQod0P9Hpapj/VJbBWnQzlveryClN
         43ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758715215; x=1759320015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmaGbmiuxIsK0xKTEWJ/f7gfwC2bw8p0SOLh4b9Z4FY=;
        b=qX9MP+FooeMqwvRY7s3dTRO8gML/CG+txEg4QcoRBtTWv8P9EZK8pFuQp1EHkFYvFF
         8k1C6aQqAQQ3GndNyCDu+dw1Z8XiRGxzE65Bczg4glfnvMQLdLUHAaelhp+axAD5ACSE
         aGchI3spHezP1zqub9q/t0j1lrgYKlF9i47yIxw1k2USEyT1x6+f+XYqgS6vRPMQvWTY
         lI7ayTXdc/IA2vxmckmCLXtzDyon/mBMEGOnvfWCpjU6jm4w1883/uobbTdcp2oFexuQ
         /ovntZ7iucGKii/w+PZEZHIacqyNGniFUr+NMLgkPlBEIrYXb6W24sHtYMTGo3+qXRig
         1d8g==
X-Forwarded-Encrypted: i=1; AJvYcCVKvlgg86nUIMW16yfaNAjKj3oZqeX/jaJCBkcEPnkiNXwRrDbZJ8er7lUJB00yNijSf4PYhW1bLSGyRCvMWYP4W9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3CyTYhVK7AbyPlEhtA6/x9xnAKGZM815M2cF1fyZXMgqbyeku
	UOTHUg6GLQRlBqAlxdhhp/T41LStDfCh3G1S+cM9K3tvgGdPfLatz2j/
X-Gm-Gg: ASbGncuPfX6sk4Rma9wwZDgyR0bem68YsbJa5LE0ufczP8K4HwZPt3bKeZg/tTY5HPH
	bw117UMXqbwNcuuPIiJpXCAXH9VBMEflcoIOojhZMGwb0vd3lQABEUtXWGW+1jnQXGvhRcf6F0Q
	QYCX1dw1yG1+yLm9gOeurUeWx/L95XeubqX0sludHRd+tyVWAJn6z2DSR4ESigU6yHxeNDjJfg9
	JXYcZsihCv9XrebSHxUA1i7I2H51I0K2szkgw25qxq7VyQWcPOy5Kpq8dTEg5QbX7beltnRyIls
	15Fg51skn/OLT3lZWnMHf0WnzuNKn2Ie9QV7fHyKV/dbvm9BR6KP7/4BzIY++SoEqUmUDRT2M2R
	HmPi13kV5nJalSEycUxxEeaI=
X-Google-Smtp-Source: AGHT+IG5AidgxW/pjwMRKvZXF7BqnVmuGXBXEakixJFL1V8tNMywu8qGgSCIq0aUezqYi7cmWgbNjA==
X-Received: by 2002:a17:903:2450:b0:268:f83a:835a with SMTP id d9443c01a7336-27cc9a91248mr60312585ad.60.1758715214591;
        Wed, 24 Sep 2025 05:00:14 -0700 (PDT)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de5dbsm189402185ad.84.2025.09.24.05.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:00:13 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
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
Subject: [PATCH v5 16/23] mm/ksw: add self-debug helpers
Date: Wed, 24 Sep 2025 19:59:22 +0800
Message-ID: <20250924115931.197077-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924115124.194940-1-wangjinchao600@gmail.com>
References: <20250924115124.194940-1-wangjinchao600@gmail.com>
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

