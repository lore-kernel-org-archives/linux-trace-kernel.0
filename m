Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28EC1A3A83
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302832; cv=none; b=U7piTS2Dzkr6Zu/2wkGUEkoYDvPOToa0WnXguhAvgm6ZwbFiHy+jG5Gh008KceiDAac/DfOmGTCG5Inm/NY70it0Q1ptjHoB+4G8d65el4e6h5lQvTJyB+rqNkNO21xRybtgXxcqj2ymvy0oEvcUB9k5yoTgxOFBNERncT5XOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302832; c=relaxed/simple;
	bh=LI900uzgGCQElfJqtf01iHNZkLmSZEe/42LMd0+O44Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PunhJsaCmeyWpkh7Gsdb9nIM/V1XnvtuT5tpPhcKaZD3CFnNTuV+XEn49hKKiygTNR5uTo+ihS9swv7KZQoMQYlKytfvLCbypUDD7zTzx1q8CZbqQNb4/HWVv4TlirxbtIZU/isRzh1JbJUrwvYLo9WhqoBiI/Rxxg6l6xtusWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fBOAYqGi; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fBOAYqGi"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53343bf5eddso5995564e87.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725302828; x=1725907628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NCSu3cKIwSHt25rKzyc3TLGkgrpQltQSLr6RUpbw+m8=;
        b=fBOAYqGi4Z4NgV2EEB3qBNZQ5Si9ZYUCyvu1XGELxNjx0Rn6sYfaGUp6ZH3x3QzcTs
         djFZMCE3PNp6MWUEcXkMUEZZQ0+gOpduwBuqz3hovH1Gc56n674h522bVhf+MkKmrXkQ
         yGhV98OJdwcQuwUJ0+bfB/LkTS7SfjNzuBQvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302828; x=1725907628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCSu3cKIwSHt25rKzyc3TLGkgrpQltQSLr6RUpbw+m8=;
        b=cyUt4ODXrgQmHjlllm9jqPyAJ2fVxVD+/0nX8Mm4bl7D5+i2+QYzGB5q7U655nU4FO
         di2ylO/7m9Jswkvv3p3jFS15rs1elooB9phUWg9N8prFSVMaTYJHBZnqccHwSaHlSRwy
         PCGILW7ct1nbl6cy4PCKBLUQPBFmgRTlXyvAcj1slrm2rXbsfN1GATtHq4VLfK6K6Jor
         DSBiO6QMijxK1TEoMEauFfEpqImTpE5UTgYrEPPyr/p8lnzkelLZw5pp4AWf3p2VZ5LW
         BQTzMXC+YXbBeNfq0gGd3dUhynR1h6QH8VayegQb8n8gXPx8gtbPr8lt2NS+Z6Vsjbnt
         eJhA==
X-Forwarded-Encrypted: i=1; AJvYcCUbLg7AcW1LTBn1H0Gi6oSCZC/6k5MnsGTGgu7pGuQPA/fHqN1J8Pj7BvLmDzwFoIVmieWy8xSuaI+7Lx08NTZrjGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg/aGUz9x8fPTElhq1GMKsG9MNRLk9hQjyl4Yv8TN8tnKv6+J1
	raDZIoGoIWxCiuQlx+jfSPP3dyFjg4BK2qb/vviKQDXWgjmIKzFW0nk9Anwu68su3Td/ZK8Pykh
	yzSo=
