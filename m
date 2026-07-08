Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F37370AE0;
	Wed,  8 Jul 2026 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529952; cv=none; b=Bz6sWnppwHNTAdH3l3SeqHGdzNQdfNVK7okBdBKTyMr0nfXBqizGJPAx+CDc/WpO1Ffz3hKI5l+TkaY63mt3r1yXu9VFhfU9QZP65cgV5Z2hDsMJZKEGaQiZ9iXRUEOMqv8E2Bxa/YYd60TyCe5JzBmMhC+W+fhcid47C+ENnOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529952; c=relaxed/simple;
	bh=47cImVGYH5TDfx7lBh9zWDSoE1OzUzv7ktQEK1lT+rs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gWJGZaHGPWLmHm/c1L6MuUtdzoWlQdFHsUUS4posAgmY6jZ+9PJZqvDp1i8lLuKoQPrLF0wBt+NsShwgXPivYRjyvC4wXO9oz3d1GAuJiT/TK7/43TJGXB/nlOQeHuPfVk1GukRgBnB3w5Rqq+eNFU609uX3JZS68S4eX9LnGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 77F2F40242;
	Wed,  8 Jul 2026 16:59:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 9F22032;
	Wed,  8 Jul 2026 16:59:01 +0000 (UTC)
Date: Wed, 8 Jul 2026 12:59:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v1] tracing/remotes: Fix leak in
 trace_remote_alloc_buffer() error path
Message-ID: <20260708125906.746f1def@gandalf.local.home>
In-Reply-To: <20260708133201.295072-1-vdonnefort@google.com>
References: <20260708133201.295072-1-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 9F22032
X-Stat-Signature: j3pea9swafybz7iomj1dnmuemd5p6nd9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX183PKLxK0/c3+9s+c5XqxprE97pZrLUYJc=
X-HE-Tag: 1783529941-500581
X-HE-Meta: U2FsdGVkX19+f5j/68swzhoxSHUyk1WJr/oN+zq7MGJopHmNj1jS0A/68P5uF/Ciu92c/0ooKceWmsaBqKy/o7Z0MQfFpYbmS3GXmOVtuCw8IB8M4NvQ47fSmpQP4yD8X0EgmaXm9w0zw4p/XMeFLSk9uN+FRbgxMHNZVyREgsW/Uw+XgF9Bc+7n4CD6i91YmOCxInFYmytqcSYvJxR/e+Ry2vij4SMEnJnDP2CUdi0JOxNZucnUUDZC2K4OUvZjcB8kj5k1R0zzN9mXwQ30/+dgrpGmNTNljfKxbpqyuw69XNRrf3cKr4tNMCi5MndVgrOvb3HgPORxtVUkE1d3rAbHakp1sqBg7sky1gqBmvuwC9x7FJq6GPv24U+m4uxl/c1BQS+XoRbXEsN1R/7NHnAqJir8Foq3dBEuUFGL5e8=

On Wed,  8 Jul 2026 14:32:01 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> If page allocation fails in trace_remote_alloc_buffer(), desc->nr_cpus
> is not yet incremented for the current CPU. As a consequence, on error,
> half-allocated rb_desc will not be freed in trace_remote_free_buffer().
> 
> Include the failing CPU in desc->nr_cpus before going to the error path.
> 

Looks like Sashiko found other issues you may want to address:

  https://sashiko.dev/#/patchset/20260708133201.295072-1-vdonnefort%40google.com

-- Steve

> Fixes: 96e43537af54 ("tracing: Introduce trace remotes")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index 2a6cc000ec98..62d3d431c309 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c
> @@ -1008,8 +1008,10 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
>  
>  		for (id = 0; id < nr_pages; id++) {
>  			rb_desc->page_va[id] = (unsigned long)__get_free_page(GFP_KERNEL);
> -			if (!rb_desc->page_va[id])
> +			if (!rb_desc->page_va[id]) {
> +				desc->nr_cpus++; /* Free this partially-allocated rb_desc */
>  				goto err;
> +			}
>  
>  			rb_desc->nr_page_va++;
>  		}
> 
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda

