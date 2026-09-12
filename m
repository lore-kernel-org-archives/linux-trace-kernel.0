Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACBB35F191
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203735; cv=none; b=F+lTcf36UQTNn/53+mhZbR2tB+K6UZMFP30maAzLrhB2bTZM+Aexn0QznVU53QF/9V+JP2U8QGcJsdwvR4XdCswrUVjltpNfAIVMmWREhMYYc/MbIIm235xWSrE95LMFvKhCMbxMXwB7kUCH5q68ofz3idr9P1akmIeRF9e5Kl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203735; c=relaxed/simple;
	bh=eV5LKezDVhtaf7fzdcnYfaIPvn0oz2TIs0JZ8CzHPF8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZbV2CyAuAz876rXFigKF4XUkeR/+st7XcPpNJuqrRsXdTsZQgbuE8vxDJusMyqhtmTNSwIFTWf5XgCEcG0GxqEf4TScn8vi3BZoGMjBwXF1ivNTF1kVQEVmb9CA0eRu32ar1Q8ahr4pjZMtGnMOlg0JV20wv5WEsCSmam6jIe0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjQmGYhp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjQmGYhp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77861F00893;
	Sat, 12 Sep 2026 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789203733;
	bh=ccln8aE84S9x+6CC+0r7osotSADbfKZabtE/wXhbuJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fjQmGYhpTm9NCpSQWtTHKr6a81tQKBOWbbyGMMvxSoWC05f8qmNut2/0LcnABaVtq
	 G7AzcTtU52Cb6N8tjKdk/XuKF01y9ogZr2O6pBvPr/3WIxbUbv9UMK4c1N3pHl+I28
	 CloAmQ2gH2aKfbhhDG+HPe+GFfaChFV91mqhnHtqQCb99FLJeADGZ5kgCwm23f0RSF
	 K6Ao4A742d9BQGNGyX1cc1q60++qQY1PwOU18VZN4NDbMmEr8ztzL6uVAQzwob2IFA
	 zVmp/Rp70dMg5UYDJo0cKONb78hg/m/GwZgLKW1bQ40BrvJr9detdHTNbNfj1yaHac
	 GhUuxvyFJ1oLg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v7 08/10] selftests/ftrace: add a stackmap basic
 functionality test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Pengfei" <ljdlns1987@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260912083753.3426176-9-lipengfei28@xiaomi.com>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
 <20260912083753.3426176-9-lipengfei28@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 09:02:13 +0000
Message-Id: <20260912090213.C77861F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims a check is performed to verify that po=
st-reset successes are below pre-reset successes, but this check is explici=
tly omitted in the script because it is flaky.
--

commit 874f10b935c1daaa7ebb380b794d32d569fa81af
Author: Pengfei Li <lipengfei28@xiaomi.com>

selftests/ftrace: add a stackmap basic functionality test

This commit adds a basic selftest for ftrace stackmap deduplication. It
exercises stackmap through sched_switch event stack capture, resets the
map while tracing, and validates counter logic and record reuse.

>     Reset the map five times while tracing and the filtered writer remain
>     active. Before each reset, require at least eight successes. Immediat=
ely
>     after reset, send SIGSTOP and wait until /proc reports the worker in a
>     stopped state before disabling tracing and sampling counters. Require=
 the
>     post-reset success count to be below the pre-reset count, proving tha=
t the
>     sample belongs to a new generation. Reset again while the writer is
>     stopped and require exactly zero entries before resuming and refillin=
g.

[Severity: Medium]
Does the commit message need to be updated to match the code?

The commit message claims a check is performed to verify the post-reset
success count is below the pre-reset count. However, the test code itself
explicitly documents that no such counter is compared, because it would
make the test flaky:

> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.=
tc b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/stackmap-basic.tc
[ ... ]
> +# Reset repeatedly while the owned writer is active, then again once it =
is
> +# quiesced. Only deterministic properties are asserted:
> +#
> +#   - While the writer runs, the reset must be accepted. No counter is
> +#     compared here: the writer resumes claiming records as soon as rese=
t()
> +#     returns, so any snapshot taken afterwards is a moving target and w=
ould
> +#     make this test flaky rather than prove anything.

Should the commit message be revised to reflect the actual test logic that
intentionally skips this comparison?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912083753.3426=
176-1-lipengfei28@xiaomi.com?part=3D8
