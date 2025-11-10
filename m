Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F12EC0A7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792624; cv=none; b=OqK+z1ZziE1UrgZRSKKVfIuErtIk69yzSKHfbdgAmi6EclH0kES0KEWKn+8e+Z4pxu34mV3Pd73mOQI9VHPEwKFO6YPbhT3dV/I6rvy++jEEby9nww/WkT7b1tpvlQF7/iLWJsVKVbdwzj8vXBpFQ8ZuKwC+dumAjziBWrQwUXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792624; c=relaxed/simple;
	bh=PyR/1C/G7IpUGl4mLUfLzY/550ANKp9vcF1hQ7PDNTc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iM0OE2c999kCo4WRhEJiS6/RNoSfNuSeL029c8wNfJ2eBLYXUI5aCZFQhdE7Cj+I5TixMcAJeUqnkaK0GI+o6JacylhfCDOh0DF/L/xF9KzWC6XLfnumMzqpY+yHpTVnmRPBQSMdUvq8o9/dkkfqqTSgostLqo/FL2sCQskgCfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ7QzKd4; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ7QzKd4"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a59ec9bef4so3560454b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792619; x=1763397419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XURKXnAmZnyauprzc95LAi6JcC8IVZIZCwVkARWD9E=;
        b=cJ7QzKd4JpyYdNppBQQ/Kfo20vq4KOUASijWOu5m3zhCssi7oiv05+C+KpocyAj3kj
         DT2MsdJTrf+iMWfcyDVIt4KgaLX566n0d3AZwko9CK3/IIxZ+PNgOw+jrvBBIu/dhhn7
         FVJULocjMpt2tbiFVaZOsE3jHwzUYHYtO8GamBsfbj0n8fPmly/nyCDWM8k/4EtWvi8z
         tfztH5SWLsI/pBvb5z6Lw/uO013/7SdWvWbjVPJ7z/15bV4s55zgOYwxQgQ2bR3H2+Eq
         Q14BS03/i/8J4e+QweERGzkXfOJ1b/CtslKoAP3HBJRKgFnSXbHVl71Q0x0qecldIq2B
         0n4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792619; x=1763397419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3XURKXnAmZnyauprzc95LAi6JcC8IVZIZCwVkARWD9E=;
        b=kT/iNB34adyk+E1ghpqwK/eOArTDxbSHdRZjj/mx71b3gWz8VsZY/NiE/3ePwesm/C
         os9K5izYYTu0hSba+p7/CTYfAKjdimwt44qF24YuYohMa/VzYYy8freeFNGN6HtY7u6I
         zjwFjijOEIF6eawWS4UJBvCn/1JfbKayWKXg9WIEofNApXpo3RvIyFo8EZKPDr0zBm5h
         kBGWF0HTD7RyoeRckfPk5VmfngBjRHrg54pKHUYDPVurAi/uYKM2fgfWSVv5Uq1p8tIp
         Ip/MKt3JX8rueKxNOZRz9tuAEIup9NqJc9TfbtaIUzPGU5gDQGxpbj6QE+/xUcJrPvm+
         gwtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwnTwZaXf02CR2J3xKLtL/1no4zX9Id0YCM74RYpD31B+0NK/7eRmGM2lU55yi/v4DqI4CHsyI0DeAl7OZCFs4vAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGUS2pw/7HaGzDNXo/jfx8iQaMY33OBhYUNGQoakHyI6HVCd2y
	iIbG5iOAoHfu6WYnpByWLXgb8mdMgxOCMLmy+HNZvaQt2bhddqgyUOyH
X-Gm-Gg: ASbGncuoeHl4z1wp1M7GP8WoGKfUG3G7PsZ3QvQgqac3SIX9LGb/3c6dFA/6EwGNqoS
	0WhF4dwNjOmJ7GhGeQ3MsvWJHkkzcbIKzzv0I9MtTzXUBsI7uVuV9vgdqXYRi7f7J0YMRlC8dA6
	AG8I3xySfctaZsDAym4ox5G002E/Gq91HXdMMbpURap1o8I0jBKV+mCzBXtW/GVl9rg9IUqg4gM
	3oYIxpOfuLBzuKtkd8J+il5R88ipalm1MbWZinhSObR6Crjy9Va54sj9MRXVWyP0PQq0UM2hPce
	V8Y8kPsy8IXqEwi80JBvU/oszCsxlQBCKmZUo+8atZip0GEsJJMhA3ylH3VT0gruRTXeLqWwewz
	dqAkW/hvdlHoYMj3Rk8XhwQ6HJsJxT/yeD/PWQU1f6Vhghs5ZtGT1SrQ7CNqL65CsAvIuLuL5XF
	SARLOyrDiVuZlDFGerTlp/Jg==
