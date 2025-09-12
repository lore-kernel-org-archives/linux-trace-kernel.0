Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93512E2EE7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672015; cv=none; b=NXyy4L85qXDrEy6UWsxb4q56Inko27ylSU6dNx47ctDbs3rYRuV/fTM/jGS4TAnFy4xRv2E9O6NYI56FESZdkA0Ss5eoPKeqCmBj+lNmQhd5Phf/SQIOabk+0w1K2GzHLAJVeHQkSCHOH+9yPDqgAUbCJP8Q5OtETTsOTIJSCwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672015; c=relaxed/simple;
	bh=CEdClddGjVYx6HjPNGBFPBiAS3jsMfpyA1eRZqyA0js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRM0yrGFmOwczVsZtbe0Ma25Nsw1tdgygzIao/nhfuw9Ass2rrY9dWbOnGtDm3IO/KSl9FYVW7BYh8aCf0WTSIM3XcVwaS6iueJc34rbjWEd2JBmpo6EVLkFF0qXd3mL0+Wg0cqIB/3gXeWK9Xdr31xwmVJK8+gB2ZfNGdSZSYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Phu1ClwF; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Phu1ClwF"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4e84a61055so1164390a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757672013; x=1758276813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqWZ4PXPvcwGUSVpTO1OvKWC6TpQO7QLp3apqR6W4A4=;
        b=Phu1ClwF/WaPaErJMaPhPDE6D9pREb2vKlFKCLG5/QTZ5EdiId+kOCcrawUXVD8G5V
         Pqqmk5rFdMAPtDfGRKFTiKiak4JjE+aqt4sg0bTSJqBnr8RV3L5xuG83kAtC94UpfP+n
         85uQ/GHXtIx0dXdxFQvzbKVNKIoBgBXmr3jAQrlCBtpz25JZf1gA0UAPXwbi0kan6cNQ
         YBwVyySuufVCMJYdzT04jsSuShSH2IqpDjs24IJrY0Jxs5EZkMKphHYKfJhhLzdJNEVL
         TQFy49G2jYxADX+XY2xkM5tK5UO6JYKAL0AEiEVzPr8dJNk6v7iQjw85MFvB6oG5vJ/e
         cElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672013; x=1758276813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqWZ4PXPvcwGUSVpTO1OvKWC6TpQO7QLp3apqR6W4A4=;
        b=isx6tMv87drP6zgtsrRcbQORwAx3j5isAT7HMaeNjvZ32pzYJ+lxk7bl3ufrKNqCHg
         Fovvbl6p04K9uSroeaCymC1cVNd+4Whr2X26J6KPsE7Ft1AIpzX0Gf0tOy5rhLjUt2Mw
         382wZ7mF9DpLAaw73VUqjN8jL1CbAQAWH6Kax5CFEO9d7g1a9+KG4rPvhnFmXEsPPUB3
         GfwTLOu7xRjjQ7YZPnH9hseOYOJzBJ3Md1BJzecP9rFsX2bakDirJYMuI/+mBU0KcoYh
         YDSDK1xNT65kc0X+rDGGZVRFr4UImVAmB0JJ53zBaY78356f51Keo+zV3zSnehl9M89L
         ppUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX24V6f1/CQhYxQ3e52lU/4PRsNdoWmfKq/cY09/udfQVosPBZNWplAVoHgYvb4k7u0r7GvrGo2XqNsA485CihbusQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBd0amnyzIqWEFXVa2chs3Az1LI9dUrhniLwSd+W1akMjyfNSs
	UcLsRgXgA6HWtjjweYiJDLCOfbK7y8O1/ATenrA3d2cDi+MA5wgIgslb
X-Gm-Gg: ASbGncu6oYahEp7enFZTVitcj8oPJOVYbTCAenIwlYnwSdR5aCo+g53a1Q/AptzpmuE
	P8NxbLu5a9keAdt1griiDaV4aG0mmIv2WOUZ0sCLvGMXtwXkA6fBP4YxkkdM+9F9jVmntvy+JXX
	LQr+LWjc/3WOVRziSumjSO1UE65keIg1++eU3POo1LpC2kNvZLBGbiZ7kQeuUqPncRCkHAFZvkr
	w2bsfx5msEQ9Zt/bGPMEz9OoXDLfnRak7FLUz4eW2WIX5femKFJ6EQEhQhcshd7asLc1eE9PXDJ
	p3kvheBm4snQkzT0R7F47wreZCkmTBnzzGRtiYy0HuDibfRe8JDy5PVOTa6zwU3fHxK3VUV3XAL
	FbgWlqXGTXcW84zeFvkUxSIDJII1l7+yspSQ=
X-Google-Smtp-Source: AGHT+IGdi0rU6u6yk/5j3je0obUk9yox4MEj0mpe+W9QIz9sLwr6j5n+alC3GBSeGbtzXzFiSEwqsw==
X-Received: by 2002:a17:903:37c4:b0:248:811e:f86c with SMTP id d9443c01a7336-25d26663209mr26113005ad.34.1757672012838;
        Fri, 12 Sep 2025 03:13:32 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ad33e1esm44309995ad.105.2025.09.12.03.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:13:32 -0700 (PDT)
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
Subject: [PATCH v4 19/21] tools/ksw: add test script
Date: Fri, 12 Sep 2025 18:11:29 +0800
Message-ID: <20250912101145.465708-20-wangjinchao600@gmail.com>
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

Provide a shell script to trigger test cases.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 tools/kstackwatch/kstackwatch_test.sh | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 tools/kstackwatch/kstackwatch_test.sh

diff --git a/tools/kstackwatch/kstackwatch_test.sh b/tools/kstackwatch/kstackwatch_test.sh
new file mode 100755
index 000000000000..61e171439ab6
--- /dev/null
+++ b/tools/kstackwatch/kstackwatch_test.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+echo "IMPORTANT: Before running, make sure you have updated the offset values!"
+
+usage() {
+	echo "Usage: $0 [0-3]"
+	echo "  0  - Canary Write Test"
+	echo "  1  - Canary Overflow Test"
+	echo "  2  - Silent Corruption Test"
+	echo "  3  - Recursive Corruption Test"
+}
+
+run_test() {
+	local test_num=$1
+	case "$test_num" in
+	0) echo "canary_test_write+0x19" >/proc/kstackwatch
+	   echo "test0" >/proc/kstackwatch_test ;;
+	1) echo "canary_test_overflow+0x1a" >/proc/kstackwatch
+	   echo "test1" >/proc/kstackwatch_test ;;
+	2) echo "silent_corruption_victim+0x32 0:8" >/proc/kstackwatch
+	   echo "test2" >/proc/kstackwatch_test ;;
+	3) echo "recursive_corruption_test+0x21+3 0:8" >/proc/kstackwatch
+	   echo "test3" >/proc/kstackwatch_test ;;
+	*) usage
+	   exit 1 ;;
+	esac
+	# Reset watch after test
+	echo >/proc/kstackwatch
+}
+
+# Check root and module
+[ "$EUID" -ne 0 ] && echo "Run as root" && exit 1
+for f in /proc/kstackwatch /proc/kstackwatch_test; do
+	[ ! -f "$f" ] && echo "$f not found" && exit 1
+done
+
+# Run
+[ -z "$1" ] && { usage; exit 0; }
+run_test "$1"
-- 
2.43.0

