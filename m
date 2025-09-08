Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D709D2DA742;
	Mon,  8 Sep 2025 23:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757374535; cv=none; b=Kyyb0MV5MtJbEJv77ioh9pDL3GpwftQRYUF0OEnCznXEV5j6bbRBTi460zcA5D+Sj0m7pF4rhC++Vz9ubLqJHToCO5Iw2V6MAyvMSCGjAUmYISBCtw+1BTg7edyQ3smOQwe2W66Ql6X7JK8WQxH+GfPv5VP39FRxf06SUPA2J4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757374535; c=relaxed/simple;
	bh=7LImajbIqQHzx1Gc8T582/FKnSAIRA+oyBk4uxUy/ng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuQOR/TE9ygWPftbVP5nbTYZQ7VobneG96luEWKyHRk9EI8KXMukL3fIwbVIEzKbZ1W0+7CxvlSrsMivCGl4unZ85ubapGJDdrf58b4usujZ+YUofOA/ZR7mcyQiY8e9c1e4RItZ787L7WptUCji98G+hQvLd6d5owkty66XM6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 76607587E5;
	Mon,  8 Sep 2025 23:35:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id D82D620025;
	Mon,  8 Sep 2025 23:35:19 +0000 (UTC)
Date: Mon, 8 Sep 2025 19:36:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 jstultz@google.com, qperret@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/24] tracing: Introduce trace remotes
Message-ID: <20250908193606.47143d09@gandalf.local.home>
In-Reply-To: <20250821081412.1008261-4-vdonnefort@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
	<20250821081412.1008261-4-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xtst64tqoj6xjbmrgzuhtq7zud5fp9as
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: D82D620025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/3BmdESBq9p494ClBbvWR0lF9SP2rHtf8=
X-HE-Tag: 1757374519-315858
X-HE-Meta: U2FsdGVkX18HK0U95OOl89BG5VQk6Kg6LVWbCl2CSVbrRvvl0YewdCSxa2DMdr13EvJ36GqGgAb6i5dTOnngrPPskeRf/ygEGARJOHoyjR92z/s4KlkYwQ0+DovGgFCn+m4yIDXhWN7EwuSDh1iED41HI2KBatpqMccYhffxFanar2pH/0PBqgVWIwTFUT6HfY4gcYbpBZ5RdTK136SiOfTDWQLwfH1GYKNhlMl8HnNGJfyGPEV6umjeSskEpfNTFrYJ5ulfZOh8mL9TtACyIp1EX+FzZQrlRFT7+xXhWIfjcoINLWtJ8UNg3Ys91GTJTQI7e02RE/MYgB7xq/lIVjKRi64GpTn/

On Thu, 21 Aug 2025 09:13:51 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> A trace remote relies on ring-buffer remotes to read and control
> compatible tracing buffers, written by entity such as firmware or
> hypervisor.
> 
> Add a Tracefs directory remotes/ that contains all instances of trace
> remotes. Each instance follows the same hierarchy as any other to ease
> the support by existing user-space tools.
> 
> This currently does not provide any event support, which will come
> later.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/include/linux/trace_remote.h b/include/linux/trace_remote.h
> new file mode 100644
> index 000000000000..de043a6f2fe0
> --- /dev/null
> +++ b/include/linux/trace_remote.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_TRACE_REMOTE_H
> +#define _LINUX_TRACE_REMOTE_H
> +
> +#include <linux/ring_buffer.h>
> +
> +struct trace_remote_callbacks {
> +	struct trace_buffer_desc *
> +		(*load_trace_buffer)(unsigned long size, void *priv);

I believe this is one of those cases where the 80 char limit is more of a
guildline than a rule. It looks better to keep the above as one line.

> +	void	(*unload_trace_buffer)(struct trace_buffer_desc *desc, void *priv);

Heck, this is already passed 80 characters ;-)

> +	int	(*enable_tracing)(bool enable, void *priv);
> +	int	(*swap_reader_page)(unsigned int cpu, void *priv);
> +};
> +
> +int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv);
> +int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t size,
> +			      const struct cpumask *cpumask);
> +void trace_remote_free_buffer(struct trace_buffer_desc *desc);
> +
> +#endif
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index d2c79da81e4f..99af56d39eaf 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -1238,4 +1238,7 @@ config HIST_TRIGGERS_DEBUG
>  


> +
> +int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv)
> +{
> +	struct trace_remote *remote;
> +
> +	remote = kzalloc(sizeof(*remote), GFP_KERNEL);
> +	if (!remote)
> +		return -ENOMEM;
> +
> +	remote->cbs = cbs;
> +	remote->priv = priv;
> +	remote->trace_buffer_size = 7 << 10;
> +	remote->poll_ms = 100;

What's with the magic numbers?

> +	mutex_init(&remote->lock);
> +
> +	if (trace_remote_init_tracefs(name, remote)) {
> +		kfree(remote);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +void trace_remote_free_buffer(struct trace_buffer_desc *desc)
> +{
> +	struct ring_buffer_desc *rb_desc;
> +	int cpu;
> +
> +	for_each_ring_buffer_desc(rb_desc, cpu, desc) {
> +		unsigned int id;
> +
> +		free_page(rb_desc->meta_va);
> +
> +		for (id = 0; id < rb_desc->nr_page_va; id++)
> +			free_page(rb_desc->page_va[id]);
> +	}
> +}
> +
> +int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t size,
> +			      const struct cpumask *cpumask)
> +{
> +	int nr_pages = (PAGE_ALIGN(size) / PAGE_SIZE) + 1;
> +	struct ring_buffer_desc *rb_desc;
> +	int cpu;
> +
> +	desc->nr_cpus = 0;
> +	desc->struct_len = offsetof(struct trace_buffer_desc, __data);

The above is better as:

	desc->struct_len = struct_size(desc, __data, 0);

As it also does some other checks, like make sure __data is a flexible
array.

> +
> +	rb_desc = (struct ring_buffer_desc *)&desc->__data[0];
> +
> +	for_each_cpu(cpu, cpumask) {
> +		unsigned int id;
> +
> +		rb_desc->cpu = cpu;
> +		rb_desc->nr_page_va = 0;
> +		rb_desc->meta_va = (unsigned long)__get_free_page(GFP_KERNEL);
> +		if (!rb_desc->meta_va)
> +			goto err;
> +
> +		for (id = 0; id < nr_pages; id++) {
> +			rb_desc->page_va[id] = (unsigned long)__get_free_page(GFP_KERNEL);
> +			if (!rb_desc->page_va[id])

What exactly are these pages allocated for? Is this what the remote will
use to write to? There should be more comments about how this is used.

> +				goto err;
> +
> +			rb_desc->nr_page_va++;
> +		}
> +		desc->nr_cpus++;
> +		desc->struct_len += offsetof(struct ring_buffer_desc, page_va);
> +		desc->struct_len += sizeof(rb_desc->page_va[0]) * rb_desc->nr_page_va;

Shouldn't the above be:

		desc->struct_len += struct_size(rb_desc, page_va, rb_desc->nr_page_va);

?

> +		rb_desc = __next_ring_buffer_desc(rb_desc);

Is there no check to make sure that the cpu mask matches what the rb_desc
will have?

-- Steve

> +	}
> +
> +	return 0;
> +
> +err:
> +	trace_remote_free_buffer(desc);
> +	return -ENOMEM;
> +}

