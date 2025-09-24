Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72852306B0C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714746; cv=none; b=TnHDIOE9SjKwnoTjx7xHau/sVJq//vC2wG3alV79L8lmuiJ6rkK7YWQMj9k2gcqcN05jxU9DyGfUBkfsHO/tDfdADUaVeMt1iTeVSz1/WRqlES/2yzLF5SviC+aUmuzJzZ6i1746a6iV5iWNjKITcWzEM7in36J4V5CFG8l/4mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714746; c=relaxed/simple;
	bh=Sl2YI7Td/C9YkkJpnWkOlkyn4hvpDBvdNr6f7stAoSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ksa1dd1lTmsMquqL8MlYuTcY75KnbCnfxS+uK3l0DYZZcjxwZ/mXTH/IZmXDHf87ASrtvkCGQi2tdEUn1zyHzRqVvhSvybl+D09lnZOPp+nZW9Hp80aLWSiUkjdN3riu56mO05I6twe2SrFBgJ7apFf5C4Oytl8tL/SERpMQNcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mj6Q95gj; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mj6Q95gj"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so968234b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758714743; x=1759319543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX4DcHmKN6k6jLli4BcDyPNAsEAGb3ORwL+dRbW7euA=;
        b=Mj6Q95gjxAqB/UIvJL2Fz+IYzT43o6YMhcDCVCSbrht7yJjT68f5u3uCByk4A6vFTE
         T2Ko4MZZsVu2RPY367DjLf4llHmY8+W1mvOQdf0d1d3hraa6sbKIS2a4nHdsPxU53pVn
         9R/y3vVIjzAErY2K2ZsUJPnYkPvX0n1bvvBsCuiCVlUANIPmLDupyIjFrnQIeuQxMJIU
         +u1iiO0v6jyZT1gXrsbiU+8mz/oqndHSfhn3BjEMT4YJhBVhem21HdrLIVtJY2cSl3zi
         oTVapqQpwViatAsyYNX0Z0cKLvbu7fBI/R42wcsn+hIWLn0TP0BjraxLqjIRTOucLfdf
         U3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714743; x=1759319543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sX4DcHmKN6k6jLli4BcDyPNAsEAGb3ORwL+dRbW7euA=;
        b=no8qpFYi0ZEfR4lCAMNI3CzFfrueENeLTJ9yFRTTWjcX2xuq2oLgXOAF793DYiq2Jg
         lSU+bm+zgIy/LkkYKrDLc43PqWAV3igZTJLGauxRa+3ZhGRtMirOKybqJBBdbvblpS/9
         qHunT+MJgvgY5XgyW3f4YPVzkBqwcEJcx4JNkZ83EQhwuLboOYEDDzMSSm28JpAWPioN
         8lX+3Sx8OlprulvqGuhsiFOxnaHFIbYqER18c0viTSkLAprzSbkh4P9n3JY1QsESJfeP
         v/LrqCMl/r1WnFwf+tsgMSvnM7wkWaFHSwC1C9o6qDWNa997ytqGDH2l4ufK9+LggOaj
         rtDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEX9aUz/QMPIlaWL7g2RPz/fFSk72Xxqerr9aQJHkSCAtHb3JDlfb6hO24syuGIGu07wvQR4o3I79e3nMhxJ17Da0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKVXbkQTSRNwsN/Jd6l3iDzSaIQGffCc7tTm1+sQHVK8jCDakD
	ltuCUPcP5a0lELl4pDfjjlEgiZWsQ8qX4YoyEqhIevtjpdRMP5Syu/5q
X-Gm-Gg: ASbGncuMN+fu92Jm7akk6uC0MUyK4hH5N7WiBa7zFLKOI+2cw9u9qFFOTr6iFz3h3OR
	JxXxZWdXzWyhY16a9nEY7O8k+1z5K0aN1RziUVt0tsnuwH9dLSG91sgiRXfUk8lnawx/x5qCfSy
	zICWbrMOCNV0Va3AZZaKEFBRMRXqlceQoRDP956lE20rP226Jb1WXxiMDmpDsKxGgeZnVsa38do
	Lzqu9oB59Q1BDO8pJaDFBV3cltdF3sxlv+ZR3OaOsqKY6jh8bSg+NUOwIKYcKfpO184tK5+2oYe
	jdIXXYE63V3nd96U5msAbkFWwGCNAjkoRS0BbcdWqwf61UTuHhJVVhhW7VXtfdxv5uhxuXJxneD
	Sz0cNaAsszKMzCmExZSWGpTmYtw==
