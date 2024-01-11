Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEA611722
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yu27uoyA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so57789745e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704966773; x=1705571573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/bwyoUlj5RFkg/2AGlXQggNwtIEjVVUzKBYI85mjvA=;
        b=yu27uoyA2XiaVtQ1khyZJ6l3itnUb5WcE14CZAlvbDvaY3btk6luKMRLbcg79qsPfu
         6FlpfaF6dH+6w12e3RjdShedSZbCPSgPRMReLwJZ20vRcY5FUg5noXxZXYpwe7Zukb/Q
         JzkBZSAjSV8z8FGI3Yl82SKPFHIPGnhau32zws2D5LLE6btYafc/2AQ/S8FBgDk2SIJe
         8+8/rHSPjPsd12SsNTdGbcMAsMco9RixGvFT53vEyRMcEneac/ZDF30atN1NSs9U5KZC
         ZZ5/k9TWgg1VGOQaU/8EsFY+kt4PqsfBZwbruM+HDMxgly8PL0jKX7iIF7fuane8uBMa
         wNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704966773; x=1705571573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/bwyoUlj5RFkg/2AGlXQggNwtIEjVVUzKBYI85mjvA=;
        b=hT4WMufeHDEAqOzWmVgGiOsgEJi1M5FsX1MBnLmY4EoNrOOtz+XS4Ijq2sJA86Yzvf
         K00x4wRGyFJ7yXRHSODPYRMwSl12z3RMBLFnFsDyuMxc0iBtD9edynkylB04N0yNH8+N
         rvND8oXXEhvjcD/VR9DqacU23mBKfxePhF/xyy4aznXAt0TnGoxz36ZEShJwHCnO8n7z
         1Be0qJXjZM47N5DwCkpwlyEbF0NnNB1dpqr9SLPnVc907hXZtXuJj6j0cb6yHKMb5L/7
         ZGDnRXIiPcFpw9ucSlF8GJgtps3klYpahZEg7xaxLWPSE/O9tirhVUArAiOz9DD510fl
         s87g==
X-Gm-Message-State: AOJu0YzWNbNC1o8CjxZwOgpqHg3QO1pOEI2Ge7alXDetF+FvUfKKP4gX
	X3BkNDD+evBwmS/QJwyajZ3gQ1EOtvjN
X-Google-Smtp-Source: AGHT+IEktLB3zxjXBruDI/lcCgkzMrMI7MyWCGvE3+Giv7rJ5camo0QlU/jlj4z8HKX03sZpaqnJjA==
X-Received: by 2002:a05:600c:6a8d:b0:40e:52d3:ff64 with SMTP id jl13-20020a05600c6a8d00b0040e52d3ff64mr272953wmb.188.1704966773239;
        Thu, 11 Jan 2024 01:52:53 -0800 (PST)
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c445500b0040e3bdff98asm5064362wmn.23.2024.01.11.01.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:52:52 -0800 (PST)
Date: Thu, 11 Jan 2024 09:52:49 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com
Subject: Re: [PATCH v10 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZZ-6cQkdehcnNNDy@google.com>
References: <20240105094729.2363579-1-vdonnefort@google.com>
 <20240105094729.2363579-2-vdonnefort@google.com>
 <20240109234230.e99da87104d58fee59ad75c6@kernel.org>
 <ZZ1ir0edlY3OzjyC@google.com>
 <20240110084205.2943f88bf8b797b04297b0ae@kernel.org>
 <20240109185813.5e071eab@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109185813.5e071eab@gandalf.local.home>

On Tue, Jan 09, 2024 at 06:58:13PM -0500, Steven Rostedt wrote:
> On Wed, 10 Jan 2024 08:42:05 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Tue, 9 Jan 2024 15:13:51 +0000
> > Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > > > > @@ -388,6 +389,7 @@ struct rb_irq_work {
> > > > >  	bool				waiters_pending;
> > > > >  	bool				full_waiters_pending;
> > > > >  	bool				wakeup_full;
> > > > > +	bool				is_cpu_buffer;  
> > > > 
> > > > I think 'is_cpu_buffer' is a bit unclear (or generic),
> > > > what about 'meta_page_update'?  
> > > 
> > > Hum not sure about that change. This was really to identify if parent of
> > > rb_irq_work is a cpu_buffer or a trace_buffer. It can be a cpu_buffer regardless
> > > of the need to update the meta-page.  
> > 
> > Yeah, I just meant that is "for_cpu_buffer", not "rb_irq_work is_cpu_buffer".
> > So when reading the code, I just felt uncomfortable.
> > 
> 
> How about "in_cpu_buffer" as that is what it is.
> 
> struct ring_buffer_per_cpu {
> 	struct rb_irq_work {
> 		bool	in_cpu_buffer;
> 	}
> }
> 
> Would that make you feel more comfortable? ;-)
> 
> -- Steve

I'll actually solve that by moving that update from the rb_irq_work to
ring_buffer_map_get_reader().

Reason is the rb_irq_work is only triggered when !O_NONBLOCK is set.

> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
