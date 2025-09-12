Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6B82F2906
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672011; cv=none; b=inEdvJVpCrWCVmMajyZhMV0rFsk9+5Owro6dkSxgQZyxpFXrUfeKMFWGkPO2TtCFCho/x9YL2CSfuMh6my6oubNE1pxK85U6v+BnDPfwM+Jktc4skOrxK/7GsBUS+sejMnZT/e4SLg2oqesTwqtNOYyakMqzNZ9sdTLIM9IayOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672011; c=relaxed/simple;
	bh=k6timgyy8B4GPUl9IUPi95Oa04aVieHJCexEN+DVT5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkZNS5BwDq9hvonx2iH2dFuyzraoxPI0GzK6sL1yUp9zdRESWNaockZ++oVFcwOieAy7AQ5VT3uBv69ADC4IKkQZPi7IVxW2mqKAkMOlIZlMNgAywSH2nTUO1P5caDcgzbIA7uUnN9YdDsquUAh7oy10ZHUBay7URbmGRy5fijU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwL2Tz0X; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwL2Tz0X"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-25caef29325so11980485ad.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757672008; x=1758276808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5u/a2s8j5yqiSFbkPas+Re9l+zCPojPRf0oLtuMcdk=;
        b=MwL2Tz0XVsS+r5ozTCrIlMb06yMsEs8UVob0h1JVcrLV+Z3G355tyMmhBvyDldpfwO
         gn8PhuE70WA82Rrf4h+uTDiOkgIWnz+qN9b/HBSlPHHODyImOSkbwI8dMr7G6Z/iojfn
         hDKzeJLbX2gJ/Rmk59EpxX5GRVhwBdoqmH8OpjlNd7GyliXwnoeXtnl8MWvA/n9VCiHX
         GTovlx31S0rHMtYXf/Za7qkPTd091638SUjb7coZoMWdvCv2h8PJm867sYRfE2+uL7xN
         yUfme2a6ytDj7+yW4s1GG4ZDlEa92fHzLZPjEPvVTJMXE/lKW2GqRv2d+iZufspPfZYF
         Jwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672008; x=1758276808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5u/a2s8j5yqiSFbkPas+Re9l+zCPojPRf0oLtuMcdk=;
        b=iUXGzH9nMybv22k/fV1J9sQUbsVoBS6QswCTI7BDBk/FEZ+zaCEEB3CeXmPVyNGcqy
         BbwO7k8Sdx7Q/JRjSBXHBMDrhq1fANnGSpx6CY/8u2lUP6iEa0qL1Vm8P1u/xdk21VJ6
         rfWphCRBSjaqb6kORlZ8JTSSvgGo2EYpfmHwO6dkTL/ututVJsGX2njHYyVX8RkixBqu
         rpINtfA/GM2+VaMI+hUGFhUZ9VIko390EuiV16BsZPQFtYIz1U1DDGijJkm11q1Qh+BD
         mHjt7mnm/2hjKouNUFhqaDrlymTnem/lOAVniq/oEIKM15F4ydiF6s9gH+XACHHYH7NC
         eEwg==
X-Forwarded-Encrypted: i=1; AJvYcCWsibbPj1T8tJZlVlN4q98PY2hA19sjxBVm6xtFW79IfgrZWkmhs18mZyN4D2HACH5u4KjfXOwPJdlP+YvXQkWzqr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5YsFaMzOIPRtoiBNY97NFzwrGWmkVjOrcig53WQ2qs66E3f2s
	VSMcASegIBQ+I/5VghPnYVX239SToNawv2Ih1ZBGya7ft0clcft8ZptH
X-Gm-Gg: ASbGncsmp6MPz2G4x7aaVkjYuwiJUIsRlASMT0e/C8Tjos2qZcKfOV8e5Q3SDKC15YT
	WnnQS9tPErzyNnTbBtULpvqKuLnT/bfnSTOv/78VV1p1Uzy0A2C9WrH134NoXWDkPtkUpdHwAT2
	lVV5ohC5bRF7+BKZGlvDMkF/6DzPLWYcWxcHF7AoyiGWhCI0s6/3dSHHsXEPU528trP76NE2dW9
	VdI2p/CZB2R45S0V99mzojpZAEOaWDcsKaeXeKR8TCOCC78fvSA90LQZ/N00lYcwoBm/iyqWFr8
	7JPNEAWhsbhodwZTUw86QE/Gf/e63eCRy4a/XXHn5TdAph5M6/sPcGYKJfVRZjxwyoO4DBCCELE
	BIg48DgaAmhl1w8rKRP1d873P/bKOs7ubP3U=
X-Google-Smtp-Source: AGHT+IHfq4U4MFqDIc6ZxO6yNatWwL7n6+/zPGuAMGcOfOLtnumo4rnkiu74aB1UWkUMdayihYaGMA==
X-Received: by 2002:a17:902:ebc2:b0:24a:ceea:b96f with SMTP id d9443c01a7336-25d24e9dc1dmr34403925ad.24.1757672007735;
        Fri, 12 Sep 2025 03:13:27 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd9509002sm5179465a91.0.2025.09.12.03.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:13:27 -0700 (PDT)
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
Subject: [PATCH v4 18/21] mm/ksw: add recursive stack corruption test
Date: Fri, 12 Sep 2025 18:11:28 +0800
Message-ID: <20250912101145.465708-19-wangjinchao600@gmail.com>
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

Add a test that triggers stack writes across recursive calls,verifying
detection at specific recursion depths.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/test.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/test.c b/mm/kstackwatch/test.c
index 2b196f72ffd7..3e867d778e91 100644
--- a/mm/kstackwatch/test.c
+++ b/mm/kstackwatch/test.c
@@ -150,6 +150,27 @@ static void silent_corruption_test(void)
 		silent_corruption_victim(i);
 }
 
+/*
+ * Test Case 3: Recursive Call Corruption
+ * Test corruption detection at specified recursion depth
+ */
+static void recursive_corruption_test(int depth)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("recursive call at depth %d\n", depth);
+	pr_info("buffer 0x%lx\n", (unsigned long)buffer);
+	if (depth <= MAX_DEPTH)
+		recursive_corruption_test(depth + 1);
+
+	buffer[0] = depth;
+
+	/* make sure the compiler do not drop assign action */
+	barrier_data(buffer);
+
+	pr_info("returning from depth %d\n", depth);
+}
+
 static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *pos)
 {
@@ -181,6 +202,11 @@ static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			pr_info("triggering silent corruption test\n");
 			silent_corruption_test();
 			break;
+		case 3:
+			pr_info("triggering recursive corruption test\n");
+			/* depth start with 0 */
+			recursive_corruption_test(0);
+			break;
 		default:
 			pr_err("Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -202,7 +228,8 @@ static ssize_t test_proc_read(struct file *file, char __user *buffer,
 		"Usage:\n"
 		"  echo 'test0' > /proc/kstackwatch_test  - Canary write test\n"
 		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n"
-		"  echo 'test2' > /proc/kstackwatch_test  - Silent corruption test\n";
+		"  echo 'test2' > /proc/kstackwatch_test  - Silent corruption test\n"
+		"  echo 'test3' > /proc/kstackwatch_test  - Recursive corruption test\n";
 
 	return simple_read_from_buffer(buffer, count, pos, usage,
 				       strlen(usage));
-- 
2.43.0

