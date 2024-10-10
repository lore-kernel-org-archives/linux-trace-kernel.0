Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C51BD00C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562670; cv=none; b=KCbZRTwzoGV8RNXxFKrY8S932KpxJ/Owt+mAD0srKEqi0bDWeg2Zw0EAsURf/1itHku6dwTbH8yGn4edzFprj/k7Zjj6QRKEG7dF5jMC6gdTmUEMNsqc7Dx6TPlipooI9p1gWfLrOT6ZkTahPsTFMOMsP4+dyOptOM/6vMb+3Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562670; c=relaxed/simple;
	bh=H9JaAro8seubwTztcgeEs18CcSuyFWdBlUaF2TD1klI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRYixAEC7Ue8krJlUm8sak+rtk6ztBFwJXPpOmHn9dCW5qmT5C0567o1wBOq0UGnekxn2CKN19BgXCp7jvNEoBjz3LdJBZxQRzqRGtUfJJkFr2wKoKrd7wP7nMZeaT1lVQi6vMq43ZwwYp4idnhfjajUxHGFjIQF7HCC1DWBzAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5bayww4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5bayww4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728562666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvflPd5gKQrGEgjFqXi5n/SBqJrFGg+Ya3MysYEqqj0=;
	b=Z5bayww42hGvedtijq3X7zCMcFkTbeAgTU1jlB6eJM9agrtlERSVAnWXjLPEZ22GeNixA1
	Xkni24Q0q9RvRdo4r3CkHPOpADoS/5SCAfHUR7bt1dLIoO0J3U0QA3dvy/N24PbcJpyerT
	TAIDV0Wmu2Wqfg5hwBheIDfT2CboGzg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-3cmL6ZDyN7yspesppJjUBw-1; Thu, 10 Oct 2024 08:17:45 -0400
X-MC-Unique: 3cmL6ZDyN7yspesppJjUBw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d37f8159aso523370f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728562664; x=1729167464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvflPd5gKQrGEgjFqXi5n/SBqJrFGg+Ya3MysYEqqj0=;
        b=DlnMl6KO7xw2U7CD23DE1D2TTMdStZln39c41oPWoldoL3mnETWuXrEYn/yrFTWK8c
         vzfDTE9KUJGnetjUwJGvmL5zVer3XWYQT6tfB2UJisgRDYqIN59CGUo2uvbQncrcYPu2
         dty/dsBRnJYNizv3M8J+ryZFVlbEZfwabopceFEAr4PGrLT44EUc8t7zPIdP+AdW5ldg
         tw1vBFrNTLQDGyrqr1UfII1k0RKFwERqVQdOPAdGS4DbU/oK6LHkMdEK3LHMqmOQwlQn
         ubk1KxJOuuRdjVJhT0DFV0S0G7Rl+Q0eLVdQSO/0ZUXARhcZSh/YS/mJk0JWJsCKTeGk
         uGhg==
X-Forwarded-Encrypted: i=1; AJvYcCUzUhNdqo+Ez6A0hQutT5jUlEhB3zVIl1OAep3eoBQrX8o09JBgmZin+e252yDU+KkoisYKSz/hSQvElUbmj05pAtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6n+SyCe+lAyqwNVIxwVaLdL4FIUixQvTOYe2fRCgDrUWkQkDm
	vBCwb/HJYnpdMa7KVjeBlpDbcVoBXqPaWHykEa9CbIC8Qy6+mIFxiMgMDF0y8FcAC1LFsnVbYi8
	HBKAHYEu9lkP4zzUZf71AssQ8HAbJ4m2Va1iNVhTbGgN18PuCxTZL91MsDA3rbMo9jkSnCY7vpY
	mhEVeJHKAMI+SIo40eO5cp3vjmPPxjIdlWI9hrSSkbWfW2
X-Received: by 2002:a05:6000:180f:b0:37c:fbf8:fc4 with SMTP id ffacd0b85a97d-37d3ab44826mr5009152f8f.59.1728562664051;
        Thu, 10 Oct 2024 05:17:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBsPvpcLWaCbyaJMuqsA/5wnAlx8SPVzPF+E5uBgFKKaQkqn66KqpMb1Cp9R5xxS9r7cV9xXbYD2SU+tSEMx4=
X-Received: by 2002:a05:6000:180f:b0:37c:fbf8:fc4 with SMTP id
 ffacd0b85a97d-37d3ab44826mr5009123f8f.59.1728562663682; Thu, 10 Oct 2024
 05:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c355dc9ad23470098d6a8d0f31fbd702551c9ea8.1728552769.git.jstancek@redhat.com>
In-Reply-To: <c355dc9ad23470098d6a8d0f31fbd702551c9ea8.1728552769.git.jstancek@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 10 Oct 2024 14:17:32 +0200
Message-ID: <CAP4=nvQT2-f98Sd6paMWqfGYv4pc39p2rfZfyCoxL6KrN-2Jdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/rtla: drop __NR_sched_getattr
To: Jan Stancek <jstancek@redhat.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jforbes@redhat.com, ezulian@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 10. 10. 2024 v 11:33 odes=C3=ADlatel Jan Stancek <jstancek@redhat.c=
om> napsal:
>
> It's not used since commit 084ce16df0f0 ("tools/rtla:
> Remove unused sched_getattr() function").
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  tools/tracing/rtla/src/utils.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
>
> diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/util=
s.c
> index 9ac71a66840c..05b2b3fc005e 100644
> --- a/tools/tracing/rtla/src/utils.c
> +++ b/tools/tracing/rtla/src/utils.c
> @@ -211,24 +211,20 @@ long parse_ns_duration(char *val)
>  /*
>   * This is a set of helper functions to use SCHED_DEADLINE.
>   */
> -#ifdef __x86_64__
> -# define __NR_sched_setattr    314
> -# define __NR_sched_getattr    315
> -#elif __i386__
> -# define __NR_sched_setattr    351
> -# define __NR_sched_getattr    352
> -#elif __arm__
> -# define __NR_sched_setattr    380
> -# define __NR_sched_getattr    381
> -#elif __aarch64__ || __riscv
> -# define __NR_sched_setattr    274
> -# define __NR_sched_getattr    275
> -#elif __powerpc__
> -# define __NR_sched_setattr    355
> -# define __NR_sched_getattr    356
> -#elif __s390x__
> -# define __NR_sched_setattr    345
> -# define __NR_sched_getattr    346
> +#ifndef __NR_sched_setattr
> +# ifdef __x86_64__
> +#  define __NR_sched_setattr   314
> +# elif __i386__
> +#  define __NR_sched_setattr   351
> +# elif __arm__
> +#  define __NR_sched_setattr   380
> +# elif __aarch64__ || __riscv
> +#  define __NR_sched_setattr   274
> +# elif __powerpc__
> +#  define __NR_sched_setattr   355
> +# elif __s390x__
> +#  define __NR_sched_setattr   345
> +# endif
>  #endif
>
>  #define SCHED_DEADLINE         6
> --
> 2.43.0
>

Right, the definition is now redundant.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas

