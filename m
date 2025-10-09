Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47162E0B5F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007447; cv=none; b=XWNdvbLBFNQ3ndoy/PTTimnY9sP5mU9uBeIBuk2BGDThUl4rxdMGBk/lnX7W5zntkrB8FvuK9wQQgnO9jiX0XTWShHRhqYbHdwFdWF3lW/K7eq2dG7lIaMpa0R3HuTA3UVZQrUqhvBIAQhlDiqTDzN0Zp+xC8v4ghM8+4JaUVXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007447; c=relaxed/simple;
	bh=Do3nnjeUWGWoTOUsDG3S1B+MUUsKTfHEQU/uiqiZ99Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPoKRZhXFVI1mZv4EMD9ccjQO7QzTuQ8RTZbnvKYnex5ug3Duie7xgtyn9jU7zdTqEZtjDnMYTO9nw4X/jCewaoEQe8kN8USR2L3vzme2fwLHAJwmaUiCzgNOfm3dh7jIIuGysRrr+E6TBrfbZDQhq9MtvX2+eEwd5aCiYBtWWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+xF2JDZ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+xF2JDZ"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b62fcddfa21so544781a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007443; x=1760612243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIQpLOg8aMQquhlHBEOSk3mXNexjDr9DRSMTRRGj0hA=;
        b=K+xF2JDZqmN029K8yvAViYFeaZp78RAJNvwyWVErHepIxGIU/8oNZMYPgpQ8Dlb/h2
         ujIAEl+0IdhqTB2LsAzP4PNKrhV/Fl2by8k+2O2+bxOQTw3+yWIeEpYBnxrGSCq6pv07
         xa98GJHD85WGnob1tltKlu83Hm6sqi6uHrQzjs1SLkvEKwD3uHjW6MEHtSqQ/2x9W1Iy
         8DjoGO65dQLRuyE+P1ARfIIUvp7JF9hJCFVYF1sP2oEzdBxyaTnUYslX9oU6bWn5ANeX
         RheP+AF7ss2kuTKTuqc/KlHJBboFmgTkeCaCDmNoaR2anQGZZB7pnyh+uwFMc+eMwX2q
         LXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007443; x=1760612243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIQpLOg8aMQquhlHBEOSk3mXNexjDr9DRSMTRRGj0hA=;
        b=GgIWE5UJeOpMtubUHuNDr9GckiT3kQP1lz7zDHqq6QvmlW3quQKZEfXQ8dlMH/kdwe
         zTVtHlEW/Kk/TMYbaBx8UVhJWUO1/JhKKe54ftXh1vf/uac6FJKte0JdgygYuP5L2trZ
         Cs9VFWcGQ185FVgAmIirV899cyMFbfakkiiH2YYkOUh9zqJGte0kAtFYeKwf8YJ5q9XI
         0ZJqKOKEkGElV5sFmvKScVIwY+wtIRNR4tiZPrTN9bsbjQccHVBo48BdPiDmSWkyftyC
         rvIDtWr8xviGFR+eXQWPwdv1Y+arQZmP2IT+sIhUfDz9kvEj0y1v73I3IdtNhA8CGWGb
         kuSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU577TSbut+fAGLLIHT9FTFbkgfRXLgoCEqcF66GfdLjS7R8d9mA2XJwa0CXciyEF7Hv+2WTG1Br7RZAqnlqUxzqSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2SpzUZf9xht5WV+dAj7Z1ezWdNJK0LUN/Q7fZsuySiP1pxn1m
	C3vKUfZNsG/9QTrCqlaHtKIaje7nI/QP2AnhJxmwB50Xdtp6320DSPuV
X-Gm-Gg: ASbGncs+/UsV+u1+V5iVk8wSkCSNcKWymS+i6s0kqjeM9XPEttIC+8g0gi741/J0ycT
	ufxxqxmO03jVvIgJyUPzivXlW5E/Tciz0yXUVcAJfsBR9Ip4UeV8KtszlKs+7yfHB71WdTLx+1v
	hyZqoYgmqxggP4l9VY6iQT6KcY8w9YTzU0JYCyhJqMmEbGRgaaHFN/mw+wv47Gq2QzlQPOfwh6C
	t8jgSxDYTmdoKb010cN7l5iIbqqH2BGc9L09gJCh3wQUGpSLBeKhYL8EcvgvSvM7erHqPRNWI41
	jvPWaWn1kSG8uH8MN94tFwGlB64L/t9QLLa68/cUFHGkT42f+50AIjTa990geEZbMo4FgON+LY7
	wH7Llx/RJO2CnmoUga/CS5met+jP1xeblAe4zMhlb9qRBWH7NeVvtiN5Ix0Bf
