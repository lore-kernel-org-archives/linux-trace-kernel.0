Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9F1F4629;
	Mon, 10 Feb 2025 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208065; cv=none; b=EcdCPDFylWSsUdHYmQ1HuM+BcUEtSz1DVtohoXj/qKPL9fkHjx98eSVXWN8Pw2JZ/d5g1x990GO5Oxo7XKEnatiLKwKtUMORcJ0I1tpZbzjbRSxSDx8QGhc50NbcYMm5iEFYmP+AYQdE1lcrvIFo9I/83ZFOE96zNaLJj6z2uZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208065; c=relaxed/simple;
	bh=bWBVCdSPg4sFnxm4ZyzpSb55fvElUtmG3NQQc/Jnf7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbCRkgERgVrkbVwaJaymIUf4BsqvZbzL2ahtqXtgZRGiMrPgXWP4DQodwhC8OOVS0TGqQmCDtUXmIZYS3GNX/GhnZzbmcKHgDoueqGwl+Icv5IWq+k/6fWJMYgqdRN3ZPZ//vmjgDR3KyoV8ltwJBAQ7xhBYUrbPPKH0UcHc9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOobZdYN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOobZdYN"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso8603775e9.1;
        Mon, 10 Feb 2025 09:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739208062; x=1739812862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZBLqDU7qXFhhc3B/+6vLC/ZjO95kH1/L9KVNqoEbow=;
        b=KOobZdYN5wqpo6bxBBeQAKMJLSDnd9j8QZvkoH65qtzXnybnHw74F3NdYjK/bcWnSn
         iJ65o3kZyInQp9Pxv+VRXkQ0yTu6tAutX5y7sekXsMJo8VwgMe3Zt+jBeR1eKN/ngh1x
         Cuzga3gtXUhEI9a0lHnMz3aZgh9F1qL/L8nEkIxSFIiFxFanMljOyFA77VnposjLHC7N
         5qGtSeoriJEktIjMPzGui3TuWt3ayQB5ju5FuttRlWkk5Kq6wTjavNw1YH69+pJw7V2Z
         W5tt34mYU2YmLM3C8TYKblc8qB/BVxMDylgrkNW7Ky2NsXGQNJwVU0NFJJppJFWtmPmE
         ijUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739208062; x=1739812862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZBLqDU7qXFhhc3B/+6vLC/ZjO95kH1/L9KVNqoEbow=;
        b=e5RYJ6XHgSJqqaIrM50URqywNND+QgKUNGQCDAGtxBotZShOC/5ak3ELHUBMvHPU4D
         Jq1cC/qhWj2snQsC+Vh5K8RXufEpglq5Ft2i9HtmZ20mC7fZzeOtZYboNxHrfxkduEgW
         e0hDWDSw4SwvuCR0I9Bw5+3V5rj2vK1Onxe3Y7qHZmg0G4ghoIhzvOUvMuTFzZ4Pscrv
         lyG4paN23CY05CQZFgVdxgn9gnfJvzpGftMMUsXknjBPlPUUiOcztJE4/iDTpRmDS5Va
         LLE3PxX1AG2gja/tLVpBlr2f5i7fiEJKY/q1/6itxKr2m91KGiwtZcuYrw4+q7gfk639
         cYxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV91ks8iBU3ZjT14YC7yD/1E8IsRLoCLIJTw4ATOvw6N4fgSg+WzkMkZ7mvbOQ1tc4ZSbj+iCabGJ7E1MwVYdm/QeZg@vger.kernel.org, AJvYcCWvwtOQE1WQbvsUAN7rN4fwbTXlBOLKUG2Gi6NGtMEifTrTWAD1wNICPvqcg2PZEcLwTB8H+p5HKPJJ3E4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZYRiCBuqQgRAxIs6aieG6kzumXjBPt3qSXFNzXlTZQa/qkpZ
	zt6k8toi2MccfZCORS1aGPjLqry1FNtTGZG5ZHN3ll6kKrFFD4ll
X-Gm-Gg: ASbGncu32fUGJM61Pc4zsgxglmH1hbGxVqcb6VJYjxLGWZqoxtlDvFIm/hV1bNJAdDp
	2lqXBvNay9v898No78l9JFaWwaA8ys9atsLxpduruMpkdVeTOyNkdMGQfaHAhvZUy1VVb6Xdg3Z
	E19wFYB9RGUnPx9/3O/3dLlKtcb16rrqFnzkjC7AurV/KNYdRW+qmNRpo0WjcKJPHbZF3iq8RF5
	nYHO+mrCH7AuJiWPdGDuVTIj5T7eSkGcQg8f3cn+dAAo7P2SPPPHlOnoPiUUs3a+Uj0SgiJZICw
	GkWM96RrGUVHXDdhQvL7zDX1lIjwAFgRbTqDNNAxgklymjSNxrAXcg==
