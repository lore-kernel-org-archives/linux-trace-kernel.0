Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD751DE3C8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401291; cv=none; b=lYUYh+i23/q9itPqlWt73Xuoc+lEohGhCaMjjc1VJ7NY284hQIKMyUkX0GhowSMmnIRmkXbE++ItU6mMhKdIpaLI6gH2kl9hUka967y1U2TmosYEpfGRu3Aw54RXaxNmxDgN9bwme4Ryt5V+FFEQLyqNK/4/PaOeLaZnuLPYhAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401291; c=relaxed/simple;
	bh=lq9X6f5rVWemxyluvt6OwcygPboGXhQUAKNek3zdLrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOKaMwbIKyPvKxYQ2XCR00wnNV89KqSaJ4sePckJ8js6SBrPLeASUchrLWvY9yAdzcbbRHBZCk/QMSJnuTuX6sUh91dqYfIqq6N24c8HKqFsYjSyQVcR73CFoalzmcsefcuhSE187JcUNXaH8+Wsx7+/JFQDWMJoEr7qMHPKFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAtMgXrL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAtMgXrL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742401288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JOpqJkUFS2tciZtn6NxMptpspHchhF4kFtYH07Hzmws=;
	b=LAtMgXrLCH4lhWmg/DvaWatBUHEVucrRqXYFgeF/1saAYRT3CqEUumpA4I+Lyur4Po5pt8
	T+hNY0HVFsiS2dRsQYM6QTf5RTvEqQ8WF+lKvXHH7LMUBFQSruUjkiUlnQs5cbAf8V4IT7
	QYaVxLRwQ+pJofbzh8DLIMCubbLaHm4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-dC8Bx__ZNRmyp4GlLPuc1w-1; Wed, 19 Mar 2025 12:21:27 -0400
X-MC-Unique: dC8Bx__ZNRmyp4GlLPuc1w-1
X-Mimecast-MFC-AGG-ID: dC8Bx__ZNRmyp4GlLPuc1w_1742401287
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-47682f9e7b9so118753571cf.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742401287; x=1743006087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOpqJkUFS2tciZtn6NxMptpspHchhF4kFtYH07Hzmws=;
        b=f53piNgq7T4jSfhsOteQb5CEIihefeZEtSiSK6t5dImu810v+Ai+Y5D+d/yUCbDjdG
         XGD5sMgofSAliDDpEQwfuYCT/lBR66R5Vddj4nYs8yX+bcH5hW35scJqjeL60OThMlKc
         tmX6GVXlKLR7rO1Mu+VqaDAPoYOoE7USt9BvdvxOCKSlud1t4tyVvjQlkohg7XKc2gFD
         RJiDonRs9VUn2+Ie9eazKbHKrXJ3l06Miqlf++bj3r73tH4rhwG1D8LpYj5J+cBpH8jg
         sG4lC1mBC/tM+z+p46p6Nirc7kCdGfDxd2NQZAUg4HftuAoPFe2CoIoU28H3tjHckYSf
         fdXg==
X-Forwarded-Encrypted: i=1; AJvYcCXS3DLtJ50ePnLNHQ+BTEvq4plMbY5IYyAI0edMfcTBGbO+C+51rGc3tkj9QoICYGmREi2YDa/e5OfGKaWQRSpfrQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSZGztGhVLa8x2dV9tbl1yzjBKxBw1LntFdBRL+HDt4QlLwcJZ
	Yz9niF9Ni7N5yRtNZUxCz8zpiroAU5mKHsz8Y/nGN2KdqCuEJAlD6CDxApAsvXIwv9wu0YEICb5
	h43XtXWqahMyqvC43LNT2tC5Oedr2nVAx7rshRCL4J3kx/oPbzrUUl60DtM4ySYnTHckXxdV3Rp
	AlmbcIqEAuMzK5MIlhsEaIlCn7SRspl+D97yw8sfBA/5au
