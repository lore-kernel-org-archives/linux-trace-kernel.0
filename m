Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B97014900E;
	Thu,  7 Nov 2024 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995453; cv=none; b=NXFhQ/xLt1aZLa9cFTk3p736kkoKVlvbWTbs558hMoNyG8NiUOG5o6f9m8UgiJhROYmiVCR2zr8OQzULQYnOUSRQ/XDG5WNN5Ik0szU8xtP5UFpcLiSs/w150U/tTsc/89RUkR2dB9/qZzebG724cE9YyQdDwkvcMVTd77E1ev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995453; c=relaxed/simple;
	bh=rWV077YyvpOMQ6dMh83h3h/ihTvv+qk0h/mTZUp6CXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cny5EAXE51j+LBRTvdKzghXJaCfCT1z4fKwTMiGXgMfvCBNwQ3/btQcA0dfOXoE86bPPLhOBuoXaW8oRdrYWiNmxavaGxYSI5soK2lg+ApEPC/XAWcUqzeUcZtPn5mMsfTJBpgwGvtLFTlMuLxiwXc/sVyX1NVSxrTz0/k337F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBBEC4CECD;
	Thu,  7 Nov 2024 16:04:11 +0000 (UTC)
Date: Thu, 7 Nov 2024 11:04:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Dmitry
 Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH v2 1/2] tracing: Add task_prctl_unknown tracepoint
Message-ID: <20241107110417.7850d68f@gandalf.local.home>
In-Reply-To: <3326c8a1-36c7-476b-8afa-2957f5bd5426@efficios.com>
References: <20241107122648.2504368-1-elver@google.com>
	<5b7defe4-09db-491e-b2fb-3fb6379dc452@efficios.com>
	<CANpmjNPWLOfXBMYV0_Eon6NgKPyDorTxwS4b67ZKz7hyz5i13A@mail.gmail.com>
	<3326c8a1-36c7-476b-8afa-2957f5bd5426@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2024 10:52:37 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> I suspect you base the overhead analysis on the x86-64 implementation
> of sys_enter/exit tracepoint and especially the overhead caused by
> the SYSCALL_WORK_SYSCALL_TRACEPOINT thread flag, am I correct ?
> 
> If that is causing a too large overhead, we should investigate if
> those can be improved instead of adding tracepoints in the
> implementation of system calls.

That would be great to get better, but the reason I'm not against this
patch is because prctl() is not a normal system call. It's basically an
ioctl() for Linux, and very vague. It's basically the garbage system call
when you don't know what to do. It's even being proposed for the sframe
work.

I understand your sentiment and agree. I don't want any random system call
to get a tracepoint attached to it. But here I'd make an exception.

-- Steve

