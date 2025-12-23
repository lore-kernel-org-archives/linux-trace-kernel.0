Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B174D1990A7
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Dec 2025 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766456608; cv=none; b=lx8hf7dbu/TwRIeZwuSMF2T+/TkgRMRgMe6BPUhFHIi7DAiHMWVQqKT6ajVPNTh4Y7E+jwlaPykBAT/n8SpGYgnjo/uB3ZHPNKuTjanmyvkdGX01CkcCz6lgDRfd6hILPkT2Z/+5zTAkpgiuWqqUY6GL+De7/XSaTDCgU/Ho2eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766456608; c=relaxed/simple;
	bh=pBzySd4Ox634GIKJpFixdpWuyO/RI9myMWRFhRp2X/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERn0HeYnQcWT2pDYX207cZityNa42Qm4peGqr1h8dqIQzaytplgJC8nukItQL66JcQk+UswptlZPmvRp++REDSWSEfevyllW0Yjhgr3CMc0gcLYDI0HUthOAIc/QlIKNi6AcLLhjvRksBb84H7bLmJLWLBvYR/EmpeW9h4rIr1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr0HsvVg; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr0HsvVg"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-65d0952e596so2542965eaf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 18:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766456603; x=1767061403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLeu/y61Z0yAvO3yDOpGOWyvHRNl3Gfwdr22wfFgq/s=;
        b=Wr0HsvVgRMmaq7cDrPiqjgbCBzRC0lzgZ0YObaMiGk2VD+wkiziRr3RVbzY/qEfTok
         j+Jyo6FodMd5t+0Er2LBl3HNLwK4/wJg26J955pv2cq97oWA/BB6233F23lAYu9CXtEp
         sS3CJPaVKODq3qYxREWxA7hH+qjHhTiJBoqkbzidELEtlF/tpk93xuLU1W7QhY7/G7i2
         SE4Sg+oZ+iGLhxOBKqZGFUfTNDiuQjK4LyjHD/+n3A0Ohu5eSTNLcUMuS4ER/WQtUqij
         RYUhtwWuG124jRvNR1r9OxyozEbc8FAIUQMiAsp2M+v7winKkbNH3OO3T5+YWJZoI5n9
         hD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766456603; x=1767061403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iLeu/y61Z0yAvO3yDOpGOWyvHRNl3Gfwdr22wfFgq/s=;
        b=W5Ff+75aBVlfUp2o7m2jq2QJdK86o1/d4mgeGy7vgYK+whifpvLYch3bjPDJnD8RfC
         jZ4QXBycUMrTv5IgbapJDzTBxTXHCGZZY2FEaKj5mYTMCmbwHSwO9Ngr6adgvWyH3tFI
         yM3WhjTv+xbxqx8DjB/jXirXqslsBSQEHea+mvNhtWPiW614Hc1Ppg2FrQecp1B1MbMu
         2d33nBhFbn6ulmLpWXEr+hpFk3f3mTo8UHaol3eE3meM7gr5p2DvKyNRSLKBsVT7gFFP
         iS4ceqvHlvit679x8Kxwt/Pp3mwdzASpUlh760mnj1pl/Xn4o8Vw0uS0CIFu8LVq/mUa
         Dejg==
X-Forwarded-Encrypted: i=1; AJvYcCUa8RN27vaYcXqqo/IwEJUt92KkrNs+YBPxV9y44HVHFeqvgT84ZMHyBmME7CwEXzuVDJ0UW7zTG9uCv8vZY9C+iJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB89KK4Db67/OYZoRbHNI4q1xxECHGakEvPvYjEI7Sw3KgsG2P
	rPoHi1xX64kUnRAMqy9OkBh3y97fhs7lmRUGHwqnSVq05q4J6VSig6+7Uueujas/k6Ls5XcUQhn
	AQlrsNIvy41+zXyT3JOmv7y5hRvxF07prHiLk
X-Gm-Gg: AY/fxX4lHry6juyGmpybUQKvtmuReyI9k3m1PVo9E9ejG6xx5jbCiWeDgAVRmrWmtdb
	4ZQPDEsTv3Ts/ZwXdLLB0+a/m/+5B7N0Q7Y+pc/wEfjrUArqGpETz2KW07avMFUSxlGcPdfTOCI
	opbDFqRkOzCmz3uzlns8QkWHtmEExGZEt1GUad5vXGXTqRaIIHI3+Ny4rg0v2cb30qZnHzi1PV/
	q9hvqCZUQTjbXDXLGPvGtT0f2bxwLVBu3Z6IPd5q76R8/3NpJ5SxSIN1Iysrl9meL6wQZQ=
