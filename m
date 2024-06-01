Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B0017BD9
	for <linux-trace-kernel@vger.kernel.org>; Sat,  1 Jun 2024 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717281083; cv=none; b=gZdvpGVQek5t09Oh+R1iqDDpRE9o77GkOhLZr1zhFvxkCJdXef5bGFb++PXpAS413HIjaoQgkZ4RBjKYt+5FaijZ2dOGB3HJEHvWhJbpiCi02iylkl6OQ8T90L/ooQOq9v32zU6Ik4j7fwAydicg8fl4I0PfILKmprv5zqqMMBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717281083; c=relaxed/simple;
	bh=rFMuik6wkuNtXHKGkspgDvdX4YfRw4xUp9eXj1XXAhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/ca38V6517+FUPaiJOzuBSfou7OEeSVgpnmTBN5lkJwhEMYcKYvKHo+FB+yIEb63FP4ZBbGC+YRpg0uz9bRh+u3ZHoP21OcjmV/LckfDoyK8LljYrTd4HLhbrD4fdcqq4fgA0STCSJ/uULGlG8PQkj1lQIlWDyPQllL09V9PEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=MYhmkv99; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="MYhmkv99"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-421140314d5so29261355e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 01 Jun 2024 15:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717281080; x=1717885880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZbo561XfWIHgBvmySekggiN2gQefSMXY05ZVlA1bQk=;
        b=MYhmkv99Py0Rw7R3dokFE2DHOdLz+jBfVd7JHnSMN+gBAigWSfisLJ7lp7OSRK+648
         M9cGT8Hzcw9YtOs+2IAEsJzvrg/dr5l5M4BwRvSEG5Mg8Dykjg3SYW61uT+l+9xH+u8g
         igwcLlZDXO6eQJwC3cIaWq4zL50Kvgb/WsHE7tnoAyfuo5groLcyA+5D4QDY4YNo6VAq
         khRAuIzfkB189pmVoejSQTLJSvCQ8b8On3yIBYXUZX/o6CEAiIK2vklR3RsYyUu0s9/E
         NnPXJDRT5TtRMnGDg9Cm4PR0Al98cLn+uiQ7HaZoVWYb6viOVJ4IttKdCht1zGX8WMSi
         Xexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717281080; x=1717885880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZbo561XfWIHgBvmySekggiN2gQefSMXY05ZVlA1bQk=;
        b=lw+ZpawBaW02/BsgOlvZspEbVfBhp2NdaO+SKeBw11Y/lHoDcif8NZUoq2deByiYMQ
         RrrUYo6zPYrYXpnuwS+1zR0f5qgWSHneC4THRMnp6k/4uNLAR+DjW+3WHilYpN1aImye
         mYNg7cnP2R+mW8MuWQ0Jaxmo3ezzqp3eGf6YJjmHi4DjEOFsDCcGqS5ooIKhxxRSrz1x
         02s3bKBfwJsTeJnSGForMsxl+fL2pxtd87YaO+rWQQ0iVaZOzPytmxX4VAL32LWVV2yP
         8x3DjFiH5nFUPl7LCP7JfvnK9gq+qinEq/PnZAXLrx+iedwj7e5Gtrg4qX1lS/cLtX3H
         AqAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF7ilbXBfwPmwJh5nC+guKPYI6JqkqiK1vfx05MHeu241sH10hoIPjPd18fjDSSHxyGHLtvNu4NfyltUW0OZDMYBn30obBwejg3s2kl/Q+y6rN
X-Gm-Message-State: AOJu0YzZCThOB2nyxd3fDqR/fRpz192BmSx4VRoKaoW8kh5oSmagftNu
	tc3GqErT8tc+HZOfUlR7lNv8jC4nMmKn2mZfBUbhmN6TkljI2oVGsbABfTrv7s8=
X-Google-Smtp-Source: AGHT+IHfbQ16/ESCbDfdhRvNrgQE37C2AAjcr2HQe1Exqfame6Csvm3T9BWb8bjJaVLiJ2lhT2dYFQ==
X-Received: by 2002:a05:600c:a4b:b0:421:1165:f240 with SMTP id 5b1f17b1804b1-4212e0bfd91mr46367175e9.36.1717281080159;
        Sat, 01 Jun 2024 15:31:20 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212f05157esm53941435e9.20.2024.06.01.15.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 15:31:19 -0700 (PDT)
Date: Sat, 1 Jun 2024 23:31:18 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/rt: Clean up usage of rt_task()
Message-ID: <20240601223118.zjhp7pgk3wb32abv@airbuntu>
References: <20240515220536.823145-1-qyousef@layalina.io>
 <20240521110035.KRIwllGe@linutronix.de>
 <20240527172650.kieptfl3zhyljkzx@airbuntu>
 <20240529082912.gPDpgVy3@linutronix.de>
 <20240529103409.3iiemroaavv5lh2p@airbuntu>
 <20240529105528.9QBTCqCr@linutronix.de>
 <20240530111044.d4jegeiueizvdjrg@airbuntu>
 <20240531063016.OCMg21Uq@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531063016.OCMg21Uq@linutronix.de>

On 05/31/24 08:30, Sebastian Andrzej Siewior wrote:
> On 2024-05-30 12:10:44 [+0100], Qais Yousef wrote:
> > > This is not consistent because IMHO the clock setup & slack should be
> > > handled equally. So I am asking the sched folks for a policy and I am
> > > leaning towards looking at task-policy in this case instead of prio
> > > because you shouldn't do anything that can delay.
> > 
> > Can't we do that based on is_soft/is_hard flag in hrtimer struct when we apply
> > the slack in hrtimer_set_expires_range_ns() instead?
> 
> We need to decide on a policy first.
> You don't want to add overhead on each invocation plus some in-kernel
> ask for delta. ->is_soft is not a good criteria.

The suggestion was not to check policy or priority but dictate the behavior
based on hrtimer properties set at init. Which agrees with your thinking.

I think the check for policy at init to enforce a behavior is borderline hack
by the way and better to get an explicit request from a task and let the
HRTIMER comply adequately without checking for policies anywhere. Whether this
property should be inherited or not is a good question and I think is the
policy you're after here. Proxy Execution would probably handle all this
inheritance problems transparently, so we need not think much about it if we
agree proxy execution is the way to deal with all those inheritance problems.
There are always exceptions though.. So worth a think.

I'll drop this patch as this discussion has diverged to something else now.
I'll leave this here until others get a chance to comment with their views too.


Cheers

--
Qais Yousef
