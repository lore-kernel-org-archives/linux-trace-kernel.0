Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1AB258ECC
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419716; cv=none; b=eFrclPa0xg75kWCLPhr/xWgpfyrq8naLZ+R4yUXcJAWnqQ9w3+ifkE30D2Ww42B0lp4Uk6PMVJNMRM0adN3CxA8o9Sl9wbuhbhnWATIakhqKtTmmZ+mba1NscZIDuuCs0widZrM/TI4d63v3hWp5qrF/o3aQ/ECsuIrgunZF32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419716; c=relaxed/simple;
	bh=e2bY/7qkyaiM/i1NmIYcr9PECxFTLhoEx9C77uMaccw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwwQR1ufIV90hKNM8kCI/MCx5Y3t6G8BQELrsDcdEJw5cWDar9asgsZWeSThJ2rbxi4xst/iNpj6QvUlxwUci2paQz6VBk+wgajndGqvCvCn7p58zfQumuxI9CdJ93SccB63hB34YFF6ZkHrjbkGDi+69feuSlBC3QSq9XpqpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YA6yO1rp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YA6yO1rp"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e3aafe06a7so2671260f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Sep 2025 05:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757419713; x=1758024513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7vDbC+h+/IIbH/cXwkOmZAco4ey3LkcdIeQn9K9PmM=;
        b=YA6yO1rpCt9mH5rn7Aik1rwu72oWsprZ6nTKcO3enh8WJfwYxniaXF9tjmxQmvnNUj
         UMUdmmk32rdYu8DkSp+AJDYvpZqKgzfTyqdmZHriavkUZ/uj4n26KU10gOmhYiYkAyqW
         /5rBgBA5lLY+9QiiTpJSWgfNaK3ajpTtxXRovDrVrBYEFc1sU6rjz4YQ2nK/FNnfJs48
         83e7SyuAJrYnt8nfmPlgJCM9NcUbKNFdncNe7S+REpPx+MXgoUYz2Z+HonR9itn2BDHw
         SEebZEX4xjTnmAdB4z6pYuRvUNFjHNmtZ/gi/OaD8w1Vb975+OZpCXyOSpjOC3WIa8Tx
         SPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757419713; x=1758024513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7vDbC+h+/IIbH/cXwkOmZAco4ey3LkcdIeQn9K9PmM=;
        b=OipdBcDEaXIFzBvNCXpQApKtRnLrBbhmjd31R4MAX51I+aOR9NxW0LVOq3Y8n40Km/
         oQo8t8/EigPettwmhwYBclnzl4FEINHIYa+ZufClVZUWZhJR0WZC68MTCOQPHnc66mq1
         BdrvvdaZ9epp4aOGqofCy8cINmkNBgCnlCo/p1aRBhJkWko4wMbyXlTdzjmOFbAVRZ/i
         ce1gT5jC8jbO/mIzd7X89Am81qakGRKWt3dAXevmY8Zzj+J0f60oy/x3lfuJvXYfUJix
         xqOieW14Oeqr3vrM7knJn55aZsz9j3+WUslsoAyVECXvbH7XcE9Af59FlzjsaWNqa3kG
         Zbvw==
X-Forwarded-Encrypted: i=1; AJvYcCUXLgwu7rPuCRHijrNqf6Ggb68LRC1hYVSU2xtV6x5ZnMwn+FpqbHrdeAnNul+0pAIHP4FApDM6cjVuejI1NNtwbpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Tkb9+3nXE05N/1M1z2lOcZKKSQO+9wlOfS/ZRoIT8v7q+b4V
	ooUvBTBbOwUTPuDfXHDgM/DamF1TasH6NMFs17jS+gQVnIt9AqWdR75S0m7cHQq2Xw==
