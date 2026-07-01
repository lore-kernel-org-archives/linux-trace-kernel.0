Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D9401A3C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900257; cv=none; b=JexWAjP3Akj73kjHzMo6hCia+SBsNLqzclCmWjaGT07Mvh43M8UXf+g7yTOCagkKL8fcxjPZr40Zhxe9PGQhzqn60rBAxqStvLEPcJ1cNIFCqVRHC1gQadIxQOP9F8tXF9e8wVNfA57tJHJ7mpkONKgDtJF91tnygS9adFvbI6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900257; c=relaxed/simple;
	bh=xnymW4sgZ0npuMNb6wrJL337/bHyYIqCEMe0cfjHx+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6OICzRziWGkP4Z8WwQohCFFner5AO13ZacUve6PsYeS7w6uvrmkCq/1tXTCukSD2uDT00m6yz2smGE4T3yjztrOdmeFnxxix/0jKe5oK4Ov2X6Z5hCfWzjTaYqW/K4dCHIBGucdZbIA5R8WEjbd9pMbBZvY/KMivX/ZRTBTB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pw4R7DW8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pw4R7DW8"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so3929645e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 03:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782900254; x=1783505054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yyyke20YFVyA/SXZoMyl8D8oua+btHBiB/bTldFU+Rg=;
        b=pw4R7DW8zCkB9ec5YsVWNCaGey1CqGQlxK4DB7rIEHDFq6PJzNxGJp5T7CVyv0mh2V
         ayYKPxapqQSEL+f/UehRNPCTAAFGm9uJzExxbZHkQ9DjC6qFK+g3riLMl2ZaAN66jQFe
         4EYnLIZG1T6gbnYYfxhZxwxN8iFVbgm5BhRBYY1vdBiZt8vLSQTYgIdBUwFGgSEoHjHz
         EtwVOVAEEzt12+IC9OskzCSa5PWerurt8uDMOouEPKRadLOHkaCkYXbj+asl9lIyEYmG
         sUzE3qE5p+MwtqUzJLdCZTuoVcfVXto3Q2g/6tu/hMj5PuGCPVdfV4ujj2X26ohr83ou
         T0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782900254; x=1783505054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yyyke20YFVyA/SXZoMyl8D8oua+btHBiB/bTldFU+Rg=;
        b=F3FebcdT6Nsh3nOENYOluPwcipMPJ+ue4bF5WGCj/i/NRIINshxqxN+pYHI2Jlf3uB
         0AOEgqgwwXviHEh0i+TGwPp1jXEfq1KtZOZMC5tSQ6XEXFlfrZ8Wc5qI2jrShqPB3y/K
         xl6Qm0SpBSK3/qsPPLYRYC/R8qDqgvpdymSr143xebPyNMESRetT0Uj84m5wgN77z5bF
         5/KvnWWVInvRXuJY51y7lb8BPyab0dBA64YqxZaPvlPbrvayhwqgFlLIL7LFM/B7vUY5
         yKUARjW1UhOPuLbF/VGEbFJkjSO7mSesUdFE8QCtV9tJGaPjTEvC8cWOVZ0l2rhJ6fh2
         u3lA==
X-Forwarded-Encrypted: i=1; AFNElJ+IaW7+P5jnmOIv+UewgPLWf6C7y4PhjOx3zhba3VDB+rT4Vi9WwZwTUNhbRZxR1N1BVQVw3CoR0lKgLQ0VkKyYlzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3NXEUcWTBM05OW5uw465tYW9bVDAjZ6mtnU8ttxT3A+nNV53E
	RHD2TueTxUk+5PsRX5ivlWs46CVHIug7y8l7LDYA96NZWUq3KXBPwn+02lPaNu9Q
X-Gm-Gg: AfdE7ckI4Y5IcPYmcJhDIwBp7GYpJkYOX1xVBDH21AE6BGbu2JC908ToXazY60O9NoO
	U/Efxf4Ii2klqKxpVlSOwRha7RkJxyeS76uUKHDa1Q9XkWAwoxQdvSpaPs2kt/eLwIqDRFK7wnk
	y3OGiy2A+Ml4pSKhsLkocHv92YI0nCJ9SZ12oJF+tLSQrv2yBh+kfc93B0/SIqcpGufDeXPrf4i
	JJ4I3e+Y9F63S3uYOKlkO9Hn8bGH9jM/YTXEl6SV3ZZO2MKwHTkZPfHOhl7fuLo4s4CJnS2up2v
	nQGaa3GpkgaXcUCE0IsS12dWAO9mrfYn1WB5uwx6yyTHOacPKN3qxJEPB9Rm3bJtdluy+Yb48Ri
	nHlcVLP0J5EsO3JZJ1xaNUE1epaURqwUEymGe/IiQ9J+jINmrLCoDaKMFva8CyumC/xcqImOerM
	5JGrq95zgI/2Ab/YukBb5Dx6dif/z2tWAA/4lskEjU+/3FYQ==
X-Received: by 2002:a7b:ce90:0:b0:493:af0d:484c with SMTP id 5b1f17b1804b1-493c2bab007mr10107955e9.34.1782900248941;
        Wed, 01 Jul 2026 03:04:08 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756797a8besm16531383f8f.35.2026.07.01.03.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 03:04:08 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:04:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Michal =?UTF-8?B?S291dG7DvQ==?=
 <mkoutny@suse.com>
Subject: Re: [PATCH 2/2] tracing: Keep pid and comm[] in the same structure
Message-ID: <20260701110407.31f7b6ca@pumpkin>
In-Reply-To: <20260630150348.149e318c@gandalf.local.home>
References: <20260626212356.64150-1-david.laight.linux@gmail.com>
	<20260626212356.64150-3-david.laight.linux@gmail.com>
	<20260629164912.4c1c2855@robin>
	<20260630110156.5314e2e6@pumpkin>
	<20260630150348.149e318c@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 15:03:48 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 30 Jun 2026 11:01:56 +0100
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> > > It's been a long time since I worked on this, but IIRC, it was to keep
> > > the pressure down on the TLB when tracing. It updates at every
> > > sched_switch that has a trace event occurring so, I likely used normal
> > > pages which are part of the huge pages the kernel sets up and doesn't
> > > affect the TLB as much. vmalloc does have impact on the TLB pressure,
> > > and tracing should always try to avoid that.    
> > 
> > Isn't this a cache so that the pid numbers can be converted to strings
> > when the trace is read out after the actual process has exited?
> > That does mean that cache doesn't need to be updated on every trace
> > request - it might be enough to just save on process exit and lookup the
> > pid itself for running processes (the whole thing relies on pids not
> > being reused).  
> 
> Yes it's a cache but it only gets filled when needed. That is, after a
> trace event occurred. Tracing is very commonly used with filtering, where
> events can be seldom triggered. What is in the saved_cmdlines file should
> only be tasks that were running when a trace occurred.
> 
> Now what we could do is add a flag to the task struct and only set that
> when tracing happens. Only tasks that exit would be saved in this array.
> The other tasks could be queried via iterating the tasks and reporting any
> task with this bit set.

I thought it was just used to do a pid->string lookup when you run 'cat trace'.
But then I found the code that lets userspace read the table....
I guess the latter is used by the userspace code that reads the raw trace buffer.
(I found some instructions that did it that way, the output was unparseable
when tracing things that are happening on multiple cpu.)
The userspace code could probably be given comm[] for all the running
processes and those that exited while tracing_on() set.
(I didn't see anything that would clear the table when the trace buffer
was cleared.)

I'll try to remember to look at this when I get home.
(I've a pi-5 with me, not doing kernel builds on it...)

	David

