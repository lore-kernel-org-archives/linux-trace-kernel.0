Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923A39FCB1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627551; cv=none; b=hmha0G9Q9MvhHp5jHJAkYc7CGZ6DajK6iXPaoVfXe8fqzsjSkRL8vOX1mpSw49ngcmDd/GB+L39x/Uh1o1Q3SG/YX6WijBKaVW7WYR3UYz/cqbHawXveYPc4AFDD/J0ozxdo2rINt3jxqdoEHUQr03m4ucP0Al1W4URt3ZTxbJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627551; c=relaxed/simple;
	bh=2BuxNkQYxYj9qq/cib0m9rPF3xFiXsKVNtyEBD4V7CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mboeCd6XVfo1RapZ7m3p6HLBSqMhhjyyWZK0HE7wdnLs5JC2AuriOZJtU8rBamtmgugiGPSeFwYDPGag0l77YS7EU58um8JhbNS7giGadxalFfXB7uIxpmg7U8z8cHxjCeAzV7bWpRRadY7SEbOcDAlNaeVbXxEHue8USebj4pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GhTq80OI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GhTq80OI"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso300962266b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 06:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786627548; x=1787232348; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+H3sd2IVUaZuvvTHtvhvefhtE2d9rSylbl8r/c0+eUI=;
        b=GhTq80OIL7WvxefETzkteq3aP9h704F00sGacNRsRl5QboggDQcH9GtfNWQ2DGFkOm
         /aMm0GnOphV3fnxz453n6l0mBp/zNmjWkXHBJqeuouG/TIyhktHjjG7kg8na3PvJY3oi
         D5Whi4Y6dZJDm+Yw6qBQa0LQKW7f2ZHsPRNREgWtbT9WiIdvT/31Xis4EjHPrBEZ6a6d
         nnDM1+kK1dCthtOm5x0Y9WDDLg0n3OJ8Pu2bjnFi9NmMZb0LgiXjL0QxTW2xVCGVlqRI
         b/8SyOVGTd7HCa6z5+pnbWS4g3a1uFCFIex1FzppZ00bW25snNaMEthpd0jJDHqLx1sS
         C9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786627548; x=1787232348;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+H3sd2IVUaZuvvTHtvhvefhtE2d9rSylbl8r/c0+eUI=;
        b=ZRj20/JvrHy/fVD3qroYrWHJsduMny4tsVBcTw1ahWqOMZEy/FAyEopjfoY0TqkyUe
         O+aVT29nDakX01XM/2ba490uiaTqzJxlt7jQMYwBW3zBxJGJuZFIHMSDraAgTECN0NQ4
         A2XDvd+fZmprnzS/bjAWKanqvGvyGHivcbz2zh4hbLFcQQQNtmyjdKBvJ69gYZLKfr08
         HF9+GcgsmKOEEMbvo/pH6U0E60mex8C7MhflPyXMLo6+GMTxUubXVbWS3/CyUxUdpdSu
         2Af8A65V1co/qd6yoa3NlP4eIF2qDceApPmgPZfp7Uox6jbNVgOtyLRppO3blKhBRyo7
         HngA==
X-Gm-Message-State: AOJu0YxrtDUO+3G/xOzOIK0DGPJLqIKwKd4Vhnxi6AW7/JXDOIhUfoNr
	rqS8pm/kuesYjawQArmJhEeNPuykv+eI2aRfPZKDuPHLggLCz6bvrwaCE9MQ9ebN1AcL4Il9jRF
	DRlV9Qw==
X-Gm-Gg: AR+sD13q6SOnKzmvuAXHEa5xnGKKlTJ4raW9Jli+nQ7ivEwgWsjXPFF3qzyJY+rbc3U
	EkPXnyDnFR21rUf2n8wicyw4324kwQ++mJbJERF8oyaiff2h/WN3v9INhX03aFjc+40X1A2N96b
	skHRat2vb0FxjQJ0j30MJwKLgUXG01OzKNEL6FfLK/AdZ8JquAgZ3stSSwFJClma2J1ycDqgfJK
	vAGMYTxvFgV9LOflLdHVqlKNfBS+O5BNDrgHMcn1MxxFq9ZYEvguK8txokDfyZD4xZqY2hj0vyT
	YIA1XAZCt57Q90lanQFxiFFVgwdLAimyqF4YDHl9OPibvbETGfJ3CT8DomS1i3KsobV1uiUKzad
	vA8avf5Dw3VmN1d01qyPImaPKxR0OCVCJdZOOkOmoN3yZaEEGF12arCdSOoN1KG1qNQsrwNlGFJ
	QD/rEnnFYD+3mueaUT0/FzSwiwaApcHhVxDjYsiPSNqALsYlwq0dt0b7w9B4pFwR1aNRQvmSeHm
	foP4KTrVM61Wynd9/fpGi1sFINv/A0hnObpXzW0F/E=
X-Received: by 2002:a17:907:1784:b0:c20:f95c:9088 with SMTP id a640c23a62f3a-c2108dbee00mr306737066b.4.1786627547045;
        Thu, 13 Aug 2026 06:25:47 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c211aa04446sm14068766b.26.2026.08.13.06.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 06:25:45 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:25:42 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/18] tracing/remotes: Release tracefs,eventfs on
 registration failure
