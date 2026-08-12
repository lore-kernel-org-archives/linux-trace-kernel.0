Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202243B6C9
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554144; cv=none; b=PHg2cs8sQrPO5yWvh1x02+IPEpLk1AaKQuBue/3cO3vy2xnJxrIgVJLYJ2ZtnT3aXR/jay4Za3cDV0jkorgqo2H52SMlbtL+bqWjQwdy2MOx1fbRSVb82tzYa0z1yCvEGZJl+ohq4/Z6TtaDaJRIlgff5vZNDcaBVlB0d/UW9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554144; c=relaxed/simple;
	bh=BIaxEUHN+c7sF6KkYQHUVFeAAO1BlWn/69suirl3FQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p/jxyyaSjSkEIITcSnaS+hsVFj9jwf4eEe1h8xsYHWr4CsrpFz3PF0JEiFDHfviYagl2DvLIipf/18pgNpvAECXjBJCEpus/zW64xyP9QYxXTh6LuHnzHSgmpgzjs+JFK36DoyzosFOLDGM+JjZce7NG6Y2v8D4VWpB3u6RfX0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYPYcJTu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYPYcJTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54691F000E9;
	Wed, 12 Aug 2026 17:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786554143;
	bh=unUnbEtSuySPqstc3Y6oLOBXDsW0HoTsnE8JMnYD/Bg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gYPYcJTuxs4miy3qFKtg9o2aJi9d1CW9EKvuicAlRuo0faKwOGjmAWnoY6K46g689
	 jl5St779apNg/8Y2IK5ayVnX5VPCSQqIHdV8zbiYkEEo6uwU13ynUOHOM2ofzy0QX1
	 Ie6r5Y59f+0Asp0ZtHcXxwWfNOGVwRPD8o12weUXcwVlgsEGC8qvXxu/pGwO8KzPCd
	 VKM0Nwdj2neNfe341f34bZxqfmoNOJA0iWrPl0Yu7zfVmljpOLIUA4Wlqg5jyYUl8D
	 xVbyq5dFQPxBuME0fRnTVgq4zgi9QKFXVhEv27aeKq9WCHS2XZeDPmfJ0keoiR0uHf
	 DVwJA3eis06sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/18] tracing/remotes: selftests: Add a test for the
 dump_on_panic tracefs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812161340.2417322-15-vdonnefort@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-15-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:02:22 +0000
Message-Id: <20260812170222.D54691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The test contains an unconditional early return, leaving dead co=
de intended to manually trigger a kernel panic, which fails to validate the=
 feature and creates a dangerous booby trap.
- [Medium] Unconditional write to `dump_on_panic` in the shared `setup_remo=
te()` function will break all ftrace remote selftests on older kernels.
- [Medium] The new test fails instead of gracefully skipping on kernels tha=
t do not support the dump_on_panic feature.
--

--- Patch [14]: [PATCH v5 14/18] tracing/remotes: selftests: Add a test for=
 the dump_on_panic tracefs file ---
commit 77956bd02c91415a58b7ae353d502fbc7538fb12
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: selftests: Add a test for the dump_on_panic tracefs file

This patch adds a selftest for the dump_on_panic tracefs file. It creates a
new test script and updates the remote setup functions to configure the
parameter.

> diff --git a/tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.=
tc b/tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.tc
> new file mode 100644
> index 0000000000000..cb9b4c6dc86c5
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.tc
> @@ -0,0 +1,51 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Test trace remote dump_on_panic
> +# requires: remotes/test
> +
> +. $TEST_DIR/remotes/functions
> +
> +test_dump_on_panic()
> +{
> +    #
> +    # Toggle when the buffer is loaded
> +    #
> +    assert_loaded

[Severity: Medium]
Since this test specifically targets the dump_on_panic file, should there be
an existence check here (such as [ -f dump_on_panic ] || exit_unsupported) =
to
prevent false negatives?

Without this check, the test fails instead of gracefully skipping on kernels
that do not support the dump_on_panic feature.

> +    echo 1 > dump_on_panic
> +    echo 0 > dump_on_panic

[ ... ]

> +    echo 1 > dump_on_panic
> +    echo 1 > tracing_on
> +    echo 0 > tracing_on
> +
> +    # REMOVE ME FOR A PROPER OOPS TEST
> +    return
> +
> +    echo 1 > tracing_on
> +
> +    for i in $(seq 1 32); do
> +        echo $i > write_event
> +    done
> +
> +    echo c > /proc/sysrq-trigger
> +}

[Severity: Medium]
Is this early return intentional?

This skips the actual panic-triggering code, leaving the dump_on_panic
feature untested. Furthermore, leaving the sysrq-trigger command behind
an early return could be dangerous if someone removes the return without
realizing it will crash the host machine during a CI run.

> +
> +if [ -z "$SOURCE_REMOTE_TEST" ]; then
> +    set -e
> +    setup_remote_test
> +    test_dump_on_panic
> +fi
> diff --git a/tools/testing/selftests/ftrace/test.d/remotes/functions b/to=
ols/testing/selftests/ftrace/test.d/remotes/functions
> index 4a14aa72fdf09..bdd28b5b85966 100644
> --- a/tools/testing/selftests/ftrace/test.d/remotes/functions
> +++ b/tools/testing/selftests/ftrace/test.d/remotes/functions
> @@ -9,6 +9,7 @@ setup_remote()
>  	cd remotes/$name/
>  	echo 0 > tracing_on
>  	echo 0 > dmesg
> +	echo 0 > dump_on_panic

[Severity: Medium]
Could this unconditional write cause failures on older kernels?

Because setup_remote() is a shared setup function, and test scripts execute
with set -e (errexit), if this is run against an older kernel lacking the
dump_on_panic file, the shell will immediately abort. This would break all
ftrace remote selftests on those kernels.

>  	clear_trace
>  	echo 7 > buffer_size_kb
>  	echo 0 > events/enable

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812161340.2417=
322-1-vdonnefort@google.com?part=3D14
