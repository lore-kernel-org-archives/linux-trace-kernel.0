Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493D7215009;
	Thu,  7 Nov 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994728; cv=none; b=DlQPWjZuBFubCSauL8jIerMy7ymlYH8xiLosPVWYPHwGMJuWF3NoKorM7GL+JtJ8pbpmiNFm2i3QgN2n/kasW+V26uwRgmY5MEBtXdJXrerjjG7n/l3Jl262neYz7rhaD8TMCaGPYCplSzgKb5eKnCjzlHa6SJ7UtcHaezeXmhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994728; c=relaxed/simple;
	bh=rzHw7h3FqPIbEuZPFVQQ+0e+1YTCpOWbB2QLfeOTCH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8qLx4hVC7ZNRnIyGg0NNqEIX/IiW4kobij0DfZ0tW3YAsDtpOlVaUL1FM1UjwNCS/3u9ZS8XjSFYkeog/EWrdvpjCyOhpLnBceKdvKKOwwUKdwq6W6arfU2oAkn6mtlomUxsyUrV79dDpAUhiqqy1aAIy7VCV4QyL9yT1LZPng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3387C4CECC;
	Thu,  7 Nov 2024 15:52:05 +0000 (UTC)
Date: Thu, 7 Nov 2024 10:52:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Marco Elver <elver@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Kees Cook
 <keescook@chromium.org>, Masami Hiramatsu <mhiramat@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Dmitry
 Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH v2 1/2] tracing: Add task_prctl_unknown tracepoint
Message-ID: <20241107105211.3275831b@gandalf.local.home>
In-Reply-To: <CANpmjNPWLOfXBMYV0_Eon6NgKPyDorTxwS4b67ZKz7hyz5i13A@mail.gmail.com>
References: <20241107122648.2504368-1-elver@google.com>
	<5b7defe4-09db-491e-b2fb-3fb6379dc452@efficios.com>
	<CANpmjNPWLOfXBMYV0_Eon6NgKPyDorTxwS4b67ZKz7hyz5i13A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2024 16:46:47 +0100
Marco Elver <elver@google.com> wrote:

> > My concern is that we start adding tons of special-case
> > tracepoints to the implementation of system calls which
> > are redundant with the sys_enter/exit tracepoints.
> >
> > Why favor this approach rather than hooking on sys_enter/exit ?  
> 
> It's __extremely__ expensive when deployed at scale. See note in
> commit description above.

Agreed. The sys_enter/exit trace events make all syscalls go the slow path,
which can be quite expensive.

-- Steve
