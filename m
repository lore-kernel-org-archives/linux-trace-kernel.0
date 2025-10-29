Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A57F2F85B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746993; cv=none; b=BkgijKdP/xP6LD7UAVU5fg9f45eWv7Kg5eWRRzExqTAWRnBqGLBA4R4NRQpv8isHLKLItfBak2wJP+w0V6lZgrdqHGMcsBk10Rejw2zw3Qvgon3BnY5DYBBLGTuwlf347HU5V6gjKPcHceZiMUEPrWW61szo5vUPNTmpX13PNAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746993; c=relaxed/simple;
	bh=t8Je67MYz78CSeDapeZWXFbw8UTnijHwDfsQ0oJzpBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSANgcID3tqA9HOH8jBzyforbKeMhbFjKzpEYi58m29O8KNIaFtrMx/UknOa7qyYCCoFY/VvqFck2NSDPaeg3TkU9dHSycyFpE62i8BEoB4Wl0Mlw1F2ZAPT1BqAHeb/XP6/XmMVrIgLShobe1u9eSsyZBgHJL90LT6lsHO8LSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMx5+jUn; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMx5+jUn"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-71d71bcac45so76363997b3.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761746991; x=1762351791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycwR5keqCwJzvgHRE2PU/x6zSUHdoe+fklvAVma4ZAo=;
        b=JMx5+jUntRlcJQLqr27dNA+ixkWY0WcL3QE4C6TlU95MlE9ivCX/UHo1gba0ho5nrY
         mRL8BMdRbegHhnja22M47l9YmSUUG4mExAaHz2q9X09/LMKT6wYbedeQGpKeLfREenEL
         RRLDGbSAjc+PVCDfeBjfiuWVHXBvRYDjTbGMp+23Vb/taj4QtkbNxVQmDnY6e+LUZ+lx
         VQ7FnD9x3qdcxLt3aliZwhxvaMtub+o8d3d0FXSA07CNvcImsgdeqtaUvhRjnEUDczTM
         NoI1OZeKCvM4qC++6c7xW5EbYWMRJWlOuDPFk/QvB7Kj9aAd6dZEVdeCRKY3bmAhvkaS
         DWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761746991; x=1762351791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycwR5keqCwJzvgHRE2PU/x6zSUHdoe+fklvAVma4ZAo=;
        b=qyXBdxCvraEB7KDKbJnvGEo0y49qZ5UHr0ov1m/rMLfFMhAd9ImMuaxsrByKF+TdrK
         25JBDyiZfLCg4i2lx+gRrycX7MB3VKtmiJq1I6DtUqQivfvUJoWgFSiIdaBi2DgReVOq
         fr6thDi0/n8a8U/020DiR3VOAFEQHz9Wf8q0a4FEMb3lKdFLdAyzgPJ262MTnWgHVYj/
         gu8SAJ5oU0Dp402i14A6mH/2b4tmzVHuhrA1X+tLWmtg5BDaTFQ4WMZ/lSukwufGdSeP
         /i8eDsLTX6+fADBoP1AJ8FLyrx6/qSn5EnsXjJBWJkFzM8sEuMaqhfWeYxUmfH5SkORf
         SitQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+0DwuBoggWj+iuqq1cdGGDupqDip0TF4Sn/XU76fyLgLPN5eCnjquLNbfpeqLtkYBMhcXTiODPynNXAG7HNn4SRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV3E7PbDwAGJuiw2XqbAE3nMhocaWddqhqU0RD+YXlrvlJz3BQ
	agBmJjhGB8/sh/qnAAYzSQsd1eepIzlOmmfc4DMG2jLfcSmCxa1C6s93ZNdf6cor2on+VHS0ybJ
	WqYDc7h3u/CX0Dd0deLsGk/PuprUDirk=
