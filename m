Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DDA1C6B4
	for <linux-trace-kernel@vger.kernel.org>; Sat, 20 Dec 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766239660; cv=none; b=QOANgPolw0uPIust1/hpbpw+21Om40447IGstKD+Jem6kytl9/E9lTEtubz8FFpr3K8JT7OjWTXSrRyvLoF9QUPr036P3BZLQXjx6Zw7Q2CNE3Rbi11V6sso5PtjUAH8QL0skPoiGzVNoDcypfoczVtp9MUMRLQ5i60tMs4rqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766239660; c=relaxed/simple;
	bh=ppuzKfXdvO9jvlXXAJ3Z8CDIdqR8C/0djsmJ/G/zQqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPx9mhouxnh2jgFGAuAO0B1xpWxG7VThG4McWOdWBOICAUJRIPbCNuiH7NBJv5Ss7lwusvQR/6L4750Do4b/wY15OIOIFR0x8YIa8GAPoOpavMKL0Q+rzgk32r2NsNAOmNmnynRFa5wmKIkQCZACq4VEydXMnAexqG3EvlwDPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XptUCPOM; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XptUCPOM"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7cc50eb0882so900216a34.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 20 Dec 2025 06:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766239657; x=1766844457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tc1iEedM1caQ6hqBuO/lN1WSU9IfL3Q4FFgEU8l0tOA=;
        b=XptUCPOMIb1bEcHpbY3RoSLIaWHsW9zGToRquY/2NNLJR/KBw9qiM9q5iPIha8dhim
         x6CXG/xynfVDHsT5mbcFjaGzxIUmITxenn2NwvsToA1CfM5RmkT6bXMxm3QIDZkN3P2Q
         Qw/CkiKk5LGIqeGksVSy5/9BIY2YUA4RTxX3MDCCAaJ+f6+YvyGCBH1MbjTMHSzB972R
         ZtrJF/FufwODlD0ntGJkFtnXGWfB/tP6Iw2u+QEYayOfbz/YIOBWj2wcBMS2bHxFdU9G
         gZqHjy7q+50znKcJfSQz7Uqu4C/yJh9HrRqNN/KZSwuUySEqMEC0FJSdfeqOijTA6qxS
         FuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766239657; x=1766844457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tc1iEedM1caQ6hqBuO/lN1WSU9IfL3Q4FFgEU8l0tOA=;
        b=roaEFDVxzN7Ed2HTtBxEeYuiTHhFx8Pkb9xNPRPyBGfen3wHgnr9xNm7UWoki85NXI
         ymLTq8rrk9qONAPzpf0xRqnd649G7ooQhVjyZm4e6dK9nl3UCXUPknn3ql+bIzOE6aTx
         32oO00wZajRZ0v0Xw7jPm7inCAhguAeyIQhAETQxUVUWArCqvk2YXjpt7wTcTja9413K
         4llOU+OJ3iyzUBiOgOKDR3QB9jtX/dROUBL8KYP5wfG1EivoBbd+s44zkhJhG2Mmhx2d
         4MzE7ilmIYN2Vg6vTp14hdTCipk2Cyk8F/PEJFiHbNsIN/L3NS3GXX2+3+AD7Xy6aIHV
         Jm/A==
X-Forwarded-Encrypted: i=1; AJvYcCWM+tWoZ7fAJV5LAzdrjhn9z5PChRqVmfb3KcDjb1eCbkVs/ssfoLZGRLHNp2wbrl3KXGqxfG9mUtwquBHSIr0IPdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNPa7mr6OyfezfKAMTzQF5LCczt/mSCgYREIgQrWRiRoWa9gjm
	eHEplxgW0v5nd3QwmP1XV/lTiuf7Wl+D/rz2xt9k0KTxQOPjPZil1x28Kdjx2IpX7ZbQ5+UZMw8
	b2sgqITvpVh9Id6X3qUWd7Ib3NYbijsjV/R1obfQ=
