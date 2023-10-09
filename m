Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD40168A8
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RODB1RLC"
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCB3F0
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:30:31 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so10351a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696843829; x=1697448629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLyudqSMOhmAh3CWo49NCC+vFjpCOk99m8pKFm0PjdI=;
        b=RODB1RLCy4JZ8rAIylWofuDDGtig5YVjofIrBdwlqD5FlNpGeV0sjfk086F3+37zon
         vSF8RHoNQ1Fml5a/io5tooghYoMuLRqejfMI2GviVQgJ8XF36oJKdh0C2J4cU32hi9yD
         U2NPB0E0Mx7c32hwul+sb7HLtEmmvSj7xkywnK4KDaw6KU1+H5UTmDwOM1b8o6UgXSfh
         CCFOq5EhBjZrRknIkvmBme3K9iwC3FFSEkheAOVdMPfZF3CvnFL3puaQ028yiTVdjp1b
         EaAlHLzBNak7Uk0FfxpeSEgbmFAHetkZzWdR1VhPXSYnO3S9Rl03kyiQfzFH99/pr96h
         cJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696843829; x=1697448629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLyudqSMOhmAh3CWo49NCC+vFjpCOk99m8pKFm0PjdI=;
        b=TzmmVUpc+P4O/BGse9WtAAL+E2jchyfnDWp4EnCL9A7q7KJzVdlX/PRSzXMJdz6Bnd
         7TLbYfBAYv/ApAJjszQFdIWhWW/D+gub/7n7v7pmU/ssFUKa2t7r63WMWvJUvgERGnxH
         qDjeezI+4J6g68ZzGh6SJv501RkpirZZe4wdkJEN9LeOoZ9S4G5x5KkW9cEkouYk5IKQ
         yYEWmBFByV/tQXRnjrwYxgozaLPLICKKveSaj+BGh3qvF7jjv+nQYQ9VsjEI+AngwWwC
         vbkx/Utct9JG3docxEiJqGCNuF/dyqS4EtFrXKefjZBjsDm3gTdO4FVQvtCt/H22r3aA
         FvFw==
X-Gm-Message-State: AOJu0YyYuqRlzP4vlJlbZqzpm+gYGkpbPIeTuaN9KiepGuZpjofmfgEY
	HlvjAecHZj/tMjaSqp0iguoQg7ERqMtmNgIN5JdF2w==
X-Google-Smtp-Source: AGHT+IH7RuJLlU9VtC9SLyybEZiZajTmMC0WMqzGd7Km+auMypxpw0+MwbkeqMcolnOdB0KiX2W1XHJoOY0T3sx9t0k=
X-Received: by 2002:a50:8d5a:0:b0:538:2941:ad10 with SMTP id
 t26-20020a508d5a000000b005382941ad10mr358835edt.5.1696843829278; Mon, 09 Oct
 2023 02:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231007050621.1706331-1-yajun.deng@linux.dev>
 <CANn89iL-zUw1FqjYRSC7BGB0hfQ5uKpJzUba3YFd--c=GdOoGg@mail.gmail.com>
 <917708b5-cb86-f233-e878-9233c4e6c707@linux.dev> <CANn89i+navyRe8-AV=ehM3qFce2hmnOEKBqvK5Xnev7KTaS5Lg@mail.gmail.com>
 <a53a3ff6-8c66-07c4-0163-e582d88843dd@linux.dev> <CANn89i+u5dXdYm_0_LwhXg5Nw+gHXx+nPUmbYhvT=k9P4+9JRQ@mail.gmail.com>
 <9f4fb613-d63f-9b86-fe92-11bf4dfb7275@linux.dev> <CANn89iK7bvQtGD=p+fHaWiiaNn=u8vWrt0YQ26pGQY=kZTdfJw@mail.gmail.com>
 <4a747fda-2bb9-4231-66d6-31306184eec2@linux.dev> <814b5598-5284-9558-8f56-12a6f7a67187@linux.dev>
 <CANn89iJCTgWTu0mzwj-8_-HiWm4uErY=VASDHoYaod9Nq-ayPA@mail.gmail.com>
 <508b33f7-3dc0-4536-21f6-4a5e7ade2b5c@linux.dev> <CANn89i+r-pQGpen1mUhybmj+6ybhxSsuoaB07NFzOWyHUMFDNw@mail.gmail.com>
 <296ca17d-cff0-2d19-f620-eedab004ddde@linux.dev>
In-Reply-To: <296ca17d-cff0-2d19-f620-eedab004ddde@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Oct 2023 11:30:15 +0200
Message-ID: <CANn89iL=W3fyuH_KawfhKvLyw2Cw=qhHbEZtbKgQEYhHJChy3Q@mail.gmail.com>
Subject: Re: [PATCH net-next v7] net/core: Introduce netdev_core_stats_inc()
To: Yajun Deng <yajun.deng@linux.dev>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, dennis@kernel.org, tj@kernel.org, 
	cl@linux.com, mark.rutland@arm.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 10:36=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev> w=
rote:
>
>
> On 2023/10/9 16:20, Eric Dumazet wrote:
> > On Mon, Oct 9, 2023 at 10:14=E2=80=AFAM Yajun Deng <yajun.deng@linux.de=
v> wrote:
> >>
> >> On 2023/10/9 15:53, Eric Dumazet wrote:
> >>> On Mon, Oct 9, 2023 at 5:07=E2=80=AFAM Yajun Deng <yajun.deng@linux.d=
ev> wrote:
> >>>
> >>>> 'this_cpu_read + this_cpu_write' and 'pr_info + this_cpu_inc' will m=
ake
> >>>> the trace work well.
> >>>>
> >>>> They all have 'pop' instructions in them. This may be the key to mak=
ing
> >>>> the trace work well.
> >>>>
> >>>> Hi all,
> >>>>
> >>>> I need your help on percpu and ftrace.
> >>>>
> >>> I do not think you made sure netdev_core_stats_inc() was never inline=
d.
> >>>
> >>> Adding more code in it is simply changing how the compiler decides to
> >>> inline or not.
> >>
> >> Yes, you are right. It needs to add the 'noinline' prefix. The
> >> disassembly code will have 'pop'
> >>
> >> instruction.
> >>
> > The function was fine, you do not need anything like push or pop.
> >
> > The only needed stuff was the call __fentry__.
> >
> > The fact that the function was inlined for some invocations was the
> > issue, because the trace point
> > is only planted in the out of line function.
>
>
> But somehow the following code isn't inline? They didn't need to add the
> 'noinline' prefix.
>
> +               field =3D (unsigned long *)((void *)this_cpu_ptr(p) + off=
set);
> +               WRITE_ONCE(*field, READ_ONCE(*field) + 1);
>
> Or
> +               (*(unsigned long *)((void *)this_cpu_ptr(p) + offset))++;
>

I think you are very confused.

You only want to trace netdev_core_stats_inc() entry point, not
arbitrary pieces of it.
