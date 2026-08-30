Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A791F3BA2;
	Sun, 30 Aug 2026 01:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788052936; cv=none; b=cWsyzU8UqVWqZNFycvEjGW6cc70kOmdZLLYqO22lwflft5y4ovpcnycnl/OgkfQ1cIRijTfE6Zn5hdBMzCxMKTO9QqA62MbEHGZbJyy65Wy3uToiPQO0K008YKQJvRwQRFVN2xR/Ku7g+/NIrd2oGO7zpG/kj1hXaKTJNt5gbao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788052936; c=relaxed/simple;
	bh=3IHIEfnt4vtTfFYqiZiEgy+nV7fnnKTw5A1pNm63pVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3FdlqkgTx/4Lb5EmbEsnMn3HVUJIodqQzdaumW1Zlghlvef9xkevADewlqQUgySIxxYUNqIAy7nqX08bCt8h7JEjfXUt/EPR2HNeXQ7im3yX/rYNXrSVkJ6JrM3/uTWC3b6mfDRIifoawiociXKMJ0xzBVU6GPHU4omUE5tHJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=aUszwaZc; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="aUszwaZc"
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 209E4C01FB;
	Sun, 30 Aug 2026 01:22:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id E36492002D;
	Sun, 30 Aug 2026 01:22:03 +0000 (UTC)
Date: Sat, 29 Aug 2026 21:22:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: mm: Trace TLB flush path selection
Message-ID: <20260829212202.57db49ca@robin>
In-Reply-To: <20260829-tlb_tracepoint-v1-1-dfdaede7e741@gmail.com>
References: <20260829-tlb_tracepoint-v1-1-dfdaede7e741@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ukqctwoyphodb13xzayqebz7r4f4dmek
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: E36492002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/sqVK0fFooPR1itamYVWNSbX7CA3T24RY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=4sRIP04b9wK9VjtW1o66xTIPvzY/H2UE5MvlBWnKKPA=; b=aUszwaZcQphe/6RW9aC3DbZu7MgM5/QL73IiMyklaB2N9HFhtstT3ZO7M7kLXfT9PvYJ/xw4Wm96RKVVFNXOazvTMx3QGArSu2Ow8bsLHMPdvwwTMA3xoRD4SDH0QYAhlurMTpAXISJOsiVVK+NdX5z1IP1hgqw+r3HfMLYXUFE=
X-HE-Tag: 1788052923-607629
X-HE-Meta: U2FsdGVkX1/wQ+Oy6cCSBIUf39XP6U3b3Q63hB4YOQx2PzNY3F5HuBYUg3xu8fpdaMceW8EDr1Ht9QoMe7RjrFymxjxRR9SkxVn7s+pAmzieKjq7CDgqI7gRwRWymf2iNNrhkFLK+RaaPOJ7aSMnsIPsMRRrBwZxz8PZ15/oWaWaYJ1XLnjywIbxOrBam8ga6izc20V5RXF2re5X0mD0osJwtbVqIZ9sncZvCYwDZki8dyw7rZJFrcZK92QBfQiinedxY9N2N6tDxBMD3cQy5HNebtqnC2GUCNVpvfXdDT6dXoyq2FaMw5pOay+rscGtIhBXvWscl1Bez+1Er4SdnxBKH9PrYGVT

On Sat, 29 Aug 2026 17:44:18 +0200
Roman 'Hedin' Storozhenko <romeusmeister@gmail.com> wrote:

> +static __always_inline void
> +riscv_tlb_trace_flush_path(const struct cpumask *cmask, unsigned long start,
> +			   unsigned long size, unsigned long stride,
> +			   unsigned long asid, bool has_mm,
> +			   enum riscv_tlb_flush_path path)
> +{
> +	enum riscv_tlb_flush_scope scope;
> +
> +	if (!trace_riscv_tlb_flush_path_enabled())
> +		return;
> +
> +	scope = riscv_tlb_get_flush_scope(size, stride, has_mm);
> +	trace_riscv_tlb_flush_path(start, size, stride, asid, has_mm, cmask,
> +				   scope, path);

instead of using two static calls you can use the new:

   trace_call__riscv_tlb_flush_path()

That is to be used instead of the trace_<event>() if it's behind a
trace_<event>_enabled() check. That is because the
trace_call__<event>() will always trigger the trace event logic because
it should only be called when the trace event was enabled.

-- Steve


> +}
> +
