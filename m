Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A4725F7A9
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678592; cv=none; b=Fk0fL5O7K0PpdQJ5ulj9aLomjP6T8ZpkBnxeVCZLATicp3cQla704Dt5dC9b1TqwR8H1xByf8+aphb7mKnvxHW7arlAMGcGnUkzBg6UFKs/MS6bWpWMA8X+PCQflWQZJTIj0r+OHR6Bb3o8mewetMz6bayx7kb43abH91JfsGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678592; c=relaxed/simple;
	bh=IjWCFFJ8d5prVvuohkK6B/sQJwGGIMm8kSomcID2yqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXgkc6jJFSLs+/3fFIvFiHJnvaHJy7dTW1Xp7FwBZEv1eHMYBLT7Jq3wIwRAHvI1tYCqB0BUMRq96oUs5c0ohyge856FVnWTXwVyE1Smc1oFgY2VSe21xMkG84hMoCz0W/FwjgfqMknKA3luGRVuuvaVa8ElrcBqRf0QFnYx46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cKvxPK4F; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cKvxPK4F"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806bf03573so3850405e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 01:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769678589; x=1770283389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IjWCFFJ8d5prVvuohkK6B/sQJwGGIMm8kSomcID2yqw=;
        b=cKvxPK4FDF8GKRCcvzgSA6qomlDhEgTNwp/e0OQQwTzwAkyp/JQ2W51GWAnH1tYhpO
         MVNcJtCB8arPeYhWREK1NNGngG2rSFl3eFrzTOc4hCCvybuVMjQYj7gsR3ChPBDGQOjo
         AN12Tx0QoD4Ut37+9kYosMHAVjKMsfso6OEbbxFD4fa1xMELzw1hwAEMsOxCIsnlY5Fd
         tkihPH4mFcjhoQcPAF/F63EZFSLiw1XSqYUIgkvjAC50lO0T2V3sNSUlu3pBmudXI0dI
         hBLD37ommN/NmnJVwHFVmyy8IORh16frKSseIP13ugRGTe0QDn02xL8U+cTVgoW9+qfx
         RCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769678589; x=1770283389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjWCFFJ8d5prVvuohkK6B/sQJwGGIMm8kSomcID2yqw=;
        b=BdnIcthNIeSwTv5hd+BQ2AFHAbpHTID4DwO60Sxp/Nb8vX5igc1zgEW0iIGmeyoG8L
         CjeP2h5Ys44a4TN3YEtg8ihkRnDlCvFawBBlCdwcgI4MA5IBzonL5eIidxnXzWtxrUG2
         q+ANPZiKuMhm/BN2wUCvsepgqN6qKcRRuW98I1Dc860JE0OOhgldttfZRQOQ3u8nvg4j
         lx8mrguG472aid4vEvl8ong1eE0ZG0+FZwhk8qYRNiwPJEuv+mZpbdnG/j6nqfyFpngk
         6NuTKWIfOlLbBbY5g/0z3zgta8YEu+s5Qm3KZRiLpGccTKgmBTqk5wpKr1/DCKL28hh6
         ixog==
X-Forwarded-Encrypted: i=1; AJvYcCWhXF+ZEhDFnA7axTYwexzCK8nOy8tdtscci4tYCJrE48K5a+IqkjGnrXBbaLjb5vmKT9JKtVmKIrYdYI/5la9LQbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5raUjQD1Wqf6X7/7n3nek2Gm1EtWXHZLHxBDnPTZDeNCdtDNX
	nRLPFtP7DoUnYyWHznYgDxk/4iaxWvFsh8xSDpLGjFwdipXEw9WV95mOw/sYo/8buD4=
X-Gm-Gg: AZuq6aJJjBRv4bwOiJrf7T6mBPdyRbdsuDyN1nokB6NfGczO3dm3jqcgc4UrBhIAxCq
	E+SLEFJD6JqSAzHT3L4scH8FqtEsysdX/sImK/jjBcDcM0D0lTNXCMI3xrFh2z8KkUvTOQW0Nbh
	iQHYVIxydHAWupFZ3nq4tT65YRFOMbY0PO2HuCfngI1hGGo9TnjiP8nrjGf/xDrEQ4t1P00dmN5
	oHZRKmwG2Euhrq79sdMhxpXLA5J8qnI9vfd9moz9pjzG/Etl2ADjzdsaUmcYgjmF59bVHqQztJD
	ui0YscfDPL0dmh173rE1Ti3uSiZ2DFlzJF/XIA2dJ2Ma/uPes9Yg14Tjduy2sO9npjN0jlXRzo9
	vEJjz4qhwRAO3z//+ESzBaEzlO01LsE+1JKCSNsvCk9ds7/Fnf9+QON0RTjnfuAhEt+nYjRSzvO
	brz1WgkUwBitTXCabB0WQ+7wKvLJv67UU=
X-Received: by 2002:a05:600c:1d16:b0:47a:8088:439c with SMTP id 5b1f17b1804b1-48069c9ec08mr116607785e9.35.1769678589240;
        Thu, 29 Jan 2026 01:23:09 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd77b8sm118657505e9.3.2026.01.29.01.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 01:23:08 -0800 (PST)
Date: Thu, 29 Jan 2026 10:23:07 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, inwardvessel@gmail.com, 
	shakeel.butt@linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next] cgroup: increase maximum subsystem count from 16
 to 32
Message-ID: <asryf3kk6c337l33faqpeznk7d4a3rxblzmqrawxffq7sfbaf7@5yfzzdroltjq>
References: <20260129063133.209874-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t6fk4azqrf6lix7c"
Content-Disposition: inline
In-Reply-To: <20260129063133.209874-1-chenridong@huaweicloud.com>


--t6fk4azqrf6lix7c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next] cgroup: increase maximum subsystem count from 16
 to 32
MIME-Version: 1.0

On Thu, Jan 29, 2026 at 06:31:33AM +0000, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> From: Chen Ridong <chenridong@huawei.com>
>=20
> The current cgroup subsystem limit of 16 is insufficient, as the number of
> subsystems has already reached this maximum.

Indeed. But some of them are legacy (and some novel). Do you really need
one kernel image with every subsys config enabled?

> Attempting to add new subsystems beyond this limit results in boot
> failures.

That sounds like BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16) doesn't trigger
during build for you. Is the macro broken?

> This patch increases the maximum number of supported cgroup subsystems fr=
om
> 16 to 32, providing adequate headroom for future subsystem additions.

It may be needed one day but I'd suggest binding this change with
introduction of actual new controller.


(As we have some CONFIG_*_V1 options that default to N, I'm thinking
about switching config's default to N as well (like:
CONFIG_CGROUP_CPUACCT CONFIG_CGROUP_DEVICE CONFIG_CGROUP_FREEZER
CONFIG_CGROUP_DEBGU), arch/x86/configs/x86_64_defconfig is not exactly
pinnacle of freshness :-/)


Thanks,
Michal

--t6fk4azqrf6lix7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaXsm2xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgrCwEA64lWaPMJqVPfz3lW0yM8
oLTj7UBAylF/bNzMNZhWzNYA/0gnAST31yIA8yujaEqUnPi4bptZCIayMmkgaupI
BPcL
=GgdH
-----END PGP SIGNATURE-----

--t6fk4azqrf6lix7c--
