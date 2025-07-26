Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4262877D2
	for <linux-trace-kernel@vger.kernel.org>; Sat, 26 Jul 2025 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753552279; cv=none; b=MdSoG3zxK6ubqOEHhf8Ej+j1IcvxPys3Ha58x+ki/8fprtMuiKU2iF3shd2SdDP5B7IY7somjf7DshKfDKV6jQLVZJfYOkh6GWHLJ1BB7L886643sy5U1kHmjkkjIuEOjudrqfphv69aidxYwdIziLAPiUqlv0W4r3bJUpHSOkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753552279; c=relaxed/simple;
	bh=DooFKyvtMrhcGsvS73nOYMGBp2dUDW7K3Uj8YSGtKyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHARFb4Uv5zjKGuhqLc/Dr8k6J0JaJXsORyccL/N8+7ALnJmr0iwapVpnZ6AoYQxRLDdIlV1VqryaYkhhwM1ihaMt/fmh5vLARL1RCZFI+X+kjk/SGh214CllaHT304WWJO+DIa9AV6d4iRwO/as60rJaWe9ODA7G68eEfpynps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=grzsw++Z; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="grzsw++Z"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af2a2a54a95so488000366b.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 26 Jul 2025 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753552276; x=1754157076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HSxbEUJxkP0g7ZjvYqH7NhSZ9AP/JqKw188Y1XM8KDw=;
        b=grzsw++ZdsWZTi+kVX7Al6ZceOKRv5ZhNtWoJHi+ee21FFW+0areV6qpyfkHVyOdqI
         FAgrnKlH/HKP1RPkDpxQCJ2N4e9LUzJUOH7euDITekZY0bhPdymnkRvwRM10jBKDVAXS
         wgl49iSxvyHNk1VI6CjF8uQQVp2dZV4FlghoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753552276; x=1754157076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSxbEUJxkP0g7ZjvYqH7NhSZ9AP/JqKw188Y1XM8KDw=;
        b=trf9btl8mwV1/Ey6vjraqqAlF4VPR3g/SCL5chz1o9kbs3oxXAVg2EWrd75DfKudPx
         J6fT5ezlDZNg35q7UXvdl89VNb128tNn/3pjyc3BhjHsbrX7dEQhFsRRkFhuZvNE4vMV
         Lya4oD+m6Eq061vPEParEmplzjQGqh3H2iwtAgwIkhklyUnUI0+fRXhuksMT49fJDIP2
         wgjq7wHSfWFGIKtAw9MTkVE3VVakX3eulAm590spfulgKNehQTjckcjByr5PdaQZVlSE
         +jwBztdkbBYdQ8hiObDsWI95mvrK8nvRUcomWt0sCr6WX5nN/NhK1kUs0Et3RzSh5eoS
         y7WA==
X-Forwarded-Encrypted: i=1; AJvYcCUkzC4phcQSER+HGxzAER6sCzXNjuZUrVh6d38AZWSOKKak5Os//yJXKI+GSdGUaOY5ogv+xLhiwHTBLUGrmERXRM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbBZwrkONW7qxSuwQOrbLkvjqh6rfJZT5qHWNILbC+O4RKqrgK
	YyZ/gaQ/WmfGrHhL6xbhlLCgpwEAeQQS5Jx3kC2pI0x3n+fO5wRANM85MZqcVxyJ0IaeU1mKT2w
	5A735gUQ=
X-Gm-Gg: ASbGncvx7IfbLfP4DqUjYPrk4nnAF5u3pmPj0pcf2Z8MZTHV8uUageXM42/jsDTrKlA
	afNU6PWQx55EEOnf0pAZIepNHVr7wKbbY057v2Qu+yag9twU4l7NiDZVxo7ZeD5T89pYXxwG91l
	7z6TXuUiG1xM51xtvEPMyyGbD7hYxgDjpdguF7uKyLiN9oohQg9Gm1jXmCkzSJZUgkJR1SykyVI
	9yk126yC1m9rgnvIzEelz2RrIMUV8KdyTDSGSS6AkkTYm3xTtcsSwdeYm9BMOmS03ZiQotSK2DY
	+KJAfGowQs0yMfiRVvMUsFhW8t52B8zey4yCjJJyBQHTzR9YjI04jD5RGXlr0cEj1PCx/FFLkQp
	pmvYWIV11Fr3cAITMA0zPIocJxb5hBS7JOlJZsNPOR12t2nA51zVOtf2/y6MmF/K14P9VP5Q/
