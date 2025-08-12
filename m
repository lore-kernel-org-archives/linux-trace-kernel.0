Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA42F659B;
	Tue, 12 Aug 2025 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016080; cv=none; b=fb6BAbE7TBU96ZN338cWFgdZ3IEnSBNfq6/af39gUl4he/bKcT7vVAYcS/9bB0+75blpd9sIJ7Of5ww47s0XdHwiU1Go9Wmz6b3tI1rDyGAVdUoCFuzsgohO1Msg39sps8zjxDXH1c4cYZIpjVDOwnX7NuRHpXZ5F5W9bBKiCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016080; c=relaxed/simple;
	bh=b2J8dR+dS8w9QpFRYh+CDJAJYdMXE6W78LAGhBr5/m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZZTxv5r4jbN6hsvTA+wnL/x+WGCfbS8adsa5SFpOuS2RLNZksbztcv2WgVdr2mTpgG2qz6dnf83rbDiXg0PtvgIELeGBrBWQUB99HzRrBfitqiInseFj3lExpvHiNecyzvo2Nb+UAsgsbsIhxAhB3ugL/fF/rAqZWzpuU0ZtAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUJhmvOk; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUJhmvOk"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e8248b3f1cso691282085a.0;
        Tue, 12 Aug 2025 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755016077; x=1755620877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVvse4gwG4SHMNUE37lqj8akcoNPT2eJxOWdm0u/E6c=;
        b=JUJhmvOk3nDLdN90mzRXhCEO8Y0cfTgfDUnmotP29Z44z+htlsOGPYvtc6dt5p2719
         obviawsuKDpug33/7reFyIMHrDd0AtLXF8P9Fg4bjKa/37ELeAbDoC416MD1w+zmbgnZ
         JTxEZV1WcbQpoS9/52NljP2vWe5Q9XbOYlSHdOxE+KD4F2rHIcfsRzk6kyIKzIrmF+/w
         trLUawgHrPRKflStoXgQ/KVelKC+/+wj55tgkWp7gPZqanx49MiJnC5p3A3HENvCPuLM
         KxYJdH5PJb4j2FEU461/KE7TmEtHYZ7KTw29t3++8RYS8OsO1eMMn9kr5lD4KHt2HhtG
         7BTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016077; x=1755620877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVvse4gwG4SHMNUE37lqj8akcoNPT2eJxOWdm0u/E6c=;
        b=G3uCKn3S9eTauTK7lqtdRgozhxLLIP5AOzBNVxM14abqW6HER0mNS/nJ2f7JwVI1Yy
         QLx00W7BmPqvlheG2alYEDs8JSaE1EafbxaJQ/vWT013lnflYCT3pH5S5grlaBrzi6YM
         mwEPZqqvM0QU2n2OYEJh4GI3Ai4tBY+PIw8V1rB0Vo/fSpHA+JwjxWszxPzhGRiKWcAJ
         J6cLN/yP8UMQxVcpleOHDztfs6QCI6zn1WuNM5t1mJl/zNucy/GRa8hY8cHHufvS4158
         4ZwmQr/VJtZc26MVoKsKF6hhsY9xf72U/5uSQZ47kfbVBTowfOO+CBMt/NgfbEYwIE92
         ZjCg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/SW0v6Jl8+AtRoiOYtGZvS8wQ4vAJQcre7jZPWkIIBeYDYuZYHfQZfK/gbllo7Faoijy/VJit38=@vger.kernel.org, AJvYcCW6UtJbQNGYks+PSfRkoK1wOEHlgsPc7FIapxiMqmR0/wApBKItuq6N6q5iOmfUki7QBD4sJRDnKo4vctNtJF4drG2N@vger.kernel.org, AJvYcCWhIC3d1usneu6sEjM2A1F//Oswo6NjL+9gKk9svFamQcTxshQuJZa7nJAQI+OyE8u9oWtVamwPRRaIoTnb@vger.kernel.org
X-Gm-Message-State: AOJu0YzzY56tYnVbIUelbQ+GsPaokVbwVryFi1Q+0Okf3dS/pYrzjMH+
	fK1OnMkCAzcRhyIDqxzf7ndlMBSie7fstyOAIa3p0/To44/oeGCGYsOI
