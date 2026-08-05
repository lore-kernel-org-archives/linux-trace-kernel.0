Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92D33CF69F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Aug 2026 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950968; cv=pass; b=gEDz2P/xS2Qj5Ldww/RZYF1epoVkeUopweehXgITbejqEht6a8cc7pFviI8VFfiHoldANfJ395DbzpZHWZzPH0wnJu8F6A7k/ddWSsQmY7FdW3+ilTD7DJiyaYTbS+zMRTc1GAUrHWxU1kvYeJnT5q+D1ExKDXWVOuv0cClLnTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950968; c=relaxed/simple;
	bh=Y7fscsQej171KTwf2J9Jdj9T34NKkKVGhz0dodxWVuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1t1hnvx+ciJ4+ycGlg1Tw/iIKXou5tkJVK1Hbg6xbwT6mHI1UgicjZQOhe5qPnDBOQqzYXr9EgIvGxnyX8E4xYs+X2IT8GHnman9Q9WBJ+f2OQe5MhigbSY9gz7CCVzwrB9He28RO3JiQ3OVO25pf6EJaVwdDgHHwUA2ZASkXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MW9Y//cN; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MW9Y//cN"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84847482584so100133b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Aug 2026 10:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785950966; cv=none;
        d=google.com; s=arc-20260327;
        b=DU5PCFvL7mQaMuqWCR4jTw77YPGmtDh/+YaRSHo/MyzCASac8He9EHhSEvvnvj92cb
         ePsVR3TIbcA6SyXtn8ObcwNwGpFlmRCIvTzktzd2FbZ7vRgag6jlui68iQjx7TMO2t8F
         lzZDvtuubeNGCOdYnbb1lLtOn8lzY3hb0cApPzvjprPGLFyndfaa8GiPh/MVVISo8AcM
         j2E8UiylDE+EY2tK5Gh7wPhsVRzUsrIjem8DRSD1UAFfZD6VbnykPstWG+wr4/MZgRRX
         tGkHmZabgRO8vfKjdaDVrrPHSbze5+rZcYQoVRmnZYojh49jT4X9U+2ahcz67mmJqH9H
         K4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tMpUianf19D+nsixXmgtbf9O/UPhmVjtYTBARVwDcmo=;
        fh=rAvhwyUxkaRhNym+3k4mial7CQarRz/PNvybZTVEcoc=;
        b=F6eOfhmZ+QljcXkiPiiae1pE7CK+id3QbkOQ2Txp5ABfeQD0s/QRtTnafch+exaskn
         bfVDKp9SD4wSzRP0GC4HNlH6Lc4v/UrlhWpQNM8slZY5xqkqHq1d+1gm67/8BXbpUDc/
         rDibQ5kb/Qa8aLh7xhs1QM8F5xZF8wGSBvOZE5eyqLxkpwhNo1ThwK/HQSGIyhnIkiar
         INS545QfgmZXhKdDG8SiENQk04983aiNLx2Drm1nU6g/pjo99aJDwC2M1gnEWqXpIQrF
         z+KCQtJsD208QxXiHxroP67rWNfUuMUGt8SG5HpcbK9DeB2SemInFFQa5AQkKxEbDRyJ
         tGaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785950966; x=1786555766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tMpUianf19D+nsixXmgtbf9O/UPhmVjtYTBARVwDcmo=;
        b=MW9Y//cNe69N12vMoJQJDxyQU0uA88ZrDaNt1hoOxM0K5N+hJik54IB10penx6EMRF
         gjRCBJucuWfNn7pc2iMKHWXZNxQhiF7n7BEBR+3DmESabQIMoA0QbNr55j8R0PmwOT8F
         QP8YSdhZshFRRw3wqTNZxU4c20//kMxnCkXmeYOkw2PEifY+73YSaXTMXzvQnuUS4OwX
         oDGDk58Dwdek6+wE+X4BvWG8rI1lkogiIASfvssMobRXwfhScFUf+ZijdkP60sfrF5qs
         +xrZ5MqxJYnlwW0HrwpVmaxuIEHjJBazCITtdcKfs0y3a91H4NbLq9K67P9vTgqs4QwA
         ihuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785950966; x=1786555766;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tMpUianf19D+nsixXmgtbf9O/UPhmVjtYTBARVwDcmo=;
        b=jJA2ZONBC44uYRfcWDXLt8Q4XAoiSChHvpKYYSOxkyE6qiW6UJSXfzvA7l77CRVOuu
         nD73SMQZgyG40lbxapvfYxNCIOH+gfDHp5MkN+5PfX1daubIOHFXKXI4nP7ncgx//8Sk
         N3hDoMJqSlJfED5rpz+tOlzBpOmE9Lf8zHGamZZdzMjHBn0tJO33sWJMmbTFJr/BMEgm
         VXeNXbLlDnM9j/sMB0KAhrB0zPML8t+BTw8Ow8ol4pcfTMolRvGMMJpm0aS6QVO6XaKz
         dSZyioPtPHgC3rBP9zw2I1Xj78/ODWOszJ2dOiobnYrF2xenFQYFVUz0qLAgy8MQ0Uls
         nfeg==
X-Forwarded-Encrypted: i=1; AHgh+Rpj+ITH7GVkl7t3BsnpuiDjdNcpJHJ+2gjZPdGRjDiJQe5WOU3aiNP9FcDTIMPj8Z4pGNyHiLjCNMuDYb+DPy5PwXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zc2xQHJNjSeZdC4EiaFDJ7TqmxLKZV7DB7WdUxA2dwvcS99h
	NAlZOzF0GOJbk3SMBL4wAcTbwTb9ykMcSx+LwJ3mnrwO/4ku7x4fXLahEgL2suaIpyz8ONuDn6/
	ziybIbqs4IQ+HzajMi1uNovfIKeCQYws=
