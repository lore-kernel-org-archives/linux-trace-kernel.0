Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9924A4307AB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552841; cv=none; b=ZVc5nIecFQd9sUSrHwTDfplczRH59UvgiRotTEO8+D84SavOpOXdKYRdLXHCLlanDvjHkZ9MRw5ZYBlYzcRQPRMyS8Gqj7jBElMoB8E5B17q21zf6w0NRlmraRlwSpZH9UGwbQ4juf/GcbAfoHKkZT9FWDZVfKzSQEoKVNOM6/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552841; c=relaxed/simple;
	bh=ZxweUUL6bAaXRrpRG9WeZ9ZSKmsgQSKbzfIcAruZUdk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pZUMT7RVlht0Q+LfTZqiK31QlWvF6jHdInzz2PTwTsoe1nDva+vfELm5ryi/B3h+hOR1ttYSjj8l80x8a2j2x0cuugtpFKTwrTEpjFSyVDayWHPoxZKvreTxdy7H0S/f7nOtsTkWW3Ytp+3NjFRP/ZmrNLE0CuoPRVZAtK/yT2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W87m8fxA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W87m8fxA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F761F000E9;
	Wed, 12 Aug 2026 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552840;
	bh=Cm6hKKdydKmaLwAQipbQkNX1N7liUHQbXdEYlgnTvRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W87m8fxA6C6FEzS7W5FThZAKSTSCQKxlqFGtYiYv4t+YuzwXKLh6eRL3EYmVN8aDX
	 ixGmDoqG3VdoVWCV2kisa1lEEKRFRqNbp9klwCH9fGE4lu7lfCfql7TdsrnGQwjcoN
	 bYEGjnX1Wu6jBQOzL8WpdVTIUN+Vo0n1fvKfRbuevgqMCp6LKyx3/Onnm6G4IV7Do8
	 ou7RUNa7xK4KHPqyIuWbpHmSTArKJndEJ74MY8t/8IXTfo0CtO/YrQz4/pOnwlkwbD
	 0y5WEVmVZWsQCw+hjezUTwSDHhW2OboG8FAPAYC65fUKlbF59Df39UddnEjL2o85s6
	 8DOWbydIvmkLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/18] tracing/remotes: selftests: Add a test for the
 dmesg tracefs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812161340.2417322-8-vdonnefort@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-8-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:40:39 +0000
Message-Id: <20260812164040.19F761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The test script leaks a temporary file in `/tmp/` if the test ab=
orts due to a failure (e.g., when a command fails under `set -e`).
- [Medium] Unconditional write to the new `dmesg` tracefs file breaks the e=
ntire remote trace test suite on older kernels.
- [Medium] The new `dmesg.tc` script lacks the necessary `# requires:` head=
er for the `dmesg` tracefs file, causing it to fail instead of being skippe=
d on older kernels.
- [Low] The awk regular expression for matching dmesg timestamps contains a=
n unescaped bracket, unintentionally creating a character class.
--

--- Patch [7]: [PATCH v5 07/18] tracing/remotes: selftests: Add a test for =
the dmesg tracefs file ---
commit bd86167985384496571cc5a8f03ca97dd77d76fd
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: selftests: Add a test for the dmesg tracefs file
   =20
Exercise the newly introduced dmesg tracefs file that turns on and off
the dmesg redirection.

> diff --git a/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc b/too=
ls/testing/selftests/ftrace/test.d/remotes/dmesg.tc
> new file mode 100644
> index 0000000000000..9d389f9d0fb78
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
> @@ -0,0 +1,81 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Test trace remote dmesg redirection
> +# requires: remotes/test

[Severity: Medium]
Does this script also need a "# requires: remotes/test/dmesg" declaration?

Without this explicit dependency, running the test on an older kernel that
lacks the dmesg tracefs file will cause it to fail abruptly due to set -e,
rather than gracefully skipping it as unsupported.

[ ... ]

> +    nr_events=3D128
> +    for i in $(seq 1 $nr_events); do
> +        echo $i > write_event
> +    done
> +
> +    sleep 1
> +    output=3D$(mktemp /tmp/remote_test.XXXXXX)

[Severity: Medium]
Will this leak a temporary file in /tmp/ if the test aborts prematurely?

The script is running with set -e, so if a validation step like check_trace
fails, it will immediately exit before reaching the rm $output command.

Should this use $TMPDIR instead, since the ftracetest framework cleans it up
automatically?

> +    dmesg | awk -v ts=3D$last_ts '
> +    /^[ *[0-9]+\.[0-9]+\]/ {

[Severity: Low]
Does this regular expression match the bracket as intended?

By failing to escape the first bracket (^[), this creates a character class
that matches spaces, asterisks, brackets, or digits instead of a literal
opening bracket.

Could this be properly escaped as /^\[ *[0-9]+\.[0-9]+\]/ ?

> +        t=3D$0; sub(/^[[ \t]*/, "", t); sub(/].*/, "", t);
> +        if (t+0 > ts+0) print $0
> +    }' | grep "selftest id=3D" | sed 's/^[^]]*] //'> $output

[ ... ]

> diff --git a/tools/testing/selftests/ftrace/test.d/remotes/functions b/to=
ols/testing/selftests/ftrace/test.d/remotes/functions
> index 05224fac3653d..4a14aa72fdf09 100644
> --- a/tools/testing/selftests/ftrace/test.d/remotes/functions
> +++ b/tools/testing/selftests/ftrace/test.d/remotes/functions
> @@ -8,6 +8,7 @@ setup_remote()
> =20
>  	cd remotes/$name/
>  	echo 0 > tracing_on
> +	echo 0 > dmesg

[Severity: Medium]
Does this unconditional write break the test suite on older kernels?

This setup function is used by all remote selftests. If the dmesg file does
not exist, this echo will fail. Since the test scripts operate with set -e,
this failure will cause the entire suite to crash on unsupported targets.

Could we check for the file's existence before writing to it?

>  	clear_trace
>  	echo 7 > buffer_size_kb
>  	echo 0 > events/enable

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812161340.2417=
322-1-vdonnefort@google.com?part=3D7
