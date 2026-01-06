Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D503E2EBB89
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767740729; cv=none; b=Cbc+qtqWoUGU5yC1zkD2BJvCeErPOVZezQHFxveG2Ww1m9lT3wEL04jWtylI3jr3Dqhyiu/4Zu/GMA9IEZAaS5o5NRrOOUA2JoFElfFevJIY79HhdMM1Z+75nAxER4CxOzSd3Bukl0WgtarOcFAM7dRKTGr/5jWFlACyPxx9msE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767740729; c=relaxed/simple;
	bh=qDhdsHg500t08EujPpH4z0abJDuCvTZSLH9532pgjUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3gkPU8RZqc3VqTqMMXie/30prw68j7Y/ypuyKkqmSrOCt0D+hyamPG/3pqilbZe5nyLqAHAByANzDW81k1s8ZJ+j4k/2ie4MRXRipSYp4y57SwtkwoDraQg8n1lQaYdYqAisvobaE42wVBiyqDgs/vKMfVA5+8zZsA+NDjGt4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hk1nHiuC; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk1nHiuC"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ae38f81be1so920106eec.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Jan 2026 15:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767740727; x=1768345527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrWh1NMNMKJq1atbYoQOFuGNwGmrHd2hv0Gwbt9ha6A=;
        b=hk1nHiuCOFtsyakZHVZfJTzzPXRI8hIrCmLCiKuz5NFbhQr9LJaQlaDpAmDLbF8f37
         8FCp7/dGw5C4CB66Ghn7sqIc19C5Bfjht5L61kYKO8JXQcwtFIamNPImSQNJxJ8RphX/
         5cTbho8FpnOIxCVJQtO8xic8MUB0GSvw/++TyRQIM6PUS9aYCffdZh4O4OfeNUDaGgMQ
         +j61QmV1UsIgt4ZcTtXeMNa/GCpG5uk0EaTi4Z+iEbv6rPOQG+QrPAHNKFeGkiz13b3h
         91Zq2u8LH3812/FXDDe4EjMfwzYMSFEJfn/rgMoSOL7VQjHw9ccbZfBtLy1UQ4uRIzCP
         o1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767740727; x=1768345527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PrWh1NMNMKJq1atbYoQOFuGNwGmrHd2hv0Gwbt9ha6A=;
        b=SusgAzDVyXWRGDw6OihxGEZDrP2M5DZn+qTU5mbYkKMW4y4OLkl9LUBjVz1LesR2uT
         BQURZdkk4mDoR16jYSKbIjtKw36FbuC+ttorXaOTB4rft3QQgg/0axOUC62HNEFISn6Z
         bfGMRwsuA/cS/Zrf7X1v/DJKoIxG+YazLXejcs0hWqp1peHCVNUKyxZu0YpEVjdKpaWL
         1hYLP+Ny8er9W2Z7rF/PDJHN7+M81dPakms5/81bcKg375qN6endlE5qwYFhJWk0wylz
         OC/MhlKBHGvjrsNAYI9Yj4A59dOzLRWMD6ir4IklJudy8YHN7+KulslwErWhgDQIekn0
         RiPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw1mo65RsW77jmqbh6epngJgj9CxHV2pgum71T1Y9UcA/Iv5VmZEyr9G204WuPKg/YgYlzNlWSho98Q+gApHdU6sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxECqabBQLxbXOPYcW/YE87HI59//z0Wer0EyQzR2SWTbSWOFEE
	/OSlhLEovTHQ30qcuexouifIpKckLWyNucFTlJ81Mp5A0VlwN9zezxLi
X-Gm-Gg: AY/fxX6YzaKKccuJaWiZzxELHO7/gYq8SNV6tSPzuDeU2nBKaal7fjqPqga0vurf6Lj
	tJgL351mYgWa3MnSmOjM57U7oSMo4W+muKevQ1D0RKBHjTBaTzSeiHVhGjst3+FUwT9c/5hlFsZ
	Oq0QE27la4D7oKu5gPYXs/6VHHeI6AbMGuTgM7ThND8Ct3KyI4h3s5KtP99q7OfH0CNBYmYAPYf
	zSe8BSC6IstKeJynFlIjqGEFPSHSBvqTT7rfkHb2Y7rsjDgpOJheiMb6rCqN3G/pZEyEuspf7JV
	Y5oqA8zy18iVsPzWv8Y+meq0p1PRM4CRfdm1XrY3dmlhTNLC0hZCAtFZIRKbvYoZ7JkHc+1hCKL
	yiLLqlnHklHxa7Scl9hAHVh7dMVQcOAijVKZGBRny2wTjHa8K/5a8+zqAahmgF4gDX7r0sDWc8b
	KdMDkRCbZMNwmpeJVZrmAQ6R7N
X-Google-Smtp-Source: AGHT+IEDGhuQ4meRR+PYZ6y0FiO9yq8v5Znwcil7S9VZulGnbyyjnVVwgLyVREHTr5cFKEHXCqyvpg==
X-Received: by 2002:a05:7301:578d:b0:2a4:3593:c7c5 with SMTP id 5a478bee46e88-2b17d1f058bmr489259eec.5.1767740726634;
        Tue, 06 Jan 2026 15:05:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a53f0sm5312715eec.10.2026.01.06.15.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 15:05:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 6 Jan 2026 15:05:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Do not over-allocate ftrace memory
Message-ID: <0a9cd12e-6db8-4b41-979e-95f06e9390f6@roeck-us.net>
References: <20260106203533.2896197-1-linux@roeck-us.net>
 <20260106161844.02ab387f@gandalf.local.home>
 <dc80ae8e-54f6-45f0-bf2f-69012c3b47aa@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc80ae8e-54f6-45f0-bf2f-69012c3b47aa@roeck-us.net>

On Tue, Jan 06, 2026 at 02:26:23PM -0800, Guenter Roeck wrote:
> > >  
> > >  			pages -= remaining;
> > 
> > I think pages is meaningless here, as it was set in the beginning with:
> > 
> > 	pages = DIV_ROUND_UP(count, ENTRIES_PER_PAGE);
> > 
> > Which is incorrect. I wonder if we should set it via:
> > 
> I know, I just didn't want to make more changes than absolutely
> necessary.
> 
> > 	/*
> > 	 * Use ftrace_number_of_pages to determine how many pages were
> > 	 * allocated
> > 	 */
> > 	pages = ftrace_number_of_pages;
> > 
> > 	start_pg = ftrace_allocate_pages(count);
> > 	if (!start_pg)
> > 		return -ENOMEM;
> > 
> > 	/* ftrace_allocate_pages() increments ftrace_number_of_pages */
> > 	pages = ftrace_number_of_pages - pages;
> > 
> 
> That might work, assuming that the code updating ftrace_number_of_pages
> is (mutex) protected. I don't immediately see that, and the
> "mutex_lock(&ftrace_lock);" right after the above code makes me a bit
> concerned.
> 

One way to avoid the locking problem without potentially risky code changes
would be to pass a pointer to pages to ftrace_allocate_pages() and to
ftrace_allocate_records(), and to update it from there. I tested that and
confirmed that it works.

Guenter
