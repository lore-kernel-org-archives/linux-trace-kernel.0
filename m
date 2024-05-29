Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B02178CE8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 May 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978385; cv=none; b=SFrbftenQ+N6PB2bqITWNpORWFWOPM0ecmTocKFTYUeabBtwqz2d38kbpHctl2TqCdZCPpWvdsfGR0ajS5rp5bXawyzriW3rXS9nSZNhnOWrpp2oJcarxwG2LYRHOqxkIueNs8RqSq7/EuBxaFYgqlUSeBbQ2mqf5jSJgeobut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978385; c=relaxed/simple;
	bh=lnRddKFcAoYT+tdiO+T64N/X4UwtldTOoym7fVYnzRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNt6S8QUU1yhpj9yeSB7gxs8wsfH8y/iafvzaElCiBNGiUetb06rGvwucTideiUQmFpemth1nJZMRwdEOl08hRwUvhXuTDqPd1VjlL7Htg83eOnnxgbuRSmAycYJX+kwxJV8mY6LT7ZwBsU9V9gU6IBVI60K7oyinVFwt53M/VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=zELE13gd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="zELE13gd"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42108822e3cso4201055e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 May 2024 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716978383; x=1717583183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LG4i7mbUzkEJRUAZg6ZfpW9p6gCCgVIHlxO5mLVFmZE=;
        b=zELE13gdHD2dG804Dlvjij5M/QsVkBUbcR8MueYEh8oVJ4kTjlKvfa7a27MNqdSPIR
         TJnI6M3l+7nfuOyI7Fb6oE+NLIdSaQ6XioY+kErtL/lIXkKtP5NbUpGZqNFdBSEsajJh
         sQ6G2TzkuS2LkBWsioRCjpQV9Ssik5ny6c5F8HtCWRknMTk0t9CYX3+MwFV43zIyoLmH
         KGdDk1zkbGvyeJMJt6aeLuS4VkLZh4DbgPc/mXMiJ4SEn98KvdGW6R8WfmogjLm8fjUj
         qPDhWyCOxP/rFNWRILTCPo9xFQ+jZMDzUGzKvAIhRWqYKpI4APGJLN7DeWzbzW4jIszQ
         VmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716978383; x=1717583183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LG4i7mbUzkEJRUAZg6ZfpW9p6gCCgVIHlxO5mLVFmZE=;
        b=Y6bAW5n2scdgXnmiEesca5QYBgR8pxndrCYXIJ9C0yxRxaosr1CGUU3dQFss05h6lo
         6sA+pt36s4fST9zshl5pEEk3aJgOIMBdM608GkCtDrAom00Dfbvsd9LALBXeQW/0pA+E
         dL9yFqmK/YrcYfB4ze1s34nhyDaq44m4OaUldspOntLPphF0lnMQDYmof/hwSCU2Dqce
         iXCa5T5UCo+peVAQJ4Mjd0Db6Cs71j55thS3KbMbFaRYf6B0lXy6ey8Wig5V+eQYrWe/
         qdQpbIOG+eekIXrtenSwxdDUrAIsikV35r0qljGg0lY77p1muiyfusxpJv4C/3dnsEQQ
         QHGA==
X-Forwarded-Encrypted: i=1; AJvYcCWh8ki4plJN7Zr9+hurZlb/FiAM38vgRquYx7A3SOLODRRTUw0oBXcqdnJGyBwnusP096pHcI25kUEDwtLBg11YPysc4PE/ZjW70OPWVtYbWvyq
X-Gm-Message-State: AOJu0YxofiqsMhFh5cSLsy3uajm+uy8NcG/v7obKvbviZGek0lRNUOvK
	QN73xAnjwfxZxU2bjwjWSJFvsQf13yKssdoocI9tORI7hWRj4Jgm6cUmkRAHzWg=
X-Google-Smtp-Source: AGHT+IFL2rVV6ZbLHtKwQ0pcVenJyjGhOLmyWzjE6L3t1oMaAdsd+Kz4zXnPAVzfGK1vk+ACrvUJSQ==
X-Received: by 2002:a05:600c:21c2:b0:41c:a9:26b3 with SMTP id 5b1f17b1804b1-42122b0d580mr13483695e9.19.1716978382753;
        Wed, 29 May 2024 03:26:22 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212348aa22sm19748435e9.36.2024.05.29.03.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:26:22 -0700 (PDT)
Date: Wed, 29 May 2024 11:26:21 +0100
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
	linux-mm@kvack.org
Subject: Re: [PATCH v3 3/3] sched/rt, dl: Convert functions to return bool
Message-ID: <20240529102621.km5ajaeyzzpqke4g@airbuntu>
References: <20240527234508.1062360-1-qyousef@layalina.io>
 <20240527234508.1062360-4-qyousef@layalina.io>
 <20240529073451.IIA7HXMj@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240529073451.IIA7HXMj@linutronix.de>

On 05/29/24 09:34, Sebastian Andrzej Siewior wrote:
> On 2024-05-28 00:45:08 [+0100], Qais Yousef wrote:
> > diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> > index 5cb88b748ad6..87d2370dd3db 100644
> > --- a/include/linux/sched/deadline.h
> > +++ b/include/linux/sched/deadline.h
> > @@ -10,7 +10,7 @@
> >  
> >  #include <linux/sched.h>
> >  
> > -static inline int dl_prio(int prio)
> > +static inline bool dl_prio(int prio)
> >  {
> >  	if (unlikely(prio < MAX_DL_PRIO))
> >  		return 1;
> 
> if we return a bool we should return true/ false.

Right. Fixed.

Thanks!

--
Qais Yousef
