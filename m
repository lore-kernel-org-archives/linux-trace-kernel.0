Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA6B391851
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 20:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765420; cv=pass; b=gakeOyyhTECc/70vTWRwWpgxVhr2XGGEkryqCDEpQmtfBO/xesTHZVCUA9hjHkWKUDqlAxMfIhvC7xC9YNx0ixpCm3Ft3LxKnbXQ2wqHMRbBhBq5rzwuBQd/aoYjWOMCRBTS81IjgdFgj//ZfJHTYYrF3K78rAMLdX0XjRiQjY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765420; c=relaxed/simple;
	bh=rqL5Z0h2rCevncTGlgklxBt0211rUyUNLOZJCKCfihY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAL4rzQrikwN8xX7LPVCeX5sinB6oFhkIes/ATM2TQhbCuggy4l1fZFSDRux09CcKu+GfKNzSdvPuUMyGdpiXhC25BxfEcbsCsFvUAbM2kmDOe7pwCz2jmWKUCIru7tOWfp1LUO7qjmAep7b1xZuqQJs0S+B4o+nZfB05l+lMDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4i4mMAO; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4i4mMAO"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-519f758bca6so26508111cf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 13:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782765414; cv=none;
        d=google.com; s=arc-20260327;
        b=OU/WXhy9NsPvqTEjocxWeOC2d5XpnRxWwP6pa/g0K76w8eTey8EAMzhgYDv8an9EdL
         GD+GrxDcyVntbO4xCvAMngd21wxClvqtb6pMEQ/g1mwCXuM06B6XBVEBWy6SnaBjMlVa
         Gpe0SGFrwEn+g3n458guPt+7qcsKm51Q3Ly0BpltAZpvL4GUwiEpoDQeXUkZVxLIE/f7
         E2iOKqSmKsZsF/T8FHxkDFl9Ai8bDN/5boIu+IkUwInkASmmGVKh0AVRhtYO6geygQhA
         oemVECSwpN3N+KT/8lKjfNlGGOINg/a/cB4hxVUl0BGbrtKZWEcsC8CUNysgdoRn1dSx
         pe5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9YIu+7FU1VHtbqvxCn7BGYzQvkGTmNtaVEMjWe5+3hY=;
        fh=nVXDvMjy1AUo912yHm74k/uD3eMCFPtcl3wx77VAT7U=;
        b=Zlo0Nh28scfMW81jnvwsB9bCpJP7f8FWdFx93voenkGu38uZunuY2I5fxhDWWz+PJR
         w34gZ9QMYoVc59Gtn8u9AjaHdtECK2fMNpSotDUhTQA/uI6QXGHWeCSO8fT+fS/ihiyy
         +JmCEafbEhe4yZZT68a5RJ6+dfFlTvrm80jyprE2bvcFz2+FQ1S2+D/Rhefx8tZZ87F2
         H2M/gwnPbd05iGn3QshKgoxLNx3kAGhnqweeUNp3t1tVarOjzw+ZJ4uV0qxH0rBPrSLW
         7bZ3+Sj6SGgWEDhI3JnE40XhD1F48HNL63NqLeMygmbiQfVcxnzODGXXS10fHUN5p0N3
         l2TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782765414; x=1783370214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YIu+7FU1VHtbqvxCn7BGYzQvkGTmNtaVEMjWe5+3hY=;
        b=Y4i4mMAO4HFGOj70muULFSSzhbwu3OOk6CXHdcrdku+pvdRhmr/TTjvJ6NXVUHZeEx
         RucGWbqu7R9EgjwLd5ZS2qep+Tbcp+oCWl69K97IPqBk0/RYhbFj3gxL09I5P63Q95sw
         FYTd0GGoAJy0Xnix4Sx8XVPv6nRjHjH0c5TeE72uc9sqO3pdJ58IWOYBWgl+TOZjAF/E
         J2DYmd4AcRhKBgLU3C+sJcynlcwJnDCg1+SDmuR2fnYVqqQKzpptvTWnIGfKV+H2oH4q
         6WIcvyqbyom4elmmgUnpQICULHKmkY5zA5uZVsrZ7JaAE4yHyH6uyTDFWFz6syBKrsXH
         GVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782765414; x=1783370214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9YIu+7FU1VHtbqvxCn7BGYzQvkGTmNtaVEMjWe5+3hY=;
        b=mhjKYDbQlEWsb8z6bZAEV+b3AcFhTYlFoZBuA6WoWmyzEH9mjEFfSx5FFUC+RFuHlP
         J+T3549xxfZiSorK6bzpHExhHDTlmqdB+Ce+d1dR4F++lPVImfoPljs1FGa1zu3ITZD2
         hNTBE7sIRpuGaYDIu+vtR4QKmV/s18N5ZClOBdSBA7kWftPdE+boF8FEWBs0+pA+xE7o
         AqRZ8mtgrr90X8RV0mCpDFdnncnKFstF7en/S00NvajpILhOn3RBh6OfTMn5oy0Kjia1
         iifX8hzeMITKexDl6Ggye9zJiimVujg+PPgIPpytdLewLx7CA7CLVKfdKADHTASZnEKE
         4Asw==
