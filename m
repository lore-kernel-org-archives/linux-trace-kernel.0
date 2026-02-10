Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277882AE78
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770737578; cv=none; b=YA55JTAW+kSdXskz/czGr7EGsCnojLgTV6l3DDw4iQcNb1SGmnmeCvyMAuJz5tHFsdug9T/QkW5ZXbIcZ2Agcqs0Zsye/iHqsWQxwXWKhi16eohaXcwbi2Uq/ahScidiYaLV6vCpMxXNXae+hhWHDr7muRUEt+XpjWp5mIy6u4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770737578; c=relaxed/simple;
	bh=+zGChlcQec4XugPYdTxIPOQXVVtEsJsEdmxWCqrDT3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQhPsmf7bhwn7mFOgeH5Ef1EzmkObT6qujgRa/4VG64KkUonvzxZAJpU1my8BCCtOvExxxXseX4pSp5qsRd47QcaDnDS+8riEU0O8MhglMIE0OkPxWw/sYv8SMxtLke0KV4Va1VA9m6HPQWbtnFXhgjtCXVkJd75gZSEZvKTuaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=abs25RIM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abs25RIM"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4362507f0bcso3558649f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 07:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770737575; x=1771342375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EUhq8bUSDIK8bU/Cf62PUQLvFL3hrikVLXNMzuDuSOI=;
        b=abs25RIMGDXDzasPRWSVOkmbtJ81t86ySxJ/vdJDQ0ZkYwNrRtPA42nKU8numIhikS
         iMyJvIpAnxOSIph1QVMNIa4Kpnugob98Q9o0xfd8UI7v1NK9+kUIzw3DxufI6rs6Kpu9
         t8p9LLFwmM+KDYCWQ1V0JbIkcLv+IsuXo6Lx8Iu8fFN1xmnB3nHVXEroHqofLg5dj3CU
         UIMflTPk8u9Rq8/z5crBsHq6/CigSN0Tx+32P+KcnrNCfplKNpZMQzsHK9Dh/HrKID7y
         t86PCsdh01yNygRo3l/gHjPzZIQqfOVf/awYoLmnfWdtv5Yh8ifjShV1ztkY3nz3GZDM
         17pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770737575; x=1771342375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUhq8bUSDIK8bU/Cf62PUQLvFL3hrikVLXNMzuDuSOI=;
        b=g/6TMYcI00zhBor1jDN5trG/7qR7X5DTkK9U/6f8XPFMkitv5bzWFdTPXw/qTp2l2A
         pf7Ad7i6m6+JSKXojtAviL940KevFBENrXu/qwuO9vNMC6Qq6FYSUuuRsaZomxmmNMSD
         lA59BVA3zOPi9XHgyLR4YMv2zvNv304zM96fwXvi2lfjBv6r4pcGPMNvADKsWj9jce0M
         hiWEZHfrwP1srXBFV6DEFjm5hLzXnkhJYQZYHHSMKgu693sA8XRueIK9IuZJblMqz0iN
         cZkAFGKtH8CKI6v5mgwrCJmd6qfn2UHh1FlPygq3enWhcdAmJMSteI3lAhig/+RrRTe3
         g4Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXYKWpzWbhPSbKu2gq+NapKPSoR8KvcCq+cn82FoYcolv1UjQqhGzBNY4t9jRDPz9uixbAp1u0z+fFpyFVdmvfph24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWEZ/8pQzNNbvbNKvm0+HxZIZB00Qvb/BSUUmLZPLBcJbYQyoq
	akZG/hpwnkYJ64wGPRaa2yj3vVoSypYcCOwWLYJZKSX6Rm+YD2s9e5/LE4Faj30d6KnM226iYkv
	fsmr+mw==
X-Gm-Gg: AZuq6aJdl+ERDAYRL86xHfnorsfu+AWpq525cMPGphjqtEP6S6NR5l8k2lB5K4eNkAe
	8qlHJ4rdvJcOm6HPApRGfXPAMSSMkQeLvfODm9LUsP++vFV5qPoK28P4wo8Wr/gR9sv7dmXL+cO
	AQw66/WLDJCANpwB2cHrmr/8Rm6k29CxWwyzVP8x6W4+7a/C+dRGZxKM4IbqLymTGvQRhFtiEkl
	ROMschq3GzSax3DYtKoHHmT4SRf6cak2EkoTN643F4tnM6KUCQ/egOyfZwpjzdezet/okVFDhUH
	ouKHHaoM8oS9G2MSl60kiCoz5BbgcU9hBA7IqWCdsxYx9XMC1VElMMvZmWydKFzALw+8JnfAXig
	STHCMeRlGWY6+SWsjoFQt1OOCasYzzkznVEszR2Bb5SfhhRyYhKzQIcsLx9Vayw4F6GvhaA5BzE
	I4A+gpPEpifzhOrFdJ06AoPf2g89iAOhpI1IDztYkVKwolGjc/e6SK/Ajzu47BinmHbbw=
X-Received: by 2002:a05:6000:24c3:b0:436:e875:7911 with SMTP id ffacd0b85a97d-43779e3bab1mr4635624f8f.4.1770737575096;
        Tue, 10 Feb 2026 07:32:55 -0800 (PST)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376686130csm21600376f8f.1.2026.02.10.07.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 07:32:54 -0800 (PST)
Date: Tue, 10 Feb 2026 15:32:50 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 07/30] tracing: Add non-consuming read to trace
 remotes
Message-ID: <aYtPoil91IX7u_9f@google.com>
References: <20260131132848.254084-1-vdonnefort@google.com>
 <20260131132848.254084-8-vdonnefort@google.com>
 <20260204185208.646a6d26@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204185208.646a6d26@gandalf.local.home>

