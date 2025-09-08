Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C181EBFE0;
	Mon,  8 Sep 2025 02:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757297178; cv=none; b=RY4JzB1gn11UkM1BEoySMYTbaCCwWW1JkFsKsOEbl+nbGPoz8krCDdW2CPAWyy0uSPxI8PjN2UccCjboqlWSzVcn9d+8VU5o7b36lwKY35urYso0Tbre1c79JTZSLObP9U4RTZzYGKmTRtwJUzj+JR5J46x8XM94/Qx/SJB8mz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757297178; c=relaxed/simple;
	bh=Q6rPj5XExPw5kXt3UBLLesxku9bvm3nVPnH/RDqDIWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEJYnCwajd1mjig8hzeWgzjMXrsdBQVchuXWhhZXX82QyurEAijcArydhprFq0bcmrqGGZgYj5Y8aGbTyzYDmUU5zQhT9QtI9kUJ5L9UjJhLfL6NCVvtEN+t/+HwEkyt5WuuYWZIXwNGIod87pDCkvqNQCFsLCnvAjLj+hhom00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avmphYNH; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avmphYNH"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70ba7aa131fso45197496d6.2;
        Sun, 07 Sep 2025 19:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757297175; x=1757901975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rH1Q4HIwxLwZ1f0LKqOXACw6UR10UU8sHDYvnNq8p4=;
        b=avmphYNHS0nioZ2ANAHBt9ftptw/aXNnnqmUfIwZws8J0LLFT90p4ilRmDFXH4USP6
         4ahR8EIfIRWjbY0F86T8t5Z2tQ0bhF5aRD8XTxzjHQSs1CzWRLYFegVDC69FoJD/h9Od
         QILKci2ReTS+IhLDbfx2UPwZgd0AfJ4toi83EsBZC86zMZkxZzD5cAwz0+k0a6MrAJ3V
         RpP6uZ/eo0qgdwkiXGnVbccXrsqKUbCnEpjS+v3LP9z5igZeuNRKbBkq8e+e3O7ARvlJ
         s/RDtFlFjjfOiOIOCsjGcN+QKcrtzzs3fDHueoz2k/J5TvUc4jF0yjSy/Fo+G3+7Z7pL
         vbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757297175; x=1757901975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rH1Q4HIwxLwZ1f0LKqOXACw6UR10UU8sHDYvnNq8p4=;
        b=Lln9FLkoiLD3U0pZw3XdKyS1Ihf9nzaCHlxJRR6zaT0RTxDTWvtj5YtdgnRmyarpCE
         uADC02sWZz8DbUrc7m8lJFsd9PhEAqte9MwK8zwdH2llOBHgBvvGyoesceaZavF884pE
         ltJA/8xixi59HB7OsQXDs8lU3spNQ5EK3kmQxYM+T6ea3f8PSXKKodDA6PsuLepjYuKn
         eGS8ZJQuEj3O/Ozmw40hAuQVvB9R2heb7wDXeFAyUBmk7aALwnznHLh37E93EnhMPSUt
         Xo4nabap9ZQsCEUS9W7nx+dDCacbeNZQdcMjW9xC2WkAJO9MVndOQA4VuxXOXIlnZMto
         HJzg==
X-Forwarded-Encrypted: i=1; AJvYcCXDHi6i1BE5r4XJrBB+pCOo2mtl5u8SO3aTJQJHrUZtac9AbLVaobcPjnY84iI6vGUlFVh6paPtUvkOo8ePP5Wk3a6d@vger.kernel.org, AJvYcCXiGq9e5Gy0ztQCvNCydZGTbcK0QZUv16kgZqRyevd2sp0ThHD4eBf6XCXDn/bEIeBq66pBlEqZV4w22ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeUsEtXR64LfjpAD2eoH1DN+90XX4cmYWEOKPbn1TjSfRu7M/I
	yZsy8RWeACX4Ep/Siewcnzy/DU3gpk4E32ATXfisijONGVYXiPbmBOT7LVbkjw==
