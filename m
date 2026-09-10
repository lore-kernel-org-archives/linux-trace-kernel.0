Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC4390C81
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071638; cv=none; b=liHUZUBmgvLGI44LLsjLbsG6lbcjkO1KJ4ZeH0+rUnT/sMjzd1dmd1cT958PpSwoeQXg6hyMH7XwujDIW5/G1Ar/kjhW0M0MMqWChZctkjoFERZyzt5TphsuXGMWb0Nbxl3hUsE3ZfVae89z0K/pojirpo64nBf65qdqjCvoSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071638; c=relaxed/simple;
	bh=pSWvcV8K/uxMZaanbQsY4b2j4vYqXLmb3x+8zHpAVM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCbxcXJ/3GBQY4NGSpW/BmLW4sNYnv4Zhpnq6hbAIKu0XWOct+Fcz1wTqnYumbOvcecgNQnqfvSj0G92HPVoX5BB0/uMzUsdCucfIpH2HATss6xwAIZFlDkAnSFCwkd+3uj1AJ/A/oqfLsefQOyOpUqXsLf5atYpQkhQBOOpl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVrVv/Hx; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVrVv/Hx"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48434392b02so106548f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 13:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789071635; x=1789676435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mOBrXIIG7Xd6rL1yLTU4+HAFOoDEt4viqKwFGqyDssc=;
        b=kVrVv/HxLcTwancbveUEpQzjO5H+T9w1N6fEBXWK7xYYlIzyBn02ZtJPT0MfqppYev
         zIXRXsSbW6IxWSCquP3+ApxrB41cqxbgGPUS8hOQkp9on7Za20+jBqtlMaAKoG1fCAya
         wcAszjRNuzmg4XYyqD5pxFuEwjFKQR2ieoC5KGj0QC7yskK1n4zdJizCvyx3Wnq9wfzU
         +awLsAtB5FZvrfh1npxwlzHfnON8w9n53lGuvWEuwwu7Z/zKc8fEs8c0T6un146h3N+/
         d3+3X/VcIivHV+luZPrln/60MBa8kHsbqqN8aXvdG6viOUvYUcgxFXZ0kWKcpYjYVx3F
         lBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789071635; x=1789676435;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mOBrXIIG7Xd6rL1yLTU4+HAFOoDEt4viqKwFGqyDssc=;
        b=fiy4XYXcji176nkaoLXr7ydioefqUk5lkBcNL9iIgVYTEG7S7Vw48xq1zsYrmLEOAa
         +3hd3Fg+7VlGQuNLrfGeEi/k6nh65ef+B4LeXUPQAMTx6/iQXkwlC6j8lQ1bD7GadTff
         frBkGUgba1mPpnXQx0NzH1OigzAB+XeOsOeybXx502IamQKc3GVaiao419aUdGS2gpvJ
         eG1Z87SoH8FSi8Pbx5N09Zu6r56R1wBge3bCNKYdwnaICQpHloGv7I5wj1qeAYaUt5eQ
         pet7E8BI+769gCS+Aqda+jVegbYZ6/Bw8NyzMW6S85gUzYaBwd0nsLThEEiP9BVC30Dz
         kX0g==
X-Forwarded-Encrypted: i=1; AKwUvBwAUT7FCmbUHK9+G0eeiXma72qP8VOmNxMJi3G7hg6Ld9ovb1ff2uisaQ8mX4Uze3b4bceX4KRRRMKeW/LyKorPHgI=@vger.kernel.org
X-Gm-Message-State: AFuF++lwh+jJg/O5FGG+fPchgqy7p+89BTNeEeqcEg8dQZXYfh3LiTeH
	w8IPvUtTXROPjFC+rOp9dnSN3agSdObbRcuuaHryc6QvR2W0NIKsM2B0X8E+nKZB6g==