X-Gm-Gg: AY/fxX5KRiDSF7T2s1o770jWcELzML7c1KM4kq6XiFau+gZ7dcG0XLbeSoraKUTaw/e
	6qhYBaRHQuFR9F9UQTBFvPqNYbaIqKFAXGyv1uLRt6bwaJwLRrDlpfkcFRy69cYY+BiihzanVWv
	0dcwVHYv1QtwZSpQC12frpGE9eokYZffCEpcKV5ApPS9XVBTvwlWL9nL85BDzEUHYMGgKaFo3mu
	g6cTBWCHV5rOLEviVli17crj2TdKN1CO3qT58N9zD0fEpZoSLFgcWq+S/MicGTzW32ZdcU=
X-Google-Smtp-Source: AGHT+IFKJvWy/VbyNKsiekvuWECXFOl3II4PdAI1c5BeYHGXBeL5yRX9cLnJ1GnL00cdoCslt6FVO9gv5pYDRsHn0iU=
X-Received: by 2002:a05:6808:c1ae:b0:442:e596:1189 with SMTP id
 5614622812f47-457b223fceemr2941683b6e.45.1766239656930; Sat, 20 Dec 2025
 06:07:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217061435.802204-1-duanchenghao@kylinos.cn> <20251217061435.802204-7-duanchenghao@kylinos.cn>
In-Reply-To: <20251217061435.802204-7-duanchenghao@kylinos.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Sat, 20 Dec 2025 22:07:25 +0800
X-Gm-Features: AQt7F2qcrrU65Yn384r_DbQIv295t02mQ5NXmH0yR08XLRQSjXo2M45Sl0nHU1M
Message-ID: <CAEyhmHRbacxpfTkPJq4MerBupH0bJkFfx8xGUvHMvGOzDDJUow@mail.gmail.com>
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

On Wed, Dec 17, 2025 at 2:15=E2=80=AFPM Chenghao Duan <duanchenghao@kylinos=
.cn> wrote:
>
> Enhance the bpf_arch_text_poke() function to enable accurate location
> of BPF program entry points.
>
> When modifying the entry point of a BPF program, skip the move t0, ra
> instruction to ensure the correct logic and copy of the jump address.
>
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 3dbabacc8856..0c16a1b18e8f 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1290,6 +1290,10 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_pok=
e_type old_t,
>                        void *new_addr)

The signature of bpf_arch_text_poke() was changed in v6.19 ([1]), please re=
base.

  [1]: https://github.com/torvalds/linux/commit/ae4a3160d19cd16b874737ebc17=
98c7bc2fe3c9e

>  {
>         int ret;
> +       unsigned long size =3D 0;
> +       unsigned long offset =3D 0;
> +       char namebuf[KSYM_NAME_LEN];
> +       void *image =3D NULL;
>         bool is_call;
>         u32 old_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D INSN=
_NOP};
>         u32 new_insns[LOONGARCH_LONG_JUMP_NINSNS] =3D {[0 ... 4] =3D INSN=
_NOP};
> @@ -1297,9 +1301,18 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_pok=
e_type old_t,
>         /* Only poking bpf text is supported. Since kernel function entry
>          * is set up by ftrace, we rely on ftrace to poke kernel function=
s.
>          */
> -       if (!is_bpf_text_address((unsigned long)ip))
> +       if (!__bpf_address_lookup((unsigned long)ip, &size, &offset, name=
buf))
>                 return -ENOTSUPP;
>
> +       image =3D ip - offset;
> +       /* zero offset means we're poking bpf prog entry */
> +       if (offset =3D=3D 0)
> +               /* skip to the nop instruction in bpf prog entry:
> +                * move t0, ra
> +                * nop
> +                */
> +               ip =3D image + LOONGARCH_INSN_SIZE;
> +
>         is_call =3D old_t =3D=3D BPF_MOD_CALL;
>         ret =3D emit_jump_or_nops(old_addr, ip, old_insns, is_call);
>         if (ret)
> --
> 2.25.1
>
