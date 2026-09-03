Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9EC4D2ED4
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448804; cv=none; b=E658nmSOErnOomX3Uo8ImROn44TkU3hyhO1mT7vxWrVv1VlSDmW52pDK6SWUWK03E9SmxxBSVJBEC1J68awreWY2AWbJyMxQ0n1p4sp+flRLdTcIj8jNk5tOMtN2wjsvhNERsVQa32SaagSxvJ1F6pfO21EBd8//QdelfecysP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448804; c=relaxed/simple;
	bh=jHZdAdF+lmGzPYsT8GrQUp9u1PkWPJu0bdv2XBa5BQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b91PeOuaRYMbjxUEbOwavGSenvxiqUjXow5ZYq4BSISEJ54eKalZ2ulbs1DwnVtMAJIwQBoPJyB0MjXPrs3p6QucAFJMNALki3UvjP8GEmvyBiQNMr70q2ZpVGCxxsIWPYPAQNsmd1VIo1Q8rfvzF5xIo4j4SGIBFxNfGS++a4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h0EVelC6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0EVelC6"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso3551395a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Sep 2026 08:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788448801; x=1789053601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aAKIuEKuV7qhY7WF80gvKc7qYwMnmaoC0K+ccLX7aeM=;
        b=h0EVelC6A3CVGqPBTfq5Ep+kk9QEZ78PoFsMeDqc1Aghi85+k4q5OODRiuV8WGbPBT
         kglaaxeZoSRzOYD7Bc1z3PNeScSf+YphLW9BQV1FINM4eneiOWrD8vb43ow2SwLtvs+L
         GEcjTREj/C797xEbY2iJ+kkQg0yPKacfKIU9346Xit1iuFyEcqDczo4erYuV5pC087qX
         ieS5osJW3BUbyc+S4B+SItRZmoSPF7KO2X8a/KcxwF2ZOiqnD/2MHCUgtj031ArU+5Hm
         XlJerFbtyQC4q14XWxA+ldJNs8+z5nVWZj42lM4JF0FZSeSjTa/72bDaQLfGkO1YKLr9
         Jt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448801; x=1789053601;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aAKIuEKuV7qhY7WF80gvKc7qYwMnmaoC0K+ccLX7aeM=;
        b=eN8GZbz2KUvtIkzEcrxHZGYnC0NcrO7j8kJRIVU7Bs6dcuu495ksDD64JdCTl9wvsP
         CsvJHv1gpGhrFiy7hvjzh8aLId4QFFAtDLJ/ec+MNULXEFeKe4YWGdhDkbqhj0wohIg9
         uXXTN9ICPCjbLssoT7F7ZeBs4lA/q/iFIXmrtLkakVlWFG3CndXPAVKk9+jDXeilEiGX
         B3FwLYBWUjwAf3sI+rD4To0BKbBzosuSWqzMFd86APPh8tLnnpMHsGsXL2pLm/I87jC1
         lwQB5S23Xh6lq4TrHbDSV8ze/gfSTHy+fnJfKB8htMKSui0/KkcTvX+Ixfukmb4AhxoO
         QKpA==
X-Forwarded-Encrypted: i=1; AKwUvBy2qGix4eFhCjD5zAYRol5MWOZ/MdERt8HHhBsW8WFJ62RoqpqodwQGxn/l323ZL1LAk+T0VKL6VsUJR3RSAbKX3aY=@vger.kernel.org
X-Gm-Message-State: AFuF++niZDi3VjNL84QgudWQVEz61WuQmZUR4k3YF9gJ+MhH76DklIVF
	vY2Tk9V4GqrWMEi/13dfI790zWABkX0CcO4jYOfV+PR4o0YGZA8Geujmv9BshHw1Dg==
X-Gm-Gg: AYBFou2Z7eFCtKnpHI4xQaFWD7hyOeadLeoYSVMsxBtGmTrcGJP/RqKtx83yqa15th4
	9J7+V752IcTbT6JAdzjrUfxzZQ4iYioHOD/8tDD4I3YtG0OMaIhYsKSZ6VhaiBUQwrUH+rTkjBb
	aDPobTWqy0eqje4XPam8s9ifme+XFhMTW2EqE6KCo7+jxwblOFKIudKmYuxjRweBLdn3h+o1oUf
	d0f0nvxGQRPEVbku4LT3ezemVMrOwrq8OfIi6GofphHEXBhKKqmGxXMMEDvvSs/iLKIw7wDMqrD
	49OEOMAB23Qw9u/ligLXBlAN6BsB3TmPcBiNeeYh6W8dN9yENybGdUzu1d3CHPmj4v8r1x3C452
	Ra8f8QAmQ2Amu+KFJAqJX6H3n/8SaAIGrjxU1bEt6a2Qe6j+to5jealQ91Wnwg8Ij3BuoKJJIpG
	IK/im/3yiQOI+oe1ATNK6oTrrLi70boetkyubm8aiBMDX1muNObJ8KpdmoUN+EaDZ8So8Eg4tf/
	sbqjNVbpT0wW+FIoaGaWjVh+0soGGEp
X-Received: by 2002:a05:6402:360c:b0:6a6:cc:269e with SMTP id 4fb4d7f45d1cf-6a68257bceamr9136219a12.8.1788448800426;
        Thu, 03 Sep 2026 08:20:00 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a69a010c72sm997336a12.8.2026.09.03.08.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:19:59 -0700 (PDT)
Date: Thu, 3 Sep 2026 16:19:55 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/4] ring-buffer: Fixes for subbuf resizing and
 persistent buffers
Message-ID: <apmQGwDuvjSn0gzP@google.com>
References: <20260901155445.1475405-1-vdonnefort@google.com>
 <20260903103116.6cb7c39c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903103116.6cb7c39c@gandalf.local.home>

On Thu, Sep 03, 2026 at 10:31:16AM -0400, Steven Rostedt wrote:
> On Tue,  1 Sep 2026 16:54:41 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > This series addresses multiple issues discovered with the dynamic ring
> > buffer resizing.
> > 
> > I have managed to reproduce a ring_buffer_read_page() race with
> > 
> >  $ while true; do for i in 8 16 32; do echo $i > /sys/kernel/tracing/buffer_subbuf_size_kb; sleep 0.1; done; done
> 
> Did you do anything else while running the above?
> 
> I ask because I ran this for several hours and it didn't produce anything.
> What bug does it supposed to trigger?
> 
> -- Steve

I clearly have been imprecise here.

I had "trace-record -e sched" and I have just verified with a print that it has
run into the reader->order != read_page->order case.

-- 
Vincent
