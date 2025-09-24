Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B293081A3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714754; cv=none; b=o2I1BLfQXKodYR/vq3lkC1SO7jb0RIuY6S4yRBoMtP+qRi3OT27Zt0Ldy4GwZMOiOUmy/0JIQl2+E193LKhEjRXMtDUHZPNX65lHCgzJQEGqosHNeWUwGrZ/gqPIitbqPFWy4wCz0prcs8bjQMMoEYctT09bGH8Go6kpofMrEJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714754; c=relaxed/simple;
	bh=ye1IFedT6QyfAsl7NnFp/ScKqi80nwnk9udpC+1GQaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nF2PVl7cllovKyoWJzW6UMY2E0c1uNf5dq0ykylbA2gK2qtWSfF2jvfz2GIc6PBQmIUlkw+TEQHRTls1OTAJQk/ZHVhehcc2V6MvNj8EBarCFWfwvNVNGFAxfyr5j/juWsMq8V/GN9ZmPHCa2+oFyYfnhTZji/ljaI8Q7Gxzmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZrlwNRh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZrlwNRh"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso5586365b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758714746; x=1759319546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RtyZdLa/V9peD4vyIt7vF3g+yVd+tHG9wNYuCcZNH8=;
        b=MZrlwNRhakdUfwF3T+Gf8oKgZDPlyAv+FZtX+0K57ajjffJeYk+oLNcx3hdqhgW+Fa
         22lUQNRyRpZVyk9cF8dtLoozEEs06waLEX/cTJpF7jw5OgRlcSAHKG9UU///nHp0i39h
         6YYrtAv1Peswb3zecgTMaCi9O/4wemc1RACmsflZlPDDTzJ+fYDB/0j96Oe8WPixl6cy
         52a/Dv6V3JEo6MGU1w6+kK68Y46UJaw7Z5jLtgDXUGfvBAvV3QAFUba/l3pB96jnUDcl
         xZ3Hl/aeqNz/6pi48cAiHpTzSWXLtJph/mDnDEGhGTMleDNnGgWTBKL7aiL/0DpUT87Q
         N/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714746; x=1759319546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RtyZdLa/V9peD4vyIt7vF3g+yVd+tHG9wNYuCcZNH8=;
        b=rqrCwE95nNzsI4r4qhG/W/fnbfNTBtedUYl+TmXvQB+09KWnXtqhZ5nnz8Dx13TKah
         6b/gdmLEMy/a+4K/DEuMi9wqijVdxqWwVkRzjlfyBMgkdpky4DZxQ4EmH7vECl8DlXa5
         P98cCjad0o+kUKnq5h7qfGsga2VUuUB/HkSsGqzJ1pCahjGtGR5Aywn4fDE7FyzXyoou
         +vM9uHVc197RaLPIc1yNp4zvuB+zpS8ev4q/L1qbHTnXzFT435xhhbfwfAUEbcOxn2Oi
         eCYi921B8FDkD0KnfTGdxfYhA3qi+q3t0HJZ5tTodKKu76z0aTaWwzLoCwEU3Q3EnxV7
         Xbjg==
X-Forwarded-Encrypted: i=1; AJvYcCVw9gzwcpaODk3pOo7N4/1Yqu5Uz1N+5BMBhkSiaMB+/fjElrNbBjDsh0b5s+8nAK4TgqPQn8XnHYOjno1SnrodCi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpJwzDnphfGkEJeboJDu0CuIcD3Am0wakoMJvaLWUb3mRR/nLG
	VxXe40W7+O11UqhDGRD4lSO/vETfQE9m2mcJfAhpjiCzUgNXkN4Nc0og
X-Gm-Gg: ASbGncvjSf5kQaY7Kw4PiA+W0XAOfI2aRJzzJcHHarSGL387tbIWF/b/vcy/t5GVdvc
	G/kkbLJ/LlvRtxW0gqoRcv5JLlGEAu2ylC0ZktImqMUG3auxYeX2/qD7LxCmlgjvJwlRQaxh+4t
	+Jm+pN2dXfXHMjrUYpoB4Xrmq3gH4lJZbgdVuywDcnX3iv8PBs1TfMOTJP8Dx5fIWIZPtENwNuJ
	bQktkeuaZ37wKB86SOAHkuvkVjFQG8gNLtlzDjtXxD8Je2rU6LPuXT6dsxmVDpo7ECDMrwjD8Vu
	ng2M4AGjODT2abaCLsleXHUkubsQlqB6dTD+0SRk4oqJy7TQ0WylFcL7TMLSIqeS19YPwA1XMOw
	WfJUuXYTVGpgqLvBno23Dzy7DVA==