X-Google-Smtp-Source: AGHT+IFwY81St5XLpTjwCpEuQG8TkLdrVqajHTaI4oa/CXdppeEnPgWqUdlHp42u1xSpRxfRRzY7gw==
X-Received: by 2002:a05:6512:318f:b0:52e:ff2a:217 with SMTP id 2adb3069b0e04-53546bc3690mr6324321e87.50.1725302827400;
        Mon, 02 Sep 2024 11:47:07 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535408277acsm1725316e87.120.2024.09.02.11.47.06
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 11:47:06 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f406034874so53979961fa.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:47:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0/gyzQDUv4LpFTwk5nBK76xXUJVpm054SQpoOduRDhlZ5G9jHoKzuNSz6arjUWu1XGM8te6bGv2hCnlTKqtdlMLA=@vger.kernel.org
X-Received: by 2002:a2e:bc0e:0:b0:2f1:6cd6:c880 with SMTP id
 38308e7fff4ca-2f610890881mr116441241fa.37.1725302826121; Mon, 02 Sep 2024
 11:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828143719.828968-1-mathieu.desnoyers@efficios.com>
 <20240828143719.828968-3-mathieu.desnoyers@efficios.com> <20240902154334.GH4723@noisy.programming.kicks-ass.net>
 <9de6ca8f-b3f1-4ebc-a5eb-185532e164e7@efficios.com>
In-Reply-To: <9de6ca8f-b3f1-4ebc-a5eb-185532e164e7@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Sep 2024 11:46:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRefOSUy88-rcackyb4Ss3yYjuqS_TJRJwY_p7E3r0SA@mail.gmail.com>
Message-ID: <CAHk-=wgRefOSUy88-rcackyb4Ss3yYjuqS_TJRJwY_p7E3r0SA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] cleanup.h: Introduce DEFINE_INACTIVE_GUARD and activate_guard
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Greg KH <gregkh@linuxfoundation.org>, 
	Sean Christopherson <seanjc@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 11:08, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> If Linus' objections were mainly about naming, perhaps what I am
> suggestion here may be more to his liking ?

Most of my objections were about having subtle features that then had
very subtle syntax and weren't that clear.

And yes, a small part of it was naming (I absolutely hated the initial
"everything is a guard" thing, when one of the main uses were about
automatic freeing of variables).

But a much larger part was about making the new use greppable and have
really simple syntax.

And the conditional case was never that simple syntax, and I feel it
really violates the whole "this scope is protected".

And no, I do not like Peter's "if_guard()" either.

Honestly, I get the feeling that this is all wrong.

For example, I searched for a few of the places where you wanted to
use this, and see code like this:

    #define __BPF_DECLARE_TRACE(call, proto, args, tp_flags)            \
    static notrace void                                                 \
    __bpf_trace_##call(void *__data, proto)                             \
    {                                                                   \
        DEFINE_INACTIVE_GUARD(preempt_notrace, bpf_trace_guard);        \
                                                                        \
        if ((tp_flags) & TRACEPOINT_MAY_FAULT) {                        \
                might_fault();                                          \
                activate_guard(preempt_notrace, bpf_trace_guard)();     \
        }                                                               \
                                                                        \
        CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data,
CAST_TO_U64(args)); \
    }

and it makes me just go "that's just *WRONG*".

That code should never EVER use a conditional guard.

I find *two* uses of this in your patches, and both of them look
com,pletely wrong to me, because you could have written the code
*without* that conditional activation, and it would have been *better*
that way.

IOW, that code should just have been something like this:

    #define __BPF_DECLARE_TRACE(call, proto, args, tp_flags)    \
    static notrace void                                         \
    __bpf_trace_##call(void *__data, proto)                     \
    {                                                           \
                                                                \
        if ((tp_flags) & TRACEPOINT_MAY_FAULT) {                \
                might_fault();                                  \
                guard(preempt_notrace)();                       \
                CONCATENATE(bpf_trace_run, ...                  \
                return;                                         \
        }                                                       \
        CONCATENATE(bpf_trace_run, ...                          \
    }

instead.

Sure, it duplicates the code inside the guard, but what's the
downside? In both of the cases I saw, the "duplicated" code was
trivial.

And the *upside* is that you don't have any conditional locking or
guarding, and you don't have to make up ridiculous and meaningless
temporary names for the guard etc. So you get to use the *LEGIBLE*
code.

And you don't have a patch that just renames all our existing uses.
Which was also wrong.

So no, I don't like Peter's "if_guard()",  but I find your conditional
activation to be absolutely wrogn and horrible too.

                 Linus
