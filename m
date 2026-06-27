Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9AB3382CD
	for <linux-trace-kernel@vger.kernel.org>; Sat, 27 Jun 2026 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782580497; cv=pass; b=O7ng9Q0uAnsSQ1MkO1nWZ8pnkex2AB+5MV+1IpXjKMV4Smbeony88Gkz7rJ670bc1BCeQi9D+0ydB+hg8pe7QwZzwCGg7+d4AkSpyBeRyfIQsoraGfEJFyoNw1Ow8bUrPuv7G2JY1XyIJyQveu7SwE/+B3Xugm+damHQbCMwm1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782580497; c=relaxed/simple;
	bh=Sa5hldT2ZYg6r/+6wae9/5GH3ZUXIje8CvnHz152sKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQuYjsr8Gej7/+HPzRPfcR7xVHjonE2dbP1MPi9tpnNsuIoRxDVQwgNvG/j4fIoiYLKsiedZ0q9zBTBGnHXdQXHO+xZGuLw+vymYu4klqbKV945RN4dcgmSrM94CW+1coUkaxbgxJLbkm0EqtMGOPntKTde+LSILwdwUpTFU9XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr4A3Lla; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr4A3Lla"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8dcc3f14b93so22962506d6.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 27 Jun 2026 10:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782580494; cv=none;
        d=google.com; s=arc-20260327;
        b=n0pTx//9Vn1zfsB315N38yI6h56z96XJ6BQMiG87voQviZiugN0gX5/OqFVWh2At9J
         ywjV3sytfM9tlnFZgqHOLq40pMMZ9p+QuJA44NxMjfTkTGStvAZF/5ObkzUEhy5t/nDn
         ZQPo7hoS3Rd6OEKpNJ9KMFow3S5UOyNAElevNNf09A7hQYr2WxWbdpTAqQVZNJj4YmC3
         9eUy/ToJ6GEUueTpxcpAO9o+OeG0uuA3TS05nU4uYP1WuiCvQPwXvfmJKEGlL/ePrPYk
         BSUuvZSVnjXX3RHFa5UIsBCPeBYGL0LqGcOUbLu8W/VI/w2Ee6NoZO8NcOajXFA/dEq7
         2AZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rndg724fhT2gi/rg6KYiyv9At6WA1DcoE2rGnTpaLCE=;
        fh=KJkSHra0aSGFcuBAi+QWMSN39jsPp9C46lDXc2Tc6wY=;
        b=edW7WhUvLR530xwzUkX5ugRnjUBXI3hqkC9NAiv2Tjw47CpEeEGXwg+Cu0/StlPJzp
         1R5zdaswjxqAS5UEYMzae9hd1m5zHT62RzIa7KFl/StmgaP8D5IZCc0agu0NzZCf6yjp
         y+iy2kVMQlpwKgF7dV4u9wzOA34cFDdY6XRrdYWE0r06Z9239PxWZnwgj74Ml+1Z4Urw
         YG8wnc2ch7a4NTrYz8f/xmAWmCkS+KHchoYC4nsLKLDI3l7/op9DPMR7WcOQ/8Q2Eku7
         eVcyCvzFb0tic8LhotQiN+VAmujgjuqBIVIt2yuT9fq4OgSY2QjWCmMQ9du73prW1Noa
         N47w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782580494; x=1783185294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rndg724fhT2gi/rg6KYiyv9At6WA1DcoE2rGnTpaLCE=;
        b=Sr4A3Llap4xpgm6N/Byyxzb/2ebidz2f7NxcQCmtHj5IFBFtYsCYTSdSTKuYDoJgNz
         4a4e2lXiwCwdsfwWzBvQZ9Qr830N63LWHbtERvyFZBOIxXu6Y2wq2hKR8otHmxtjV1It
         BngyI4flQYia9MN6hndbKiJtFwNPCHXY7XH/vdzJy9h/V5Bo7MKMFDkOJcrBrxQmdxIT
         LGREonmCqa5hkEb1rvr8EN/co8WJV6u+LSiUrU6cUGyZzgcvBosN4jmoyHxRiw2mctGS
         Qptx5FIeajeU+wSLda9rSFth6t1alBVU1RJwcHPdn1ELaypGcLYE/CELuyfcOSbNBWPp
         Gatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782580494; x=1783185294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rndg724fhT2gi/rg6KYiyv9At6WA1DcoE2rGnTpaLCE=;
        b=QWtMBNchBxVW58pOJCkqEChL/33Kh358MIGFLGL69fADZPRMIwY4B2pHh2l9XD9uDI
         f/S6J7ZIRmGcm4vSSslXoRVZg8l2Qi6qTppvhgqb+RnKu6C++5fwCBvrvPndTxZyLXd2
         FJyJd3HcGuvUEPIi29FskJ/cf+x88PNwystBCPrGFihlN3A3Mt8nYeGthusnoZx6ACw2
         syqI77uTzbpYU8dwjZhQb7bXtDjIc9VA14gaRK/7MxBuRGnV7UljopiyhiuIXL+PKTTp
         kHtgOgZPaD/SS3dAJ9W2rW3QYYWODOfI1CeO3HLWQau+pyvTN86nuZ442zigpwqhPofN
         c+GA==