X-Gm-Gg: ASbGncu9TvGLoNXpacMYD0qLRiNt21wEzrbCx3yQUGH6eblthtKHejDm16BNtiktc/e
	gajPFiUu3kRqTduFbLH5kJ2qbRWgg4+aeJsOG4a5leVxAxa/E7a9ewrl5FKAQR50VV2wcp/HvcW
	0WW8XgrcQjAAA9XoCTr+mowZfhFxeKmY88uBls/cF064YpzeVi8P78HdpzZ7U7LFxyXBK2KEgi/
	c2PaH/gWVKA4FI4VkuMS6d86iFIoz9IDcV81/1LEu3/rhQmoP8GnMLakZSdhZ7FMNRwQnK4XXSx
	zFeOgLNuopzjGgk7mxLyAsFb4n6FUBOnU/D8GITdJCnErLFW1Db1OsCtpZBBIZJW7wJoLfA2ycj
	19jitEGOAH/bAS1nsU54KgOyAT7bYJceI3g4h6FFc2SXHN/d6furQ0boO0xB6bEY9/Gmgj/o5Uv
	lW3CA6xdy0Za7ELO8TiA==
X-Google-Smtp-Source: AGHT+IGeUCO95fGBwGUmOSpGDkKozomxcyG5csobsYZCX/t73uJphgb5U1soQgy7YZdwgSNrpRBkyg==
X-Received: by 2002:ad4:5ecb:0:b0:728:7d77:63ba with SMTP id 6a1803df08f44-739371a7998mr69427196d6.33.1757297175254;
        Sun, 07 Sep 2025 19:06:15 -0700 (PDT)
Received: from ideapad.solutionip.com (wsip-184-179-113-83.ri.ri.cox.net. [184.179.113.83])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72925b87571sm79638846d6.6.2025.09.07.19.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 19:06:14 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH v3 2/3] rtla: fix -C/--cgroup interface
Date: Sun,  7 Sep 2025 22:05:58 -0400
Message-ID: <a093065d78b7a4377c084fb4dc56942aedc5f6f2.1757034919.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1757034919.git.ipravdin.official@gmail.com>
References: <cover.1757034919.git.ipravdin.official@gmail.com>
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
the aforementioned way, i.e. `-C [cgroup]` and `--cgroup [cgroup]`.

Refactor identical logic between -t/--trace and -C/--cgroup into a
common function.

Change documentation to reflect this user interface change.

