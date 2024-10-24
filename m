Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B441167D80
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729812797; cv=none; b=uS63vl5DxsjRQ2JJmgFvJLB4haGNC5LeEae7GTBO253nx0Jx7cjOvVFn+yk6gZOjXQsSEcQm0AAsPTaAaztT1JWOVJl5Y2TvEwPWykgl9SkuL81uBLXuNGoi3H/0wEzFlqrzg7CFWsymX5QqTYwoqYsdnBhnpiqji3AiSZXSTKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729812797; c=relaxed/simple;
	bh=vmsuMNCTMsnSpAb3EIoplVmMWZi2viZaThCOjLNdh50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s18K2521l+Ypb8iwV6EcSSLFUtdAzFi65BCyyrr/rwCrn2jDEJc4GvrhBYmVPDlz1mXcKmyBfgsypHNo1HzPY7aPBDrhV78JvL+TThk1Y/o6PQ1W/YBb2Nwhkn7SRJkUZdatYXIpqL+j0po6A/ClOCQF+5RfWyhCRftC7/Q9OPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tfdcDEUq; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfdcDEUq"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460a8d1a9b7so73221cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729812794; x=1730417594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmsuMNCTMsnSpAb3EIoplVmMWZi2viZaThCOjLNdh50=;
        b=tfdcDEUq2adZ82IcpiIp3q/1BtXOwFrLGvMGNmW2hecD8bmVONbp5sPneD7xuPU4oO
         yRx0Oqw3sTGIef+wmGSMtat9V7PBEy2IBSpn/4peEElJrwwuzbH2cDa/k6Tg85ORD99L
         Wcc2EyhZ577TNqfG4Di5YC0YsoP5VcFVQPtIN4SS+3oENY3hHffhsrKJPZ+HWTFyf2uy
         kGhgPDOH+GTJIKtjzpI9ftE8bBY7dy9gmbrfZoSi7U84aqvB3M9DeSMMK64eviBn2QQ9
         hhFLuBGyTUTjI6iZa7YzywplUV5gMilkemZe0xnfgKoKWIfkFgOUWauPhtymVL3vwdCh
         5FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729812794; x=1730417594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmsuMNCTMsnSpAb3EIoplVmMWZi2viZaThCOjLNdh50=;
        b=PhdNRJZwQiDGtHxzQ52tNCaVGjhrNdWG1U74qMbIpSqN78/tPz97Y7r8G7wUMc7+js
         OSdem1NkJi8RNmpsmNsqUisuUUdZo9Dew/XRkrKQtC1u2jRhEXrpW+G4axhXq84iT5jy
         CMXC8e2pB72BX4Ayi6IkqO6Sjs9Zra5xUf0PzYRdAnv6+U1zdar7AQW9Bi94pHZ1Trne
         k/h50Aj0yC83iQBCI47YMh7F5YjfoPEd0eMIU6dfzIiyLWLTsRIr0LpCV/KS5UprdYrY
         SQtvemA85BdVB6F/Om6x4i6wlgOSCsR9bdWxuH+JHp66IjiXv7Dn1srHSYByg5Dxxnfo
         +nFw==
X-Forwarded-Encrypted: i=1; AJvYcCXLzHI3OYmVAd1Sqz2vhAdVBtV3GKOZWQGLgPuyMxLscRF1eyGWgUAVbKEnRaCSVuPzNh6ddgxCztqBImJRA9SMjLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhzMTOp46iAV7VqDQVIWQ43RIyxujhvAsEv1xb4GFJdSQDvlPV
	Y6iFsaRkGk1ge22oGbnfq5HhCaa0Xff/HcbiXV9lNehW0vUuTH7vQnu2NBLaE/qkVkBgiLby6+M
	ZMxibj30z8JLKSQYZkym4H1LqOQJzrP3EgKOz
X-Google-Smtp-Source: AGHT+IEW2JMaWRvxKfmcu8sr08V97Ij3HhW3jaebS9MGMkSOQxIgxXNcePp71xFUudebLmPyfGSMJ3WTInWv/8QJhg8=
X-Received: by 2002:a05:622a:548e:b0:460:8444:d017 with SMTP id
 d75a77b69052e-461306e214bmr542231cf.27.1729812794080; Thu, 24 Oct 2024
 16:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-2-andrii@kernel.org>
 <20241023201031.GF11151@noisy.programming.kicks-ass.net> <CAJuCfpFMhoCmqGJMU2uc4JHmk9zh88JzhZAeSz3DgvXEh+u+_g@mail.gmail.com>
 <20241024095659.GD9767@noisy.programming.kicks-ass.net> <CAJuCfpGxu=z-2Wsf41-m4MQ6t7DjfiiWXD408BW8SjTfx0NGTg@mail.gmail.com>
 <CAJuCfpGYzG+3aLjobsXcTSoo9Jo9MCYA_QcROPyLRKEeVHkLGA@mail.gmail.com> <CAEf4Bzbf_2tJL1ogZegy2sD=WbNmdKHXuXCXtAALGYuWYgyEEw@mail.gmail.com>
In-Reply-To: <CAEf4Bzbf_2tJL1ogZegy2sD=WbNmdKHXuXCXtAALGYuWYgyEEw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 24 Oct 2024 16:33:01 -0700
Message-ID: <CAJuCfpFJG8MS=LMC2saYYRPGv+xs+UXkrPWD9_Eo1VqY=7v1ow@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 1/4] mm: introduce mmap_lock_speculation_{start|end}
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, mjguzik@gmail.com, 
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 4:20=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Oct 24, 2024 at 2:04=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Thu, Oct 24, 2024 at 9:28=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Thu, Oct 24, 2024 at 2:57=E2=80=AFAM Peter Zijlstra <peterz@infrad=
ead.org> wrote:
> > > >
> > > > On Wed, Oct 23, 2024 at 03:17:01PM -0700, Suren Baghdasaryan wrote:
> > > >
> > > > > > Or better yet, just use seqcount...
> > > > >
> > > > > Yeah, with these changes it does look a lot like seqcount now...
> > > > > I can take another stab at rewriting this using seqcount_t but on=
e
> > > > > issue that Jann was concerned about is the counter being int vs l=
ong.
> > > > > seqcount_t uses unsigned, so I'm not sure how to address that if =
I
> > > > > were to use seqcount_t. Any suggestions how to address that befor=
e I
> > > > > move forward with a rewrite?
> > > >
> > > > So if that issue is real, it is not specific to this case. Specific=
ally
> > > > preemptible seqcount will be similarly affected. So we should proba=
bly
> > > > address that in the seqcount implementation.
> > >
> > > Sounds good. Let me try rewriting this patch using seqcount_t and I'l=
l
> > > work with Jann on a separate patch to change seqcount_t.
> > > Thanks for the feedback!
> >
> > I posted the patchset to convert mm_lock_seq into seqcount_t and to
> > add speculative functions at
> > https://lore.kernel.org/all/20241024205231.1944747-1-surenb@google.com/=
.
>
> Thanks, Suren! Hopefully it can land soon!

Would incorporating them into your patchset speed things up? If so,
feel free to include them into your series.
The only required change in your other patches is the renaming of
mmap_lock_speculation_start() to mmap_lock_speculation_begin().

>
> >
> > >
> > > >