X-Forwarded-Encrypted: i=1; AFNElJ+3ERh/3dAM5itESrsCF3uF5TrgMbMh7FHG7sCUaL9Y/v+MROa6mX3AruHVl+g7WJYEeS0+LjuEPtxdj82YtlzfHMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRW0qa8QJV+dh9cA/LU86WG9MNzR25yp8CVSQW5aJJ+3bQIsnJ
	oPnuU+7DKA6f93F0T4tLuqdW5IyjVpTyNPIB/gHxKAauk8aoiN1hbjs1Fxn9am2kimp7CYDbwkz
	Ga5NWdtyfLHnMWx8l0A5Y5qhu4au+MKNtELyr
X-Gm-Gg: AfdE7cmQdzhO0jF3dtWEHm40ZLWBHuPVWj9vvKLACkxq/V/1Q/scqtR4+xWuQxD1r6w
	/nyf7se+yP1P3TCsANBIYJZ2HKgGto2nHFkZD5n1Tc7qmn9Qh9Z2D33ljsSKOBZBcAm1hBxkPmY
	X3c0wmb8bsYqNqygj/3fDxHv5nb6OnKVq3fuZtmoEvWxZK2vQF5uOQTOho4bqsCC3gRBky98Zsg
	Dg211C8Ra/1WT1rND3EdD02iX6CneJbRlKEbzb5cxwK32HgBIAoYwWfzP41461D/gM7ecyJQ+nz
	3fbPW0nuRvfpzuIgKfFhd3fYvNM=
X-Received: by 2002:ac8:58c4:0:b0:519:7559:3937 with SMTP id
 d75a77b69052e-51a7276b300mr173294671cf.2.1782580493825; Sat, 27 Jun 2026
 10:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622183109.1137245-1-dwindsor@gmail.com> <ajqBkKE8TpQL1mIG@redhat.com>
 <20260623125725.GW48970@noisy.programming.kicks-ass.net> <ajqJNju6MY3B0S2F@redhat.com>
In-Reply-To: <ajqJNju6MY3B0S2F@redhat.com>
From: David Windsor <dwindsor@gmail.com>
Date: Sat, 27 Jun 2026 13:14:41 -0400
X-Gm-Features: AVVi8Cf2BLETcrC-Y5ycMRcxCYiENER-6GwvG2TtezK7GfUOEgSuV7OQzuRAuW0
Message-ID: <CAEXv5_gFBvtP9HZrQ14VAYpFbrY44o0+Qw9i=c6GM1Mnp4R83A@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/uprobes: Keep shadow stack in sync for emulated CALLs
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mhiramat@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	shuah@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:25=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 06/23, Peter Zijlstra wrote:
> >
> > On Tue, Jun 23, 2026 at 02:52:32PM +0200, Oleg Nesterov wrote:
> > > On 06/22, David Windsor wrote:
> > > >
> > > > --- a/arch/x86/kernel/uprobes.c
> > > > +++ b/arch/x86/kernel/uprobes.c
> > > > @@ -1246,8 +1246,12 @@ static int default_post_xol_op(struct arch_u=
probe *auprobe, struct pt_regs *regs
> > > >           long correction =3D utask->vaddr - utask->xol_vaddr;
> > > >           regs->ip +=3D correction;
> > > >   } else if (auprobe->defparam.fixups & UPROBE_FIX_CALL) {
> > > > +         unsigned long retaddr =3D utask->vaddr + auprobe->defpara=
m.ilen;
> > > > +
> > > >           regs->sp +=3D sizeof_long(regs); /* Pop incorrect return =
address */
> > > > -         if (emulate_push_stack(regs, utask->vaddr + auprobe->defp=
aram.ilen))
> > > > +         if (emulate_push_stack(regs, retaddr))
> > > > +                 return -ERESTART;
> > > > +         if (shstk_update_last_frame(retaddr))
> > > >                   return -ERESTART;
> > >
> > > Well, if shstk_update_last_frame() fails after emulate_push_stack(), =
we should
> > > probably return another error, so that the caller handle_singlestep()=
 will kill
> > > this task?
> >
> > Makes sense, the other user has a force_sig(SIGSEGV) on failure.
>
> Offtopic question... both shstk_update_last_frame() and shstk_push() are =
only
> used by arch/x86/kernel/uprobes.c. But they are not symmetric in that
> shstk_update_last_frame() returns 0 if !features_enabled(ARCH_SHSTK_SHSTK=
),
> while shstk_push() returns -ENOTSUPP in this case.
>
> That is why the users can't just do "if (shstk_push(xxx)) ...". This is r=
eally
> minor, but perhaps it makes sense to change shstk_push() to return 0 in t=
his
> case too? I don't think -ENOTSUPP is actually useful...
>

Agreed, will send a follow-up patch changing shstk_push() to return 0
rather than -ENOTSUPP.

I'll send v2 shortly with the additional call to force_sig(SIGSEGV) to
balance out the callers.

> Oleg.
>
