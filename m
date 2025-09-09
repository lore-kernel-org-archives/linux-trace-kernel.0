Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF3132CF76
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Sep 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434224; cv=none; b=nPGL5EIWfZak3xPlQnFMwNK1wry16O64xtzVimC3/jxtf6NM6OYZkTqz3Wsc0CsRG/TejlVb5b27CSIYQpm+XoTW/p6GmwqngULmwgWpEMUKexE1Ps51Hdz5tdVg4n93hBvc0VEYr6fotLnwRI/UkrlOysfqa8lm2wFna5ybmq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434224; c=relaxed/simple;
	bh=bvmtY118txyjfxnCSpGNzanxwErszIEgZjkDshuNbJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMH6FNETw1CBQZtJnDRUZNBJzmOBjVGE5gbk8EVQWMxJ2IryUO146+rbVgr2BjzHWyk4gFEyb4AhSC1DDWSlAl3orWVHDYw4D7rUk64sG/wSuywUgt8YzJGPY/hcBqLYidZ9+CWw1FiqoHcc0ylXtNhdv9StP4UoonfkZBAEhkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRyHgv3W; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRyHgv3W"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso35354295e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Sep 2025 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757434221; x=1758039021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J+NppKLzVrIsIoSaivdIxFGudWC05VGLRO9K0C3DxKA=;
        b=FRyHgv3W5U8JKjUdNBgBEukF7I82pH6MTp9NPt1tkQkjEJb84zJe4ONos+/4vHt15s
         tsPyDew5aD5CdTQnmfE/AxPn6vSb9VUquAgKqxt/WPHzo8JpVZ8wZGZmrqDQmj5iE0AZ
         1oJYtk1UVEHZGyvafKqOZdG702CAmi4qWd3coiA9BATMaRkcp/h4QHFiY5xCENX/CNjg
         jwlW3mGf0SGSJNGoHkEdCD9pUQSwr/k1kNKOT3YZ9wDN8sBjJ7pm2py7DBqjPRCGL0b6
         vaMh7ggTz5KsYArg/uxSzUH/oHs68T7ht3UBXQFON2fkqVjX9sB5qScHbnF3xerzuh9K
         oJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757434221; x=1758039021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+NppKLzVrIsIoSaivdIxFGudWC05VGLRO9K0C3DxKA=;
        b=o/CaP1Al+xuKEkfAFIK44Iz1K4H86e7SiGuKpFVfFpFzjsUjr37UwvcLP4LKVK58Ox
         tsEO31whB5RAWxrh0wQawsuDp05U4cbezl5L1XRJ3Z6M9EV5SztN/AjZE2jAn54Fib0u
         NVAJuWAZb67Da7Ktm9eWoVkXPnMUfozoaxC+f6up7S2RvqghGLWzL4qsU8AFKa5eC7c9
         wkyfiiEcd3HR8x+iqcI+1D7rn2tTv0hgfdy3k8I1MI1ePAG/oG3y/uqUW7J4clOSdXUG
         SEhDgTZZOGRavv+BQxlox/ff6zPWlaQ7FLcUTLZgGr6Tp3OdLpOfEpqMNJygKJuyLGB1
         OlDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcJ6x/os73WGmUITBIssJzrCyYHV2avGAo0NQtGkV5bpath5NEnmrUw7ixYl2OzImHrYUfB4WSix62Fn+VTJmFDuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvksRDGEvSinqdxIa5s7uAYyjXQaIRCU3zlgd6ZJGjRn4HxntO
	GY3n54aaLsQAHvEyCeGCOwuRt0IC71NCTDHF+KT5CdkmPwyd8iNPHifOnz84RuEqGw==
X-Gm-Gg: ASbGncukGKR91ifvUpAfjxUdv+ehNQUdc0zXEV4mRIZjOsxexCnkLZM79exPCA3Hkh/
	ZEMubVY15FCEZ+LrCoY36A6Sry+3p2Jtuwx8n+auxTU7MpRQA9tM8gUoNZycmzVScS50kBd8vw4
	37pv2Y5Hvs0lu/ArVZHHOgYyRDiinZLsaQzzrVJMQ6Bjm2qXpw3Wb4EFWXKPCM6VThaVeANch/V
	zfyAo8wkweZa1LXmXJJIopS3OqAdopl0FqwuoUm4ILakmRevt77B8dqBycP2iDta5nk1s86fkU4
	vJmausbG5azuvVR2UZ2TZwLn2ABOkQYRY42aXBt5bcXKEYy7YzUNPxBqORpGH/srStQ+NY6SD2H
	BCiW5s2ffdsY7eSZA/aD3BK6iNwRXIV4zb/h3jOmdkWn/cuXEz2ZK5McvVXiiIBDMkSRKo2R3jV
	9y11aO
X-Google-Smtp-Source: AGHT+IEcQIe0OC8lSfD+aiR6eeprIeDl6s8EC4O8tczqPnzu992yeZRmguAnbDmw2y0KnALeXMKgPg==
X-Received: by 2002:a05:6000:1449:b0:3e4:ea11:f7df with SMTP id ffacd0b85a97d-3e64392b8c4mr12530932f8f.40.1757434220628;
        Tue, 09 Sep 2025 09:10:20 -0700 (PDT)
Received: from google.com (211.29.195.35.bc.googleusercontent.com. [35.195.29.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238910sm3069080f8f.41.2025.09.09.09.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:10:19 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:10:16 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/24] tracing: Introduce trace remotes
Message-ID: <aMBRaPzjR4OJVIWn@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
 <20250821081412.1008261-4-vdonnefort@google.com>
 <20250908193606.47143d09@gandalf.local.home>
 <aMAYvA9LSvfxvt_C@google.com>
 <20250909093848.402674b7@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909093848.402674b7@gandalf.local.home>

On Tue, Sep 09, 2025 at 09:38:48AM -0400, Steven Rostedt wrote:
> On Tue, 9 Sep 2025 13:08:28 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > > +		rb_desc = __next_ring_buffer_desc(rb_desc);  
> > > 
> > > Is there no check to make sure that the cpu mask matches what the rb_desc
> > > will have?  
> > 
> > The function is filling rb_desc[], based on the cpumask input, so both will
> > match when returning from this function.
> > It is then easy to handle the case where some CPUs are not part of the cpumask.
> > See remote_test_load() where for_each_ring_buffer_desc() iterates over all the
> > CPUs from the trace_desc but uses rb_desc->cpu.
> > 
> > Is it what you meant?
> 
> I'm more worried about the allocation not being big enough for the rb_desc
> being filled. I just noticed that the trace_remote_register() function is
> missing a kerneldoc header. Please add one and specify what the parameters
> are for as well as their requirements.
> 
> It's fine to state that the allocation of desc must match what the cpumask
> is. But the lack of comments about what the function does and what is
> expected of the parameters makes it hard to know if it is performing
> properly.

Ok, will do!

I could also add a desc_size parameter to make sure we won't overflow the given
desc?

> 
> -- Steve
