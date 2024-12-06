Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C685D19ABC6;
	Fri,  6 Dec 2024 23:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733528135; cv=none; b=XcantiH2Z9ZQlDdCSqHFHWKeObp55t8RWFDEt8/E5e1eVlvicpIDHcQLAVP5cFxOthkA1EiaDGohaMf5D9CjWLTfZgV5Z/jcZOPtGpGui9IVzffurlzkaBByVXO2R2PiXL51u3NRmu6xEd6PQwnVSsDW2Cn+OtDnWnozg7lcfhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733528135; c=relaxed/simple;
	bh=myjc/BUk3duYfzf2BuKRpvv3wzCuNob9sVPNA5NrNwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfMMozy2eRkTM1s0GrXOUQQKGa9/l7+lCFkRYWdrjx5m1qypwDpKkKG1wORlj1JUdDVaku5K4ugNRmd1gkkw9fCNa1icv/PoS7HCSEw7q+oGRVpiA0tnq+/UZc3cQKVwFL0ijdkE38vzLbLsW/5Nb9FdO79dr883JdKhakQUO4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcrVkshd; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcrVkshd"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2161eb95317so9321325ad.1;
        Fri, 06 Dec 2024 15:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733528133; x=1734132933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=126Ubm7PaeWZ4ZTzd+fTI4aIf3M9NdpROOmAVqkxosw=;
        b=mcrVkshdY4GQj0ItBjNdElwYzEMphnpd9IJ2Az2eglUiMnWdnmiFStkb6XNROoiCut
         y6VFm+l5pWT+f6d+LSOUApotZsk9jWB86HucSfHizC2ZkRXYTZz/v7rkcjykjsGSasTL
         uC/mnHzoPszw2uZHbO6A7uGpIMaWWGG66NvONbhGmNwi4PTaeByovhvegSXvdZuNpdgt
         6SCuIIW32gxSJvR/IYwmWKj0Ab0fe2qqyS/YtNjLURtJvAgCcgdptspg5wj/YlBIqXkO
         XKgJksXy6f99hYSww8EOsgJJfPEReR9EiLpbZc5ZWcDMrgoa4ahFr7ytyrb4tLXb7gdb
         KHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733528133; x=1734132933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=126Ubm7PaeWZ4ZTzd+fTI4aIf3M9NdpROOmAVqkxosw=;
        b=NyVALZYNlJOj4+geZzeOz6yrLcDt3oGEhUflMAvAzYZWF/DeVBoQHblAKXHKYtiOcr
         LnmF7XMqX6zbRwMScJ204i8YKltZDMN1o33PeoQ0s/PXcsdsRp/0+qYb6sm1TftlM4Gd
         fNCrmsMhoTLXyBytXyv844ppz0+BrCRSRnlw3ooNy6/pqlQreEPBCuPRrBvuCC+AvtDX
         w/slagyIvCW8nW6Yolb55i+Pklk51uy6GGEhs6IC8V4OEHLTP5SkIn4awFTQUS3pjPUk
         8+qmBXxM+1Z8AULtD2oMbO9VHpfatS5i8Zl0tm83sZ+aKJkMpyWLpxKP1k9zuSdZeMIa
         lfDg==
X-Forwarded-Encrypted: i=1; AJvYcCWeuMsE43gxY8G6bxl5xtyJ6jD7OnywCthJv3+pOnF7DsWT09drduan9N8PLtHQyt36S0gUTnwkfv5OBL5UVRubJao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7tGsycGGhZPYOTtbnOeR9qZ4VekUFiuM7qWQKCj0elHY27BLN
	/fr8zp6IAWTnuAacsxG6NYOJS2r0m1dtwgbp5CLR4FGjMRMcBPPy
X-Gm-Gg: ASbGncuMrquFPtHZv4B0+YosqWDnfEMbMcnuvwmz1tCHp1M/3vz8lGBc/FAlM+6+1VV
	DQ1D6TzAygEF8b8P1/Ar0baSCn4MCGD21SkjA+po6svn2V+zmIrMbBNWqLUyzbtXAqif/E8+GC8
	bh6l8xKnRymbQI6QCMYC9/+AV3P43skmwC6xjObfbcwsxbijcqO++M57prbz7ySKca+TiG1PuYu
	7zSws6/jLsKEUVUtMBdwDIL3hZ+r0OZ4IxgTGat3R5OF6mmsA==
X-Google-Smtp-Source: AGHT+IGCyNnkcXUzTJfpaaB0JuvpkQlDsGaivHj5Ru3IRnBxIZ67ik/FVm+00VqFGVdNnEtFStzg4A==
X-Received: by 2002:a17:903:11c8:b0:215:4a31:47d8 with SMTP id d9443c01a7336-21614d1ef5emr71074785ad.9.1733528132717;
        Fri, 06 Dec 2024 15:35:32 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e5f265sm33841085ad.70.2024.12.06.15.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 15:35:31 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 5B40542806FA; Sat, 07 Dec 2024 06:35:27 +0700 (WIB)
Date: Sat, 7 Dec 2024 06:35:27 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Andy Chiu <andybnac@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Robbin Ehn <rehn@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, bjorn@rivosinc.com,
	puranjay12@gmail.com, alexghiti@rivosinc.com,
	yongxuan.wang@sifive.com, greentime.hu@sifive.com,
	nick.hu@sifive.com, nylon.chen@sifive.com, tommy.wu@sifive.com,
	eric.lin@sifive.com, viccent.chen@sifive.com, zong.li@sifive.com,
	samuel.holland@sifive.com
Subject: Re: [PATCH v3 3/7] riscv: ftrace: prepare ftrace for atomic code
 patching
Message-ID: <Z1OKPxHBJ0kV5TbA@archie.me>
References: <20241127172908.17149-1-andybnac@gmail.com>
 <20241127172908.17149-4-andybnac@gmail.com>
 <87v7vxf7t6.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fdN/cFbE4b73Mn/0"
Content-Disposition: inline
In-Reply-To: <87v7vxf7t6.fsf@all.your.base.are.belong.to.us>


--fdN/cFbE4b73Mn/0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 11:02:29AM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
> Adding Robbin for input, who's doing much more crazy text patching in
> JVM, than what we do in the kernel. ;-)
>=20
> Let's say we're tracing "f". Previously w/ stop_machine() it was
> something like:
>=20
> f:
> 1: nop
>    nop
>    ...
>    ...
>=20
> ftrace_caller:
>    ...
>    auipc	a2, function_trace_op
>    ld		a2, function_trace_op(a2)
>    ...
> 2: auipc    ra, ftrace_stub
>    jalr     ftrace_stub(ra)
>=20
> The text was patched by ftrace in 1 and 2.
>=20
> ...and now:
> f:
>    auipc    t0, ftrace_caller
> A: nop
>    ...
>    ...
>=20
> ftrace_caller:
>    ...
>    auipc    a2, function_trace_op
>    ld       a2, function_trace_op(a2)
>    ...
>    auipc    ra, ftrace_call_dest
>    ld       ra, ftrace_call_dest(ra)
>    jalr     ra=20
>=20
> The text is only patched in A, and the tracer func is loaded via
> ftrace_call_dest.

Previously the operation was no-op, right?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--fdN/cFbE4b73Mn/0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ1OKOgAKCRD2uYlJVVFO
o6Y+AQCiT8k5GCk4aLvmXeShXl/pfnz5HC+PJM+m4E8quF6IJQD+My2mpICqvpg/
Bn0rGqOqUEb+abAgVYRVjE8IIuPdPwE=
=ruu5
-----END PGP SIGNATURE-----

--fdN/cFbE4b73Mn/0--
