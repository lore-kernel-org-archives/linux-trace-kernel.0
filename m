Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF43440656
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164295; cv=none; b=J8oXvvx6e76DUz4II3oyW1n4C/HPHIDqYKDbOInyf5urPTFnM61Rgf4W5iM0UpVthVIYl/QSRwXy6HJqV6OH4kC7XWbDvU3GYxTRTex4nHN9B7OR6DPmK/1+7In5WiuA6S3fXstgfoSWBqmI5HYDyYdZ6o9AWmLaOzsF2WU8Nic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164295; c=relaxed/simple;
	bh=vAU9vgROXTf2FRO9haQ3qcBLs1+rx4d3/kfw4GfAYXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DybrQTKV9Z+x8ndxMX6i7yHGg6bqiiUG+JC3ztKLqrUmCgXLZV9MahlihTK/RNkj+QwBT/9MyXi/e+6/I7fm2xDRzMmQhkuaro4S5M+Nvx+Q3zfRuFv0ObQiKDSrrMpKI2ksFknL+BtTl7h/XjgJY+DYsh2ZXlA/6PMm8ax0C8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcv7o8vs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcv7o8vs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE301F000E9;
	Wed, 19 Aug 2026 18:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787164293;
	bh=1WqZ0ViI5tk7nsrO94k/gDInfQPMpVEorf4+V3uK9Yw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bcv7o8vswHbgDR6xaxd4O9OrOhPxePJliPynAhaqAXCle5cFaEmyW1+mAf+WXJCRO
	 Rrf2Tc0tPcK7MuQnMKFFj5Mzdvb51ZC6Riufq2IX8KyaOZwhB5l/s8FqXeoa++feyl
	 LoBQmH5DnslmY3PXNqmEp0kaefP8AVFXJ1xX10DPl8yZX6QMis9lQ50gG169Si/IPZ
	 5uV4OD6s4g+au1ZbmNaLOwvLdmAuoDKNZgDDaD0KKlUtv8X/GFhKuhXQxUYoNSahJm
	 ZOEiv/1AYU2d0n/q1HjlOLdV00zOoNkk1M/9FeHYBjT4+6w/3yUo1/HJuYR2Cmk+Jc
	 yJ3htEN/3czfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 9/9] selftests/ftrace: Walk up to find
 test.d/functions when a subdirectory is passed
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <7808194405719fd0ae7b0bcf4301c5902eb31929.1787161646.git.wen.yang@linux.dev>
References: <cover.1787161646.git.wen.yang@linux.dev>
 <7808194405719fd0ae7b0bcf4301c5902eb31929.1787161646.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:31:33 +0000
Message-Id: <20260819183133.5EE301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Local Privilege Escalation via untrusted directory traversal when =
implicitly sourcing test.d/functions.
- [Medium] Infinite loop in directory traversal when testing top-level dire=
ctories due to POSIX 'dirname' behavior with double slashes.
--

--- Patch [9]: [PATCH v5 9/9] selftests/ftrace: Walk up to find test.d/func=
tions when a subdirectory is passed ---
commit 982c65a7f93c6d254f86b734c29fd401b0e3707a
Author: Wen Yang <wen.yang@linux.dev>

selftests/ftrace: Walk up to find test.d/functions when a subdirectory is p=
assed

When a test directory that does not itself contain test.d/functions is
passed to ftracetest (e.g. verification/test.d/tlob/), ftracetest fell
back to its own functions file and lost the rv-specific check_requires
handling for ':monitor' and ':reactor' requirements.

> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/se=
lftests/ftrace/ftracetest
> index 0a56bf209f6c0..3ba929820dd2c 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -159,9 +159,20 @@ parse_opts() { # opts
>    if [ -n "$OPT_TEST_CASES" ]; then
>      TEST_CASES=3D$OPT_TEST_CASES
>    fi
> -  if [ -n "$OPT_TEST_DIR" -a -f "$OPT_TEST_DIR"/test.d/functions ]; then
> -    TOP_DIR=3D$OPT_TEST_DIR
> -    TEST_DIR=3D$TOP_DIR/test.d
> +  if [ -n "$OPT_TEST_DIR" ]; then
> +    # Walk up from OPT_TEST_DIR to find the nearest ancestor that contai=
ns
> +    # test.d/functions.  This allows a monitor subdirectory (e.g.
> +    # verification/test.d/tlob/) to be passed directly without placing a
> +    # dummy functions shim in each new subdirectory.
> +    dir=3D$OPT_TEST_DIR
> +    while [ "$dir" !=3D "/" ]; do

[Severity: Medium]
Can this loop run indefinitely if a user passes a directory directly under
the root, like /tmp?

If the path is formatted as //tmp, GNU dirname preserves double leading
slashes because it treats them as POSIX UNC paths. If dir starts as //tmp,
dirname "$dir" evaluates to //, and the loop condition [ "$dir" !=3D "/" ]
will evaluate to true infinitely, causing the test script to hang.

> +      if [ -f "$dir/test.d/functions" ]; then
> +        TOP_DIR=3D$dir
> +        TEST_DIR=3D$TOP_DIR/test.d
> +        break
> +      fi

[Severity: High]
Could this directory traversal lead to arbitrary code execution if the path
walks back through a world-writable directory?

If ftracetest is run as root on a trusted directory inside a path like
/tmp/legitimate_tests/, the loop will traverse up to /tmp and search for
/tmp/test.d/functions.

An unprivileged attacker could preemptively plant a malicious script at
that location. The script would then be found, and since the ftracetest
script later sources this file, it would execute the attacker's code with
root privileges.

> +      dir=3D$(dirname "$dir")
> +    done
> +  fi
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787161646.gi=
t.wen.yang@linux.dev?part=3D9
