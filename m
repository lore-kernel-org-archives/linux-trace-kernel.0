Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260991;
	b=3cHO0jree3CWb0yWtd7RaxFfSPIPb1DpVz8nRl2LZN0whRKxRCH41mOLlYGwJ5c7rGky
	 VJxUXR9qk0EIVlHtxqryJ0EWrs8r2ndrv3KAccL7JsJuJ01xH3OMHAc5bYyEvb+/ALMGV
	 g7ZF2Vva510nSFmZyPQNqPhTmpJJe99u1V3VwMltQDkc0oalnsBUz28/xgN5/l14fAd95
	 h68m8Rk70gu1ctOI+i8oVWQ7qlrSPPp1o10/nDnI0nu9z2mPvWPs1GbDe9HiXf/hH2Ihr
	 wApoJTRa9zBtitjl/wokMoUA5kB5j6tEFExMCHAcnkEpl9r4qbwsYvG2lB/jtJAdoSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260991;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UmPLmwL8shKRk7SyJKO6MR3jMwJl4b3eUpkhcq0T2gg=;
	b=J50Fo7EhoiwQrxecIPlrIo9WzsACgMHQQ0ev1TIDGaKS0gOHOf/O6BTlbx5ipQy18YYw
	 zELPKxCzl7EcHCiRiBqX65OVJpls8Z+O9pEDAYUxVcJhiNi6DSPDBuB4cQT7NwKY+6gJr
	 lC7F3Gsu6STRPjQ0PWU07c5ZRe6lqp72OaHePpCn0dYCk8u0eFkBdAnq06AD44dCVkVgx
	 NFNOKeOtV5Tsk7teBt5oCHR1d9XumvYRRf2vuzidTWYGklYMwIbQ/PIFlwHgf4ByKCihM
	 B9aZYPShhSZ3BICjr0JAhhURwRUSCH/DnGxJqa1xDEyRD/xHNZCVJlaSjNBf8ehwFYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDWVj29E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DCA606A320
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDWVj29E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F7F1F000C4;
	Sat, 21 Nov 2026 11:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795260990;
	bh=UmPLmwL8shKRk7SyJKO6MR3jMwJl4b3eUpkhcq0T2gg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dDWVj29Ee63xXMxYqbqtB4dmnpPVfWP2bnqOnvCY5YXqfx8LjH1fM/Pg32To/lYvU
	 74r8pbKy3LCPr95EWLLlgwt+kEIT33HL9V2kP6htBnlel0K8GH8hHPyFqEeqKuHXu8
	 eyGHcgr+kq06eUILS/LvrZfyD6WBoI0HOSO4x0Ld1OiXQS2ulyyafoAjiuLufIIH/x
	 l/j+jk0SbphdTBcZjxhJrtLUfKy9Tzd2DJHZc69PBA8ZbN/oJdkaE72T2urjUQK6KM
	 vAYTSnMD3QiL75t0gPxuZaiPml9+sMI8DoPW39heq1pmaPUtxG8IwRXj4TPW6SD8mH
	 SvNb4BlgRP0+g==
Message-ID: <sashiko-outbox-226981@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] verification/rvgen: Validate the monitor type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chaosheng Qu" <chaosheng.qu.linux@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <cf05914335850f6835ae79b34d6b4ad891128948.1795252297.git.chaosheng.qu.linux@gmail.com>
References: <cover.1795252297.git.chaosheng.qu.linux@gmail.com>
 <cf05914335850f6835ae79b34d6b4ad891128948.1795252297.git.chaosheng.qu.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 11:36:30 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] verification/rvgen: missing Fixes: trailer for monitor_type
  validation
--

commit 3e56be70e8ab6364389874866af8ed0012adb35b
Author: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

> verification/rvgen: Validate the monitor type
>
> The monitor type is pasted into the generated monitor as RV_MON_<TYPE>.
> Nothing checks it, so a typo yields a monitor that cannot build and the
> tool still exits 0:
>
>     $ rvgen monitor -c da -s test_da.dot -t bogus_type -n bm
>     $ grep RV_MON_TYPE bm/bm.c
>     #define RV_MON_TYPE RV_MON_BOGUS_TYPE
>
> include/linux/rv.h defines only RV_MON_GLOBAL, RV_MON_PER_CPU,
> RV_MON_PER_TASK and RV_MON_PER_OBJ, so that macro never resolves.
>
> The accepted set is already in Monitor.monitor_types, which the help text
> prints.  Pass it to argparse as choices.
>
> Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

[Severity: Low]
Monitor type validation in dot2k.__init__() was removed when
monitor_types moved to the Monitor base class in cce86e03a27f
("verification/rvgen: Restructure the classes to prepare for LTL
inclusion").  Should this include:

  Fixes: cce86e03a27f ("verification/rvgen: Restructure the classes to prep=
are for LTL inclusion")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795252297.gi=
t.chaosheng.qu.linux@gmail.com?part=3D1
