Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C230F818;
	Mon, 23 Feb 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864151; cv=none; b=L0iRkCbnemJbnE/cPFeXa5N4K0G9SvrEG3r92h+1Pqy6fhCkatbF3kHH0AYN+jq+jQ5kE3GJ377wQ0QSI7odC9D3r0C+Kg+jOj4yRvXfKGG9NgYVkqvzSjoccQxp0GsvxfytGZw5hpwUGEcw2qjFxRDG3NGMDUQBddklJ6R0wOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864151; c=relaxed/simple;
	bh=V8MCg8JxTBTc1LXnILzTBwpz2fPHtDQfHJM/Xxnk7Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBwlCotRuZePy8eJljPIzaPSS8GQrdDh8mDEoHg/N4PPnNB1y6UHABz0nbIrv8aud9bHqESKue8cXY+qQd/YRp/uWD7RwPRGSJB5QLXZEXmCwR6iZo82uHVnIf9/McL8d6kJa8VYBv84Mj7urnFgIxOyUcBglOhiwfSyCrsHjn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jr+8mPX9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jr+8mPX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E3CC116C6;
	Mon, 23 Feb 2026 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771864150;
	bh=V8MCg8JxTBTc1LXnILzTBwpz2fPHtDQfHJM/Xxnk7Ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jr+8mPX9vgCWsq/ucbX61sM0Cd2e5uIvfEupzEo+OcX0qo3vTuUn4F9nrvq+qTSsQ
	 p46bxm6FC/GpbvBTOFLNPqp3tf3rh1TIljVD+JIB8+aaGsDCzNjXXK8vKW7U7zXxYz
	 drhBBZtrFdUEALGlRgp2HQzWLWdZxjaIX99szosPRXfwFMezDtbfheKa8lbnqhzc7z
	 uOn7yIfxfz7DJEFqnbDVcgNIGAqC8LKEjzMSBl5bRRr1OIeAbh7fCKw/5eU+SoNUer
	 KCF+yUS6wqxouazitkTRI9+HmUNM8m1EU14OPE/zCiSHfIIhl1WnLc0FdjnuFJ9Lb9
	 f0FUTMQA2V0Mg==
Date: Mon, 23 Feb 2026 16:29:02 +0000
From: Conor Dooley <conor@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andy Chiu <andybnac@gmail.com>, linux-riscv@lists.infradead.org,
	alexghiti@rivosinc.com, palmer@dabbelt.com,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	Mark Rutland <mark.rutland@arm.com>, paul.walmsley@sifive.com,
	greentime.hu@sifive.com, nick.hu@sifive.com, nylon.chen@sifive.com,
	eric.lin@sifive.com, vicent.chen@sifive.com, zong.li@sifive.com,
	yongxuan.wang@sifive.com, samuel.holland@sifive.com,
	olivia.chu@sifive.com, c2232430@gmail.com, arnd@arndb.de,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	llvm@lists.linux.dev, pjw@kernel.org
Subject: Re: [PATCH v4 10/12] riscv: Implement
 HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
Message-ID: <20260223-garlic-sulphuric-0c1574608d09@spud>
References: <20250407180838.42877-1-andybnac@gmail.com>
 <20250407180838.42877-10-andybnac@gmail.com>
 <20260221-repeal-emphatic-ddc2e9b94208@spud>
 <CANk7y0iTjHUBK66xx50b-eT=ssz9g0moFjOhCmipQC1SzkGs5g@mail.gmail.com>
 <20260223-respect-chaste-60c3403b5bc9@wendy>
 <CANk7y0jdzCeFaLVpj6-mnWiSZvv+rJF=9kgWDYF7g_rjCpiYsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gW4htCybjdexQ6TR"
Content-Disposition: inline
In-Reply-To: <CANk7y0jdzCeFaLVpj6-mnWiSZvv+rJF=9kgWDYF7g_rjCpiYsw@mail.gmail.com>


