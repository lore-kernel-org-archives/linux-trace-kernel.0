Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93A130596B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714741; cv=none; b=X4DlO5kdLUMzsR7D3SK/F8ntiw7mXIX4YvJFx/SNM6DQpFwgXpKvGbVq58QUqK0sr4EYLtq4Il2O5XI9RjrzU3m00u/XPF7jIgoyjoYEb26Ne8YHp8SUJQphKvlnOrEqwRSutEWwt1mdyXFrvuCB4N4h0l59z+WA2XRmEQ1R/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714741; c=relaxed/simple;
	bh=wmwmRtcPH4ST6Dm0G2/AFHsMnlz3q9k9yRWhyo1wI/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSL+pvBbP6XRwzvtgIwv9pmwJFNCO4R8WHje33lfXsUIjl2c8EsekW94HaYjWylnxsR9+9bxAvXCYr8g/hH9kBjRirkCe+hy9jlQE040JJ+yniDt08EXLheMJoWhtuUqNDQ3PooKhH6qyo5pW8O+j3yIHXofBs+Xo8Qv+N+MwhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXCQ7oji; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXCQ7oji"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b553412a19bso2686003a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758714735; x=1759319535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4BKEfc9ax2ksTKKBAwbjubQHvBiDjA54WMJGQTptLg=;
        b=AXCQ7ojisXReGNvopgPMp8A0RZsJPR7y39gkdB+j20C1Kr39caCOI3U/8aJK0DzUBu
         FSvj5BAqshUcX8sqk5Z+XaCM83/KoVGvmTbVAGZqkbjAgnKvqcFr9Th+rz6QlMKMwNLz
         9ZpVxdrcYdND8pT5D2Ehx5k3nyDS+TMb6BaRPIwh41BsYcQlX4SgmzQ1MspkpBVSe/vE
         z3VsfdNHc+lT4vlYipGxa60SbjmCyRxdSk43cJCCD0t8Xh4qCpV2+SJUHBG7E4gWVKyn
         L3L6eXwieXXVo0BxL818lzuVABikbGk8NrAOi/97+qIeG2ld6Mrd2SRESAay+RCoQRjU
         imKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714735; x=1759319535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4BKEfc9ax2ksTKKBAwbjubQHvBiDjA54WMJGQTptLg=;
        b=tY/vv2XHqkd7u7t+z7SGou2L7+zpE3l/ni9i+iAWDRLpcye6zhRYDNBfzC6ncSF/Ow
         QR8L2wV+J/L+oeIuMbTwXgzssU/KJNq19tzBEfjYx1QBy3nAVGnPa1negSP0Pp5tYI5X
         0/kZVfvRf3b8+YPmieznW35D0qgOocOZaxuE9acxCitmsVyfaDxWSI1cHQfMRe3nSlD5
         0mRWJAhmpjX75HEnO1UtWzOg6R+aLi7GaFWciK+oBPXhat7Wt2kqw88N2aTaYB9SmbOo
         f5SLryX6tFA/NzjtHgk3LXzu6Wyi5gT2e2dHJ/afWilBNVSapDQ05KzJ4uwVUOE/GEUU
         c/QA==
X-Forwarded-Encrypted: i=1; AJvYcCXEXS95b0KNuk0KRgMjvE5n5C6OmpR7MIh6MAtlU2AMh+uQGv5SSaX8HHk/A81qZOrZ+PNm45yQ4EnKFVVmo7RIQaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWVQkDZMP91veIWqMx8u8Oj5SRgob2C5JakXNcQB4X/VnDrSC5
	ARkZ/eJF8i4vaosgQyevJRwoA7Yst9gp94tfa5yAeZY3ttRO0wPh3QNs
X-Gm-Gg: ASbGncvKVHqVYZ5tCO5EAuX1YvVTxZR0myrOelnjiVDCU0P/j922uZxGPi1n1ITTA6R
	Zg2wyoZjYiYJp+GrvcG0LuvPcofqaE74nl/Mpz5pfaga2JUhmx/j7ooc1PMPuytrz5io0+FQKda
	SYOFEFwTysugC9YkijY2VsPRegxlcdM4lrrq/EnEkZlE3xtRxTks6oLQdBzUckguJip/WSVklV5
	oIRwetdD5Yi9nJNeLipmPDkBkAkgtrmGxmAa8TIX+Lf004zZefm+fxf5F97B7uPP2HuqiFMpnaV
	Nhqokc7Nh8n5b+w3bpwbp71CoGFlNzg1265Yd1uPiTbDtMl/6h9DPDin6suQsUUpKBI6RTN8Y5+
	QgJglf+ic8iEz18fp9RdFZHiPwA==
X-Google-Smtp-Source: AGHT+IEIPde70G75F7g+aLuFunwEIX4ciWCOE5JEZlKnHsvKJ7fdAzkwZXDsNRxc7SsbnaPx5zSyIw==
X-Received: by 2002:a17:903:8ce:b0:266:2e6b:f592 with SMTP id d9443c01a7336-27cc325ea9emr75331615ad.25.1758714734961;
        Wed, 24 Sep 2025 04:52:14 -0700 (PDT)
Received: from localhost ([23.142.224.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27cc8b251f7sm49110575ad.8.2025.09.24.04.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:52:14 -0700 (PDT)
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
Subject: [PATCH v5 11/23] sched: add per-task context
Date: Wed, 24 Sep 2025 19:50:54 +0800
Message-ID: <20250924115124.194940-12-wangjinchao600@gmail.com>
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
index f8188b833350..6935ee51f855 100644
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
+	struct ksw_ctx		ksw_ctx;
+#endif
+
 #if IS_ENABLED(CONFIG_KUNIT)
 	struct kunit			*kunit_test;
 #endif
-- 
2.43.0