X-Gm-Gg: AYBFou3McY7Zyfij/TBqfiJ0GOWTupFdM4XweegEBhNrsQJvYlrtHwPov7lP7V45anR
	NgkZ+h1I9lcyKYQRa0wxVeJhSr5gjMAtxD2bDvuKX9DobSpTtGYK3NRUNnEl+QxdGL86mn3aGFn
	V2Gz3ZXKEYF2ZIkYUnBkbfqBeUz/GCwEniZHIeqwB6IBTGYbrZb4F4GCRZkUhar2qVQ7Ovc3MVU
	AW9cz6nln+zNar/a7Q9I05Zx1I1iMwy42wrJnLwsGCe2KTWmwnKjYR/1NLz6vECjZQd494h1NA+
	CycmNrYvsg7yzXxOQrVabjliAgRqGfgp9WXhqI0bf7kOjUQGhIRio0nL1uh1nqs+kCO0IEYVNXU
	8hdPZYzS+WYpjIky9ZblURoXLwjs3xkl3rdqRPbRNWrfYCHZTur0UyoSRmR/+UoK5wtUg7Jlslx
	vZalQKiF9Fo0z6DUkcBz/ePiS0WGg4CDq9+8Uvj+e5aRygWtKTx02TrMHQg/PgNY1mTD+DAFPg7
	3oSXLVaibqWmcGXYi6Rqw+YMBqnct+XG+zlf9dAt0m9
X-Received: by 2002:adf:f9d2:0:b0:486:e6a2:2d7c with SMTP id ffacd0b85a97d-486eb31b1ccmr1092516f8f.15.1789071634748;
        Thu, 10 Sep 2026 13:20:34 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35bed0sm781202f8f.32.2026.09.10.13.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:20:33 -0700 (PDT)
Date: Thu, 10 Sep 2026 21:20:30 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ring-buffer: Add a MAINTAINERS category specific for the
 tracing ring-buffer
Message-ID: <aqMRDq3SzHDhFEQp@google.com>
References: <20260908094035.0b180833@gandalf.local.home>
 <20260910155058.1ac4c991@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910155058.1ac4c991@gandalf.local.home>

On Thu, Sep 10, 2026 at 03:50:58PM -0400, Steven Rostedt wrote:
> 
> Masami,
> 
> Can I get an official Acked-by on this?
> 
> Vincent, you can also give an Acked-by too.
> 
> -- Steve
> 
> 
> On Tue, 8 Sep 2026 09:40:35 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > The ring buffer code in the tracing directory has always been decoupled
> > from the tracing code. It had a clean abstracted API to allow it to be
> > used by systems outside of tracing. The API even allowed the ring buffer
> > code to be drastically changed without affecting the tracing sub-system.
> > 
> > Recently, Vincent Donnefort has been contributing a lot of work to enhance
> > the ring buffer. He implemented the user space mappings and recently
> > created a version to allow pKVM hypervisors to use the code to trace
> > the hypervisor and expose the events to the user.
> > 
> > Create a separate category for maintaining the ring buffer code so that
> > Vincent can become an official maintainer of it. His work has little to do
> > with the tracing code itself. In the future, he may even be the main
> > maintainer of the ring buffer.
> > 
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > ---
> >  MAINTAINERS | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3a19da74d00c..71bd2f57055d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -27778,6 +27778,22 @@ F:	kernel/trace/trace_irqsoff.c
> >  F:	kernel/trace/trace_osnoise.c
> >  F:	kernel/trace/trace_sched_wakeup.c
> >  
> > +TRACING RING BUFFER
> > +M:	Steven Rostedt <rostedt@goodmis.org>
> > +M:	Vincent Donnefort <vdonnefort@google.com>
> > +M:	Masami Hiramatsu <mhiramat@kernel.org>
> > +L:	linux-kernel@vger.kernel.org
> > +L:	linux-trace-kernel@vger.kernel.org
> > +S:	Maintained
> > +Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> > +F:	Documentation/trace/ring-buffer*
> > +F:	Documentation/trace/remotes.rst
> > +F:	include/linux/ring-buffer*.h
> > +F:	kernel/trace/*ring_buffer*.c
> > +F:	kernel/trace/remote*.c
> > +F:	tools/testing/selftests/ring-buffer/
> > +
> >  TRADITIONAL CHINESE DOCUMENTATION
> >  M:	Chen-Yu Yeh <chenyou910331@gmail.com>
> >  M:	Weijie Yuan <wy@wyuan.org>
> 

Acked-by: Vincent Donnefort <vdonnefort@google.com>

-- 
Vincent
