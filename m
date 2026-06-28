Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82221E2858
	for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Jun 2026 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782666655; cv=none; b=avWh854Fsvyi2i1EA1/C0bb3FR6brE1eMH1Rpm5t/6HFTsU/mMlCYi8p0nwsh8ZGPNb6ax+wL4LTVRogRJaDd+qUaxYtaPVTZLoyqe9pzHPUejqJQFFE7uwUytpOO6bjgBJyXeKtZTSo2zwuZDQLFvXMuq/HETU8Rq8C3B2lfDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782666655; c=relaxed/simple;
	bh=jLE79uneLnYU9DqJiSQ+LKMyL59XqMB5JEsymMRbTqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abDQpC8sZE74yOSfQEsYKap7d4s7b2sE1tDEljl3UZTZVNSQNm7g7jCoWhvADBCvHQkQB168weOj39l6A8CxNYi8nQLfY6VPoVip/bBVfzTVyDYyjyXRNQRhSn1UTwMVkBOrthvQuLxxtCWZWnO4mWEvFb1NTJYSh+g2iAcy7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kf7LhnDi; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kf7LhnDi"
Message-ID: <0c230c01-77c8-4c9e-9f49-ecb9555402cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782666641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6i++7dOuM59jdKMipfBEkagKlSwSjaZJrHfEWam97f0=;
	b=kf7LhnDi2KMS0j8dwvmG+tsvD35q0xI7a0VotkXRGZhdhl2CKme8Syb+Tv4/qL/ANFfo5N
	lBCfkJvygoWzSQxDqSDb6W2hbjbA64W26o7SWHPwG/YQWL+pAUCAo0x2Ea+7eyWM6DNJZC
	UCEbFx9Rg4ToYWS4GOmsy1dw78P/nF8=
