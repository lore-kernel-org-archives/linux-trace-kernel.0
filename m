Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8779813C807;
	Fri, 25 Oct 2024 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729822800; cv=none; b=KjVYV06p9KWkYYRto9+lrz9bX4yOLT/nTAsSdX8GQghBHUWr2GiXki3O/XLDbCqRLx9g0XU8lafuzXVLxXjAKmZ+7wKzCDYse9S/gxMqV61AggzXR2LeYdCFYa3Zx9P7o7UcCq4UfQmTlAj5oJn+fld+6zOFO/suiZV+cpFPpq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729822800; c=relaxed/simple;
	bh=WbE/oAARqexUJVhWC65sM69ZtqaASCIS8W0in1r88bs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lto+94efETvuQBI2IFK6GkYfFQZhI3G4CNJH6PZjK17TzZq8PSApGFME9NSJLEe7Zwfkr4sChbKdO6efnPZmL3uGw+UkjFeCKjXiEYZAC531O4ZxfJOnF8oaA3aqS616prTMwukMaQAxfSKQnDTLrEqLRQtw8+YV8OhyYTQCqiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23F3C4CEC7;
	Fri, 25 Oct 2024 02:19:58 +0000 (UTC)
Date: Thu, 24 Oct 2024 22:19:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, linux-trace-kernel@vger.kernel.org, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dma-mapping: Use trace_dma_alloc for dma_alloc*
 instead of using trace_dma_map
Message-ID: <20241024221955.2fd9356e@rorschach.local.home>
In-Reply-To: <20241018150036.2878190-4-sean.anderson@linux.dev>
References: <20241018150036.2878190-1-sean.anderson@linux.dev>
	<20241018150036.2878190-4-sean.anderson@linux.dev>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Oct 2024 11:00:36 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> +	TP_printk("%s dir=3D%s dma_addr=3D%llx size=3D%zu phys_addrs=3D%s flags=
=3D%s attrs=3D%s",
> +		__get_str(device),
> +		decode_dma_data_direction(__entry->dir),
> +		__entry->dma_addr,
> +		__entry->size,
> +		__print_array(__get_dynamic_array(phys_addrs),
> +			      __get_dynamic_array_len(phys_addrs) /
> +				sizeof(u64), sizeof(u64)),
> +		show_gfp_flags(__entry->flags),
> +		decode_dma_attrs(__entry->attrs))

=46rom a tracing perspective, everything in the patch set looks good.
Just a heads up that the above __print_array() should be changed after
6.13 is out to use __print_dynamic_array().

  https://lore.kernel.org/linux-trace-kernel/20241022194158.110073-3-avadhu=
t.naik@amd.com/

For the series:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