X-Gm-Gg: ASbGnctunCIkrmXE2c68QqJQYRoTxuDG78sClUbbKN+GhmzC9mmqELqhLaQSkbgfxLt
	mh/GYpmCmtNmtvXYTK8UPZzsaYmcqp6RFJOir9yfJjKs8tIcjcaOxLelmKLKJ6enAnnC0MGwXj0
	Iql8Y/gGmiVMWJdNTluY1GDUXxvpw/Xg==
X-Received: by 2002:a05:622a:248d:b0:476:a969:90c5 with SMTP id d75a77b69052e-4770835ee45mr47927961cf.24.1742401286953;
        Wed, 19 Mar 2025 09:21:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEq0WBTdUbfxwEVbo37+U0Z4XQZwzQBI6UK5QfoVOWzEKA+jKrkY6HS88cD6LTiUix9oV0Ssh8A6+qBy79YGiY=
X-Received: by 2002:a05:622a:248d:b0:476:a969:90c5 with SMTP id
 d75a77b69052e-4770835ee45mr47927731cf.24.1742401286668; Wed, 19 Mar 2025
 09:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314125725.6425-1-gpaoloni@redhat.com> <20250318110700.510f05df7e113180503fc036@kernel.org>
 <20250319051317.670ba86c@batman.local.home>
In-Reply-To: <20250319051317.670ba86c@batman.local.home>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Wed, 19 Mar 2025 17:21:14 +0100
X-Gm-Features: AQ5f1JqNVJcfdW-NN-v_3Y6r0ZqLbaTg-J7YEdwOWjVrfDSN-7gsg_RUGixj8UU
Message-ID: <CA+wEVJbraZfyF1-4J41maJHtBYUAZBNWMUA9z+PWPXYeR5jumw@mail.gmail.com>
Subject: Re: [RFC PATCH] tracing: fix return value in __ftrace_event_enable_disable
 for TRACE_REG_UNREGISTER
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tJtYDjwle1hZTyX7dYF18kflmNYx42N9g5mWakRHRTo_1742401287
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 10:13=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 18 Mar 2025 11:07:00 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > > --- a/kernel/trace/trace_events.c
> > > +++ b/kernel/trace/trace_events.c
> > > @@ -790,7 +790,7 @@ static int __ftrace_event_enable_disable(struct t=
race_event_file *file,
> > >                             clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT=
, &file->flags);
> > >                     }
> > >
> > > -                   call->class->reg(call, TRACE_REG_UNREGISTER, file=
);
> > > +                   ret =3D call->class->reg(call, TRACE_REG_UNREGIST=
ER, file);
> >
> > This is not enough. As same as enable failure, this function needs to h=
andle
> > this error to report it and break.
>
> Perhaps all we should do here is:
>
>                         WARN_ON_ONCE(ret);

Yes I was trying to address the request from Masami however,
if we look at the error path of TRACE_REG_REGISTER what happens is:

ret =3D call->class->reg(call, TRACE_REG_REGISTER, file);
if (ret) {
   if (cmd)
       tracing_stop_cmdline_record();
    if (tgid)
       tracing_stop_tgid_record();
    pr_info("event trace: Could not enable event "
       "%s\n", trace_event_name(call));
    break;

In this case it makes sense since it will undo what was done before
enabling the trace event. However I don't think it would make sense
to invoke tracing_start_cmdline_record and/or tracing_start_tgid_record
if the unregister callbacks fails since the event could be in a sort of
unknown state (i.e. we cannot trust the event to still be enabled).

Also it is probably not appropriate to log the event using exclusively

         pr_info("event trace: Could not disable event "
                 "%s\n", trace_event_name(call));

So I would agree with Steven or else

      if (ret)
           pr_warn("event trace: Could not disable event "
                   "%s\n", trace_event_name(call));

Many thanks for the review
Gab
>
> -- Steve
>

