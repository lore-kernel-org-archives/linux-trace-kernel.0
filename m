Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792918000;
	b=KnSKeOEngoC5RE4TAw3vYHHpY1mVTxZd0aAhy4c89NH+CHOG4FJE8K5eoIbep7DXkuII
	 JStFoM1YKcC2zKabS8juuIJxYMQSYyFUuoX5LWIQnqr3O87FNZcpm0+FQs68Q5UDn5vql
	 7cPOqymyXCH9Ve9rJg8zEp9gZqex9N6HCOQdx91No+euY5uVLYhBIxdQ5OOEyOY/yXyB2
	 U9jwKTobGKCkc+D4gR6wHEwdyWoYnMLOmv7knVC6C0MriS9DLGHDTjs450g7QakX1CYoW
	 7GZWHtcEEugGNBa1Uvxp9HDMN2b4fldLsMGgZM6T3UQ0xvZ0IZyxvWYe2ZWlNKLriYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792918000;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VjLv5mAoTzvC2ga+hecWJ5i4AzHeRxnYcwWrLFwnYcg=;
	b=SSHNGRLxX8tU1nUlr+mHrH1+Jjg9ur4iEve9igMjX5fUSMo/2b2HWmgiG9BWt3IYIHxl
	 +GPEii41PNVjNwjmT/aZ7wuBrZyLj+PEIY5G/IiLi4+FeLH8LEBei44RsKpmVBeCi9IXA
	 hLF+pqTh1whKyNzRf1tnuYF/PuyL8NQHkUyj0rH8yzO16ltWSSpwcty6CcIeATO+gnR7T
	 uIkiMwtBFhAeScaG3AL81ZIH3fx26OyFsxQURb2g7qZjUe85ES7Irs8X73KyQ2jH7AqKj
	 w1BQINeuXtirX/yQUIdlatfBRLCgmGN5963sE4oqiyN0Gu7xCrjBkVqyGAVly3zqp3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ixw4FZRM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAD4606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ixw4FZRM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1585D1F01825;
	Sun, 25 Oct 2026 08:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792918000;
	bh=VjLv5mAoTzvC2ga+hecWJ5i4AzHeRxnYcwWrLFwnYcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ixw4FZRMB95l0uv/rz6ZfGelQjeWYP8nmSJL4sVcPg89XPC8fEPceqrT7uOYqP/Km
	 qRNoYf8Erfmp8WoGzh+r2PPLJHDd1/zTr12sLSaurohoI/Nn+0FOJZkBbd0Oo6ztn7
	 ImL3rSwLHCJiGdW1oaLo4tid8KlwOBEoDg9ndWprjj8TKsKHj7j/3PKG/t4OhSn+CS
	 1J7F7Jyx4yrirhOoEIYhd8D6US8dC6eHJehq46WDPAh86N99XVj6kMzrZzEVhD4KRM
	 1WaxNs47ZH/LejdwDiqSHRNIQ10ktv2D5JY8a/KBG8D+h+IJkPamDkj5DL6eW7i+h+
	 Xm7seR3O2hssw==
Message-ID: <sashiko-outbox-184136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 9/9] selftests/ftrace: Add event filter syntax check
 test case
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179291751117.492959.1147654467208615243.stgit@devnote2>
References: <179291742944.492959.11659339795290028998.stgit@devnote2>
 <179291751117.492959.1147654467208615243.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 08:46:39 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/ftrace: negated pipelines in filter-syntax-check.tc by=
pass set -e
--

commit 98a96a63f4d758b8db11a7d2138febf6cb5cf6e9
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

selftests/ftrace: Add event filter syntax check test case

This patch adds filter-syntax-check.tc to test valid event filter
expressions, error_log caret reporting for malformed filter expressions,
newline truncation on multi-line filter input, and error returns on invalid
subsystem filters.

> diff --git a/tools/testing/selftests/ftrace/test.d/filter/filter-syntax-c=
heck.tc b/tools/testing/selftests/ftrace/test.d/filter/filter-syntax-check.=
tc
> new file mode 100644
> index 0000000000000..68c8accc5ffd0
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/filter/filter-syntax-check.tc
> @@ -0,0 +1,52 @@

[ ... ]

> +# Multi-line input must be truncated at the first newline
> +echo > error_log
> +! ( printf "common_pid =3D=3D CPUS{0\n\"} && common_pid =3D=3D 0 && comm=
on_pid =3D=3D CPUS{0\n\"}" | \
> +    dd of=3Devents/sched/sched_switch/filter bs=3D4096 ) 2> /dev/null
> +grep -q "Missing '}'" error_log
> +! grep -q "Missing matching quote" error_log
> +
> +# Subsystem filter must fail on invalid filter expressions
> +echo 'common_pid >=3D 0' > events/sched/filter
> +! echo 'no_such_field =3D=3D 1' > events/sched/filter
> +! echo 'common_pid =3D=3D 1 &&' > events/sched/filter
> +echo 0 > events/sched/filter
> +
> +exit 0

[Severity: Medium]
Will these negated pipelines actually fail the test if any of the inner
commands unexpectedly succeed?

In tools/testing/selftests/ftrace/ftracetest, __run_test() sources each
test script in a /bin/sh subshell with set -e enabled:

    __run_test() { # testfile
      # setup PID and PPID, $$ is not updated.
      (cd $TRACING_DIR; read PID _ < /proc/self/stat; set -e; set -x;
       checkreq $1; initialize_system; . $1)
      [ $? -ne 0 ] && kill -s $SIG_FAIL $SIG_PID
    }

In POSIX sh, set -e is ignored for any pipeline beginning with the !
reserved word. If the dd, grep, or echo commands in filter-syntax-check.tc
unexpectedly return 0, the negated pipeline evaluates to status 1 without
causing the shell to exit, and execution continues through:

    echo 0 > events/sched/filter

    exit 0

allowing the test to pass even when a negative check fails. Should these use
explicit failure handling (such as || exit_fail) or wrap the negation in a
subshell so set -e catches an unexpected success?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179291742944.492959=
.11659339795290028998.stgit@devnote2?part=3D9
