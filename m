Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A97082D;
	Sun, 30 Mar 2025 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743360498; cv=none; b=Gk3IkdvpBWmHo2CdHyy38MfLV2F6RQ5arcDmx5rv6jjuvLkLtO65wNpIa06yIaEnvIiYVcTar+Y7lTTdnvDDgcVDwU0exj7epbHso1IljkDk6y2XPURomp+yukxH1blaSVbk1F0JGS+mtJtBUEia71NeK4HVxXmFuikkaqpQUVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743360498; c=relaxed/simple;
	bh=vt0+0ksOzWU6tIE4vQ+9UM9weh/Us7TxYV6DNvMWpeo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SZuw7GF2hCH0vjsY5kGD1r+8N66w75jxG+s7s8M9sg4SCuvFtmq3TvBR8+tQ39aSn+9O6oYnmtnHqyVlG9lgNJRWij+oU6YC/5TFo2FPvgQtzQN2045e++W/FH6Tfm3Mphh7JDDwmvhDD3kr8vk8SpSrdVvo/TAqh7niTLO0mWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39ac56756f6so3229266f8f.2;
        Sun, 30 Mar 2025 11:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743360492; x=1743965292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2+EY5sDkbJi+ojyqbqFZLU/TshUIJYeTFWEaDgEawY=;
        b=l/TBPCL3h4quEtCm1zsJlZ1B17+zl7v8oanu2ME3IPFBxGMW0lDSrQnNjH7QS4B9lR
         M5LwgwrxUMD/IfLFBq0GH0jqy8y89FoS6Q/d1dpDIBgNqfjfebWwqBOTtLpjZiMXeFiG
         sn9ZneKQOlnFdBUv2/EfuGAk4wxFheS1ZljH/kip3ijkBIhcA9pyNnmS2lAAAfn4MWND
         YAykcFihwV/KNTHaqPDlMuF8pb2EFR4hEIowxJ50jNogLrMjE6SJ1x5NYlpOHjxmoYzb
         pOf+2NmI2yAI837eKXXbEF9dBaam9G73re0vxpul4hu4xPUjQciFmXKFUwuUbMKCb2u+
         IC6A==
X-Forwarded-Encrypted: i=1; AJvYcCUbqfwILV5Xyji7UAMp8rq56oRFljFBtviQP5jGPiNlJNnsjKRB/IkfSzI++II+TzHZ/93gkK8OhYcqDsWOo/X7ggkF@vger.kernel.org, AJvYcCUtQpNkNqVj1xMRNYlYseEumKNfPbeDMojDGbVQT9MeDhFqa+3W71ibiVq/07ILMlOXJUkX7xie2FuJAQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUpqQtcuJt3wWHdRf9/+rsP9Z14L9lKFh9LAW3ZNVOlOHctuMf
	pkDB9sNXHvWdcGZrG8/fOID6lXk4C4tFMlCOhAiXn5U6XAcKjSmG
X-Gm-Gg: ASbGnculnxAgNnZy0Swo48A/Hx6v1z5s8+SVt1AwAR4e6me0dQsntor7yJYdQZZOVmf
	uZgxjxV28gg00mh5tlPSrPvKPdsUGKIIm8gI5cRnoI+kFNH2uYaQRJn31OsNd7T2oyfrP3nJsHY
	O1stas7dg7gXzfGMcuStUeJ1LowJ86v4Scd/Jlq9eLkAE+fdL6lIvEbZ+lJP5Q+13OEF5YyHofs
	TtLoOXW+G2dn336E+DROdt1Dkbc2MCTAvXGfsGlSEbmluuDbm7zsiGUoObgJ47VifZPpsiDeFZA
	NjZhtoCUqagb0oVhH9k9b3jPSw7qAgTxJ6YTSptSwNPQ2PNO/DufnYWBDwihcmo2qkCqCg==
