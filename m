Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F513BAEB;
	Thu,  6 Jun 2024 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687507; cv=none; b=p6vIVJMkSOA6+qpmJFZi9iwkbV8RKSddRaHANzu26H9mAMfu9c2G4t2ay+BNqmGPvTvnen8FVwLvlLH+ltCCSelq/2g12YGbXmuYZROI2JN8AGzzT9/STUa8X7b7GskWq3AJQIwaicNBQJiZNcKCmH/vyKg7rgTfrSoabFZoWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687507; c=relaxed/simple;
	bh=tgTzIjWs3IOWhzy9aFIvKKOyh5lSjPt68eYtmBGavek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rINkwfwg/Kl4pwGMzOvl5F8jC3OU5BSMu5BVHawvKe4ARi9pvsxEXrp2pdXc7N7cLJkOPmBs3AeOuG9aUzoeVbdgX/GOJ1Dv8oDOvdA9p3lCsgry0IYXnQwMjWZtCq9qKAMtS7yPdGMT9E9NzqMSuRW0GIgwmx3grAN0dNmLMI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=L/JvKhzu; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="L/JvKhzu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1717687503;
	bh=tgTzIjWs3IOWhzy9aFIvKKOyh5lSjPt68eYtmBGavek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L/JvKhzuuKxAlugKssZBtUEsAaiWcHP3Vsgav8zTxI+r7wA6dxJDKgIupT6DuDL/S
	 4MVlCmzNVRTUAitMTNaHYNnqoNq4rWsydmXWT5LR4kxIdXbsM3dcn/5Qg/2UAAd4UK
	 y9idJGjRH6yF1GL6KhV6BS/Syuplst1fAr74l6N6RQGvfvjdbi+YGSABc6zabGlAxP
	 PhrNbG3Ju7Vaai55JsTea8XVVTPCHP2mHJwWx6D742GwzeQLiBtxi/CJrvmjVTpjkm
	 anX8DQKVBlFHo2ExjSDdfHy/gOXrVyU/niLSrPKee1y7ub1Q+uPjfuERfogqBqFxli
	 FrmnDD54Zhmxw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Vw7Rz1ztMz13B4;
	Thu,  6 Jun 2024 11:25:03 -0400 (EDT)
Message-ID: <cd4a58d9-3e0a-49d1-8a74-bc9d53fc2dfd@efficios.com>
Date: Thu, 6 Jun 2024 11:25:49 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Tracepoints and static branch/call in Rust
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-06 11:05, Alice Ryhl wrote:
> An important part of a production ready Linux kernel driver is
> tracepoints. So to write production ready Linux kernel drivers in Rust,
> we must be able to call tracepoints from Rust code. This patch series
> adds support for calling tracepoints declared in C from Rust.

I'm glad to see progress on this front ! Please see feedback below.