X-Google-Smtp-Source: AGHT+IFd3RP0c8tCn3t4y4bSe9bOx7A5o9IS+XWa0APddLheuXvaqGIhD3jal1mya9sFq0ZjmUZBSA==
X-Received: by 2002:a05:6a00:c91:b0:77f:3018:c994 with SMTP id d2e1a72fcca58-77f53a13c02mr7705160b3a.17.1758714746084;
        Wed, 24 Sep 2025 04:52:26 -0700 (PDT)
Received: from localhost ([23.142.224.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f0fc4cfbcsm13824080b3a.61.2025.09.24.04.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:52:25 -0700 (PDT)
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
Subject: [PATCH v5 14/23] mm/ksw: resolve stack watch addr and len
Date: Wed, 24 Sep 2025 19:50:57 +0800
Message-ID: <20250924115124.194940-15-wangjinchao600@gmail.com>
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

Add helpers to find the stack canary or a local variable addr and len
for the probed function based on ksw_get_config(). For canary search,
limits search to a fixed number of steps to avoid scanning the entire
stack. Validates that the computed address and length are within the
kernel stack.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/stack.c | 77 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 3 deletions(-)

diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index e596ef97222d..3c4cb6d5b58a 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -9,6 +9,7 @@
 
 #include "kstackwatch.h"
 
+#define MAX_CANARY_SEARCH_STEPS 128
 static struct kprobe entry_probe;
 static struct fprobe exit_probe;
 
@@ -59,13 +60,83 @@ static bool ksw_stack_check_ctx(bool entry)
 		return false;
 }
 
+static unsigned long ksw_find_stack_canary_addr(struct pt_regs *regs)
+{
+	unsigned long *stack_ptr, *stack_end, *stack_base;
+	unsigned long expected_canary;
+	unsigned int i;
+
+	stack_ptr = (unsigned long *)kernel_stack_pointer(regs);
+
+	stack_base = (unsigned long *)(current->stack);
+
+	// TODO: limit it to the current frame
+	stack_end = (unsigned long *)((char *)current->stack + THREAD_SIZE);
+
+	expected_canary = current->stack_canary;
+
+	if (stack_ptr < stack_base || stack_ptr >= stack_end) {
+		pr_err("Stack pointer 0x%lx out of bounds [0x%lx, 0x%lx)\n",
+		       (unsigned long)stack_ptr, (unsigned long)stack_base,
+		       (unsigned long)stack_end);
+		return 0;
+	}
+
+	for (i = 0; i < MAX_CANARY_SEARCH_STEPS; i++) {
+		if (&stack_ptr[i] >= stack_end)
+			break;
+
+		if (stack_ptr[i] == expected_canary) {
+			pr_debug("canary found i:%d 0x%lx\n", i,
+				 (unsigned long)&stack_ptr[i]);
+			return (unsigned long)&stack_ptr[i];
+		}
+	}
+
+	pr_debug("canary not found in first %d steps\n",
+		 MAX_CANARY_SEARCH_STEPS);
+	return 0;
+}
+
+static int ksw_stack_validate_addr(unsigned long addr, size_t size)
+{
+	unsigned long stack_start, stack_end;
+
+	if (!addr || !size)
+		return -EINVAL;
+
+	stack_start = (unsigned long)current->stack;
+	stack_end = stack_start + THREAD_SIZE;
+
+	if (addr < stack_start || (addr + size) > stack_end)
+		return -ERANGE;
+
+	return 0;
+}
+
 static int ksw_stack_prepare_watch(struct pt_regs *regs,
 				   const struct ksw_config *config,
 				   ulong *watch_addr, u16 *watch_len)
 {
-	/* implement logic will be added in following patches */
-	*watch_addr = 0;
-	*watch_len = 0;
+	ulong addr;
+	u16 len;
+
+	// default is to watch the canary
+	if (!ksw_get_config()->watch_len) {
+		addr = ksw_find_stack_canary_addr(regs);
+		len = sizeof(ulong);
+	} else {
+		addr = kernel_stack_pointer(regs) + ksw_get_config()->sp_offset;
+		len = ksw_get_config()->watch_len;
+	}
+
+	if (ksw_stack_validate_addr(addr, len)) {
+		pr_err("invalid stack addr:0x%lx len :%u\n", addr, len);
+		return -EINVAL;
+	}
+
+	*watch_addr = addr;
+	*watch_len = len;
 	return 0;
 }
 
-- 
2.43.0

