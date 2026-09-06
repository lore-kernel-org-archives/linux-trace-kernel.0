Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DABB3BE168
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715150; cv=none; b=Y2CIpYWsXqeZJ2p2C6B+eG/KG6a2qih91Gkemkz6afsFV8noby+ngMJk5Hyzos8KtT1+k9+vZX7B0zs/jVLy8LT732w1+mj6qp2XTb1XAsWodipBXrAcBLRWDIe19gyOCwMTYpgo7tKZ2eCF5HX8ayMZvPvX+7hZOHeRCdum3+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715150; c=relaxed/simple;
	bh=CGGU/1AGVB02gv6+q4F0ZFtbtmjUBFtPBlpLH9xDexM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ietATMDz333y4eqD+pGI6Ui4cuI5wEDaQbMNpJdatvQx0KSOq/qmJIKsGjD1JmVGtvtLCr1VYMmkQsuTQy4Lj6aPxGK4nSvDjZSuqOH0fRAKcd4jjWM92HNwl+jK7F1sDa/nfeh3F/oaNEPA69NHA45QCHSL76N9erF4xGnM9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gICmulMj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gICmulMj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323171F00A3A;
	Sun,  6 Sep 2026 17:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788715149;
	bh=Fw4zJUBMgXvstg53KXmym1oiNX9ijIGg5HN8/JrJGT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gICmulMjIITlSELiOHgQWiXG8cSDprs9DwLglC9Q12CTyeUcA6kvKntcoV3fPUiUe
	 7OQNFbukH8ullWNt1X/i5Gm+QuZFnArgTSXHfutliHnFJtaOZF2s4wNky6zP+fOuxv
	 MOZQzObKQ0xqvJKowTVSl9F+syzj/ToURGocpm7p666v03fjMFcrtmaySonH+/LR/2
	 toXAHqVMYap2Eix+D499ZhqJspWzfsBwFD8/LYsnGIgi7fxEc3J2Eu4U2mgmhT46jz
	 mQWXf3EXcBsIbVuDJ6G9YFL/h78Him67EQHqa/O3DFBRb3mMw5/G6RWMvyKanUEEbx
	 sDg7X7w2o6BCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/5] selftests/verification: Test loadable
 module-based reactor
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <8337c115db6ca718a0d442ad85f0d2d4eaa2422b.1788705281.git.wen.yang@linux.dev>
References: <cover.1788705281.git.wen.yang@linux.dev>
 <8337c115db6ca718a0d442ad85f0d2d4eaa2422b.1788705281.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 17:19:08 +0000
Message-Id: <20260906171909.323171F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Typo in the test cleanup trap prevents the script from properly =
detaching the reactor and unloading the module on test failure.
--

commit fcfb27a313bc6b0b71755c80b19e1e2cbf231cac
Author: Wen Yang <wen.yang@linux.dev>

selftests/verification: Test loadable module-based reactor

Add a selftest module that register an RV reactor and a test that
exercises the module pinning: rmmod must fail while a monitor is
attached to the reactor and succeed after it is detached. A trap
unloads the module on failure so it does not break the next insmod.

> diff --git a/tools/testing/selftests/verification/test.d/rv_reactor_loada=
ble.tc b/tools/testing/selftests/verification/test.d/rv_reactor_loadable.tc
> new file mode 100644
> index 0000000000000..ff16916615215
> --- /dev/null
> +++ b/tools/testing/selftests/verification/test.d/rv_reactor_loadable.tc
> @@ -0,0 +1,46 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# description: Test a loadable module-based reactor
> +# requires: available_reactors insmod:program rmmod:program
> +
> +MODULE_KO=3D"$FTRACETEST_ROOT/test_modules/rv_test_reactor.ko"
> +[ -f "$MODULE_KO" ] || exit_unsupported
> +[ -f /proc/modules ] || exit_unsupported
> +monitor=3D$(ls monitors | head -n 1)
> +[ -n "$monitor" ] || exit_unsupported
> +
> +cleanup() {
> +	if grep -q '^test_reactors$' available_reactors; then

[Severity: Medium]
Is there a typo in this grep pattern? Should it be test_reactor instead of
test_reactors?

If the test fails and triggers the cleanup trap, this condition will evalua=
te to
false, bypassing the cleanup logic. This leaves the test module loaded and =
the
reactor attached, which pollutes the test environment for subsequent selfte=
sts.

> +		echo nop > "monitors/$monitor/reactors" || true
> +		rmmod rv_test_reactor || true
> +	fi
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788705281.gi=
t.wen.yang@linux.dev?part=3D5