> 
> To use the tracepoint support, you must:
> 
> 1. Declare the tracepoint in a C header file as usual.
> 2. Make sure that the header file is visible to bindgen so that Rust
>     bindings are generated for the symbols that the tracepoint macro
>     emits.
> 3. Use the declare_trace! macro in your Rust code to generate Rust
>     functions that call into the tracepoint.
> 
> For example, the kernel has a tracepoint called `sched_kthread_stop`. It
> is declared like this:
> 
> 	TRACE_EVENT(sched_kthread_stop,
> 		TP_PROTO(struct task_struct *t),
> 		TP_ARGS(t),
> 		TP_STRUCT__entry(
> 			__array(	char,	comm,	TASK_COMM_LEN	)
> 			__field(	pid_t,	pid			)
> 		),
> 		TP_fast_assign(
> 			memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
> 			__entry->pid	= t->pid;
> 		),
> 		TP_printk("comm=%s pid=%d", __entry->comm, __entry->pid)
> 	);
> 
> To call the above tracepoint from Rust code, you would add the relevant
> header file to rust/bindings/bindings_helper.h and add the following
> invocation somewhere in your Rust code:
> 
> 	declare_trace! {
> 	    fn sched_kthread_stop(task: *mut task_struct);
> 	}
> 
> This will define a Rust function of the given name that you can call
> like any other Rust function. Since these tracepoints often take raw
> pointers as arguments, it may be convenient to wrap it in a safe
> wrapper:
> 
> 	mod raw {
> 	    declare_trace! {
> 	        fn sched_kthread_stop(task: *mut task_struct);
> 	    }
> 	}
> 	
> 	#[inline]
> 	pub fn trace_sched_kthread_stop(task: &Task) {
> 	    // SAFETY: The pointer to `task` is valid.
> 	    unsafe { raw::sched_kthread_stop(task.as_raw()) }
> 	}
> 
> A future expansion of the tracepoint support could generate these safe
> versions automatically, but that is left as future work for now.
> 
> This is intended for use in the Rust Binder driver, which was originally
> sent as an RFC [1]. The RFC did not include tracepoint support, but you
> can see how it will be used in Rust Binder at [2]. The author has
> verified that the tracepoint support works on Android devices.
> 
> This implementation implements support for static keys in Rust so that
> the actual static branch will end up in the Rust object file. However,
> it would also be possible to just wrap the trace_##name generated by
> __DECLARE_TRACE in an extern C function and then call that from Rust.
> This will simplify the Rust code by removing the need for static
> branches and calls, but it places the static branch behind an external
> call, which has performance implications.

The tracepoints try very hard to minimize overhead of dormant tracepoints
so it is not frowned-upon to have them built into production binaries.
This is needed to make sure distribution vendors keep those tracepoints
in the kernel binaries that reach end-users.

Adding a function call before evaluation of the static branch goes against
this major goal.

> 
> A possible middle ground would be to place just the __DO_TRACE body in
> an extern C function and to implement the Rust wrapper by doing the
> static branch in Rust, and then calling into C the code that contains
> __DO_TRACE when the tracepoint is active. However, this would need some
> changes to include/linux/tracepoint.h to generate and export a function
> containing the body of __DO_TRACE when the tracepoint should be callable
> from Rust.

This tradeoff is more acceptable than having a function call before
evaluation of the static branch, but I wonder what is the upside of
this tradeoff compared to inlining the whole __DO_TRACE in Rust ?

> So in general, there is a tradeoff between placing parts of the
> tracepoint (which is perf sensitive) behind an external call, and having
> code duplicated in both C and Rust (which must be kept in sync when
> changes are made). This is an important point that I would like feedback
> on from the C maintainers.

I don't see how the duplication happens there: __DO_TRACE is meant to be
inlined into each C tracepoint caller site, so the code is already meant
to be duplicated. Having an explicit function wrapping the tracepoint
for Rust would just create an extra instance of __DO_TRACE if it happens
to be also inlined into C code.

Or do you meant you would like to prevent having to duplicate the
implementation of __DO_TRACE in both C and Rust ?

I'm not sure if you mean to prevent source code duplication between
C and Rust or duplication of binary code (instructions).

Thanks,

Mathieu


> 
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
> Link: https://r.android.com/3110088 [2]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Alice Ryhl (3):
>        rust: add static_call support
>        rust: add static_key_false
>        rust: add tracepoint support
> 
>   rust/bindings/bindings_helper.h |  1 +
>   rust/bindings/lib.rs            | 15 +++++++
>   rust/helpers.c                  | 24 +++++++++++
>   rust/kernel/lib.rs              |  3 ++
>   rust/kernel/static_call.rs      | 92 +++++++++++++++++++++++++++++++++++++++++
>   rust/kernel/static_key.rs       | 87 ++++++++++++++++++++++++++++++++++++++
>   rust/kernel/tracepoint.rs       | 92 +++++++++++++++++++++++++++++++++++++++++
>   scripts/Makefile.build          |  2 +-
>   8 files changed, 315 insertions(+), 1 deletion(-)
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240606-tracepoint-31e15b90e471
> 
> Best regards,

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

