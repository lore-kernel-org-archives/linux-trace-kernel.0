Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42199376E4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974347; cv=none; b=M+9vZdDx0WWdl8JI+X9Ah3eqtM7EmA9GsK1cpms6qkcpyIJKvJJWP2qjWtLMIUJQzXOTIalbv5ADjXdSIGKKa9KzGrXHW3kdFgR6Dg6mqcMpTN+4hIj0zY8Jh3grYoZRsie+H0sTW9QkVNbjpICP+sgindt9Fg3l6D79v4aa9uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974347; c=relaxed/simple;
	bh=9ExI3HMc8dpikZS14KdMf2VTfo2Gm4D9Du3Ad8hswa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTVnU3sDkTykUd7Oxq3NGXt6Yk3C5/SCnRr+zf3lq/zET3LBp1WCmfvA6vrZP7QC6by+xzfkh96SZfqAGv+cBdONPxCWXt4KM5kGwQIbiqtorEa2blrc++pw/P0JE3Mya6MIW+lz7NusrJ6C5dNYB96ZgO0Nkr+kgkQsQUgmcw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTwxAVVv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTwxAVVv"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7046211e455so1369031b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718974345; x=1719579145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFikssrTKZjRo9rjV6X1YnKRcFeJcrLtumLLhBthri8=;
        b=dTwxAVVvG50novP6VF9UJ4zxxi3/kn2Qm/RuCRSGH6hF9+fGk4+lxd8Ts1FqPzm3dc
         TNLnGhqmv7uchPdWDS+dM1lZLxaOCbBdW6WgnygnPxblfrgdo5IChA51HTkI12IQG/is
         0h2Gqx5pNlccTuls0xwhHYtRZVbuRRItSow1ThOoQrT3C0jLepMAzKHEOwuLpgAtX3uk
         5crDRly5mSLFxUu1smW6B66qa7qBAyp4f+iJozeZdpCj8VSXKe6egAOQni4qEPPAveLq
         ZvGVrcaVu9Y7Vc8vCW22gO7E3O8DFODHFhyvtY/CjokQF9o4iBjPzsBf29maRwj6MZcy
         dv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718974345; x=1719579145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFikssrTKZjRo9rjV6X1YnKRcFeJcrLtumLLhBthri8=;
        b=TuQNTJ3lbkfvxX2KeOHv9gPd0bKHvKz+bo80J/0MKsm5vwKKs645sTjDM0Va2t0s15
         xwqz0/x896lU3JhTzUe70u17eNOiZoGvNNa/i6TWuLQz02gTwvDlZ5oB9lwIR5LksZ3a
         jdngDf60TgpaHVe20v3uWDDgOcsZGIOadp48eep9aLVGqRXQLSOe9Mv+0m6NcB/QovSR
         WSU72dK5Rl4A8dWoFgwFmuKHC4iRd1dsjlJyEhOYE5u9ESu2uf5MnMD6a3R+GPohNfHX
         NVBLwFeJn0ubn9LOy8BFfBv1YjjivpCRoR6MxnvPPeAIxRoMbYQjjGlEFd3pNKGi0CgH
         hvew==
X-Gm-Message-State: AOJu0YxH+z1mF7cpB+jw6ajxP5MQenraSP3mCBqPooH8L5aSDtM5rG1B
	p/rkO+9QZnlBA+4GYhpqoCbRdRiryjZJ3uvN3jA6sV8DMT/wuyIxx/z6VExZJK6rTVbxjFms3DR
	1/jWY/W0TJNvO4e0PNse0EcY/RDusLIl1JFCe
X-Google-Smtp-Source: AGHT+IHLbxh5gnZYE3Ij3eJIOL1ReH1iHe0C7faIKhDLxkg3+UYsqYWbYf6Q8dpYIbAjVW26QeLxKyYtHQr3AWRtJa0=
X-Received: by 2002:a05:6a20:7283:b0:1af:bd03:3222 with SMTP id
 adf61e73a8af0-1bcbb5f75cbmr9905522637.45.1718974345162; Fri, 21 Jun 2024
 05:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621-tracepoint-v3-0-9e44eeea2b85@google.com> <20240621-tracepoint-v3-2-9e44eeea2b85@google.com>
