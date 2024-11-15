Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505F81C07E6;
	Fri, 15 Nov 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677235; cv=none; b=NdflypfgH5aioa0sWwyKkcnglMS42cB99Av7VY1cCvef68QfxprmoIuNT5D0pgVvU6YWO7zqyItov5yH6LSqjW7BqrxYDJ2L7WZzZZI9sjBQ6RTcYIv2aogawKetUjns8XSTZEmreSdIOnPcgTlCFQIVFArNU/xMTp5m7Gy7s0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677235; c=relaxed/simple;
	bh=t4T2XHdtaRZDeVjyalXTBY+pLv2dFJNSc9eDjmvyR60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CiLRLkjrPEJE1aUIRogN3af5BbQKGsRVn6OI3lltB9iirUNClMdU8HdkzQInc9s2H2104qqzWMCWFW9BEhpWZDyiU2ZgwkQaszgck1wInkHHpeMlpa69MD4BRdf6lMZcZaV9nmUkyCdcwGs6xok1tVuMaM1N5j7LjoObClpWnyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF660C4CECF;
	Fri, 15 Nov 2024 13:27:13 +0000 (UTC)
Date: Fri, 15 Nov 2024 08:27:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Dmitry
 Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 1/2] tracing: Add task_prctl_unknown tracepoint
Message-ID: <20241115082737.5f23e491@gandalf.local.home>
In-Reply-To: <CANpmjNPuXxa3=SDZ_0uQ+ez2Tis96C2B-nE4NJSvCs4LBjjQgA@mail.gmail.com>
References: <20241108113455.2924361-1-elver@google.com>
	<CANpmjNPuXxa3=SDZ_0uQ+ez2Tis96C2B-nE4NJSvCs4LBjjQgA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 13:00:00 +0100
Marco Elver <elver@google.com> wrote:

> Steven, unless there are any further objections, would you be able to
> take this through the tracing tree?
> 
> Many thanks!

This isn't my file. Trace events usually belong to the subsystems that
use them. As this adds an event to kernel/sys.c which doesn't really have
an owner, then I would ask Andrew Morton to take it.

-- Steve
