Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB3639A06F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 05:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017846; cv=none; b=pkC4ddIkV6myNpvjN7UWRfnTV1aELnBykSQ5/9xdzk1JG7bAZ0gA27+kPjw7anQn8+Wxj1j9zNI8Nfm0/nhxHzKyzmRIpw8Fwyy2cHdy9H+KZTjinPmg5UiCLQwaHtIP9ZLfgmEW6QtYf9yc4rJOvW4jyGYsNRrT2a2iq1jCaxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017846; c=relaxed/simple;
	bh=0uwXnaTUosMC/Icf2qUxADl52CRHI4T5CRZDpL/gEQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuDciiR7Fmq/Jdcf85isvLSuAk9HvQWYpIG2lBq1tuz5ydT8kwXoMysHl7P6qLyhxDK311MOCsvjMZf0v0G0Lbq0BxkhOJen9fiQRcaxT4AqSGr1f8uYUmh/xXX82IrDWyM2O+28yGDcI7t0C0G55MqFqwuGAmKzbgu9Aa9WihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.sg; spf=pass smtp.mailfrom=starlabs.sg; dkim=pass (2048-bit key) header.d=starlabs-sg.20251104.gappssmtp.com header.i=@starlabs-sg.20251104.gappssmtp.com header.b=UeRj05bE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-sg.20251104.gappssmtp.com header.i=@starlabs-sg.20251104.gappssmtp.com header.b="UeRj05bE"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d58efc7356so86983675ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Sep 2026 22:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-sg.20251104.gappssmtp.com; s=20251104; t=1789017844; x=1789622644; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pvypTGKdePbQiPk8V3bzpkE/0k4igHkbObf9bmT4wd8=;
        b=UeRj05bEsWjLuHH/YfUF+69PqnHBNBGmNGHrNqz2Yaz8R955NmZp6cefrCdjv/17x8
         CcpclfSx9zi0sL9MmELxINOCdREXjHa2rPLt+4eOnx0VRBxpOIPDjb4C0AT7D5BPmE+V
         +895ykA1BPxWRl0wTExnCWAL0njS7Z8Dc/lF7xwncQSc1stjb1fA2J1RoqwbuxNPTTb7
         XX5YW62gzfDOasc3RRgtodrG2w4IIJf1hW42y+x2VqxILx4HN4Oz2/tDd/XAubsrJfnU
         XqZT/Wd49hOybPyGmpPdUBI/1LexIRkjFV/FN1RfCT1uCwQvThnTTWu230uSFz1xlCYR
         9x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789017844; x=1789622644;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pvypTGKdePbQiPk8V3bzpkE/0k4igHkbObf9bmT4wd8=;
        b=b6qtkMUeSjaNusFC4zvvrQH08RfJHCL26Ro7+XwHd1R+WzQbF3KmGp2/CyfzWv4V9P
         //DmVQgaWe3ZesRPLsw1+pGe0JdhWzjJe+Oks1nTo/1nkAZ/rXUC4e0Jk0jsBQnNOOe5
         LIH5wjSDdcz4+/CVFAPq/FP56ij1L76GfqY4AYua8bAwEPZLye3XRcmxqBgTkswKUAFH
         nuvWW15IXdnp8OKtrU9Bagf0fwSYXuQUBghyaemhQv/uja0TC6fuwSDfBTOFJmNHYBEp
         zRnEL8SQhvnsp7KUuNE7m2yAROc/gBhxjCMzxyPJFQ9+3JzsL62u0EJopdrqZNxhwHAL
         LtUA==
X-Gm-Message-State: AFuF++n8plH3cws7+UrYSn3h8qCjZonfOXPUbld/qkmU0VpaULI+zm6B
	XANP/FtS2fYeb1HvKuxQiY738ptWS0Bho8idLdphNGgOG9htmRCsnbTgIrZeqTKigHKnYpQH7bM
	P8BmunBrYvw==
