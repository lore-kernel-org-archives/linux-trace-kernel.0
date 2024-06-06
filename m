Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3A5196C72;
	Thu,  6 Jun 2024 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687757; cv=none; b=bSlZ+QtORlqDGeXap+J31IKFPPdiXFnwIaIf2BGX8PPUBhinS9SyZUzGKzJpo+kBdoIG1dK6EzjFcrEHzGA1YaegOh5vUC5PuWe9ppugC5dK5vQKPDk/1+Jt6YaFPtIoLv37YYTXFuH5zWGlgMWSF7d9y0OLyDfIhhj1exsuXj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687757; c=relaxed/simple;
	bh=eBB9aBsiHmO7WU3mW/9YuXTak8tCclcTkOS/Rq6E7qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgJhwY6lGBl9FQJU/UcnvMuKru/SMuGTSPV+919KhWFwYVnNRcwb4Q6hHqL0Z+UWSb8JBYYrKSLLid7NUA37wzrErGoMbnj4fZBWKItb5H2JtQ2TZzUQzUo8kHE05kQO1sMQGwyYHZuUjsbPXthK7xHi4YHWLXr8qMaGrKPdBKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=A3LjRNJB; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="A3LjRNJB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1717687754;
	bh=eBB9aBsiHmO7WU3mW/9YuXTak8tCclcTkOS/Rq6E7qk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A3LjRNJBEERCPjwPScg2ylCa5gji25832C322+S371TeZM/YKkxh0OPo7S/9Fc9jY
	 QKmCofOGy8HweZsq1Mze1B/jrfqevddKdNyyVOXfYlIO/b9QDfVlD+2mJ6mUtF4+Ik
	 pvjWsScyQtxDbtHGtimWQph+F70cAVEac222LcrSnRebRmWIysrodQR6BFhFwWZiHX
	 h9cPNQ4pFk91vERkOaia81xFrhCpNZspEJR0sPuPvPJguln0WjehwQQrjJ7+9aI0Kj
	 2jLxTO9kmp+3igDS52Jn1sFxayMBry45PyVJ9W+gczgCQ6alF8fY5mC1cAhD7jycLL
	 4AUaPKpc6L9GQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Vw7Xp3yhGz13B5;
	Thu,  6 Jun 2024 11:29:14 -0400 (EDT)
Message-ID: <389a8c55-a169-47ef-99c0-48f58003b40c@efficios.com>
Date: Thu, 6 Jun 2024 11:30:03 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rust: add tracepoint support
To: Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>
Cc: linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
 <20240606-tracepoint-v1-3-6551627bf51b@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240606-tracepoint-v1-3-6551627bf51b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-06 11:05, Alice Ryhl wrote:
> Make it possible to have Rust code call into tracepoints defined by C
> code. It is still required that the tracepoint is declared in a C
> header, and that this header is included in the input to bindgen.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

[...]

> diff --git a/rust/helpers.c b/rust/helpers.c
> index 2c37a0f5d7a8..0560cc2a512a 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -165,6 +165,30 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
>   }
>   EXPORT_SYMBOL_GPL(rust_helper_krealloc);
>   
> +void rust_helper_preempt_enable_notrace(void)
> +{
> +	preempt_enable_notrace();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_preempt_enable_notrace);
> +
> +void rust_helper_preempt_disable_notrace(void)
> +{
> +	preempt_disable_notrace();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_preempt_disable_notrace);
> +
> +bool rust_helper_current_cpu_online(void)
> +{
> +	return cpu_online(raw_smp_processor_id());
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_current_cpu_online);
> +
> +void *rust_helper___rcu_dereference_raw(void **p)
> +{
> +	return rcu_dereference_raw(p);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper___rcu_dereference_raw);

Ouch. Doing a function call for each of those small operations will
have a rather large performance impact when tracing is active. If it is
not possible to inline those in Rust, then implementing __DO_TRACE in
a C function would at least allow Rust to only do a single call to C
rather than go back and forth between Rust and C.

What prevents inlining those helpers in Rust ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

