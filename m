Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD76D364E95
	for <linux-trace-kernel@vger.kernel.org>; Sun,  8 Feb 2026 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770565383; cv=pass; b=MJnlHRAOev8/L1A3lkCkA1RzSPVgjS24TkxSBEWoEWF8KlZXv6CQ62hwHAC8VXCyRB7PKPSQTCHTvE74Voj2K0SqvsCuQHFsdrEH14lncgPFJ6igxLGnu57n8m6eAqTjp13/sUqu3O+15HlVql5WaJrangyp/VBeA7xG7ywK1Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770565383; c=relaxed/simple;
	bh=Q+F6ZnbMmyxBOFD5itAiiyZCrJUukfh/u+OOWnGnTTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcxwJrNbhFAgKKWuupifcqp2TpLGhs/ypTzxWBuYgtNLg60pMXKPm0NlfNEYl1nZ8S/bvyGZq5frId1GNkVIGYzp2lkWHt5gpz1SHVC2A4nyhJcdQAL4uju2vmBXMfo6U4yTs6xI5tI4hjomFW3absZzPptEVX8OAL4dV+iSJTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsxbwyvw; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsxbwyvw"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b885e8c679bso290960866b.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 08 Feb 2026 07:43:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770565381; cv=none;
        d=google.com; s=arc-20240605;
        b=aQfkn9ax5lcFC+eaeM0iHs2/Ipsp0C3Sgh2brV5MgeO/WWJxg7DVG8QbVMguNZ+Qzm
         FR0mvr8cmsgdElmZ+5HZpwxFr+ZRgPK8nAZorD4FwZTntCHws4ArQEX5mI1mMSpMcbgs
         jnUywo+ZjxBH2UZDqP4GzFgUHW4xvEOuUQsNhWFw/DJMbDqz5Z1MNS6fkp2pDxPv2uzX
         twoFhxQhtwBwJt6FpqihXBbGfbP8GRUtwLGumScnnCFcznBE0xnfL/XD1IIwosKY/+jI
         rCf6TIomw5LE4YSOURQ2/gmCVAe+viKH/5LJMg5sdTfgPWKNXBG2WkbHjOeIqZ5YpvPp
         0gVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TcWGBefWkwyWiO9ZnBb+aZxNrdmsgmtsLf4aY+V/ddE=;
        fh=7RME5HbJvKfNhgOztjWoi1gqnhldRugPF+GlP8QIzxs=;
        b=bHFwAVR++Z8FpxcKQ6a75mPSqM74q0ZxNeHqK9BlE8gbtui7m36mZhGxR6Q39QDTZt
         Mt6scepSqe1a5GRci4nWVx2J7ZxfS/tjZ1NGEe3K+aiDn1s22KkCqBCU1j5SbXv68iqY
         W0jEgqWo5A566CSQInWOjn2kf8A4fN8VLYfAYlz7CQNjN1mdgymZRoSRxbPFeMLtl/3V
         Hi91z55i1NTaDwVKYWtnO8UoankwNvbQ/Dh9JwXsJG1mAo/TbOiFC9sJ2i1A9yNTc4JH
         xAJFpSxJFDojQNSErrwqFfW47RQjNBXTD7DBX1fyhbLIq/ZbL58k6NLPkXv7Yh4tzVAE
         J8sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770565381; x=1771170181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcWGBefWkwyWiO9ZnBb+aZxNrdmsgmtsLf4aY+V/ddE=;
        b=jsxbwyvw1rZv7Z+KWzMle6QnJgW+Y7TiHAAdU3vsEITGJMK2usWsMA7MsiriAXRyyK
         AbSa44oCD0p1yYS64iETL7xQ29Y4SW3x6a4iOPs/q2oT4qjw4LIUHzHbMfl15qthG4a0
         diiUYHE/q1bKxzSIGFKyixCczQ1rhUuy8lv8bgkSm4ttErC1qebxwoKuy0pdggws/uo0
         P8VBb/wZ6VwZ+pRw68vdSw8NBHMN5HaRzX5Sf6QjOsvUElgApanj7SSr25N6+wGPyyP7
         kS7TYTC2Cu3E8XqLJDicxD0mpIPKAAT9frko4eu+/7nOsc6+KsJbJdWJT0GJsz7wqW8+
         nzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770565381; x=1771170181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TcWGBefWkwyWiO9ZnBb+aZxNrdmsgmtsLf4aY+V/ddE=;
        b=LFgM8ICn4L2eI9oVDk9x2+PlompFR7SgZ4OYsY+BsVub+VvZQXgw9FUgWjVvbTnIUn
         asn80EIcO1noYrJU5ip1IO3IxwVxkz3cOyKWM8ez2NjfUpQYSUjc8kP+13LtybIL2BOm
         LoXSyY4upSgp6j4zyca8BRqIMkRQEbg6T5jta2jDRIIQPrSuwBKrcpx964wX1Xl7loSX
         4ihssZgEON92gVzsj9XJSCSV2UFOTzIoo0eawvcF1tQjf0X1uyRkTKASsYHxGJYwqxeQ
         NUsHtpa37FEYvj7+53WVVSN1xmBF7XFsf1iQ8+WQxyjXbDXfTT+G9nzN5+eIf+TrQt6C
         FqnA==
