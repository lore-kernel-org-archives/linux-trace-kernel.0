Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14FE1CFB6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859180; cv=none; b=AUcDrjOEyGKCs0Be2jB/5xDw6Z3Dzz9K1N6mnYeIYCKySjgZDTnptRrzHTC3f6rjU9flK1JYGXJkZPSVJF722BaH1oUFS+718nohf2xFQQQfLVbuVIChfYzLUlCuLDrbNGm/kzoIbbe57BBABBXk4/UGf9OQL7MORitIsfPDJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859180; c=relaxed/simple;
	bh=7TJwwryli1eiXxuuyYraxu9ShumGwrwu09I+D4SuiqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3dAPnCehpCe/xrC/gnYXQA2zlx5b1/1kmUa2xLjqWhYdZcH6NxTx/DssEhlPGBoOw3kgZm9QLkX5L8+eGLQMCYhKaiirohm0qorTpOCN3T1JRc7UwZHKDTBw9f8ryHvyZQv88ad7LndzZqsN/c8/N84erDFfCYikeycw5iXhXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TyReYxEN; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TyReYxEN"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41467d697a2so3089275e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710859177; x=1711463977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+YYgQidQ5be3lwh2CXbvA3hpQugIfZRQu2ICyfEDrs=;
        b=TyReYxENqHHkj1K4zVCtmM2ZzoXT0hcFebDYlFu52FBq4T90ZsM7Ww+1rLiYwz85PS
         pfeW4/4cYA9DSkWlaakFYyfNXToZ+YEQAKW8Td47FGF09yK8ZAVyx9ve3oVReawjEtpQ
         GWSkToj3rQpAGrcQ0XuvAa1Mv/HznGbsVPT6CF81elywpxzKf0Ip2cudQ5aKvDKH2RY/
         kqvEvR2aSg0mfSKexnLX6I1ImOZShdRICcR634OJsj29UUsTC58bbparUYg4UTcHa97D
         MXGrzZqNOcbckSh85AR7aN0GdzbJCopk8acFP3BvA63Y+qz4xUfnn6DDi28cY/CCk4QJ
         56Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710859177; x=1711463977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+YYgQidQ5be3lwh2CXbvA3hpQugIfZRQu2ICyfEDrs=;
        b=YeXRBs0xG8bvyQkNPEdpqbJi1myfJLumDEsH2rEf6OGBfQfyS6BPYNPe/3GChkf1G9
         +O05I0veVadt6J+rFS79+APUqObWtWINpCggAAt8c3lO0HRfwKmKULNQPNaTGoI01oF+
         SHwHZtKxY3UipWPjN5r1fTHTzPWSWtc5BYJbnnuh1jJEJark0qHFkk3Z5HjfxPKMevhP
         rK930wZt+d5bH4laOlAwanKQteTM5uiOE9g74zu8nD41kOjyveZyO8N8ZJt2zJ3zEfoV
         lVOZuCxFBvi8Kvqtrn34RrKJlcLH4PVby2PvCvtgCbfF4MmI4hlNCw8qnXRnJOv/kyyW
         FCSw==
X-Forwarded-Encrypted: i=1; AJvYcCV2uq0BMN0O0x9jecMhTTSygUHFxzTACVYmANXJ5J1csJoG6uEbmicPyur/zmtNSgMWvOxwnaOU1lgkn+Bj8RF2NDkDRcrOpUMZ67iQ+CY/Dts3
X-Gm-Message-State: AOJu0Yw45M7+9Iaqv+quVVjn1a3+xvPg5zYPSxQqhRL5H8hXmeYVRSVe
	1uFH0Mfh6LO6nmBSSmmhpwzbkVwEOGip/EbMmbZJB+V35qlKnOEUm8/qvK8Y16Q=
X-Google-Smtp-Source: AGHT+IHnm7hNGc5vPjP41iBhSl0n/yWybGfkv5VNbtAmH1xGLZXWvP5rIsgdhVtbqQg2foO9n5kRWQ==
X-Received: by 2002:a05:600c:1913:b0:414:630:26be with SMTP id j19-20020a05600c191300b00414063026bemr8444477wmq.31.1710859176602;
        Tue, 19 Mar 2024 07:39:36 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id hg5-20020a05600c538500b00414674a1a40sm1528424wmb.45.2024.03.19.07.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 07:39:36 -0700 (PDT)
Date: Tue, 19 Mar 2024 17:39:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] tracing/probes: Support $argN in return probe
 (kprobe and fprobe)
Message-ID: <5d0530e2-43f4-4570-85f6-8404d0b3fea9@moroto.mountain>
References: <b010488e-68aa-407c-add0-3e059254aaa0@moroto.mountain>
 <20240319101000.4dbe0cc5@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319101000.4dbe0cc5@gandalf.local.home>

On Tue, Mar 19, 2024 at 10:10:00AM -0400, Steven Rostedt wrote:
> On Tue, 19 Mar 2024 10:19:09 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > Hello Masami Hiramatsu (Google),
> > 
> > Commit 25f00e40ce79 ("tracing/probes: Support $argN in return probe
> > (kprobe and fprobe)") from Mar 4, 2024 (linux-next), leads to the
> > following Smatch static checker warning:
> > 
> > 	kernel/trace/trace_probe.c:856 store_trace_entry_data()
> > 	error: uninitialized symbol 'val'.
> > 
> > kernel/trace/trace_probe.c
> >     846                 return;
> >     847 
> >     848         for (i = 0; i < earg->size; i++) {
> >     849                 struct fetch_insn *code = &earg->code[i];
> >     850 
> >     851                 switch (code->op) {
> >     852                 case FETCH_OP_ARG:
> >     853                         val = regs_get_kernel_argument(regs, code->param);
> >     854                         break;
> >     855                 case FETCH_OP_ST_EDATA:
> > --> 856                         *(unsigned long *)((unsigned long)edata + code->offset) = val;  
> > 
> > Probably the earg->code[i] always has FETCH_OP_ARG before
> > FETCH_OP_ST_EDATA but Smatch isn't smart enough to figure that out...
> 
> Looks that way:
> 
> 		case FETCH_OP_END:
> 			earg->code[i].op = FETCH_OP_ARG;
> 			earg->code[i].param = argnum;
> 			earg->code[i + 1].op = FETCH_OP_ST_EDATA;
> 			earg->code[i + 1].offset = offset;
> 			return offset;
> 
> But probably should still initialize val to zero or have a WARN_ON() if
> that doesn't happen.
> 

Most people use the GCC extension to initialize everything to zero so
initializing to zero really has zero cost.  I always recomend people to
do it.

regards,
dan carpenter

