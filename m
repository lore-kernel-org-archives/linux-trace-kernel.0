Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5911CB306
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390026; cv=none; b=K0sTlFftqlUWM/ylTd222b25jQOj73HAWlLmT/zkBJz5YzyHWBOsnfER1N1LwgAd8s6S5scowppIPxBoNswBceQaZjQElJ3rfYmpM9BUQ1gaioRmmDBoHzYrMYmA9YPIEKb6YrSWz/LWGWW87/93No+4V7T8OTikqoSd1n8OapI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390026; c=relaxed/simple;
	bh=2uozw+fJ5WSOhhVTdjzSoLngH5Q1O9Z/Og7kh1h8O9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nR0M1InAFjH6tRe1OQdg6DQbLRqwdr+Gk0UMpZA5RnNj6MxNB03REGrslZ3n3sb3HZcyVgTUQicS6fzrZN2o0B5jb4KriosSkJeWf21aTcRAYyqsh6Asf5D0ROPcKJ8md72L0yD2ug/f9l97i9+YpFZzzQhRRk+Thc8ZpwYi20g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bkVsaYTZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bkVsaYTZ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86984e035aso695485066b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725390022; x=1725994822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1O1ShPrP32GZ6zNKibhG+Lc7a+zlJjipIRDsNar31FQ=;
        b=bkVsaYTZSHpalpoQ+jrRJfkahrhV2EaIlNnfBtYJlzcWKn8m8UXaFf1LhzJbjg67Vg
         x+X5dgvm5lYELnNr9js2BrxRTus/ly+cSgoR/HQshRHdiCwwVB+QKHQzPHrnYLOrAVIg
         7KadA4xhbL9ZSf60n7rAg9hpX3Cc5pWTNy4N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725390022; x=1725994822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1O1ShPrP32GZ6zNKibhG+Lc7a+zlJjipIRDsNar31FQ=;
        b=JHTTenYYhEWE+sQ9N/IRfFWz1TF29JcTaiDo9VpCnOuyieXG4zpnddAWkGQdBWacKX
         ETMbvnKZBDD4DhT4NvDibILOx4mZWly9HGAStUMyIeffEXqW3h3xzwDUxUujKiY9WQI+
         c7ZiC7TpnFwLLolsAggY4MBYQUKnDmx2sBwBHDjI9rD08A5hTsfBLYtFjD4df++j93Lu
         CztZwwX9muAtdo25vCrGUbshx2f4TcABXiXAK+tGOVtc2UiPXA+wjPM2pVPPmHtQKbzp
         XGD447BlydDATeukEBD/9VHRHhNaZv090ufcyC9Zp1Q8ptBZPunQlzmiaY1AewtB0ASK
         Yyxg==
X-Forwarded-Encrypted: i=1; AJvYcCXgqVRXK1E+EQSxa2otT7VViXOCvyDIu3aNw/VbfiEvHwdcUbMonrTGDDYBihbSg4cGfO86q7jZ35exZ9JBw6h/yjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxDdsjuJM7k9YUp8NaAXiXRRz75M/suwFfKwpdPRrzyqUqmuuC
	/31Gn0p6s5I+brA0VBCJHkcJ76IGfvoKnY0brEjRGpfnrUyMi8A27jhKzY3BwfAsQLBfINXZC2f
	dbBSbtA==
X-Google-Smtp-Source: AGHT+IFZCf9sspigncv6WjVqJaXJI0QJSE58TGSmfDEPtWHNaWPaYA/2sYd3AnxOVQQB3dEIbpqMuQ==
X-Received: by 2002:a17:907:2d10:b0:a86:817e:d27a with SMTP id a640c23a62f3a-a89a38247demr851135766b.61.1725390021941;
        Tue, 03 Sep 2024 12:00:21 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989222588sm708016766b.200.2024.09.03.12.00.21
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 12:00:21 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c210e23651so6088031a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:00:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrJwJ/GOw49oBGWsy1wmc0COh9LJ7Ul8Fyelu1y84JieDPGGfZI9MGMiIRUg9u5awgW4sbS3utA0Z/91sNAXBJo9E=@vger.kernel.org
X-Received: by 2002:a05:6402:430a:b0:5c2:632e:a4e7 with SMTP id
 4fb4d7f45d1cf-5c2632ea4famr4616131a12.6.1725390021271; Tue, 03 Sep 2024
 12:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828143719.828968-1-mathieu.desnoyers@efficios.com>
 <20240828143719.828968-3-mathieu.desnoyers@efficios.com> <20240902154334.GH4723@noisy.programming.kicks-ass.net>
 <9de6ca8f-b3f1-4ebc-a5eb-185532e164e7@efficios.com> <CAHk-=wgRefOSUy88-rcackyb4Ss3yYjuqS_TJRJwY_p7E3r0SA@mail.gmail.com>
 <60d293cb-3863-41c8-868d-59c7468e270e@efficios.com>
