Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A8930677D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 01:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779327574; cv=pass; b=LFCb5kTk6oNs28HTIEePbG9WNPtDmsu6ef+TDVHJBaUHBq8iRpAEhppq13HY6xc9FkeXtBu37AUrH+kavXRBYAsI7XnQfvHE1XBdhVlwEOU7ZS6mw2irUSkGE7/323NTjdgEHaG1zjAFp8+xdtIKEKSdzFwhl1ymPCQKzI7wMec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779327574; c=relaxed/simple;
	bh=yECoRPcc9MgdwydAyixOT6oWVqh0Soy6ptJGTKcDeQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5fWDxYm5xAdUmrcTFtwo/NiarFNv1YZNSQmyZRVUzPdewn4SRFmKDalkYfdu4eUTd7sDTI4Fe6HW3m6E6KBR1v2nurCEo8dRDw0t5ndrE7r3p0BZa8DzZodip29GfZ7Phr95bvgBtOzfJXzIO6e3KyHFklC2m6go8gxeKFmDEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0kx6QLr; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0kx6QLr"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so1473971a12.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 18:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779327564; cv=none;
        d=google.com; s=arc-20240605;
        b=RjoP9NwxWZZ1mOXDNGGRJXiibUi4etLztQTb0Mi1v6c9pHojH9ithXyah053YzxL+d
         0uy5B9vCxsfOFs3+DzypCRPHb6quDrk8yf8QJnjt0e1VtVbFz7TArizcFa3jwz+3MiSg
         33UO+B+3JT1wAe6dbkndsCgXKVrbGWV7foJRU+A7jr9qn8B3V3SEGj9pajz9kGZQ6J4e
         pPp5Yk0Ai4txK/CPTyYmoIzQduvrK5uATtYGAA0sDiXLKZ6KSU6vxPks81Mc6fVMZFk3
         qCLoiLEtt23sidj9nVEW56kFaYS+EGJdzUetU3+AdsvptsLLq4KvnzVvE4cvnaaKGSSh
         cluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P/RUGoJFhQql3Jq1jdEGsiasJcwn4x9hrakVluPPHDc=;
        fh=COrlhm9HaTdAytAlXTZiJbvYSog8+l2ndY6HWuAVhAY=;
        b=KDAR1U24pxL34CmRbal9PL2EKxiTG0bWT/k7EGduI9CDI6NOqzsxExTKuqk5FikhGw
         Y5+lQqPV4LI5oHVKVXtetD0SZh25UL6qFOs3/0GfwGniFZqdhtoZ00LhKxUkx6vx3jBU
         WcNbGxxQITgY6fkG5nsOW/sM6M7RrLW3e6IwWxIu73NEZ8XBqSkJG3xEGIUavTu4vkJ2
         VIO/fEaPtF5hCjoFMPPCjcxayfFMHlr+wMAOdme0NTumv0DlzqoBBSvMj57C8bMYW0T8
         CPCww4AAtPAZqUd2iDJuKfHQKHe02reIqcETDJrwASkup7Ozno/Y09SREWln2dh4tAKT
         sF8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779327564; x=1779932364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/RUGoJFhQql3Jq1jdEGsiasJcwn4x9hrakVluPPHDc=;
        b=p0kx6QLrYPln/OKIFFaeWSXyj7dmGysBinOCTl/OGLUM5OomOy+4DCzNKpzvDlhQx9
         4v/JeBn5+yjJhZiNHIfQzx0blqdb5fOGUg/swMJ9AOxXCc7bpVOZWwPW6atLmymVLeZx
         1fABf4ZKIVi5/qP9GX3uIEbIF908IPmGyWGFgBmwc5IWbPUAPC3Ojp4bES48mwvZLBsJ
         VINru7/Lj6LyQqADVGabLerr2thX0P2prMZ+YkbP1UI5Vy/ULv6zTHftGtrFfaz019L/
         Z21j15aHpe7m8f/F8zKl1Znhhc3qcy4CVb3zsBZ/EuzTTKv3YGY29bEP9ywzjj/UFcp/
         EG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779327564; x=1779932364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/RUGoJFhQql3Jq1jdEGsiasJcwn4x9hrakVluPPHDc=;
        b=Rq62QX2FNrG/qyxcCoS32qYrRJVxsjGrBS96vPP8QmPBuRSbpHPUqn3twQb00UFlvW
         USZe/Sriq1fkDC9ayU+8oT/SZuL8shVhiFd2nUY7OvU/IyBnMcBFnGelLR0bcbGFaD4I
         VF2DW6HXqzO4i67ZHpwwBwE/rRb/xy+RWaqx4spZ/qdh/bY0VlD03u8AM+UNoCSMXkqi
         BBdocMOjjGv+3DdyRXNdoUW4Yl52aAdO+iOy7iJ3hH09qNUrCvVeqCjHSuiPagJyFThK
         J6UEQk+dMNbOqjTGmoYX3kLtdEZ/ePPLBqTIJqEr+GHXuGUwBThCYZrE9NwU30YUMIuJ
         skKQ==
