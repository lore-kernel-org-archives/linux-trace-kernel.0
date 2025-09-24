Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3892F24DFF4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714737; cv=none; b=QU9fAg+WFni+c8cqEg4RPb7n1xTgroKGGykpquQntioZb5bBIhwwNc6nQ6YRCpi02k9k3R+I5wnJSjjGbx64CRFZIkC5vaQwkPTJyGcKur9NDETymIVJhN8iUosM6wTtOlEuSoIJGFW6fus33WUcpXiDywnS0x4Dt1MlhKUwmq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714737; c=relaxed/simple;
	bh=EtuMaKP8CWfi9pjY9FcQGV9HEHi4WtiOKMPT566R1T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IU7zXvrbUS5R+rgIoFEJh0EdG9fd2YWAqA0HjuiSjFg9I4IC0TBR9DN65ql2HK/5ancpm8h6kzQWgkc+2A0HaW6qPCMkBMrYeYTqHWZh0huvIuz8+/X5H41kVKQ3QFyHeL7TV16aHS1zsBsEWEjI1Pm35wguyzvN68Y3H072QJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KadITuav; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KadITuav"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-279e2554c8fso34136045ad.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758714731; x=1759319531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VplC5p74+BCL3Xjzqw2UL/AL1hevTQUKrGPaYOT40mY=;
        b=KadITuavOA2ZmCjJymWSBloH7MHKJhTzOxSIBdRu1FkjkiP29qrosSqXUEPQlFMyLs
         AoQ7Y7As/bc2Hu9BKtRbo8IXLVzg8m/8eg36xI/JzJXCJZwichsTS82hJ9rrgvH73HTn
         iv652MEycbMu4T/2HhU9eKlF9etjgeImW09rguRcU8I3gCpnhO+8o3wBo6GBY0c21Rh4
         s+uz24ctoCl+ogVBkKYZZcFO4wwhZi0RSU1CNE0PxfJzS5geUElVPuwlw+5H4JdiVOeK
         HrvWswubwt1KYoAq/nUTpmUgUqNbF8aqej2vWvo1dNqcfFtOWz4QnbDnGE7SnNY87Cpd
         4VXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714731; x=1759319531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VplC5p74+BCL3Xjzqw2UL/AL1hevTQUKrGPaYOT40mY=;
        b=PZxuN0/ubLESSoAWuQOd73BK4EiCXySYBf6t4Fcycg6hBkkioLInDDic8Iz0DvRPLa
         Oh/wtTiyKENhcLeRUPC6nXYKbWMMvT33JV+bi7U2Z2lhHwxvnP2AT10deFr6ixzqgHQL
         LZDp518+0wNb+6yYy0Y4WXIPVI+6p57dDExyBeaIS7cWrgreoiEPZ4fulfEosoiL/Awn
         mtIycESnrn/Koe+qLZMWR1C8+pmGT3HgQjoZ7fUexxrEQUJl7fP/dHMPy9Du1QUoiDrQ
         gwsWpEDSr+W9ndM8pyCHMxJfewvGJ+o12hmiFnNpu09Y+GxaYkmo99iM7s+bpdlNCKkw
         kF+w==
X-Forwarded-Encrypted: i=1; AJvYcCXiCIgthnFTZmDqo8LM8+J3BmIV4EtXe51Tk9asFKULNQpYBirFpETWJQKyIT0JhV3pnBsliROzbCaByTCx9fOms5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEW6vDaaUjlArPIX8Y7JGoZGWTyWUDsuo7neqOtEG8R2kmREHK
	bI/8+Eky6JoJ4xlgLxaZEVwew9P1MX4jbCQpTRVOufNySr2YGxF0Y2kJ
