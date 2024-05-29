Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AD073475
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 May 2024 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978856; cv=none; b=KwFE3oGhtfoFNIjzTsYDNF9M+e7Wnv6sgw0aoJS8EV+SErcfcBQcwpEYg8Xrthf8uyyKkxwSvjaAacLiMlT5JMxieSvwy58kA6RR6W56L8k6MtZ5Q8Zl4+sVs4Aj3TFI4aSYmeD0ObCpMx1KZqs0NXb3Wccc76o9mJGyQevJgR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978856; c=relaxed/simple;
	bh=JqW6S9gLbBT6oNduRIEy9rcuDuL7GJ37WpegUorfK2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGjJxEh+QWygbFDglWB8JL1cVfGFgCBnzl8qtkfORtIt4ttPYJlFXXDT3F35uYDkikezEaeCKfOi5B4ydSVhCkvqeU5DMmQr45txXCjmUf9DzlmUS5+DuArO1p5LapR709YASzlZkQ6WWecIDgjqTnNG+J3al6/jHh93GPuodn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=2Cp/6dOE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="2Cp/6dOE"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3588cb76276so399299f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 May 2024 03:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716978853; x=1717583653; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pWxQqhsuf8BC7pPkaTLgrKW/tD/H2B+jRA3s0q6FfWo=;
        b=2Cp/6dOE52Iiv81xt1QhwDB7ljPMSLtzss+3QzZEIsV/oW9y6Aep7CH8KUuewu2leE
         UZmlg03NKSMfqfLTjYtupneCsfNiOM5nN9UhT2XS2YoP1/3cGzuAHx70Bbt2ChkOd1ly
         lthL2X28g/ewhvSbpkptCVfvS9bVNsxsVcP17Bd7YXcg1vEORenrfcWxW5L5vpXsS7pP
         FUQtg87Gs3l8cNzgvtVBURctf5sDcE1uKWdQVe7CLuFRyTJKGJ258HmoOoCpOecfRLDn
         DpOkR+ut38lCvQuvRrM2vpqq3WTv6nYqFpC3qDROaXYZQSRb3kFWE4a0nq1l/vw5kHom
         m9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716978853; x=1717583653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWxQqhsuf8BC7pPkaTLgrKW/tD/H2B+jRA3s0q6FfWo=;
        b=Gopg7ltcYz4Bw/Kyt11ZJFjp8D0Psx32vMRD69sx5GDwwuGrB9edQNc473H0mS8Yqg
         uYVQjlfTsdV4ltmH3e8XberwQswqsToGvLxI2c6dZLqD6GkOHYQ7akL5JXYm1VnxOmx8
         YjQPvy0zXaP3f1mpUUEGDlrJ18X5rucmfKGw3qMuwrA2qLvoJqsUXq8mj/EqPCI7+DwE
         ujYCCXiD5XrGV13XnIm0zFDDYTDBgGfLU2G+zmnNci8nP2ZUK8CdS3CIDvYnkHquvBKk
         5nK9TrMHDTYrAIYxFDroCgprLiQiLDAmQjXTu76XgRXfrYDZyPbzBuIHFBMzESPoz1fi
         53tA==
X-Forwarded-Encrypted: i=1; AJvYcCVSHPPbKFhYJa/nrgGhz5ff4vJDjT5Ab3tiBuHo2RRJFXDoVpmZD7CLxnJaZDKDDI/40N2qvOSkrziBjVO37m2pEernWaQqQtQ0sncjzFRKKe3O
X-Gm-Message-State: AOJu0YyKZJ2FZUjjrklonNxwCcbG1GWeRQmz5NdvBsjIdT3lGgdWgAUW
	SKAnXUmTgx0AXhmxuFH4WHOA/6zchMtu0b9maJl/Xzpuy0ClmTqaTO2/at3Se1E=
X-Google-Smtp-Source: AGHT+IGSszxrKbHSyGgQ7mAClIEtVdH7p9Lx2JOJh6npifDBZVn+xxJ8yW2MTf6yCWOUozN0vx/rZg==
X-Received: by 2002:a5d:4602:0:b0:34c:fd92:3359 with SMTP id ffacd0b85a97d-35c7af09709mr1539637f8f.21.1716978853406;
        Wed, 29 May 2024 03:34:13 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c92f8sm14306730f8f.67.2024.05.29.03.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:34:13 -0700 (PDT)
Date: Wed, 29 May 2024 11:34:09 +0100
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
Message-ID: <20240529103409.3iiemroaavv5lh2p@airbuntu>
References: <20240515220536.823145-1-qyousef@layalina.io>
 <20240521110035.KRIwllGe@linutronix.de>
 <20240527172650.kieptfl3zhyljkzx@airbuntu>
 <20240529082912.gPDpgVy3@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529082912.gPDpgVy3@linutronix.de>

On 05/29/24 10:29, Sebastian Andrzej Siewior wrote:
> On 2024-05-27 18:26:50 [+0100], Qais Yousef wrote:
> > > In order to be PI-boosted you need to acquire a lock and the only lock
> > > you can sleep while acquired without generating a warning is a mutex_t
> > > (or equivalent sleeping lock) on PREEMPT_RT. 
> > 
> > Note we care about the behavior for !PREEMPT_RT. PI issues are important there
> > too. I assume the fact the PREEMPT_RT changes the locks behavior is what you're
> > referring to here and not applicable to normal case.
> 
> So for !PREEMPT_RT you need a rtmutex for PI. RCU and i2c is using it
> within the kernel and this shouldn't go via the `slack' API.
> 
> The FUTEX API on the other hand is a different story and it might
> matter. So you have one task running SCHED_OTHER and acquiring a lock in
> userspace (pthread_mutex_t, PTHREAD_PRIO_INHERIT). Another task running
> at SCHED_FIFO/ RR/ DL would also acquire that lock, block on it and
> then inherit its priority.
> This is the point where the former task has a different policy vs
> priority considering PI-boosting. You could argue that the task
> shouldn't sleep or invoke anything possible sleeping with a timeout > 0
> because it is using an important lock.
> But then it is userland and has the freedom to do whatever it wants you
> know…

Yes..

> 
> So it might be better to forget what I said and keeping the current

Okay I'll drop the patch then in next posting.

> behaviour. But then it is insistent which matters only in the RT case.
> Puh. Any sched folks regarding policy?

I am not sure I understood you here. Could you rephrase please?
