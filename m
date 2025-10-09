Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A52E0B59
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007474; cv=none; b=Mtpm6prUN8o0Sc3k+P2N9VePzLvjBztf3vPMkPQ05HkLwXc8to301EqxGgQbvoD7aRr/pIoym2Z2X4GU0X70hQe8a3bB/7r/Y00s0Ap4frvoSD1Z38JxDAvcPhHoGCaL/s8mBVBi+aJjarUuUspVOysv9oGfrs/qesQF1pwiYS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007474; c=relaxed/simple;
	bh=zK4RWkz30MU/OH8jEOTvGZJj2/7wnecqVuCjoc5/aOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJHSLhd9YbHrYesQf5aOjm/TSrJgDvPtBHURRtihr2v3Nbx5I9B2d3xZ/dQ2Z/9bpUmYUOGkQAoOdfY1UCPI+JPZJ0Y8cazhjEs7OPCuiMNOvjAUk0GaMvpq9x0KwyPCtEoW+qtoVNerwC7SABv1GVrDu0MRD2GY4twONgVb9K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUQKyRWS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUQKyRWS"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so792814a91.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007471; x=1760612271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPor1AiTaHON3BhVq+NCy46wTls72eqNmMOTROEZDIU=;
        b=OUQKyRWS4NogfY8BKn70Mh5zqkNfWaMf1ej46t3EeqmhIzH77wL3IrQoFcmsSnNt8T
         oiJf7v6AZzNxPpoZ9mOwkWbowmLLclVGMWt+yqVfDwiTTeJ5M4GlRqfXof8NWTVMwoDm
         1s3uXUTMLqyoKoCtjiocVkkszgMND+F9C38eoorWaZZuRGfJ9gR1a9B3dth8Fsx+RFo3
         XOxOaROnb5dDAQZBhJzWSXPAyV9j5gThTCUjg8ajdpyL3bMf4a8daEOamlzNMBGBN7Ca
         HIT4pHppqIROfYf2ua2k+b6fhhBg1OwSrYmJTaP6rkgM/8Ivw1onylWTQnfrmRRNwbHe
         /ZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007471; x=1760612271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPor1AiTaHON3BhVq+NCy46wTls72eqNmMOTROEZDIU=;
        b=E+MhTOXj4Ji57tIlvvBnmCuFqLYHxL1AvqTeJ1GBESVZYw4Q7V7zuxCDwGxX+5hkn6
         dfcoW6dqOElNlHWv0hX0K918sUqnltLq5+W8uSk5mB410tcH/UO1i2JLFFnu/XCYrb1k
         Ph58h2YaAeuX+8bDchogrmchxufG6x7T5d/QUiw7jzzcy1l1ftAzAVqU8LGMB0jlX8qF
         k0wt9QmTid6xE08L830VurgsH/+e3JJg0wEJF/iW1RyUez5KCOdL5BUaPZwVoN+1mpnU
         rcgi9sP49SikG1P4WEdZgeWENAiTrdvqt3/02ivR4qgwAZh3teWa+th6bvgPcH2r/TIb
         a8iA==
X-Forwarded-Encrypted: i=1; AJvYcCVt/4SQX8sXXgVrcjrkWAV7/otbM9n+m1wmiaOhEH9FH0634TWmmsGRhBfuwn/goWkl2RXuhTTF2ICrWan0o0p/ows=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFB3SWP8lQmbDuqHs2eUL/vW9CbYyRihL/dgTCQvaaWiZVjwaH
	yK1qTSaJ4B2UEO6oGDdYghhjhYbsyLMBjpHc7y7zp/5nb8Ur9XJ04lq/
X-Gm-Gg: ASbGncts50c/hc3gfcr2Hr77LxIEDpIJIHqHCFXOwnD5qxrDMSFluwADrhd7B73yhTS
	WrP+Hqmt0EalilrPNNgA79y+nrerFNKpEmwD2MT/JcIcegLMSB0Miv0jr3DnEPxAZW4eu++S1/1
	/F3TK3Q1XFKFYDaE292zigo5k4+P2aqxg1PX18cfXfocLa1YACeAlS7v2NJHoP7d9YAWHqUUdvC
	VcPlPcPJhaeUs3hkj2N0dimOlnAZFS5jQlA571ivhwvG4Zmk7nzTZ12emlgZ0iZ/KaqIRb0JiWS
	JHALeae2vLXIcq4Njnvm5dlTL8K/1NtCIDEryEphLQFfetCYxdFsxUYvluI6oPQlQAQQltaP44t
	VPOf1YdC0zKMA09uDucIWQim+dBujzd921LoZxtXjbB4rhdOJZQP9nsqyDl5R
X-Google-Smtp-Source: AGHT+IGfoiP7FyJn6BgVbF1cW+pirt064OXDV5hiE6L+A4G5ft0+AYVVqaDAH6C+gBiZsXo7qM0L8w==
X-Received: by 2002:a17:90b:3ec1:b0:335:2823:3683 with SMTP id 98e67ed59e1d1-33b5111491amr9148774a91.9.1760007470702;
        Thu, 09 Oct 2025 03:57:50 -0700 (PDT)
Received: from localhost ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b513926fesm6702757a91.21.2025.10.09.03.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:57:50 -0700 (PDT)
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
Subject: [PATCH v7 11/23] sched: add per-task context
Date: Thu,  9 Oct 2025 18:55:47 +0800
Message-ID: <20251009105650.168917-12-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009105650.168917-1-wangjinchao600@gmail.com>
References: <20251009105650.168917-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce struct ksw_ctx to enable lockless per-task state
tracking. This is required because KStackWatch operates in NMI context
(via kprobe handler) where traditional locking is unsafe.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/kstackwatch_types.h | 14 ++++++++++++++
 include/linux/sched.h             |  5 +++++
 2 files changed, 19 insertions(+)
 create mode 100644 include/linux/kstackwatch_types.h

diff --git a/include/linux/kstackwatch_types.h b/include/linux/kstackwatch_types.h
new file mode 100644
index 000000000000..2b515c06a918
--- /dev/null
+++ b/include/linux/kstackwatch_types.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KSTACK_WATCH_TYPES_H
+#define _LINUX_KSTACK_WATCH_TYPES_H
+#include <linux/types.h>
+
+struct ksw_watchpoint;
+struct ksw_ctx {
+	struct ksw_watchpoint *wp;
+	ulong sp;
+	u16 depth;
+	u16 generation;
+};
+
+#endif /* _LINUX_KSTACK_WATCH_TYPES_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index cbb7340c5866..707b34f26264 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -22,6 +22,7 @@
 #include <linux/sem_types.h>
 #include <linux/shm.h>
 #include <linux/kmsan_types.h>
+#include <linux/kstackwatch_types.h>
 #include <linux/mutex_types.h>
 #include <linux/plist_types.h>
 #include <linux/hrtimer_types.h>
@@ -1487,6 +1488,10 @@ struct task_struct {
 	struct kmsan_ctx		kmsan_ctx;
 #endif
 
+#if IS_ENABLED(CONFIG_KSTACK_WATCH)
+	struct ksw_ctx		ksw_ctx;
+#endif
+
 #if IS_ENABLED(CONFIG_KUNIT)
 	struct kunit			*kunit_test;
 #endif
-- 
2.43.0

