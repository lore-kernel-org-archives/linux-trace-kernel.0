Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10387258B
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwZ52g5o"
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CD8D6
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Oct 2023 01:20:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so12341a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Oct 2023 01:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696839637; x=1697444437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWViv6BOk41de86zHjPam8Zdgu0i96xG1qhT5iaH3Ps=;
        b=DwZ52g5ohboKdPQ3gy9qj9L/+v7K5D1Ogr+abh2/iNA3kWyA9MTtSEniaCSE5W7Ifq
         4h0MhKym7u4DBZvaHFKGRsT3V2qsMorT45lYR1U1LsGJKteUe5hyMQkiwGg1AjXKxIsl
         dPN8OYXPTlqtepdeK8VJIycTD7517v2Qb8UaboRlgAXlfY+Lt2tnNniNFE36s/5qcDMV
         be+xGhEsPJBQmy64r2kjxBOPD5d2mEDzSRqrThbxler/yLk25VhDSzHmXnusP/IakGt7
         lLN0YW84arXIk14o+6MImpa2c1IhRQ18YaMm13D/C9HNP4xNG6L1nhey0+tVOJzDsN8X
         j67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696839637; x=1697444437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWViv6BOk41de86zHjPam8Zdgu0i96xG1qhT5iaH3Ps=;
        b=QOGgaylmu/yqUBgPTsJxPDK01wyphrpQbiMDuXPVVUyyfkpGL8axkTpIMsz1W9ye9N
         OQdDZVwNdTe/OfG58E1Bygw6KG0Ii/sToYlw4WiBDLNz4IoX03vCEERN+6moeGC4VV9o
         DMUpucVn3NLHBi483OtlQZmu9dGiG1FuSbzzVXjFbfY6safn9je5PuViimhdeEJ11qa3
         I9Am2U4u2oxBJXHcPaHLyRO8QXloxhMY7Maoz3suuNLMqYoVOFDMlVlOGegVzUti548O
         ErfAGEtRrYht0XGM665iRHM0Gfb02bxzGgj3FheCJr0xQefcNHNK6u610Xc0P12hnm1x
         ly7Q==
X-Gm-Message-State: AOJu0YyZ3R3iL6kKon8pPb+B0sTuPWv0R4JyVrgnnjSwBJ26urbU8B25
	WI85wvX13Mk/83gHGWbC6JkCM2rVYyw0hXQm1KIJnw==
X-Google-Smtp-Source: AGHT+IH0V8NS2cVB9NZEj3VMCocK2gICCvlMXNwBh20rtBdFEA7r8dCh0cjFM+eUOw8TJ+GaIC5YbUP3Z5a6HMdEiVA=
X-Received: by 2002:a05:6402:d4b:b0:53a:ff83:6123 with SMTP id
 ec11-20020a0564020d4b00b0053aff836123mr198316edb.3.1696839636925; Mon, 09 Oct
 2023 01:20:36 -0700 (PDT)
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
 <CANn89iJCTgWTu0mzwj-8_-HiWm4uErY=VASDHoYaod9Nq-ayPA@mail.gmail.com> <508b33f7-3dc0-4536-21f6-4a5e7ade2b5c@linux.dev>
In-Reply-To: <508b33f7-3dc0-4536-21f6-4a5e7ade2b5c@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Oct 2023 10:20:25 +0200
Message-ID: <CANn89i+r-pQGpen1mUhybmj+6ybhxSsuoaB07NFzOWyHUMFDNw@mail.gmail.com>
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
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 10:14=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev> w=
rote:
>
>
> On 2023/10/9 15:53, Eric Dumazet wrote:
> > On Mon, Oct 9, 2023 at 5:07=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev=
> wrote:
> >
> >> 'this_cpu_read + this_cpu_write' and 'pr_info + this_cpu_inc' will mak=
e
> >> the trace work well.
> >>
> >> They all have 'pop' instructions in them. This may be the key to makin=
g
> >> the trace work well.
> >>
> >> Hi all,
> >>
> >> I need your help on percpu and ftrace.
> >>
> > I do not think you made sure netdev_core_stats_inc() was never inlined.
> >
> > Adding more code in it is simply changing how the compiler decides to
> > inline or not.
>
>
> Yes, you are right. It needs to add the 'noinline' prefix. The
> disassembly code will have 'pop'
>
> instruction.
>

The function was fine, you do not need anything like push or pop.

The only needed stuff was the call __fentry__.

The fact that the function was inlined for some invocations was the
issue, because the trace point
is only planted in the out of line function.