Message-ID: <an3F1j_7CYxFk-FQ@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-3-vdonnefort@google.com>
 <20260812162503.6A4FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812162503.6A4FC1F000E9@smtp.kernel.org>

On Wed, Aug 12, 2026 at 04:25:03PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Expanding the global `trace_remotes_lock` over the external driver callback `cbs->init()` introduces a severe risk of deadlocks and priority inversion.
> 
> Pre-existing issues:
> - [Critical] A Time-Of-Check to Time-Of-Use race condition between `trace_remote_tracefs_open()` and concurrent unregistration leads to a Use-After-Free.
> --
> 
> --- Patch [2]: [PATCH v5 02/18] tracing/remotes: Release tracefs,eventfs on registration failure ---
> commit 70ddc6ce63b80a301a72ec3efb7683b32447865f
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> tracing/remotes: Release tracefs,eventfs on registration failure
>     
> In trace_remote_register(), if registration of events or the init
> callback fails, the created tracefs and eventfs directories are leaked.
> Release the entire eventfs and tracefs hierarchy on trace_remote
> registration failure.
> 
> > diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> > index ce2d517183b79..0384277070b9e 100644
> > --- a/kernel/trace/trace_remote.c
> > +++ b/kernel/trace/trace_remote.c
> 
> [ ... ]
> 
> > @@ -972,10 +990,9 @@ static int trace_remote_register_events(const char *remote_name, struct trace_re
> >  int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv,
> >  			  struct remote_event *events, size_t nr_events)
> >  {
> > -	struct trace_remote *remote;
> > +	struct trace_remote *remote __free(kfree) = kzalloc_obj(*remote);
> >  	int ret;
> >  
> > -	remote = kzalloc_obj(*remote);
> >  	if (!remote)
> >  		return -ENOMEM;
> >  
> > @@ -986,13 +1003,15 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
> >  	mutex_init(&remote->lock);
> >  	init_rwsem(&remote->reader_lock);
> >  
> > -	if (trace_remote_init_tracefs(name, remote)) {
> > -		kfree(remote);
> > -		return -ENOMEM;
> > -	}
> > +	guard(mutex)(&trace_remotes_lock);
> > +
> > +	ret = trace_remote_init_tracefs(name, remote);
> > +	if (ret)
> > +		return ret;
> >  
> >  	ret = trace_remote_register_events(name, remote, events, nr_events);
> >  	if (ret) {
> > +		trace_remote_remove_tracefs(remote);
> >  		pr_err("Failed to register events for trace remote '%s' (%d)\n",
> >  		       name, ret);
> >  		return ret;
> > @@ -1000,13 +1019,16 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
> >  
> >  	ret = cbs->init ? cbs->init(remote->dentry, priv) : 0;
> 
> [Severity: High]
> Does holding the global trace_remotes_lock while calling the external init()
> callback introduce a risk of deadlocks?
> 
> Because trace_remotes_lock was acquired via guard(mutex) earlier in this
> function, calling an opaque external callback with this global subsystem lock
> held establishes an inverted lock dependency.
> 
> If the teardown path of the external driver takes its own locks before
> unregistering the trace remote, could this result in an ABBA deadlock?

Current users are just fine. I do not think that is something worth considering
at the moment.

> 
> >  	if (ret) {
> > +		trace_remote_unregister_events(remote);
> > +		trace_remote_remove_tracefs(remote);
> >  		pr_err("Init failed for trace remote '%s' (%d)\n", name, ret);
> > -	} else {
> > -		guard(mutex)(&trace_remotes_lock);
> > -		list_add(&remote->node, &trace_remotes);
> >  	}
> >  
> > -	return ret;
> > +	list_add(&remote->node, &trace_remotes);
> > +	retain_and_null_ptr(remote);
> > +
> > +	return 0;
> >  }
> 
> [Severity: Critical]
> This is a pre-existing issue, but is there a race condition between
> trace_remote_tracefs_open() and concurrent unregistration?
> 
> In trace_remote_tracefs_open(), the code checks if the remote object exists
> in the global trace_remotes list:
> 
> kernel/trace/trace_remote.c:trace_remote_tracefs_open() {
>     ...
>     guard(mutex)(&trace_remotes_lock);
> 
>     /* i_private is either a struct trace_remote or a struct remote_event */
>     list_for_each_entry(r, &trace_remotes, node) {
>         if (r == i_private)
>             return 0;
>     ...
> }
> 
> However, the lock is dropped on return without incrementing the object's
> reference count.
> 
> Then in trace_open(), the unprotected remote pointer is dereferenced:
> 
> kernel/trace/trace_remote.c:trace_open() {
>     ...
>     ret = trace_remote_tracefs_open(inode, filp);
>     if (ret)
>         return ret;
> 
>     if (!(filp->f_mode & FMODE_READ))
>         return 0;
>     ...
>     guard(mutex)(&remote->lock);
>     ...
> }
> 
> If a concurrent unregistration acquires trace_remotes_lock, removes the
> remote, and frees it after trace_remote_tracefs_open() returns but before
> trace_open() acquires remote->lock, will this result in a use-after-free
> regression?

trace_remote_tracefs_open() will block until the remote is properly registered,
that is, added to the list trace_remotes.

After the remote is added to the list, there is no unregistration possible at
the moment.

I do not see any concurrent unregistration possible.

-- 
Vincent

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260812161340.2417322-1-vdonnefort@google.com?part=2
