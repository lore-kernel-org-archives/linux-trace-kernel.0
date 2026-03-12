Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74722346E60
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319094; cv=none; b=mzlxJgt+QJW8mqsP7NqI/MZ8dntznXeRt0crZuCYZZ95M78ilN2QBAXD5po3oX23oCdSEUN+Joq6RTIQb2a+GZmR6GqbYtIepy9esHyT30+aVn4/MR9+UOXVis+Y+oC1Ttx3bLZb74/I1gEi+IXURlL8NJMiF3vfuXY513ZvffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319094; c=relaxed/simple;
	bh=nIfDf+pZH4rz6UU/6W6FX3WRSUuva6kGMVYjbvPfW7Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjIn5F83jBrjdew75qCbyif6ydHWVfNPqKMVzMt6yaf7EhVcs3ObuVOEVnPrha32351oKp078mQRLhdT326EIT1623whGo/uKWRMbGUIlXPacXGNF48WjXsWXNq2sbQL4HyzLkL2pepog8FABn5C+kl3YvB3XHT1Nlimje0M1S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V62HzhPh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V62HzhPh"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48541edecf9so10134335e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 05:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773319086; x=1773923886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ds8XmIw4rytuzFN00yBWaHDuFdQzJihgPn8GrBJUq+4=;
        b=V62HzhPheVs1Xr15YReTWJfcwWDBTcBxK0+jIw9meBjwne72tj+HMWQNLcT6N9v7tm
         LRmRXJXpC+XBkp+2pcKdumejKBK4dIEaDJg3UnK8kNC2FgDNMSQ6rQ0gL4fW0oARv6Fw
         seAj4KCLtO333IjucFsdlT1qTHLG859miOJ7KadvL98595nTlTLOxFEdsLnEhzKPvcfJ
         dgeoMJYTSfwivwRQcx8apijznnvQ8LhzFVzyMmAkXfAVYDhaugTBxt8mbuSh9Eu87DAP
         xHXXGPagDEJBnZdtbv9Ab2WTnPWiqNnmhVSl8QJnuJkzMawgTzW9WLUURciqtMlZLotb
         wl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773319086; x=1773923886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ds8XmIw4rytuzFN00yBWaHDuFdQzJihgPn8GrBJUq+4=;
        b=Q3IkhKfe0r0ajWmXUs0bGBgZjPGeAfD4rCiG/iWArPGyttZ34dIoMzgGNeRmG7sU1U
         LLYaMaHbCGJL0ADB2tOmM//xRF8hSzircSGPYrYNKiLTEMevTNKXsGBZ6DwIekkfZj6/
         zrzc6ZMAF+8Oom5/z6OQfsxbajGwpF6dwzlJZinziWJ10VBvHKTkKu+AGSHK1vHWUu12
         l0vBPUKR3xOcNp3iV6M3wkyL9BQWbUzIY6OlYNLc1LGJeL+mB61UUOItQJTNuroUtNc2
         1UYVm34eR2pVKs6pKNIFy8MB3Aw/rTL+Lpkl1gwA84LVXCgbYo7VqIzMDdPhfJAApCB/
         lX7g==
X-Forwarded-Encrypted: i=1; AJvYcCX4mJijcSqJ7aMr8DFAhaB1kcYWewNEPHezdkcoOdyvTpB9DR+1RpVaCnmzlCal0JeF4rbW54d9zMmaUUNygleXUaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4onO9vbgWu2iOoDH4NTzBK+O31gew/0GOL26UCU61vrsTyTD7
	E8WWkkHZfHqRF+sLlqIxiv4tjoh1HCMD3qJSpKm6Sc4Mboi38/DKduk9JeyqOkyLYhM=
X-Gm-Gg: ATEYQzzNn3SHJPU2HcAINpKWznKYRMVLPCrXPSH5WQtvN+VjZzE6M5SK3ppeLyLh71H
	iUv3Zj72WfBUV+sClRHch7yWc+UNf1TlaxyEdERf/N0oLMY3tWwP/tAoxCJFMn3swdI67ZguxlJ
	QEup2h231FlbaALR53lSBFExmMyZoRYWVGu7lBNFaOSIHu9K5R89zLmzxkJYBJAHq+lDGV2kP/8
	yLoUEteqOxKg54o2ynd+cwHtdLUKv4/Li9BLyuJonkxcvPh5EAmFThTPAJvUN5OZmH9CoJ+lIAp
	YGmW8zGv/sV3Yhr4kHiu9ef20Ngt0vmGsRgzAIJPdLjwWMOkalm4llNZW1miaP9Wbb0/Fj6oLrr
	6gi3wUuOV6OSGiQlUN5tSwmcMdV03YUhTAyppGkYBwmqs7X6CvXywMUmX2gRJ1PCqHk9bTIWS
X-Received: by 2002:a05:600c:a08:b0:485:2c61:9459 with SMTP id 5b1f17b1804b1-4854b0afb48mr108156565e9.8.1773319086489;
        Thu, 12 Mar 2026 05:38:06 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6bb4sm126330325e9.4.2026.03.12.05.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:38:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 12 Mar 2026 13:38:04 +0100
To: bot+bpf-ci@kernel.org
Cc: rostedt@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, menglong8.dong@gmail.com,
	song@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next] ftrace: Use hash argument for tmp_ops in
 update_ftrace_direct_mod
Message-ID: <abKzrOXHSbWOfc-L@krava>
References: <20260312114746.122174-1-jolsa@kernel.org>
 <ab12d6dc347ea5a2ffe8705e1538043beb0f497b4a906410a10fabeceeb10e70@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab12d6dc347ea5a2ffe8705e1538043beb0f497b4a906410a10fabeceeb10e70@mail.kernel.org>

On Thu, Mar 12, 2026 at 12:24:24PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 8df69e702706..71dcbfeac86c 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -6608,7 +6608,7 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
> >
> >  	/* Enable the tmp_ops to have the same functions as the direct ops */
> >  	ftrace_ops_init(&tmp_ops);
> > -	tmp_ops.func_hash = ops->func_hash;
> > +	tmp_ops.func_hash->filter_hash = hash;
> 
> The comment above says "Enable the tmp_ops to have the same functions
> as the direct ops", but after this change tmp_ops only gets the
> modified subset via the hash argument, not all of the direct ops
> functions.  Should the comment be updated to reflect this?
> 
> Also, the commit message has a minor grammar issue:
> 
> > which contains only the modified sites is always a subset of the
> > ops->func_hash.
> 
> Reads like it is missing an "and" between "sites" and "is".

yep, sent v2 

jirka
