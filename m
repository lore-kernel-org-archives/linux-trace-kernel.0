Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8557378D6B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858070; cv=none; b=rAVDedwIDvS8vGnqd2/9ODuyd0o7ssRBW+Vl/HbVr/LUz/Higiv4S06a7O7adrbwxdin5wABOLs3XSnbZNTDeEfAU0FgEULbQaD+Zv0h77eAerMWwHSBXCA2C0TFuov9DzClC7WIckBrNQ9kl3rYtzsX57pKyDghiY02er3XnaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858070; c=relaxed/simple;
	bh=fL0hLgzb3MRWwbtLM9rc3bBqJVikgY91zZJucAyeqyA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AszjT+9mP7uqzfrtp8ig4AB6RjMPegUWof7I9txprDn25FeZtqc+sLruaOdGy3lEtOpogIO9GApBOzjUEe+UMTSY2KwkbOMLQBANr6SkwrrLfN07/9bkMkxTSH5oij7czyYuTy/xxOopBpawR4v0jzCjQne4uHk97MEhtyet8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/I8nYuW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/I8nYuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F711F000E9;
	Thu, 27 Aug 2026 19:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858068;
	bh=LT+QD+DNswCwq3vxNvZxGNz3hhgkwgGKtGfsjT7fWCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V/I8nYuW9tt0h0SGINSs3NH/0mwac/eQ7AEe3eQVfoUBwzU9BlMTGY5wM6o7gkssd
	 k5+OMPdJMsdYls9ehnx+tCHNh9CR00xNxVztBR3PI/9m23qlknqPjCLEoRY/n86OMm
	 X4YkgIVqVstSyMfJWUiYBeK5dRAvdzYFNKT3FZF225BHaxN4Fbxc7GeILD4CCjuqnv
	 sr2fCNCmAiYD+VpQJKsJXUrtCP588uUCXKLHsvlvzUPnPk5eCJAOC43TSze2NpRQjm
	 fGCWpDGyH2JKK1IComVx6QiF6nANaFqSRMuH4zSIgh9fdXufg9hL41dDvzfL3Aqw5F
	 K7WcT8kK9cabw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/6] selftests: prctl: Add test for long thread names
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260827-tonyk-long_name-v5-6-5fa843782a00@igalia.com>
References: <20260827-tonyk-long_name-v5-0-5fa843782a00@igalia.com>
 <20260827-tonyk-long_name-v5-6-5fa843782a00@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:14:28 +0000
Message-Id: <20260827191428.94F711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Stack buffer overflow in selftest when reading long thread names.
- [Medium] Helper functions return negative error codes on prctl failures, =
but the test framework incorrectly evaluates these as success.
--

commit fe809367165b80380a7910f0d6bf3371b37e1de5
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

selftests: prctl: Add test for long thread names

Add tests for the new interface to set and get long thread names. The
kernel should accept the LONG_NAME and returning it accordingly. For the
old PR_GET_NAME interface, the kernel should truncate the name up to 16
chars. /proc/<task>/comm should return the same string ad PR_GET_NAME.

> diff --git a/tools/testing/selftests/prctl/set-process-name.c b/tools/tes=
ting/selftests/prctl/set-process-name.c
> index 3f7b146d36dfe..951319d606561 100644
> --- a/tools/testing/selftests/prctl/set-process-name.c
> +++ b/tools/testing/selftests/prctl/set-process-name.c

[ ... ]

> @@ -82,6 +114,11 @@ TEST(rename_process) {
>  	EXPECT_GE(set_name(CHANGE_NAME), 0);
>  	EXPECT_TRUE(check_is_name_correct(CHANGE_NAME));
> =20
> +	EXPECT_GE(set_ext_name(LONG_NAME), 0);
> +	EXPECT_TRUE(check_is_ext_name_correct(LONG_NAME));
[Severity: Medium]
If prctl() fails in check_is_ext_name_correct(), it returns a negative error
code. Since EXPECT_TRUE() evaluates any non-zero value as true, won't this
cause the test to incorrectly pass on failure?

Should the helper function return 0 on failure, or should the test use
EXPECT_EQ(1, check_is_ext_name_correct(LONG_NAME)) instead?

> +	EXPECT_TRUE(check_is_name_correct(LONG_NAME_CAP));
> +	EXPECT_TRUE(check_name());
[Severity: Medium]
When this test runs, it calls check_name() while the thread name is set to a
33-character string.

If the kernel incorrectly fails to truncate the long process name when read=
ing
/proc/self/task/.../comm, could this cause a stack buffer overflow?

tools/testing/selftests/prctl/set-process-name.c:check_name() {
	char output[TASK_COMM_LEN] =3D {};
	...
	fscanf(fptr, "%s", output);
	...
}

Since fscanf with "%s" is unbounded, a long name surfaced by the kernel will
overflow the 16-byte output buffer and crash the test. Should we add a width
limit like "%15s" to the fscanf call to prevent this?

> +
>  	EXPECT_GE(set_name(EMPTY_NAME), 0);
>  	EXPECT_TRUE(check_is_name_correct(EMPTY_NAME));
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-tonyk-long=
_name-v5-0-5fa843782a00@igalia.com?part=3D6
