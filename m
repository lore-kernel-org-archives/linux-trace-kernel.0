Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D7C2DFA21
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671964; cv=none; b=HAN3BDXUsyajlNZuxxp8nTvXptBbepNxFS26kD5m0s+i74G30NAof+JmDsx+7H+36I6ApCITQsThtOfiHuR/j94+8E5VnL9S9WSjOe+dtAlUwHuQGW2x5NMkCjcuM53Te/fD1yFBH84Mg5n1F3FgYD026r0GIv8iptr1C7luwlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671964; c=relaxed/simple;
	bh=Un+cr8+CAx8R+jlvlSG9Ydlf8KMHwbHKNBBW5RhycS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMj8V3x/K8sNbzR+pYdH9jAchaN83JkuB5hZZa2KhLlj+2hta7E6pDmT2Hm0Woc0RdOl7II9u6XQ3nsk1we0VceoWoIrBHYr/Vxfd0nGhRruFxXsx6riNu0D6RlgkIBoGmLMezarWMqSmAg2hC2Nf7TsMl2WurvbbNpcX7bzTmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4uZmrmV; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4uZmrmV"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b54b3cafdcaso113602a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671961; x=1758276761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTRhetdXz/AlDveQ7cC4oIBX48CBF691SylMydPRcTY=;
        b=A4uZmrmVDOMz3gjZm/FgGvhM7+l9CdJvU+O1OUKMIrxovJmb8hl+KCi9/5Q9KmN++z
         dEEd0GGEc4flgqSmMDhj2WdWoAQgE8V+VNsY+8D7RWpIx0YfB3AIz+entQTvIjgAzuqb
         2MDsHsLagwDLvUPEFjpbTmhkksKJLfidSt9Nfviv7Cjp2gfYCg73NnGXZzQLAtZDCUTK
         bwK4tMZfo4GWQprrIxUSjFdnjPcCpa1KUP8dkvrzK9+rlK2Fmc4VnSF6HaVPa4wQUuil
         PJNG3dWTxCwDCDVdKB9MoMXhpPBivv+Yyrfb03GStmbjeGgvNQtdsinEUvxE4dNRaItv
         2T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671961; x=1758276761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTRhetdXz/AlDveQ7cC4oIBX48CBF691SylMydPRcTY=;
        b=eTqDYpuqZDiDlHiUiSAJbcpVWfH48mJy5WC2gqIGDJLbnyMs1p/HKFrBTnvu+rjhHV
         TmMYPfTfHY1cg/0Zhu0xCXFE7MrSfoTSjYM3Q7Llhq6mIoO9lC7TuM4SZHPOiQMOHgS9
         SpQuz1fb7JK8Abs4wumlX7lYjl4Bb5lQsfvoNt8UqK/p0E/Jc2QGsfSwIdGu9xPlNr3N
         g/4dyHtWwX9EdqUSSM4g0nFc51H9zaWFIScRIGaFbf6NQYlWLieVBE95JoODibMabQJm
         BVg84DYxAuGjeP8c4xkPFZCI3x/+EQziHMWuemuNQyaUSTooWemq3MtMnV/IKpB4rfbw
         UA8w==
X-Forwarded-Encrypted: i=1; AJvYcCWmyR738n5eucG1LRNrgO9srvjlDPbht3socrqNdumC0eZuVDdLQ8rOeRbWsmhZrMvqINkACZd22Alj7U/c5bHNtks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3qFU3/uVqSjAEXYXm+UzCrCpVC0HKWPZ2NsdSI04vmUW7cUXv
	1no8/QLH3WW+puEidgDi2CtQj5E4yUYqE/W+h3EfMTPF16Jow0jqY8Tx
X-Gm-Gg: ASbGncsliz4Uj9lu8oNtuW5PdoxupSmU/CfL5FBZoU3MSFa/PrsCK7Go38Ce9PzQd6m
	ga/4e6i7SZ/WUmCrokHMqb1T8K4KcOT6epr0NnSipjt57b7GgRUn2X64BrJC/4wgZI7bpwThau1
	wJDspCpBjvW7e8sf0i9BYPkDnXFwLyxBGmvHJbDr4dp3cFCO0VC8xqvEFRJGdVvfD5vK34OzhsW
	4I/dKzHo5ok4pPIoIAFebxdEdqLllSLm35+MpmXSjMK8U5NmELr0dOmTsJJLbCKCIf0Deflr5Ih
	hU285LoBlgbyvC6DsUzdxfA04DwITlt+a/R4Paikp+PQ2+u0YeTNNVl/0I4jOvQynkejVmT9dyq
	2JU2TrBRtG4th3jI/19cr7Aa9ECUopvaV0x7X3/alVPnrz+RuYw==
X-Google-Smtp-Source: AGHT+IGqTkU62M75KR/OKOWzeX1g5EGPCOAXf7ry0VUZE+EZFf5kPwKsv6/nCCnQmnFIPNz9rUR8cw==
X-Received: by 2002:a17:903:3884:b0:24c:d0b3:3b20 with SMTP id d9443c01a7336-25d2675c1fdmr26411195ad.37.1757671960988;
        Fri, 12 Sep 2025 03:12:40 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a398cfbasm4325375a12.39.2025.09.12.03.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:12:40 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
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
Subject: [PATCH v4 09/21] mm/ksw: support CPU hotplug
Date: Fri, 12 Sep 2025 18:11:19 +0800
Message-ID: <20250912101145.465708-10-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912101145.465708-1-wangjinchao600@gmail.com>
References: <20250912101145.465708-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register CPU online/offline callbacks via cpuhp_setup_state_nocalls()
so stack watches are installed/removed dynamically as CPUs come online
or go offline.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/watch.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index 14549e02faf1..795e779792da 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cpuhotplug.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/irqflags.h>
 #include <linux/perf_event.h>
@@ -61,6 +62,32 @@ static void ksw_watch_on_local_cpu(void *data)
 	}
 }
 
+static int ksw_cpu_online(unsigned int cpu)
+{
+	struct perf_event *bp;
+
+	bp = perf_event_create_kernel_counter(&watch_attr, cpu, NULL,
+					      ksw_watch_handler, NULL);
+	if (IS_ERR(bp)) {
+		pr_err("Failed to create watch on CPU %d: %ld\n", cpu,
+		       PTR_ERR(bp));
+		return PTR_ERR(bp);
+	}
+
+	per_cpu(*watch_events, cpu) = bp;
+	per_cpu(watch_csd, cpu) = CSD_INIT(ksw_watch_on_local_cpu, NULL);
+	return 0;
+}
+
+static int ksw_cpu_offline(unsigned int cpu)
+{
+	struct perf_event *bp = per_cpu(*watch_events, cpu);
+
+	if (bp)
+		unregister_hw_breakpoint(bp);
+	return 0;
+}
+
 static void __ksw_watch_target(ulong addr, u16 len)
 {
 	int cpu;
@@ -117,6 +144,15 @@ int ksw_watch_init(void)
 		return ret;
 	}
 
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"kstackwatch:online", ksw_cpu_online,
+					ksw_cpu_offline);
+	if (ret < 0) {
+		unregister_wide_hw_breakpoint(watch_events);
+		pr_err("Failed to register CPU hotplug notifier\n");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

