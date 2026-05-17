Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C617305691
	for <linux-trace-kernel@vger.kernel.org>; Sun, 17 May 2026 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779018318; cv=none; b=IeEi7/YUgWBqgCvw+TrlLcMJ6Rw5LK9t6MVDFEBYi5WpVagmT1QpRwVx882n0asawOCnvW03mnI6oBBI7m9+RoX2KchDEVaGSdf9lsWZ0N0RN8Hqb6DNnlaowp7Y0uuXDbB7PzukPitNeNvMwxzY3BheQ7LdI8aottBAyL9oxqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779018318; c=relaxed/simple;
	bh=3l7pJGBdrNdxcgGvxQPumHi6XTbYUKTv0qSBktVIClA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDV/L7458aMKiC5zfnXuX+K9fFGaIObhwO9X47/GAfV5k/eqrW/VWYlH/pdyOhUGULh29/0cHzrkj5Spk7jVvYMFDNzCcLGhVSPQqVPxZ95DGdXBE6dOzHavQKv2DVK0t3KvlpdbqBIl0VxFlRoKoSTTVWD6HaAT8iHh1pMv1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDwlr0Ek; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDwlr0Ek"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso6452045e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 17 May 2026 04:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779018315; x=1779623115; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9YJjc/QiWZeE3TL65SN8Kq4yKPUHyJIwfqQZVmxkSt4=;
        b=oDwlr0EkLTN4IVU0hhvH94jI4/fAGVcH0btgKCnAIlvDdui8EeqiXdb38tfwmvgZkm
         /m1eUZiPXX5wAY4z6sGmZQETjxiIKr9uCHRg9TMeueQa4PyKzA8UR86wQe3yCZ1oBd8i
         yIcbCuy0jEBj50s10wv0r/6pmwq3G0xkM65bB+Z0r4q+uuy6KyO7IItIV8E73ovw1Gd/
         a/mQrEDOVE25S+2vTb/FjHF7Do5QJIkuv1jyJ8kFcZN7P1aqr109jaRHQMVOcvFhN4/+
         Mnfv90JIMT8B8fcTLI1LA30kpCmonBfBMrIr2L1+YlZXRH3VfOE8dwJUQFEX8LNvu1F2
         C1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779018315; x=1779623115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YJjc/QiWZeE3TL65SN8Kq4yKPUHyJIwfqQZVmxkSt4=;
        b=lJiRxLKyS9u8IG/NklcQ7vrLulAFxN0NV5LZQ4H7BHMiX3tfqPQmL0ATL7wB7VwS5q
         pQkifHjKwRlCk3eIZ8Hkp/5i538qPB3saxIBTym00ItHmSwxqn/jrnDt1GN1TadIcNr/
         SD+oUJCupx2/XZ9DyxzInIf6wg9Qq0oqsu1nRvTN2Fwqqsw8CEvS8maK3r3tCzOXy0ST
         AecSXESLKrZQmm0G3rX+S4L4t8ZiU3EJsCTWKo4Qvqsf51rUZ7OE/nmkOaiIQLxcdDYT
         6RsNUrgSACw5tdqiKslNxA3mJ2r7Yb9y9R0XAQZb/Hx0B8r2GPyarRbJT8eFa0NkktcN
         l2qQ==
X-Forwarded-Encrypted: i=1; AFNElJ/C7/bz1NXD/iW3oiNZ27Ph8YHsMm03z6f7LtPl/EqMMjxuTeNOaqmqeXbKe30Uh6LYMC9lkTi4NUiVHxdUXvPPV40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8j3vsyeFV67ig1CtrF5g3Kkh1iKhXQzvqewjCe8oJwdNFxB5G
	x51ZL1Fj1ViOwMOOjXJw3PQu+KLUk4jNvCIbkyd0Sd/ialNk18ZYEmu/
X-Gm-Gg: Acq92OFy+fpNngTjEsk0dB1Y8Yju1PLBgj4pDqPtfbDPN1LweSJFF9aNMBbxiJ/8xeU
	Y6pzpVF7FEHY17B8p/hovlRafnYHsmpwWaPoImD/QPVkhW93UjJ7DprCL1rv5B4OL7ZgrnuYFsU
	hBZZgifShOdlqfIa0zTzLTVOnuJABaHTA2klDwgEUlw/LDBPCPvVAXqm7N2A4Adv4RyWGL/D3Tc
	VAjD1WABaJ6vq873q280UhRe7gdmIjOl/bd/cfn5aCtP6K4PFlaMpfRRE9qzSrHc/oJ9pjtKoWR
	1o6xjIxrL+S+V0ng4MWH80PAu8nW6FkbYBJGrbg8grXeXOCF2WY+o5Q2OysSJ8DvXhpYGdffnNN
	1Ph2ALWgPJ0JMtpvZjFNLvcR4vPrGj9fOIyKsRC59krvzr0WIO2icCMcmy0SMkwrX2hpVwUG0ku
	XHpXTb7jra2bnV25Gwnk767Y3aPg==