Fixes: a957cbc02531 ("rtla: Add -C cgroup support")
Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
---
 Documentation/tools/rtla/common_options.rst |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c       | 26 ++++++---------------
 tools/tracing/rtla/src/osnoise_top.c        | 26 ++++++---------------
 tools/tracing/rtla/src/timerlat_hist.c      | 26 ++++++---------------
 tools/tracing/rtla/src/timerlat_top.c       | 26 ++++++---------------
 tools/tracing/rtla/src/utils.c              | 26 +++++++++++++++++++++
 tools/tracing/rtla/src/utils.h              |  1 +
 7 files changed, 56 insertions(+), 77 deletions(-)

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
index 8d579bcee709..1dc39de79d78 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -422,9 +422,9 @@ static void osnoise_hist_usage(char *usage)
 	static const char * const msg[] = {
 		"",
 		"  usage: rtla osnoise hist [-h] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
-		"	  [-T us] [-t[file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
+		"	  [-T us] [-t [file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
 		"	  [-c cpu-list] [-H cpu-list] [-P priority] [-b N] [-E N] [--no-header] [--no-summary] \\",
-		"	  [--no-index] [--with-zeros] [-C[=cgroup_name]] [--warm-up]",
+		"	  [--no-index] [--with-zeros] [-C [cgroup_name]] [--warm-up]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
@@ -435,10 +435,10 @@ static void osnoise_hist_usage(char *usage)
 		"	  -T/--threshold us: the minimum delta to be considered a noise",
 		"	  -c/--cpus cpu-list: list of cpus to run osnoise threads",
 		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
-		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
+		"	  -C/--cgroup [cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
-		"	  -t/--trace[file]: save the stopped trace to [file|osnoise_trace.txt]",
+		"	  -t/--trace [file]: save the stopped trace to [file|osnoise_trace.txt]",
 		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
 		"	     --filter <filter>: enable a trace event filter to the previous -e event",
 		"	     --trigger <trigger>: enable a trace event trigger to the previous -e event",
@@ -559,13 +559,7 @@ static struct osnoise_params
 			break;
 		case 'C':
 			params->cgroup = 1;
-			if (!optarg) {
-				/* will inherit this cgroup */
-				params->cgroup_name = NULL;
-			} else if (*optarg == '=') {
-				/* skip the = */
-				params->cgroup_name = ++optarg;
-			}
+			params->cgroup_name = parse_optional_arg(argc, argv);
 			break;
 		case 'D':
 			config_debug = 1;
@@ -630,14 +624,8 @@ static struct osnoise_params
 			params->threshold = get_llong_from_str(optarg);
 			break;
 		case 't':
-			if (optarg) {
-				if (optarg[0] == '=')
-					params->trace_output = &optarg[1];
-				else
-					params->trace_output = &optarg[0];
-			} else if (optind < argc && argv[optind][0] != '0')
-				params->trace_output = argv[optind];
-			else
+			params->trace_output = parse_optional_arg(argc, argv);
+			if (!params->trace_output)
 				params->trace_output = "osnoise_trace.txt";
 			break;
 		case '0': /* no header */
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 2c12780c8aa9..b3e161536ed8 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -257,8 +257,8 @@ static void osnoise_top_usage(struct osnoise_params *params, char *usage)
 
 	static const char * const msg[] = {
 		" [-h] [-q] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
-		"	  [-T us] [-t[file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
-		"	  [-c cpu-list] [-H cpu-list] [-P priority] [-C[=cgroup_name]] [--warm-up s]",
+		"	  [-T us] [-t [file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
+		"	  [-c cpu-list] [-H cpu-list] [-P priority] [-C [cgroup_name]] [--warm-up s]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
@@ -269,10 +269,10 @@ static void osnoise_top_usage(struct osnoise_params *params, char *usage)
 		"	  -T/--threshold us: the minimum delta to be considered a noise",
 		"	  -c/--cpus cpu-list: list of cpus to run osnoise threads",
 		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
-		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
+		"	  -C/--cgroup [cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
-		"	  -t/--trace[file]: save the stopped trace to [file|osnoise_trace.txt]",
+		"	  -t/--trace [file]: save the stopped trace to [file|osnoise_trace.txt]",
 		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
 		"	     --filter <filter>: enable a trace event filter to the previous -e event",
 		"	     --trigger <trigger>: enable a trace event trigger to the previous -e event",
@@ -394,13 +394,7 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 			break;
 		case 'C':
 			params->cgroup = 1;
-			if (!optarg) {
-				/* will inherit this cgroup */
-				params->cgroup_name = NULL;
-			} else if (*optarg == '=') {
-				/* skip the = */
-				params->cgroup_name = ++optarg;
-			}
+			params->cgroup_name = parse_optional_arg(argc, argv);
 			break;
 		case 'D':
 			config_debug = 1;
@@ -460,14 +454,8 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 			params->stop_total_us = get_llong_from_str(optarg);
 			break;
 		case 't':
-			if (optarg) {
-				if (optarg[0] == '=')
-					params->trace_output = &optarg[1];
-				else
-					params->trace_output = &optarg[0];
-			} else if (optind < argc && argv[optind][0] != '-')
-				params->trace_output = argv[optind];
-			else
+			params->trace_output = parse_optional_arg(argc, argv);
+			if (!params->trace_output)
 				params->trace_output = "osnoise_trace.txt";
 			break;
 		case 'T':
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 9baea1b251ed..ad713dafa3c3 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -713,9 +713,9 @@ static void timerlat_hist_usage(char *usage)
 	char *msg[] = {
 		"",
 		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] \\",
-		"         [-t[file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
+		"         [-t [file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
 		"	  [-P priority] [-E N] [-b N] [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
-		"	  [--no-index] [--with-zeros] [--dma-latency us] [-C[=cgroup_name]] [--no-aa] [--dump-task] [-u|-k]",
+		"	  [--no-index] [--with-zeros] [--dma-latency us] [-C [cgroup_name]] [--no-aa] [--dump-task] [-u|-k]",
 		"	  [--warm-up s] [--deepest-idle-state n]",
 		"",
 		"	  -h/--help: print this menu",
@@ -726,11 +726,11 @@ static void timerlat_hist_usage(char *usage)
 		"	  -s/--stack us: save the stack trace at the IRQ if a thread latency is higher than the argument in us",
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
 		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
-		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
+		"	  -C/--cgroup [cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
 		"	     --dump-tasks: prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)",
 		"	  -D/--debug: print debug info",
-		"	  -t/--trace[file]: save the stopped trace to [file|timerlat_trace.txt]",
+		"	  -t/--trace [file]: save the stopped trace to [file|timerlat_trace.txt]",
 		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
 		"	     --filter <filter>: enable a trace event filter to the previous -e event",
 		"	     --trigger <trigger>: enable a trace event trigger to the previous -e event",
@@ -885,13 +885,7 @@ static struct timerlat_params
 			break;
 		case 'C':
 			params->cgroup = 1;
-			if (!optarg) {
-				/* will inherit this cgroup */
-				params->cgroup_name = NULL;
-			} else if (*optarg == '=') {
-				/* skip the = */
-				params->cgroup_name = ++optarg;
-			}
+			params->cgroup_name = parse_optional_arg(argc, argv);
 			break;
 		case 'b':
 			params->bucket_size = get_llong_from_str(optarg);
@@ -962,14 +956,8 @@ static struct timerlat_params
 			params->stop_total_us = get_llong_from_str(optarg);
 			break;
 		case 't':
-			if (optarg) {
-				if (optarg[0] == '=')
-					trace_output = &optarg[1];
-				else
-					trace_output = &optarg[0];
-			} else if (optind < argc && argv[optind][0] != '-')
-				trace_output = argv[optind];
-			else
+			trace_output = parse_optional_arg(argc, argv);
+			if (!trace_output)
 				trace_output = "timerlat_trace.txt";
 			break;
 		case 'u':
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index c80b81c0b4da..7f1885018624 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -480,8 +480,8 @@ static void timerlat_top_usage(char *usage)
 	static const char *const msg[] = {
 		"",
 		"  usage: rtla timerlat [top] [-h] [-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
-		"	  [[-t[file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
-		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C[=cgroup_name]] [-u|-k] [--warm-up s] [--deepest-idle-state n]",
+		"	  [[-t [file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] [-H cpu-list]\\",
+		"	  [-P priority] [--dma-latency us] [--aa-only us] [-C [cgroup_name]] [-u|-k] [--warm-up s] [--deepest-idle-state n]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -492,11 +492,11 @@ static void timerlat_top_usage(char *usage)
 		"	  -s/--stack us: save the stack trace at the IRQ if a thread latency is higher than the argument in us",
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
 		"	  -H/--house-keeping cpus: run rtla control threads only on the given cpus",
-		"	  -C/--cgroup[=cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
+		"	  -C/--cgroup [cgroup_name]: set cgroup, if no cgroup_name is passed, the rtla's cgroup will be inherited",
 		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
 		"	     --dump-tasks: prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)",
-		"	  -t/--trace[file]: save the stopped trace to [file|timerlat_trace.txt]",
+		"	  -t/--trace [file]: save the stopped trace to [file|timerlat_trace.txt]",
 		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
 		"	     --filter <command>: enable a trace event filter to the previous -e event",
 		"	     --trigger <command>: enable a trace event trigger to the previous -e event",
@@ -650,13 +650,7 @@ static struct timerlat_params
 			break;
 		case 'C':
 			params->cgroup = 1;
-			if (!optarg) {
-				/* will inherit this cgroup */
-				params->cgroup_name = NULL;
-			} else if (*optarg == '=') {
-				/* skip the = */
-				params->cgroup_name = ++optarg;
-			}
+			params->cgroup_name = optarg;
 			break;
 		case 'D':
 			config_debug = 1;
@@ -719,14 +713,8 @@ static struct timerlat_params
 			params->stop_total_us = get_llong_from_str(optarg);
 			break;
 		case 't':
-			if (optarg) {
-				if (optarg[0] == '=')
-					trace_output = &optarg[1];
-				else
-					trace_output = &optarg[0];
-			} else if (optind < argc && argv[optind][0] != '-')
-				trace_output = argv[optind];
-			else
+			trace_output = parse_optional_arg(argc, argv);
+			if (!trace_output)
 				trace_output = "timerlat_trace.txt";
 			break;
 		case 'u':
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index d6ab15dcb490..bd5f34b44648 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -959,3 +959,29 @@ int auto_house_keeping(cpu_set_t *monitored_cpus)
 
 	return 1;
 }
+
+/**
+ * parse_optional_arg - Parse optional argument value
+ *
+ * Parse optional argument value, which can be in the form of:
+ * -sarg, -s/--long=arg, -s/--long arg
+ *
+ * Returns arg value if found, NULL otherwise.
+ */
+char *parse_optional_arg(int argc, char **argv)
+{
+	if (optarg) {
+		if (optarg[0] == '=') {
+			/* skip the = */
+			return &optarg[1];
+		} else {
+			return optarg;
+		}
+	/* parse argument of form -s [arg] and --long [arg]*/
+	} else if (optind < argc && argv[optind][0] != '-') {
+		/* consume optind */
+		return argv[optind++];
+	} else {
+		return NULL;
+	}
+}
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index a2a6f89f342d..d8d83abf0f0d 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -24,6 +24,7 @@ long parse_seconds_duration(char *val);
 void get_duration(time_t start_time, char *output, int output_size);
 
 int parse_cpu_list(char *cpu_list, char **monitored_cpus);
+char *parse_optional_arg(int argc, char **argv);
 long long get_llong_from_str(char *start);
 
 static inline void
-- 
2.48.1

