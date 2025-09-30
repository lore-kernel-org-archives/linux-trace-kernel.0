Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C919258ED1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200331; cv=none; b=JwrgpCH6If+yZOFu2MYokDefEv4lEj+0qFogAcBEbWAJEOzVZacgdeeQpA/ohJYULUM+RmAsIP6D07+neOmX3cyqAvxIspD/vUzgA5UMDwVCLcOZvFYA0XvzkQQK+B/XXs3BAMT3qqBLK+hoUa8KvuvlEWSvJaNk8UHnOLNWuNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200331; c=relaxed/simple;
	bh=Sl2YI7Td/C9YkkJpnWkOlkyn4hvpDBvdNr6f7stAoSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdcZ63hNGDXAa+iIiHkAY8Wh23DpfIBgZtWGqmBkdmzC7YGMLlfY5U3aVIaC3g5XFWeoDWX2sSINBmOywLpzc8VqcZZ5xLw7tnOs8Mgs3Brbg2+6NmivXfUugjpbFaUy/NfvPui2Gx82loLHJGmcr9u8LdhISEceU6QPJ04Jl/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiyBF/wn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiyBF/wn"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso4226442b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200329; x=1759805129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX4DcHmKN6k6jLli4BcDyPNAsEAGb3ORwL+dRbW7euA=;
        b=aiyBF/wnrDTAEUGQ3gs3hkoDo6ov65uut92C3I+ngMReOiufaQ1vmTFIu1XnSWaGGh
         khX0pjDWJadRCDMCM3CMXPMKCKltjKWNUtc51qshE5kXFvc287XTIF8QXgev3XVGSn9y
         05DxNPfZbgEUDZkoFxdl+YdQopelHsQzG3KhzdyKhxkrnE1Hv/+FHU7/2n9zyeLmIYVz
         uTo47nYJvcaZwtoT0ajVuJE7PlG/Oh+U/sm85SO4tUaIx1F5/CrTTe7S+qGifdVeBf89
         wV/OxahguZKjvN/XTCzxgnwE0taEPgzJ1LSh95A9Ols1FTzW4QPkrMnIoSn1CJaDFPvk
         oNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200329; x=1759805129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sX4DcHmKN6k6jLli4BcDyPNAsEAGb3ORwL+dRbW7euA=;
        b=cayNaqnJug+WIdBdKXvZGJIUKukwfsbsCeK/l9MzLAP2GMILQUhjV3ciqxWIaUicNX
         nlKj8Ld9R9/hVvHDuCxT225tv8CJRmb/4lKr8WccJJHLQjXybMge6iUZX/su0y6nbNyI
         rGvUPA87HiB5d+P6hxpVzAbBYhVlvQltZJ7w8SNq5FNh2aBtIHai5DaWpPEogJyb5GxT
         /1DGkgpYIVO/bj21FvK/ytgbNvmI2cypMc/KoaIYLepgfg00Olu6xTC9eIbjrMi6EhGP
         ec9BKe/zvRJflPpf0KZ5O0l9o5dn4NhRehMPRDxzMIXHCnyuQ8A5Z5pt6c1W8NpanZqa
         2Dqg==
X-Forwarded-Encrypted: i=1; AJvYcCVUSKxLkzrE0YAeGNtvRj26JegN/YIazPkNx0OIWPX/bUC6V0KtL6kBs07JI2MJFwf9B6uMEmuLs7ONGqRT2OVHwbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNYW53AcivCv69T5ZGYzTA7KKB+7TTNZM935HqOR/eWpfG7bJM
	LvH07VY5/myn3hcNB+pqcpxqROJpvGRZxsZpFDFpL/GdDFsQaDgmIeOA
X-Gm-Gg: ASbGnctKfKpuTGhhw6U6bQiqmup7ERtJpp/TnvAWZhW+ImURrpkDzGG82HR2d830uGW
	awZvt/nC/G0naqjU7by5R6LffAv3J6kduQ/oLyabHKes8RRQJWeJSf2GGS70AZhLk9w06eUkL9M
	hc+qhz7SD4EYYJ2EjV5Xaa9PQL6iatPZI64IXmHHP25DDUMVRQT54nWFSPe/1DyZYX28DoQ+gNh
	hRNDOc01Ujq1C2PIKIn0GbzGHK8izPSbey9f/8q0Y84QxXR4fmSj/GNVu7fHWZm1WukjR+pZ/Il
	GKU1Ono0sRFdOPx8xV6RuoFm8nK0HAwYcwjggtGKXdoc51Os98pXkB0QYsNf09aOTWKycr/xyiB
	kBTjzaHwXLUByBRytAPNUeCmLtJ9c4aKFizZJoTHrcOuvoUhDEbv3IvfClriXVqtThBOHTqk4Wy
	YMuMocC7xADgU=
X-Google-Smtp-Source: AGHT+IGTqTwXopd2ojQqxBEBkqI1vY+O5jS9ODQlBJjx1qTPcUYlj9RqM72R3p1od6/UyekDO+cXWA==
X-Received: by 2002:a05:6a00:b53:b0:76e:885a:c332 with SMTP id d2e1a72fcca58-780fcf080d2mr23371738b3a.32.1759200329155;
        Mon, 29 Sep 2025 19:45:29 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-782e36c803fsm5830819b3a.38.2025.09.29.19.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:45:28 -0700 (PDT)
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
Subject: [PATCH v6 13/23] mm/ksw: add per-task ctx tracking
Date: Tue, 30 Sep 2025 10:43:34 +0800
Message-ID: <20250930024402.1043776-14-wangjinchao600@gmail.com>
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

