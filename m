Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA621FF3E;
	Thu, 15 May 2025 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326904; cv=none; b=frnhaUbujUSBItwtSVs4eokk4pBjXSOzrTVAFUoOzfCkZsQgkJvXsFkpfKl2dd2EIK+1cCp39Ds1D3CK/dB3iWeXYQnFBSVNfuJs62waK37LusOO/Ysll7/+TqXX0eAwEA6mJ8Awlj2fsaSvSDMRq7FNErgJLymNBE/pxxrZZT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326904; c=relaxed/simple;
	bh=/wYBKwb1OUxzZsfClXqfSuJhz7Sq52vo6cckxtTJkHU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=auHPmvEYpFfFlh8mHDvPNHOnxBXPWKuBQrATKFI5vsUmCP20/FxzH0l3wRU+zqH7nl94y+ZY3Gyk1sbr+IardtlpvcSPCwIKslDeDJD+x3oP27gc2K15TyhnLIZtYR406M6ANOyMnGg19Cm07fwNperqrqJs5DyA/0dB5gSibiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a108684f90so766271f8f.1;
        Thu, 15 May 2025 09:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747326901; x=1747931701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syyAJcOs6Ta0VHvxjwld6+DDJxWneemMl4TKeTCSxUI=;
        b=bEF2inFD719T3EKMgxaayoxoGEr1XLWHY3p8znh9gHXvQ72rA8/I2PXv1kjtS4nUdN
         k8453y9wcHhbX/p9MVVqjmVIS2yoyfT605g8z6vOL1en7u5ryzncTwCwP1vveDSu2p91
         Z3Vc2uCYtEfUSQRX8WIth3xBTOYucWCBh50Acos1YM3eglTTjkK5L4UT9HG5iAq1Wwp5
         pkYZvpVsjsD7mrRRKowQoQijO4RWZdPJ5O8+ZYMxypr1fFP9omSlUj7OmubuAffK+TaG
         ecL3FWwqtuyDZEArdELBaOJjcLoJ6u5AC/9FMRyq6QNXl2N/qE9Ll5H92pLlnBfB+yFW
         Br/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUffHNT5vqSVnnDcwyTh0Pk8zlzAk+32Q+oa10H5yDxqxGSd0YcOgJYrIjt1GWCPD1tcACe9DLKNX2MDjHDPUpdLvgg@vger.kernel.org, AJvYcCUvSkuQ+R/H5uRPmlmdKHNX/L/pC67JMnbS3l6ZIhS7fQDmk1JuEtO3eY+hXYwvw2z/Q3ecy4AdA7hqcw82@vger.kernel.org, AJvYcCWhIXcgJu47eGbW6uHzdI9i6Y/LctQbA1RcdGSLcJ1vB/7NXjzAydivjZoctO+ISd6kOFMduNUA3G8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8PAA3tzb0M5gW5x7ThAwQlZWAzCAX/PqC3quIO3GX6e77dHMi
	A+3CeuxEjo07TS/tNvvsdncgTamW/kAzRTrJ32vsbx0F3YSLgaoH6KuX
X-Gm-Gg: ASbGnctE/s1Zf8Bj8WHKsZRh05UxRglHa2xAGahKd8fFU2HNczJvPErxATip/i8Uo+D
	FrfBRQHmwGk8dQiLKVwecap3TEWsDuxYDCYvhhaPrxqChx0jeuAobgMdYIcanGq/1jywqnod3VV
	7KWSzW7dt9EV4eJgggZoXh2FhGx/DghUM5n32C9CyOqx+vWQf4F6CqQQ9A7dqBRoW15lfIfbyGT
	9ZWAhtvbu4dSZOr7t7kXlDMLfWy5NzJqsVYjXNKwvAqURdfGFfebhrIEYh2oIqYCXPj8dxXPZAn
	Z/LkF+n8cinjVEIG8br1taFAdIJMWaQql26sM15RnRBrDJdwZnd7WOe3hTZLce6Qyg==