X-Gm-Gg: ASbGnctrBB+xXrWcm9rAvv+hVN57Tu1VTvkymECehMRPkOSbxnWleWo8G7e6wxLYjQ9
	RXiAqMU+lppp586RsYbQBx2pqsVmKqLeQyx9kikjM6KmdqjXFM4Ak5mPq7rFOy92vZW+BOGPNSs
	O90HOVIHhf7usR/F/bnHxQAlC6HcFakISXsqTJ0RHq7fuUoXayZ+ziII/54TmqqhK2yCvEytm3G
	L7lQiZpLtlqOIyR4rNNVUrD4jeCV70FM3n5ZNhSrQR0AqBd/5E+z3iwhu9JiDjy
X-Google-Smtp-Source: AGHT+IF+osjOqvoulkw8NO3HUmXRkTZBaKFJ2uh5+H+b3awpIW0yi0ceflqPVNZ93HSbPbOv8l1IEkL2tLogOY1edPQ=
X-Received: by 2002:a05:690c:7241:b0:782:9804:c939 with SMTP id
 00721157ae682-786290a02c5mr29214567b3.67.1761746990928; Wed, 29 Oct 2025
 07:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029021514.25076-1-dongml2@chinatelecom.cn> <20251029100045.1bacc491@gandalf.local.home>
In-Reply-To: <20251029100045.1bacc491@gandalf.local.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 29 Oct 2025 22:09:40 +0800
X-Gm-Features: AWmQ_blsBI_DFdiQF48RKMGt-Buyb8d0mgmMYGrEuLR2v4XIcFJRfldKRW4N2B4
Message-ID: <CADxym3YcR+WYjRv-0+SOiE1yoO85FaqffCF2XbLZ9H7+qHet6w@mail.gmail.com>
Subject: Re: [PATCH] tracing: fprobe: use ftrace if CONFIG_DYNAMIC_FTRACE_WITH_ARGS
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, jolsa@kernel.org, mathieu.desnoyers@efficios.com, 
	jiang.biao@linux.dev, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 10:00=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 29 Oct 2025 10:15:14 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > +#if defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS) || defined(CONFIG_DYNAMIC=
_FTRACE_WITH_REGS)
> > +#define FPROBE_USE_FTRACE
> > +#endif
> > +
> > +#ifdef FPROBE_USE_FTRACE
> >  /* ftrace_ops callback, this processes fprobes which have only entry_h=
andler. */
> >  static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent=
_ip,
> >       struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > @@ -295,7 +299,7 @@ NOKPROBE_SYMBOL(fprobe_ftrace_entry);
> >
> >  static struct ftrace_ops fprobe_ftrace_ops =3D {
> >       .func   =3D fprobe_ftrace_entry,
> > -     .flags  =3D FTRACE_OPS_FL_SAVE_REGS,
> > +     .flags  =3D FTRACE_OPS_FL_SAVE_ARGS,
>
> If an arch defines DYNAMIC_FTRACE_WITH_REGS but not
> DYNAMIC_FTRACE_WITH_ARGS, then this will fail to build.

Hi, it won't fail here, as FTRACE_OPS_FL_SAVE_ARGS has
following definition:

#ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
#define FTRACE_OPS_FL_SAVE_ARGS                        FTRACE_OPS_FL_SAVE_R=
EGS
#else
#define FTRACE_OPS_FL_SAVE_ARGS                        0
#endif

Which means it will fallback to FTRACE_OPS_FL_SAVE_REGS if
CONFIG_DYNAMIC_FTRACE_WITH_ARGS not defined.

I have commit a PR to the bpf CI, and all testings passed and no
building error happens:
  https://github.com/kernel-patches/bpf/pull/10110

Thanks!
Menglong Dong

>
> >  };
> >  static int fprobe_ftrace_active;
> >
>
> Perhaps do:
>
> #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> # define FPROBE_FTRACE_TYPE FTRACE_OPS_FL_SAVE_ARGS
> #elif defined(CONFIG_DYNAMIC_FTRACE_WITH_REGS)
> # define FPROBE_FTRACE_TYPE FTRACE_OPS_FL_SAVE_REGS,
> #endif
>
> #ifdef FPROBE_FTRACE_TYPE
> [..]
> static struct ftrace_ops fprobe_ftrace_ops =3D {
>         .func   =3D fprobe_ftrace_entry,
>         .flags  =3D FTRACE_FTRACE_TYPE,
>
>
> ?
>
> -- Steve
