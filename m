Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BC41990D8;
	Thu,  6 Jun 2024 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694781; cv=none; b=BtfcZs4lj1W4Ex8Qj5p/7g9Id7YqtKe4z8jITBHSqvVYQUe7Jcw2anXZVT2Wq7a6cD1GMXH93SEbhZFe1ZptUImlVW2UOr6vDbFMAEsm8FFtK+bt3Bn+a08/Eh9veRkGROTTn6bH/znoVksK5i2v1rhpNdZJpJJ3tRX0FOswU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694781; c=relaxed/simple;
	bh=l8EdykTqJ3aoDDrALAsVEr30BhVYMuefAflhbdzU+3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwt7N64kzigV8RAQqIZcb/mJOJ82Tj0b2/E46fWY9QEcouUeD7FhRtZ1X/aRGHTTmS8I+Zg7g3oNUigggxGrAqlEb3fVHIwh7TsW5FdLSYL/ebFzNVrKV1peOQOOCBzSopf2f9q7mRYgv+mo7hbRQpPlp3WHzqAKYQBrPc0lXog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U6cVw9w4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U6cVw9w4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jniy+NLgVrBfK0p3PyzP0Z6EZrAShqg1T5f6U9wpTZM=; b=U6cVw9w4l6T0HIwuVstgOdFrTf
	/eJRHcWb1hvtr8USQwnMbi9gwBnZoAmC5llmrCK8WoJavNxSZyU1vBRsTXpX1mIxRV2HbXbKvemvr
	TcXvzrpg5zh8w7sQ/DUmTHhVSvF/gW4d7nzHmzLdSKn8+nXlNSLKkBVrg5ifTV1HQcWCAL4a1TzO7
	qOWitxMaFgEvdbg1vnic8/zdxscPveTofIJJgbgTNMTGr1zZ0yrw7ce5WHIqVbg4oxX0vZIbXtgXw
	aC3yBbxrIM1qZQ9dcKNVCUGJtqPoggVx2LR7agbJzNJM8kOrpNoU60HebjaE6iXoVS3ZhuNGq8+B4
	tvA9fqYA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFGsN-00000001fmR-14ZR;
	Thu, 06 Jun 2024 17:26:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E941230047C; Thu,  6 Jun 2024 19:26:07 +0200 (CEST)
Date: Thu, 6 Jun 2024 19:26:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: add tracepoint support
Message-ID: <20240606172607.GG8774@noisy.programming.kicks-ass.net>
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
 <20240606-tracepoint-v1-3-6551627bf51b@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-tracepoint-v1-3-6551627bf51b@google.com>

On Thu, Jun 06, 2024 at 03:05:26PM +0000, Alice Ryhl wrote:
> Make it possible to have Rust code call into tracepoints defined by C
> code. It is still required that the tracepoint is declared in a C
> header, and that this header is included in the input to bindgen.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/bindings/lib.rs            | 15 +++++++
>  rust/helpers.c                  | 24 +++++++++++
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/tracepoint.rs       | 92 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 133 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index ddb5644d4fd9..d442f9ccfc2c 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -15,6 +15,7 @@
>  #include <linux/refcount.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> +#include <linux/tracepoint.h>
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  
> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index 40ddaee50d8b..48856761d682 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -48,3 +48,18 @@ mod bindings_helper {
>  }
>  
>  pub use bindings_raw::*;
> +
> +/// Rust version of the C macro `rcu_dereference_raw`.
> +///
> +/// The rust helper only works with void pointers, but this wrapper method makes it work with any
> +/// pointer type using pointer casts.
> +///
> +/// # Safety
> +///
> +/// This method has the same safety requirements as the C macro of the same name.
> +#[inline(always)]
> +pub unsafe fn rcu_dereference_raw<T>(p: *const *mut T) -> *mut T {
> +    // SAFETY: This helper calls into the C macro, so the caller promises to uphold the safety
> +    // requirements.
> +    unsafe { __rcu_dereference_raw(p as *mut *mut _) as *mut T }
> +}
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 2c37a0f5d7a8..0560cc2a512a 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -165,6 +165,30 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_krealloc);
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

A notrace wrapper that is tracable, lol.

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

I'm going to keep yelling and objecting to these wrappers.

Fix bindgen already. Or whatever is needed to get it to interoperate
with C inline / asm.

NAK NAK NAK
