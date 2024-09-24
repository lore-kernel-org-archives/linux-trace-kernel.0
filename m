Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378E31A60
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Sep 2024 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727200874; cv=none; b=tJfTFPBU/K262Qy2FDUTzR+6TXayKy03h8F1g+1LlwGSv7JmgyzCGMFMecd4SmmG52LMmFSqfNSL/8Dz1dAO5E6GEZKLzAr8IUfMf+UrQITpNetjABqQbX7E+p8DesOmJ2JOTmFelU4/u28MPJdiwa8IHvWOLixRNWLh1NqpIsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727200874; c=relaxed/simple;
	bh=A15kpu7Y1O25FNXdv/Y2yPmP7X/PnOCFalZNHC+1jXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpTwYG4sVNUGbPsGA1X21SKreZwd7Gi//bbYml4XDRu2CVpq+83Ftjcmglqwz5gBSFUmA0T0IU1lxksZxxeFOKp1q3gpVqgthXtszjZASKCuSY51Dn5lSku7YTUpPMmk33EJEw99rGQP+L6COYTW3ytILzmLvufd7DF2HAeGYbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xW2GnKWp; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xW2GnKWp"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c247dd0899so2619a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727200871; x=1727805671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjhiFYP9ZLzgH4eZvCkFY1gAOy9o8UQ0O08H+0Dp/FU=;
        b=xW2GnKWp+peKeWhGjxYJN/23TVphx7aPdHUqBzBf7C6FesYkKu2X+lEuU+Hl06ASu2
         kj7bwYa3RMHwxWPcZ6ZjbpxyPdsosaLPBW31M3nuvwFou4KLvXgJpQzKFmF70iukukGc
         dGNf47puZ16G6qTtLT/YJ58F2DDwwiH1ytMwkqlOjigm5i66nFPspS8xK5gi28Y9Ildo
         D3ysdCSLyn7m1esqMJ2020vTlaDf7vlmFF4C2HtOrM3FmfGAAkMfyacfmTyUlHstrXfl
         +SVtxbbmP/jc8kHB75YE4/oD0ERvAp9MsZJljZH9LmFhxTanMnR3JXVQq9FKF24p8bQN
         pN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727200871; x=1727805671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjhiFYP9ZLzgH4eZvCkFY1gAOy9o8UQ0O08H+0Dp/FU=;
        b=ZS7nTTVwxkrAQrmUPQA/QkDMHsb5LA3bpAAL3gwzMKsItYeDvoPfcyi6OUIF6e25Zt
         yIsLM3Wt5YafXrfr56LWuWzeCPCT6pfkg4hUno/qQ6JgctFO6cq3VcN4meGGjXQN/GPW
         QpW9tV54xxexOziH2KWni0OzcmKJOQOnJerka2tRsHL3CbYQ+IHbWr1mSbltQRnJ47Yk
         y8Cqs4WXrmghe+3sQ6NNB41jAg/qTyYvEuTZwB0vTyPNilsr0ekapOQDXbbRbyHeC073
         hDshoYrzZHU26S+ET0sCORJdqBIdpdAHLSb9mdwDgYvKhxYdf0NsuRu4IhJ2lqRtDSDh
         Z0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXctsgveJ09IHB4/qvcEBVEqUshp8mL4ctrreTKPxnnfVi6+SGhGlKkmO0HizozSj+H+9zOrp6+0d9BUZPMum+mzi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrtdGFYbc5VInKvvp+CLMTIkn0A+gvtJ1nMFGat/bYzNNiUABr
	1UdMGY7T/n5iEUmUdImNmuunh8ltGyjAsQ2gsWfazCrmYFN73ggE+mR50Rlvgf6oQCgBswmfJJU
	bkrS1oY4kqtppD+4h15EkwGZjmRO5TTrJvBb/
X-Google-Smtp-Source: AGHT+IGauZmcTAmbWAYK0JUSi5/BirlMPx1JVwLFWuHaMRUoRmepOtiQ7z74xNp5Rgwdm/FNTBH4pFL40akueNX7x10=
X-Received: by 2002:a05:6402:26d3:b0:5c5:c5fb:d3f0 with SMTP id
 4fb4d7f45d1cf-5c7209c91fcmr22261a12.4.1727200870366; Tue, 24 Sep 2024
 11:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpFFqqUWYOob_WYG_aY=PurnKvZjxznnx7V0=ESbNzHr_w@mail.gmail.com>
 <20240912210222.186542-1-surenb@google.com> <CAG48ez131NJWvo_RrxL7Ss0p4jd_aKOu71z1vm9wfaH7Qjn+qw@mail.gmail.com>
 <ZvLzueEY9Sbyz1H4@casper.infradead.org>
In-Reply-To: <ZvLzueEY9Sbyz1H4@casper.infradead.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 24 Sep 2024 20:00:32 +0200
Message-ID: <CAG48ez0c=ExHdoxQWqDN9hFAhwUKab8vgk-nJ-JGqTUm4xVUsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 7:15=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Fri, Sep 13, 2024 at 12:52:39AM +0200, Jann Horn wrote:
> > FWIW, I would still feel happier if this was a 64-bit number, though I
> > guess at least with uprobes the attack surface is not that large even
> > if you can wrap that counter... 2^31 counter increments are not all
> > that much, especially if someone introduces a kernel path in the
> > future that lets you repeatedly take the mmap_lock for writing within
> > a single syscall without doing much work, or maybe on some machine
> > where syscalls are really fast. I really don't like hinging memory
> > safety on how fast or slow some piece of code can run, unless we can
> > make strong arguments about it based on how many memory writes a CPU
> > core is capable of doing per second or stuff like that.
>
> You could repeatedly call munmap(1, 0) which will take the
> mmap_write_lock, do no work and call mmap_write_unlock().  We could
> fix that by moving the start/len validation outside the
> mmap_write_lock(), but it won't increase the path length by much.
> How many syscalls can we do per second?
> https://blogs.oracle.com/linux/post/syscall-latency suggests 217ns per
> syscall, so we'll be close to 4.6m syscalls/second or 466 seconds (7
> minutes, 46 seconds).

Yeah, that seems like a pretty reasonable guess.

One method that may or may not be faster would be to use an io-uring
worker to dispatch a bunch of IORING_OP_MADVISE operations - that
would save on syscall entry overhead but in exchange you'd have to
worry about feeding a constant stream of work into the worker thread
in a cache-efficient way, maybe by having one CPU constantly switch
back and forth between a userspace thread and a uring worker or
something like that.
