Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BAA19F127;
	Mon, 21 Apr 2025 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745246225; cv=none; b=mFDaB2tS3R3L4whOfAixSH3aa4cm1ls6mf2ZEj03cr3IiMqghOgxlobBo5huclCDz4TONexLTenmTKNt1FU68cDXExJUz8lxp8HqqdLJ7ZvMi3vax7yRj1x5IzdJyXSKdS6oB3Jf5vUQMwB6czlgtSqvt+J76lwagkbxG9t9gfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745246225; c=relaxed/simple;
	bh=YLucKKjz3N7nuuybkDfWZS4sob5auATo+yS/1UqCiko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPi8/NF74Whw4G4yaot4me1kevkB8sZAc9ZdnA8KUJEDw+3kk6rnUYjpw/9k2W+wZ1DaOQqhK0DgjTDnbQOfjyPo70zhDtr84yhZ4zdX1CRxcgrsBfRfIXYKh3saoT5rNwfROk0HR9lPf4j/6WjM5dSr4RXJYm5BhEg6qOqD164=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYsqqg1o; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYsqqg1o"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-301302a328bso4270721a91.2;
        Mon, 21 Apr 2025 07:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745246223; x=1745851023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mPbTxt1xCSveA3U4yTGjdoeVzUE/l45rw6qCh0l4IAU=;
        b=mYsqqg1olx1bOKqM04PnjfgDDEqztORpOksWsSQUtmIRgc1yeyQ7M5B1WtMRKa3Qbl
         FIiMeXmu62iuLr6GIdaaMTA/H0ulno+D9vKqJEPCrwJHZotiWyyuodVEcYgvWpU77bvt
         j6CYQefI35LIyJe3ZITELNIRnvJwFoye44HD2IjV6xCPbOgGw91yFdMqzrf0wu4EoRXJ
         Pe045AVeqZnErEKQ3QQYZYPKJh9zlWTpGZ+pM7zmD4bIMlmVDLXJMr4uBt7yWKp5V/DN
         y3egsQkGFNLvMZhxfOu9mqemdVmE9z5bqLSVkNEJFxo2+qBq6VzuijUvacxK1NNmX7lK
         Oang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745246223; x=1745851023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPbTxt1xCSveA3U4yTGjdoeVzUE/l45rw6qCh0l4IAU=;
        b=ww18yCxZrNANyDG85XzWBa34fwXM5ZNa8yxlqzSX7gIdzUbI4MVUtmQdDgzdaK8tK8
         0v4maWogtcdGS6yRGfY9LrscejbPACJxhT2mACOXQGGUEnha83JH8xeGo/JPbgNMaKSF
         HUIh687ovSfs7x9+TxrAhIM1tMfPJ0qDKKh3OhxXuDHZ9qPuZ2hKfPVa1cA3PjRKBZoS
         2c9oEOIrLkiOS20X5dear/iHL7LZEgT8BA6Nmz9DEu8/BI9OPEtS5qNh7rQltG5Ckmjf
         ghG/4G1eCSWdjBz8lomqUPKhmOa12BPt7IF+cRKmnJEKOnMfmmUMVKhtRaedfQ2qBm3n
         TQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUDXqB30aqp7TreEMPn9lToR0LWzy1vohWH5aHbZUXHxkVvUux9NDqbU1zkwNMHvc16F5o/nbjl6g1Cs27rXBUs+/p@vger.kernel.org, AJvYcCXRatfO62BaZlxN5GDXq96HHNykl+vtfHiZPTKo8N12ZYifgcxG7Ma/Jy3H0fHlDvuIYpRjgTAJ7qmCXB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgmlJCYiIic2XqOAFqbUjwaWrFyCse5lxRLKog9PSahDKy+hLQ
	TZBO15/4BQ4hQuArHeHi2c0mBpNTXvNWL5udEmdI1+v0lJX2e3qo4z5+uZkIfZB3Ci8QQ+QRy8p
	OQ9rpfEAPGj+NfPewCit2z64LTcE=
X-Gm-Gg: ASbGncuR79A/OzepXD677qWWv1RtYlUi32XNyqZEFXlNn4NhIKzjx1820df923nqGNl
	0xQb9YVTMBH2aiXqDrQKQH9lDmoUdy1OiZRyQMfPgMl6oDydUTsGWJiFd7VJfNsJP5hvdpa64Ky
	/4HevNQy66JMA4SH5kU2eDOzyN
X-Google-Smtp-Source: AGHT+IHJa46Co1E1kI6mn8bwL6OG+lX6z1DMWQ3+qezTjfJ1VVoNd1SMPT1rupbW/e25+/7xXvsNtsPVIpJHwCn3DMY=
X-Received: by 2002:a17:90a:c887:b0:2ff:693a:7590 with SMTP id
 98e67ed59e1d1-3087bccaec2mr18875647a91.33.1745246222778; Mon, 21 Apr 2025
 07:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421134936.89104-1-aha310510@gmail.com> <20250421101912.4fd7c11a@gandalf.local.home>
In-Reply-To: <20250421101912.4fd7c11a@gandalf.local.home>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 21 Apr 2025 23:36:52 +0900
X-Gm-Features: ATxdqUHPOHjHEz8SWCYSZwtkmcCXGtteCQAscKNShJqFD4GqX-Am-L7SyLx8lI4
Message-ID: <CAO9qdTE4gXLorLXLovem1r7uVFSJ4FjpNHM9tH2C2geruQqG9Q@mail.gmail.com>
Subject: Re: [PATCH] tracing: fix oob write in trace_seq_to_buffer()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, 
	syzbot+c8cd2d2c412b868263fb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 21 Apr 2025 22:49:36 +0900
> Jeongjun Park <aha310510@gmail.com> wrote:
>
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 8ddf6b17215c..8ba6ea38411d 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -1827,6 +1827,8 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
> >       len = trace_seq_used(s) - s->readpos;
> >       if (cnt > len)
> >               cnt = len;
> > +     if (cnt > PAGE_SIZE)
> > +             return -EINVAL;
>
> You fixed the wrong location. The caller should know how much size the
> buffer is, and that's passed in by cnt.
>
> >       memcpy(buf, s->buffer + s->readpos, cnt);
> >
> >       s->readpos += cnt;
>
> The correct fix would be:
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index b6e40e8791fa..c23b5ab27314 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6729,7 +6864,8 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
>                 /* Copy the data into the page, so we can start over. */
>                 ret = trace_seq_to_buffer(&iter->seq,
>                                           page_address(spd.pages[i]),
> -                                         trace_seq_used(&iter->seq));
> +                                         min(trace_seq_used(&iter->seq),
> +                                             PAGE_SIZE));
>                 if (ret < 0) {
>                         __free_page(spd.pages[i]);
>                         break;
>
> Especially since the trace_seq_to_buffer() code should be moved out of this
> file and should have no idea how big the buffer passed in is.

Thanks for your advice! I'll fix it right away and send you a v2 patch.

Regards,

Jeongjun Park

>
> -- Steve
