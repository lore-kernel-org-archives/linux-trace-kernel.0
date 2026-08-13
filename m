Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF347DFB0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630845; cv=none; b=MqXn4SpDVcYY3gL7lxuVMzhq9jibfuFXl3qt9J9wUMYrvL6gPoZu77egpq3Np6ordfXTjOa7sGQodHCYHSugdp97jK8sycov7d/v+szeKLXkgvMLe65r1j+U0A+JOzGrqeOvAFfPUKq5LJTHKKIF1EBhiXPLvwQdlojhH+4lWx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630845; c=relaxed/simple;
	bh=BKkZHAxbqg0Xvz3ay8iJpo5Ks0LapLfKRR8tWj7WlVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAyWM/UvJrdRwUOdDsE2s5xbX7L9IKaAS2bfa9tIyzYnfeaLbrxsIDeH2IhxalXsdT1vTPoqZxkY2Jmu3VOzqSdLgwo1Yu/LoIZd09U4JFNBjp1I5ODqh6XrraTcFEuIhw5kjk/lwlabaY7z8rmLTS4OcLWt3AytngDcUCENCfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q4GdcQF7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4GdcQF7"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49558ce01afso17338625e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786630838; x=1787235638; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kpl5xwcJLZQQoBi2QcazQFcRB+AFZZkbtY/pIHVQKyk=;
        b=q4GdcQF7Yt2BraNewrpLnMXar+KxqXe6sHR9VJH8wA4Nvx7Cpl+lHaEpGXzVqj1rrK
         rY+EJswbfy+14zXpG2wLUYTEGr8CPUOUR62ZK+7S0m3iHJ/8/AumXxiAk4HwDsD8ORLy
         dmBaV1z9vWJ8ooAsYYtWG7H1p/WmUTlVn5VH2Z0bIyli12M5t1l3VCXHqzeXHWpLWZ7Z
         yAwOHT2xjgEu65RaQ487oV+8aI5oYJyTmuSd/3Iz62ZIThE1guO4roqtVlhqcY9gG3XV
         n3dBtHZvUYIXcCnNSTJ1VflQzf8zBWMO/lZtV8t0GdDgHuxidY3NPI/18zyrkM2MIUgO
         tTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786630838; x=1787235638;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Kpl5xwcJLZQQoBi2QcazQFcRB+AFZZkbtY/pIHVQKyk=;
        b=ic1vUVfD1PhRg9reTOhZd8U9k3koiq4YVeLFGvty2dpypyov07ihYp8g9dFbOWzLFt
         a1DTJHqMKgUKN/qK+HNVwxx4IoaOzSQmJi7SNMuhm5A66U66XAoJF4Ru+kJTKU6QPuNZ
         rwL2c1yMmMJMMqL8RwLx41ylke2k8Oy2vVoXGwYFxkS2L73J3JKqoVHDDT2V3cw0VN24
         pJHt70LyBCoIu6K5sJ+44Zt0HGQ4HuVXLyEphUfhxPjmSHkSk+T7utuRbC0GIo3jw8AH
         9h4wFs2WRITsnglbAi/27ztSt8hOYEqpUAaTFms17/h5c9goNwzMI+QEgqSOuXS0giOr
         plow==
X-Gm-Message-State: AOJu0Yy9rq3qk1Pn3AfuVUsBJpjWsFAskIYlRtLLivx6K+pCWOhDcp2T
	3Ap1lGCtv2zl7eWNVSunAyZ5vtAULLki9r2YHRZ+3YstRwz9Q8QdftYdOf2kHRftRYfyhUfyTS4
	bM+bbEw==
X-Gm-Gg: AR+sD129p4zpiMC0iY4DeGvXeukt/3d0/2xY1uvo54ajnDzWhqcpo//Yjpp5Oc6/0nR
	8xSRWRiZMfexte6/QPB378ES0zJNSuQEVKae+nieoz1NojvhYmxn8HmYL7+bs+uYbjmgSIdQ960
	vGO30wCRCzOIoONWCkO0NIR5STFYLUuvRRikssppJMORvzhHL3gsxuTHuAp3G3VwU9ZFyaBKfCo
	EfcfrbP+F7+IMMGx2DRsPfnx0TAw/sTpQK+7hNYo5STK1uQNQFEHxg1sTLU1UH4hqtxoj1c4822
	GUV+6pHs1Cui7kEOgF5Da2Uo2j4n6jydCSUluv/fsveACnYH2fPShBHWV2Os93OgN0vrzAdAJ+h
	wu46A5A2AVnKPiuFCOoOmN3nyMuG15qB0xtKNoGM0aM21TX9s36KqFykxmTwVLPs9YXza0CK47M
	BpgwFYE5edbcn3HGQx+zYHVao+qL9dbSp3WQsfTJ5i5rmCIwo4BjJSAp8tKQpWt0O48ZGvoflVh
	YjGj0Vb1PIX7VYr0ChDiZ3Nr9dU/Td0
