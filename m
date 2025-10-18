Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634702D661D
	for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Oct 2025 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760792692; cv=none; b=PBDp8pDpog1UrSoadRkdGyhIBHlPWBykh3imRCBCO6IznGY6DqZe1SEq3CMDo9dFBNCYhBUFHNWtVa8PZ8x32Kl/R+LL2vtVI6UBnrdivbdJPtwRXluUkYe7rD0If6+sFiY5Kv4AaMbhOMddVsgOXedhA0OuhPZHYTJfYiEdHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760792692; c=relaxed/simple;
	bh=tNCtfZXrwra07r6TPtCLq3FKK/mpUzFwvZ2s9FeejDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pg8i/A0iZ+zsqBI3uI9x4XGDQ8s8VtdBJmqteZ1hO/YOTXQWQXTVWPpwXumAOZd4lSfHHVYdcZUAxAcOlEuqQzCYPkLSbNKuGxmm8GU1nksEKpbq8Mo8YgjALZPhW21ufAmbGGi/nsXAAaFaFEhzinUKz+FSdkTNcmkDbHZLyAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dqh1TJS0; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dqh1TJS0"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7f7835f4478so31553906d6.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Oct 2025 06:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760792689; x=1761397489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkQnkfhKVZ2WiQWF8dIRcSRecJlwiFQZcKoAtHOZptI=;
        b=Dqh1TJS0okdYv0K9KNpVgAoS3zPHD5outYG7KQUoxgPnrFefZ0DsxOcy6zOu1Bafna
         GoZTDC9nbk55g3A8a5j01DfIEvnPFSoJhQ6MSW07HJhXMsVsEKK5dLFHSWjkCFwJ3Ig/
         kgDa3s6TjSHdKjLeTJBuJcTk4VCZ+asBe5Zxkle17H0ENEPun4Xd7lEEsrd7B95Jyb4e
         1etuWYI5rbrROsmjxjHhrPBaAYWnPRjd62GotUKVkZi3PkSyWJ3aXwUhutZDIneJZCbn
         nS3FtceJuMy2S520lEq8QqP8Pmi6UPaHFNxNv9kQ94CT49XO8VVAu9qtx/bIWsF5DApW
         vRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760792689; x=1761397489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkQnkfhKVZ2WiQWF8dIRcSRecJlwiFQZcKoAtHOZptI=;
        b=f9UmAEgjxqo3iJAsok8pnc1HrQ5BWZ/OZ84C8YsjVCVw99VDl3hQPh+I+zQsfboBK3
         r/u6t1oJi84vh1buNQ6D1XSNRm8/CGGwaoSlH7dSjL8timtyQszAtwDaOPvRn3LmBV/z
         hqVpWcbvC7wVUaRqGX6GwyKUUI8oB7CFlZcjjTX8v1vYSAc9pOEq3khmDPpQZOgOzHE+
         Cf/Hub3LZciVxL7N9y9uHLtrVIarxXgH1QzL8xpZ9zSE21qEd0FZtHAVN51dGe2Ud6mY
         FdPTf6GXRd4EG7TtI+SOHgOtrZo6SkW3o6sx0npt1nry9sUjfrSjlK6ozT1tp9kw6efg
         iOcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+6wzcNYlrbfS8FrVcggCC8vLZfE67Ask3o6++po6Rb6Ity1LVSOfzuCGuMwLFtsR5T72k7mIZOyKfLQndb//+y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPOJWoQlEaQP3573j8LzzoOgVx5FAOBPGkD2z6hcNa6ztC4NQR
	u76ii3f5Yz1H/+4emfJ1EJcxyEsI8a30st1+vhbu18ihE4Z62Xhf5nTHPWdM47+C
X-Gm-Gg: ASbGncsHNFBL0dSKlGIYTXltc7gNeRG0ij1tR5Ka4NdnudEz2rCwWIgbavSJpmPdpA+
	jWNKsmFzbdBnFUEV2JjQL87di8rSzdtomYm7YNQ1BCGOC5C30FaNkaSOhTMTjqdQXQqZg1RgqQv
	rzvN+VgN4G1HaucjEWd6ciE9xwv8KZlXXGU+Utt45BoRMRCPui/e4ggy8EqkoXFA6icFbZo5Rg2
	ea4VZUtkhvjoeanW3kCiozN/tSl/jkIkx4qd6a1Y3RT80WJZK+bVzUh6CdaUyOnWOmLnlg289ll
	Ey22C92WN3iDvoF5fnppYufWVrF0At6TtGuvG5GH+68i49XfkoPL/71oqXlxjPCxB/vOuLh26k3
	eFacC8ocVpmNUGexvNWLj0BVWunZ2v9zJnVEwH4NwuT8x6d2/XJ3d8vm69GLS4FqZJdCVE5i/zz
	8HjX8QkH6LXwPOcmwOCNqDrzGXb2Jc1h6cr18r
X-Google-Smtp-Source: AGHT+IGTBjXIhOWC86hx4SGk6B0RopfrHRh+YLNI/bAmg9Pt0yLabyd37BfTIk3sWm7f/2E/S5GOJw==
X-Received: by 2002:ad4:5cea:0:b0:87c:1ec5:841e with SMTP id 6a1803df08f44-87c2054ac90mr92083136d6.8.1760792689172;
        Sat, 18 Oct 2025 06:04:49 -0700 (PDT)