X-Google-Smtp-Source: AGHT+IEy6nqdrhFzdXiejMlKeLR/if51v6YA7naBMA/Gs1+aEYsaaXyvvkC8yu/muG2ulgLFPEwOPg==
X-Received: by 2002:a05:6000:188c:b0:391:3f4f:a172 with SMTP id ffacd0b85a97d-39c1211dd9bmr4354355f8f.49.1743360492212;
        Sun, 30 Mar 2025 11:48:12 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e280:5300:f8dc:acb8:77bb:8cf8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b65873bsm9091454f8f.8.2025.03.30.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 11:48:11 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Eder Zulian <ezulian@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Stancek <jstancek@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] rtla: Set distinctive exit value for failed tests
Date: Sun, 30 Mar 2025 21:45:01 +0300
Message-ID: <20250330184641.1929409-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Failed tests return the same exit value as passed tests,
requiring test frameworks to validate results by parsing output.

Set a unique exit value for failed tests to
allow integration with testing frameworks without parsing output.

Add enum type for return value.

Update `make check`.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  |  5 +++--
 tools/tracing/rtla/src/osnoise_top.c   |  5 +++--
 tools/tracing/rtla/src/timerlat_hist.c |  5 +++--
 tools/tracing/rtla/src/timerlat_top.c  |  5 +++--
 tools/tracing/rtla/src/utils.h         |  6 ++++++
 tools/tracing/rtla/tests/engine.sh     |  7 +++++--
 tools/tracing/rtla/tests/hwnoise.t     |  4 ++--
 tools/tracing/rtla/tests/osnoise.t     |  6 +++---
 tools/tracing/rtla/tests/timerlat.t    | 12 ++++++------
 9 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index d9d15c8f27c71..8d579bcee7090 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -766,8 +766,8 @@ int osnoise_hist_main(int argc, char *argv[])
 	struct osnoise_params *params;
 	struct osnoise_tool *record = NULL;
 	struct osnoise_tool *tool = NULL;
+	enum result return_value = ERROR;
 	struct trace_instance *trace;
-	int return_value = 1;
 	int retval;
 
 	params = osnoise_hist_parse_args(argc, argv);
@@ -889,12 +889,13 @@ int osnoise_hist_main(int argc, char *argv[])
 
 	osnoise_print_stats(params, tool);
 
-	return_value = 0;
+	return_value = PASSED;
 
 	if (osnoise_trace_is_off(tool, record)) {
 		printf("rtla osnoise hit stop tracing\n");
 		save_trace_to_file(record ? record->trace.inst : NULL,
 				   params->trace_output);
+		return_value = FAILED;
 	}
 
 out_hist:
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 3455ee73e2e69..2c12780c8aa92 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -594,8 +594,8 @@ int osnoise_top_main(int argc, char **argv)
 	struct osnoise_params *params;
 	struct osnoise_tool *record = NULL;
 	struct osnoise_tool *tool = NULL;
+	enum result return_value = ERROR;
 	struct trace_instance *trace;
-	int return_value = 1;
 	int retval;
 
 	params = osnoise_top_parse_args(argc, argv);
@@ -715,12 +715,13 @@ int osnoise_top_main(int argc, char **argv)
 
 	osnoise_print_stats(params, tool);
 
-	return_value = 0;
+	return_value = PASSED;
 
 	if (osnoise_trace_is_off(tool, record)) {
 		printf("osnoise hit stop tracing\n");
 		save_trace_to_file(record ? record->trace.inst : NULL,
 				   params->trace_output);
+		return_value = FAILED;
 	}
 
 out_top:
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 9d9efeedc4c2c..36d2294c963d1 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1141,11 +1141,11 @@ int timerlat_hist_main(int argc, char *argv[])
 	struct timerlat_params *params;
 	struct osnoise_tool *record = NULL;
 	struct timerlat_u_params params_u;
+	enum result return_value = ERROR;
 	struct osnoise_tool *tool = NULL;
 	struct osnoise_tool *aa = NULL;
 	struct trace_instance *trace;
 	int dma_latency_fd = -1;