X-Google-Smtp-Source: AGHT+IFYQ6TY1JvCD6/8ugUJPzSmdfqJx5SrIx00DO6YDE/XWcIW+afoGh0b2CfnLL+rZrcCv5sxoixO7SufMxtT7Zg=
X-Received: by 2002:a4a:a60a:0:b0:659:9a49:8ef3 with SMTP id
 006d021491bc7-65d0e3dbf8fmr4021479eaf.39.1766456603527; Mon, 22 Dec 2025
 18:23:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217061435.802204-1-duanchenghao@kylinos.cn>
 <20251217061435.802204-7-duanchenghao@kylinos.cn> <CAEyhmHRbacxpfTkPJq4MerBupH0bJkFfx8xGUvHMvGOzDDJUow@mail.gmail.com>
 <20251222015010.GA119291@chenghao-pc>
In-Reply-To: <20251222015010.GA119291@chenghao-pc>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Tue, 23 Dec 2025 10:23:12 +0800
X-Gm-Features: AQt7F2r1vCQijeU9b5DREgugKrd94kf6gaE7wPwDz-Jur_-FY6Ndtz9WhSQy1Mc
Message-ID: <CAEyhmHRkW67wiz_JX0i+sf2Y5LoYnpmTSt_Dh+asU8EEVTdk=w@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] LoongArch: BPF: Enhance the bpf_arch_text_poke() function
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: yangtiezhu@loongson.cn, rostedt@goodmis.org, mhiramat@kernel.org, 
	mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, 
	zhangtianyang@loongson.cn, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org, youling.tang@linux.dev, 
	jianghaoran@kylinos.cn, vincent.mc.li@gmail.com, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 9:50=E2=80=AFAM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
>
> On Sat, Dec 20, 2025 at 10:07:25PM +0800, Hengqi Chen wrote:
> > On Wed, Dec 17, 2025 at 2:15=E2=80=AFPM Chenghao Duan <duanchenghao@kyl=
inos.cn> wrote:
> > >
> > > Enhance the bpf_arch_text_poke() function to enable accurate location
> > > of BPF program entry points.
> > >
> > > When modifying the entry point of a BPF program, skip the move t0, ra
> > > instruction to ensure the correct logic and copy of the jump address.
> > >
> > > Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> > > ---
> > >  arch/loongarch/net/bpf_jit.c | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_ji=
t.c
> > > index 3dbabacc8856..0c16a1b18e8f 100644
> > > --- a/arch/loongarch/net/bpf_jit.c
> > > +++ b/arch/loongarch/net/bpf_jit.c
> > > @@ -1290,6 +1290,10 @@ int bpf_arch_text_poke(void *ip, enum bpf_text=
_poke_type old_t,
> > >                        void *new_addr)
> >
> > The signature of bpf_arch_text_poke() was changed in v6.19 ([1]), pleas=
e rebase.
> >
> >   [1]: https://github.com/torvalds/linux/commit/ae4a3160d19cd16b874737e=
bc1798c7bc2fe3c9e
>
> Thank you for your review and for pointing out the API change in v6.19.
>
> I believe my patch series already accounts for this. It was developed on
> top of commit ae4a3160d19c ("bpf: specify the old and new poke_type for b=
pf_arch_text_poke"),
> so all modifications to bpf_arch_text_poke() call sites within my
> patches should already be using the updated signature.

Fine, it seems like the LoongArch tree is not up-to-date.

>
> Please let me know if you find any inconsistencies or if further
> adjustments are needed.
>
> Best regards,
> Chenghao
>
> >
> > >  {
> > >         int ret;
> > > +       unsigned long size =3D 0;
> > > +       unsigned long offset =3D 0;
> > > +       char namebuf[KSYM_NAME_LEN];
> > > +       void *image =3D NULL;
> > >         bool is_call;
> > >         u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D =
INSN_NOP};
> > >         u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D =
INSN_NOP};
> > > @@ -1297,9 +1301,18 @@ int bpf_arch_text_poke(void *ip, enum bpf_text=
_poke_type old_t,
> > >         /* Only poking bpf text is supported. Since kernel function e=
ntry
> > >          * is set up by ftrace, we rely on ftrace to poke kernel func=
tions.
> > >          */
> > > -       if (!is_bpf_text_address((unsigned long)ip))
> > > +       if (!__bpf_address_lookup((unsigned long)ip, &size, &offset, =
namebuf))
> > >                 return -ENOTSUPP;
> > >
> > > +       image =3D ip - offset;
> > > +       /* zero offset means we're poking bpf prog entry */
> > > +       if (offset =3D=3D 0)
> > > +               /* skip to the nop instruction in bpf prog entry:
> > > +                * move t0, ra
> > > +                * nop
> > > +                */
> > > +               ip =3D image + LOONGARCH_INSN_SIZE;
> > > +
> > >         is_call =3D old_t =3D=3D BPF_MOD_CALL;
> > >         ret =3D emit_jump_or_nops(old_addr, ip, old_insns, is_call);
> > >         if (ret)
> > > --
> > > 2.25.1
> > >
