Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133A020DD2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573060; cv=none; b=mRlNxS7Kjw5aIib0ejd8FqWycLQ3h4GnPtEp45CMXD+IjGDBMTHsI4E223xFHaj10TRGfXVDzvVWXnWOVcNXl/IdI4y8R9E2okv+Yx2yftIy+HyT+q7Xaza88lByScBitjhbF3DjMbNe7ymCts4SaiT4fSISR6ZBHtZJcavBVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573060; c=relaxed/simple;
	bh=vv7FoLT/BiNcE50eI8e+RHka34AVKuvU0855Sv669wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAbcMHhhBv+/w6hzE346kyuR9I59wF5/Bxah+cJnoLxyod49w4iPxtzieAZiPAtGaOrUjoDl2sOLemrNenPGZDfi18NUmyRs8Nhw1H2eDp46rCbeUJSVdZedn+q4b/LlYPcI7eQ1kQnuRS+tdNxnXxJj/5VbKbcBr0jlJmxa9fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5C6+l6X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5C6+l6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728573058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BjA55q+krBtyKpu1UrvE4kCe5ypwnXLDju+HFDL51q8=;
	b=E5C6+l6X3TjHspEtAv1kzQWHB9AxEj6oPwSqhATqB5XvmfHcbqsxumws+i6HUb5mZ8p3Tl
	528AXmMX4lwYRmh0SB4luuXOudv1ZCaVfarlociawEddGfl57RuAzlrbqXABXewkfbElM8
	RtWGLNcnnLIiHcbOBMkrVqNe/BtEeJw=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-s4pEcf0eOJuYHoBMXh_RsA-1; Thu, 10 Oct 2024 11:10:57 -0400
X-MC-Unique: s4pEcf0eOJuYHoBMXh_RsA-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-28778791da6so1018401fac.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573056; x=1729177856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjA55q+krBtyKpu1UrvE4kCe5ypwnXLDju+HFDL51q8=;
        b=ouR2016KHRVlFIlgjqHiO2uFa5ELR6Q33LdjsZvkzPcB9l9sB+Ys6Xaz+PjJrRpNte
         mdw4v4IonHXdLpvnm05Mg/HfUemPjpgyt5l3p4MUCMqmSFW4tT/qIHIWsdXOpXWS7QEy
         +ZlSKnf2BRvSbrwBaEAl5r4sBtWH9wvMkFlGXfohMT0cpbu5EzebvQ7r4gjQFxx2buQn
         CPxst0Fiopxth5WzFEaBL9qCIGgbMcg8upJv2kWwyf9fDacfhT6ejEILP3rmaBu7iQVc
         yB4dHqGoEMFVDm3B+HPNnv7zXgxGT3tHpFYt+cJPjQk7iQ5KjQqsyDgf+Yytiexk7Z3l
         1auQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZWA1auuQGQ6EkFhM4OwOS2VHEAli6Lu7LrjVXe/UCSkhzIN3Em/SY2a7Y28z12RbChxqJg5wy3yLvOiBOlVHrQJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkLdN13FPrIm8xLOV+mlwTZoDxSSeUtwnb9Q9QOfUc+AP7Jj/C
	Y8X19tAmXqXDqDWYKiA6wDe8/IYRME6G4I0+OpMngd91w8bNSPapopf3GvBY+pc3X9o9IRnDkhx
	3WVahCITwG6uembVXJvV5LcTunKjNqxLGkrsINmLqV6D1i2RHTiucR5eZtdFi/GnTdy4Ebn0jOo
	MC4q/0EMbUn5kCKS7XRAcW7UbgnVjmb6GBUCJHv2jSNG2h
X-Received: by 2002:a05:6870:3327:b0:27c:52a1:f311 with SMTP id 586e51a60fabf-28834526ad2mr5129383fac.42.1728573056181;
        Thu, 10 Oct 2024 08:10:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIB7HsgwV6fuJpvkUQunBq6VUSoqHhvwFCo7dOAfNi+vwTrro16B+0BF1xEsApsHvhZ3NuLGuCIrJFJ3LYhAo=
X-Received: by 2002:a05:6870:3327:b0:27c:52a1:f311 with SMTP id
 586e51a60fabf-28834526ad2mr5129356fac.42.1728573055919; Thu, 10 Oct 2024
 08:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c355dc9ad23470098d6a8d0f31fbd702551c9ea8.1728552769.git.jstancek@redhat.com>
 <45c1f78d4f0e7f1b786443ffdd462d7670ec1634.1728552769.git.jstancek@redhat.com>
 <CAP4=nvRLgwu3y_c_m-SdPxaWm6rO_LVFKK98pkjFiLJ42LqhpQ@mail.gmail.com> <20241010105539.5b5aa41f@gandalf.local.home>
In-Reply-To: <20241010105539.5b5aa41f@gandalf.local.home>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 10 Oct 2024 17:10:37 +0200
Message-ID: <CAASaF6x2gddQ3UTQD+aXBfV3vXsX24kMMVNDigwC5wk_q4VABg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/rtla: fix collision with glibc sched_attr/sched_set_attr
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jforbes@redhat.com, ezulian@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 5:02=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 10 Oct 2024 14:25:11 +0200
> Tomas Glozar <tglozar@redhat.com> wrote:
>
> > > --- a/tools/tracing/rtla/src/utils.c
> > > +++ b/tools/tracing/rtla/src/utils.c
> > > @@ -229,7 +229,7 @@ long parse_ns_duration(char *val)
> > >
> > >  #define SCHED_DEADLINE         6
> > >
> > > -static inline int sched_setattr(pid_t pid, const struct sched_attr *=
attr,
> > > +static inline int rtla_sched_setattr(pid_t pid, const struct sched_a=
ttr *attr,
> >
> > Hmm, rtla_sched_attr sounds to me like the function does something
> > specific to rtla. Maybe syscall_sched_attr would be a better name?
>
> Should I be waiting for a v2 with this addressed?

I don't have strong opinion here, I sent v2 with name Tomas suggested.

Regards,
Jan

>
> -- Steve
>

