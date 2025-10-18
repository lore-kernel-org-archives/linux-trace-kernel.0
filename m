Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB787E0E8
	for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Oct 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797843; cv=none; b=gCvME7Nnn/CHcIjItIZcI1atTcF9Setpdqhyx5wy6zFYnohD23m3ZYppoGzSKdOWhBI8BuZi5VAsGXxcyI+MM39Sb/24JhYuevbgSY5FWgHdSXjYhv4AUfZrN9E782gPQ9fYVqT2RWZR4vQFblET98FulP/bjAIEQh3fi13O+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797843; c=relaxed/simple;
	bh=H5AzUI1YR9TrA+ShwSblAD+3OTi6tR9slfhzioJEg/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHYkc6OoUytOpv+EQhtF/4FZqkUBc7YIl7+OWgXPaG4/wccW3tprsMT32tSiQJwmemM7RB2/5mO3oa/EICPIxF/vs2hxwejBmqNUoD5U5e6b9t73PHZnmz8RVMSmuC3n22Q4kkzVp8n/ikdaL1oSfwAY/ySS0SFTFrOi+CnqQhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gi+z+SvN; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi+z+SvN"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33292adb180so2878735a91.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 18 Oct 2025 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760797841; x=1761402641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H5AzUI1YR9TrA+ShwSblAD+3OTi6tR9slfhzioJEg/c=;
        b=Gi+z+SvNsHkZO9AAIyWP+0DeGfslFOUz69IO0fYboTt/sdoCGN3HRsHrQEFQpekhiu
         bswXiZb+xoDAzrfqIBq0I2WKq6gk1ejJ1vcRzEKvmGRK9T9gr40h+O7AeSu0UL0qP1ck
         6GxeYIito3xbM9qsmE3aRAiGqfCbcPYycV9YhbyhdP+DyxlnIiiI8J8o/EMps1ghjKTv
         cRTJdH6BCLP1gLWYZsH4x0uT3Ssyz7qKzCfd5ahUwgLuBf0uwOsm98NOmfGBjTqlecJT
         SdokDU6gbkHid5y/PeLBBomoYu+kkg0JhPhDU2YKB/gKbGOczcFWUP/Pw/hjDA6aSyND
         JaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760797841; x=1761402641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5AzUI1YR9TrA+ShwSblAD+3OTi6tR9slfhzioJEg/c=;
        b=PWVBaXlkgn/8k5CKL+jSKTVew3DSIQsBH8+RSvoIXq8LZZciUfA3qK6KHMuwIxvAr6
         iWCL4P18uCwuFEKitw+wHN882Zs9UtdU7+K4yPJG4Wvyk5kkifVoAnlgDEIcBDfGM+a1
         LmUdRyUWoOilVwF6hvtY+aurYHOidkmhQXeIYncAEF7DWJLwhncujNe9aVdq8KuwSBUA
         xy1i0yVL8JJdKpHZSmlrE2AwRiPzl+uGNqlFEdT0IIW472GfAzHMZ7XeZgHV8gBaS9oE
         HcHd4eDK8Zd0+fXd7urWjTipW6AcS43zkiIU0hrSXDnGI8NKfwMT1OU4NXrE4lKcVRPM
         sagQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgVTSSdmg8vGpDqZsWeTeBpyunry+lMw5aP67lblGj6XTGhnbV3eE9m3Ci4zY8sR/f6p0oDIMFyEtbihr4QJ2uLQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoaZ/GdjPvE0Kk0irAnAQyrnPrW6wakNrwYd+3PJ+y5u3pjOZ3
	GjA6lYUfpBlvVkNvb12VKOrMpL8zhMLTYttnn/Cq2/uI6LteD4ZOUJCG
X-Gm-Gg: ASbGncsyciM5GT5f8QWixBMmhb4R7gpVodt+pJdONC+e73bC4gd9/yiSxX3RB2DbFnT
	3UYRBZJQE/Q54YsQO1YO3uVdcxELihvlxeI9R3/wUBoBJfIOMlO+HDZ4/Sl0le2SlsCC2huLqTx
	JYJywQtwFUQezmtmWRJrODqjykceNpPezzdCaD3Vcb4VEUr/CN7tnQuADfU+CwQ3U+JwRiqhGVB
	aWYDyxupsS3+MilzW9VOqdcmBEcv2xuNbCsZpL39Oo1zsC79Nz2neZOQQKPJtQHyJWnoRiAQNnU
	0Egl0v5Chm27UBk5RUT7m+dTrRhnMHB1kdUOuKHK9zIrnzXI2QLou+QoLYhIsUmXWWQYpFBJHp5
	0EFc5+X3zjDfnH9wBM8mLqa7qFDNRiXHWdNuNjqwFI52L9rwWK21TXOnNr5T0IhPjjGgTbprQLg
	Ff3UiYkW66F2eg7cUyR37un+QU
X-Google-Smtp-Source: AGHT+IHWngUQc7B5DhoG9VaMeEWADlJVoOxl/VKkyFHP2uKToZpaKxsuBioQGNTpHSbiFcVbfcshrA==
X-Received: by 2002:a17:90b:3d87:b0:33b:b020:595e with SMTP id 98e67ed59e1d1-33bcf8f78cfmr9188242a91.25.1760797841284;
        Sat, 18 Oct 2025 07:30:41 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bae2a4e03sm4525492a91.4.2025.10.18.07.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:30:40 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 560444241822; Sat, 18 Oct 2025 21:30:37 +0700 (WIB)
Date: Sat, 18 Oct 2025 21:30:37 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Gopi Krishna Menon <krishnagopi487@gmail.com>
Subject: Re: [PATCH] Documentation/rtla: rename common_xxx.rst files to
 common_xxx.txt
Message-ID: <aPOkjdKXDKeIIsCE@archie.me>
References: <20251013092719.30780-2-bagasdotme@gmail.com>
 <87zf9pz33e.fsf@trenco.lwn.net>
 <aPMqTSbPucoqNhA1@archie.me>
 <87v7kcz3yl.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ybs29haJIQVP26Hi"
Content-Disposition: inline
In-Reply-To: <87v7kcz3yl.fsf@trenco.lwn.net>


--ybs29haJIQVP26Hi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 08:20:34AM -0600, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>=20
> > Shouldn't this more appropriate as a fix for current cycle (6.18)? I see
> > the warnings on Linus's tree, though.
>=20
> As a general rule, I don't see warning fixes as being important enough
> to send outside of the merge window; the next cycle isn't that far away.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--ybs29haJIQVP26Hi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPOkhwAKCRD2uYlJVVFO
o3NPAQDfJXtSqbwM4/sAhpfkKAvqBkJII1d9MZNDlAgwoiq+qAEAnu2ndfw7w1wu
QyJdeJuxkPc2xpzvRc3YXL3d0wwuQAU=
=jsrl
-----END PGP SIGNATURE-----

--ybs29haJIQVP26Hi--
