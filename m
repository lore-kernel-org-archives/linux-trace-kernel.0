Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0241922FD;
	Wed, 16 Apr 2025 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744770557; cv=none; b=Eid2fGD0+AKYdFjFm/DApjMG0fHP5iANeJBP0awst//EJzu5phI1tAC3Nqp/IbAAQWkyZY2XV2Jx/GncBO/VKaYX/bFfhVnMyM9xllJpSMg0+ldi8d+HmIZUc7zj1LyH7YIteFMBgfHu5cmE/Lna8msDhH4aKK7q/hO6CXsPypU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744770557; c=relaxed/simple;
	bh=GRO35YjSKNjg7reySZwDw9nnIaiJMQZeMCMsXN+b2KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=id5nlWbS4evNfkqnh0ZZKLwZZ72b2sdzXocyMJROsHQbGpp/as7aZ6xq+v/rDk8JW9YwuJKyu8L6YjE8obQJrzRYla3jAxy26ZmWYAZj7mqKoi77RufHQTuld5eBVSJUetn/t4E4y7ssu0qLUyeOOwU99Roo1jvFz7zkCNCW+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/3SFiaJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/3SFiaJ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223fd89d036so76182885ad.1;
        Tue, 15 Apr 2025 19:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744770555; x=1745375355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/8KQydjXyjALtPkCLpgAVjkgu+PVmshHO/B/jkHTytY=;
        b=Q/3SFiaJKtuqWlNWXV3lhHuhSekF5LHEgCb52WtRSkPGc9U5EnFDWLQJufo7mavk4e
         7VFaYXFaMHssMbJGwDNlPrVDYIYLhyN80WGQFkYcoa2zc1++8JP6OPXNpzyFWZ5/HvYK
         6xWOHRWLFJDOw/NW/e38pagdx8xLnQOZC1z0dv4EexsOkBwNhAmQ9FavSg6D9ZUhfdtF
         p+TY4eslBiI905SAcTST9YxHDFTxH7R6S7QZ4RMyp1I7d9IJ7ZrrrENzzaD17TWlrMGv
         A0awPA35pRKmFByUYoFtjNZvjRP03pF+eKPUFTVzQeePwsieGX6aBG7M3QOWpsnAh1fE
         FtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744770555; x=1745375355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8KQydjXyjALtPkCLpgAVjkgu+PVmshHO/B/jkHTytY=;
        b=uFXDykNg8zGepjNykfbrcTIQLDp6me4ZaImwqsGeuPLhHtzih5+T4GQqyPhCTQ/ZRX
         mdJimD9VlT5sUUvNc9FZ7vhayZB7BQeJir3GTRrceDkmrlrBSc1MGjEDaUUl2nTm5Tuk
         2qwtj2gGK++dbKa0PcxI/AL/HntJXtZhdZ1RWoa9uQcR2qHA0dB7/GUA+7H5C4oOpYSD
         EMy9De5p/rpPcBcsIZMRo85Rhkakynm/XQ8R7WRtYnsqbXndW/aDGahHJ98HMmrAYrtm
         IZ0BpZx1o3RzE6uCB5yjecLxf6iC07+Sy5w319ohlrwsl2Zy4uVYpP7hCVYJZtLircG9
         MrRg==
X-Forwarded-Encrypted: i=1; AJvYcCWpAz9VM0LPkKh9TYtHEAMt8fXSL5d2jHOupfbH63fhCiilU6dptt7cPE7Ju5phSjWoNHl5EmRFJZA=@vger.kernel.org, AJvYcCXW20DGu7mOHhA3a6xsp1shRfK5OSjYqB5W2n1sWxK9uDr9HhdYOXQsyNOCA6IO5CKzK6vhsTBGzffv999MjurI7PD5@vger.kernel.org
X-Gm-Message-State: AOJu0YzU2fVZ+fD0UBK2nnVsfxtboDp4NVdh6gwdmdfIsNjy2VyhB1oS
	jdprBYkczVhMb7+qdt/gqFZpao7AvLoxpcoYwDzi26rMUykj7rjc
X-Gm-Gg: ASbGncvdwwe5/G1dGJi+MQvdPCkQ8J52io0Ml1YXnByGR6njK0u6vJhoscB4BkQOqY/
	NeDK1W5Rejc6KQWWu/h7eeltAB/hrqGybboVCVDrBHgRJbeFTNd6Weu4gCzK01EycD2/4CiWh0z
	LhQp3y7ytnYwGPP+SBxFBeuQOdw5OrF+0ifgPKq7mncnVybCyHHtjh26YGAtgn9ouGWu5dT01I0
	xoktLBJaVUaQjqH6rUqMCTCtkEGqhIPF3P47GSLoHgVbLdiSexBjXEIChrO8H/umnmmrdImXhoh
	eOLNv1ASeWbNfY9+YghvB1pZMNjEpkjEJGMm6hLUshTddupPhVQ=
X-Google-Smtp-Source: AGHT+IGWK5+JLME7l7GD5LBI80atzEWy4uzP9IolNBwPWJYlwwHCLEK54dOpYMDp1S1/mkFqwyTSMQ==
X-Received: by 2002:a17:903:22cb:b0:224:1c95:451e with SMTP id d9443c01a7336-22c359742b6mr1224845ad.33.1744770555209;
        Tue, 15 Apr 2025 19:29:15 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fe7219sm2563135ad.245.2025.04.15.19.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 19:29:13 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 284714209E42; Wed, 16 Apr 2025 09:29:10 +0700 (WIB)
Date: Wed, 16 Apr 2025 09:29:10 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: Re: [PATCH 2/2] Documentation: trace: Refactor toctree
Message-ID: <Z_8V9jY_GskZNrme@archie.me>
References: <20250415034613.21305-1-bagasdotme@gmail.com>
 <20250415034613.21305-3-bagasdotme@gmail.com>
 <20250415100617.08ab9e08@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rRlYRbG0CYZBfKKN"
Content-Disposition: inline
In-Reply-To: <20250415100617.08ab9e08@gandalf.local.home>


--rRlYRbG0CYZBfKKN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 10:06:17AM -0400, Steven Rostedt wrote:
> > +Core Tracing Frameworks
> > +-----------------------
> > +
> > +The following are the primary tracing frameworks integrated into
> > +the Linux kernel.
> > +
> > +.. toctree::
> > +   :maxdepth: 1
> > +
> >     ftrace
> > +   ftrace-design
> >     ftrace-uses
> > -   fprobe
> >     kprobes
> >     kprobetrace
> >     uprobetracer
>=20
> I think the uprobetracer can go into the user space tracing below.
> As uprobes attaches to user space programs.
>=20
> >     fprobetrace
> > -   tracepoints
> > +   fprobe
> > +   ring-buffer-design
> > +
>=20
> [..]
>=20
> > +
> > +User-Space Tracing
> > +------------------
> > +
> > +These tools allow tracing user-space applications and
> > +interactions.
> > +
> > +.. toctree::
> > +   :maxdepth: 1
> > +
> > +   user_events
>=20
>       uprobetracer
>=20

Will be addressed in v2.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--rRlYRbG0CYZBfKKN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ/8V7wAKCRD2uYlJVVFO
o+bSAP9dXm3CeL8KzHY+jpT+Y4Nu8QImT8LNAr7OfqX5MKc14QD/ee51dtP0mfnk
RP1xGIVypS9FfDbrJVpjofQ1j6aDzwo=
=tTtf
-----END PGP SIGNATURE-----

--rRlYRbG0CYZBfKKN--
