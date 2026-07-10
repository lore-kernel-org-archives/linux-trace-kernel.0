Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3297B3D3D09
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670509; cv=none; b=pmmRYheRb0SyO6H/RVfBEgtyuucSZIZbU/+XlfAV5FXoyB4tabo74cfy3fFulftdNnfOx3E73SuGWWmjgFbvV/sGoRYyH9tNITA4oAbG7zwyp0JPBpE/yEnWntwNKLMONS4cbbY8Yd2Aw+nu79VRUfNXD0eAxBxi4Pi4ATdejb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670509; c=relaxed/simple;
	bh=BSxkRfmMCRO+8TnjSjUC17LpujreVv3sfto3dXisocE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYftAh4OzyMIWJgfoIwyfr12aLYHih0hC4C7O7HCN+ba2mnSPcof3YUOr4u7dxrKaYT/ypaRAFipL4zDZXQQR0IQZ60E8Rvp3QxBnl7k1PxhHkdsMZ1WsqLmvrNPMNs9xNzO1zZDgVW1DPbWxNQJmccp6Sn2M8xxYV34tLBcAHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FYYOpR/A; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYYOpR/A"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so3905345e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783670506; x=1784275306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZAZ2MW/yOHMxZoLRacs/O/ZQyGb9jH0iCR+T/PVLRLU=;
        b=FYYOpR/AbMxpBJ00Imo1qFHFm/kTD3RWFaTN0VKfJoBHGN+ZOuBirpIZdMelcm3tlb
         /W/r8Om9klndbvYUKA1T0mYIE3/akzVPquDy4lxdkqhqGqxznEUrTO6bR5+tPy16okC3
         HZ1zb5O4KFAuKhFWRNGkpIIAXmYadumSXYMvbbhcHcEOPqbfk+xu1h+NaSVoB/tecmyQ
         aDatiKjQh+Rts0fYGo1YQm7eUv5Q4kiAE8LySXQ0MPID3iQvd2f9rXKPzr9LZ9S8D6e3
         8E6VDSf42BMx13HCthcaXkBYuIhusZV75OtkZOSH+3+XkuYyd0vWErm6ACxZ0Wi8dSks
         SbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783670506; x=1784275306;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZAZ2MW/yOHMxZoLRacs/O/ZQyGb9jH0iCR+T/PVLRLU=;
        b=OJN21VeNtEQttxx0ZjkwD4NPoNm/CZoLEuefvQHjMV5Yam7JwC/vPFlezpoYCIMBje
         UYOJgzZub3KKtHoCWOauvvhYIl00IpvhOkWUgDDLmdARcVfOXmlrIImWSzVpuc+ClHjz
         XvhAyrbkrcSgPtoNFW1TmH7PFJxCQk3gkUhn39oE1ElraQZUHRkiONJEt4th4Ibn69iv
         1hVUA8ZQWUjcvWM/fztIn+mN5kDbYuaFp/qEmqSiAWQYi+1UN+s9Cr2vjMZkkVdVF2cm
         RiV9VtUNBMKDUzi1mSl2iys9TC6QD0V7kwP241CgRyPfAeyNC5Scts5Q18zzUCTGbAlY
         0EwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rromqe/kBbJru0iIwuOh9Wn4xfrP3VWeRMmikyAns6aWbJ2beJjcbu7pNxP5dFEd6NqK1hED0JEVusXFTSMaFCTTNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTGXhxA3tJRh3ciDP+mTM5VEGse7LhIwCXKihUJr/LAnD7uy4b
	WGcvFrfijaAPJaM4SWX2PlnC9jDWBrf0Si/h+o5d0LWGuhMfJPgpFsTtOPKkDnT0EQ==
X-Gm-Gg: AfdE7ckSDhWciqavHHidyPx2NF3gONWTf2lk6dkP5ay1TPkqis3UZluCZx+ANB6HiyN
	8I36Z7hwUNDqK8iPy2dFgCRQBYgRbc9CLTqXO9W3krvn6Xct90a9W6pubNRGNVmpcsj1f8JdmDD
	dscxDx2ovZDC1IYNWEjkOMwvjeeMZbVLoL+ni/7Kl1zHhZNztBz0alPWegtjR6F3MLTphjSlwnO
	KtmCFfTJtZmuxKZErGm0PCaFQ/zr2NJI4AzRXR4mY1Y+o6V4p/VC24rl0Jhe84UZ3yogIEtmmB3
	rLZ9VhOR7DH87ogQjZj5xjI6d8+FPo/TLdYLJ83UnIgXvCRAxvJk/4oJGH4dhNg5ar12ugXGx3s
	F0Bit3SKbsOtQL8q7pNw7EoB13toIjtrYZ9sSC778kgvZ6FkmpACQPJE/5bk0SMmBiAUoQI987i
	N7E7gCFLSreqQ46tT+9CWs9enrkzBwQ4VyVWf/Cv9Vh2Zp8Hnz9DU=
X-Received: by 2002:a05:600c:6d0d:b0:493:b9cd:1272 with SMTP id 5b1f17b1804b1-493e68c40dbmr63251275e9.23.1783670506031;
        Fri, 10 Jul 2026 01:01:46 -0700 (PDT)
Received: from google.com (137.69.77.34.bc.googleusercontent.com. [34.77.69.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb742a49sm116592715e9.12.2026.07.10.01.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:01:44 -0700 (PDT)
Date: Fri, 10 Jul 2026 09:01:41 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/3] tracing/remotes: Fix leak in
 trace_remote_alloc_buffer() error path
Message-ID: <alCm5fq3UC2JtzZV@google.com>
References: <20260709160017.1729517-1-vdonnefort@google.com>
 <20260709160017.1729517-2-vdonnefort@google.com>
 <20260709191516.7a7ad6f6@gandalf.local.home>
 <alCmOw8l4e-DS44v@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alCmOw8l4e-DS44v@google.com>

On Fri, Jul 10, 2026 at 08:58:51AM +0100, Vincent Donnefort wrote:
> On Thu, Jul 09, 2026 at 07:15:16PM -0400, Steven Rostedt wrote:
> > On Thu,  9 Jul 2026 17:00:15 +0100
> > Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > > If page allocation fails in trace_remote_alloc_buffer(), desc->nr_cpus
> > > is not yet incremented for the current CPU. As a consequence, on error,
> > > half-allocated rb_desc will not be freed in trace_remote_free_buffer().
> > > 
> > > Increment desc->nr_cpus as soon as the first allocation for the current
> > > CPU has succeeded.
> > > 
> > > Fixes: 96e43537af54 ("tracing: Introduce trace remotes")
> > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > This patch makes Sashiko find other possible issues with the code :-p
> > 
> >   https://sashiko.dev/#/patchset/20260709160017.1729517-2-vdonnefort%40google.com
> 
> So one of them is fixed as part of "tracing/remotes: Add printk, dump_on_panic
> and boot parameters" [1]. I can pull those fixes into this series instead.
> 
> I'll look at the rest.

Ha yes this other one is real too. However this is in arch/arm64/kvm/ so I'll
post it separately to kvmarm.

> 
> [1] https://lore.kernel.org/all/20260605163825.1762953-2-vdonnefort@google.com/ 
> 
> > 
> > -- Steve
