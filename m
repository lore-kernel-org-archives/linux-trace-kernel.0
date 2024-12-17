Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C851D5AAC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734474270; cv=none; b=NJ8iWi1hHHNFDAsBUuKiDzdTIQg5cVxF/NlIx4AmvF5yNznExiljZ6rPmCZ/C5icbgT2tcbKNcjCl7Xh2l9gjk0hvnv9CZqH9Qp6uNjaqf+mz+427qCz7ZqLgTKhqHmlAfkoLFYps3fJUYSw+/ZxTolzl9HnlSw/HW+p5mwJMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734474270; c=relaxed/simple;
	bh=tBC+aTX5XAIGgGHuDRt0Rt7ji1vMfYTw+73UoqI64Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PabCboekxbk/ACnxuy7QQJ3m6azizyGO6fQ/g2gV4JGoZKejanoMDJ+XgSp77FbzlucLyThDXw3MT7QecWqjyVzL0rHDt2QwFRzW95+z02R/X57xsXwrCwKpjYKf+1TYH5c/lO85z+QI4RQdI2VuUkOQXgDdJu2duFIcNvdjIiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fgzpu/TD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fgzpu/TD"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa670ffe302so1077615066b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734474266; x=1735079066; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CR25to9Z7LCRWh3Dep4GmmASyUYDd1JTk1/fy6GdpKA=;
        b=Fgzpu/TD8VjcAQDPxN6ghi8UxRPHeSd8X3+GFQPqN3doRlSVg06rjWDNlhvFlkm/9P
         FPYuhJa8Hg4U6IX7oRb+yss3HoghPbcoOGzPYGTc/665a8RdShKfgVmsti8iYvwyi42o
         8q+U3602m649KnxYv3LYmHFkxRKvdHDvFKvCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734474266; x=1735079066;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CR25to9Z7LCRWh3Dep4GmmASyUYDd1JTk1/fy6GdpKA=;
        b=qe2LFq4D9vzgWLQuvZP+FPRWOBHZhaIa37KA3FM8f8EZOziV7yMLK8JHRFbN0OD+K0
         DsrQ19hE40ncvKniAZ0iYqBB6Put3bmpJnDkjPcJRzOw3ModBU0HlMTjFxUtciUZY6Wx
         Nd7d8YAzgzy6grdPKKiEASc7YJbHZnt+tPgIBK6bvMmwdAZ9fN1XTB6Z0DLAYPfqqgAe
         i5dBvVFqEW4ATtU+Si2LlXTjbSSmnmyzaJ9Wi9V7PJ9dEADnzgzQAGDFrIJXYFYhcEkL
         XP0CCxZxORB88VapbHxrx9QKVVvOx4bZiDpQCGU8IlnnkhMfZt/YhTz8AbO9bIxZ0aHq
         OF3A==
X-Forwarded-Encrypted: i=1; AJvYcCVTFHBINVjCMvtt8XhXx74QGDUep1qL0b/jxkntLW/jIhMnH9gXvrl8qNeLW271qJT3zfPZS8W2GNtD/BsM1yClGbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSukvM/kXjZpjZAN9ICSTPLPoCTis6U5xNtipviBkgGL76bWR
	XKGPXN4+4BVwZ34/nfTeO6J3VFGV+Rnz8ZsYU/TYmhEHfb5UL6pU9bti+jy8bYGyjYZEBuh3Ilz
	o78M=
X-Gm-Gg: ASbGnctvHn+oK7dRppRxlT+6e1gvOzMjJ2vKJ8RywKwL91ohLUKe7lcyQ7+OaIs/Eav
	gQ0pAXwgCog4Ijh9JvKos0StWx86Zaqk92N+z9WKPhdXDDOw4k29RWcaiUD6ncZggS9ZEBt9J/X
	+ABTWDfWqHzxe5XWdeof1luvM9pTG9AifkuVYtCrkuSl7/ojj2ArbD66k2cXnxZCYKOHINkj8mm
	YTmVF/Zk/73hL0yM97oR8FAcTKy+ABNHbmDFKvwO+2HI4r1zbFkcC+Jw3AJG1E0bhxXl0SyscsM
	2Kh7amXLlZjX3gX8MJgQahi64So5Uoo=
X-Google-Smtp-Source: AGHT+IHp9S2eAv/u0Kc57a1X5BN6uvJ46mSgwTmo9XNFONCufCETgGP8zbTDjiy3Ll9EqNz0s07/uw==
X-Received: by 2002:a17:906:328d:b0:aa6:79fa:b483 with SMTP id a640c23a62f3a-aabf44af144mr37649966b.0.1734474266515;
        Tue, 17 Dec 2024 14:24:26 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aabc8060de7sm242320766b.53.2024.12.17.14.24.25
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 14:24:26 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa68b513abcso970569066b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:24:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPbq+upuZksBIRDalLPl0HL62YCy/OYo/n49iaRujlcYNv8TEzC1Uqf2JwY/lNU5vXsblkuaidOWLk1bz111OqqMw=@vger.kernel.org
X-Received: by 2002:a17:907:7f92:b0:aa6:bcc2:4da1 with SMTP id
 a640c23a62f3a-aabf46ff26emr33780366b.7.1734474265031; Tue, 17 Dec 2024
 14:24:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
 <20241217133318.06f849c9@gandalf.local.home> <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
 <20241217140153.22ac28b0@gandalf.local.home> <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
 <20241217144411.2165f73b@gandalf.local.home>
In-Reply-To: <20241217144411.2165f73b@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 14:24:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whWfmZbwRmySSpOyYEZJgcKG3d-qheYidnwu+b+rk6THg@mail.gmail.com>
Message-ID: <CAHk-=whWfmZbwRmySSpOyYEZJgcKG3d-qheYidnwu+b+rk6THg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 11:43, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But this will be future work and not something for this merge window, as
> it's more of a feature. The only fix is to add that print_field() code, and
> the patch series that removes trace_check_vprintf() (which fixes a
> different bug).

Side note: I've also been looking at the core vsnprintf() code to see
if it could be cleanly extended to have callers give more control over
it. Some kind of callback mechanism for the pointer handling so that
there is *not* any need for crazy hackery.

That needs some basic cleanups I want to do and that I'm playing with,
but even with some of that code cleaned up it looks a bit nasty.

I really don't want to expose too much of the internals to the
outside, and vsnprintf() is actually fairly performance-critical, and
indirect calls have become so expensive that I really don't want to
introduce function pointers in there.

But I'll try to see if some more cleanups would make it at least
possible to have a separate version. That said, we already have the
disgusting "binary printf" code, used by bpf and tracing, and I'd hate
to introduce a *third* interface, particularly since the binary printf
code is already doing things wrong (it puts things into a "word
array", but instead of using a single word for char/short like the
normal C varargs code does, it packs them at actual byte/word
boundaries and adds padding etc).

So just looking at that code, I'm not hugely excited about adding yet
more copies of this and new interfaces in this area.

(Aside: are those binary buffers actually exported to user space (that
"u32 *bin_buf, size_t size" thing), or could we fix the binary printf
code to really use a whole word for char/short values? The difference
between '%hhd' and '%d' should be how it's printed out, not how the
data is accessed)

               Linus
