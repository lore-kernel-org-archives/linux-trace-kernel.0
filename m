Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E49428D836
	for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760280027; cv=none; b=bY6YjnaU/2ngMx1jQS3KSS8RFto318dcVCQrAd8N8xb2XSkbTTd9I4FOjRXlEuIGpihsZ1374QJAB8W2QN6z9oIZlyxJ+axPxs9MLoonfrFrF5suQTr9AN189Gb88lKemvnKCrKW50L0HT7yVDTW7miGAM4fOaYeYfNjmsyHjxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760280027; c=relaxed/simple;
	bh=Wh5h8R4i6wbyblid+ANW0qxMSJzl7sw5qOnKstak05k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGPPVbUnsqRRjlYHFB3p6jZuRvs+YTcb1CNtSBVQXbg0rxXkrJJwzukhYvgtVRYYsh+5RtnzMf+GLz5L1qRg0f0XxCeCjfAMbgByfJswbBNsIpGJKhPAUFFX7hmQxWc/56J5+CVJi0DUN44Hlg4ujTmd/WmomCDPAgjQdgAYfLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnns5v6s; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnns5v6s"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-85b94fe19e2so460142385a.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Oct 2025 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760280024; x=1760884824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rESNqBlm01rEUHeI+dW4BfRZdaJiZNLBgBxLi9o7AK8=;
        b=jnns5v6smfiu+Q4Mb6oBYc/TSGlQSrShm0RHUTkRgmwwmVxnUd0GaD8hWcIdoYmY1K
         UGiIW4gAb/eCfhw+xQ6lporwUgJgVnIh7Mad67sBhMLcZ2lj1cst/IkncdZx/cdphg5b
         7pH67Cid42kmHEwhEMgiBLX+nwFjvjZlx95LSJGkiDv9YK0JpmY0X17ADNQWfawJJV0H
         9dhEtMrGeExZVtDXNClYx8nuqq2rgFE/cZDlEuI9Qn2jHzqXCLU6j6SeoMpkKLE9sBhV
         GCGtKJsI7dBvDueEi4tImtG1j+Amga+FFUcpUm9WmQmiDiaCzW7hYjP9bCcATkz/OcdQ
         XBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760280024; x=1760884824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rESNqBlm01rEUHeI+dW4BfRZdaJiZNLBgBxLi9o7AK8=;
        b=iblDzvLeiiH0PKy/fp8xachKtfB1YcLlyNH69HP+B+6dJ3NXDoTPRES+YpnJQzA3sB
         gpoJL+pZm64UZBRWdz9hT8NeRCrAKDvWTjJX/byQtERkJfhZNWG1Ehp8+zI64i3mobck
         tQEHd5ktscqjW5isKh8QYWquZH8NmaFjW0TrCLWvodZzCKfCHbf2U0cJoJmIN7te4wZg
         Q0l08HHl6MnblTj707YsY0P09Vmv6e3mf/KMWQBARbZGfzI7rWa6giuebJfKLRnfBQvX
         HQS089lYpSCbKyj/UPsyXfQYqoVbLzJ3SmNH7pQw5RhXmXQ43iw9zZJ+uq1D7pJSiCuG
         hJuw==
X-Forwarded-Encrypted: i=1; AJvYcCWMNHRlKTHjLfu5UM06mzjVacYufZwvUzOmGBNU6e0SpCfzdUEtTcwrmi0awP/z6KVprlmio8d9q9fhADp/KXTeNxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGaR0uiosEkMRs3GGZa12uuwl02mSgLEitjHCWoydg0LPHY+VQ
	NuZhE9QtRzGhzweyc0EG2b8bUWmdYIAqgza2J43cA7kNbgdu5AbXCt81
X-Gm-Gg: ASbGncsRe6gNL2HiqHFnY/eq6YMNCrirR8otzAty/f/2mApqDvMXKJosJwUUcWakQE9
	5HmAOlYJz+3EazXWyWaSaEV8csx7y73Ik4mGAMKxqsvuAaBztssBy+SriNhvSvTGnyL/glkc23+
	0FPqrLyFzKo+ElX7jpkicvJOuNvbFWZQtfS8lg+YlTH+e5R+ufAQr21YbSpLatXj3ULqWsrgCvx
	zz6D6eIZeJIv0IlrGpaBElcuLD/CmgSTHii85cr4eejn4308WNLqPjAPm9WdxP8CiYVoGYkdlMe
	qtfY340x5/tWd5OrJxcurKQvmeyMBoZYE8+u43RjNXgB1EHXv45KK9cycjp7+c9D/0g/F91LR9c
	x4HooYOgn4Njp2zyq1O/n/w6AV5Gzk+HQDzizGTyjK4c91zcwJoka