X-Gm-Gg: ASbGncvpUFj8hxJ10fFzBWkTZ/jttkj7swmewbmDQlalkUZXzZvBMpNkCNgNpLEunxw
	iqoe3K4fIRFR6oJIGL8j4f3WlptSX9lYztSdDLf4s8zucxQL7ic8bYCZX3NhcI3GWqVpH2wUD/r
	wxo3XD4wophLCiQOI9fU6wyJGmkcJEghqX/Tn7dgJ6/8YHaq8zmEoDHFguB+kIIy3mmMCXG4fTD
	vPNX807RaxfKnkpFLqU2J6vnNB7/6nxnVAqQsvgPRN35QDmdnGShaq6YyDpdASbn+2h26Q7ygAo
	zS+IlGk0erAB8v8hvwSe1Qmphdb/aP72vY9S5+Ahz+fTQp42L5rXaN9D9O9/DFh/wW+EIjUm7C1
	8U183DvxquOsVZG6pkif/9TlL70mBTJJti6eqR1KfxMA5bHFJrHL7H+t7PHqml5WLV71j47MCKA
	HnopFH
X-Google-Smtp-Source: AGHT+IEmpSA1PmUMsgcmd2ZNoedzp7F9aWzukj/yEFhZuO5KFbaj8r4hHCaj2MqwR9Y8LELRFzynbQ==
X-Received: by 2002:a05:6000:2486:b0:3e7:490c:1a2 with SMTP id ffacd0b85a97d-3e7490c049dmr6915730f8f.10.1757419712364;
        Tue, 09 Sep 2025 05:08:32 -0700 (PDT)