X-Forwarded-Encrypted: i=1; AFNElJ8xKg/O6+gZ6llXdupuRWIlChyB8/LtHCDZx8a0F0c1oORBLarAUmuvxtC29p9N44e1YhyEXkBIdWk/pwj/GCD6iB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbu1BdT4ZkHdQVH01Ww6hndN/K0NNXpro61oa2+BiyMt3Bz7/3
	trgmkjYoA/Pr9/ZE3ur6Fg+wsyT30pW1dj2XB+ulvK6ekFjdNhxkH+a0T0UGWEfgiyTNfIy52Jr
	x1fQ6Fr87gw6shn8moIIWztan5JtNHNo=
X-Gm-Gg: AfdE7ck6uzPbLP6ppqrhEgLLzZY+uf9CUOwOKnkRhK6VCxsTshxRpyIyf8mFzSlHR6Q
	+kB2IiIVrQlouWLhVjACH8kuM6rUz7h8rLPyabSbUdgTzo5TKL/CR6Nqfrc3nT2RNiadUOPEKls
	gg01/pBr+Op8DnmHFmFf+CdixoNDSB+UcHajfAnS28JKIbkjg8+S2Jyd18i2lBwaAgryUZWZMk1
	JqMtPYX7FXlq5sQhYvjR3I+MzIdiypvEjRh4/UFmipQfvwfO+YQSjIG7c6XrvjWrOL5XzC5/3LC
	bVwKMVggWKvrXS+OX5A3nTE+wOE=
X-Received: by 2002:ac8:7f4b:0:b0:517:146d:2db5 with SMTP id
 d75a77b69052e-51c10716dfcmr13137691cf.2.1782765413909; Mon, 29 Jun 2026
 13:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622183109.1137245-1-dwindsor@gmail.com> <ajqBkKE8TpQL1mIG@redhat.com>
 <20260623125725.GW48970@noisy.programming.kicks-ass.net> <ajqJNju6MY3B0S2F@redhat.com>
 <CAEXv5_gFBvtP9HZrQ14VAYpFbrY44o0+Qw9i=c6GM1Mnp4R83A@mail.gmail.com>
In-Reply-To: <CAEXv5_gFBvtP9HZrQ14VAYpFbrY44o0+Qw9i=c6GM1Mnp4R83A@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Mon, 29 Jun 2026 16:36:41 -0400
X-Gm-Features: AVVi8CfuqcgWf9PxadWlEONY5GAlf5DL137qARv7peK2GzjuWzY2x-_h44kqHGg
Message-ID: <CAEXv5_isBBk7FJhuzv4n_WWHtseiiA5JM4AwZAsTBdRpx_L4fQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/uprobes: Keep shadow stack in sync for emulated CALLs
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mhiramat@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	shuah@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 1:14=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> On Tue, Jun 23, 2026 at 9:25=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> w=
rote:
> >
> > On 06/23, Peter Zijlstra wrote:
> > >
> > > On Tue, Jun 23, 2026 at 02:52:32PM +0200, Oleg Nesterov wrote:
> > > > On 06/22, David Windsor wrote:
> > > > >
> > > > > --- a/arch/x86/kernel/uprobes.c
> > > > > +++ b/arch/x86/kernel/uprobes.c
> > > > > @@ -1246,8 +1246,12 @@ static int default_post_xol_op(struct arch=
_uprobe *auprobe, struct pt_regs *regs
> > > > >           long correction =3D utask->vaddr - utask->xol_vaddr;
> > > > >           regs->ip +=3D correction;
> > > > >   } else if (auprobe->defparam.fixups & UPROBE_FIX_CALL) {
> > > > > +         unsigned long retaddr =3D utask->vaddr + auprobe->defpa=
ram.ilen;
> > > > > +
> > > > >           regs->sp +=3D sizeof_long(regs); /* Pop incorrect retur=
n address */
> > > > > -         if (emulate_push_stack(regs, utask->vaddr + auprobe->de=
fparam.ilen))
> > > > > +         if (emulate_push_stack(regs, retaddr))
> > > > > +                 return -ERESTART;
> > > > > +         if (shstk_update_last_frame(retaddr))
> > > > >                   return -ERESTART;
> > > >
> > > > Well, if shstk_update_last_frame() fails after emulate_push_stack()=
, we should
> > > > probably return another error, so that the caller handle_singlestep=
() will kill
> > > > this task?
> > >
> > > Makes sense, the other user has a force_sig(SIGSEGV) on failure.
> >
> > Offtopic question... both shstk_update_last_frame() and shstk_push() ar=
e only
> > used by arch/x86/kernel/uprobes.c. But they are not symmetric in that
> > shstk_update_last_frame() returns 0 if !features_enabled(ARCH_SHSTK_SHS=
TK),
> > while shstk_push() returns -ENOTSUPP in this case.
> >
> > That is why the users can't just do "if (shstk_push(xxx)) ...". This is=
 really
> > minor, but perhaps it makes sense to change shstk_push() to return 0 in=
 this
> > case too? I don't think -ENOTSUPP is actually useful...
> >
>
> Agreed, will send a follow-up patch changing shstk_push() to return 0
> rather than -ENOTSUPP.
>
> I'll send v2 shortly with the additional call to force_sig(SIGSEGV) to
> balance out the callers.
>

Actually, we don't need to force_sig() ourselves in this case, the
handle_singlestep() path will take care of that. We just need to
return something that's not -ERESTART. You may have meant that in your
reply, but just noting it for the record for when I send v2.

> > Oleg.
> >
