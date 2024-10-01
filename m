Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC932913
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Oct 2024 01:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727746428; cv=none; b=kgue8K3HytpD3JuK2VNPUFweBaOsQ+J3QvgjgwO81ZgLcodnmWDPBx78YT5UgwHx+7IweYgn/wu2qIg+U+Fecy1Sd6mQlan7pVt9vV0CNi5rMZYfXqOn/ZR4AcaYvxW6JrKrplLldZdl+KQ4bkROxNU/BSmsIrou+2Hum0ZHPjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727746428; c=relaxed/simple;
	bh=5NHLulPUM4wU7bPOT4jXfKIxd1JekEGRQ90/BVn6F9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7uRPlRQ2FXrfYNqRdxGcttmixTh6BjSyQ8MlUxfNVyItwfJWc4AmkkT5FkyZMK9CqR/qVK/kecnunVpGd1Mu7XBg+lU2A76BbiTCobDrDXOa7ZRxEI2EWHw2km2+FLsQSG93fUmj4oWij9kSyGGMocNxC1eQvR/e79ixJR/qA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUdAqaJq; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUdAqaJq"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a3525ba6aaso6490525ab.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727746426; x=1728351226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=58afsIDq7dgIRgRBrkCELksOoL87/pUmrrFWK4tAdKg=;
        b=iUdAqaJqrcUDo5zySL5ZlSfn2DwIvi7ialgeuJmgCxsQmJR/ik+XUW5zrOWb3RMhxA
         b5pE5ed+lG1xdENkJOmgNiz1Jaz/OYzcyr0HTHxFG5Kqkx0sChIwxjyK8vrYVFbUzFL1
         Ld3K/KR8+LnGNnI8LsZPi4j/jPJ/ovUOL3biQHXemyh85OORUsrJqeQn8EBAReSj+XDH
         8v/SET4SwVEMhQZZI7yJ8MH1cz2DxAqItTh/J/1mQPh+g5F+r4GzPTzNT9HU9p0KZRBJ
         3NlvsFLESPPwiSuQIVYk8AnUV55eJYNMvuxxtiVtM55iNsEypEWXhnLTG2z/VQMxzlSI
         H1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727746426; x=1728351226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58afsIDq7dgIRgRBrkCELksOoL87/pUmrrFWK4tAdKg=;
        b=IR58sB5OF+vnO8jQIxdkDNoo5fDN4FqEtzuX1srbnUerKswdzIU2boudn8ePxxn661
         g+URqy4t9Xxfu91KOTGRSPYQzLD/M46T4WM7+1SujNtwGg8vzUh/df5dnYfxOdBWc3Hr
         xFT8Cb4xlCmi4QtdQx2oqBZBQvn91KagBozH0IaWQwLaP3zY1fvz//a3umPrfvPj+pXP
         Ke3S02LPLAxxx1DIuTcOnrr76/VGJcs/ldYioe4ssgOw50gE1Y5KLNpyMLsePZoogB1M
         aa8n2BU3FoXenKAmjcwP6L5C8GObUiXZywnX1tS+tQVJ0Vuo7jk3RPymR0pJntpbBzCM
         +KYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEb0pMaLKjpKojOwwAu/YYksz/HorsCcpJBo6IWVrF4x3zxBFhuPJJcgmMZALUpopaxZXS24OiXqK3iIGfFVP30pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxBcDQFNWfxhJgOB9f20lox758Txxn3UaJkaVRabPqqyArayS9
	KL0eL/BviI80w6SjE0jdncEqCFPtZtm2dE8xjwzMuhkIgUCM7zTCefDpcmO4qQ==
X-Google-Smtp-Source: AGHT+IH0poGYB56sfi16XYYhcqjuHorzltOHy2negMWUdNvyTLzV0J/udZiCfwU+JhAIljXgCGmfcw==
X-Received: by 2002:a05:6e02:1a6e:b0:3a0:8c5f:90d8 with SMTP id e9e14a558f8ab-3a34515ad44mr113156925ab.6.1727746425864;
        Mon, 30 Sep 2024 18:33:45 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344de1e7dsm27791695ab.59.2024.09.30.18.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 18:33:44 -0700 (PDT)