Date: Mon, 29 Jun 2026 01:10:34 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 04/17] tools/rv: Add selftests
To: Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>,
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-5-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260625121440.116317-5-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/25/26 20:14, Gabriele Monaco wrote:
> The rv tool needs automated testing to catch regressions and verify
> correct functionality across different usage scenarios.
> 
> Add selftests that validate monitor listing (including containers and
> nested monitors), monitor execution with different configurations
> (reactors, verbose output, tracing), and trace output format for both
> per-task and per-cpu monitors. Error handling paths are also tested.
> Tests use a shared engine for common patterns.
> 
> Acked-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   tools/verification/rv/Makefile        |   5 +-
>   tools/verification/rv/tests/rv_list.t |  48 ++++++++++
>   tools/verification/rv/tests/rv_mon.t  |  95 ++++++++++++++++++
>   tools/verification/tests/engine.sh    | 132 ++++++++++++++++++++++++++
>   4 files changed, 279 insertions(+), 1 deletion(-)
>   create mode 100644 tools/verification/rv/tests/rv_list.t
>   create mode 100644 tools/verification/rv/tests/rv_mon.t
>   create mode 100644 tools/verification/tests/engine.sh
> 
> diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
> index 5b898360ba..8ae5fc0d1d 100644
> --- a/tools/verification/rv/Makefile
> +++ b/tools/verification/rv/Makefile
> @@ -78,4 +78,7 @@ clean: doc_clean fixdep-clean
>   	$(Q)rm -f rv rv-static fixdep FEATURE-DUMP rv-*
>   	$(Q)rm -rf feature
>   
> -.PHONY: FORCE clean
> +check: $(RV)
> +	RV=$(RV) prove -o --directives -f tests/
> +
> +.PHONY: FORCE clean check
> diff --git a/tools/verification/rv/tests/rv_list.t b/tools/verification/rv/tests/rv_list.t
> new file mode 100644
> index 0000000000..201af33a52
> --- /dev/null
> +++ b/tools/verification/rv/tests/rv_list.t
> @@ -0,0 +1,48 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +source ../tests/engine.sh
> +test_begin
> +
> +set_timeout 30s
> +
> +RVDIR=/sys/kernel/tracing/rv/
> +
> +# Help and basic tests
> +check "verify help page" \
> +	"$RV --help" 0 "usage: rv command"
> +
> +check "verify list subcommand help" \
> +	"$RV list --help" 0 "list all available monitors"
> +
> +all_nested=$(grep : $RVDIR/available_monitors | cut -d: -f2 | paste -s | sed 's/\t/\\|/g')
> +all_non_nested=$(grep -v : $RVDIR/available_monitors | cut -d: -f2 | paste -s | sed 's/\t/\\|/g')
> +sched_monitors=$(grep sched: $RVDIR/available_monitors | cut -d: -f2 | paste -s | sed 's/\t/\\|/g')
> +description_state="[[:space:]]\+[[:print:]]\+\[\(OFF\|ON\)\]"
> +line_nested=" - \($all_nested\)${description_state}"
> +line_non_nested="\($all_non_nested\)${description_state}"
> +
> +# List monitors and containers
> +check "list all monitors" \
> +	"$RV list" 0 "" "" "^\($line_nested\|$line_non_nested\)$"
> +
> +check_if_exists "list container" \
> +	"$RV list sched" "$RVDIR/monitors/sched" \
> +	"" "-- No monitor found in container sched --" \
> +	"^\($sched_monitors\)${description_state}$"
> +
> +check_if_exists "list non-container" \
> +	"$RV list wwnr" "$RVDIR/monitors/wwnr" \
> +	"-- No monitor found in container wwnr --" \
> +	"^\( - \)\?[[:alnum:]]\+${description_state}$"
> +
> +check "list incomplete container name" \
> +	"$RV list s" 0 "-- No monitor found in container s --"
> +
> +# Error handling tests
> +check "no command" \
> +	"$RV" 1 "rv requires a command"
> +
> +check "invalid command" \
> +	"$RV invalid" 1 "rv does not know the invalid command"
> +
> +test_end
> diff --git a/tools/verification/rv/tests/rv_mon.t b/tools/verification/rv/tests/rv_mon.t
> new file mode 100644
> index 0000000000..cbc346c74c
> --- /dev/null
> +++ b/tools/verification/rv/tests/rv_mon.t
> @@ -0,0 +1,95 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +source ../tests/engine.sh
> +test_begin
> +
> +set_timeout 30s
> +
> +RVDIR=/sys/kernel/tracing/rv/
> +
> +# Help and basic tests
> +check "verify mon subcommand help" \
> +	"$RV mon --help" 0 "run a monitor"
> +
> +# Error handling tests
> +check "mon without monitor name" \
> +	"$RV mon" 1 "usage: rv mon"
> +
> +check "invalid monitor name" \
> +	"$RV mon invalid" 1 "monitor invalid does not exist"
> +
> +if [ -d $RVDIR/monitors/wwnr ]; then
> +
> +check "invalid reactor name" \
> +	"$RV mon wwnr -r invalid" 1 "failed to set invalid reactor, is it available?"
> +
> +check "monitor name is substring of another monitor" \
> +	"$RV mon nr" 1 "monitor nr does not exist"
> +
> +check "already enabled monitor returns error" \
> +	"echo 1 > $RVDIR/monitors/wwnr/enable; $RV mon wwnr" 1 \
> +	"monitor wwnr (in-kernel) is already enabled"
> +echo 0 > $RVDIR/monitors/wwnr/enable
> +
> +fi
> +
> +# rv mon runs until terminated
> +set_expected_timeout 2s
> +
> +# Run monitors with different configurations
> +check_if_exists "run the monitor without parameters" \
> +	"$RV mon wwnr" "$RVDIR/monitors/wwnr" "" "."
> +
> +check_if_exists "run the monitor as verbose" \
> +	"$RV mon wwnr -v" "$RVDIR/monitors/wwnr" \
> +	"my pid is \$pid" "\(event\|error\)"
> +
> +check_if_exists "run the monitor with a reactor" \
> +	"$RV mon wwnr -r printk & sleep .5 && cat $RVDIR/monitors/wwnr/reactors && wait" \
> +	"$RVDIR/monitors/wwnr/reactors" "\[printk\]"
> +
> +check_if_exists "reactor is restored after exit" \
> +	"cat $RVDIR/monitors/wwnr/reactors" \
> +	"$RVDIR/monitors/wwnr/reactors" "\[nop\]"
> +
> +check_if_exists "run a nested monitor with a reactor" \
> +	"$RV mon snroc -r printk & sleep .5 && cat $RVDIR/monitors/sched/snroc/reactors && wait" \
> +	"$RVDIR/monitors/sched/snroc/reactors" "\[printk\]"
> +
> +check_if_exists "run an explicitly nested monitor with a reactor" \
> +	"$RV mon sched:sssw -r printk & sleep .5 && cat $RVDIR/monitors/sched/sssw/reactors && wait" \
> +	"$RVDIR/monitors/sched/sssw/reactors" "\[printk\]"
> +
> +check_if_exists "run container monitor" \
> +	"$RV mon sched & sleep .5 && cat $RVDIR/monitors/sched/{sssw,sco}/enable && wait" \
> +	"$RVDIR/monitors/sched" "1" "0" "^1$"
> +
> +# Regexes for the trace
> +header="^[[:space:]]\+\(\([][A-Z_x<>-]\+\||\)[[:space:]]*\)\+$"
> +type="\(event\|error\)[[:space:]]\+"
> +genpid="[0-9]\+[[:space:]]\+"
> +selfpid="\$pid[[:space:]]\+"
> +cpu="\[[0-9]\{3\}\][[:space:]]\+"
> +state="[a-z_]\+ "
> +trace_task="${genpid}${cpu}${type}${genpid}${state}"
> +trace_task_self="${genpid}${cpu}${type}${selfpid}${state}"
> +trace_cpu="${genpid}${cpu}${type}${state}"
> +trace_cpu_self="${selfpid}${cpu}${type}${state}"
> +
> +check_if_exists "run per-task monitor with tracing" \
> +	"$RV mon sssw -t" "$RVDIR/monitors/sched/sssw" \
> +	"$header" "$trace_task_self" "\($header\|$trace_task\)"
> +
> +check_if_exists "run per-task monitor tracing also self" \
> +	"$RV mon sched:sssw -t -s" "$RVDIR/monitors/sched/sssw" \
> +	"$trace_task_self" "" "\($header\|$trace_task\)"
> +
> +check_if_exists "run per-cpu monitor with tracing" \
> +	"$RV mon sched:sco -t" "$RVDIR/monitors/sched/sco" \
> +	"$header" "$trace_cpu_self" "\($header\|$trace_cpu\)"
> +
> +check_if_exists "run per-cpu monitor tracing also self" \
> +	"$RV mon sco -t -s" "$RVDIR/monitors/sched/sco" \
> +	"$trace_cpu_self" "" "\($header\|$trace_cpu\)"
> +
> +test_end
> diff --git a/tools/verification/tests/engine.sh b/tools/verification/tests/engine.sh
> new file mode 100644
> index 0000000000..76cc254ff9
> --- /dev/null
> +++ b/tools/verification/tests/engine.sh
> @@ -0,0 +1,132 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +test_begin() {
> +	# Count tests to allow the test harness to double-check if all were
> +	# included correctly.
> +	ctr=0
> +	[ -z "$RV" ] && RV="../rv/rv"
> +	[ -n "$TEST_COUNT" ] && echo "1..$TEST_COUNT"
> +}
> +
> +failure() {
> +	fail=1
> +	if [ $# -gt 0 ]; then
> +		failbuf+="$1"
> +		failbuf+=$'\n'
> +	fi
> +}
> +
> +report() {
> +	local desc="$1"
> +
> +	if [ "$fail" -eq 0 ]; then
> +		echo "ok $ctr - $desc"
> +	else
> +		# Add output and exit code as comments in case of failure
> +		echo "not ok $ctr - $desc"
> +		echo -n "$failbuf"
> +		echo "$result" | col -b | while read -r line; do echo "# $line"; done
> +		printf "#\n# exit code %s\n" "$exitcode"
> +	fi
> +}
> +
> +_check() {
> +	local command=$2
> +	local expected_exitcode=${3:-0}
> +	local expected_output=$4
> +	local unexpected_output=$5
> +	local all_lines_pattern=$6
> +	local patterns="$expected_output $unexpected_output $all_lines_pattern"
> +
> +	eval "$TIMEOUT" "$command" &> check_output.$$ &
> +	bgpid=$!
> +	pid=$(pgrep -f "${command%%[|;&>]*}" | tail -n1)

The pgrep runs may immediately after the background fork, before the 
child process has had time to exec.

--
Best wishes,
Wen

> +	wait $bgpid
> +	exitcode=$?
> +	result=$(tr -d '\0' < check_output.$$)
> +	rm -f check_output.$$
> +
> +	failbuf=''
> +	fail=0
> +
> +	# Suppress any other error if a needed pid is empty
> +	if [ -z "$pid" ] && grep -q "\$pid" <<< "$patterns"; then
> +		result=''
> +		failure "# Empty pid for $command"
> +		return 1
> +	fi
> +
> +	expected_output="${expected_output//\$pid/$pid}"
> +	unexpected_output="${unexpected_output//\$pid/$pid}"
> +	all_lines_pattern="${all_lines_pattern//\$pid/$pid}"
> +
> +	# Test if the results matches if requested
> +	if [ -n "$expected_output" ] && ! grep -qe "$expected_output" <<< "$result"; then
> +		failure "# Output match failed: \"$expected_output\""
> +	fi
> +
> +	if [ -n "$unexpected_output" ] && grep -qe "$unexpected_output" <<< "$result"; then
> +		failure "# Output non-match failed: \"$unexpected_output\""
> +	fi
> +
> +	if [ -n "$all_lines_pattern" ] && grep -vqe "$all_lines_pattern" <<< "$result"; then
> +		failure "# All-lines pattern failed: \"$all_lines_pattern\""
> +	fi
> +
> +	if [ $exitcode -ne "$expected_exitcode" ]; then
> +		failure "# Expected exit code $expected_exitcode"
> +	fi
> +}
> +
> +check() {
> +	# Simple check: run the command with given arguments and test exit code.
> +	# If TEST_COUNT is set, run the test. Otherwise, just count.
> +	ctr=$((ctr + 1))
> +	if [ -n "$TEST_COUNT" ]; then
> +		_check "$@"
> +		report "$1"
> +	fi
> +}
> +
> +check_if_exists() {
> +	# Conditional check that skips if a file or folder doesn't exist
> +	local desc=$1
> +	local command=$2
> +	local file=$3
> +	local expected_output=$4
> +	local unexpected_output=$5
> +	local all_lines_pattern=$6
> +
> +	ctr=$((ctr + 1))
> +	if [ -n "$TEST_COUNT" ]; then
> +		if [ ! -e "$file" ]; then
> +			echo "ok $ctr - $desc # SKIP file not found: $file"
> +		else
> +			_check "$desc" "$command" 0 "$expected_output" \
> +				"$unexpected_output" "$all_lines_pattern"
> +			report "$desc"
> +		fi
> +	fi
> +}
> +
> +set_timeout() {
> +	TIMEOUT="timeout -v -k 15s $1"
> +}
> +
> +set_expected_timeout() {
> +	TIMEOUT="timeout --preserve-status -k 15s $1"
> +}
> +
> +unset_timeout() {
> +	unset TIMEOUT
> +}
> +
> +test_end() {
> +	# If running without TEST_COUNT, tests are not actually run, just
> +	# counted. In that case, re-run the test with the correct count.
> +	[ -z "$TEST_COUNT" ] && TEST_COUNT=$ctr exec bash "$0" || true
> +}
> +
> +# Avoid any environmental discrepancies
> +export LC_ALL=C
> +unset_timeout
