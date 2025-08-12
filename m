Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D642F7475;
	Tue, 12 Aug 2025 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755019319; cv=none; b=Hs034Js0ae8jcO0r1cNmr5/OY0rZcrw0VKN3pf2+u1fp8rFg84ilzjrrRos5/9XjPoWxYrWmsFptgn9vPF9TAB1RnpKoeWvg8jyMgPTwttqQe4cnGvIEZAL/f7m2Kddyp5vXlAUye+Z6HNVP1+25hyCTdxLwxxVxYzL92L93NyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755019319; c=relaxed/simple;
	bh=LwOM06oyJ3mvRmM1qS+z4Xx/tVIHy6t1yyC5hj0ET7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDcJMHkv6NcimwjjEP3gq1BQvGdGoY2TNx74we+EqP/y74ReuDzDG7XCvy4q7d1rm61wLvwGfX8293aJdhzbPxnyZJhQFHPupjevZSPvXDWNSU+MtshJOBMig5BB79PGcQg/NcLaHDr+SMLkEeNQMuM/CsfvNQ8/79mQPG19Hjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTs4zlPQ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTs4zlPQ"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e849d7a292so286952185a.3;
        Tue, 12 Aug 2025 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755019317; x=1755624117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjGmbNR7gAZNxscPO3ZTs76U8Kdh+Ee956niV2hTpvE=;
        b=GTs4zlPQkM9GRivcfb95K2p1w+O8sql2aswtDcS25FOch5IEPU8G85bXdNcJAG8d1T
         +J4E2uk4TLX+fCS2KYElbwuv4dzTFvpcAG6ZlxCeSezo8TkkgSRuEkDUAGB2NPkEdPWO
         EoWJvYtYMKmwDR/6Bu1d+oWTl7r3l3mU7ZIrE3kNc9myXl4ZLBVfNJSNOC8y0u///fdV
         QAWVl0+n1jkFCnt2NV+2Fy33Ct75rO6QYXPOd+I/LCX3KzVwQHYKfMop0ESIwgJKia23
         TUUYcSm9H0Ofs6+e7aFffMjhbOLHzgsdM/1+yCTXCfA8xKA04fHb32Fl3/ojaRXf+Tf2
         ugRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755019317; x=1755624117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjGmbNR7gAZNxscPO3ZTs76U8Kdh+Ee956niV2hTpvE=;
        b=o1sIELumBo1Ag95OFlhfgoMaYTcvQugGeDUBVlvGAd0lX3UZSFhsdF3vk6DEqiT3Ot
         N3KPFnWmm/4rSwDi6uhnbHeVBypcbYC9Uw3V9AIYkqi5hT33ABOYV26QKH/qwKw1+lT5
         BNmTZvDHdVnAEX6YQHZAoLZXA2pGCjQV6hmmUQDZFdIJaHmigFLD77za2ywKS3nSo9L7
         cdz+vMxVnLwiNqU/KPO6HB1Gn0H7LQC1+HDzscB3OcSnb8E6hD8TjBc9yQ5R8IgiN1JK
         NRN/EWrB4vwN3ecWER9IoDijNQed+iqfsBaBTtcPLwD5+/kIBNx/89ryBsO4ixpVPnRC
         ddZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmyJskvhBM/7IsOYCKIKRwmEQ9ypWnQ328bwqTyOaLmkFvkNl1NO4NpKlwWwrtl/o3qujL33BMJq6v6KX7@vger.kernel.org, AJvYcCXrGLYsnb5jBTjchyJ7O25Cs6KL2RbuPx8xvadPkauOV2fliHKZmgEFd6xM4BuTQFWYMHUFvVVbQfqtlmxgY2yW0hYW@vger.kernel.org, AJvYcCXvhl+Jo+JOdpNlNfj2M7itnJkz13ut6yGTPAOST10PdtFD1tr5bBfyEwgf4H2OWxCNMahUDNzbv6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ6SsHctIrgoXdGm8su2KhqduqvmmoSQCxy0tWratIl8/894t+
	Xj+vL8L9/3MF9gu6gM1U/xf1BUfby3YzW63di1E1MUN0hoDocnbnLMuG