In-Reply-To: <20240621-tracepoint-v3-2-9e44eeea2b85@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 21 Jun 2024 14:52:10 +0200
Message-ID: <CAH5fLghb6oVkgy3ckf=dUk9S4VdCeWin+yDBW1ffBoxu=HqBKw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rust: add tracepoint support
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>
Cc: linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:35=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Make it possible to have Rust code call into tracepoints defined by C
> code. It is still required that the tracepoint is declared in a C
> header, and that this header is included in the input to bindgen.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  include/linux/tracepoint.h      | 18 +++++++++++++++-
>  include/trace/define_trace.h    |  7 ++++++
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/tracepoint.rs       | 47 +++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 73 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 689b6d71590e..d82af4d77c9f 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -238,6 +238,20 @@ static inline struct tracepoint *tracepoint_ptr_dere=
f(tracepoint_ptr_t *p)
>  #define __DECLARE_TRACE_RCU(name, proto, args, cond)
>  #endif
>
> +/*
> + * Declare an exported function that Rust code can call to trigger this
> + * tracepoint. This function does not include the static branch; that is=
 done
> + * in Rust to avoid a function call when the tracepoint is disabled.
> + */
> +#define DEFINE_RUST_DO_TRACE(name, proto, args)
> +#define DEFINE_RUST_DO_TRACE_REAL(name, proto, args)                   \
> +       notrace void rust_do_trace_##name(proto)                        \
> +       {                                                               \
> +               __DO_TRACE(name,                                        \
> +                       TP_ARGS(args),                                  \
> +                       cpu_online(raw_smp_processor_id()), 0);         \
> +       }
> +
>  /*
>   * Make sure the alignment of the structure in the __tracepoints section=
 will
>   * not add unwanted padding between the beginning of the section and the
> @@ -253,6 +267,7 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
>         extern int __traceiter_##name(data_proto);                      \
>         DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);        \
>         extern struct tracepoint __tracepoint_##name;                   \
> +       extern void rust_do_trace_##name(proto);                        \
>         static inline void trace_##name(proto)                          \
>         {                                                               \
>                 if (static_key_false(&__tracepoint_##name.key))         \
> @@ -337,7 +352,8 @@ static inline struct tracepoint *tracepoint_ptr_deref=
(tracepoint_ptr_t *p)
>         void __probestub_##_name(void *__data, proto)                   \
>         {                                                               \
>         }                                                               \
> -       DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
> +       DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);       \
> +       DEFINE_RUST_DO_TRACE(_name, TP_PROTO(proto), TP_ARGS(args))
>
>  #define DEFINE_TRACE(name, proto, args)                \
>         DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
> diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
> index 00723935dcc7..b47cc036acba 100644
> --- a/include/trace/define_trace.h
> +++ b/include/trace/define_trace.h
> @@ -72,6 +72,13 @@
>  #define DECLARE_TRACE(name, proto, args)       \
>         DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>
> +/* If requested, create helpers for calling these tracepoints from Rust.=
 */
> +#ifdef CREATE_RUST_TRACE_POINTS
> +#undef DEFINE_RUST_DO_TRACE
> +#define DEFINE_RUST_DO_TRACE(name, proto, args)        \
> +       DEFINE_RUST_DO_TRACE_REAL(name, PARAMS(proto), PARAMS(args))
> +#endif
> +
>  #undef TRACE_INCLUDE
>  #undef __TRACE_INCLUDE
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h

Hmm, I tried using the support where I have both events and hooks:

#define CREATE_TRACE_POINTS
#define CREATE_RUST_TRACE_POINTS
#include <trace/hooks/rust_binder.h>
#include <trace/events/rust_binder.h>

But it's not really working. Initially I thought that it's because I
need to undef DEFINE_RUST_DO_TRACE at the end of this file, but even
when I added that, I still get this error:

    error: redefinition of 'str__rust_binder__trace_system_name'

Is the Rust support missing something, or is the answer just that you
can't have two files of the same name like this? Or am I doing
something else wrong?

Alice