Received: from google.com (211.29.195.35.bc.googleusercontent.com. [35.195.29.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9cb9sm2559883f8f.20.2025.09.09.05.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 05:08:31 -0700 (PDT)
Date: Tue, 9 Sep 2025 13:08:28 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/24] tracing: Introduce trace remotes
Message-ID: <aMAYvA9LSvfxvt_C@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
 <20250821081412.1008261-4-vdonnefort@google.com>
 <20250908193606.47143d09@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908193606.47143d09@gandalf.local.home>

On Mon, Sep 08, 2025 at 07:36:05PM -0400, Steven Rostedt wrote:
> On Thu, 21 Aug 2025 09:13:51 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > A trace remote relies on ring-buffer remotes to read and control
> > compatible tracing buffers, written by entity such as firmware or
> > hypervisor.
> > 
> > Add a Tracefs directory remotes/ that contains all instances of trace
> > remotes. Each instance follows the same hierarchy as any other to ease
> > the support by existing user-space tools.
> > 
> > This currently does not provide any event support, which will come
> > later.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/include/linux/trace_remote.h b/include/linux/trace_remote.h
> > new file mode 100644
> > index 000000000000..de043a6f2fe0
> > --- /dev/null
> > +++ b/include/linux/trace_remote.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef _LINUX_TRACE_REMOTE_H
> > +#define _LINUX_TRACE_REMOTE_H
> > +
> > +#include <linux/ring_buffer.h>
> > +
> > +struct trace_remote_callbacks {
> > +	struct trace_buffer_desc *
> > +		(*load_trace_buffer)(unsigned long size, void *priv);
> 
> I believe this is one of those cases where the 80 char limit is more of a
> guildline than a rule. It looks better to keep the above as one line.
> 
> > +	void	(*unload_trace_buffer)(struct trace_buffer_desc *desc, void *priv);
> 
> Heck, this is already passed 80 characters ;-)
> 
> > +	int	(*enable_tracing)(bool enable, void *priv);
> > +	int	(*swap_reader_page)(unsigned int cpu, void *priv);
> > +};
> > +
> > +int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv);
> > +int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t size,
> > +			      const struct cpumask *cpumask);
> > +void trace_remote_free_buffer(struct trace_buffer_desc *desc);
> > +
> > +#endif
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index d2c79da81e4f..99af56d39eaf 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -1238,4 +1238,7 @@ config HIST_TRIGGERS_DEBUG
> >  
> 
> 
> > +
> > +int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv)
> > +{
> > +	struct trace_remote *remote;
> > +
> > +	remote = kzalloc(sizeof(*remote), GFP_KERNEL);
> > +	if (!remote)
> > +		return -ENOMEM;
> > +
> > +	remote->cbs = cbs;
> > +	remote->priv = priv;
> > +	remote->trace_buffer_size = 7 << 10;
> > +	remote->poll_ms = 100;
> 
> What's with the magic numbers?

The 7KiB value can be modified with the tracefs file buffer_size_kb.

the 100ms can't be modified. I could either make a tracefs file or just a
trace_remote_set_poll_ms() function so it can be modified after registration.

In all cases, I'll add a TRACE_REMOTE_DEFAULT_XXXX definition at the start of
the file.

> 
> > +	mutex_init(&remote->lock);
> > +
> > +	if (trace_remote_init_tracefs(name, remote)) {
> > +		kfree(remote);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +void trace_remote_free_buffer(struct trace_buffer_desc *desc)
> > +{
> > +	struct ring_buffer_desc *rb_desc;
> > +	int cpu;
> > +
> > +	for_each_ring_buffer_desc(rb_desc, cpu, desc) {
> > +		unsigned int id;
> > +
> > +		free_page(rb_desc->meta_va);
> > +
> > +		for (id = 0; id < rb_desc->nr_page_va; id++)
> > +			free_page(rb_desc->page_va[id]);
> > +	}
> > +}
> > +
> > +int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t size,
> > +			      const struct cpumask *cpumask)
> > +{
> > +	int nr_pages = (PAGE_ALIGN(size) / PAGE_SIZE) + 1;
> > +	struct ring_buffer_desc *rb_desc;
> > +	int cpu;
> > +
> > +	desc->nr_cpus = 0;
> > +	desc->struct_len = offsetof(struct trace_buffer_desc, __data);
> 
> The above is better as:
> 
> 	desc->struct_len = struct_size(desc, __data, 0);
> 
> As it also does some other checks, like make sure __data is a flexible
> array.
> 
> > +
> > +	rb_desc = (struct ring_buffer_desc *)&desc->__data[0];
> > +
> > +	for_each_cpu(cpu, cpumask) {
> > +		unsigned int id;
> > +
> > +		rb_desc->cpu = cpu;
> > +		rb_desc->nr_page_va = 0;
> > +		rb_desc->meta_va = (unsigned long)__get_free_page(GFP_KERNEL);
> > +		if (!rb_desc->meta_va)
> > +			goto err;
> > +
> > +		for (id = 0; id < nr_pages; id++) {
> > +			rb_desc->page_va[id] = (unsigned long)__get_free_page(GFP_KERNEL);
> > +			if (!rb_desc->page_va[id])
> 
> What exactly are these pages allocated for? Is this what the remote will
> use to write to? There should be more comments about how this is used.

Those are the actual ring-buffer data pages. I'll add a comment here.
> 
> > +				goto err;
> > +
> > +			rb_desc->nr_page_va++;
> > +		}
> > +		desc->nr_cpus++;
> > +		desc->struct_len += offsetof(struct ring_buffer_desc, page_va);
> > +		desc->struct_len += sizeof(rb_desc->page_va[0]) * rb_desc->nr_page_va;
> 
> Shouldn't the above be:
> 
> 		desc->struct_len += struct_size(rb_desc, page_va, rb_desc->nr_page_va);
> 
> ?

Yes, that'd look way better.

> 
> > +		rb_desc = __next_ring_buffer_desc(rb_desc);
> 
> Is there no check to make sure that the cpu mask matches what the rb_desc
> will have?

The function is filling rb_desc[], based on the cpumask input, so both will
match when returning from this function.
It is then easy to handle the case where some CPUs are not part of the cpumask.
See remote_test_load() where for_each_ring_buffer_desc() iterates over all the
CPUs from the trace_desc but uses rb_desc->cpu.

Is it what you meant?

> 
> -- Steve
> 
> > +	}
> > +
> > +	return 0;
> > +
> > +err:
> > +	trace_remote_free_buffer(desc);
> > +	return -ENOMEM;
> > +}
> 
