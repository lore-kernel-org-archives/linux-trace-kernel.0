Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018C2882D4
	for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760279531; cv=none; b=qj+pWlPOgImiobmoa4yyavoIhqjGgdXrncdGeH5p6lHrWWX18kAvPHifKBdwwS7IUA7ErLPqPK5pzp3QsA7Mf6YYSTIWZe+AW+pYkW6BOZYucGECkIiUOmvygVW45sNitq5a0Rz6WLJ3+keHFO2xY+ZX2xYMYJDOsMGix7+AEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760279531; c=relaxed/simple;
	bh=exVDaTCv2o9KGqW9+Cgff31C7B8DfZakECaMCpf1bfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvR3UxkPFjkwnV6UGJNhMRkUAtZyoRYMIP5HQl5ShRodm0KyOrmMciKHkZ2Rja+0B1Anw+ttyTl0q4nMe1JZaNBIZkzPSpcY7hyESvKNrfTIlw5YgswItiY8zu/M2XFUMmu4kC9gqGWoCeH2tAno+5NHhN7TQ60iGw/2odAxJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1s89k26; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1s89k26"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-799572d92b0so44059496d6.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Oct 2025 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760279528; x=1760884328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lafAVcrEHvdofnatEPGKT/Xtct7Xl7DSjL6fT41f0Sw=;
        b=K1s89k26nbYzSwwGw7yMYiYrRjewHFeqMCWTkxii0Kk1TGe8AJjnPIhBf9DswDh9AP
         Pc8PZkqx8PU/oLLaaseQlS2cn+adpK50u3OR+RUldZVfZbHOgIHTkf2j22hZCKR1/bY8
         K+WzATCb/aJGKL21QkWActjsYo1QICYWvUqnwm7Y23ReLGJMDnVIHhQ2nCvoLuAZDF4k
         MFpNBR0+2pc6q0LW7u3kXC9ZmsMz65gusX7+PngKjBo7pwiyG8Q3ip7uRmtL6kKVKXvC
         P35XoF+hOLRCfEMQFis3zy8k4eGD4BO0dwAafZG96RutusvGhhC7+CY8MhB04M5dSkS+
         lJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760279528; x=1760884328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lafAVcrEHvdofnatEPGKT/Xtct7Xl7DSjL6fT41f0Sw=;
        b=BpjAmMpSIxtR2fXuPId1jeGEOcEwzFuACocrKqi8EeBK6W/vBZO5G/cUw083YGy51n
         ztr42Rm4fcVg8tI9kCjii0Vs922Nd0PIvlF7mDYNcERtN3kKclJ0n2d/DA/CHRaic8pa
         8hc69Zsm2bnkR9FsXSMTob5rNL5brX1I19lqHMswgz5bVt6T9FF6j9xn7jjOABpCtoWx
         U++6lPZZvCwf19nLEtGiKHgZ3XRFlYnrOGJETy6WC19/IAJP51gUAdNZSCl7wOUQszrj
         jvfU/nYW6SRxG4UDX67b99jS8pfqsyhNtCr5aYtyRjJbcS/oeOujGXOw+VtfCCymvy2h
         gPhg==
X-Forwarded-Encrypted: i=1; AJvYcCUlW6gKwchckA84rNscdt0vNWhGE0uKQnlEnZmeIB8cySLQofXbzkjGNGYyK9fGBNvHbUVWrBZ0HetovsaRWlmSuqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Rq9lZh0zSOaXpOxabYcZY/ku56ukK/BMAjCjSV1n2ew/tMdM
	571PxMqmlCVSRW3iMB6DGMZMUpjmPvI1ARYPW06wV+xovqksY8SD3eXl
X-Gm-Gg: ASbGncs56PF5LlHG8xvjvM9uDUTuMdmeGOwByG6Bi9dZK1E87ifjTJ341aW1u27kXZb
	1BbvNcOttF0hITCp7y5hNDhYdQ3IAP2l/E9ArfQKBEctCxr3/FJzxfaqDD+3HHhLjYIgJECZee4
	uXZ9XR3VLv21TkebxqWLOa5mko3Q/HKjCAFctL6QRENLjN/xDXnxDP5FVcS3tpThQNTWUkUMymL
	S4bEYk4GjlTZpbsZfKOJRJtQnO7AQexnh87j4ObtCJ2dQiPDx285R25D7LdZj/XRmRTgRE8NoQ8
	0QPwJDWYJgHWm8mWWNOGJw/8W7ggOtikN1Bmf6gb+lMG2HTfIXnYmylpIs3O8fmFDRHNBiohHk5
	wUO2O+6FnEKK8BbMULuPeY2/9JP853aqxYJ/TtYYsZzg2xkgtcwsC
X-Google-Smtp-Source: AGHT+IGylxeC57G3HP7/1vZXTCP0woc3CF/bb9piQD8YyNw88k6+Ampz6Ayo2XWXeOakyOz8ZMmEgA==
X-Received: by 2002:a05:622a:30f:b0:4e7:222e:6725 with SMTP id d75a77b69052e-4e7222e7357mr20155591cf.8.1760279527640;
        Sun, 12 Oct 2025 07:32:07 -0700 (PDT)
Received: from gmail.com ([2600:4041:4491:2000:f887:3bb2:9bc6:cbb0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc35930f3sm54042686d6.43.2025.10.12.07.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 07:32:07 -0700 (PDT)
Date: Sun, 12 Oct 2025 23:32:05 +0900
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
	hca@linux.ibm.com, corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/5] tracing: fprobe: require explicit [GROUP/]EVENT
 for list/wildcard
Message-ID: <aOu75evMUGF8pBxE@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
 <20251004235001.133111-3-seokwoo.chung130@gmail.com>
 <20251008095316.cf24f13a84a454ddbf530120@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008095316.cf24f13a84a454ddbf530120@kernel.org>

On Wed, Oct 08, 2025 at 09:53:16AM +0900, Masami Hiramatsu wrote:
> This should be a part of [3/5], because when bisecting, the test will check the
> README file and check the feature.
> 
> Thank you,
> 

Ok. I will fold the readme_msg change in [3/5] (the patch that
introduces :entry|:exit and keeps %return for single-symbol input) so
the tracefs README matches the feature during bisection and for tests.

> On Sun,  5 Oct 2025 08:46:56 +0900
> Ryan Chung <seokwoo.chung130@gmail.com> wrote:
> 
> > Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> > ---
> >  kernel/trace/trace.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index b3c94fbaf002..ac0d3acc337e 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -5524,7 +5524,8 @@ static const char readme_msg[] =
> >  	"\t           r[maxactive][:[<group>/][<event>]] <place> [<args>]\n"
> >  #endif
> >  #ifdef CONFIG_FPROBE_EVENTS
> > -	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
> > +	"\t           f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]\n"
> > +	"\t                (single symbols still accept %return)\n"
> >  	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
> >  #endif
> >  #ifdef CONFIG_HIST_TRIGGERS
> > -- 
> > 2.43.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