On Wed, Feb 04, 2026 at 06:52:08PM -0500, Steven Rostedt wrote:
> On Sat, 31 Jan 2026 13:28:25 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > -static struct trace_remote_iterator *trace_remote_iter(struct trace_remote *remote, int cpu)
> > +static void __free_ring_buffer_iter(struct trace_remote_iterator *iter, int cpu)
> > +{
> > +	if (!iter->rb_iter)
> > +		return;
> 
> Hmm, can't iter->rb_iter be NULL when iter->rb_iters[] is used?

Arg yes, I missed that when I removed the union. And actually I don't think this
can be called with iter->rb_iter or iter->rb_iter NULL anymore.

> 
> > +
> > +	if (cpu != RING_BUFFER_ALL_CPUS) {
> > +		ring_buffer_read_finish(iter->rb_iter);
> > +		return;
> > +	}
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		if (iter->rb_iters[cpu])
> > +			ring_buffer_read_finish(iter->rb_iters[cpu]);
> > +	}
> > +
> > +	kfree(iter->rb_iters);
> > +}
> > +
> > +static int __alloc_ring_buffer_iter(struct trace_remote_iterator *iter, int cpu)
> > +{
> > +	if (cpu != RING_BUFFER_ALL_CPUS) {
> > +		iter->rb_iter = ring_buffer_read_start(iter->remote->trace_buffer, cpu, GFP_KERNEL);
> > +
> > +		return iter->rb_iter ? 0 : -ENOMEM;
> > +	}
> > +
> > +	iter->rb_iters = kcalloc(nr_cpu_ids, sizeof(*iter->rb_iters), GFP_KERNEL);
> > +	if (!iter->rb_iters)
> > +		return -ENOMEM;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		iter->rb_iters[cpu] = ring_buffer_read_start(iter->remote->trace_buffer, cpu,
> > +							     GFP_KERNEL);
> > +		if (!iter->rb_iters[cpu]) {
> > +			__free_ring_buffer_iter(iter, RING_BUFFER_ALL_CPUS);
> 
> For instance, we call __free_ring_buffer_iter() here, but I don't see
> iter->rb_iter being set.
> 
> -- Steve
> 
> 
> > +			return -ENOMEM;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +

[...]

> > +static void *trace_next(struct seq_file *m, void *v, loff_t *pos)
> > +{
> > +	struct trace_remote_iterator *iter = m->private;
> > +
> > +	++*pos;
> > +
> > +	if (!iter || !trace_remote_iter_read_event(iter))
> > +		return NULL;
> > +
> > +	trace_remote_iter_move(iter);
> > +	iter->pos++;
> > +
> > +	return iter;
> > +}
> > +
> > +static void *trace_start(struct seq_file *m, loff_t *pos)
> > +{
> > +	struct trace_remote_iterator *iter = m->private;
> > +	loff_t i;
> > +
> 
> FYI, this is where you take locks for iteration of files.
> 
> > +	if (!iter)
> > +		return NULL;
> > +
> > +	if (!*pos) {
> > +		iter->pos = -1;
> > +		return trace_next(m, NULL, &i);
> > +	}
> > +
> > +	i = iter->pos;
> > +	while (i < *pos) {
> > +		iter = trace_next(m, NULL, &i);
> > +		if (!iter)
> > +			return NULL;
> > +	}
> > +
> > +	return iter;
> > +}
> > +
> > +static int trace_show(struct seq_file *m, void *v)
> > +{
> > +	struct trace_remote_iterator *iter = v;
> > +
> > +	trace_seq_init(&iter->seq);
> > +
> > +	if (trace_remote_iter_print_event(iter)) {
> > +		seq_printf(m, "[EVENT %d PRINT TOO BIG]\n", iter->evt->id);
> > +		return 0;
> > +	}
> > +
> > +	return trace_print_seq(m, &iter->seq);
> > +}
> > +
> > +static void trace_stop(struct seq_file *s, void *v) { }
> 
> And stop is where you release the locks.
> 
> > +
> > +static const struct seq_operations trace_sops = {
> > +	.start		= trace_start,
> > +	.next		= trace_next,
> > +	.show		= trace_show,
> > +	.stop		= trace_stop,
> > +};
> > +
> > +static int trace_open(struct inode *inode, struct file *filp)
> > +{
> > +	struct trace_remote *remote = inode->i_private;
> > +	struct trace_remote_iterator *iter = NULL;
> > +	int cpu = tracing_get_cpu(inode);
> > +	int ret;
> > +
> > +	if (!(filp->f_mode & FMODE_READ))
> > +		return 0;
> > +
> > +	guard(mutex)(&remote->lock);
> > +
> > +	iter = trace_remote_iter(remote, cpu, TRI_NONCONSUMING);
> > +	if (IS_ERR(iter))
> > +		return PTR_ERR(iter);
> 
> So if iter is bad we exit out here.
> 
> > +
> > +	ret = seq_open(filp, &trace_sops);
> > +	if (ret) {
> > +		trace_remote_iter_free(iter);
> > +		return ret;
> > +	}
> > +
> > +	if (iter)
> 
> Why test if iter exists here?

We only test IS_ERR. iter will be NULL if the buffer isn't loaded and the
userspace output would be empty. But anyway if I move the locking into
start/stop this line will go away!

> 
> > +		trace_remote_iter_read_start(iter);
> 
> But still, the above grabs locks in the open, where it can return to user
> space while still holding the locks? That's a no-no.
> 
> You can use the seq file start and stop for locking.
> 
> -- Steve
>
[...]