X-Gm-Message-State: AOJu0Yytk9Q6mq0s0WziaPM4C5WAIhD4iwNgS/22hel1QoDfCUods8NH
	uLEy4/poTh8mqZQTSFjmIH3T4M3sccybMUeA/rX/48jlNl9MCqm6PvQDbkS58a7r/cMppEO4zcM
	gaHU0oAI3ydCstTKhICBtWqMLiQ9AL6Ll3g==
X-Gm-Gg: Acq92OEqv5zaJkfniCdjGuCiIxjb3LLV0S4/S8zg3SiygjB8CHPYtZ9TiPMA6LJ66Ih
	g4zcvWNjc1vlaso1Nlx/lPTbiJjQBjZ079kHTt4W/Fz7VL8V+c4KQ1Wr+z8RliVAcn7KCby7uzQ
	rz1p3U5cNtOH/7AgI++HPt8xRVJIgF5FUdtIcxH7jmJUD/W201qqGKnSvqMiJ6jCmnQIAtgOuNt
	dF17tfSCZdvptdiBkp2Vg1G9kBbUOixDfskXpkCpEL37ETmdtw7TtGB+seoY9ybBpVIW8EmDgg4
	8RmaNW06A7FUsR1BcOTZlFLW+cP2XqfFqdlxv+ZklyuZdmSJNB/iyNC9d9Za7v6sP0f0BxxqmMt
	NTAojopgA/Gio/Fye+jutKR8euLzpog6Ln6KSQLkErgcnYHerg/WpiqaWCQ==
X-Received: by 2002:a05:6402:350d:b0:674:b355:555e with SMTP id
 4fb4d7f45d1cf-688361e8effmr290030a12.17.1779327563850; Wed, 20 May 2026
 18:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520220030.16887-1-rosenp@gmail.com> <20260520212829.7734bad4@fedora>
In-Reply-To: <20260520212829.7734bad4@fedora>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 20 May 2026 18:39:12 -0700
X-Gm-Features: AVHnY4LQeTesc3cnK822HfQPnh4iCrlGI5xL2YTKDzM_S03rlZsU8Vj5cMWtZQo
Message-ID: <CAKxU2N_WKn-3EFEpWYmqTWY_GWqJfybn3vsmNJWX78z2SEtpZw@mail.gmail.com>
Subject: Re: [PATCH] ftrace: Use flexible array for hash buckets
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"open list:FUNCTION HOOKS (FTRACE)" <linux-kernel@vger.kernel.org>, sashiko-bot@kernel.org, 
	sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 6:28=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 20 May 2026 15:00:30 -0700
> Rosen Penev <rosenp@gmail.com> wrote:
>
> > Store ftrace hash buckets in the ftrace_hash allocation instead of
> > allocating the bucket array separately.
> >
> > This keeps the bucket storage tied to the hash lifetime and simplifies
> > the allocation and cleanup paths.
> >
> > Assisted-by: Codex:GPT-5.5
>
> I'll let the AI's duke it out!
>
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  kernel/trace/ftrace.c | 17 ++---------------
> >  kernel/trace/trace.h  |  2 +-
> >  2 files changed, 3 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index b2611de3f594..25a9dca290dd 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -1082,10 +1082,7 @@ struct ftrace_func_probe {
> >   * it all the time. These are in a read only section such that if
> >   * anyone does try to modify it, it will cause an exception.
> >   */
> > -static const struct hlist_head empty_buckets[1];
> > -static const struct ftrace_hash empty_hash =3D {
> > -     .buckets =3D (struct hlist_head *)empty_buckets,
> > -};
> > +static const struct ftrace_hash empty_hash =3D {};
> >  #define EMPTY_HASH   ((struct ftrace_hash *)&empty_hash)
>
>
> According to Sashiko: https://sashiko.dev/#/patchset/20260520220030.16887=
-1-rosenp%40gmail.com
>
>    Could this conversion to a flexible array member cause an
>    out-of-bounds read when iterating over the empty hash? Because
>    empty_hash is now initialized as an empty struct, its flexible array
>    member buckets has a size of 0. However, empty_hash.size_bits is 0,
>    which means loop limits computing '1 << hash->size_bits' will
>    evaluate to 1. If functions like
>    prepare_direct_functions_for_ipmodify() iterate over a default
>    EMPTY_HASH without checking ftrace_hash_empty(), they will attempt
>    to read EMPTY_HASH->buckets[0]. This reads past the end of the
>    struct into adjacent memory in the .rodata section. If that adjacent
>    memory happens to be non-zero, the linked list loop could
>    dereference it and cause a kernel panic. Prior to this patch,
>    empty_buckets provided a safely zeroed array of size 1 to handle
>    this single iteration.
Yeah this looks right. Might as well abandon.
>
> -- Steve