X-Google-Smtp-Source: AGHT+IHuKrB+wtc9CHezkXO5L4byllrdW5vET8rdYYUSuvOOINFBAia4TK1dY6/MsIv8M0S8kDpO5A==
X-Received: by 2002:a05:620a:31a2:b0:85b:e8ca:8ac7 with SMTP id af79cd13be357-88350a7c13fmr2517732685a.31.1760280024215;
        Sun, 12 Oct 2025 07:40:24 -0700 (PDT)
Received: from gmail.com ([2600:4041:4491:2000:f887:3bb2:9bc6:cbb0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a23693a0sm797498485a.53.2025.10.12.07.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 07:40:23 -0700 (PDT)
Date: Sun, 12 Oct 2025 23:40:21 +0900
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
	hca@linux.ibm.com, corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/5] docs: tracing: fprobe: document list filters and
 :entry/:exit
Message-ID: <aOu91W3GegRiK8Pg@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
 <20251004235001.133111-2-seokwoo.chung130@gmail.com>
 <20251008100611.6fb5f0b9d49c9d0c403e2670@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008100611.6fb5f0b9d49c9d0c403e2670@kernel.org>

On Wed, Oct 08, 2025 at 10:06:11AM +0900, Masami Hiramatsu wrote:
> On Sun,  5 Oct 2025 08:46:55 +0900
> Ryan Chung <seokwoo.chung130@gmail.com> wrote:
> 
> > Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> > ---
> >  Documentation/trace/fprobetrace.rst | 27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
> > index b4c2ca3d02c1..629e2d7402bd 100644
> > --- a/Documentation/trace/fprobetrace.rst
> > +++ b/Documentation/trace/fprobetrace.rst
> > @@ -25,21 +25,36 @@ Synopsis of fprobe-events
> >  -------------------------
> >  ::
> >  
> > -  f[:[GRP1/][EVENT1]] SYM [FETCHARGS]                       : Probe on function entry
> > -  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS]     : Probe on function exit
> > -  t[:[GRP2/][EVENT2]] TRACEPOINT [FETCHARGS]                : Probe on tracepoint
> > +  # fprobe (function entry/exit)
> > +  f[:[GRP1/][EVENT1]] SYM_OR_LIST[:entry|:exit] [FETCHARGS]
> > +
> > +  # legacy single-symbol exit
> > +  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS]
> > +
> > +  # Probe on tracepoint
> > +  t[:[GRP2/][EVENT2]] TRACEPOINT [FETCHARGS]
> >  
> >   GRP1           : Group name for fprobe. If omitted, use "fprobes" for it.
> >   GRP2           : Group name for tprobe. If omitted, use "tracepoints" for it.
> > - EVENT1         : Event name for fprobe. If omitted, the event name is
> > -                  "SYM__entry" or "SYM__exit".
> > + EVENT1         : Event name for fprobe. If omitted,
> > +                  - For a single literal symbol, the event name is
> > +                    "SYM__entry" or "SYM__exit".
> > +                  - For a *list or any wildcard*, an explicit [GRP1/][EVENT1]
> > +                    is required; otherwise the parser rejects it.
> >   EVENT2         : Event name for tprobe. If omitted, the event name is
> >                    the same as "TRACEPOINT", but if the "TRACEPOINT" starts
> >                    with a digit character, "_TRACEPOINT" is used.
> >   MAXACTIVE      : Maximum number of instances of the specified function that
> >                    can be probed simultaneously, or 0 for the default value
> >                    as defined in Documentation/trace/fprobe.rst
> > -
> > + SYM_OR_LIST    : Either a single symbol, or a comma-separated list of
> > +                  include/exclude patterns:
> > +                  - Tokens are matched as symbols; wildcards may be used.
> > +                  - Tokens prefixed with '!' are exclusions.
> > +                  - Examples:
> > +                        foo             # single literal (entry)
> > +                        foo:exit        # single literal exit
> > +                        foo%return      # legacy single-symbol exit
> 
> So you can explain it in syntax formats:
> 
> Single function (including wildcard):
> 
>   f[:[GRP1/][EVENT1]] SYM[%return] [FETCHARGS]
> 
> Multiple functions:
> 
>   f[:[GRP1/]EVENT3 SYM[,[!]SYM[,...]][:entry|:exit] [FETCHARGS]
> 
> Where,
>  - SYM prefixed with '!' are exclusions.
>  - ":entry" suffix means it probes entry of given symbols. (default)
>  - ":exit" suffix means it probes exit of given symbols.
>  - "%return" suffix means it probes exit of SYM (single symbol).
> 
> Thank you,
> 
> 
> >   FETCHARGS      : Arguments. Each probe can have up to 128 args.
> >    ARG           : Fetch "ARG" function argument using BTF (only for function
> >                    entry or tracepoint.) (\*1)
> > -- 
> > 2.43.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>o

Hi Masami. Thank you for your coments. I will fold this into v4 and make
sure examples and naming rules match the behavior. Thanks for the
guidance.

Best regards,
Ryan Chung