Received: from ideapad.mynetworksettings.com ([2600:4040:5304:d300:275f:6229:da5:6a60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028966fasm15840596d6.33.2025.10.18.06.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 06:04:48 -0700 (PDT)
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: rostedt@goodmis.org,
	tglozar@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ivan Pravdin <ipravdin.official@gmail.com>
Subject: [PATCH v4 1/2] rtla: fix -C/--cgroup interface
Date: Sat, 18 Oct 2025 09:04:30 -0400
Message-ID: <005ddb8734decbbbf5629f01015c441683ff803b.1760791697.git.ipravdin.official@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1760791697.git.ipravdin.official@gmail.com>
References: <cover.1760791697.git.ipravdin.official@gmail.com>
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
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
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
index 77ef35d3f831..edc8e850f5d0 100644
--- a/Documentation/tools/rtla/common_options.rst
+++ b/Documentation/tools/rtla/common_options.rst
@@ -42,7 +42,7 @@
         - *f:prio* - use SCHED_FIFO with *prio*;
         - *d:runtime[us|ms|s]:period[us|ms|s]* - use SCHED_DEADLINE with *runtime* and *period* in nanoseconds.
 
-**-C**, **--cgroup**\[*=cgroup*]
+**-C**, **--cgroup** \[*cgroup*]
 
         Set a *cgroup* to the tracer's threads. If the **-C** option is passed without arguments, the tracer's thread will inherit **rtla**'s *cgroup*. Otherwise, the threads will be placed on the *cgroup* passed to the option.
 
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index dffb6d0a98d7..8b12d8803998 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -428,9 +428,9 @@ static void osnoise_hist_usage(char *usage)
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
@@ -441,10 +441,10 @@ static void osnoise_hist_usage(char *usage)
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
@@ -574,13 +574,7 @@ static struct common_params
 			break;
 		case 'C':
 			params->common.cgroup = 1;
-			if (!optarg) {
-				/* will inherit this cgroup */
-				params->common.cgroup_name = NULL;
-			} else if (*optarg == '=') {
-				/* skip the = */
-				params->common.cgroup_name = ++optarg;
-			}
+			params->common.cgroup_name = parse_optional_arg(argc, argv);
 			break;
 		case 'D':
 			config_debug = 1;
@@ -646,14 +640,8 @@ static struct common_params
 			params->threshold = get_llong_from_str(optarg);
 			break;
 		case 't':
-			if (optarg) {
-				if (optarg[0] == '=')
-					trace_output = &optarg[1];
-				else
-					trace_output = &optarg[0];
-			} else if (optind < argc && argv[optind][0] != '0')
-				trace_output = argv[optind];
-			else
+			trace_output = parse_optional_arg(argc, argv);
+			if (!trace_output)
 				trace_output = "osnoise_trace.txt";
 			break;
 		case '0': /* no header */
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 95418f7ecc96..0be400666c05 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -263,8 +263,8 @@ static void osnoise_top_usage(struct osnoise_params *params, char *usage)
 
 	static const char * const msg[] = {
 		" [-h] [-q] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
-		"	  [-T us] [-t[file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
-		"	  [-c cpu-list] [-H cpu-list] [-P priority] [-C[=cgroup_name]] [--warm-up s]",
+		"	  [-T us] [-t [file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
+		"	  [-c cpu-list] [-H cpu-list] [-P priority] [-C [cgroup_name]] [--warm-up s]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
@@ -275,10 +275,10 @@ static void osnoise_top_usage(struct osnoise_params *params, char *usage)
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
@@ -408,13 +408,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			break;
 		case 'C':
 			params->common.cgroup = 1;
-			if (!optarg) {
-				/* will inherit this cgroup */
-				params->common.cgroup_name = NULL;
-			} else if (*optarg == '=') {
-				/* skip the = */
-				params->common.cgroup_name = ++optarg;
-			}
+			params->common.cgroup_name = parse_optional_arg(argc, argv);
 			break;
 		case 'D':
 			config_debug = 1;
@@ -474,14 +468,8 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			params->common.stop_total_us = get_llong_from_str(optarg);
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
 				trace_output = "osnoise_trace.txt";
 			break;
 		case 'T':
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 606c1688057b..16416192e432 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -717,9 +717,9 @@ static void timerlat_hist_usage(char *usage)
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
@@ -730,11 +730,11 @@ static void timerlat_hist_usage(char *usage)
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
@@ -889,13 +889,7 @@ static struct common_params
 			break;
 		case 'C':
 			params->common.cgroup = 1;
-			if (!optarg) {
-				/* will inherit this cgroup */
-				params->common.cgroup_name = NULL;
-			} else if (*optarg == '=') {
-				/* skip the = */
-				params->common.cgroup_name = ++optarg;
-			}
+			params->common.cgroup_name = parse_optional_arg(argc, argv);
 			break;
 		case 'b':
 			params->common.hist.bucket_size = get_llong_from_str(optarg);
@@ -968,14 +962,8 @@ static struct common_params
 			params->common.stop_total_us = get_llong_from_str(optarg);
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
index fc479a0dcb59..fe4f4e69e00f 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -483,8 +483,8 @@ static void timerlat_top_usage(char *usage)
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
@@ -495,11 +495,11 @@ static void timerlat_top_usage(char *usage)
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
@@ -653,13 +653,7 @@ static struct common_params
 			break;
 		case 'C':
 			params->common.cgroup = 1;
-			if (!optarg) {
-				/* will inherit this cgroup */
-				params->common.cgroup_name = NULL;
-			} else if (*optarg == '=') {
-				/* skip the = */
-				params->common.cgroup_name = ++optarg;
-			}
+			params->common.cgroup_name = optarg;
 			break;
 		case 'D':
 			config_debug = 1;
@@ -722,14 +716,8 @@ static struct common_params
 			params->common.stop_total_us = get_llong_from_str(optarg);
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