-	int return_value = 1;
 	pthread_t timerlat_u;
 	int retval;
 	int nr_cpus, i;
@@ -1378,7 +1378,7 @@ int timerlat_hist_main(int argc, char *argv[])
 
 	timerlat_print_stats(params, tool);
 
-	return_value = 0;
+	return_value = PASSED;
 
 	if (osnoise_trace_is_off(tool, record) && !stop_tracing) {
 		printf("rtla timerlat hit stop tracing\n");
@@ -1388,6 +1388,7 @@ int timerlat_hist_main(int argc, char *argv[])
 
 		save_trace_to_file(record ? record->trace.inst : NULL,
 				   params->trace_output);
+		return_value = FAILED;
 	}
 
 out_hist:
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 79cb6f28967fc..7365e08fe9866 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -985,12 +985,12 @@ int timerlat_top_main(int argc, char *argv[])
 	struct timerlat_params *params;
 	struct osnoise_tool *record = NULL;
 	struct timerlat_u_params params_u;
+	enum result return_value = ERROR;
 	struct osnoise_tool *top = NULL;
 	struct osnoise_tool *aa = NULL;
 	struct trace_instance *trace;
 	int dma_latency_fd = -1;
 	pthread_t timerlat_u;
-	int return_value = 1;
 	char *max_lat;
 	int retval;
 	int nr_cpus, i;
@@ -1197,7 +1197,7 @@ int timerlat_top_main(int argc, char *argv[])
 
 	timerlat_print_stats(params, top);
 
