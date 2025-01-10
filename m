Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF1290F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jan 2025 05:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736487523; cv=none; b=LDb+CG00P+eR0CQktdGZR/fzQwT23CaJHT0J8hI+fJtw9GLruAt4spUxhNNqGDyPsVY0Gc8o9yS5cylZQovlD5/Waf5aKo1vwCAwlUAd5uEnvuzGbP1lnPcvVXrwBUeW6fHjiotarNJvBPdm/1Hf0aeZEeJ/anjkWyLso0z9tc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736487523; c=relaxed/simple;
	bh=QTPUfbx6R77a/GvDZefKLFi+rweGMBAPjWz6xN4cIsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2dstnJsPcJe34xIuXq9y0Uom8GM6Jlg/WqMU+NKv1HzgcfDHr61FHnMqNEUMC9oIW7mXGr8qj2opHqrwpLGbq9ngxRcaCBQDeqx7oZprduU7NWPfMf+CvDc4ak9wnCLzAlZEIDedNBMS7wKIZxCK3hEmI9EsKdsKBOXJwYbcS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FPSq1yZC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FPSq1yZC"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862a921123so1062267f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jan 2025 21:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736487520; x=1737092320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3uVCnMYGVorPnWCZXIo6ZjHAAwok8CMs3XjG+q+NlDo=;
        b=FPSq1yZCqdLaXTEFbf/50YWHXaQH+RhEOPsY6BfLprK9t/DRH13GKhXFL9IQOfxJJu
         /2z6O+T+UQT2YER6ISNgKkzrvbPr+TiwZ8p0r445sLpTCZEceqXrAnMHC1yN+O7AIJAe
         8dv6YP3xPKzztV5SFQ8ID5v9QQPp8jR+doyojwyVuhoER7KEOMQhlGsbT74ailuRdGMQ
         R2eaXq7UuI5R4h0d521qPERmv6c04wLMgUmH0T/JROKS3M4VeNb+VyfIW3wRoqb2DfPm
         cg6V1bxf/yXIUN5s4VCyvpf3suSQJ8lr7GrSm+bOE34nQ4tFjUTgvYte6MBKXOLgFHWo
         QCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736487520; x=1737092320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uVCnMYGVorPnWCZXIo6ZjHAAwok8CMs3XjG+q+NlDo=;
        b=iXkx42lul0wwUqBn7nx2zcTHXDPoJkZFj382gsgqXgn86gBhAUOMlr+AKL/U+3jtWg
         /R9GSiNY42V9wBgntJKMju2aVLtzKfpW0voVW1PCH/LfcLojdpxK2b3SobFTE6SkLkFZ
         zN6L0S7mMx++xL1UyFhWYNDKRi33SP+LoYtrHXcPE/a/YXqsXEiH1DfvSOf3hRKCMLq4
         ytknj+ILkJ+WWuWROn1LeawHkmRbwYZoqbyodFJCYbe8BiPoHAJ9XDqHj6XwME3e/s1e
         EI4D019K5dGiVIGOh8L+02uux1sZ/4n9kC5+JiQIlmVWVO7sM5CROLL/xj8xIC6kar8u
         V2zg==
X-Forwarded-Encrypted: i=1; AJvYcCV91ut0eVFRafmb7nL1gGVgfsizzQ0A1YVl5ik3HypYNzaWjnV0/Dnj7DuUxgbidd79cTHj10K13gHkSaThMfRaOGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJkcD28Xke7yGdtr/oQTf3fKlHSY4nxsPJiCdV6UKIjEhEmAN9
	s5KByvqJ7t8hTOOyNkYGRbMdS7JWlZm1iBX9lCKLnti5wDTR4HvgDssmbbJ356o=
X-Gm-Gg: ASbGnctP+tp/jMMcPt1+ojHWoRcNZRCvHmX7xsDeacFExIQ/tqXK/HZuEuvGLK3CL4F
	fkWk/QndzlqXTdNtPfcgipJo/UEDpK2ugHvAXIIzyLT0M8C87fiW1hbxn4Ik5QWhe2UWnC6QaXA
	mvOZ9NImmaNtoNtfpluoW3HFreu9POySRrT9TXxGmnMuFgAKL49zN6n/NxT+tUwLQfVzWwudT9s
	STaob/ncZDMFHqb8WF9FEtyDGKX/qKl+OKviWFNjfrSf12lqWVOKIYoiOsAoA==
X-Google-Smtp-Source: AGHT+IGhGi4KgPhrmUw0YIvfY6S58SuiyhRszWUA9YtRmO/fw4AOAqGbt5FVpwm8S8bEzz5woqZjDw==
X-Received: by 2002:a05:6000:1884:b0:385:e1e8:40db with SMTP id ffacd0b85a97d-38a8730a618mr7312117f8f.24.1736487519643;
        Thu, 09 Jan 2025 21:38:39 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b81b1sm3581323f8f.66.2025.01.09.21.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 21:38:39 -0800 (PST)
Date: Fri, 10 Jan 2025 08:38:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Eder Zulian <ezulian@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] rtla: Fix implicit NULL dereference
Message-ID: <16990bcc-c328-457b-a789-0f318d8eaf3f@stanley.mountain>
References: <20250109211358.2619367-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109211358.2619367-1-costa.shul@redhat.com>

The subject is bad because it says "Fix" when this is a clean up
and it says "NULL dereference" when there isn't any NULL dereference.

On Thu, Jan 09, 2025 at 11:13:26PM +0200, Costa Shulyupin wrote:
> The `record` variable is NULL when tracing is not requested:
> 
> struct osnoise_tool *record = NULL;
> 
> if (params->trace_output) {
>         record = osnoise_init_trace_tool("osnoise");
> ....
> 
> Value of `&record->trace` in this case is NULL just because
> the `trace` member is the first member `struct osnoise_tool` with offset 0.
> `&record->trace` just returns the offset.
> 
> Explicit dereference `record->trace' would cause segmentation fault.
> 
> Add explicit check for zero `record`.
> 

This commit message is very confusing.  I would normally not send a
patch like this, but if I did send it the commit message would say
something like:

  The "record" pointer can be NULL in this code.  When we're calling
  trace_is_off(&tool->trace, &record->trace) and "record" is NULL then
  it kind of looks like a NULL dereference.  It turns out that it's
  fine when you look at it more closely, but at first glance it looks
  sketchy.  Add an explicit NULL check to make the code more clear.

Tracing code is generally fast path code so maybe we don't want to add
a NULL check?  If we were really bothered by the existing code then a
better fix would be to add an inline function to do it.

regards,
dan carpenter

