Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616177;
	b=dyEULg6nQbIr4dFXhr9XK9nx08poBs8bKkOIy8eU1+YjvFvSF7VzcSseua63Qr2pXYhm
	 N4Tkxtejdg53di1l5IMg5uNQTbdUJUyAUtr3iDf82FwcsXgdSWhxqqB0cFpAsvMZ77y1h
	 vFCUvioiiNSD+jY3zWbAx0HTcI5AxSeMKPShxRUPo8yXJvUAtquj02tjPypGxOrZMBwXc
	 /XiKwugQMh9Oagf2qWb18oCTwHkSMlZKWi1IpFcp7XaW4lvDu3boVahePwlSttn2uRoiS
	 2Y6r1NnEfTFd/g6mnc0ZrrvrcSRN5lyvTF62Ai+bdHBFlsCvF21zd+Hd+pvZYcVhBCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616177;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=aWyI2O7H0NtGnKP5/F2krKuxvxxzodN6y5EnFjYm8Wk=;
	b=f6rphA+uNDaGjIXjRFKCSCCYkaD/nNl0q/qa1WJJMRKky4cYvca3PJNU03ImoEorbTGD
	 rqf0k69whOIvPQxIOKGulXUiwbzOQArYgo2zN0XRt8B0gpqa5TByHJNtP14gwS7rqWNxi
	 PhGDS0vOg1ljT/Qry+/RLsODh1+nCY4YArmaGgCbPoK88zK6w5zIymm9p0JT6tMcRkjb0
	 LDtX87tcfmKRuQIW6Vjzd6G7u3vNDjsmQjm0bXtCDGxhu8JkVPyXMjZAwSqsLR4VYHX3Z
	 iJr97rZew1utgFGn6lJ9J6W3RLVhZHCyLwYvtoQaIvIWhSGH8K+i1EtijN+mtivspdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=rj19RG6Q;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5E606A31E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 14:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FA5E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=rj19RG6Q
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id AE3A0A0F4B;
	Wed, 25 Nov 2026 14:16:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id D9FB420012;
	Wed, 25 Nov 2026 14:16:13 +0000 (UTC)
Date: Wed, 25 Nov 2026 09:16:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Crystal Wood <crwood@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/10] tracing/osnoise: Per-cpu mutexes and fd
 detachment
Message-ID: <20261125091612.5458e933@gandalf.local.home>
In-Reply-To: <20261125090122.22fdb88d@gandalf.local.home>
References: <20261113064103.3041704-1-crwood@redhat.com>
	<20261113064103.3041704-6-crwood@redhat.com>
	<20261125090122.22fdb88d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: D9FB420012
X-Stat-Signature: euikbp9rxmzw8pxrsx44fof1cctw66s6
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/ZI8H7qxrdo4aXIPD6XC9VyPXhSlUTWKI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=aWyI2O7H0NtGnKP5/F2krKuxvxxzodN6y5EnFjYm8Wk=; b=rj19RG6QqUtXqrcuEjsuRDcyls9emkUY+NAUtuLTRHXAUUPIypb1a4h6gJRG0AHpMV2T+oe+MQh5wZYh5XPqfWM/YcfWXQfBhhYt3PWN9RcGW5cnS8vijYlMuIxG9aNqKOfDDqM7RmEWgv2n4eDQCQtlfSHowHuj4ICKZrqN9Tc=
X-HE-Tag: 1795616173-333785
X-HE-Meta: U2FsdGVkX19ZDj+Qfe8Y3WXxsL/L+hR1d5CaHp18+kcv7VZ5IbYSYX9AFW5UjzUjoO8IvXRK4SJmGBVqAFV5hyMcvOW+ODeynpzqR01qejyJXq7S9FWfLVddQZyJHTpwDKuQcahQEWjsko+mWVehPpMqKvhYWX36PTnRj7OGP17rCjljezVNqJDZrWNj5OTwFcPdJcd0zetRoDEKCa+pVCQ2VBg0gmMnyZJ8mfFhJ2E03yR0dZKswPOD3bsBndDsyolreZc7crRJnFOradwrg7XF/dQ+8Oc805NEJzpDsUi93dcDxGjYXdYlGyOAxihZrIRFmoR/XMaEJypqD20508l2zZqLW2jDI1NuBfWr6+WeQ+0d12P6FIUMaN3/CTBf

On Wed, 25 Nov 2026 09:01:22 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

Hi Crystal,

> >  static int timerlat_fd_open(struct inode *inode, struct file *file)
> >  {
> > +	struct fd_data *fdd;
> >  	struct osnoise_variables *osn_var;
> >  	struct timerlat_variables *tlat;
> >  	long cpu = (long) inode->i_cdev;
> > +	int ret = 0;
> >  
> >  	mutex_lock(&interface_lock);  
> 
> Hmm, if we switch this to:
> 
> 	guard(mutex)(&interface_lock);


I see now that patch 8 does this.

Can you make the guard conversions first, and then do updates. I rather not
have patches that add gotos just to be removed later in the series.

Thanks,

-- Steve

> 	
> >  
> > @@ -2437,16 +2495,16 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
> >  	migrate_disable();  
> 
> and this to:
> 
> 	guard(migrate)();
> 
> >  
> >  	osn_var = this_cpu_osn_var();
> > +	tlat = this_cpu_tmr_var();
> > +	mutex_lock(&osn_var->lock);  
> 
> and use:
> 
> 	guard(mutex)(&osn_var->lock);
> 
> >  
> > -	/*
> > -	 * The osn_var->pid holds the single access to this file.
> > -	 */
> > -	if (osn_var->pid) {
> > -		mutex_unlock(&interface_lock);
> > -		migrate_enable();
> > -		return -EBUSY;
> > +	if (osn_var->fdd) {
> > +		ret = -EBUSY;
> > +		goto err;  
> 
> 	this could simply be:
> 
> 	if (osn_var->fdd)
> 		return -EBUSY;
> 
> 
> >  	}
> >  
> > +	WARN_ON_ONCE(osn_var->kthread);
> > +
> >  	/*
> >  	 * timerlat tracer is a per-cpu tracer. Check if the user-space too
> >  	 * is pinned to a single CPU. The tracer laters monitor if the task
> > @@ -2455,33 +2513,47 @@ static int timerlat_fd_open(struct inode *inode, struct file *file)
> >  	 * setup.
> >  	 */
> >  	if (current->nr_cpus_allowed > 1 ||  cpu != smp_processor_id()) {  
> 
> 		return -EPERM;
> 
> > -		mutex_unlock(&interface_lock);
> > -		migrate_enable();
> > -		return -EPERM;
> > +		ret = -EPERM;
> > +		goto err;
> > +	}
> > +
> > +	fdd = kmalloc(sizeof(*fdd), GFP_KERNEL);
> > +	if (!fdd) {  
> 
> 		return -ENOMEM;
> 
> > +		ret = -ENOMEM;
> > +		goto err;
> >  	}
> >  
> >  	/*
> >  	 * From now on, it is good to go.
> >  	 */
> > -	file->private_data = inode->i_cdev;
> > +	fdd->thread = current;
> > +	fdd->detach = timerlat_fd_detach;
> > +	fdd->cpu = cpu;
> > +	file->private_data = fdd;
> >  
> > +	tlat->tracing_thread = false;
> > +	tlat->thread = current;
> >  	get_task_struct(current);
> >  
> > -	osn_var->kthread = current;
> >  	osn_var->pid = current->pid;
> > +	osn_var->fdd = fdd;
> > +
> > +	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
> >    
> 
> 