X-Gm-Gg: ASbGnct3yLJ1cBYVq3NclYiWtcZ04kgYa1pkQmi79OwOulRiQN2qGVoPZxSc2rU7id5
	FKGgsEUusMJCIdzHTPCrvhKc3Yk8xJ1W2dz18LSxy7nhZzzZmXVP0cCbKFPg3ktmK46e2z8+bD2
	XKK1SnEzQZs2O+bvE44yjyG0CnzMRUOPA8B9FrtWWAfU7rdzAXNr7Y5SFpG+Mu+vVFLqHAUS1pN
	wOBADBsu6OEcIWw/hGvrdVFAsbKtCJjMtrVUu7A/7wt5th4zdZcOazIskXvu+nvFelfll3ckLh5
	HqDxPQWglOWQdtwOr0Xij/n4Sw14KMZk2DF2QHWY91Pl2ZQKByKlN1c2hmQXmahI1zBTpO/98Ex
	HSRDUd+Bx5ACN2dCEQOY9SS7Ycyk9kQmyX2t1+w9Ngd3pd28vzXdV7IfsCkG3gONI8V2Klriszc
	gTrYc37FdeM5l4
X-Google-Smtp-Source: AGHT+IEZOFBaQmq8M/TLVSdvSJqstKbfFiDBnB5aLkMnf/DUtBrvnsght8jgx8jzMv/NteEco9LH8g==
X-Received: by 2002:a05:620a:611e:b0:7c5:3d60:7f91 with SMTP id af79cd13be357-7e8645175famr38152685a.15.1755016077189;
        Tue, 12 Aug 2025 09:27:57 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55.mynetworksettings.com ([2600:4040:530f:f000:a841:61f7:aa1f:bc8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e8079cfcc9sm1269013885a.29.2025.08.12.09.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 09:27:56 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH 2/3] rtla: fix -C/--cgroup interface
Date: Tue, 12 Aug 2025 12:27:31 -0400
Message-ID: <4c350277bffecdf736ebc69f76de265e693fda14.1755014784.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1755014784.git.ipravdin.official@gmail.com>
References: <cover.1755014784.git.ipravdin.official@gmail.com>
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

Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
---
 Documentation/tools/rtla/common_options.rst |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c       | 16 +++++++-----
 tools/tracing/rtla/src/osnoise_top.c        | 16 +++++++-----
 tools/tracing/rtla/src/timerlat_hist.c      | 16 +++++++-----
 tools/tracing/rtla/src/timerlat_top.c       | 28 ++++++++-------------
 5 files changed, 41 insertions(+), 37 deletions(-)

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
index 8d579bcee709..92c379fbe030 100644
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
@@ -559,12 +559,16 @@ static struct osnoise_params
 			break;
 		case 'C':
 			params->cgroup = 1;
-			if (!optarg) {
-				/* will inherit this cgroup */
+			if (optarg) {
+				if (optarg[0] == '=')
+					/* skip the = */
+					params->cgroup_name = &optarg[1];
+				else
+					params->cgroup_name = optarg;
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
index 2c12780c8aa9..d149c3c4ac11 100644
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
@@ -394,12 +394,16 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 			break;
 		case 'C':
 			params->cgroup = 1;
-			if (!optarg) {
-				/* will inherit this cgroup */
+			if (optarg) {
+				if (optarg[0] == '=')
+					/* skip the = */
+					params->cgroup_name = &optarg[1];
+				else
+					params->cgroup_name = optarg;
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
index 9baea1b251ed..c397f6260054 100644
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
@@ -885,12 +885,16 @@ static struct timerlat_params
 			break;
 		case 'C':
 			params->cgroup = 1;
-			if (!optarg) {
-				/* will inherit this cgroup */
+			if (optarg) {
+				if (optarg[0] == '=')
+					/* skip the = */
+					params->cgroup_name = &optarg[1];
+				else
+					params->cgroup_name = optarg;
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
index c80b81c0b4da..73949d52cf41 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -423,15 +423,6 @@ timerlat_top_print_sum(struct osnoise_tool *top, struct timerlat_top_cpu *summar
 	}
 }
 
-/*
- * clear_terminal - clears the output terminal
- */
-static void clear_terminal(struct trace_seq *seq)
-{
-	if (!config_debug)
-		trace_seq_printf(seq, "\033c");
-}
-
 /*
  * timerlat_print_stats - print data for all cpus
  */
@@ -449,9 +440,6 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *top)
 	if (nr_cpus == -1)
 		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
-	if (!params->quiet)
-		clear_terminal(trace->seq);
-
 	timerlat_top_reset_sum(&summary);
 
 	timerlat_top_header(params, top);
@@ -492,7 +480,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -s/--stack us: save the stack trace at the IRQ if a thread latency is higher than the argument in us",
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
 		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
-		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
+		"	  -C/--cgroup [cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
 		"	     --dump-tasks: prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)",
@@ -650,12 +638,16 @@ static struct timerlat_params
 			break;
 		case 'C':
 			params->cgroup = 1;
-			if (!optarg) {
-				/* will inherit this cgroup */
+			if (optarg) {
+				if (optarg[0] == '=')
+					/* skip the = */
+					params->cgroup_name = &optarg[1];
+				else
+					params->cgroup_name = optarg;
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

