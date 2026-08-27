Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91712D7D47
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855817; cv=none; b=Ns4snYK1S1NE/nz3Y9/0W28dgED5QK/Tcf5euc8iONus+k0rflRP2Fd8oCtLcDWhCYCnfCuhNWyN2iCi2hSkpVSAHVgSI8xxD1iOBMmt2Sg+D+8VHAFHdOQby67zg156M4B7bVPR4+WSR/v8uB5jKRj4UjMp2kC0D5Mt1P+9HcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855817; c=relaxed/simple;
	bh=Iy8xrmf1SWQFo2w0jaLUVe43ClEa/SfnzDLOGmtq+jQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jgLt7pcYsSI1phUrBgSD9A/OQPbUFHZIxgR/4pBdN/qdRnC9SD1TB8Xpl/SyLC4zSK/4xYE9WC7lLYq5jQlinO2CfG4M3PWzycJD9P9W1qwGJ0rcki2hWgPUA7WPHtpnt33tl6sxEc0EwDsxGNXgErQq8ZpP05r1deaAg8YgvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWnSyATA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWnSyATA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE191F000E9;
	Thu, 27 Aug 2026 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787855815;
	bh=EHCzwAo+5DVA6fK+mycltX86tNdg36OxZJHBphUT4KY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GWnSyATAPy26+nROpHs6MTbjtCHHzrNCXsIacUovFUxnRaFKDSzVbRFEvAuyCR10o
	 kLdpM0x6BBwwAqxF8vDpGTJYqXjDLEuXmmn7X0Et94vHUcI2OzxFvLgaD8j398TpFs
	 O0xo23SF8Vss3jGPYlSdehXZHar+p3PG2xns+JXnWnPAmfZGXS1ozLvl5LVXjWErke
	 6BNh/1SqL2wwJoilUYrk7bXeY3DWmfbws723bPLcStcXow7mX3fE6kbSoSym4mCgSS
	 8Og4JJ+VG0Y/nBKv5VGgv8Ql/w0IMKAEomZPwoJ8w1UBqABH+zdtKy9XRUQFbpimvb
	 X+/oQMaVWgW6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] rv/reactors: use LD_WAIT_SPIN as the reactor
 lockdep wait type
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <7bfe97bd497a2641de36b35e17f69e6f3f291c2a.1787854397.git.wen.yang@linux.dev>
References: <cover.1787854397.git.wen.yang@linux.dev>
 <7bfe97bd497a2641de36b35e17f69e6f3f291c2a.1787854397.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:36:55 +0000
Message-Id: <20260827183655.6EE191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The documentation for reactor locking rules was added to the wrong =
file (`monitor_synthesis.rst` instead of `runtime-verification.rst`), causi=
ng an inconsistency between the commit message, source code comments, and t=
he actual documentation.
--

commit 26073218a7c3b83225869704d414a262b5e15e47
Author: Wen Yang <wen.yang@linux.dev>

rv/reactors: use LD_WAIT_SPIN as the reactor lockdep wait type

This commit changes the lockdep wait type override in rv_react() from
LD_WAIT_FREE to LD_WAIT_SPIN to prevent spurious "Invalid wait context"
warnings. It also adds documentation explaining the reactor locking rules.

> diff --git a/Documentation/trace/rv/monitor_synthesis.rst b/Documentation=
/trace/rv/monitor_synthesis.rst
> index 2c1b5a0ae1545..aab4b0342d5f5 100644
> --- a/Documentation/trace/rv/monitor_synthesis.rst
> +++ b/Documentation/trace/rv/monitor_synthesis.rst
> @@ -365,6 +365,26 @@ but higher overhead. The timer wheel (``HA_TIMER_WHE=
EL``) is a good alternative
>  for monitors with several instances (e.g. per-task) that achieves lower
>  overhead with increased latency, yet without compromising precision.
> =20
> +Reactors
> +--------
> +
> +A reactor is a callback triggered by a monitor when a violation is
> +detected. Reactors are registered via ``/sys/kernel/tracing/rv/reactors/=
``
> +and enabled per monitor.
> +
> +Reactor Locking Rules
> +++++++++++++++++++++

[ ... ]

> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
> index 2f5fc8d18dea4..afc97d0971091 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -465,7 +465,11 @@ int init_rv_reactors(struct dentry *root_dir)
> =20
>  void rv_react(struct rv_monitor *monitor, const char *msg, ...)
>  {
> -	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
> +	/*
> +	 * Use LD_WAIT_SPIN uniformly for deterministic lockdep checking.
> +	 * See Documentation/trace/rv/runtime-verification.rst.
> +	 */

[Severity: Low]
Is the documentation for reactor locking rules added to the wrong file?

The comment added here in rv_react() points to
Documentation/trace/rv/runtime-verification.rst for the explanation of the
LD_WAIT_SPIN override. However, the documentation was actually added to
Documentation/trace/rv/monitor_synthesis.rst.

Could the comment or the file location be updated so readers following the
code comment will look in the correct documentation file?

> +	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_SPIN);
>  	va_list args;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787854397.gi=
t.wen.yang@linux.dev?part=3D1