X-Google-Smtp-Source: AGHT+IGOyKlaUlM9p/10WBKqWLH1kAL+nD44hK1wqYFWziJy9+J39xBk7vREEpjEd+kDQ1YpWVSXtw==
X-Received: by 2002:a17:907:3d0d:b0:ae3:a717:e90c with SMTP id a640c23a62f3a-af61c8a54afmr659385566b.23.1753552275576;
        Sat, 26 Jul 2025 10:51:15 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a61103sm167867466b.70.2025.07.26.10.51.12
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 10:51:14 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo5632560a12.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 26 Jul 2025 10:51:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXD19nTaTIXpnurFW+2H9jVZG9Y5F5tgEeSGHGiBMvIldQOUnDU6N+BIqYTlcZ/3SnkQPgsxZGxJhMulgauPnN+Lo=@vger.kernel.org
X-Received: by 2002:a05:6402:14d:b0:611:d10e:ebd7 with SMTP id
 4fb4d7f45d1cf-614f1da658amr5711204a12.19.1753552272125; Sat, 26 Jul 2025
 10:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724123612.206110-1-bhupesh@igalia.com> <20250724123612.206110-3-bhupesh@igalia.com>
 <202507241640.572BF86C70@keescook>
In-Reply-To: <202507241640.572BF86C70@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Jul 2025 10:50:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
X-Gm-Features: Ac12FXwUXdIlVLvMNocbefDF6HEUwlAESHc5g0TBeq7Fw2jKEkXsJpBWks3U_Dc
Message-ID: <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
To: Kees Cook <kees@kernel.org>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, 
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com, 
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org, 
	david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com, 
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

, but

On Thu, 24 Jul 2025 at 16:49, Kees Cook <kees@kernel.org> wrote:
>
> Why not switch all of these to get_task_comm()? It will correctly handle
> the size check and NUL termination.

I'd rather aim to get rid of get_task_comm() entirely.

I don't think it has ever made much sense, except in the "guarantee
NUL termination" sense, but since we have basically agreed to always
guarantee that natively in ->comm[] itself (by *never* writing non-NUL
characters to the last byte, rather than "write something, then
overwrite it") the whole concept is broken.

The alleged other reason for get_task_comm() is to get a stable
result, but since the source can be modified by users, there's no
"stable". If you get some half-way state, that *could* have been a
user just writing odd names.

So the other reason to use get_task_comm() is pretty much pointless too.

And several of the existing users are just pointless overhead, copying
the comm[] to a local copy only to print it out, and making it much
more complex than just using "%s" with tsk->comm.

End result: all get_task_comm() does now is to verify the size of the
result buffer, and that is *BAD*. We shouldn't care. If the result
buffer is smaller than the string, we should just have truncated it.
And if the buffer is bigger, we should zero-pad or not depending on
the use case.

And guess what? We *have* that function. It's called "strscpy()". It
already does the right thing, including passing in the size of a fixed
array and just dealing with it the RightWay(tm). Add '_pad()' if that
is the behavior you want, and now you *document* the fact that the
result is padded.

So I claim that get_task_comm() is bad, and we should feel bad about
ever having introduced it.

Now, the tracing code may actually care about *performance*, and what
it probably wants is that "just copy things and NUL-terminate it", but
I don't think we should use get_task_comm() for that because of all
the horrid bad history it has.

In other words, if "strscpy()" is too expensive (because it's being
careful and returns the size), I think we should look at maybe
optimizing strscpy() further. It already does word-at-a-time stuff,
but what strscpy() does *not* do is the "inline at call site for small
constant sizes".

We could inline sized_strscpy() for small constant sizes, but the real
problem is that it returns the length, and there's no way to do
"inline for small constant sizes when nobody cares about the result"
that I can think of. You can use _Generic() on the arguments, but not
on the "people don't look at the return value".

So we do probably want something for that "just copy comm to a
constant-sized array" case if people care about performance for it
(and tracing probably does), but I still think get_task_comm() has too
much baggage (and takes a size that it shouldn't take).

"get_task_array()" might be more palatable, and is certainly simple to
implement using something like

   static __always_inline void
       __cstr_array_copy(char *dst,
            const char *src, __kernel_size_t size)
   {
        memcpy(dst, src, size);
        dst[size] = 0;
   }

   #define get_task_array(a,b) \
      __cstr_array_copy(dst, src, __must_be_array(dst))

(Entirely untested, hasn't seen a compiler, is written for email, you
get the idea..).

But I think that should be a separate thing (and it should be
documented to be data-racy in the destination and *not* be the kind of
"stable NUL at the end" that strscpy and friends are.

               Linus
