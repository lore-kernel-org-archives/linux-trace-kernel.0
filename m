Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5803E47A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706678751; cv=none; b=Jkpmyi/UMCLm0wsODEFoI8IoC1vUS+JiQXPc+5ZROKcjOpnNmB7M0V6wb9Ff6pmv7fUPt9c71VI6c4hz+ELk+8OWvnB/+z2rCvCXKOqunMgclHQ71h4Prs2DeAbZX0DNvk2hcElxpopF7LLmYJCXFPMmyRxBGrUvfBkh6h1yDjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706678751; c=relaxed/simple;
	bh=q3CZgihMakOv5ir/cwu7ZTqBpONwkqg3zIDu0G6t0DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfjEz/2Fy53plksTJ0XaMkvNBIREDFTCI5U9dWyuRdNyFhRavtQytcoGHFL6R7pMObc2twa3WO5Z47raHuKs7yVPfKlxe29r8XNFHdIwUpdzM+wPMcysw8qHfV63nv3X0+0S3a3Pt+tRxDfobbI5EJrRJcSZ9ZSCRmb7igx2krM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XIqAVIrW; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XIqAVIrW"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55f19a3ca7aso921245a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706678748; x=1707283548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YNeDtEUcLcTdeQG2/4dUYEpMxn73/e37bLelySYVlAM=;
        b=XIqAVIrWJIsxPYX+dnw0C9veB5lqSKYLRFjp4DPQBmpQX6/UgUR+sZ4VqtRlV5ebjx
         euMPUOzB+eXRvRqe4sH2zWuoUUV1fTF4i4uNHhbgShcApUc7YMTnf5+j89xAFksN7Zsz
         elAsW7WH1T3p7P9lLoNxz+9cZi6tK1aURrneI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706678748; x=1707283548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNeDtEUcLcTdeQG2/4dUYEpMxn73/e37bLelySYVlAM=;
        b=spFX1P9rq0A+QnVTFJ0ApVzbMjgEVhYWk1Dil0CW/UtgPIY8QpF+DhkHqMjqZ6olVc
         jAy90ZuwkYtOKrFSTO5wQMGUVIOlynRUOBtYG2of2IBhBFmB/gS8DF9YukVgOI8KGaoN
         VSkzLrdd2hs4WtxdmNUb3xvPwqm3qFNI0AcuGISsmxqSFd3DTQ2Z0qNBoJa0E1Pmq1iJ
         Ema97Y57e5pdjOXDvLUKtS/R5AKQA6wwa8Pb59diZlfnCS0UCwJYhYX/+NwTcDjFzZlC
         v3AhzBzqRKpEKdogAjWIh/RXB2TPxABHru/84tI2d57XbXuTwAgbo57CZ9RtKyohawWn
         cDJg==
X-Gm-Message-State: AOJu0YxVBy+9hVKapNf2+hyGQoxC7m+T/aKAEkEEBEag1BSWMZkzfGIl
	PYzapasrrPUBWF2T4fkk/UQxJQIokl0O9vAvbWfd+PMv0BrPCCbSN3bMDPJ5/slpEZLGmWWLd59
	77k2YyQ==
X-Google-Smtp-Source: AGHT+IEVUsQQnAeU/nWzzQnlqsieNm4qk/2rN3Lq5lXpzonp3/WJT+oY1muz+IoCr9i73w+ql7zMMg==
X-Received: by 2002:a17:906:abd4:b0:a31:8944:2cf6 with SMTP id kq20-20020a170906abd400b00a3189442cf6mr592124ejb.8.1706678747899;
        Tue, 30 Jan 2024 21:25:47 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id m1-20020a1709062b8100b00a363e8be473sm978889ejg.143.2024.01.30.21.25.47
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 21:25:47 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55eed368b0bso1062972a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:25:47 -0800 (PST)
X-Received: by 2002:a05:6402:310a:b0:55c:93c1:4a50 with SMTP id
 dc10-20020a056402310a00b0055c93c14a50mr540016edb.13.1706678747043; Tue, 30
 Jan 2024 21:25:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org> <20240131000956.3dbc0fc0@gandalf.local.home>
In-Reply-To: <20240131000956.3dbc0fc0@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 21:25:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjH+k47je4YbP=D+KOiNYp8cJh8C_gZFzSOa8HPDm=AQw@mail.gmail.com>
Message-ID: <CAHk-=wjH+k47je4YbP=D+KOiNYp8cJh8C_gZFzSOa8HPDm=AQw@mail.gmail.com>
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 21:09, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I would think that the last "put" would always have the "is_freed" set. The
> WARN_ON is to catch things doing too many put_ei().

Yes, that looks sane to me.

> > +     simple_recursive_removal(dentry, NULL);
>
> Actually, this doesn't work.

Yes, note how the next patch just removed it entirely.


> Does this work:
>
>         d_invalidate(dentry);

It does, but it's basically irrelevant with the d_revalidate approach.

Basically, once you have d_revalidate(), the unhashing happens there,
and it's just extra work and pointless to do it elsewhere.

So if you look at the "clean up dentry ops and add revalidate
function" patch, you'll see that it just does

-       simple_recursive_removal(dentry, NULL);

and the thing is just history.

So really, that final patch is the one that fixes the whole eventfs
mess for good (knock wood). But you can't do it first, because it
basically depends on all the refcount fixes.

It might be possible to re-organize the patches so that the refcount
changes go first, then the d_revalidate(), and then the rest. But I
suspect they all really end up depending on each other some way,
because the basic issue was that the whole "keep unrefcounted dentry
pointers around" was just wrong.  So it doesn't end up right until
it's _all_ fixed, because every step of the way exposes some problem.

At least that was my experience. Fix one thing, and it exposes the
hack that another thing depended on.

This is actually something that Al is a master at. You sometimes see
him send one big complicated patch where he talks about all the
problems in some area and it's one huge "fix up everything patch" that
looks very scary.

And then a week later he sends a series of 19 patches that all make
sense and all look "obvious" and all make small progress.

And magically they end up matching that big cleanup patch in the end.
And you just *know* that it didn't start out as that beautiful logical
series, because you saw the big messy patch first...

            Linus
