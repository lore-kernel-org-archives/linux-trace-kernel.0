Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29F024EF61
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186904; cv=none; b=iHaACzGpT8HvAkWuU0ldli6hMw2gzdhrycYCbxFxk3xHu4Ctthe4lKEz/sVUVI9nlbBeUzR2nJ7UvhWUAqZU2OrJ4inl/lqUZC086lXCKmK/MDYpCV7ZGjRef6xwSuXDTEteJ7+ZnFZE99vRNid/c+gUrZEAlcCO3urTev0noU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186904; c=relaxed/simple;
	bh=lUDN2FTPIBZksZjXeFJs8IYepzlRpej42fM20ZtJ10Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7vOJZtrka5nNUbc47yfeMjuxc56U4vdooOKuyproBo44cdUmzbZAgD8uIXOXlneyx5gKC6vumDm6wmARR32XD8knpotAA8RdzJ+hbkt6mrAKp72xpJSLUvY8l7p0gUqfYdZeZqYNV3O2S9rt5u1fs8fNM0VDwkb7HAwfsw3JYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R0f2Rv5R; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R0f2Rv5R"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bcfa6c57fso9211045e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741186901; x=1741791701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lUDN2FTPIBZksZjXeFJs8IYepzlRpej42fM20ZtJ10Y=;
        b=R0f2Rv5Rmqu57EmOcE2UXowXc/PksYag574O8qQ5gfVyF78UFrExUqw/nuaIm0+YiG
         Ic3am0KS3CuJ7FSKhNc8XVN4ec/vsjoTDVe2xQsonEtuAk7VTAUkjJXwjUZAOL3GByrv
         zHveXe9le0sarmSjh9yojKakozUsRyw2zDvNwSwFuOhBLgYylr1YOIYeeCPb3/XmDTdx
         j6WoryV1BcGHkRaBWpxnXrd1RjTZZuhmXMdvCFTbY6GFYke0Y034c8mOSAQJJEHEOEzV
         asvtiOB+tyMZb2Eh6XukDzL9zUv6GJ4RkWLHsL1ogSj3bxbTsnpGvrXDd++SIqYB/rw7
         wObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186901; x=1741791701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUDN2FTPIBZksZjXeFJs8IYepzlRpej42fM20ZtJ10Y=;
        b=EaJsfrRQJDgloK9O6QKxOaLofVDJIR7ySRA5BBgsSrlCOx1bx6wUqd8KLiRok/WOfJ
         uMNlJHglLMff9CjEMFoEfn7kexWSOtcRF3uRhg8N+easHzEmxs8tDmiXn9Jwf/2tzF/S
         tECtlCjC8lrsrV2GWjYo1p3wY4sg/8caPBy66yabtDhKX34Bg/WS5HnZRwJ+MLLcbnH5
         ctjACR2jhPP3OUQEruUFgvPVDEJ3rdaf4EST7atYoZUkJg/pOm+2FxNqPPS1AL2MEp++
         Evphu+aqGOzEHUPPyCOIbzW3awiN0sSasXDgfIDO8xvsUs3dFapk+N4rhRAM1s+AIs1a
         khAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVniGGNH3rBKZrnNtOdX2JZ2wiWc9fDTzntegm87tDdiF+bA4k2v2FZnGLX5UXXUoTgE2hB01X9Ww0jvLd6p52gmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsqxsv0kiYvyZOiUWlOptEo6dn6rpQwG6jTNQ0Zqd4KbZasfTI
	D/H9VZqTFdNpIRrk8EYfu8nBGKw2TuyCRUCku1YBW4Z0K6YOcswKa344Lz/F2go=
X-Gm-Gg: ASbGncvQcYjUjBluz3iylag9oTLbUh7NuSzrslHH4ogTTR2tRPiOvllM8JAsX34dWni
	HJ4FXDmZU3vR5ycUG5+gG+GM7/A/RkHbxbjguJIYMRl0gciuvctfJTabvK0P5tp0A05Dz01rCDv
	qMI7Jc8tVhsGkDh3vdq9qOGsF+1hGGdGnUHhEsTVMH9XFEcxW/inhgIyEYU8foHJk3otkstc+pk
	U7al/1ZgC8NbUG2lgY/5gg0Z9wOJMQ+WL1LGxnUw+2y6+PW+xiU3Nus46kcEdHMx4V1uC4ADlUs
	rBKTKy99TNyLEKjUVvAFKAReRQeTFLod03fEpKANZXFt07g=
X-Google-Smtp-Source: AGHT+IE5xeV0NUbNuYKzvFOV3AEJUr+EReH4NEBfc38jPX0mdKmdS3ZR7+QmzK4BxhzpwO1278L48A==
X-Received: by 2002:a05:600c:1c26:b0:439:9274:81db with SMTP id 5b1f17b1804b1-43bd292a806mr33898885e9.5.1741186900528;
        Wed, 05 Mar 2025 07:01:40 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e484451fsm21658482f8f.63.2025.03.05.07.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:01:40 -0800 (PST)
Date: Wed, 5 Mar 2025 16:01:38 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 2/2] pid: Optional first-fit pid allocation
Message-ID: <sk77mxmicnkuikluyi7r7oipn5rzf3v6d5jbhe7qtfvxrlpcgp@44yzmfadjtaa>
References: <20250221170249.890014-1-mkoutny@suse.com>
 <20250221170249.890014-3-mkoutny@suse.com>
 <20250221161854.8ea0dd0b2da05d38574cefc4@linux-foundation.org>
 <20250222090208.2b7aa864@pumpkin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n4qsuijfubozppny"
Content-Disposition: inline
In-Reply-To: <20250222090208.2b7aa864@pumpkin>


--n4qsuijfubozppny
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] pid: Optional first-fit pid allocation
MIME-Version: 1.0

On Sat, Feb 22, 2025 at 09:02:08AM +0000, David Laight <david.laight.linux@gmail.com> wrote:
> It also seems a good way of being able to predict the next pid and
> doing all the 'nasty' things that allows because there is no guard
> time on pid reuse.

The motivations was not to make guessing next pid more difficult, I'll
update the docs with better explanation.

> Both first-fit and next-fit have the same issue.
> Picking a random pid is better.

I surely don't want to delve into this now. (I acknowledge that having a
possible range specified per pid ns would be useful for such a
randomization.)

Michal

--n4qsuijfubozppny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8hnUAAKCRAt3Wney77B
SatLAQCLUp9Io5Ukm//Nmg5Fi6bNTNJ9OOvj3Vz0RpfBn1XDDwD/ZLoJh3aJ008u
HVxHLGdnDtj801p48rWW+9FitrsiyAA=
=A1Hk
-----END PGP SIGNATURE-----

--n4qsuijfubozppny--