Date: Mon, 30 Sep 2024 18:33:41 -0700
From: Justin Stitt <justinstitt@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: yang.yang29@zte.com.cn, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] tracing: use strscpy() to instead of strncpy()
Message-ID: <yhv3rzg6vhgwage27cyvg72t4vwf5x3tdtj3zjipryzvz3u55x@c33q753uxyi3>
References: <202301091939219689840@zte.com.cn>
 <20230124121703.1e3a1ac4@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124121703.1e3a1ac4@gandalf.local.home>

Hi Steve,

Can we revisit this patch? see below.

On Tue, Jan 24, 2023 at 12:17:03PM GMT, Steven Rostedt wrote:
> On Mon, 9 Jan 2023 19:39:21 +0800 (CST)
> <yang.yang29@zte.com.cn> wrote:
> 
> > From: Xu Panda <xu.panda@zte.com.cn>
> > 
> > The implementation of strscpy() is more robust and safer.
> > That's now the recommended way to copy NUL-terminated strings.
> 
> But the string being copied is *not* NUL-terminated! And this change causes
> a bug.
> 
> This is the 3rd patch I've seen that blindly converts strncpy() to
> strscpy() and causes a bug in doing so. Not very safe if you ask me.
> 
> > 
> > Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> > Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> > ---
> >  kernel/trace/trace_events_synth.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> > index 67592eed0be8..cd636edd045e 100644
> > --- a/kernel/trace/trace_events_synth.c
> > +++ b/kernel/trace/trace_events_synth.c
> > @@ -195,8 +195,7 @@ static int synth_field_string_size(char *type)
> >  	if (len == 0)
> >  		return 0; /* variable-length string */
> > 
> > -	strncpy(buf, start, len);
> > -	buf[len] = '\0';
> > +	strscpy(buf, start, len + 1);
> > 
> >  	err = kstrtouint(buf, 0, &size);
> >  	if (err)
> 
> 
> Here's the code being affected:
> 
> static int synth_field_string_size(char *type)
> {
> 	char buf[4], *end, *start;
> 	unsigned int len;
> 	int size, err;
> 
> 	start = strstr(type, "char[");
> 	if (start == NULL)
> 		return -EINVAL;
> 	start += sizeof("char[") - 1;
> 
> 	end = strchr(type, ']');
> 	if (!end || end < start || type + strlen(type) > end + 1)
> 		return -EINVAL;
> 
> 	len = end - start;
> 	if (len > 3)
> 		return -EINVAL;
> 
> 	if (len == 0)
> 		return 0; /* variable-length string */
> 
> 	strncpy(buf, start, len);
> 	buf[len] = '\0';
> 
> And you are replacing the above two lines with just:
> 
> 	strscpy(buf, start, len + 1);
> 
> 
> If you noticed, the string being placed into buf is:
> 
>   "char[123]"
> 
> Where we want to copy that "123" into buf.
> 
> strscpy() expects the source to be nul terminated, or it will return -E2BIG.
> 
> So the above will *always* return -E2BIG *and* not end buf[] with '\0' as
> if strscpy() returns -E2BIG, then buf[] is not guaranteed to be
> NUL-terminated.

@buf should still be NUL-terminated while returning -E2BIG in this
instance. For context, here's the implementation of strscpy():
  ...
  /* Hit buffer length without finding a NUL; force NUL-termination. */
  if (res)
    dest[res-1] = '\0';

  return -E2BIG;

... and the only other spot where we can return E2BIG is way earlier in
the function where we check the count.
  if (count == 0 || WARN_ON_ONCE(count > INT_MAX))
    return -E2BIG;

So it seems we should be NUL-terminating @buf in all cases, considering
count is greater than 0 and certainly not larger than INT_MAX. And, with
the `len + 1` we shouldn't be seeing any data loss either.

> 
>   NACK!
> 
> -- Steve
>

I'm keen on replacing this instance of strncpy towards the goal of [1].
If we don't want to use strscpy() I think memcpy() is another viable
alternative (of course leaving the manual NUL-byte assignment as-is).

[1]: https://github.com/KSPP/linux/issues/90

Thanks
Justin
