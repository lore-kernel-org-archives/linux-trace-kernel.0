Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F0D357CEA;
	Tue, 11 Aug 2026 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491548; cv=none; b=DXX4PYaUt/4ZcGYOSQLvtSWb8Gz9toCX/CBXsu8wIFzUUF89bByLKb8VeNcO7KHtw2/7raYzEBMQy0yCt2N07B0kygzrQrZfu9pou4dp1iy1pxwybFc2z1K9z7nTSgPEOdWadGmMi++a3WFAp5f29ssnS6IILI8rOZQHlZ7t2Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491548; c=relaxed/simple;
	bh=jp5aDgUNdw4lX3EKDUEmrqhbhHbpntaFPtOqvW3Y4i4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dP/wieoumO07paGBQXt/TUItFD0VPw3fB3kZfuwHc/y0Oa6+JHps73hcqQIpNxDyOkU3hxuYOL5b0c8dl39utHI2+hT0OKeOxL6smRZoL6OmcWNnWzr/oDYAEykcxHqToA3UjezUEFs96jtYh4dFhUYDyk4oTqPXumZtO+tYNOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOm5vJuK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOm5vJuK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB621F000E9;
	Tue, 11 Aug 2026 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786491546;
	bh=DdzHxzFb+l4uABALkV1V87Z+v8mnXXrznbeqaw4w41M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dOm5vJuKisjnM+EPw1YGhZAm6alvXSZg7/Grr4RB1AZsqfDhPf6Tw+NAlhuqxlkmu
	 GwZNz1HjSOWx8bJvb3KqSsxnn/LnKSgSmT4c0e1EhjoJce007iy3T3rFwFgvfNb9i/
	 kYHaO6hn1Wv2EJ1kT3us6p+dVvFlPEM6DMYc/caM4cbNdNllG9rRBKFpRDwVWcZXcJ
	 0S980z2i0wFldPJSKMQOw+B0qXXnaJdKxtK+Ld8iJKn2kjb4QDW6y4tC+ycXGXMaGx
	 B2wuig4CXSzsLzUTuVPx4dRp994eLnyh5uA59Dna0PBdsT1Vy2OCKEGQBNwzREl701
	 2HKpe4n8rO3EA==
Date: Wed, 12 Aug 2026 08:39:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/4] selftests/ftrace: Add kernel cmdline tracing
 testcases
Message-Id: <20260812083902.2866cd1bb7e3834e36a1ce69@kernel.org>
In-Reply-To: <178646248625.428104.6475014420560529192.stgit@devnote2>
References: <178646245730.428104.4400499381224001727.stgit@devnote2>
	<178646248625.428104.6475014420560529192.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 00:34:46 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add test cases for kernel command-line tracing options. It verifies
