Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F729D26E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233635; cv=none; b=SZq3KhlNKTIUG7ibFvrZtCAG1BzIm3fZFLFuhXwPgiIHt3G4VizI4p7SKs7vr5dQOpgg0gwUGMhvasz+mdYczU3s+J0P7rQCxWgk2C0bQjIfh1R2dNnabcJ4iHagx+Xc3ZzLYv2AAf8bon4S+0BLr0LrArotKoEghqJMEdfVJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233635; c=relaxed/simple;
	bh=8FozrOzJd4aARdx14DKMa072roWvZt/aUG6mjZwTUR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJ2uDr/W56aLmMdLE6pKRDf08rRvFdZRRQoyZy5cGw41U6f19KMQLQ9shavwFwITZNqDxH715kUg4q2MZ35VVOcjjGUNVrvwqua2xAbzdiF2DTXNHaY/2l76T3I9EACKk0TnRnlK8CmcS4RUEHDnkgTIzyeQ+PMxZvgAf4yFd4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKY981kk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKY981kk"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439c56e822eso8611945f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773233633; x=1773838433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYvluDr19g8cY3EGjzutO/A8uDQ7z+RxFTa+Y5Q3tCw=;
        b=lKY981kkwwKJ/Gb6XauDGtXu5FjweZU50AKsXAR+6TbsCUbCWUdT4j6Ak82Ql8E1fU
         8e4QdYIB6aU2tYD0mQG7+EY9gH1GA0tLQPLZBnRVKvfCVCxN3s8eO39/aZmn+nfVEwKK
         Je14XNUWklpYTDZqcAhb5hQqq8OJmmeKPhYbyo7o7nq2ktmSFpDkXdkypwBytHRRft2I
         pyMnZSgwOT4XsrRGqm74jh8UHZYfkhKMDwlYXl7TNgNivyGHt7nYTl7Ii9ZXYCZTl20A
         FKkdgzIL1nLYtTGBpfnYWscrYVzKgXGdcY7uStUHIbsjA3ioBMQgCaiuCFLPOkAyiVWe
         C0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773233633; x=1773838433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rYvluDr19g8cY3EGjzutO/A8uDQ7z+RxFTa+Y5Q3tCw=;
        b=L9Ofi/nHOHZ5vSp9UMaj/YpnCLWOOKQYVOrA+BU9P9qmQQrs9RgXBNIE+JplOHBzoU
         O+RviryQgQYExDCJfFuiydFof79L82b8QdVenka9cyLBujc1HGqqmrHZY2Ztims/sLjE
         /wtKrNpNUuC5ijDMqSBUr7/ZUYMMEU8zaKOavU1zEa9iACgPyDk9V3SZ+b7m1PUj9pdB
         MHpGKkMTwmV8f2srpw6LzmqhdlTwQtdRM2DpcA+RoERMDlb4rY1VEM+2olPdLDUTzfiQ
         Dv1kHQ38EYg8eA7W4xgYUS6J11giNBu5Ooifun7AP+UFOicZILQ8pbHK12QokzPT1tEN
         x+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWJBUtg1nySwy0TFixm3ebm3p4SA479OqFeTrvyX33IZwTAs7rOjHHJ/pLjD3/3TqgOz1NhviETBGkvgY5HZOnlg3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzG7roeYwI7vdMhKpYTZ0PUQTyUTMs+fNi/WFqk1UrWshCQchm
	bXz8ZLJdl0eKqiKwf5pmKJ/RYeiBHMhjNrDkzfDiE2O6P56r+QLWbZzw
X-Gm-Gg: ATEYQzyWb9rZRmH086uuT0JEhgyTs6rrxmbJtePLURs+AzKMJAlBqD1zO7U7bl21pvo
	nL5uCmdTN41jHuLihfCNgd8C3ck+QxUZbvixlm1CzGt7eR5fuHWlJx+eOqUY2ks96+uUQMFYCI8
	i3G5gstyNgPtuHXk/129Qw7Bw6UKKtFE6cNJp4TwMuScOnu5Q+9HuWl048SvihSzd5tmcwh2IU4
	QEk+bDMu2qAAYEW9inhcBB0YkQ9Gxwg/i3Jxy5LP9BK4ZAUSZqbDcmHknyxEX+k6O3P+LY2u83A
	Dah6WXGGzhW36Ohslr2e7sAyTlaSggb3CCrEiMkhNSJM+0DuMCGvJ8PRnwmdI8+yMxdtD6lC2hH
	MTue3ikXIY4ibDtii1+whCGBsCLNKZhes6m4NjTBzlylDAlqhvx6pxnK90D0UxcBTLjhsXgyoh6
	q8FUX3gYE9U0UYXEbgNiEK/jMjP4oLHbYdsNdOyR3iekfXV3KNpxzUIBTgSZREH9PB
X-Received: by 2002:a05:6000:2482:b0:439:b932:b428 with SMTP id ffacd0b85a97d-439f81b6659mr4797322f8f.8.1773233632585;
        Wed, 11 Mar 2026 05:53:52 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f818ff0fsm7048224f8f.4.2026.03.11.05.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 05:53:52 -0700 (PDT)
Date: Wed, 11 Mar 2026 12:53:50 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, longman@redhat.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] disable optimistic spinning for ftrace_lock
Message-ID: <20260311125350.1d89341f@pumpkin>
In-Reply-To: <20260311115426.GN606826@noisy.programming.kicks-ass.net>
References: <20260311115250.78488-1-laoar.shao@gmail.com>
	<20260311115426.GN606826@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Mar 2026 12:54:26 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Mar 11, 2026 at 07:52:47PM +0800, Yafang Shao wrote:
> > Recently, we resolved a latency spike issue caused by concurrently running
> > bpftrace processes. The root cause was high contention on the ftrace_lock
> > due to optimistic spinning. We can optimize this by disabling optimistic
> > spinning for ftrace_lock.
> > 
> > While semaphores may present similar challenges, I'm not currently aware of
> > specific instances that exhibit this exact issue. Should we encounter
> > problematic semaphores in production workloads, we can address them at that
> > time.
> > 
> > PATCH #1: introduce slow_mutex_[un]lock to disable optimistic spinning
> > PATCH #2: add variant for rtmutex
> > PATCH #3: disable optimistic spinning for ftrace_lock
> >   
> 
> So I really utterly hate this.

Yep...
Adding the extra parameter is likely to have a measurable impact
on everything else.

The problematic path is obvious:        find_kallsyms_symbol+142
        module_address_lookup+104
        kallsyms_lookup_buildid+203
        kallsyms_lookup+20
        print_rec+64
        t_show+67
        seq_read_iter+709
        seq_read+165
        vfs_read+165
        ksys_read+103
        __x64_sys_read+25
        do_syscall_64+56
        entry_SYSCALL_64_after_hwframe+100

The code needs to drop the ftrace_lock across t_show.

Although there is a bigger issue of why on earth the code is reading the
list of filter functions at all - never mind all the time.
I'll do it by hand when debugging, but I'd have though anything using bpf
will know exactly where to add its hooks.

	David