X-Received: by 2002:a05:600c:a293:b0:48f:e6de:1cba with SMTP id 5b1f17b1804b1-48fe6de1dc5mr98844695e9.17.1779018314603;
        Sun, 17 May 2026 04:45:14 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm29688465f8f.28.2026.05.17.04.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 04:45:14 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 17 May 2026 13:45:13 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] uprobes/x86: Move optimized uprobe from nop5 to nop10
Message-ID: <agmqSdXV0LTEIoUP@krava>
References: <20260514135342.22130-1-jolsa@kernel.org>
 <20260514135342.22130-2-jolsa@kernel.org>
 <CAEf4BzZxNLEeyDE2aJVm=T=RzDayaHzAbHxXQqn6M6uqa45obA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZxNLEeyDE2aJVm=T=RzDayaHzAbHxXQqn6M6uqa45obA@mail.gmail.com>

On Fri, May 15, 2026 at 01:31:31PM -0700, Andrii Nakryiko wrote:
> On Thu, May 14, 2026 at 6:53 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Andrii reported an issue with optimized uprobes [1] that can clobber
> > redzone area with call instruction storing return address on stack
> > where user code may keep temporary data without adjusting rsp.
> >
> > Fixing this by moving the optimized uprobes on top of 10-bytes nop
> > instruction, so we can squeeze another instruction to escape the
> > redzone area before doing the call, like:
> >
> >   lea -0x80(%rsp), %rsp
> >   call tramp
> >
> > Note the lea instruction is used to adjust the rsp register without
> > changing the flags.
> 
> I think it should be very loudly explained that we can't go back to
> nop10 and have to do short jump over patched sequence (and why).

there's comment in swbp_unoptimize:

         * We have optimized nop10 (lea, call), changing it to 'jmp rel8' to
         * end of the 10-byte slot instead of restoring the original nop10,
         * because we could have thread already inside lea instruction.

I'll add it in here as well

> 
> >
> > The optimized uprobe performance stays the same:
> >
> >         uprobe-nop     :    3.129 ± 0.013M/s
> >         uprobe-push    :    3.045 ± 0.006M/s
> >         uprobe-ret     :    1.095 ± 0.004M/s
> >   -->   uprobe-nop10   :    7.170 ± 0.020M/s
> >         uretprobe-nop  :    2.143 ± 0.021M/s
> >         uretprobe-push :    2.090 ± 0.000M/s
> >         uretprobe-ret  :    0.942 ± 0.000M/s
> >   -->   uretprobe-nop10:    3.381 ± 0.003M/s
> >         usdt-nop       :    3.245 ± 0.004M/s
> >   -->   usdt-nop10     :    7.256 ± 0.023M/s
> >
> > [1] https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > Closes: https://lore.kernel.org/bpf/20260509003146.976844-1-andrii@kernel.org/
> > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/kernel/uprobes.c | 121 +++++++++++++++++++++++++++-----------
> >  1 file changed, 86 insertions(+), 35 deletions(-)
> >
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index ebb1baf1eb1d..f7c4101a4039 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -636,9 +636,21 @@ struct uprobe_trampoline {
> >         unsigned long           vaddr;
> >  };
> >
> > +#define LEA_INSN_SIZE          5
> > +#define OPT_INSN_SIZE          (LEA_INSN_SIZE + CALL_INSN_SIZE)
> > +#define OPT_JMP8_OFFSET                (OPT_INSN_SIZE - JMP8_INSN_SIZE)
> > +#define REDZONE_SIZE           0x80
> > +
> > +static const u8 lea_rsp[] = { 0x48, 0x8d, 0x64, 0x24, 0x80 };
> > +
> > +static bool is_lea_insn(const uprobe_opcode_t *insn)
> > +{
> > +       return !memcmp(insn, lea_rsp, LEA_INSN_SIZE);
> > +}
> > +
> >  static bool is_reachable_by_call(unsigned long vtramp, unsigned long vaddr)
> >  {
> > -       long delta = (long)(vaddr + 5 - vtramp);
> > +       long delta = (long)(vaddr + OPT_INSN_SIZE - vtramp);
> >
> >         return delta >= INT_MIN && delta <= INT_MAX;
> >  }
> > @@ -651,7 +663,7 @@ static unsigned long find_nearest_trampoline(unsigned long vaddr)
> >         };
> >         unsigned long low_limit, high_limit;
> >         unsigned long low_tramp, high_tramp;
> > -       unsigned long call_end = vaddr + 5;
> > +       unsigned long call_end = vaddr + OPT_INSN_SIZE;
> >
> >         if (check_add_overflow(call_end, INT_MIN, &low_limit))
> >                 low_limit = PAGE_SIZE;
> > @@ -826,8 +838,8 @@ SYSCALL_DEFINE0(uprobe)
> 
> should we change -ENXIO to -EPROTO or some other distinct error code,
> so libbpf can avoid using nop5 attachment on kernels new enough to
> support nop5 optimization, but old enough to not do this properly with
> nop10?

right, I'll take that change as well

thanks,
jirka
