Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD5D198E81;
	Thu,  6 Jun 2024 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694346; cv=none; b=rUY9rr/pnW8YaT84RY7C+updh63qKI9BmQ/ZuKTA+byf3JCeSVbo0UqlYiooiefqMH0cqaZDWuyhJ0DYHjW7v4cORQG15uoy3lxCVVaSsjveONE/Ra6ihUMd8sGZoif+PBQhsI4TNt4H9eJWrdpihqbqnGGM45MofkBWTOIbJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694346; c=relaxed/simple;
	bh=Xs1pjo3lFjP8N7muVrLGWCIMXCKg0pc++kR1viKSbVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5lUvQq20M+YxTkDLSKP8hEG8C4AGOjUVV4+wPmJ0GBvkqP08Et2olGU2Aa3MYhw41/X6IKz66tUgnmuJmVEzzk+QXzvJUa8ZYlv8+JyiBeUKvvylPZXAYFur9xCwNGsJrWZ3p9PQjbA7QaPhQP7pqeKlbByl1HFGulr+3voQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sZiuUTZB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sZiuUTZB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AX+P9Wg9cHx6TMFxQPWdZdwRQgdlPHNf0hGvOlWuVCg=; b=sZiuUTZBbDZI+OBBaMppulmOV8
	lfPeXd/F5I4YEINOwVTcwP05R96wCiqPGzAdeZQxuUJkm5O82lIssE+O1fYRX5YY1GOuKgmimsjhn
	MMuYKbjZ0eh5jdNBVwpzCBYxnh6hnSuXfOLTCyQAQpJL1OaKHOkSyJYPs3W0Kt0jh5viR6JTfxgKG
	P70zDxU+JYBMH1zIUIiPujOgDIGc+b4NDIljrUQn3gRjz0SUIZq/zFYMiBYFvJFr2eJaYg6A8cIzi
	AqD+/6DjLSu9/V6c0LTnbGUKDg32GUX7wex4VY22BA9QJ7Gv0S/m5yJASjL2xqH32z46Z56tTuucw
	9M/fjL4g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFGlH-00000001faA-43hm;
	Thu, 06 Jun 2024 17:18:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C14AE30047C; Thu,  6 Jun 2024 19:18:45 +0200 (CEST)
Date: Thu, 6 Jun 2024 19:18:45 +0200
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
Subject: Re: [PATCH 1/3] rust: add static_call support
Message-ID: <20240606171845.GE8774@noisy.programming.kicks-ass.net>
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
 <20240606-tracepoint-v1-1-6551627bf51b@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-tracepoint-v1-1-6551627bf51b@google.com>

On Thu, Jun 06, 2024 at 03:05:24PM +0000, Alice Ryhl wrote:
> Add static_call support by mirroring how C does. When the platform does
> not support static calls (right now, that means that it is not x86),
> then the function pointer is loaded from a global and called. Otherwise,
> we generate a call to a trampoline function, and objtool is used to make
> these calls patchable at runtime.

This is absolutely unreadable gibberish -- how am I supposed to keep
this in sync with the rest of the static_call infrastructure?

> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/lib.rs         |  1 +
>  rust/kernel/static_call.rs | 92 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index fbd91a48ff8b..d534b1178955 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -38,6 +38,7 @@
>  pub mod prelude;
>  pub mod print;
>  mod static_assert;
> +pub mod static_call;
>  #[doc(hidden)]
>  pub mod std_vendor;
>  pub mod str;
> diff --git a/rust/kernel/static_call.rs b/rust/kernel/static_call.rs
> new file mode 100644
> index 000000000000..f7b8ba7bf1fb
> --- /dev/null
> +++ b/rust/kernel/static_call.rs
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Logic for static calls.
> +
> +#[macro_export]
> +#[doc(hidden)]
> +macro_rules! ty_underscore_for {
> +    ($arg:expr) => {
> +        _
> +    };
> +}
> +
> +#[doc(hidden)]
> +#[repr(transparent)]
> +pub struct AddressableStaticCallKey {
> +    _ptr: *const bindings::static_call_key,
> +}
> +unsafe impl Sync for AddressableStaticCallKey {}
> +impl AddressableStaticCallKey {
> +    pub const fn new(ptr: *const bindings::static_call_key) -> Self {
> +        Self { _ptr: ptr }
> +    }
> +}
> +
> +#[cfg(CONFIG_HAVE_STATIC_CALL)]
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! _static_call {
> +    ($name:ident($($args:expr),* $(,)?)) => {{
> +        // Symbol mangling will give this symbol a unique name.
> +        #[cfg(CONFIG_HAVE_STATIC_CALL_INLINE)]
> +        #[link_section = ".discard.addressable"]
> +        #[used]
> +        static __ADDRESSABLE: $crate::static_call::AddressableStaticCallKey = unsafe {
> +            $crate::static_call::AddressableStaticCallKey::new(::core::ptr::addr_of!(
> +                $crate::macros::paste! { $crate::bindings:: [<__SCK__ $name >]; }
> +            ))
> +        };
> +
> +        let fn_ptr: unsafe extern "C" fn($($crate::static_call::ty_underscore_for!($args)),*) -> _ =
> +            $crate::macros::paste! { $crate::bindings:: [<__SCT__ $name >]; };
> +        (fn_ptr)($($args),*)
> +    }};
> +}
> +
> +#[cfg(not(CONFIG_HAVE_STATIC_CALL))]
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! _static_call {
> +    ($name:ident($($args:expr),* $(,)?)) => {{
> +        let void_ptr_fn: *mut ::core::ffi::c_void =
> +            $crate::macros::paste! { $crate::bindings:: [<__SCK__ $name >]; }.func;
> +
> +        let fn_ptr: unsafe extern "C" fn($($crate::static_call::ty_underscore_for!($args)),*) -> _ =
> +            if true {
> +                ::core::mem::transmute(void_ptr_fn)
> +            } else {
> +                // This is dead code, but it influences type inference on `fn_ptr` so that we
> +                // transmute the function pointer to the right type.
> +                $crate::macros::paste! { $crate::bindings:: [<__SCT__ $name >]; }
> +            };
> +
> +        (fn_ptr)($($args),*)
> +    }};
> +}
> +
> +/// Statically call a global function.
> +///
> +/// # Safety
> +///
> +/// This macro will call the provided function. It is up to the caller to uphold the safety
> +/// guarantees of the function.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// fn call_static() {
> +///     unsafe {
> +///         static_call! { your_static_call() };
> +///     }
> +/// }
> +/// ```
> +#[macro_export]
> +macro_rules! static_call {
> +    // Forward to the real implementation. Separated like this so that we don't have to duplicate
> +    // the documentation.
> +    ($($args:tt)*) => { $crate::static_call::_static_call! { $($args)* } };
> +}
> +
> +pub use {_static_call, static_call, ty_underscore_for};
> 
> -- 
> 2.45.2.505.gda0bf45e8d-goog
> 
