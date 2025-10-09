Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE12DFA3A
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007437; cv=none; b=iBQM8/tvOZ3RcG0oP9p2PQ4P3qNSMr5W5nNF0uZRs8W7c0vhxqcY13flHqANirClw0e9DN4uVVw9+5OwpwigGL5KGIHETGpto4O5QpCYYKQ5Ix8ACAFXPpSo5qvEgvWm5xAIcOVsyqis+eMd9U19s9F+f0X5qaIs6JBdHyW+zAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007437; c=relaxed/simple;
	bh=ZEq5LCeeZxdZtY+a+kvZMIoWs2Mzj+sOmq7f1LtT1gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5mxwy7FhG7zvDfLHJh3BUHSRs1IO5t/uDa221Xuoce+TJU5jL+UOrG6KY3UfGSEMeAvkZPBu0l8GeDYsPK61WKz8xOFlGa+oR8er+nLA0Lx1ynUUnHYlfCnAUf6oPi+RZ9Z6OEBfo7Xg5AsmvDmKXsw7CVp5PT96g3J5ugQyt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4Pp6a8s; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4Pp6a8s"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so493843a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007435; x=1760612235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd/jIJYyk1G6SYf0mNQVLBMDX4oiGoErfqkyMXn4+LQ=;
        b=b4Pp6a8sJa2n2qbeytpIz5f3NA41jueaqkOCK4dO/3SkRa/mkKIrszTCewtb9m1VLb
         nQ1TaaSOh9Ur23oJyv8NPwu2GvohB63qYmrD/tBwJDqKPNTURSvtPigdYglPHpchnuXR
         ggVIquQ78qxY6UziF6il6ugvescs6JyhxQFGS+xktMD1GSOksGVSpNntyv8YLNfgdT0h
         7idHSXMxt+oTelQbZbnOGwt5BH4Qdn+PDksw1YDErDcZlJiuIUbuM7hNRU7L/QkmTovZ
         ZnV38Aiatc12psZ0egrAHK54zUtPOfExPWXeKE7rZnuoWpWFp3kZXXEdD69UhOY1C5Ic
         9BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007435; x=1760612235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bd/jIJYyk1G6SYf0mNQVLBMDX4oiGoErfqkyMXn4+LQ=;
        b=m6wA1x8OmPgk1O1pOU19RHCZCK0yihwkwH8iLawlaY8OnnsyfxTHwL1yBB5+WiBs9U
         a1EF/fTrmpD7c+40a5aysx+Ot8c/8a7m9P4NsUdD6C+5yqPmrX6m6f9nGQdUsBw6HBAV
         QkR2gsEBDIBFkZYm/H0H0P3ngdzG+HGP9omQeAjk7ES1IGInmKP7OGzfJ9AroNYGeuKi
         qbB7IcsxRSrRF9/+PnG5guY48LlDDxLGzL/y8RNkuXg6eeD+PfidrhqypFthoK3ilAbA
         9PGKXuZSD3EW/72mHm+930Gcfnl1Ypl/s+I+NKVOpR8SENO2Gt2FwsDh107Snh+FvsK9
         ulSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl5qIHj8wsKyHtrisoRXtknB3WGAGo4CV1XsYboa3jbDLukNV9P3diBwTfvRNFw+f52JNNNNye4p3d5EelHPUv4FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwVzouVoKT4Sv5lAvKp49wlQa3AEOoKTmX/JIRL5fNb77h5fXs
	ezh2K2wbRisNV/9wZnkqKMAE219bJj2WEY+emg5fGwIkBDWGfKGXFaFO
X-Gm-Gg: ASbGncuWCGiQ9HnitFtSs+kAhQLdqNlmmv9aYHv4oVTBl71zFKwG0t51p47wINn5suM
	zPT7XvE7RwM3o3oJYChASKVNm19ouNQjIgmsoz13PUdLyZ7KfsovWJL1oOfvFx/9XbaUhvUapT+
	t/LcU+awMRF3nHpjdsHPp+CWG6kUQi5Qa4spVRgmrDUeKUBGAoSJaAc+aHTOlldPedHzeiJWK9a
	eUo1wul+EkQS2H+GoSPD1rH23XHWvosim+D+hb160W66moMBOqU3/exlmzVXEYywmqxoyspmKSG
	dnSgaXVpvx32mRPeF4m4e2uHuQW9JVeKNOCyl2V3LYp+N/9PMgqt/9ckHjYitgYmwTgMCFI3HKj
	yzbwL89XokKt9Kusd1OsvUhdKEvcdWyn0vVecu85A4Sv1eqRYSGyK4mlt4COJ
X-Google-Smtp-Source: AGHT+IEE3niJRONXV0Bm+xhadUZIixrOrMgOG5awbVzvEtTxP46vMAiWCgHmPSj8i4UN21ZLnxO2Nw==
X-Received: by 2002:a17:903:2c06:b0:27e:dc53:d239 with SMTP id d9443c01a7336-290272b547bmr83465905ad.35.1760007434817;
        Thu, 09 Oct 2025 03:57:14 -0700 (PDT)
Received: from localhost ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de9febsm25266445ad.7.2025.10.09.03.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:57:14 -0700 (PDT)
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
Subject: [PATCH v7 02/23] x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
Date: Thu,  9 Oct 2025 18:55:38 +0800
Message-ID: <20251009105650.168917-3-wangjinchao600@gmail.com>
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

The new arch_reinstall_hw_breakpoint() function can be used in an
atomic context, unlike the more expensive free and re-allocation path.
This allows callers to efficiently re-establish an existing breakpoint.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/include/asm/hw_breakpoint.h | 2 ++
 arch/x86/kernel/hw_breakpoint.c      | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index aa6adac6c3a2..c22cc4e87fc5 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -21,6 +21,7 @@ struct arch_hw_breakpoint {
 
 enum bp_slot_action {
 	BP_SLOT_ACTION_INSTALL,
+	BP_SLOT_ACTION_REINSTALL,
 	BP_SLOT_ACTION_UNINSTALL,
 };
 
@@ -65,6 +66,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 
 
 int arch_install_hw_breakpoint(struct perf_event *bp);
+int arch_reinstall_hw_breakpoint(struct perf_event *bp);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 3658ace4bd8d..29c9369264d4 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -99,6 +99,10 @@ static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
 		old_bp = NULL;
 		new_bp = bp;
 		break;
+	case BP_SLOT_ACTION_REINSTALL:
+		old_bp = bp;
+		new_bp = bp;
+		break;
 	case BP_SLOT_ACTION_UNINSTALL:
 		old_bp = bp;
 		new_bp = NULL;
@@ -187,6 +191,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
 }
 
+int arch_reinstall_hw_breakpoint(struct perf_event *bp)
+{
+	return arch_manage_bp(bp, BP_SLOT_ACTION_REINSTALL);
+}
+
 void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 {
 	arch_manage_bp(bp, BP_SLOT_ACTION_UNINSTALL);
-- 
2.43.0