> various parameters like trace_buf_size and trace_options by reading
> the output of tracing files in sysfs.
> 
> Assisted-by: Antigravity:gemini-3.6-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v2:
>  - Fix buffer_size_kb parsing in cmdline-03-trace-buf-size.sh to handle
>    unexpanded buffer string output '1 (expanded: 2048)'.
>  - Use grep -qw in cmdline-04-trace-options.sh to match word options
>    and avoid matching disabled 'no<option>' entries.
> ---
>  .../boottime/cmdlines/cmdline-01-ftrace.cmdline    |    1 +
>  .../cmdlines/cmdline-02-trace-event.cmdline        |    1 +
>  .../cmdlines/cmdline-03-trace-buf-size.cmdline     |    1 +
>  .../cmdlines/cmdline-04-trace-options.cmdline      |    1 +
>  .../cmdlines/cmdline-05-trace-clock.cmdline        |    1 +
>  .../cmdlines/cmdline-06-trace-instance.cmdline     |    1 +
>  .../ftrace/boottime/tests/cmdline-01-ftrace.sh     |   19 ++++++++++++++
>  .../boottime/tests/cmdline-02-trace-event.sh       |   26 +++++++++++++++++++
>  .../boottime/tests/cmdline-03-trace-buf-size.sh    |   28 ++++++++++++++++++++
>  .../boottime/tests/cmdline-04-trace-options.sh     |   23 ++++++++++++++++
>  .../boottime/tests/cmdline-05-trace-clock.sh       |   19 ++++++++++++++
>  .../boottime/tests/cmdline-06-trace-instance.sh    |   24 +++++++++++++++++
>  12 files changed, 145 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-01-ftrace.cmdline
>  create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-02-trace-event.cmdline
>  create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-03-trace-buf-size.cmdline
>  create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-04-trace-options.cmdline
>  create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-05-trace-clock.cmdline
>  create mode 100644 tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-06-trace-instance.cmdline
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-01-ftrace.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-02-trace-event.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-03-trace-buf-size.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-04-trace-options.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-05-trace-clock.sh
>  create mode 100644 tools/testing/selftests/ftrace/boottime/tests/cmdline-06-trace-instance.sh
> 
> diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-01-ftrace.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-01-ftrace.cmdline
> new file mode 100644
> index 000000000000..4f6fc54240c8
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-01-ftrace.cmdline
> @@ -0,0 +1 @@
> +ftrace=function
> diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-02-trace-event.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-02-trace-event.cmdline
> new file mode 100644
> index 000000000000..66bcd29b14cb
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-02-trace-event.cmdline
> @@ -0,0 +1 @@
> +trace_event=sched:sched_switch,kmem:kmalloc
> diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-03-trace-buf-size.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-03-trace-buf-size.cmdline
> new file mode 100644
> index 000000000000..e5d1c4a8ca89
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-03-trace-buf-size.cmdline
> @@ -0,0 +1 @@
> +trace_buf_size=2048K
> diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-04-trace-options.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-04-trace-options.cmdline
> new file mode 100644
> index 000000000000..51d82f8e948d
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-04-trace-options.cmdline
> @@ -0,0 +1 @@
> +trace_options=sym-addr,verbose
> diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-05-trace-clock.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-05-trace-clock.cmdline
> new file mode 100644
> index 000000000000..f72a4ac808a3
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-05-trace-clock.cmdline
> @@ -0,0 +1 @@
> +trace_clock=global
> diff --git a/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-06-trace-instance.cmdline b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-06-trace-instance.cmdline
> new file mode 100644
> index 000000000000..9618e3e2b88b
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/boottime/cmdlines/cmdline-06-trace-instance.cmdline
> @@ -0,0 +1 @@
> +trace_instance=bar,sched:sched_switch
> diff --git a/tools/testing/selftests/ftrace/boottime/tests/cmdline-01-ftrace.sh b/tools/testing/selftests/ftrace/boottime/tests/cmdline-01-ftrace.sh
> new file mode 100644
> index 000000000000..23a0b15f2dd3
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/boottime/tests/cmdline-01-ftrace.sh
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2026, Google LLC.
> +# Check ftrace= kernel command-line tracer setting
> +TRACEDIR="/sys/kernel/tracing"
> +
> +if [ ! -f "$TRACEDIR/current_tracer" ]; then
> +	echo "FAIL: current_tracer does not exist"
> +	exit 1
> +fi
> +
> +read -r TRACER _ < "$TRACEDIR/current_tracer"
> +if [ "$TRACER" != "function" ]; then
> +	echo "FAIL: current_tracer is '$TRACER', expected 'function'"
> +	exit 1
> +fi
> +
> +echo "PASS: cmdline-01-ftrace"
> +exit 0
> diff --git a/tools/testing/selftests/ftrace/boottime/tests/cmdline-02-trace-event.sh b/tools/testing/selftests/ftrace/boottime/tests/cmdline-02-trace-event.sh
> new file mode 100644
> index 000000000000..b793907c48cd
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/boottime/tests/cmdline-02-trace-event.sh
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2026, Google LLC.
> +# Check trace_event= kernel command-line setting
> +TRACEDIR="/sys/kernel/tracing"
> +
> +if [ ! -d "$TRACEDIR/events/sched/sched_switch" ]; then
> +	echo "FAIL: event sched:sched_switch does not exist"
> +	exit 1
> +fi
> +
> +if [ ! -d "$TRACEDIR/events/kmem/kmalloc" ]; then
> +	echo "FAIL: event kmem:kmalloc does not exist"
> +	exit 1
> +fi
> +
> +ENABLE1=$(cat "$TRACEDIR/events/sched/sched_switch/enable")
> +ENABLE2=$(cat "$TRACEDIR/events/kmem/kmalloc/enable")
> +
> +if [ "$ENABLE1" != "1" ] || [ "$ENABLE2" != "1" ]; then
> +	echo "FAIL: events not enabled (sched_switch=$ENABLE1, kmalloc=$ENABLE2)"
> +	exit 1
> +fi
> +
> +echo "PASS: cmdline-02-trace-event"
> +exit 0
> diff --git a/tools/testing/selftests/ftrace/boottime/tests/cmdline-03-trace-buf-size.sh b/tools/testing/selftests/ftrace/boottime/tests/cmdline-03-trace-buf-size.sh
> new file mode 100644
> index 000000000000..2eab5fb487a3
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/boottime/tests/cmdline-03-trace-buf-size.sh
> @@ -0,0 +1,28 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2026, Google LLC.
> +# Check trace_buf_size= kernel command-line setting
> +TRACEDIR="/sys/kernel/tracing"
> +
> +if [ ! -f "$TRACEDIR/buffer_size_kb" ]; then
> +	echo "FAIL: buffer_size_kb does not exist"
> +	exit 1
> +fi
> +
> +BUF_RAW=$(cat "$TRACEDIR/buffer_size_kb")
> +case "$BUF_RAW" in
> +	*"expanded:"*)
> +		BUFSIZE=$(echo "$BUF_RAW" | sed -n 's/.*expanded: *\([0-9]*\).*/\1/p')
> +		;;
> +	*)
> +		BUFSIZE=$(echo "$BUF_RAW" | awk '{print $1}')

