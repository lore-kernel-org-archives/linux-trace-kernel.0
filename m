Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F9369D54
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414621; cv=none; b=JgmdnjSvhJdNg6vVzcSs9ouN6HKEl0fSAoyjPAozDhqRo8CzVa5GG3iLftoForDxKc7EsZvkmU7vOegTxK9eMF9BmZk6Evk2S4YK0Kuk/PIJyRAleF4h88QLqBk/36ic4VAOc1CylWeLLbDgts7vNyQ2I6AKYZCjzarGKSJXlJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414621; c=relaxed/simple;
	bh=yS+LZJ57oq+KkVICiV7jRWunUHdNhnrRxQvxBF191s8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AGA3xIIUOcFinMuK/5mI50asJT0LttuzwWiplSt49Du0LxDQ6JIUDuDYNMW0ubYPw7nY80LwxeZ8VblFCYC16PTQR5/yx2tZp1MUh2noQFVu7WTtGLdeCh7akKPCnpgAOt6R+eQ5gK39X0BJRzp6Gg6FoZzZ/vJjXESC8ChrylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3aHOAJr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3aHOAJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347901F000E9;
	Thu,  3 Sep 2026 05:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788414620;
	bh=LP+W9DZsWNZCHFmRkl03/DAiBcK9IHrmNgDJya5MATU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l3aHOAJrIRlVLzNIkFierQPrBJWz6hGYAsA17TaiastrOwZ/aQPq1vhpPYl5gYwYn
	 J4riSLml2EWaynr4qH6lcX3gsH/QpKerjHgQgDaNuq8XekSDuvxXgRYk7bWZKxNahM
	 27I3UFkPB73zN8KvK6SfsObt4P5VAQTlixcV3+PHgO5fP38g96yXPD9AtewmRLplTv
	 zKnSva/wuG+lmP08mJ98EPGsP3ZAnDdFWeao/bW+wpEam7YeewzoB+7fQbVLML53Xx
	 xFJaye7vqaEdp+AVJcKlU+Ac8TJOQTo0mxkXGgfCcsf9HmgtPfmo2UPK1xj+l0oEO4
	 RV3qY8W9NNHBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/12] i2c: nomadik: change print level for fault
 messages to debug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Guzman" <Dmitry.Guzman@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260903-i2c-fault-reporting-v2-5-fedeb91792e6@mobileye.com>
References: <20260903-i2c-fault-reporting-v2-0-fedeb91792e6@mobileye.com>
 <20260903-i2c-fault-reporting-v2-5-fedeb91792e6@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 05:50:19 +0000
Message-Id: <20260903055020.347901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Improper downgrade of legitimate I2C timeout error to debug, mas=
king a severe delay bug
--

commit d09d3a7f57c0692be5183e8fc8dc35c1ad33aa93
Author: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

i2c: nomadik: change print level for fault messages to debug

i2c-nomadik driver prints error message on every faulted message. This
is not a good practice, because in I2C a fault not always is an error,
sometimes it is the expected result.

> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-no=
madik.c
> index a3cef4b66190a..9c7658148bd45 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -627,7 +627,7 @@ static int write_i2c(struct nmk_i2c_dev *priv, u16 fl=
ags)
> =20
>  	if (!xfer_done) {
>  		/* Controller timed out */
> -		dev_err(&priv->adev->dev, "write to slave 0x%x timed out\n",
> +		dev_dbg(&priv->adev->dev, "write to slave 0x%x timed out\n",

[Severity: Medium]
Does this change mask a severe delay bug?

If i2cdetect is printing this timeout message for every probed address as
noted in the commit message, doesn't it mean nmk_i2c_wait_xfer_done()
called by write_i2c() is genuinely exhausting its waitqueue timeout for
each missing device?

When i2cdetect probes empty addresses, the controller appears to be nacking
the transfer but failing to fire the expected error interrupt. This would
result in i2cdetect stalling for the full timeout duration on every missing
address (e.g., around a 24 seconds total delay for the bus scan).=20

Could this underlying driver or hardware flaw with missing interrupts be
fixed rather than suppressing the timeout warning?

>  			priv->cli.slave_adr);
>  		status =3D -ETIMEDOUT;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-i2c-fault-=
reporting-v2-0-fedeb91792e6@mobileye.com?part=3D5
