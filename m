Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B87B1E3DE8
	for <linux-trace-kernel@vger.kernel.org>; Sat, 15 Nov 2025 02:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172757; cv=none; b=rlRahe/LCzICBngcb3WQkFSgsY8cY3WUhy7RTTmlHIT4E5+E+HDo4LwaXR4ffL6LE4RJPEdB54ubj7FTKTblYe6dvTtxMBf8qiL8RarMEAfbIoxZie2NB0vQbSugCGwLOmgl5TghaDpd52d4HAjtPrO2Z+es84cq48NeqoDdsUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172757; c=relaxed/simple;
	bh=3PXnM2NF6vKZDHestwDEuZTYUPHPKyZU7tavshGG4x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFpgLFpo1hpUhu0DAxZHt7vvroONFgpTeBl2gWW6lC/kirvwpiK18K7OxpR6XrB0qUzbW0rmKGWmbuMsSs882c2d5srJKWwNUp+kFiCo+ckEjTY0DrGyTKB0VUavIZ4PbgaQGfv6/hsttnqlxIe3dco/EO2hTTHdpMl2KDonKoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOiiU36D; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOiiU36D"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-7815092cd0bso25804777b3.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 18:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763172755; x=1763777555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9Qnvzwy30obfyYrc0KVi/oZN5LmGMAHEChanTy19Ac=;
        b=kOiiU36DTJsMUShh1uWPgCPzgy4lxVkLBsaQ+MfMtYbKBwQMSIQMkhplwZtxrFUl0A
         6sKYowtAhYgMGzim5xtF+4aQliRnxCZoDFsJBhckRB+lW6QJKk6jSp/+jYSchDV90avh
         D0ryhtCcvmg8Smuw+eALSXJ5k+U96U6LqN+7UsrTd7HgoyOj6+ZV6OV81G75w+Q8eBTm
         0vqwpKtNRrSincMXXz0IvEuB0kJ80qn5QYGyJE3X3msRt8/cfCjltFLdr3f1r0s/Href
         FlK2xRnE30CYetx85D4uoPEmlQz1XqZpHHl5lJ3kjNSJTaGyer4Wj/Hl8pp6XVdceoAR
         SuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763172755; x=1763777555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o9Qnvzwy30obfyYrc0KVi/oZN5LmGMAHEChanTy19Ac=;
        b=v3+OHFBM6HmNtDCmlexyQaxE22R11AqWzsQuDqcv2z5AsYd+1rKKP1fLVxpxhCSbZR
         uJaww4MPOTNju6eFtIwVfrwnCLXl0t98nThN1jXtgmEmH6GwsHH80xGGnJ3VBgU0o1nO
         O0j7ymfeL7/RQFEhfDdB04mOhTJYSK234Gh+4Tck+c1ARmEFYXKlicEMuR/1A7ahD+w2
         zO/lHfXZOgZv7amaSEcthaAj3Fi3YIq8NghzBcWeC1Xd1pgpRrOixh7aNSn1bg4wjU+n
         CUFeOWGYGhsuG/jABA/s73VL7gKYtCCkRi0oH0c0zHG88r7WKN2miaEiQZGtgoaTFCHH
         BGPA==
X-Forwarded-Encrypted: i=1; AJvYcCVMGmaDUS9g4GhoHKV8px61EkN6nInfdHm9EA1/fDB1Q7yOUj4x3VFgLONztUezGvPRp2NMfOjKMGq1az9uAJdjelg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHSDokF4fnX/kERUKvw0yneXrPTM48xoJYpL5Ak4pAnRTG7T70
	9r7ruYYwI1+hhlDdXTRGsOAFBeCrlQPjDMeS0ErIcKJXp+I1DHJmwq6TdJ85bK+IH/b8S/Xecl/
	HQYaDjZ9FG5y+nACM5m8+pBnaycVbO3k=
X-Gm-Gg: ASbGncvffqJTSHqKJOfsxVI1kTxoO1q9x+qScX7bR+/u8nrBZfTW9L0GjNN8mB82Iy+
	z7v0eWsX9PHeaCl/aMFJqVLGn8I0N9rxe2s4medihPfAQ9wGpCI7DBQOUuBs62Znfz86QCH1lxG
	juocujMXUQ8RajzxnkARfGQ8yirAfAoQuqIB4aiwhyjdtRM/ea+Jz3VYpxJgKVdg0F0giaaYsbl
	idoiVwovljGz/nRQhtNtI4ZN5MfJYgMBwORUQjrUlWLvb60uQzTqv1X9/qrN3BPivBu7d8=
X-Google-Smtp-Source: AGHT+IE0EjMBlj9fKLLl8YcYf2yaXpwv5o6ojXHZRKNeRCq/poWUekbkzNnqg7+1kPvc+2go9XKMhc5o2Efu9aVIVtQ=
X-Received: by 2002:a81:fb0a:0:b0:783:7b01:32fc with SMTP id
 00721157ae682-78929e2b18amr63662337b3.18.1763172755260; Fri, 14 Nov 2025
 18:12:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
 <20251114092450.172024-3-dongml2@chinatelecom.cn> <20251114113924.723f6fde@gandalf.local.home>
In-Reply-To: <20251114113924.723f6fde@gandalf.local.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 15 Nov 2025 10:12:24 +0800
X-Gm-Features: AWmQ_bl1sMdavc9XzdeKOoyyGPqNi20ltUDbJWwlSEkAyk-YWoghYmbZTUQzbIk
Message-ID: <CADxym3b8+f2Gg-2RiK++9+D8yQ7yb44VQPnuHh2uS-CDRJjzEQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 2/7] x86/ftrace: implement DYNAMIC_FTRACE_WITH_JMP
To: Steven Rostedt <rostedt@goodmis.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org, 
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 12:39=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Fri, 14 Nov 2025 17:24:45 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > --- a/arch/x86/kernel/ftrace_64.S
> > +++ b/arch/x86/kernel/ftrace_64.S
> > @@ -285,8 +285,18 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOB=
AL)
> >       ANNOTATE_NOENDBR
> >       RET
> >
> > +1:
> > +     testb   $1, %al
> > +     jz      2f
> > +     andq $0xfffffffffffffffe, %rax
> > +     movq %rax, MCOUNT_REG_SIZE+8(%rsp)
> > +     restore_mcount_regs
> > +     /* Restore flags */
> > +     popfq
> > +     RET
> > +
> >       /* Swap the flags with orig_rax */
> > -1:   movq MCOUNT_REG_SIZE(%rsp), %rdi
> > +2:   movq MCOUNT_REG_SIZE(%rsp), %rdi
> >       movq %rdi, MCOUNT_REG_SIZE-8(%rsp)
> >       movq %rax, MCOUNT_REG_SIZE(%rsp)
> >
>
> So in this case we have:
>
>  original_caller:
>  call foo -> foo:
>              call fentry -> fentry:
>                             [do ftrace callbacks ]
>                             move tramp_addr to stack
>                             RET -> tramp_addr
>                                             tramp_addr:
>                                             [..]
>                                             call foo_body -> foo_body:
>                                                              [..]
>                                                              RET -> back =
to tramp_addr
>                                             [..]
>                                             RET -> back to original_calle=
r

Nice flow chart, which I think we can put in the commit log.

>
> I guess that looks balanced.

Yes, it is balanced.

>
> -- Steve
>
>