In-Reply-To: <60d293cb-3863-41c8-868d-59c7468e270e@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Sep 2024 12:00:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wggDLDeTKbhb5hh--x=-DQd69v41137M72m6NOTmbD-cw@mail.gmail.com>
Message-ID: <CAHk-=wggDLDeTKbhb5hh--x=-DQd69v41137M72m6NOTmbD-cw@mail.gmail.com>
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

On Tue, 3 Sept 2024 at 06:42, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> If we look at perf_trace_##call(), with the conditional guard, it looks
> like the following. It is not clear to me that code duplication would
> be acceptable here.

Sure it is.

Admittedly, I think it would look a *lot* better off with that macro
creating a helper function for the common part, and then just call
that helper function in two places.

In fact, I think the existing "perf_trace_##call()" function *is* that
helper function already, and all it needs is

 (a) add the traditional double underscore (or "do_") to that function

 (b) create the wrapper function.

IOW, I think the diff would look something like this:

--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -15,7 +15,7 @@
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
 static notrace void                                                    \
-perf_trace_##call(void *__data, proto)                                 \
+__perf_trace_##call(void *__data, proto)                               \
 {                                                                      \
        struct trace_event_call *event_call = __data;                   \
        struct trace_event_data_offsets_##call __maybe_unused __data_offsets;\
@@ -53,6 +53,17 @@ perf_trace_##call(void *__data, proto)
                         \
        perf_trace_run_bpf_submit(entry, __entry_size, rctx,            \
                                  event_call, __count, __regs,          \
                                  head, __task);                        \
+}                                                                      \
+static notrace void                                                    \
+perf_trace_##call(void *__data, proto)                                 \
+{                                                                      \
+        if ((tp_flags) & TRACEPOINT_MAY_FAULT) {                        \
+                might_fault();                                          \
+                guard(preempt_notrace)();                              \
+                __perf_trace_##call(__data, proto);                    \
+                return;
         \
+        }                                                              \
+        __perf_trace_##call(__data, proto);                            \
 }

 /*

and notice how there is no actual duplicated code on a source level
now (although the compiler may obviously do the inlining and
duplication - although I think that the tp_flags are always constant,
so what actually hopefully happens is that the compiler doesn't
duplicate anything at all, and all the conditionals just go away.).

NOTE! The above patch is garbage. I did it as a "like this" patch on
my current tree, and it doesn't even have the "tp_class" thing at all,
so the patch is obviously not functional. It's just meant as a "look,
wrapper function".

In fact, I think the wrapping might even be done at a higher level (ie
maybe the whole "may_fault" shouldn't be an argument at all, but a
static part of the define, in case some event classes can take faults
and others cannot?)

I dunno. I actually think the whole "TRACEPOINT_MAY_FAULT" thing is an
incredibly ugly hack, and SHOULD NOT EXIST.

In other words - why make these incredibly ugly macros EVEN MORE UGLY
- when there is a single use-case and we sure as hell don't want to
add any more?

IOW - why not get rid of the stupid TRACE_EVENT_FN_MAY_FAULT thing
entirely, and do this trivial wrapping in the *one* place that wants
it, instead of making it look like some generic thing with an
allegedly generic test, when it is anything but generic, and is in
fact just a single special case for system call.

Yes, I know. Computer Science classes say that "generic programming is
good". Those CS classes are garbage. You want to make your code as
specialized as humanly possible, and *not* make some complicated "this
handles all cases" code that is complicated and fragile.

                            Linus