X-Google-Smtp-Source: AGHT+IHM4OGfhR5oYYdpAC3Dd6EW1w7h66PDSvRIMWNc5YTjulef4dYL+e/NY4vhVJcodihdgSSIbA==
X-Received: by 2002:a05:6a20:e292:b0:247:65a0:822 with SMTP id adf61e73a8af0-2cff1c61c0amr8760157637.40.1758714742579;
        Wed, 24 Sep 2025 04:52:22 -0700 (PDT)
Received: from localhost ([23.142.224.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551518480asm14947563a12.28.2025.09.24.04.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:52:21 -0700 (PDT)
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
Subject: [PATCH v5 13/23] mm/ksw: add per-task ctx tracking
Date: Wed, 24 Sep 2025 19:50:56 +0800
Message-ID: <20250924115124.194940-14-wangjinchao600@gmail.com>
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

Each task tracks its depth, stack pointer, and generation. A watchpoint is
enabled only when the configured depth is reached, and disabled on function
exit.

The context is reset when probes are disabled, generation changes, or exit
depth becomes inconsistent.

Duplicate arming on the same frame is skipped.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/stack.c | 67 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index 9f59f41d954c..e596ef97222d 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -12,6 +12,53 @@
 static struct kprobe entry_probe;
 static struct fprobe exit_probe;
 
+static bool probe_enable;
+static u16 probe_generation;
+
+static void ksw_reset_ctx(void)
+{
+	struct ksw_ctx *ctx = &current->ksw_ctx;
+
+	if (ctx->wp)
+		ksw_watch_off(ctx->wp);
+
+	ctx->wp = NULL;
+	ctx->sp = 0;
+	ctx->depth = 0;
+	ctx->generation = READ_ONCE(probe_generation);
+}
+
+static bool ksw_stack_check_ctx(bool entry)
+{
+	struct ksw_ctx *ctx = &current->ksw_ctx;
+	u16 cur_enable = READ_ONCE(probe_enable);
+	u16 cur_generation = READ_ONCE(probe_generation);
+	u16 cur_depth, target_depth = ksw_get_config()->depth;
+
+	if (!cur_enable) {
+		ksw_reset_ctx();
+		return false;
+	}
+
+	if (ctx->generation != cur_generation)
+		ksw_reset_ctx();
+
+	if (!entry && !ctx->depth) {
+		ksw_reset_ctx();
+		return false;
+	}
+
+	if (entry)
+		cur_depth = ctx->depth++;
+	else
+		cur_depth = --ctx->depth;
+
+	if (cur_depth == target_depth)
+		return true;
+	else
+		return false;
+}
+
 static int ksw_stack_prepare_watch(struct pt_regs *regs,
 				   const struct ksw_config *config,
 				   ulong *watch_addr, u16 *watch_len)
@@ -26,10 +73,22 @@ static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
 				    unsigned long flags)
 {
 	struct ksw_ctx *ctx = &current->ksw_ctx;
+	ulong stack_pointer;
 	ulong watch_addr;
 	u16 watch_len;
 	int ret;
 
+	stack_pointer = kernel_stack_pointer(regs);
+
+	/*
+	 * triggered more than once, may be in a loop
+	 */
+	if (ctx->wp && ctx->sp == stack_pointer)
+		return;
+
+	if (!ksw_stack_check_ctx(true))
+		return;
+
 	ret = ksw_watch_get(&ctx->wp);
 	if (ret)
 		return;
@@ -50,6 +109,7 @@ static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
 		return;
 	}
 
+	ctx->sp = stack_pointer;
 }
 
 static void ksw_stack_exit_handler(struct fprobe *fp, unsigned long ip,
@@ -58,6 +118,8 @@ static void ksw_stack_exit_handler(struct fprobe *fp, unsigned long ip,
 {
 	struct ksw_ctx *ctx = &current->ksw_ctx;
 
+	if (!ksw_stack_check_ctx(false))
+		return;
 
 	if (ctx->wp) {
 		ksw_watch_off(ctx->wp);
@@ -92,11 +154,16 @@ int ksw_stack_init(void)
 		return ret;
 	}
 
+	WRITE_ONCE(probe_generation, READ_ONCE(probe_generation) + 1);
+	WRITE_ONCE(probe_enable, true);
+
 	return 0;
 }
 
 void ksw_stack_exit(void)
 {
+	WRITE_ONCE(probe_enable, false);
+	WRITE_ONCE(probe_generation, READ_ONCE(probe_generation) + 1);
 	unregister_fprobe(&exit_probe);
 	unregister_kprobe(&entry_probe);
 }
-- 
2.43.0

