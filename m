Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54EF1F5F5
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706672417; cv=none; b=rUULPLM+F+53EkA2l67JdRLT6kyqhjwM7WmOjvt8kmPwtOK6gP0Ninym5debe9cOvp7LLatbdS9Z9T1jvjaDUNarKcL6bbgl40OjdpoctTa5kDp8SlPmMZ6zLbLNuTEYY+TeMBNBKbrpzMfZBzPsY/26udHrsO3BBPoQectRac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706672417; c=relaxed/simple;
	bh=yw1NOpDHyLzhqgRn7bhY/dhSkPQ2PzYELUWet09fCyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sd7wCIvCnzchaGc3rFOCmWsDGg2Bw+CX+hAGQtQ0bMG129fjpi9HyJvwLZPgdbEuwHgLaOPpwz8H9j9Ac0uwe3DSls3qhAb1lGT2Sc4uqsZC8SLXrg7wDxu6xLT15Xz6VU5C1BO3VOGKEX+CuHKQ33AJTW2OZZQamm0ffI7DK1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gZsoelm+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gZsoelm+"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3566c0309fso409267566b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706672413; x=1707277213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8RGcPR+EINRerlSJ09DwzUdoWhHkZNQ/15Haltdbaks=;
        b=gZsoelm+umAuDJp3o6Xch5DRDE3T3wh+tTYj1V2Wlt92Bh+lXQMfIpQi/MqjdIDjJx
         OLieoIr0ncAnh5HfxOivwJxgAfy8VkX0U/IVeerD3Qu7OWNkZuZmLHoDJzdK0UH/Iw6L
         t+AuWNE+nBjHewJHJ+kBOtCNiD70IfHn8Ci+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706672413; x=1707277213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RGcPR+EINRerlSJ09DwzUdoWhHkZNQ/15Haltdbaks=;
        b=m6Umr90YPaPIY8f3w8Eot+triS+46ykk9DkCOEr00hennl5BSr9tysnk0PBESgE0cG
         xDYDRzSat27/MuX6hK4gfbR5SvqY9dpb/y5ENU8Z52uBWk585kL2rtKj2XKKBdxDlU3K
         FH0kn8C/N5/j6Mz6cigG9OFMFoyXr3xRzFUtAitaLheQR1Uw+7OvwdAdsZsm0CsverQ0
         L4U5ET4vv6qpYZ4noyEpFERT6zHbLNcQldJCRYCBg8mR6nSteJydc3YRusqdWNxY2X8m
         +k1DR2DdVPY6mHkIU99mDNkw93wxWLI8sORXVnuOn/pBMTpIgHjnG6X2f2zCZTkChKG1
         DktQ==
X-Gm-Message-State: AOJu0YypQFWPO9ubYjW2bVZheQEzp9z70SHRPHriIMbGmwy4SteyMacy
	k1b3Cgd1pF8KdvnvhdH2ciQDF9Y2QbdQQqhR/M6QVS+K53RoYh9tP07XcwoZBJNoyGN6XC9acfb
	gELKcUw==
X-Google-Smtp-Source: AGHT+IFEYXnVxeMTmUzEiR7RZt+T6fWjWPgDQTuAGFQqfp+2Diij+cFzsUdl5mhMyWtt0RwPm3yonQ==
X-Received: by 2002:a17:906:e2cd:b0:a30:f558:e04f with SMTP id gr13-20020a170906e2cd00b00a30f558e04fmr233205ejb.7.1706672412693;
        Tue, 30 Jan 2024 19:40:12 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id hw18-20020a170907a0d200b00a3600d7c2fbsm1827759ejc.176.2024.01.30.19.40.12
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 19:40:12 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55f2b0c5ae9so2555645a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:40:12 -0800 (PST)
X-Received: by 2002:aa7:d3da:0:b0:55f:4d7e:e4e9 with SMTP id
 o26-20020aa7d3da000000b0055f4d7ee4e9mr171002edr.21.1706672411784; Tue, 30 Jan
 2024 19:40:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-6-torvalds@linux-foundation.org> <20240131011246.GP2087318@ZenIV>
 <CAHk-=wie3VgLatmR4J_VpnyJR-qKppz=gnDfxEa9Gyy-7cH7HQ@mail.gmail.com> <20240131024626.GQ2087318@ZenIV>
In-Reply-To: <20240131024626.GQ2087318@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 19:39:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjyki7XCnUjaBZSobLaNqWSjg39JhaUjrMH67sYxZLmdQ@mail.gmail.com>
Message-ID: <CAHk-=wjyki7XCnUjaBZSobLaNqWSjg39JhaUjrMH67sYxZLmdQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] eventfs: clean up dentry ops and add revalidate function
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 18:46, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What's to stop ->d_revalidate() from being called in parallel with
> __dentry_kill()?

Oh, you're right.

For some reason I thought we did the d_release() _after_ the RCU grace
period, but we don't.

Why don't we, btw? It would be so much better if we did the
d_release() from __d_free(). We have all that smarts in fs/dcache.c to
decide if we need to RCU-delay it or not, and then we don't let
filesystems use it.

I assume the reason is that some 'd_delete' cases might want to sleep
etc. Still, for things like this that just want to release memory, it
would be *much* better to have d_release called when the dentry is
actually released.

Hmm. Not very many d_delete cases, but I did see a couple that
definitely want process context (dma_buf_release goes to things that
do vfree() etc).

So I guess the "make low-level filesystems do their own kfree_rcu() is
what we're doing.

In this case it's as simple as doing that

-       kfree(ei);
+       kfree_rcu(ei, rcu);

and we'd just make the rcu entry a union with something that isn't
that 'is_freed' field so that it doesn't take more space.

             Linus
