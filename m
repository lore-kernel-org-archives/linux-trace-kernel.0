Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133948;
	b=kce6u3FENB6SCGqIvNL6PcdYDq2QUIQjUw6k4L69bfoEmlDyo/YRH1lsVO8nb4y7FFxg
	 jBrKWmBeel5qJpOCX+vQmnfrHHe9K/2kPwIUcASviyKlpJdt5ny5ovpVS2R0Yg2tAiTNM
	 TpTG010ClS6+/52ZeRFE93V7oKg+ugRxCi38e0G/zHQ17SA/JrhDO5d49dq8FYFnRp9Ua
	 RAt3TWlp1a3xpL8/LddxAOFk7j4z29Haz6BQ3k4tfTIw6aaVqXv27fV6phpMsFObN2oyW
	 XY4h5lN97XtKoFI4Zg+HRs5Mm2oSK+vNK5uZ6AoMDRh7IAvUFhbqT1nMkfBeDuOw1hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133948;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gj7Je4CrzT0T0KyxS5M8XIGmgWUPZtJshcrvc9//UF0=;
	b=HC6Pt8jobQAXWcro+bWDYJWoxmUCAe7IDj9WyHUfhjOJHL+tl7jPM/nt+u4c64dz7K0a
	 Y9ww/EiRxjCeqF7EIL2VJLOiwvw4JakCb/6bsVKBNxKxfW8wD72NCNBxbeMVCat06a9FU
	 JFANsuAkzb2M1eUK1LIqzyNOwv4pJdcVOJ2L9KJsYYRLlU3xfVBPefVithESYEZEpWAup
	 fCtHY2H01GZ2UkOOg0qX33KSJqoVh9aLK/lHJqViVRbxltgxSyqy9ALA/y0ZJ2TCDj5nE
	 lftteBXZvOOw2kcdr2qRS6F+RYU1YaQfRgqNUfm2WF/sMFBbkvOuqQFWTRv956vHUFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uoc6xTPJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AC3606A320
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 00:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uoc6xTPJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99CB1F000C4;
	Fri, 20 Nov 2026 00:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795133947;
	bh=gj7Je4CrzT0T0KyxS5M8XIGmgWUPZtJshcrvc9//UF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uoc6xTPJvPRb8cZ+GgCH/Z/RyuNC+4iVA/ciN6xE80wIwHcZphxS4Gkdd46FXJEYX
	 9zfYKwQFjT+COIecQaaQVH0zdVuXsJqhROVfvd89T0gkgQCjAL3WZs8AP7PopVPrP2
	 JBHnlKjP2K57cwc3iA5zfF+xfeaBKNpAMFMaH9drFY/gvi7Io8u2UX/Gx9tqUDfDyQ
	 T7DoCHqT07zEho/imO7HRD06uFO89e5EvNS+fMiZa63Rmh0J13FKjBRaGRHDcs8JUJ
	 vSuBZn9dGvzOPKM9Xmy1FR6f5KINlEQpoBXfIya90YdKIpZ+o6GeuBrLS7HEA0/b6R
	 GeIRHtK9fiufQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dominik Maier <dmnk@google.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, dmnk+artist@google.com
Subject: Re: [PATCH] tracing: check kallsyms_show_value() for numeric addresses in .function filter
Date: Fri, 20 Nov 2026 09:19:04 +0900
Message-ID: <undine-1795133944816620228-cb7b5dcc895c565c@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261119151901.7488cf38@gandalf.local.home>
References: <20261119192233.2664654-1-dmnk@google.com> <20261119151901.7488cf38@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Thu, 19 Nov 2026 15:19:01 -0500, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 19 Nov 2026 20:22:33 +0100
> Dominik Maier <dmnk@google.com> wrote:
> 
> > In parse_pred(), the .function filter modifier accepts either a symbol
> > name or a raw numeric kernel address (such as 0xffffffff81000000) and
> > resolves it through kallsyms_lookup_size_offset().
> > 
> > While tracefs defaults to mode 0700, task-scoped counting tracepoint
> > events can be opened via perf_event_open() under default
> > perf_event_paranoid = 2 and configured via PERF_EVENT_IOC_SET_FILTER.
> > Allowing raw numeric addresses in .function predicates without checking
> > kallsyms_show_value(current_cred()) lets callers without kallsyms
> > address visibility test whether candidate kernel addresses fall within a
> > valid symbol despite kptr_restrict.
> 
> God I HATE AI!!!
> 
> This is a perf bug, it needs to be solved in the perf code. How many times
> do I need to keep telling people with AI bots this! I think you are the
> third person to send the same patch.
> 
> The filter logic can expose kernel addresses. If perf isn't allowed to have
> access to that, then it shouldn't be allowed to filter.

Yeah, I agree that this is perf's issue. It should add
perf_event_paranoid = 3 to prohibit PERF_EVENT_IOC_SET_FILTER.
But anyway, this fix itself looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,


> 
> -- Steve
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