X-Google-Smtp-Source: AGHT+IGwhZp7sR8qO7EodMLEWTI6zPWQZVM+o0lti9Zoirk7XA/gfdo2Qj8sUs2rlU3vUl9jP4zoog==
X-Received: by 2002:a7b:c319:0:b0:434:f586:7520 with SMTP id 5b1f17b1804b1-43924a27e47mr132662305e9.6.1739208061666;
        Mon, 10 Feb 2025 09:21:01 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390da70fbesm188607735e9.24.2025.02.10.09.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:21:00 -0800 (PST)
Date: Mon, 10 Feb 2025 17:20:59 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Prakash Sangappa
 <prakash.sangappa@oracle.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, luto@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com,
 raghavendra.kt@amd.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Konrad Wilk <konrad.wilk@oracle.com>, jgross@suse.com,
 Andrew.Cooper3@citrix.com, Vineeth Pillai <vineethrp@google.com>, Suleiman
 Souhlal <suleiman@google.com>, Ingo Molnar <mingo@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Clark Williams
 <clark.williams@gmail.com>, bigeasy@linutronix.de, daniel.wagner@suse.com,
 Joseph Salisbury <joseph.salisbury@oracle.com>, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250210172059.07cda916@pumpkin>
In-Reply-To: <20250206083039.0916ad24@gandalf.local.home>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
	<9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
	<20250204220418.35949317@gandalf.local.home>
	<CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
	<20250205081635.397eacb0@gandalf.local.home>
	<CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
	<20250206083039.0916ad24@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 08:30:39 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 5 Feb 2025 22:07:12 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > RT tasks don't have a time slice. They are affected by events. An external
> > > interrupt coming in, or a timer going off that states something is
> > > happening. Perhaps we could use this for SCHED_RR or maybe even
> > > SCHED_DEADLINE, as those do have time slices.
> > >
> > > But if it does get used, it should only be used when the task being
> > > scheduled is the same SCHED_RR priority, or if SCHED_DEADLINE will not fail
> > > its guarantees.
> > >    
> > 
> > Right, it would apply still to RR/DL though...  
> 
> But it would have to guarantee that the RR it is delaying is of the same
> priority, and that delaying the DL is not going to cause something to miss
> its deadline.
> 
> >   
> > > > In any case, if you want this to only work on FAIR tasks and not RT
> > > > tasks, why is that only possible to do with rseq() + LAZY preemption
> > > > and not Prakash's new API + all preemption modes?
> > > >
> > > > Also you can just ignore RT tasks (not that I'm saying that's a good
> > > > idea but..) in taskshrd_delay_resched() in that patch if you ever
> > > > wanted to do that.
> > > >
> > > > I just feel the RT latency thing is a non-issue AFAICS.    
> > >
> > > Have you worked on any RT projects before?    
> > 
> > Heh.. I think maybe you misunderstood my statement, I was mentioning
> > that I felt (similar to Peter I think) that NOT adopting this feature
> > generically for all tasks due to a concern of 50us latency maybe does
> > not make sense since poorly designed app / random hardware already
> > have this issue. I think the main concern discussed in this thread is
> > (and please CMIIW):  
> 
> We have code that has sub 100us latency and less. If some random user space
> application applies this, adding 50us (or even 20us) will break these. And
> this has nothing to do with poorly designed applications or hardware.
> 
> By adding this as a feature that works everywhere, you will break use cases
> that work today.

Hmmm... you lose big-time anyway.

All you need is a lot of network traffic 'pinch' the process context until
the hardware interrupt, NAPI softint code and rcu softint code completes.
That can easily take several milliseconds.

We managed to get a trace of a SCHED_FIFO task being pre-empted by a
higher priority SCHED_FIFO task.
The chosen target cpu was active running a worker thread.
That got interrupted and ran softint code for several milliseconds.
Other cpu became idle, but the scheduler rather expects to be able
to run RT threads on the cpu it chooses.

The same can happen if an RT thread grabs a mutex for a short time.
All it takes is a hardware interrupt and the mutex hold time goes
through the roof.
You don't need a context switch to hurt you.

The only userspace fix is to replace all the mutex with atomic operations.
(And even they can be griefsome because they are measurable slow.)

	David
   
