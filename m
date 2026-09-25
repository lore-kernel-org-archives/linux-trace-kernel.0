Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42BE217F27
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360871; cv=none; b=KQDyLB7mMwekJuNPhobYgOfTp2hlGouE5vQjlcIL685MKQ/0ZdECOuwI43cswOGjBDjyvzOmZ4SypbdJSKwFIN3h6hJPuuKcVEws1cF9q3DmmUBiLPz79TLSJ5mGfbOKYz2M8AMb5xDOZTDMGVGuHkAKlB3YTmsA3SB1vD5k7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360871; c=relaxed/simple;
	bh=MtmLPTxz9CI4V2/WK2n8pQjR3yvfIkfHs/HRJGJFBOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cVo4QTLZP4uuzOlvwsz6WVsb7lTeKSPVmh2X6tadptnRog3/B2NXQUCXsWz9/QonWt+HdwJmGE6o+ZNW+/lIWhKAuJYtam/aUKNMTFoVlQl+q5qqNaZNBYH2b0hpISY4jF5dsru9RzgO0SH98qta6QcWjVPbVHhVNCKojy/SPC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keq6pXhE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keq6pXhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456D31F000FF;
	Fri, 25 Sep 2026 18:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790360870;
	bh=so3bX1sn4WlAOpsyKf2/r+MjXiOphWjfunkNGodqurE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=keq6pXhEX7m00lZ2wAzBJ79ph5v/do8jOgTrTEty66ykKWOzRW9hJubH3Ci9LDh8Z
	 o15o173UNqX8JrFZzUgT6vuurmKqCZ+1ZTXbzDnl9j97K9iIWamrteOklvZgpdQc/V
	 CY8oZExmN/c/Y4YMIZqt1H9SAKLvffXW1LzgQn3NaO2X62v0EzZ2n1wfMU1gDrJVEM
	 vJiDq3KCpPeq53O3NvdArg5rIIUiBbsofTEt5RkbiD1J7txUjru7x5ElNemLjnCMQk
	 RE7P3wx8KCuRhWNRVimOsmsJ4kriqUM55YXr6I9EpXD+2ANW3GyB5oFTppJ9Do6vII
	 F0L+lQOUNFnTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Add TAINT_DRIVER_OVERRIDE for usage of driver_override
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260925182041.1025371-2-u.kleine-koenig@baylibre.com>
References: <20260925182041.1025371-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 18:27:49 +0000
Message-Id: <20260925182750.456D31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] bus: undeclared variable 'drv' breaks build in driver_override_stor=
e()
- [Low] docs: off-by-one error in tainted-kernels.rst loop bound
--

commit 2d672f63b60203b8c528977d9c5848655d98a583
Author: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

    Add TAINT_DRIVER_OVERRIDE for usage of driver_override
   =20
    Commit fcbfaffee51a ("driver core: add TAINT_FORCED_BIND for when
    userspace manually messes with devices and drivers") introduced a taint
    for usage of bind/unbind sysfs files that manually trigger driver probe
    and remove respectively.

> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentatio=
n/admin-guide/tainted-kernels.rst
> index abbf5e3dd7495..75750a9533e98 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -74,7 +74,7 @@ a particular type of taint. It's best to leave that to =
the aforementioned
>  script, but if you need something quick you can use this shell command t=
o check
>  which bits are set::
> =20
> -	$ for i in $(seq 20); do echo $(($i-1)) $(($(cat /proc/sys/kernel/taint=
ed)>>($i-1)&1));done
> +	$ for i in $(seq 21); do echo $(($i-1)) $(($(cat /proc/sys/kernel/taint=
ed)>>($i-1)&1));done

[Severity: Low]
Will this script snippet fail to report the newly added bit 21?=20

The loop bound `seq 21` generates numbers 1 through 21, which maps to indic=
es
0 through 20 via `$i-1`. This appears to miss the new TAINT_DRIVER_OVERRIDE
bit.

[ ... ]

> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index c51ad96d4de4b..6e91210aab452 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -513,6 +513,7 @@ static ssize_t driver_override_store(struct device *d=
ev,
>  {
>  	int ret;
> =20
> +	add_taint_module(drv->owner, TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);

[Severity: Low]
Are we referencing an undeclared variable `drv` here?=20

The signature of driver_override_store() only takes `dev`, `attr`, `buf`,
and `count`, so this causes a compilation failure when building bus.c.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925182041.1025=
371-2-u.kleine-koenig@baylibre.com?part=3D1