X-Forwarded-Encrypted: i=1; AJvYcCVOyM9t2wanlEgR9z2Hn4oDmLDvGAVfianD5FUsAnalnkdTSNWn+hEizKmuEdajHo51C+UvHCIZXQNHqdeWIj2rMj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXJ0W/eSqFc6lFbsy3M9AAI8MtSNeGmjVhhkK6qsPzs/iA8oCl
	N0pJTBcdDJz4kFptl5p3EMzPAorl/EHMuFxZlLmC846AN/YdeQuSF1Edz6hYFDMWBuCL2mdSFk4
	eiOWqAH2TX38Zlzud32pxIAXi3rvQBB0=
X-Gm-Gg: AZuq6aKgND9aJ1wEGCkxy6ccgBwrpqbbeb10qk9KQx853hJfBA6A46xy0TunRhrg0Ki
	KIKh/yaaKdY0vSvcrhmdaUEXckIltOZS56LvusyNqMMLIbfRD9oGjx87+rt2ce7tI1PuXpsfaMg
	qF2bkN99SPetXWJxjhi/klndPg2LtLXUaap8iIAf482WqSCxeTIjceL37X5/SnspoBozRZ29MXr
	6yw3Af41g+wl9eo/R9VbEmyE9SjHCxMcethyh8y8YVtGnBB4dzE0cEd94/Ae3Xzn+LPoytX
X-Received: by 2002:a17:906:2099:b0:b8f:ad6:db92 with SMTP id
 a640c23a62f3a-b8f0ad71129mr167531866b.3.1770565381035; Sun, 08 Feb 2026
 07:43:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
 <20260202111548.3555306-3-dolinux.peng@gmail.com> <20260202111249.649ac338@gandalf.local.home>
 <CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
 <CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com>
 <20260203101707.52965eb0@gandalf.local.home> <CAADnVQKXMzTsbrD8j0spJETXL77x=r30fEiPQLCiNr=XWtgB+Q@mail.gmail.com>
 <CAErzpmu9mNXTOw-WwkSGEdvmJY2VjyUbGWZD=5s6kXNRE_YkJQ@mail.gmail.com>
 <20260205130459.0ff532f3@robin> <CAErzpmsajhJ45TkPx_TPwAPwN1fxO0cNYFTKFgLaosiPMo9wew@mail.gmail.com>
 <20260208102742.2169de7a@robin>
In-Reply-To: <20260208102742.2169de7a@robin>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sun, 8 Feb 2026 23:42:50 +0800
X-Gm-Features: AZwV_Qii4imxiiZs7X2NlajFjW5GfNHC0Ibaxr6tql3hlmmhExTi6pc6g9KtnNg
Message-ID: <CAErzpmu3XGE=LKQjGgb_538BV=hytkv4rsE_M2r6ADEkB_Ckkw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Donglin Peng <pengdonglin@xiaomi.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 11:27=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sun, 8 Feb 2026 21:07:37 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
> > Hi Steve,
> >
> > I noticed that trace-cmd 3.4 introduced a new feature:
> >
> > - Add support for showing parent functions in function graph
> >
> >   If the "funcgraph-retaddr" option is set during function graph tracin=
g,
> >   the parent functions will now be displayed:
> >
> >   preempt_count_add(val=3D65536); /* <-irq_enter_rcu */ (ret=3D0x10001)
> >
> > However, it currently only prints the caller's entry point. I suggest
> > enhancing this to include the **offset within the caller** as well. Thi=
s
> > would allow tools like `faddr2line` to locate the exact call site accur=
ately.
>
> Yeah, it makes sense to always show the offset of where it was called.
> We can add that for 3.4.1.

Thanks, I can send a patch to implement it.

>
> >
> > I implemented a tool named FuncGraph[1] to convert function_graph
> > ftrace output into an interactive HTML file. It leverages fastfaddr2lin=
e
> > to map return addresses (e.g., __sys_bpf+0x51/0x500) to their
> > corresponding call sites, such as: __sys_bpfat kernel/bpf/syscall.c:611=
5.
> >
> > What do you think?
>
> Sounds cool. Is this the vibe coding thing you talked about on Linked-In?

Yes. The project repository includes a sample HTML file (`sample.html`)
demonstrating the functionality =E2=80=94 feel free to try it out.

I hope future versions of `trace-cmd` or `Kernelshark` could incorporate
similar features to enhance trace analysis workflows.

>
> -- Steve
>
> >
> > Thanks,
> > Donglin
> >
> > [1] https://github.com/pengdonglin137/FuncGraph
> >
> > >
> > > -- Steve
> > >
> > >
> > >
> > > [1] https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/tag/=
?h=3Dtrace-cmd-v3.4
>
