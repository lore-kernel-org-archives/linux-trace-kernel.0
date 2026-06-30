Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5993D6493
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813721; cv=none; b=XGRHZJRnYOVL14lQPH8Zw3Reemhu8QqbAFZm4Nl6PMdd+Ek5mxK1za5RuDWB7LozYKQdWf1a1voDHzmo+ieI/OGYfe/2+nTtukRfTDAOFCRtrvNrizQs3rGo+xS0zyZ8TAbZxu6Bi7S/J0adDsaHRwpM/o6HJmjjySa3Ue8ydsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813721; c=relaxed/simple;
	bh=QiQvYF8/QaSb6AfdixCPrH92YaSM0Fq4/gmq2GFZ4Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRE/xkLiya4OW67ZfVxNoxrTqP+pS3AAi9KZJdKLX0h1sdoKaIZEeLfxc6EfSYt9kBmKL6lUOgo7OrHJyxyYadgxnuYSucLmSfnDokziQaBICFdYoY5ci3IU+crlB4HjSmuYLN2wiWXVXx6rj/M0KvC3jnYOEzpdaIMB3U7Xjik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c43gqdaR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c43gqdaR"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so3263745e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782813718; x=1783418518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWs0rjmcLg7NvaVW2+lqNNrpWlNXZepbMri66/CGWuA=;
        b=c43gqdaRRLeDBVK0bQ18wKxS1OJfm8V/ZEF/2c5K839ALaJexAHEIk+bB2CV+Bevz7
         T3logmfwlpkQ1gS4ZylEj+lNnl1jvKqsOqW2zgTn5zzQkSTtFWSGpLjIKx7tqQ5q/jWN
         omu/9TfWynqc5lpVmS1uBIfuOZoPZi6t08C7kYg7HOWpQ/xMzGnTxPeExyRRq5/irdZ9
         7880XlM0sPY604GwRKpb3/Arewwvf+hvsfflIywIpr4zU4qaZKl1MuPEoQneL70GqKWU
         TqwBaC0qy9mrl/dgMbNve1qqaOowYbFEpDhkSbWb4IDTtQgzn0pLYLkRw2KG/3MwgjhG
         c1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813718; x=1783418518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NWs0rjmcLg7NvaVW2+lqNNrpWlNXZepbMri66/CGWuA=;
        b=EA9ZVkYFEAQFHegw/ZysOueY9DE8KquFfg25b1ao4702P7lLzehzQnFaOLZt0dwHDT
         0pCYgBruYjUKRREuODEJGrJNDq+ZyO1dX8IPQ8caS23i9EEDkSO0xEgNkk7y1xNJa59E
         +9v31IZfB8iJJ3zxLeRoevI5Mx1pRnMuQvCpiBiRwawgksiR+VT63aAQr9DgJLNmNVeI
         0NV8FadXSK08+j2eHI6FihSZ5m+p+d6OgvWJOVqfSqaR0Qwti/5bC+9/m1CyB4RH845z
         l6fwVZOytI6reTRqs0kUQvjQxtub9JeNLqWNwM4xUjTntWLhlET5M+yoexaHYbJdgLhV
         oOrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9t/hQmBpo1CSWZ4AOvGBIQtspV7Ga4ouuObbCjVIg/0DO3c6hTkzNezYc8FrdWX1vmySnljIy1fwCEjoMpxNSwDAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVcjC20ge6zYTC1YuRlYswJPU5GmPLOtzgn9Vei1knhKRjzOjt
	NoM/MD+UTmbGAejxQnnm/kG55EGwlsXyPMwjDH0jibeUEQlIGmJupt0k
X-Gm-Gg: AfdE7cmavD/mYFaep2UC3wg8IaDq3348a6E4C87kGk2XW/vff0e3iQ5qLp1lI1Uf8x4
	coUQt4Ax5I+lby2wGZr5LD6vPtutpX2plSWadbMX/27nLreLTKiePFPD6ksQcKWUieU9IHGDOYu
	Ic5y55KgsQWyGI8q6HufGre+sv5xf1WHNukepYJAtUGkpX7rws1SyN2ug0QYN3VRmuqE4qGllyD
	1lit0n6OykfzFp9IEQpqONUJJDkYN0djbCVRnM5KXL7liLlzLlnbsoQn6VVLzN6qW0jlUA++tCK
	qT0vC2mafm1OkuqtKz0HtwyAwd5H3x/XYK8zn8fOamUoPmLZRUM8WBwpMal+/sbfVzzL/DTYa6W
	FZoo2lMPtpcIubb9KLP3PoCgRhJmiogs/JZV7FOgI+h8Ad/hnC7qDVm0GOiuTb9TQkeOhs72f+l
	Vx5JNgHgL5UxPBOABJZqb4U1v+wG1e9G3RX/JLTZicqHI2GA==