X-Gm-Gg: AYBFou1eWAmJOeI1ZYEsAoXqXUPXy/emjRaC5OBgJZLhqiO1mWxb1ZHz3Bz3GX+evJD
	2d34u0EqvWIs+hD63i8wAuEsOkF+I0RuGnScv44/3mIOyuzHMczqD6nfvaXH2nWU0uG4hUFRTfa
	ZrsPowuN0LjUqjSHzSzERsx6Q1FL3G814Lf2phdD0qPSm0gOVuCWWw7EIUnpfggvhmeQ15dkIU4
	/sbAQq1IgIVGk1jK04ToHOiywZxfmipWTHTYz2zXEpGTJFkR/bzZCvmAFL/nrXFSuRiVVXXdXf/
	DwaxwsOOKgQXUb+TF7arJ6DTeqFA/Cxn79MFTl4ueO+TJuVATotSpqvyRdVZUhc1+nDxUcF7Rk3
	WzzPbWGreDHVdwJVNE0KfFkPmAHnJspXsw0cz3/7W7gXLym4lsabeggLvPXUaeSf8XQ4FHAMn7N
	sPfQwAcSDJG3DBCkYz6oqdfrbthCzsFdm3YtPmiE5upyzaf3kMhPdRyL2oEHiYj1Al5MbgRLvVo
	CNNeFvB5AikqOm0pg7ac1mnaTgTlmJFoAWX0z9t/Qrm3w==
X-Received: by 2002:a17:903:2ca:b0:2d9:3850:2741 with SMTP id d9443c01a7336-2db12255f7bmr584733615ad.0.1789017844318;
        Wed, 09 Sep 2026 22:24:04 -0700 (PDT)
Received: from SLSGDTZTAUFIk002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1497fbf8sm83895135ad.43.2026.09.09.22.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 22:24:03 -0700 (PDT)
Date: Thu, 10 Sep 2026 13:24:00 +0800
From: Zafir Rasyidi Taufik <zafir.taufik@starlabs.sg>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: uprobes: Fix slab use-after-free in filter_chain
Message-ID: <aqI-8AVfTLxLpXxv@SLSGDTZTAUFIk002>
References: <20260910023106.1795811-3-zafir.taufik@starlabs.sg>
 <20260910024850.6E3351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910024850.6E3351F000FF@smtp.kernel.org>

On Thu, Sep 10, 2026 at 02:48:49AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Race condition in unregister_trace_uprobe leads to use-after-free (UAF) of trace_uprobe during lockless read accesses.
> --
> 
> commit 04fcafa318e6d04f74e677950139db1dd3bf079c
> Author: Zafir Rasyidi Taufik <zafir.taufik@starlabs.sg>
> 
> tracing: uprobes: Fix slab use-after-free in filter_chain
> 
> This commit addresses a use-after-free in uprobe_mmap. It resolves an issue
> where unregister_trace_uprobe() would fail to unlink the consumer when a
> trace_probe has a sibling event.
> 
> > diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> > index 861d857adadb3..110ec7b78b3dc 100644
> > --- a/kernel/trace/trace_uprobe.c
> > +++ b/kernel/trace/trace_uprobe.c
> > @@ -408,6 +408,11 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
> >  		return ret;
> >  
> >  unreg:
> > +	if (tu->uprobe) {
> > +		uprobe_unregister_nosync(tu->uprobe, &tu->consumer);
> > +		tu->uprobe = NULL;
> > +		uprobe_unregister_sync();
> > +	}
> >  	dyn_event_remove(&tu->devent);
> >  	trace_probe_unlink(&tu->tp);
> >  	free_trace_uprobe(tu);
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this code leave a window for a
> use-after-free of trace_uprobe during lockless read accesses?
> 
> When a sibling probe exists, this code unlinks and immediately frees the
> trace probe without synchronizing with trace readers via RCU or shared locks.
> 
> For example, when a user queries an attached perf event, it initiates a
> lockless traversal:
> 
> bpf_task_fd_query()
>   bpf_get_perf_event_info()
>     bpf_get_uprobe_info()
>       trace_uprobe_primary_from_call()
> 
> This accesses the trace probe structure without acquiring event_mutex or
> trace_event_sem.
> 
> Additionally, even if trace_event_sem is held for read, such as during
> print_uprobe_event(), unregister_trace_uprobe() bypasses taking
> trace_event_sem for write when unregistering a sibling probe (it skips
> unregister_uprobe_event() and jumps directly to unreg).
> 
> At the same time, if unregister_trace_uprobe() is called, it unlinks the
> probe via trace_probe_unlink(). The list removal relies on standard
> list_del_init() instead of list_del_rcu(), allowing concurrent lockless
> readers to traverse into soon-to-be-freed nodes when free_trace_uprobe(tu)
> is called immediately after.
> 
> Could this lead to memory corruption when readers access the freed probe?

I will investigate furthur regarding this. If it's correct I will think
of a patch and send it separately.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260910023106.1795811-3-zafir.taufik@starlabs.sg?part=1