Hmm, as Sashiko said:

> Will this script fail at runtime if the expanded: string is missing?
> The boottime initramfs busybox environment (defined in BUSYBOX_APPLETS in
> tools/testing/selftests/ftrace/boottime/run_boottime_test.sh) doesn't seem to
> include awk. If awk isn't available, wouldn't BUFSIZE evaluate to an empty
> string and cause a false positive test failure?

yes, I forgot to add awk in applets. I think it should be definable for each
test script. Something like:

# APPRET: awk

Thanks,

> +		;;
> +esac
> +
> +if [ -z "$BUFSIZE" ] || [ "$BUFSIZE" -lt 2048 ]; then
> +	echo "FAIL: buffer_size_kb is '$BUF_RAW', expected >= 2048"
> +	exit 1
> +fi
> +
> +echo "PASS: cmdline-03-trace-buf-size"
> +exit 0
> diff --git a/tools/testing/selftests/ftrace/boottime/tests/cmdline-04-trace-options.sh b/tools/testing/selftests/ftrace/boottime/tests/cmdline-04-trace-options.sh
> new file mode 100644
> index 000000000000..53a65b55f7a7
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/boottime/tests/cmdline-04-trace-options.sh
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2026, Google LLC.
> +# Check trace_options= kernel command-line setting
> +TRACEDIR="/sys/kernel/tracing"
> +
> +if [ ! -f "$TRACEDIR/trace_options" ]; then
> +	echo "FAIL: trace_options file does not exist"
> +	exit 1
> +fi
> +
> +if ! grep -qw "sym-addr" "$TRACEDIR/trace_options"; then
> +	echo "FAIL: sym-addr option is not set in trace_options"
> +	exit 1
> +fi
> +
> +if ! grep -qw "verbose" "$TRACEDIR/trace_options"; then
> +	echo "FAIL: verbose option is not set in trace_options"
> +	exit 1
> +fi
> +
> +echo "PASS: cmdline-04-trace-options"
> +exit 0
> diff --git a/tools/testing/selftests/ftrace/boottime/tests/cmdline-05-trace-clock.sh b/tools/testing/selftests/ftrace/boottime/tests/cmdline-05-trace-clock.sh
> new file mode 100644
> index 000000000000..d6de9f6e2090
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/boottime/tests/cmdline-05-trace-clock.sh
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2026, Google LLC.
> +# Check trace_clock= kernel command-line setting
> +TRACEDIR="/sys/kernel/tracing"
> +
> +if [ ! -f "$TRACEDIR/trace_clock" ]; then
> +	echo "FAIL: trace_clock file does not exist"
> +	exit 1
> +fi
> +
> +if ! grep -q '\[global\]' "$TRACEDIR/trace_clock"; then
> +	CLOCK=$(cat "$TRACEDIR/trace_clock")
> +	echo "FAIL: trace_clock is not set to global ($CLOCK)"
> +	exit 1
> +fi
> +
> +echo "PASS: cmdline-05-trace-clock"
> +exit 0
> diff --git a/tools/testing/selftests/ftrace/boottime/tests/cmdline-06-trace-instance.sh b/tools/testing/selftests/ftrace/boottime/tests/cmdline-06-trace-instance.sh
> new file mode 100644
> index 000000000000..aae7f0a86d81
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/boottime/tests/cmdline-06-trace-instance.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2026, Google LLC.
> +# Check trace_instance= kernel command-line setting
> +TRACEDIR="/sys/kernel/tracing"
> +
> +if [ ! -d "$TRACEDIR/instances/bar" ]; then
> +	echo "FAIL: trace instance bar does not exist"
> +	exit 1
> +fi
> +
> +if [ ! -d "$TRACEDIR/instances/bar/events/sched/sched_switch" ]; then
> +	echo "FAIL: event sched_switch does not exist in instance bar"
> +	exit 1
> +fi
> +
> +ENABLE=$(cat "$TRACEDIR/instances/bar/events/sched/sched_switch/enable")
> +if [ "$ENABLE" != "1" ]; then
> +	echo "FAIL: event sched_switch is not enabled in instance bar ($ENABLE)"
> +	exit 1
> +fi
> +
> +echo "PASS: cmdline-06-trace-instance"
> +exit 0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