-	return_value = 0;
+	return_value = PASSED;
 
 	if (osnoise_trace_is_off(top, record) && !stop_tracing) {
 		printf("rtla timerlat hit stop tracing\n");
@@ -1207,6 +1207,7 @@ int timerlat_top_main(int argc, char *argv[])
 
 		save_trace_to_file(record ? record->trace.inst : NULL,
 				   params->trace_output);
+		return_value = FAILED;
 	} else if (params->aa_only) {
 		/*
 		 * If the trace did not stop with --aa-only, at least print the
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 101d4799a0090..a2a6f89f342d0 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -83,3 +83,9 @@ int auto_house_keeping(cpu_set_t *monitored_cpus);
 
 #define ns_to_usf(x) (((double)x/1000))
 #define ns_to_per(total, part) ((part * 100) / (double)total)
+
+enum result {
+	PASSED = 0, /* same as EXIT_SUCCESS */
+	ERROR = 1,  /* same as EXIT_FAILURE, an error in arguments */
+	FAILED = 2, /* test hit the stop tracing condition */
+};
diff --git a/tools/tracing/rtla/tests/engine.sh b/tools/tracing/rtla/tests/engine.sh
index b1697b3e3f528..f2616a8e4179e 100644
--- a/tools/tracing/rtla/tests/engine.sh
+++ b/tools/tracing/rtla/tests/engine.sh
@@ -39,6 +39,7 @@ reset_osnoise() {
 }
 
 check() {
+	expected_exitcode=${3:-0}
 	# Simple check: run rtla with given arguments and test exit code.
 	# If TEST_COUNT is set, run the test. Otherwise, just count.
 	ctr=$(($ctr + 1))
@@ -49,7 +50,7 @@ check() {
 		# Run rtla; in case of failure, include its output as comment
 		# in the test results.
 		result=$(stdbuf -oL $TIMEOUT "$RTLA" $2 2>&1); exitcode=$?
-		if [ $exitcode -eq 0 ]
+		if [ $exitcode -eq $expected_exitcode ]
 		then
 			echo "ok $ctr - $1"
 		else
@@ -68,12 +69,14 @@ check_with_osnoise_options() {
 	# Save original arguments
 	arg1=$1
 	arg2=$2
+	arg3=$3
 
 	# Apply osnoise options (if not dry run)
 	if [ -n "$TEST_COUNT" ]
 	then
 		[ "$NO_RESET_OSNOISE" == 1 ] || reset_osnoise
 		shift
+		shift
 		while shift
 		do
 			[ "$1" == "" ] && continue
@@ -84,7 +87,7 @@ check_with_osnoise_options() {
 		done
 	fi
 
-	NO_RESET_OSNOISE=1 check "$arg1" "$arg2"
+	NO_RESET_OSNOISE=1 check "$arg1" "$arg2" "$arg3"
 }
 
 set_timeout() {
diff --git a/tools/tracing/rtla/tests/hwnoise.t b/tools/tracing/rtla/tests/hwnoise.t
index bbed175805374..5f71401a139e6 100644
--- a/tools/tracing/rtla/tests/hwnoise.t
+++ b/tools/tracing/rtla/tests/hwnoise.t
@@ -10,11 +10,11 @@ check "verify help page" \
 check "detect noise higher than one microsecond" \
 	"hwnoise -c 0 -T 1 -d 5s -q"
 check "set the automatic trace mode" \
-	"hwnoise -a 5 -d 30s"
+	"hwnoise -a 5 -d 30s" 2
 check "set scheduling param to the osnoise tracer threads" \
 	"hwnoise -P F:1 -c 0 -r 900000 -d 1M -q"
 check "stop the trace if a single sample is higher than 1 us" \
-	"hwnoise -s 1 -T 1 -t -d 30s"
+	"hwnoise -s 1 -T 1 -t -d 30s" 2
 check "enable a trace event trigger" \
 	"hwnoise -t -e osnoise:irq_noise trigger=\"hist:key=desc,duration:sort=desc,duration:vals=hitcount\" -d 1m"
 
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index e5995c03c790f..44908fc01abfd 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -10,9 +10,9 @@ check "verify help page" \
 check "verify the --priority/-P param" \
 	"osnoise top -P F:1 -c 0 -r 900000 -d 1M -q"
 check "verify the --stop/-s param" \
-	"osnoise top -s 30 -T 1 -t"
+	"osnoise top -s 30 -T 1 -t" 2
 check "verify the  --trace param" \
-	"osnoise hist -s 30 -T 1 -t"
+	"osnoise hist -s 30 -T 1 -t" 2
 check "verify the --entries/-E param" \
 	"osnoise hist -P F:1 -c 0 -r 900000 -d 1M -b 10 -E 25"
 
@@ -20,6 +20,6 @@ check "verify the --entries/-E param" \
 # and stopping on threshold.
 # If default period is not set, this will time out.
 check_with_osnoise_options "apply default period" \
-	"osnoise hist -s 1" period_us=600000000
+	"osnoise hist -s 1" 2 period_us=600000000
 
 test_end
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index e939ff71d6be3..579c12a85e8f3 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -21,21 +21,21 @@ export RTLA_NO_BPF=$option
 check "verify help page" \
 	"timerlat --help"
 check "verify -s/--stack" \
-	"timerlat top -s 3 -T 10 -t"
+	"timerlat top -s 3 -T 10 -t" 2
 check "verify -P/--priority" \
 	"timerlat top -P F:1 -c 0 -d 1M -q"
 check "test in nanoseconds" \
-	"timerlat top -i 2 -c 0 -n -d 30s"
+	"timerlat top -i 2 -c 0 -n -d 30s" 2
 check "set the automatic trace mode" \
-	"timerlat top -a 5 --dump-tasks"
+	"timerlat top -a 5 --dump-tasks" 2
 check "print the auto-analysis if hits the stop tracing condition" \
-	"timerlat top --aa-only 5"
+	"timerlat top --aa-only 5" 2
 check "disable auto-analysis" \
-	"timerlat top -s 3 -T 10 -t --no-aa"
+	"timerlat top -s 3 -T 10 -t --no-aa" 2
 check "verify -c/--cpus" \
 	"timerlat hist -c 0 -d 30s"
 check "hist test in nanoseconds" \
-	"timerlat hist -i 2 -c 0 -n -d 30s"
+	"timerlat hist -i 2 -c 0 -n -d 30s" 2
 done
 
 test_end
-- 
2.48.1