--gW4htCybjdexQ6TR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 03:41:26PM +0000, Puranjay Mohan wrote:
> On Mon, Feb 23, 2026 at 3:28=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > On Mon, Feb 23, 2026 at 03:18:17PM +0000, Puranjay Mohan wrote:
> > > On Sat, Feb 21, 2026 at 12:15=E2=80=AFPM Conor Dooley <conor@kernel.o=
rg> wrote:
> > > >
> > > > Hey,
> > > >
> > > > On Tue, Apr 08, 2025 at 02:08:34AM +0800, Andy Chiu wrote:
> > > > > From: Puranjay Mohan <puranjay12@gmail.com>
> > > > >
> > > > > This patch enables support for DYNAMIC_FTRACE_WITH_CALL_OPS on RI=
SC-V.
> > > > > This allows each ftrace callsite to provide an ftrace_ops to the =
common
> > > > > ftrace trampoline, allowing each callsite to invoke distinct trac=
er
> > > > > functions without the need to fall back to list processing or to
> > > > > allocate custom trampolines for each callsite. This significantly=
 speeds
> > > > > up cases where multiple distinct trace functions are used and cal=
lsites
> > > > > are mostly traced by a single tracer.

> > > > >
> > > > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > > > >
> > > > > [update kconfig, asm, refactor]
> > > > >
> > > > > Signed-off-by: Andy Chiu <andybnac@gmail.com>
> > > > > Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > > >
> > > > I bisected a boot failure to this commit [c217157bcd1df ("riscv:
> > > > Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")] yesterday, that appe=
ars
> > > > to be affecting all LLVM versions that I currently have installed. =
=46rom
> > > > some initial testing of Kconfig options, it looks like the issue is
> > > > CFI_CLANG related because when I disable CFI_CLANG things work once
> > > > more. Since this option depends on !CFI_CLANG, but is def_bool y, I
> > > > modified Kconfig to force disable it at all times and tested
> > > > !DYNAMIC_FTRACE_WITH_CALL_OPS && !CFG_CLANG, which did boot.
> > > >
> > > > I dunno anything about what's going on in this patch, but so little=
 in
> > > > it relates to having DYNAMIC_FTRACE_WITH_CALL_OPS, that I was able =
to
> > > > figure out that the problem is -fpatchable-function-entry=3D8,4
> > > >
> > >
> > > DYNAMIC_FTRACE_WITH_CALL_OPS can't work together with CFI_CLANG.
> > >
> > > arm64 has:
> > >
> > > select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
> > > if (DYNAMIC_FTRACE_WITH_ARGS && !CFI && \
> > >    (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))
> > >
> > > would need something similar for riscv if not already done.
> >
> >
> > I think you've misunderstood my email. We already have:
> >
> >         select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS if (DYNAMIC_FTRACE_WIT=
H_ARGS && !CFI)
> >
> > The problem is that the patch broke using CFI_CLANG, due to the
> > fpatchable-function-entry change.
>=20
>=20
> Yeah, sorry I did not see the patch,
> the original one I sent had:
>=20
> +ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS), y)
> +ifeq ($(CONFIG_RISCV_ISA_C),y)
> + CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D8,4
> +else
> + CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4,2
> +endif
> +else
>=20
>=20
> The basic Idea is that we can't put nops before the function entry
> when using CFI_CLANG, because they both interfere with each other.
>=20
> the fix should be something like:

Ye, this is what Nathan and I both did locally, give or take. I just
wasn't sure if this was actually correct to do or if it was just
papering over an issue with our CFI support. Do you want to send this as
a patch?

>=20
> -- >8 --
>=20
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 371da75a47f9..94100810a6a4 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -14,11 +14,19 @@ endif
>  ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
>         LDFLAGS_vmlinux +=3D --no-relax
>         KBUILD_CPPFLAGS +=3D -DCC_USING_PATCHABLE_FUNCTION_ENTRY
> +ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS),y)
>  ifeq ($(CONFIG_RISCV_ISA_C),y)
>         CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D8,4
>  else
>         CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4,2
>  endif
> +else
> +ifeq ($(CONFIG_RISCV_ISA_C),y)
> +       CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4
> +else
> +       CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D2
> +endif
> +endif
>  endif
>=20
>  ifeq ($(CONFIG_CMODEL_MEDLOW),y)
>=20
> -- 8< --
>=20
>=20
> Thanks,
> Puranjay

--gW4htCybjdexQ6TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZyASgAKCRB4tDGHoIJi
0ipLAP9rwb/PDaE+bILOLjsj+tOWGZpG2udHnJniirLzWBbsPgEAyN9wZ55T41u/
kQpB7PGNIlR8JZt4LkDVrfaNS6czeQY=
=Odj9
-----END PGP SIGNATURE-----

--gW4htCybjdexQ6TR--
