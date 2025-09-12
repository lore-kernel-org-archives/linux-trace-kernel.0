Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225C82EACFB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671970; cv=none; b=pRXfOBmgT+BZ9V+5gWC0aUJ2hSnlcMWZA227LllkbF4PNg7sGA8vc/BuvW6Tb+rlwE5FDYUEbwU2zibax219mpJkxn5jzqKwKDHwJiwWHFoHRaRYRKgYBPZsNM2AmLI0c6whK4o3AptXGBhGKjMJGtcXvJRAkiYHl95cDVO9eds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671970; c=relaxed/simple;
	bh=9KjIUwPMgHNHYVh/vgsz+Iu+cp7WW766R2rHVAOmv3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iepOTp4IW9GJHoWezTyOJw5+S75ElB5SfBiqm31/xTcKOfjSmFWOmTYHlpKq4ARh6LCXtoZkJr8XCj2s9U5wgjOCidILEKZtYJj8T4vBL3JUiNhBHe34lwgVPneOUJ4mlvc21Z1SQYUUOPH7kUmED1/4u/vRe32qQSHFl+bXDpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZajTr3oD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZajTr3oD"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24c8ef94e5dso13709115ad.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671966; x=1758276766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqhfZKpOZ5vr6/4baQpnpDghHsngjObwVAr7pMjTC1U=;
        b=ZajTr3oDOxUYhsKnBwW/jtStARL+36ayWUwx4F2P6hiWtwXOvDpVMVNxrvHhiTrZuB
         v2qVtPdtCZ81HZO9ZLyqIovuW4I74RgRaD3dSWSRVtkz0N6MNT/pISfjP34RfngIUyod
         N5fh2DrReYCXh1qzjTJVtmVWqXWn3fm9LPAhhMrQ1gkLbfCC9e9kNLHQVmEVSvzLt5ho
         NX7j7c8j6GqXH8pipGjTvf4ebtxAysbB+dXfeSj/xorvfu9+dAxowrpsYNDO9IU9ONXN
         gyZZ0XbR5GWQEBZW5hJQBY9oeQsXNicVR+XYMs8hjbC99xMBzQy7/CtOiWbakBD/rons
         u4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671966; x=1758276766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqhfZKpOZ5vr6/4baQpnpDghHsngjObwVAr7pMjTC1U=;
        b=pVtZWxkLgSEPKTsZxF0L0+I1vBEhqIGpB1gffR+lCHKPGXSQ9WxBelIoxxPkLNIWEg
         PYekNGKOUqhxN4Qp2svC2Ax7Q4nsPvB8x3hDeoo14ogzghlH2Tdsh9pKZWXDN6vR39y2
         A/E1wOsw27TI8msp6T8sEZr2enDlIBku4+bTEebdpcXULr7nqrbaWJiHJIWP6AH8IF/f
         /PcdnRMmLgzUjs8JpH8TBRNQKchKGbOAXDdFQB7K/oqInVenEBnuqr2rCJkIf7hxHB2R
         NEJyBYdc5hVwM0B0QpCTYK5h7scfj7lzLjC8vIZaE4CSLufO1VUqiSUmAOwdkmHfseZv
         vCsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/K6io6Bt0uwDYgkBaGT6UcPZPk8/vD0wUZhuZG89MEclS935fuFDhi7H5eH5LIByvcXGTtjajvSLxYDuLfGApdGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLkXaZd7B4SbWYqEdR3ZkgbHfS3IIl3vcvuZj8K6qpyYzfnnws
	Dd3lgvC8+7lBl+RUeYGJzCqtYYAjRohHGPAWybvvHbG73kNKuB4XsXrS
X-Gm-Gg: ASbGncvXZws1gEG09a7iB08vq0T7xbBwPGDLgjXF957Hi9cWbmaGVcw3y3ZSgHfbB9p
	bpWASgjrPjgXcFtNHp9MMft2636UUCCSazo1SaVE/R43HB3C/Xuf9uA5DSVEbEbZ7X2aR2vB/PP
	1/Eqq0oQdXqo9ob3k0XHpj7oeRswfjV+bj+kQECUQBfgSacrweV6n/IkkCEsduRsKXmGaru6OHx
	rAbX4WGWk4JuxEvFMozKy8CpvpYICDvJ9sLOl0Qv4puoUx3ZSAY1bDFO57yfv8UszI/HTtNFGGw
	jKIag4tFmY6FsjSniRREOsaxhUiazFU1dfVynnZxZxhDUR3Qhr21KTbBrV3V/0CzuutrMT/CuNI
	gYyh8/fMU0CEOURVACKD/3hz0SKkXGGeRSg68q7o=
X-Google-Smtp-Source: AGHT+IHYvhVuQu3JkB4HjuaPSs4+WBMwwDAkSMFdp4aHblSEvg/m0jfxMexK7gmtMSLEueohiSNhCQ==
X-Received: by 2002:a17:902:e5c5:b0:253:65e4:205f with SMTP id d9443c01a7336-25bab92cc8fmr79198095ad.3.1757671965944;
        Fri, 12 Sep 2025 03:12:45 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa1c54sm4273352a12.50.2025.09.12.03.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:12:45 -0700 (PDT)
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
Subject: [PATCH v4 10/21] sched: add per-task KStackWatch context
Date: Fri, 12 Sep 2025 18:11:20 +0800
Message-ID: <20250912101145.465708-11-wangjinchao600@gmail.com>
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

Introduce struct kstackwatch_ctx to enable lockless per-task state
tracking.  This is required because KStackWatch operates in NMI context
(via kprobe handler) where traditional locking is unsafe.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/kstackwatch_types.h | 13 +++++++++++++
 include/linux/sched.h             |  5 +++++
 2 files changed, 18 insertions(+)
 create mode 100644 include/linux/kstackwatch_types.h

diff --git a/include/linux/kstackwatch_types.h b/include/linux/kstackwatch_types.h
new file mode 100644
index 000000000000..93855fcc7981
--- /dev/null
+++ b/include/linux/kstackwatch_types.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KSTACK_WATCH_TYPES_H
+#define _LINUX_KSTACK_WATCH_TYPES_H
+#include <linux/types.h>
+
+struct kstackwatch_ctx {
+	ulong watch_addr;
+	u16 watch_len;
+	u16 depth;
+	bool watch_on;
+};
+
+#endif /* _LINUX_KSTACK_WATCH_TYPES_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8188b833350..1b324b458309 100644
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
@@ -1481,6 +1482,10 @@ struct task_struct {
 	struct kmsan_ctx		kmsan_ctx;
 #endif
 
+#if IS_ENABLED(CONFIG_KSTACK_WATCH)
+	struct kstackwatch_ctx		kstackwatch_ctx;
+#endif
+
 #if IS_ENABLED(CONFIG_KUNIT)
 	struct kunit			*kunit_test;
 #endif
-- 
2.43.0

