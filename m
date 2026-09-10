Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F635201F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059662; cv=none; b=QegrsNVgHvyJJrrEsIg5U1YumQmtU6K53XRTrzeLmii6WIY6eAuGL23SMGXyU314NaRucf+ro1U4oj3V0utOuBl3lUdL0CWNbvsFeJ2yq14L1GOPoARcs4NqfuXljtxxZJrNQ8CElJ8m9GP9hnOuzrR56M57pBgbu8E2vHH6Rks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059662; c=relaxed/simple;
	bh=GME9VIO3h0A1mbh4O7sbMrSVlEmY01n+Vd5zPwkIbAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V4oeVn4gUu49tFmO6i1IG+XK1QSRBP7DLGR7m8HhEAI2SaXbDDmm+s1/8/l/kyRdhvwPdtz/nQbHEG2huep/dOxL8JkysUgbrSoK3FSxmA42q3zy7gdfJQOPwvtDDW3j29Y8JihJh5V/CU3gkWmZ2bjPWH+HJH0LeSu8JigzCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfKeLosa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfKeLosa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC77D1F0089A;
	Thu, 10 Sep 2026 17:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789059650;
	bh=31eYmcDjwNrSXwnzZUMYMLIKZK6ne5al2JtV3ASIl0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IfKeLosa+S0moRV+VUIHXgNsFVcY0EVOrpJVynhHVU9/M9Axg2u9ucnARulgtvgCu
	 gt3mWThUdtc58cVw4iS2fyLnuZ4Jb7L6cjeRoyeICBf24Vw8+/yoZYGyFvO/ECYfL3
	 4qpRRO3sOjv1Hmbzouh+ErzPdL8IteRaYfSdWYCLqvoOI8W9RSyFK8fuu85VgEtXI8
	 6aAT18jAYE4Hz5pT6H4smROjLQMyBFAIVYOw5OsYvv7So43K5Ky++XSWZ+qhwk5gCC
	 +UP2zB3a6oMN3xsSMMhnO7rugW5xpNVXXV24eLj3peDxvS7sll4WHDMsL2FasRI7LJ
	 /VO+AUvZlkSRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6] selftests: prctl: Add test for long thread names
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260910-tonyk-long_name-v6-6-d70afbf194c5@igalia.com>
References: <20260910-tonyk-long_name-v6-0-d70afbf194c5@igalia.com>
 <20260910-tonyk-long_name-v6-6-d70afbf194c5@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:00:50 +0000
Message-Id: <20260910170050.BC77D1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `check_name()` function evaluates negative error codes as te=
st successes due to `EXPECT_TRUE()` behavior.
- [Medium] The test fails rather than gracefully skipping on older kernels =
lacking `PR_SET_EXT_NAME` support.
--

commit 56060d6784146397018fe8a302145c26fb029757
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Subject: selftests: prctl: Add test for long thread names

This commit adds tests for setting and getting long thread names using
the new extended PR_SET_EXT_NAME and PR_GET_EXT_NAME prctl interfaces. It
also adjusts the check_is_name_correct() function to prevent negative error
codes from being evaluated as successes by EXPECT_TRUE().

> diff --git a/tools/testing/selftests/prctl/set-process-name.c b/tools/tes=
ting/selftests/prctl/set-process-name.c
> --- a/tools/testing/selftests/prctl/set-process-name.c
> +++ b/tools/testing/selftests/prctl/set-process-name.c
[ ... ]
> @@ -80,10 +118,15 @@ int check_name(void)
>  TEST(rename_process) {
> =20
>  	EXPECT_GE(set_name(CHANGE_NAME), 0);
> -	EXPECT_TRUE(check_is_name_correct(CHANGE_NAME));
> +	EXPECT_FALSE(check_is_name_correct(CHANGE_NAME));
> +
> +	EXPECT_GE(set_ext_name(LONG_NAME), 0);

[Severity: Medium]
Will this test cause a failure rather than gracefully skipping on older
kernels?

If the test runs on a kernel where the PR_SET_EXT_NAME interface is
unsupported, set_ext_name() returns a negative error code like -EINVAL.
The EXPECT_GE assertion will fail the test entirely.

Should this test gracefully skip when run on kernels lacking support for
these new extensions?

> +	EXPECT_FALSE(check_is_ext_name_correct(LONG_NAME));
> +	EXPECT_FALSE(check_is_name_correct(LONG_NAME_CAP));
> +	EXPECT_TRUE(check_name());

[Severity: Medium]
Does this new test invocation suffer from the same logic error being fixed
in check_is_name_correct()?

The commit message explicitly mentions fixing check_is_name_correct() becau=
se
EXPECT_TRUE() evaluates negative error codes as success.

While the flawed logic in the check_name() function is a pre-existing issue,
it returns -EIO on file open failure and -errno on prctl failure:

tools/testing/selftests/prctl/set-process-name.c:check_name() {
    ...
    if (!fptr)
        return -EIO;
    ...
    if (res < 0)
        return -errno;
    ...
}

Since this patch introduces a new EXPECT_TRUE(check_name()) call here, won't
any file open or prctl failure be falsely evaluated as a test success? Could
we update check_name() as well to prevent this flaw from propagating?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-tonyk-long=
_name-v6-0-d70afbf194c5@igalia.com?part=3D6
