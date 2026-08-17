Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484563B811F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975517; cv=none; b=k6gxD+8wx+hmgBadmvHyePFCoCSGEmXvZSD+zPly6D7fTXxDZSb28uoFfTfdgdcQldNwmKZ2y1j5zu8B7hheZ44QFYPmVEUN+SxQFkh52BT33V0YgNU8yV1kh2pbX0Z/zLNkgRXIcD42ZfXC6ueElGU71rEzO7n6CvNQYszwsT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975517; c=relaxed/simple;
	bh=Q2Ey1AANsOKFOHjRvF3SG0jg53UftD+jHv4F/W+JM+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WP/YItbeOZVlPL2rSwn0UFMD+4edjwCBk8YgSkzTHpGWmocmNjv+aJCVH7H1X1rfDrNJSOr88FyB62LqsMseZplUeHFOkBn1wTpEuTVF66NtBhl90SzWZ9MXfpeMfrWXhzNPASRWt9woF8yY3wthkYAhtZMtoVlBh7qAbCXqqOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbKg8/X1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbKg8/X1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE67B1F00A3A;
	Mon, 17 Aug 2026 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975515;
	bh=8BKTAvZKzlN4KNmS50jsH78KF4vNb4HKLq6ajMydq4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fbKg8/X1akRAKv2Owixtxub2lxqOBHIZ52SBzG7KAY6koIK2utVebQI1+nMBh7bR0
	 T1JkupcuRfBNG73wobTuzZBbCNgF68wu9FhT/lhsNMxRW5Us7Vu9Pf9vsJ+9ktaRML
	 aHhoetjaANaHX0UQOeuHvq+xIoM5QU7jRN1Db604cMGqF36BPRWrdEtX6uD1xjmhcP
	 0dIe5EX0YgyFaPFkOGJjPEw35NbMEP/5oOjwTuLoGA/TRuGhsH2Vs1hDzE/mVK82UY
	 Efm5VJakxjwFIwg/UqHz+QuR5w1G+KaHS2JyjWQSBb+n2O+VW924GrXQ4tN8y5xuuk
	 OMI8uDNU5gLIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/18] tracing/remotes: selftests: Add a test for the
 dmesg tracefs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260817135517.3919534-8-vdonnefort@google.com>
References: <20260817135517.3919534-1-vdonnefort@google.com>
 <20260817135517.3919534-8-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:05:14 +0000
Message-Id: <20260817140514.DE67B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unconditional write to the newly introduced `dmesg` tracefs file=
 in `setup_remote()` breaks existing remote tests on older kernels lacking =
this feature.
- [Medium] The dmesg test implicitly depends on dmesg timestamps and silent=
ly fails if they are disabled.
--

--- Patch [7]: [PATCH v6 07/18] tracing/remotes: selftests: Add a test for =
the dmesg tracefs file ---
commit f74a3f691a6b4375c6156c109a1d6336670de341
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: selftests: Add a test for the dmesg tracefs file

This commit adds a new selftest to exercise the newly introduced dmesg
tracefs file. It checks the ability to turn on and off dmesg redirection.

> diff --git a/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc b/too=
ls/testing/selftests/ftrace/test.d/remotes/dmesg.tc
> new file mode 100644
> index 0000000000000..74f801a5e39ea
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc

[ ... ]

> +    sleep 1
> +    output=3D$(mktemp $TMPDIR/remote_test.XXXXXX)
> +    dmesg | awk -v ts=3D$last_ts '
> +    /^\[ *[0-9]+\.[0-9]+\]/ {
> +        t=3D$0; sub(/^\[[ \t]*/, "", t); sub(/].*/, "", t);
> +        if (t+0 > ts+0) print $0
> +    }' | grep "selftest id=3D" | sed 's/^[^]]*] //'> $output

[Severity: Medium]
Does this implicitly depend on dmesg timestamps being enabled?

If the kernel is configured with CONFIG_PRINTK_TIME=3Dn, or if the user-spa=
ce
dmesg utility suppresses timestamps by default, the output won't have the
[ X.Y] prefix.

The awk script strictly expects this format and drops lines that do not
match the prefix. This would result in an empty temporary file. Because
the script executes with set -e, an empty file might cause the subsequent
check_trace validation to abort the test.

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
Will this unconditional write break existing remote tests when run on older
kernels?

Since this test suite frequently runs with set -e enabled in the caller
scripts, if the dmesg tracefs file does not exist on an older kernel, this
echo command will fail with a "No such file or directory" error and abort
the script.

Could we check if the dmesg file exists before attempting to write to it?

>  	clear_trace
>  	echo 7 > buffer_size_kb
>  	echo 0 > events/enable

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817135517.3919=
534-1-vdonnefort@google.com?part=3D7
