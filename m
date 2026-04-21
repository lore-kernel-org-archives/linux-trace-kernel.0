Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A62223D7DC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761705; cv=none; b=o3yW/9rYrpTXw4XfKUslxVsLgoLc9Vep64Aaq0rwkmmY9/lqPmUPJjlSrmOcNqK979SvXpQoiqp9NrTEfx1BBsCf8FR7T0oErolPzv9j3eRi0Ta6V6DKSnmfIqdY8NGyLqY8gcqDD+53gpeu+eXtSrE//mJH339HUJ2MpsnvQdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761705; c=relaxed/simple;
	bh=dtnnNHZ5616P4ZuNt3CYdKmALQNKqvUCA10EYXObtaU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZe0ff9j5jAb5TKmUJ03gG+b33pYDWRFTW2nNJKp9xyGPN4NLsqZOpyOOVbLR5EHMmGjE50gdvpgZomKPhpW+nZ9ZDJzTN0X650L9sDP9S3TSYpkyfoTlSBFTuiX5mogHV3BCCdYGvZ2eTGYW9OnmrB1YjRCn0sxC9teK7ihQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBFVzVjb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBFVzVjb"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso45160955e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 01:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761702; x=1777366502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AeY5qh+EcqkCfyyCPXXB9ZSKqRXVtQuu9uCaeSiXST8=;
        b=OBFVzVjb/Cabr9f/d7SrB/UeSPBslad8fvDZKz8OJ3sfSd6WdndcYVHWL9SJgtUA/e
         n0IAMWvcSU99THf9jW7KAg0KWgNOSbacUR1r7L1d8OyHhg71OMdEJpf5FWQS2LhPhOT9
         QQxXNRjCkQ89UkD9HWQxgpve3e3lLEGS8UgvTZaJS5RGjpcshPJIAOnMtsdj8BbBMJD2
         Qp//4lkhWXmQWAvqddhw0cwjtx91p0h1rDTvS8K7uEo+6HwgXzPVL6w404lqDN+Yzw5f
         /6zPYbIT04pCub5eN/pF+xC8RpFngm4bKxLkOh3z5VmFC08/CAQohE3actvrMuvJQUu3
         pepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761702; x=1777366502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeY5qh+EcqkCfyyCPXXB9ZSKqRXVtQuu9uCaeSiXST8=;
        b=QyryBGhQqJUVWC2XJd+lI4wtQBJDfknnGQ4GkccNqoKGcXEK+rkSnBKpLJ/cxg1iiR
         buuxnzy+w0hOX5ZcmG4t/4rhyV0CsO4eew813/8ahMYiOWlbj6IjwuvgwOvhL1m3eUdN
         opU1y44OTJR3CJ5w7P88zcZCNEqhm1rs+8IasZcNCnXlBJTufEsj+RYFguGB8m3l/rQ9
         V3bQZE4dQW6G55uCokzFUeSX8lMO2FPvf/3b1TKbL7S/jQxGxQBytiAkaH2Pg7Y5CEXF
         NvoKWhU5G9r4hWXOUQc5BRhfV28hmMDES6oyG9KxzXeUQMHXapnweVw03zPyYLIxx1XG
         3Z9w==
X-Forwarded-Encrypted: i=1; AFNElJ+II4X92gfByTnlSbnK+QuBqj5oMvdIM/+6ILWT5R7pknuxPLExcTDLUeP89UgfO5UumLNU8yrONpCZgoc6aBWyZs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzyNfo3AIX7nELFSReDHpf9mYvuPUK344/kY6LkiWQFYIkCtCE
	SsXh3KIZX/WOQ531tujaIFJa9a+aZhN8oc79jDuv1mHP7ykEGLsRs4uV
X-Gm-Gg: AeBDietv7mL9/HzSwDJcb9aLFxPjfJE+iHnwo8V/TArPBailbnky970/Rv2N4RHCJ3R
	QfuD7Q7mtjIdUX2KqTJI6oL2DgmiX29QxmvExeVNLJeOy6IDoujzljNPd8OzZjRo3Dkoih14Qa9
	CNaOWbFDKoTGGzhASWfXL8iu8/uEHStxRGHF6r4mdiYrMUjtb9MaCyx+pCYz1qKU9UTybq8BNE0
	V7qgE5wKUmx0lB2aRNVdtEVUnY1h2/8X+nhn/MHC61wlQ85LMomYq47fYg6xPciQVklfECcVJ0n
	GVtTCPMPzwiopJ0gVsSavnYAKLCX/Srt+m7vvDMedaA7eXNqryREq5OCtPgeI/xGV/GDNgUULyx
	EHVdR7wjb6Tx0+/J9ci89uZwiVisT+hxHNCm9Ll9HGsRldYobIs408WAN2uJWJhoWItOig1weFf
	KpU2CnV4dVfGYh2xEHOg==
X-Received: by 2002:a05:600c:b90:b0:488:b99b:4177 with SMTP id 5b1f17b1804b1-488fb78ee4emr234358865e9.25.1776761702420;
        Tue, 21 Apr 2026 01:55:02 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55b8baaesm53728875e9.10.2026.04.21.01.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:55:02 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:54:59 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 04/28] bpf: Use mutex lock pool for bpf
 trampolines
Message-ID: <aec7YxWrZnJDzoCI@krava>
References: <20260417192502.194548-5-jolsa@kernel.org>
 <53b3e6cb10e12555d3b1b321eeb4e04a447c707c387568d1e9ef759fb6459ef4@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53b3e6cb10e12555d3b1b321eeb4e04a447c707c387568d1e9ef759fb6459ef4@mail.kernel.org>

On Fri, Apr 17, 2026 at 08:10:24PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -30,6 +30,34 @@ #define TRAMPOLINE_TABLE_SIZE (1 << TRAMPOLINE_HASH_BITS)
> >  /* serializes access to trampoline tables */
> >  static DEFINE_MUTEX(trampoline_mutex);
> >
> > +/*
> > + * We keep 32 trampoline locks (5 bits) in the pool, because there is
> > + * 48 (MAX_LOCK_DEPTH) locks limit allowed to be simultaneously held
> > + * by task. Each lock has its own lockdep key to keep it simple.
> > + */
> 
> The comment explains the 32 count (MAX_LOCK_DEPTH limit), but should it
> also explain why each lock has its own lock_class_key?
> 
> Without that explanation, it is not obvious that distinct keys are required
> to avoid lockdep "recursive locking" warnings when trampoline_lock_all()
> acquires all 32 pool mutexes simultaneously.
> 
> This was raised by bot+bpf-ci@kernel.org in v3 review:
> https://lore.kernel.org/bpf/31ae46274a3157f2b9840e1a09b2698d1ec0cfd461737ff460c2d3349a9f0054@mail.kernel.org/
> 
> The author acknowledged it with "will add", but the current comment only
> says "to keep it simple" without addressing the recursive locking concern.

will add more details

jirka

> 
> > +#define TRAMPOLINE_LOCKS_BITS 5
> > +#define TRAMPOLINE_LOCKS_TABLE_SIZE (1 << TRAMPOLINE_LOCKS_BITS)
> > +
> > +static struct {
> > +	struct mutex mutex;
> > +	struct lock_class_key key;
> > +} trampoline_locks[TRAMPOLINE_LOCKS_TABLE_SIZE];
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24583317711