X-Received: by 2002:a05:600c:524c:b0:499:79ba:a754 with SMTP id 5b1f17b1804b1-499821add45mr79820975e9.11.1786630837322;
        Thu, 13 Aug 2026 07:20:37 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499821652dbsm67797955e9.9.2026.08.13.07.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:20:36 -0700 (PDT)
Date: Thu, 13 Aug 2026 15:20:33 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 15/18] tracing/remotes: Add poll_ms tracefs file
Message-ID: <an3SsR5ANiiipIOl@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-16-vdonnefort@google.com>
 <20260812171304.A47D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812171304.A47D41F000E9@smtp.kernel.org>

On Wed, Aug 12, 2026 at 05:13:04PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Low] Data race on `remote->poll_ms` due to lockless reads.
> - [Low] Improper mixing of goto-based error handling and scope-based cleanup (__free) in `trace_remote_iter`.
> --
> 
> --- Patch [15]: [PATCH v5 15/18] tracing/remotes: Add poll_ms tracefs file ---
> commit a661ee191c6d806ed0a716f67237aca890febe25
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> tracing/remotes: Add poll_ms tracefs file
> 
> Add a tracefs file to configure the trace remote polling period. Keep
> the default value to 100ms.
> 
> > diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> > index 5536e0df43795..b1c75666ab638 100644
> > --- a/kernel/trace/trace_remote.c
> > +++ b/kernel/trace/trace_remote.c
> > @@ -1135,6 +1135,40 @@ static int dump_on_panic_show(struct seq_file *s, void *unused)
> >  }
> >  DEFINE_TRACE_REMOTE_ATTRIBUTE(dump_on_panic);
> >  
> > +static ssize_t poll_ms_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
> > +{
> > +	struct seq_file *seq = filp->private_data;
> > +	struct trace_remote *remote = seq->private;
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	ret = kstrtouint_from_user(ubuf, cnt, 10, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!val)
> > +		return -EINVAL;
> > +
> > +	guard(mutex)(&remote->lock);
> > +
> > +	if (val < remote->poll_ms && remote->poll_cnt)
> > +		mod_delayed_work(system_percpu_wq, &remote->poll_work, msecs_to_jiffies(val));
> > +
> > +	remote->poll_ms = val;
> > +
> > +	return cnt;
> > +}
> > +
> > +static int poll_ms_show(struct seq_file *s, void *unused)
> > +{
> > +	struct trace_remote *remote = s->private;
> > +
> > +	seq_printf(s, "%u\n", remote->poll_ms);
> 
> [Severity: Low]
> Does this code introduce a data race on remote->poll_ms?
> 
> In poll_ms_write(), remote->poll_ms is modified while holding remote->lock.
> However, in poll_ms_show(), remote->poll_ms is read without holding
> remote->lock.
> 
> It appears this could also cause a data race with lockless reads in
> trace_remote_do_poll():
> 
> kernel/trace/trace_remote.c:trace_remote_do_poll() {
>     ...
> 	schedule_delayed_work(&remote->poll_work, yield ? 0 : msecs_to_jiffies(remote->poll_ms));
> }
> 
> Could this concurrent read and write cause a data race, potentially leading
> to torn reads or violating kernel concurrency expectations?

Fair enough... I'll WRITE_ONCE/READ_ONCE.

-- 
Vincent

> 
> [ ... ]
> 
> Also, looking at trace_remote_iter() in kernel/trace/trace_remote.c:
> 
> kernel/trace/trace_remote.c:trace_remote_iter() {
> 	struct trace_remote_iterator *iter __free(kfree) = kzalloc_obj(*iter);
>     ...
> 		if (WARN_ON_ONCE(remote->dmesg)) {
> 			ret = -EBUSY;
> 			goto err;
> 		}
>     ...
> err:
> 	switch (type) {
> 	case TRI_PANIC:
> 		break;
> 	default:
> 		trace_remote_put(remote);
> 	}
> 	return ERR_PTR(ret);
> }
> 
> [Severity: Low]
> Does this code incorrectly mix goto-based error handling and scope-based
> cleanup (__free)?
> 
> The cleanup subsystem guidelines prohibit mixing goto-based error paths
> with __free() variable declarations in the same function. While it does not
> appear to cause a concrete resource leak or double-free in this specific
> instance, could this create confusing ownership semantics and risk future
> bugs during refactoring?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260812161340.2417322-1-vdonnefort@google.com?part=15
