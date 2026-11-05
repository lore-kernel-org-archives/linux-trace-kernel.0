Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901236;
	b=GCwfVlv8W/PWGj1eoww/1Q3daZLPuxeA47CtLG8DDvfxOZaSI9QzlkSLnOgzMvI1vTtM
	 wheb+tgNigGWLCl8qDaemmC6LNcpaHWAxTgpMBfs2Er9HVgOaCyLq+2a/3SSgXnHWThBb
	 MPVxOJwzlh53bgzjPnGncOcDx0p76mqd7tUwc+ODv2bgoEG/byjSidE2a+CJsTNy4d1zY
	 EalSsuJgn2JI3dhqT2CK6Ux9W9jnJVl3DlgxWIT6f7P4YtyXJ3GwT9TEEAPBrc9GW+wwd
	 JP27oXEob80BLMIXmaKCQG+s3hOiA9289rEspVHQZdvhs1z06eJyApbLXR3Ts/UuIBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901236;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uCqgLwRe4NdF1J33IQOi0+xc8QVoV1b82/pUq3G9j88=;
	b=HJKMdTtyAlLrODyK/7ncVy92GAYFJRvx+Hq44N4FMEOz5thwURL1jkXd1vusQrG607Tv
	 BBJEy8fe6JMXBbuHt1BxeMg7AUsP4RdNIdTGDJGWX3xnJm5NDWgdIkM0rm+d2opLOpA9l
	 qH+ysoNlqcJKLqPODMQMnz6kMsHCB25ebzvMLrq4IVxzmXSuIxhb9kASoNzwfjZ6e1CCo
	 AehBJhuqf1lNVQEUtuX3Hvgxy00+BjcUiNNH3sZMpRzUL96Pr52BzQq+BR1pK+5xE5fc0
	 pOFkm7fkQgzIMX2vB2IjumMxRTdMMilxaG53rYj9mAtL9dmlMJZZigHtRdZ/xKMnUGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MhGluoDx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFF9606A32C
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MhGluoDx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A221F00919;
	Thu,  5 Nov 2026 17:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793901236;
	bh=uCqgLwRe4NdF1J33IQOi0+xc8QVoV1b82/pUq3G9j88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MhGluoDxUuhtCbTdvifvroJcTH+18MxA4Y9EOPuyAVbJG11+KhgjfUWYiYuBnYztB
	 NP0LG3sD5nQQBaIvBV7x5H7dW6GfBVJ4BnVc980ZjaiINPEO3syxlm5xwOUod3hVe7
	 4n5PnoCKq4t6A3KzOXGTd0yFWH8C05L7UHQ7/6rwn2Ubtf4dMMPw6P1pnubDRQ0dTs
	 tB4KIUyic35CRVsGOav5t4UrseOK0ZDWW3xmGpcdBE8u+3J8qlnbKYggOiPSWqVurw
	 4M2Buq7xldiyhpEn4jFfbXXVTF+DAdlsEX6Ep3245zkqMm925lfj9e9f3KN+vNa0My
	 mb7L3+2NcP3lQ==
Message-ID: <sashiko-outbox-199668@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 11/14] i2c: nomadik: save I2C_CR register before
 resetting HW in IRQ handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Guzman" <Dmitry.Guzman@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261105-i2c-fault-reporting-v3-11-515ad74ac4c9@mobileye.com>
References: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
 <20261105-i2c-fault-reporting-v3-11-515ad74ac4c9@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:53:55 +0000
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
- [Low] i2c: nomadik: commit subject refers to I2C_CR register instead of I=
2C_SR
--

commit d218bb5af34fbc63fe8a8b9dff6e05c3496a8824
Author: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

i2c: nomadik: save I2C_CR register before resetting HW in IRQ handler

This commit adds an i2c_sr field to struct nmk_i2c_dev to save the
I2C_SR status register value in i2c_irq_handler() before calling
init_hw(), preserving the status for fault reporting in
nmk_i2c_xfer_one().

>     i2c: nomadik: save I2C_CR register before resetting HW in IRQ handler
>    =20
>     On some interrupts, such as Bus Error interrupt or Arbitration Lost
>     interrupt, the interrupt handler calls init_hw() to reset the I2C
>     controller. This clears I2C_SR register value that might be used for
>     fault reporting.
>    =20
>     Add i2c_sr field to nmk_i2c_dev structure, store there I2C_SR register
>     value before resetting the hardware, and use this value instead of
>     reading it directly in nmk_i2c_xfer_one() if it was read in IRQ handl=
er.
>    =20
>     Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

[Severity: Low]
This isn't a bug, but should the commit subject refer to the I2C_SR
register instead of I2C_CR? Both the commit message body and the changes
in drivers/i2c/busses/i2c-nomadik.c (in struct nmk_i2c_dev,
nmk_i2c_xfer_one(), and i2c_irq_handler()) save and inspect I2C_SR rather
than the I2C_CR control register.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-i2c-fault-=
reporting-v3-0-515ad74ac4c9@mobileye.com?part=3D11
