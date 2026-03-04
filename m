Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC93D75B6
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660692; cv=none; b=RJUdBtsU/UenQ+P3XSrrw/bHvqBK3CX2JAwcWXzzlgesirN42H6Gx+jviBhVR0dcBSVEFyOxBbfzZg0PSWSBmtFARpofA5bbgl+LAvt9opKZWHWZOkCyiLn/eJRuqjKKcHWpmW9fI8qBXSbMxNf+LtR68m58M3EwRX0QOj2+EiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660692; c=relaxed/simple;
	bh=PcS5mLYUPXAnbl7k8XF3V5byX4FCrBsPOJjd42WKHcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFm9h0sgchYtWHduDl3+44xAUsN4sDUBQEGXsD34TavkKiUekE3mSwuRJVpVxq2F8GvWOc5jPWwyOGH426fza+KRxXhTym97GR6EhqL8KEnsb2cc9+0azklnQ1D/GZ97qD7sCZJnF5aV+5RId2WLZHtgWoEv33qOvRlL8puNvtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzFMEST3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzFMEST3"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b73f4ab4so4085762f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 13:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772660690; x=1773265490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBHy4//B0BVAaOjPVplq/WDAKnGbN6ejMvGH72LFAkg=;
        b=AzFMEST3zuiFDQ4q+oM+1xG3cpv7N5NnhQoLYAVJZbptPl9Wg3idk5Ui6FYSOWNMYV
         Eb0rHpiheJyjtPz8w5cR5UmQKHo20ZRpcY2yizeXCMdIn2YZZG9ku8OpHm0zvryLqQSC
         6ufiiDn3zoZZQ9/Mz9eOsPP8uom+O6Y0ivwXASh2Sw2+govhoT4oNgZdWUExYwaa+wQP
         GB3a5zFvK4CvdT1lUKmBK2gBbwe2T+C1KRr9U2+OXEBgMjuG2bIdhxQgGXbqgo/PeQvT
         uyyM6mAY9TzHHnNdW8P61hEpK+nDRx0Xuak1OmdmFTxIgvNJ4tI3h1xSXhwJQvMgnhWR
         A4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772660690; x=1773265490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XBHy4//B0BVAaOjPVplq/WDAKnGbN6ejMvGH72LFAkg=;
        b=D3jI7PzPvEiFxb7d4nW6ufIRf+Ako2TXqdB6U+fvrJM4JMhPwiorFPUWgwwHL+EtZZ
         SEDo72x3qARJtl8uFb+FONu3YhtQwdcJci039CfcA965FRGL1ZodZsKPgQ2uR0Uk0JTu
         bCfpeyldU5fZ8UeOwf8hI0pacNzgK9bJ4WWAXIslaKL2z4+ns6FJG8BfVIrdZg+DY9GX
         X9R73Cj06VGqGq3tJO8mwOUUBdqD5nl5QrMa9gkPj8NjLKv0hAx2tixrXqBab8ixHfzV
         AIylY6Z/onK3lUc+odqJ+9sE1Bkrk32P8dZ5zEgIPjabSaQrCPoRDiKPima9+qDmGDWG
         ayFA==
X-Forwarded-Encrypted: i=1; AJvYcCVIr/wNIbpZS35nRjaaH9eyi+G5U/ybsVrwGrJhs0TJyWULKAwn6EV2WzKPydNThKu5YikUyDDPlCrZpqNBGvTicxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFdWjayFZZ8x9QklSNB0sC8eSsW//rselKuYnS6f5/+n3IGEq2
	1/Pz7mHJ21DU3AqkAkHxpuukcmCJ8wlcIwPx1QBUMgHGQYcI6KWnVcj7
X-Gm-Gg: ATEYQzx7L8UOYI3bmxjeYfqtKSgKh5IfqqReWws1UZTRg5x5++QCdw3P91MmC3nAi2T
	T4dvghEllYvNeLlCH3mSRk/WJ2aX7n8dQeZZGG+IKxTc5qkQgJ46qxpmer8SrTr9NLgGUeZDYL8
	3i8R9K2Eedl1k9dyMQFeLofjJS9V3eU+e+rqb4Qjd1NEnvEGENOhN6t8xC5EmPItAU5ytzoF246
	/W16krtq44D6jkPoCN0YbloVsUYzEMGysTfSiecQtJSXV+co34pV+91GY6A2Zusj/JXtUwBThkU
	HUYhZdIljmU23qY7FIIOhkXKRagwYfRUJo61pP1rqCB4gX9zsz2Ih7Hq0LYqmgjszDTQO9/7wEv
	vhcWNoRmWtGx91frRTnvF2U3uyFa143UP4zkd18ieZLTWAOvH/H6ofPElNwdAh9vGajwkoA0nW6
	60hWu/4HYXoFwl4tp0jwjWiUcnng+SmbceOG/MUqPTMlp7o0dLkoYMob3vvSFBOUGc
X-Received: by 2002:a05:600c:46d2:b0:483:b505:9db4 with SMTP id 5b1f17b1804b1-485198a3d0emr61675375e9.31.1772660689592;
        Wed, 04 Mar 2026 13:44:49 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851883a012sm148720885e9.3.2026.03.04.13.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 13:44:49 -0800 (PST)
Date: Wed, 4 Mar 2026 21:44:47 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Yafang Shao
 <laoar.shao@gmail.com>, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, longman@redhat.com, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
Message-ID: <20260304214447.3e5817ea@pumpkin>
In-Reply-To: <20260304155742.7b4de2d1@gandalf.local.home>
References: <20260304074650.58165-1-laoar.shao@gmail.com>
	<20260304074650.58165-2-laoar.shao@gmail.com>
	<20260304090249.GN606826@noisy.programming.kicks-ass.net>
	<20260304095415.4d5f2528@pumpkin>
	<20260304155742.7b4de2d1@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Mar 2026 15:57:42 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 4 Mar 2026 09:54:15 +0000
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> > That might still be an issue if a high priority process is spinning.
> > But a %sys spike doesn't imply a latency spike.
> > 
> > Is this using the osq_lock.c code?
> > That will have problems on overprovisioned VMs, it tries to find out
> > whether the hypervisor has switched out - but ISTR that is flawed.
> > 
> > In reality a spin lock shouldn't be held for long enough to cause
> > any kind latency issue.
> > So something in the code that reads the list of filter functions
> > needs to be done differently so that the lock isn't held for as long.  
> 
> It's not a spinlock, it's an adaptive mutex which spins while the owner of
> the mutex is also still running on the CPU. If the spinner CPU triggers a
> NEED_RESCHED or the owner goes to sleep, the spinner stops spinning and
> goes to sleep too.

I think half my brain knew that - otherwise I wouldn't have mentioned
the osq_lock.c code.
That all reminded me I've a patch that optimises that code a bit.
But I do remember thinking it ought to have a 'I been spinning long
enough, time to sleep' path.

	David 

> 
> Honestly, this still looks like a non-issue or a corner case that I don't
> think requires these changes.
> 
> This looks like one of those "Patient: Doctor it hurts me when I do this.
> Doctor: Then don't do that." cases.
> 
> Why is a production system having multiple users cat
> avaliable_filter_functions to begin with?
> 
> -- Steve