X-Gm-Gg: ASbGncvoBBV216tQI/bi8Qm5R6t5n/6eSU8mw7z/0NDGTVRNXf0E1+Z+ZT8OxcjTJRh
	lOXR2+fD/zqILAvojE4ZL3gp7B0GnNXjpBoWPUJDs8p+v5fCijhzC27wv4oCEKQJsnLjZuxJ6kj
	SiyQhguxr1BLv9MhAhuc3UwkU/0rq3jHTHw/8jDBC/0eslh2Gaw9MSsTIZXvTULktlN5i3lecsh
	zL87XchMStfg2AGwp50ObbfuAKuNQfzcs5jpelsiuCs/VqogK/mJGMrslke4GTnohvOwFyfj7e6
	vvO7CiaoTadO/vRiyZgjs39/xShPlahmAvfy5y/NWdmq2IoDwvC8tSsj0KF9mPeEeWP0ZIZ0xUf
	VtdIoReesGU7laArJAdewRKQoIA==
X-Google-Smtp-Source: AGHT+IGFrnEbp9Ui8MNObSoQqRzgjbRIw9qZ/ysMx9tVm7YuXfu+8QvxKGGvJ7LyD8Oz3yVl/creWg==
X-Received: by 2002:a17:903:230a:b0:273:31fb:a872 with SMTP id d9443c01a7336-27cc2aa7dc7mr73054015ad.6.1758714731497;
        Wed, 24 Sep 2025 04:52:11 -0700 (PDT)
Received: from localhost ([23.142.224.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ec0eb4293sm18798485ad.138.2025.09.24.04.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:52:10 -0700 (PDT)
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
Subject: [PATCH v5 10/23] mm/ksw: support CPU hotplug
Date: Wed, 24 Sep 2025 19:50:53 +0800
Message-ID: <20250924115124.194940-11-wangjinchao600@gmail.com>
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

Register CPU online/offline callbacks via cpuhp_setup_state_nocalls()
so stack watches are installed/removed dynamically as CPUs come online
or go offline.

When a new CPU comes online, register a hardware breakpoint for the holder,
avoiding races with watch_on()/watch_off() that may run on another CPU. The
watch address will be updated the next time watch_on() is called.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/watch.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index 722ffd9fda7c..f32b1e46168c 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -89,6 +89,48 @@ static void ksw_watch_on_local_cpu(void *info)
 	WARN(ret, "fail to reinstall HWBP on CPU%d ret %d", cpu, ret);
 }
 
+static int ksw_watch_cpu_online(unsigned int cpu)
+{
+	struct perf_event_attr attr;
+	struct ksw_watchpoint *wp;
+	call_single_data_t *csd;
+	struct perf_event *bp;
+
+	mutex_lock(&all_wp_mutex);
+	list_for_each_entry(wp, &all_wp_list, list) {
+		attr = wp->attr;
+		attr.bp_addr = (u64)&holder;
+		bp = perf_event_create_kernel_counter(&attr, cpu, NULL,
+						      ksw_watch_handler, wp);
+		if (IS_ERR(bp)) {
+			pr_warn("%s failed to create watch on CPU %d: %ld\n",
+				__func__, cpu, PTR_ERR(bp));
+			continue;
+		}
+
+		per_cpu(*wp->event, cpu) = bp;
+		csd = per_cpu_ptr(wp->csd, cpu);
+		INIT_CSD(csd, ksw_watch_on_local_cpu, wp);
+	}
+	mutex_unlock(&all_wp_mutex);
+	return 0;
+}
+
+static int ksw_watch_cpu_offline(unsigned int cpu)
+{
+	struct ksw_watchpoint *wp;
+	struct perf_event *bp;
+
+	mutex_lock(&all_wp_mutex);
+	list_for_each_entry(wp, &all_wp_list, list) {
+		bp = per_cpu(*wp->event, cpu);
+		if (bp)
+			unregister_hw_breakpoint(bp);
+	}
+	mutex_unlock(&all_wp_mutex);
+	return 0;
+}
+
 static void ksw_watch_update(struct ksw_watchpoint *wp, ulong addr, u16 len)
 {
 	call_single_data_t *csd;
@@ -210,6 +252,16 @@ int ksw_watch_init(void)
 	if (ret <= 0)
 		return -EBUSY;
 
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"kstackwatch:online",
+					ksw_watch_cpu_online,
+					ksw_watch_cpu_offline);
+	if (ret < 0) {
+		ksw_watch_free();
+		pr_err("Failed to register CPU hotplug notifier\n");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

