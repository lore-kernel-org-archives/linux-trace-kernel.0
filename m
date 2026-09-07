Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA4A38F638;
	Mon,  7 Sep 2026 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792113; cv=none; b=QVi+D9jON9P+lZp2bO+Fw0u/3sC+HleuenAjWDVvlfZgc5MLPnGR3Q9Bn5wyPF/yMz4ssiPEpzkA4TOmpftJBh/6emgwhL7cadZorree1TeL8pDNF5TxwYO87ZjBnRDYGOrCae1TpnZBl1fUFAM+4dfMTSeNhybDjRPNwZ9HY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792113; c=relaxed/simple;
	bh=5IyDnu4y6puq3ryqOWh8dyW1Po/qKtPCAtB0xw6VQW8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oWk+rhwCtMolT2Dbk2eJcSw/EBef3A4Aigxxp55ddZGC1sjm87vdaxFCEnldqLwjbyCDoxY4bdpQX1zCu+wn/JXVJ4TtLbmrMxwZ+KpuBzDVCZWxvaadb9teuTXGVSEN9qahhevZzkwqACnvvxuj27ezni9V2aL2aXwixJiwTlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEH192QR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEH192QR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F911F00A3A;
	Mon,  7 Sep 2026 14:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788792110;
	bh=WtgESNz2LvJtM+W7EtZmYUPe7qe1mpTJaQo8pOa+czk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZEH192QR5zlW+3Yb3EUja9wud/iVyHp5vAfnCrTe/5J2uvwr6C5Ev15+ASxq432eO
	 d+PnTnb6yI5u07khlpR5Ivjbq9XgAz+qHbyzHfrJbCafqlnoRRKWOJkSy+QPKahztF
	 b05BJBr1vI4+C5A611KOezxys9OQvgzYIU52PkhuJJShOLuL0SduJeFJ8KJuUXNfrI
	 VQ/YTLXwO6JhmH+85moUdlJJAcHrR6JqLMGj5gNrwZUnthOtltjaY2U7fvPQWusVLm
	 eP6ZtOFXsVegx0Env1hD3HBYGigpn9Mh32uDx47O6H8C/QwS02m4oboQbLsBBOp570
	 M27FJ7qlTbXgw==
Date: Mon, 7 Sep 2026 23:41:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ring-buffer: Rename ring_buffer_size() to
 ring_buffer_capacity()
Message-Id: <20260907234146.9739977b015a6c8c39ce3693@kernel.org>
In-Reply-To: <20260907094238.3624013-1-vdonnefort@google.com>
References: <20260907094238.3624013-1-vdonnefort@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 10:42:38 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> Since commit 8a5f63637890 ("ring-buffer: Fix subbuf resize race with ring
> buffer readers"), "capacity" refers to the memory available for events
> (excluding subbuffer headers) while "size" refers to the raw allocation.
> ring_buffer_size() actually calculates this event capacity. Rename it to
> ring_buffer_capacity() to align with this convention.

I think this is OK, but I have a question.

[...]
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8658cad53cb5..f0251788ec75 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4712,9 +4712,9 @@ void trace_set_buffer_entries(struct array_buffer *buf, unsigned long val)
>  static void update_buffer_entries(struct array_buffer *buf, int cpu)
>  {
>  	if (cpu == RING_BUFFER_ALL_CPUS) {
> -		trace_set_buffer_entries(buf, ring_buffer_size(buf->buffer, 0));
> +		trace_set_buffer_entries(buf, ring_buffer_capacity(buf->buffer, 0));
>  	} else {
> -		per_cpu_ptr(buf->data, cpu)->entries = ring_buffer_size(buf->buffer, cpu);
> +		per_cpu_ptr(buf->data, cpu)->entries = ring_buffer_capacity(buf->buffer, cpu);

nit: Don't we need to re-word this "entries" with "capacity" too? 

Actually, this "entries" is a bit odd because

- ring_buffer_entries() returns the number of events.
- trace_set_buffer_entries() sets the buffer capacity in bytes.

It seems we call it as "entries" historical reason, but now it becomes the
source of confusion. Maybe we should change it too. (but in the separate patch)

Thanks,

>  	}
>  }
>  
> @@ -8476,7 +8476,7 @@ int allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int
>  
>  	/* Allocate the first page for all buffers */
>  	trace_set_buffer_entries(&tr->array_buffer,
> -				 ring_buffer_size(tr->array_buffer.buffer, 0));
> +				 ring_buffer_capacity(tr->array_buffer.buffer, 0));
>  
>  	return 0;
>  }
> 
> base-commit: df2908090cda368b01ff43709f51890076c56157
> -- 
> 2.55.0.979.g7e5102b832-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
