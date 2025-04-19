Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88EE86338;
	Sat, 19 Apr 2025 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745054980; cv=none; b=OnWc6IHiiRoVLQiHctsAjWZ+zvMl08gmbTld7AnTnQMn75I++XvZ2NONVwY/A7XKmFsPyvNaRGcfn5nQW+na3cyx+bMXYWDuq22x6vzBiy+vgsBw7fzPMFCEfKVVKlkGtam+F+zJxxrsQ8LLjxNKO3qpIitBQr2b3he/KMN62/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745054980; c=relaxed/simple;
	bh=L3jZIvRFT7zN+24GKgD77xybabb7mNcnO1t8/PPFTbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYGv8AxA+R2vhiMs05SWiXokqkglcNNOnwaG/6uPXU74sguB6pJKFfLG3izDGAUpDkr4TXVTgLh1nVW/jGKjIn7l5KteBhPjZGlVU24Wjz8/AQosHAGJ6FBUCcxG/Yt4LQOhlqI5q217kPVM76lfzSnK/+T+7r+a5Y4j0RkzpXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca1ZV90O; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca1ZV90O"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f0ad74483fso29106506d6.1;
        Sat, 19 Apr 2025 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745054977; x=1745659777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V4aMm4u8KPovDgrH6Sr7DHo7zVlQ5dKxL0+Timy+s2U=;
        b=Ca1ZV90ODxEGh7RpkkgaL8LDHbF37iFQOpdItHoZ7Yn1yzkgXjQ/Jg7GYzfGc1MI4F
         qEkgiQkzpDvC3cRrqpW0mbx1Go/zfUMI9PoOKDn53ANCamO724yTaAZb4phjmew9tgt4
         fZTYK3W0wPImrhBhFaoIUhiAALuKxklA3diNcH/G6qTmxN6dEwB94ya+jXdgTEemGW1X
         P0BTeF1r0mYqJT9GWka6lHh3x3ruLKQ0IeHdGrRQ74WOQd6uFt6IweGx0+QuRiUVSqzD
         cd77Nt8omD94MoPoGbqnE6AxLrw6Kyxq4meBQAzJpveFnsoQ84EIHn440iBSx7B/A3Nf
         yw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745054977; x=1745659777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4aMm4u8KPovDgrH6Sr7DHo7zVlQ5dKxL0+Timy+s2U=;
        b=h0NXuCs0o2nnZFCtkkJVQh4VGcQIW0v6vDZGrfwfJ2aYqgCKDGhnY0seTkI1z547vd
         +OFeERQUmmfGwSgX5NujLB7jnSbn6FPMoVnVRvZnwgqAkw/kLiXFXpGR3LOYrxoyi99p
         TB5H8TmAqU7NZqFKRVvj67R1fjMFxKWGKTV+EMeUgwQO/fNxlJoCUBbdolG3Zz7jEEB4
         DFMeJ8Jtbloq3gZ02cSVSUf5QwtMVBCuV5N6X94BuUS6tfIe4YQEOcayluIoX9jQVOV/
         RAADJWCxOP9aHZGSw4S+8SFBUMLH85MvqCys6Ytl766S/A0+inp7f5vM2r/pyXM8lNTM
         48Kg==
X-Forwarded-Encrypted: i=1; AJvYcCV0V3dusdbuQ4EdRbCx7TWwbSB5nDYBWLCqtwWEtauEzlKxZlSf3Wp/bSi0p+e2YjjJ5k2nxa+8YTr/Gqf8QAW8n3Mu@vger.kernel.org, AJvYcCWDgzLVWIRdVd3p5d4SU243h+BVNMvJizg3lLracxCLK+IWtOJs/1cGOONIkxHRos/evi/GxP0u9BwtNAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLOLMb90/8ffdHNgrCwqKFKyNdL/voBzccI/KAGYGETV/rQ1c9
	HAhRcXh8IHIvDeapdcIqD6YiQZBlRrvkdw8CLn+7aeHE0PS0g/fEIX3fQ1kWcPIpKefaxoz5qFu
	ojU1R0y+zBBc+gATmxht6/NX2T04=
X-Gm-Gg: ASbGncvDbndngubv+SzizgkARC/l34LLzxlSo0UBCIrJ3jCMtttNXlaYB11UDEQUpC2
	w6OuspCL32mu6kiYMDCQYAI7ei9eYvsvwUbtW/g6eOXrO96k2AXkGWC1iiOKQu6gUSmlpb1VO3R
	YtwSTTy2vo/jYH7YXQa7Ytqk5zYXQ7Q4X66G8FJdQ8
X-Google-Smtp-Source: AGHT+IEzSUF0PN2hp/Gtr/+iJqMvfT8qG9nhtQrv9EiomNxhI8pyF8WH8lioqPhwIzbQ5eHBpQM4Hl8d3Xkk+C3gW+0=
X-Received: by 2002:ad4:5d4a:0:b0:6e6:61f1:458a with SMTP id
 6a1803df08f44-6f2c454e561mr99974026d6.14.1745054977419; Sat, 19 Apr 2025
 02:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418221443.1067938-1-devaanshk840@gmail.com> <20250418224555.5b8b8232@batman.local.home>
In-Reply-To: <20250418224555.5b8b8232@batman.local.home>
From: Devaansh Kumar <devaanshk840@gmail.com>
Date: Sat, 19 Apr 2025 14:59:25 +0530
X-Gm-Features: ATxdqUG0pXnNpetJs8q58l01fGlH1NyIhqnV12gdFCtoWWynJdXAqpFRLsa3emk
Message-ID: <CA+RTe_gcBZh43txCyG6hQX5GF0bYbg8swJ5iPm4usanMn8BDAg@mail.gmail.com>
Subject: Re: [PATCH v4] tracing: Replace deprecated strncpy() with strscpy()
 for stack_trace_filter_buf
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Apr 2025 at 08:15, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat, 19 Apr 2025 03:44:41 +0530
> Devaansh Kumar <devaanshk840@gmail.com> wrote:
>
> > diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> > index 14c6f272c4d8..0f2253f3bc8c 100644
> > --- a/kernel/trace/trace_stack.c
> > +++ b/kernel/trace/trace_stack.c
> > @@ -542,7 +542,7 @@ static __init int enable_stacktrace(char *str)
> >       int len;
> >
> >       if ((len = str_has_prefix(str, "_filter=")))
> > -             strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
> > +             strscpy(stack_trace_filter_buf, str + len, sizeof(stack_trace_filter_buf));
>
> Is the sizeof() needed?
>
> From include/linux/string.h:
>
> /**
>  * strscpy - Copy a C-string into a sized buffer
>  * @dst: Where to copy the string to
>  * @src: Where to copy the string from
>  * @...: Size of destination buffer (optional)
>  *
>  * Copy the source string @src, or as much of it as fits, into the
>  * destination @dst buffer. The behavior is undefined if the string
>  * buffers overlap. The destination @dst buffer is always NUL terminated,
>  * unless it's zero-sized.
>  *
>  * The size argument @... is only required when @dst is not an array, or
>  * when the copy needs to be smaller than sizeof(@dst).
>  *
>  * Preferred to strncpy() since it always returns a valid string, and
>  * doesn't unnecessarily force the tail of the destination buffer to be
>  * zero padded. If padding is desired please use strscpy_pad().
>  *
>  * Returns the number of characters copied in @dst (not including the
>  * trailing %NUL) or -E2BIG if @size is 0 or the copy from @src was
>  * truncated.
>  */
> #define strscpy(dst, src, ...)  \
>         CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
>
> With stack_trace_filter_buf defined as:
>
>   static char stack_trace_filter_buf[COMMAND_LINE_SIZE+1] __initdata;
>
> This looks like a text book example of just having that be:
>
>                 strscpy(stack_trace_filter_buf, str + len);
>

Right I have tested it, just using strscpy(stack_trace_filter_buf, str
+ len) works.


> -- Steve
>
>
> >
> >       stack_tracer_enabled = 1;
> >       return 1;