X-Gm-Gg: ASbGncvkx603cKoM/naroFCNvYTtbHOJIt9sqI1CIY9uDPiwJybvSGWB9bfG5QrasoM
	SY8mrOXDCwPe/lh53zqJuUmA0lNFe5cxWZnTrFHodyudoQXBzMNXnbx2BfiWknHTtgxW/c+IU8D
	ob5hdFiUsRv+e125W0eIcwgs2jvAg/i4UXG2noG2fNbKf8e56zxWJeMlMyakI/arfrrPszL8Cw2
	J3nVPyw74Xho3dX9YqvQHJ+rwXZ+lfDFEXTug5QTQGOaqoLhjwtFN36UONtZyJi05KDJ80qZsA9
	yPxmU3i1PptHq5WxMMf1Wr8oYp/pnZAFElQwX4/16IuUikSNlzONDXczvfrXuXViR7jUFkrcT1K
	lUSvGo2Dw12VNXexkF7kd8NrNf+L/DSoIs+Ve+tkUYCmChn8HGhtE3T5GA/SBH/WrXCCbujb7EF
	B0WYVGGGjOf507
X-Google-Smtp-Source: AGHT+IERbBrmkOHPHPRdywR8hNkIHSu+rbHhBXn29n3G2KrcXN48dQX6G0l4aEvSoci63NIJMimVkg==
X-Received: by 2002:a05:620a:454f:b0:7e8:12c1:4d5b with SMTP id af79cd13be357-7e86529cf7bmr2953985a.6.1755019316471;
        Tue, 12 Aug 2025 10:21:56 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.mynetworksettings.com ([2600:4040:530f:f000:a841:61f7:aa1f:bc8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e82a1ccbfesm863457285a.51.2025.08.12.10.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:21:56 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH v2 2/3] rtla: fix -C/--cgroup interface
Date: Tue, 12 Aug 2025 13:21:09 -0400
Message-ID: <9394c039d5c957bd8417669148391e20fa1276ee.1755018581.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1755018581.git.ipravdin.official@gmail.com>
References: <cover.1755018581.git.ipravdin.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, user can only specify cgroup to the tracer's thread the
following ways:

    `-C[cgroup]`
    `-C[=cgroup]`
    `--cgroup[=cgroup]`

If user tries to specify cgroup as `-C [cgroup]` or `--cgroup [cgroup]`,
the parser silently fails and rtla's cgroup is used for the tracer
threads.

To make interface more user-friendly, allow user to specify cgroup in
the aforementioned way, i.e. `-C [cgroup]` and `--cgroup [cgroup]`

Change documentation to reflect this user interface change.

Fixes: a957cbc02531 ("rtla: Add -C cgroup support")
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
---
 Documentation/tools/rtla/common_options.rst |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c       | 17 +++++++++++------
 tools/tracing/rtla/src/osnoise_top.c        | 17 +++++++++++------
 tools/tracing/rtla/src/timerlat_hist.c      | 17 +++++++++++------
 tools/tracing/rtla/src/timerlat_top.c       | 17 +++++++++++------
 5 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.rst
index 2dc1575210aa..3f292a12b7af 100644
--- a/Documentation/tools/rtla/common_options.rst
+++ b/Documentation/tools/rtla/common_options.rst
@@ -42,7 +42,7 @@
         - *f:prio* - use SCHED_FIFO with *prio*;
         - *d:runtime[us|ms|s]:period[us|ms|s]* - use SCHED_DEADLINE with *runtime* and *period* in nanoseconds.
 
-**-C**, **--cgroup**\[*=cgroup*]
+**-C**, **--cgroup** \[*cgroup*]
 
         Set a *cgroup* to the tracer's threads. If the **-C** option is passed without arguments, the tracer's thread will inherit **rtla**'s *cgroup*. Otherwise, the threads will be placed on the *cgroup* passed to the option.
 
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 8d579bcee709..298640d92434 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -435,7 +435,7 @@ static void osnoise_hist_usage(char *usage)
 		"	  -T/--threshold us: the minimum delta to be considered a noise",
 		"	  -c/--cpus cpu-list: list of cpus to run osnoise threads",
 		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
-		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
+		"	  -C/--cgroup [cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[file]: save the stopped trace to [file|osnoise_trace.txt]",
@@ -559,12 +559,17 @@ static struct osnoise_params
 			break;
 		case 'C':
 			params->cgroup = 1;
-			if (!optarg) {
-				/* will inherit this cgroup */
+			if (optarg) {
+				if (optarg[0] == '=') {
+					/* skip the = */
+					params->cgroup_name = &optarg[1];
+				} else {
+					params->cgroup_name = optarg;
+				}
+			} else if (optind < argc && argv[optind][0] != '-') {
+				params->cgroup_name = argv[optind];
+			} else {
 				params->cgroup_name = NULL;
-			} else if (*optarg == '=') {
-				/* skip the = */
-				params->cgroup_name = ++optarg;
 			}
 			break;
 		case 'D':
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 2c12780c8aa9..70924242bcdd 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -269,7 +269,7 @@ static void osnoise_top_usage(struct osnoise_params *params, char *usage)
 		"	  -T/--threshold us: the minimum delta to be considered a noise",
 		"	  -c/--cpus cpu-list: list of cpus to run osnoise threads",
 		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
-		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
+		"	  -C/--cgroup [cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[file]: save the stopped trace to [file|osnoise_trace.txt]",
@@ -394,12 +394,17 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 			break;
 		case 'C':
 			params->cgroup = 1;
-			if (!optarg) {
-				/* will inherit this cgroup */
+			if (optarg) {
+			if (optarg[0] == '=') {
+					/* skip the = */
+					params->cgroup_name = &optarg[1];
+				} else {
+					params->cgroup_name = optarg;
+				}
+			} else if (optind < argc && argv[optind][0] != '-') {
+				params->cgroup_name = argv[optind];
+			} else {
 				params->cgroup_name = NULL;
-			} else if (*optarg == '=') {
-				/* skip the = */
-				params->cgroup_name = ++optarg;
 			}
 			break;
 		case 'D':
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 9baea1b251ed..2a48a076d941 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -726,7 +726,7 @@ static void timerlat_hist_usage(char *usage)
 		"	  -s/--stack us: save the stack trace at the IRQ if a thread latency is higher than the argument in us",
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
 		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
-		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
+		"	  -C/--cgroup [cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
 		"	     --dump-tasks: prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)",
 		"	  -D/--debug: print debug info",
@@ -885,12 +885,17 @@ static struct timerlat_params
 			break;
 		case 'C':
 			params->cgroup = 1;
-			if (!optarg) {
-				/* will inherit this cgroup */
+			if (optarg) {
+				if (optarg[0] == '=') {
+					/* skip the = */
+					params->cgroup_name = &optarg[1];
+				} else {
+					params->cgroup_name = optarg;
+				}
+			} else if (optind < argc && argv[optind][0] != '-') {
+				params->cgroup_name = argv[optind];
+			} else {
 				params->cgroup_name = NULL;
-			} else if (*optarg == '=') {
-				/* skip the = */
-				params->cgroup_name = ++optarg;
 			}
 			break;
 		case 'b':
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index c80b81c0b4da..e45d9978744c 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -492,7 +492,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -s/--stack us: save the stack trace at the IRQ if a thread latency is higher than the argument in us",
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
 		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
-		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
+		"	  -C/--cgroup [cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
 		"	     --dump-tasks: prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)",
@@ -650,12 +650,17 @@ static struct timerlat_params
 			break;
 		case 'C':
 			params->cgroup = 1;
-			if (!optarg) {
-				/* will inherit this cgroup */
+			if (optarg) {
+				if (optarg[0] == '=') {
+					/* skip the = */
+					params->cgroup_name = &optarg[1];
+				} else {
+					params->cgroup_name = optarg;
+				}
+			} else if (optind < argc && argv[optind][0] != '-') {
+				params->cgroup_name = argv[optind];
+			} else {
 				params->cgroup_name = NULL;
-			} else if (*optarg == '=') {
-				/* skip the = */
-				params->cgroup_name = ++optarg;
 			}
 			break;
 		case 'D':
-- 
2.48.1