X-Google-Smtp-Source: AGHT+IHPDBs2nQEEtOyd+SrR9P+qllZOyEoDd+ZmfNYqYrv5SYPcJPc74F2vXkjnYFPY0AXGIsqkQg==
X-Received: by 2002:a17:903:9cb:b0:267:c984:8d9f with SMTP id d9443c01a7336-29027266982mr95235515ad.24.1760007443143;
        Thu, 09 Oct 2025 03:57:23 -0700 (PDT)
Received: from localhost ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b511135a3sm6722720a91.11.2025.10.09.03.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:57:22 -0700 (PDT)
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
Subject: [PATCH v7 04/23] mm/ksw: add build system support
Date: Thu,  9 Oct 2025 18:55:40 +0800
Message-ID: <20251009105650.168917-5-wangjinchao600@gmail.com>
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

Add Kconfig and Makefile infrastructure.

The implementation is located under `mm/kstackwatch/`.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/Kconfig.debug             |  8 ++++++++
 mm/Makefile                  |  1 +
 mm/kstackwatch/Makefile      |  2 ++
 mm/kstackwatch/kernel.c      | 23 +++++++++++++++++++++++
 mm/kstackwatch/kstackwatch.h |  5 +++++
 mm/kstackwatch/stack.c       |  1 +
 mm/kstackwatch/watch.c       |  1 +
 7 files changed, 41 insertions(+)
 create mode 100644 mm/kstackwatch/Makefile
 create mode 100644 mm/kstackwatch/kernel.c
 create mode 100644 mm/kstackwatch/kstackwatch.h
 create mode 100644 mm/kstackwatch/stack.c
 create mode 100644 mm/kstackwatch/watch.c

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 32b65073d0cc..24f4c4254f01 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -309,3 +309,11 @@ config PER_VMA_LOCK_STATS
 	  overhead in the page fault path.
 
 	  If in doubt, say N.
+
+config KSTACK_WATCH
+	bool "Kernel Stack Watch"
+	depends on HAVE_HW_BREAKPOINT && KPROBES && FPROBE && STACKTRACE
+	help
+	  A lightweight real-time debugging tool to detect stack corruption.
+
+	  If unsure, say N.
diff --git a/mm/Makefile b/mm/Makefile
index 21abb3353550..4d45fb69116c 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_PAGE_POISONING) += page_poison.o
 obj-$(CONFIG_KASAN)	+= kasan/
 obj-$(CONFIG_KFENCE) += kfence/
 obj-$(CONFIG_KMSAN)	+= kmsan/
+obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch/
 obj-$(CONFIG_FAILSLAB) += failslab.o
 obj-$(CONFIG_FAIL_PAGE_ALLOC) += fail_page_alloc.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
diff --git a/mm/kstackwatch/Makefile b/mm/kstackwatch/Makefile
new file mode 100644
index 000000000000..84a46cb9a766
--- /dev/null
+++ b/mm/kstackwatch/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch.o
+kstackwatch-y := kernel.o stack.o watch.o
diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
new file mode 100644
index 000000000000..78f1d019225f
--- /dev/null
+++ b/mm/kstackwatch/kernel.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+
+static int __init kstackwatch_init(void)
+{
+	pr_info("module loaded\n");
+	return 0;
+}
+
+static void __exit kstackwatch_exit(void)
+{
+	pr_info("module unloaded\n");
+}
+
+module_init(kstackwatch_init);
+module_exit(kstackwatch_exit);
+
+MODULE_AUTHOR("Jinchao Wang");
+MODULE_DESCRIPTION("Kernel Stack Watch");
+MODULE_LICENSE("GPL");
+
diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
new file mode 100644
index 000000000000..0273ef478a26
--- /dev/null
+++ b/mm/kstackwatch/kstackwatch.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KSTACKWATCH_H
+#define _KSTACKWATCH_H
+
+#endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
new file mode 100644
index 000000000000..cec594032515
--- /dev/null
+++ b/mm/kstackwatch/stack.c
@@ -0,0 +1 @@
+// SPDX-License-Identifier: GPL-2.0
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
new file mode 100644
index 000000000000..cec594032515
--- /dev/null
+++ b/mm/kstackwatch/watch.c
@@ -0,0 +1 @@
+// SPDX-License-Identifier: GPL-2.0
-- 
2.43.0

