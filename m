Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5306C2E1C65
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671990; cv=none; b=SaO+gWp4Uib9/m9ILW2JmiPegegstgCvv9DfdcJD0R6aBRgc3+M+s+ULQV/+VTWWs2pRQIXAavo1Z/frK/fmi+v1NYvvqIECmVNWToJTZPV9ATXHgBqyCVMwaLW8SIfNoU3/xj/6gA1/MzBXbZ4XWrn9nsJIfzR492pH5ZraMGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671990; c=relaxed/simple;
	bh=ljHubFdo4RbY9sPZZpmIGXXQZrdiNxFcVGyARbY49GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJ8Vg3ZTvg5LMVeY1gw1Qf2VjucZ/ccQSb05CW0ydVNXPtLz8CCirw/HSfL0GnXeDMNakYBkIui3uZ/J8hJd5cBJZQab5Prl5yczRIsRpR/lmFhIFQ4tM8mE5mvivj93j6ngPNdiImC+vgZI0r+O+sZ8AxzOJTcnSzzN5zO7mOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDPSCdZU; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDPSCdZU"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1514620b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671987; x=1758276787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clh29CJb8P7VxnXXw4h/9gdA7sU+C9WtN5xBt8cm/X4=;
        b=IDPSCdZUUpOtAF1g097xo+JllyTdTsE6JXJrlMnaWPvAcFm+Byxx8HkfwMK2Ay7qhg
         yBS9gbB0W31nUnKN6faZ91ABd77++7zOZLhbMRZgm/rlORu4DnKMRkZh7El4jkaNwRlU
         tZdQpoQLvNTx9UGq7GCegQB0tUBgb8ggjiQIroUh2uVAxkqX7WVIqy961kqGuGasz/Vf
         I0I+Ps2IciMECyInMUAH1SXckZetPLXGkUtE0mSUlcPL7+lLZegw7xcYudczi23IUdMd
         98fgrBf9hBhJ7tTapx+kiRhcgejl4+jOdRZze0dk69A6uydoEI/9rj5W6Gjqsr31VR0K
         WKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671987; x=1758276787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clh29CJb8P7VxnXXw4h/9gdA7sU+C9WtN5xBt8cm/X4=;
        b=l7bxgBbuuesCuu1XTNKijc77jjiPcC6fC7xavEfdwntnJtwZhqpRWYpIYpAilZInhw
         aBlsiT8oxS0M4TG17dpXW2LBnvDMNe3QEXOSZVnO9c3i4pMDtrBZC74BdCHQtePp8la1
         9Lk7VnZIVfGovD17723asvpsMt1I/37muRXbYzjPrmxHxEgL9tx7ZVNXcmDHA9YOE5Nt
         pTpXRRsFiP0Dntdo8KleSmhU/exttadzt0iQ+LAYFuf91MoZYHmbyyLJbHJtTM07dZYJ
         rvQEriLrdPjnWB15HP4MUzhkCTDyQ2V5+w5NPsP7+M3cmWS/AgqMBzaFQp5aRttaRstj
         aJLg==
X-Forwarded-Encrypted: i=1; AJvYcCUbmM3XT1N8y6EOVc8NbK75pRoxC03Mi9/GyJkydq8LXZf0g/UD9Fl1gImIhR8fRGvDNrB5XcCMIRWl8GLo8UIuPlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3QgaLEnWmb9QCZgAXWSDOE9OADl1FriPkUlnTsilPnr7eRr62
	4oX9ws/j9Janp4t60d4buamKwSS8zZQpDgWYUg7zKTxmOvgigMFyN9wu
X-Gm-Gg: ASbGnctd8G7PYjc3upHsskQrbWkw6BjsFKoRQHmG40R0haXZSByIhQre5KiWrG4eFJt
	4LYhOpclt73MPI2ZkEXDpnYTdDLNXND+FWeW3hl9VO6ikrVi2FuWbRQnhpazZbJJHNQYug/qOSb
	erH7fN4ZpN8OhelfNzaKtabrom98CA9UTZZoSsrdZGZSI/Zxye8CU/NyWg2MEvqveRZnYm59jKd
	N/02neScjzWLv19YN6lHSBYfUad+WfnkEvS84x6KOz27U0A5tuscdWsu7jpbzxSjhAyJF5I1jt1
	FpKlF9CkQwu6NTK1SOhsP0tqz9Ek8ONKYdrOW6jqW0pJcXXPFkLu9OCkNBHexTw+I5/DL5QkIUD
	hu44807bqVkLVVdulf3B9q2rcm47iKd7dOTI=
X-Google-Smtp-Source: AGHT+IHaEUea7hRsSpqZl85bTv6q0KsvHQdzV/MeRfkpCvkL2MgkVHPyR0dQHBXbAqMEfqsEXUoPVA==
X-Received: by 2002:a05:6a00:982:b0:76b:d869:43fd with SMTP id d2e1a72fcca58-7761216815amr3249434b3a.18.1757671987091;
        Fri, 12 Sep 2025 03:13:07 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b6b1sm4934804b3a.20.2025.09.12.03.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:13:06 -0700 (PDT)
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
Subject: [PATCH v4 14/21] mm/ksw: add self-debug helpers
Date: Fri, 12 Sep 2025 18:11:24 +0800
Message-ID: <20250912101145.465708-15-wangjinchao600@gmail.com>
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

Provide two debug helpers:

- ksw_watch_show(): print the current watch target address and length.
- ksw_watch_fire(): intentionally trigger the watchpoint immediately
  by writing to the watched address, useful for testing HWBP behavior.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch.h |  2 ++
 mm/kstackwatch/watch.c       | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 5ea2db76cdfb..9a4900df8ff8 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -47,5 +47,7 @@ int ksw_watch_init(void);
 void ksw_watch_exit(void);
 int ksw_watch_on(ulong watch_addr, u16 watch_len);
 int ksw_watch_off(ulong watch_addr, u16 watch_len);
+void ksw_watch_show(void);
+void ksw_watch_fire(void);
 
 #endif /* _KSTACKWATCH_H */
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index 795e779792da..2e9294595bf3 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -161,3 +161,21 @@ void ksw_watch_exit(void)
 	unregister_wide_hw_breakpoint(watch_events);
 	watch_events = NULL;
 }
+
+/* self debug function */
+void ksw_watch_show(void)
+{
+	pr_info("watch target bp_addr: 0x%llx len:%llu\n", watch_attr.bp_addr,
+		watch_attr.bp_len);
+}
+EXPORT_SYMBOL_GPL(ksw_watch_show);
+
+/* self debug function */
+void ksw_watch_fire(void)
+{
+	char *ptr = (char *)watch_attr.bp_addr;
+
+	pr_warn("watch triggered immediately\n");
+	*ptr = 0x42; // This should trigger immediately for any bp_len
+}
+EXPORT_SYMBOL_GPL(ksw_watch_fire);
-- 
2.43.0