X-Google-Smtp-Source: AGHT+IE4ra3aOU6AC3VY9Gg6aAiRBbZVp1TeJobqAmTS20aSxV2gTSQJIElDd/SxyV53Mq4DKRR9AA==
X-Received: by 2002:a05:6a21:681:b0:334:97a6:17f2 with SMTP id adf61e73a8af0-353a18b7968mr11417885637.14.1762792619356;
        Mon, 10 Nov 2025 08:36:59 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba900eab130sm13106983a12.25.2025.11.10.08.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:36:58 -0800 (PST)
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
Subject: [PATCH v8 04/27] mm/ksw: add build system support
Date: Tue, 11 Nov 2025 00:35:59 +0800
Message-ID: <20251110163634.3686676-5-wangjinchao600@gmail.com>
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

Add Kconfig and Makefile infrastructure.

The implementation is located under `mm/kstackwatch/`.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/kstackwatch.h |  5 +++++
 mm/Kconfig                  |  1 +
 mm/Makefile                 |  1 +
 mm/kstackwatch/Kconfig      | 14 ++++++++++++++
 mm/kstackwatch/Makefile     |  2 ++
 mm/kstackwatch/kernel.c     | 23 +++++++++++++++++++++++
 mm/kstackwatch/stack.c      |  1 +
 mm/kstackwatch/watch.c      |  1 +
 8 files changed, 48 insertions(+)
 create mode 100644 include/linux/kstackwatch.h
 create mode 100644 mm/kstackwatch/Kconfig
 create mode 100644 mm/kstackwatch/Makefile
 create mode 100644 mm/kstackwatch/kernel.c
 create mode 100644 mm/kstackwatch/stack.c
 create mode 100644 mm/kstackwatch/watch.c

diff --git a/include/linux/kstackwatch.h b/include/linux/kstackwatch.h
new file mode 100644
index 000000000000..0273ef478a26
--- /dev/null
+++ b/include/linux/kstackwatch.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KSTACKWATCH_H
+#define _KSTACKWATCH_H
+
+#endif /* _KSTACKWATCH_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 0e26f4fc8717..61d4e6edadf2 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1373,5 +1373,6 @@ config FIND_NORMAL_PAGE
 	def_bool n
 
 source "mm/damon/Kconfig"
+source "mm/kstackwatch/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 21abb3353550..efc101816f00 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_PAGE_POISONING) += page_poison.o
 obj-$(CONFIG_KASAN)	+= kasan/
 obj-$(CONFIG_KFENCE) += kfence/
 obj-$(CONFIG_KMSAN)	+= kmsan/
+obj-$(CONFIG_KSTACKWATCH)	+= kstackwatch/
 obj-$(CONFIG_FAILSLAB) += failslab.o
 obj-$(CONFIG_FAIL_PAGE_ALLOC) += fail_page_alloc.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
diff --git a/mm/kstackwatch/Kconfig b/mm/kstackwatch/Kconfig
new file mode 100644
index 000000000000..496caf264f35
--- /dev/null
+++ b/mm/kstackwatch/Kconfig
@@ -0,0 +1,14 @@
+config KSTACKWATCH
+	bool "Kernel Stack Watch"
+	depends on HAVE_HW_BREAKPOINT && KPROBES && FPROBE && STACKTRACE
+	help
+	  A lightweight real-time debugging tool to detect stack corruption
+	  and abnormal stack usage patterns in the kernel. It monitors stack
+	  boundaries and detects overwrites in real time using hardware
+	  breakpoints and probe-based instrumentation.
+
+	  This feature is intended for kernel developers or advanced users
+	  diagnosing rare stack overflow or memory corruption bugs. It may
+	  introduce minor overhead during runtime monitoring.
+
+	  If unsure, say N.
diff --git a/mm/kstackwatch/Makefile b/mm/kstackwatch/Makefile
new file mode 100644
index 000000000000..c99c621eac02
--- /dev/null
+++ b/mm/kstackwatch/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_KSTACKWATCH)	+= kstackwatch.o
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