X-Gm-Gg: AR+sD12RirI0vvxAwZ/Djry/mgw6t/pMvmzDFCCNVSVm4R/wDqxCb1weqZWJycMHJKu
	dpO5fXhTgQoe5463ygdTUqFuyYXjSPOsmnXLgYCBn8Gg+S8w3oHaQ5Xc+26Ga53pnieKCf2aF0B
	fxcpuERudpvu7o+uMqIxtyKGHYeTMOWInYV37eoVDfcV/U+WLQ9ibXAExKhtuPQKEBC8eEwiu12
	UePm55/A1+OtW0ZiUt6mT/E9q03IeiJfJMWOQT8zKXZy26TqasY0LOSSxcR+BFO60HHEn18UDQg
	LIYEWiI1/zXJgKSmCvHY27bCqNkmj+x31qOVbiYU3XxOcCPWtr7qr67QezV1oFS4IJhz7+47nck
	y7BceHFKDDhPUsY4oEt29xCfS1Q==
X-Received: by 2002:a05:6a00:3c8a:b0:84e:46d:23a6 with SMTP id
 d2e1a72fcca58-84f41d70adbmr810610b3a.18.1785950966087; Wed, 05 Aug 2026
 10:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805131904.1127416-1-sumanthk@linux.ibm.com> <anNTRb2aGsvY8_Rf@redhat.com>
In-Reply-To: <anNTRb2aGsvY8_Rf@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Aug 2026 10:29:13 -0700
X-Gm-Features: AUfX_mzpvj_MsMBKvKw2Y4p38yD3bfk3uIgkbl269uU7hIXf_ymSEc7JVRXPSis
Message-ID: <CAEf4BzZum6AjU1G_hazOwW1ECNzHm=2vLVUGOjD-tSYqr-HRuA@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Skip breakpoint installation on non executable vmas
To: Oleg Nesterov <oleg@redhat.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 8:14=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 08/05, Sumanth Korikkar wrote:
> >
> > bpftrace  -e 'usdt:./testprogs/usdt_semaphore_test:tracetest:testprobe =
{
> > printf("%s\n", str(arg1) ); exit(); }'
>

does bpftrace care if USDT semaphore is set to 1 or 2, it shouldn't.
As long as detaching decrements it from 2 back to zero we should be
fine. Is that what's happening? If so, is there really a problem
needing to be fixed?

> I am hoping that Andrii and Jiri (cc'ed) can take a look, I know nothing
> about usdt... And TBH, I don't even know what RELRO is ;)
>
> Let me ask a couple of questions for now.
>
> > expects a semaphore increment of 1, but semaphore gets double increment=
ed
> >
> > Test program:
> > https://github.com/bpftrace/bpftrace/blob/master/tests/testprogs/usdt_s=
emaphore_test.c
>
> Perhaps you can provide the test-case which I could compile on my
> machine without libbpf-usdt/usdt.h?
>
> And can you explain what the bpftrace cmd above actually does? I mean,
> where does it put the uprobe? I guess the ref_ctr_offset argument of
> uprobe_register() refers to USDT_DEFINE_SEMA() in that test-case...
>
> > Reason: .text mapping and RELRO mapping resolve to the same page aligne=
d
> > file offset 0
> > 01000000-01001000 r-xp 00000000 5e:01 usdt_semaphore_test (.text)
> > 01001000-01002000 r--p 00000000 5e:01 usdt_semaphore_test (RELRO)
> > 01002000-01003000 rw-p 00001000 5e:01 usdt_semaphore_test (semaphore)
> >
> > valid_vma() currently accepts both mappings (which contains executable
> > text and RELRO mapping) during uprobe registration, since both have
> > VM_MAYEXEC set. This causes register_for_each_vma() to call
> > install_breakpoint() twice for the same underlying uprobe offset in the
> > process.  This means, update_ref_ctr() is called twice for the same
> > process, so a usdt semaphore is incremented from 0 to 2.
>
> So, 2 vmas map the same binary, install_breakpoint() is called twice.
> But, the 2nd install_breakpoint() -> ... -> uprobe_write() should see
> that the original insn was already replaced by int3, in this case
> verify_opcode() returns 0 and uprobe_write() should do nothing.
>
> And, if this uprobe was optimized before the 2nd install_breakpoint(),
> uprobe_write() won't be called.
>
> Hmm.

Even though it's the same file offset, it is mapped to two different
virtual addresses, so I think it should be two different memory pages
that will have two separate int3 instructions. I don't think there is
any contradiction or surprise, is there?

>
> > Installing a breakpoint for mapping without VM_EXEC and
> > updating usdt reference counter in that case is not useful.
> >
> > Skip non VM_EXEC mappings in install_breakpoint(). This fixes semaphore
> > double increment as shown in the above usecase.

You said that mapping is VM_MAYEXEC, which means that kernel allows to
re-mmap it as executable, if that happens, we will miss uprobe in that
location, so that's probably why breakpoint is installed for
VM_MAYEXEC.

Anyways, I'm just not sure whether there is a real issue we are
fixing, or it's just a proactive fix just in case. Can you elaborate?

> >
> > Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > ---
> >  kernel/events/uprobes.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 6300b216012c..9e0bbc3cf401 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -1155,6 +1155,9 @@ static int install_breakpoint(struct uprobe *upro=
be, struct vm_area_struct *vma,
> >       bool first_uprobe;
> >       int ret;
> >
> > +     if (!(vma->vm_flags & VM_EXEC))
> > +             return 0;
> > +
>
> Well, but then it makes more sense to change valid_vma() to nack the
> non VM_EXEC mappings ?
>
> Oleg.
>