X-Received: by 2002:a05:600c:348c:b0:493:b56b:c45c with SMTP id 5b1f17b1804b1-493b82b5afdmr45416075e9.30.1782813718214;
        Tue, 30 Jun 2026 03:01:58 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8ca8b1csm50682145e9.9.2026.06.30.03.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:01:57 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:01:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Michal =?UTF-8?B?S291dG7DvQ==?=
 <mkoutny@suse.com>
Subject: Re: [PATCH 2/2] tracing: Keep pid and comm[] in the same structure
Message-ID: <20260630110156.5314e2e6@pumpkin>
In-Reply-To: <20260629164912.4c1c2855@robin>
References: <20260626212356.64150-1-david.laight.linux@gmail.com>
	<20260626212356.64150-3-david.laight.linux@gmail.com>
	<20260629164912.4c1c2855@robin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 16:49:12 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 26 Jun 2026 22:23:56 +0100
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> > Rather than have two separate dynamic arrays on the end of struct
> > saved_commandlines_buffer have a single dynamic array where each
> > entry contains the pid and associated task->comm[].
> > This simplifies the initialisation and lookup.
> > 
> > Don't bother trying to initialise the pid field no a non-zero value,
> > it only matters in the tracing_saved_cmdlines_seq_ops code.
> > Allocate entry [0] first so that the tracing_saved_cmdlines_seq_ops
> > code can just index the array with the file offset.
> > 
> > The code now uses the correct size when determining the page 'order'
> > to free the structure. The smaller size will always give the same
> > 'order'.
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> > 
> > Is there any reason why this code uses alloc_pages() rather
> > than vmalloc()?  
> 
> It's been a long time since I worked on this, but IIRC, it was to keep
> the pressure down on the TLB when tracing. It updates at every
> sched_switch that has a trace event occurring so, I likely used normal
> pages which are part of the huge pages the kernel sets up and doesn't
> affect the TLB as much. vmalloc does have impact on the TLB pressure,
> and tracing should always try to avoid that.

Isn't this a cache so that the pid numbers can be converted to strings
when the trace is read out after the actual process has exited?
That does mean that cache doesn't need to be updated on every trace
request - it might be enough to just save on process exit and lookup the
pid itself for running processes (the whole thing relies on pids not
being reused).

> 
> > map_pid_to_cmdline[] is 64k*sizeof(int) so the whole structure
> > expands to 512k with about 64k/20 (about 3200) pid entries even
> > though the default is 128.  
> 
> That's because it is not dynamic. That array needs to be able to hold
> most PIDs. The default is 128 but it will expand to how much it can
> hold to allocate the full map_pid_to_cmdline. The real default for 4098
> page sized architectures is 6552 entries.

That is double my 'quick calculation' - but both are a lot of entries.

> > AFAICT there is only one copy of the data - so it could be static.
> > Perhaps with pointers to map_pid_cmdline[] and (after this patch)
> > pid_comm[], both of which could be separately resized.  
> 
> map_pid_t_cmdline[] is to hold the PID_MAX_DEFAULT amount of PIDs to
> avoid collisions. I wouldn't resize it.

If comm[] is only saved on process exit you'd likely get away with far
fewer entries - getting collisions for processes that have exited is
rather unlikely.
(I wonder if I could make that work.)

Does that memory get allocated at boot time?
512k is a lot to allocated for a feature that won't usually be used.
OTOH you won't reliably get that much contiguous memory later on.
Deferring to a later time (maybe as late as the first tracing_on())
might be more reasonable - but that would have to use vmalloc().

I'm also not sure about the code that lets you trace from boot.
That must be able to initialise early - but I'm not sure how early.

	David

> 
> > 
> > I also noticed that map_pid_to_cmdline[] contains indexes into
> > pid_comm[], restricting these to 16bits would half the data area.  
> 
> Hmm, yeah, this could be useful, as it doesn't appear one could make
> saved_cmdline_size greater than 65536 (or even close to that).
> 
> -- Steve