X-Google-Smtp-Source: AGHT+IGZW7mB608zuIBsXjfOJOOnzPlTRp/POpeXOjwDDDHLSfRMyw4ONIM21jGHoK7Via7ZU/Re+A==
X-Received: by 2002:a05:6000:2012:b0:3a0:ad33:c1b3 with SMTP id ffacd0b85a97d-3a35c834d5amr469597f8f.3.1747326900430;
        Thu, 15 May 2025 09:35:00 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e280:5300:9068:704e:a31a:c135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a87fsm10016f8f.29.2025.05.15.09.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 09:35:00 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Costa Shulyupin <costa.shul@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Eder Zulian <ezulian@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jan Stancek <jstancek@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] rtla: Set distinctive exit value for failed tests
Date: Thu, 15 May 2025 19:20:05 +0300
Message-ID: <20250515162133.29507-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A test is considered failed when a sample trace exceeds the threshold.
Failed tests return the same exit code as passed tests, requiring test
frameworks to determine the result by searching for "hit stop tracing"
in the output.

Assign a distinct exit code for failed tests to enable the use of shell
expressions and seamless integration with testing frameworks without the
need to parse the output.

Add enum type for return value.

Update `make check`.

Add documentation
- update Documentation/tools/rtla/common_appendix.rst.
  add SPDX-License-Identifier
  add section 'EXIT STATUS'
- include common_appendix.rst into
  Documentation/tools/rtla/rtla-timerlat-hist.rst - the only file of
  rtla-*.rst still without common_appendix.rst.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---
Changes since v2:
- No changes in patch
- Add documentation
Changes since v1:
- Expanded the patch description as requested by Tomas

---
 Documentation/tools/rtla/common_appendix.rst    | 10 ++++++++++
 Documentation/tools/rtla/rtla-timerlat-hist.rst |  2 ++
 tools/tracing/rtla/src/osnoise_hist.c           |  5 +++--
 tools/tracing/rtla/src/osnoise_top.c            |  5 +++--
 tools/tracing/rtla/src/timerlat_hist.c          |  5 +++--
 tools/tracing/rtla/src/timerlat_top.c           |  5 +++--
 tools/tracing/rtla/src/utils.h                  |  6 ++++++
 tools/tracing/rtla/tests/engine.sh              |  7 +++++--
 tools/tracing/rtla/tests/hwnoise.t              |  4 ++--
 tools/tracing/rtla/tests/osnoise.t              |  6 +++---
 tools/tracing/rtla/tests/timerlat.t             | 12 ++++++------
 11 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/Documentation/tools/rtla/common_appendix.rst b/Documentation/tools/rtla/common_appendix.rst
index b5cf2dc223df..a6233ca8e6d6 100644
--- a/Documentation/tools/rtla/common_appendix.rst
+++ b/Documentation/tools/rtla/common_appendix.rst
@@ -1,3 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+EXIT STATUS
+===========
+
+::
+
+ 0  Passed: the test did not hit the stop tracing condition
+ 1  Error: invalid argument
+ 2  Failed: the test hit the stop tracing condition
+
 REPORTING BUGS
 ==============
 Report bugs to <linux-kernel@vger.kernel.org>
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index 03b7f3deb069..b2d8726271b3 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -107,3 +107,5 @@ SEE ALSO
 AUTHOR
 ======
 Written by Daniel Bristot de Oliveira <bristot@kernel.org>
+
+.. include:: common_appendix.rst
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index d9d15c8f27c7..8d579bcee709 100644
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
index 3455ee73e2e6..2c12780c8aa9 100644
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
index 9d9efeedc4c2..36d2294c963d 100644
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
index 79cb6f28967f..7365e08fe986 100644
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
index 101d4799a009..a2a6f89f342d 100644
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
index b1697b3e3f52..f2616a8e4179 100644
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
index bbed17580537..5f71401a139e 100644
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
index e5995c03c790..44908fc01abf 100644
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
index e939ff71d6be..579c12a85e8f 100644
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

