Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900105;
	b=kwX9irZgGmwdBxTaQGIqHuIVFpp3AXUlJzNgx8RBOTC6LwJyOrp58N7fhG/BQuLZDRfz
	 HDEGs6OIYfKYvbZfiGpRF79l919eCk/RszBvuv/NLVQxKPJjh6ZBJl/xUQAcCFMt4iRR1
	 rl/SIo3z6r38J3gwQeKi+ELnpBfjmFU8kUm/u8Ct7iDj+VNIvORVJgAIzeJOFp0L5PT5h
	 SCkxsA0avMrmZya+gysmhGXv/bNUVQ1Gv2fHUUKPRgJJJc8kVgyhaIyNOcH7exuHxU+nT
	 7YcVmUalD7XtJb9jQ97SVDd5SbPbx60B9oT8es9uBj8o8PM0N3CxriYUiw/0yQSlN5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900105;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ja0MYkvtxGb4Zi0Zt1eCErsX8r6Y6eFkFPXNqtCQwdc=;
	b=s2yRDUC83Jes1CBSFUm6ikdhvci1lEmkqGAyJ3kptT3p8IpMEeoRePqEl7Y04hTw3kIL
	 JTJDJDfw7d9whbDu7iJHAGEnX9+dii00NpmP6PsIF/9+T+3ofrml4SaaezbX4aXIyrjma
	 Mmh0xy21dAzvbCPOrKIC6Kko2vRxYbgdBb+lmdpTLT6zzjveSRmrZedNxkAH5q8tFwP6J
	 KithV+zG3/IekS/cbuHPIgTKH5BqMoJmif37pHR3RULueJg3fKxjZGZPhk6n5IYxOm+Ol
	 BXSw3qAtiXTHN7o8T2sdyYj/FXKFKuAckz1VUoQjsOUjPJnI0SphpyYpRQiyTuVsXMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yuitw+wu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C5E606A31B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yuitw+wu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D409E1F00919;
	Thu,  5 Nov 2026 17:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793900105;
	bh=ja0MYkvtxGb4Zi0Zt1eCErsX8r6Y6eFkFPXNqtCQwdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yuitw+wudtHzLlHRr8H/3FAXb3Nip2mBx7IJpo8mPvKL6h8bmkBZXvAl+7oHGQKI/
	 90fsizRWQtRN97/a7pOB6o2/6U6vCTdHm1sN3Ga9lnoIUqaJ450RNWSFwquDvYYHBo
	 TwvKWSZptWLbbqQAzF5GMqdGwP87ifMQEF2Hsvrd6X6J5ntMNaRnxY/LOSDsDlJcPC
	 JRuK98Va30o/YErmOCg3eGMiRIfvfwgaEi6TcamMCdCqzyjWqfWtoMSkXQGJzU51Mj
	 o3aRHzGekC/V57yqZa4jTdyK6YKHg6xoLVN06ys6TVH12/GrZ+ftz3KMFyb4jjL69a
	 pmQxQ/g2bV1yQ==
Message-ID: <sashiko-outbox-199637@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 08/14] i2c: uapi: add I2C_XFER_V2 ioctl -
 detailed fault reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Guzman" <Dmitry.Guzman@mobileye.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261105-i2c-fault-reporting-v3-8-515ad74ac4c9@mobileye.com>
References: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
 <20261105-i2c-fault-reporting-v3-8-515ad74ac4c9@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:35:04 +0000
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
- [Low] i2c: uapi: commit message refers to I2C_XFER_V2 instead of I2C_RDWR=
_V2
--

commit 469565334f01910f1574884cc7c0897afa2334bd
Author: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

i2c: uapi: add I2C_XFER_V2 ioctl - detailed fault reporting

This commit adds the I2C_RDWR_V2 ioctl command and struct
i2c_rdwr_v2_ioctl_data to include/uapi/linux/i2c-dev.h to support
multi-message I2C transfers with detailed fault reporting.

>     i2c: uapi: add I2C_XFER_V2 ioctl - detailed fault reporting
>    =20
>     For user-space access to I2C multi-message transfer with detailed
>     reporting functionality, add I2C_XFER_V2 ioctl and corresponding
>     struct i2c_rdwr_v2_ioctl_data.
>    =20
>     The structure consists of struct i2c_rdwr_ioctl_data that used in the
>     same way as in I2C_XFER, and struct i2c_transfer_report that the
>     detailed transfer report is put in.
>    =20
>     Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

[Severity: Low]
This isn't a bug, but the commit subject and message refer to I2C_XFER_V2
and I2C_XFER, whereas include/uapi/linux/i2c-dev.h defines I2C_RDWR_V2
alongside the existing I2C_RDWR ioctl:

include/uapi/linux/i2c-dev.h:
#define I2C_RDWR	0x0707	/* Combined R/W transfer (one STOP only) */
#define I2C_RDWR_V2	0x0709  /* I2C_RDWR with detailed fault reporting */

Should the commit subject and message be updated to reference I2C_RDWR_V2
and I2C_RDWR instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-i2c-fault-=
reporting-v3-0-515ad74ac4c9@mobileye.com?part=3D8
