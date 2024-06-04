Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974F33F6;
	Tue,  4 Jun 2024 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518863; cv=none; b=mlFx48IfEEW6qoZybIEwxA2/r5Yxhr+8oAmoNVN6R/p2fClvlemBysuRK6AYuiAYnnk9koMG3pKyqPB42UWI+Wq6+FrKyqoItzL0Yk3OZMuat6znFq8e6s0kF0Iw0Geowit/j1cB/mnevQ53fJe1XCZRaIwsx8gbkwIDFm8EiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518863; c=relaxed/simple;
	bh=7D7T22hQGM8W37qBr4mMHw1mBEwnwhMEDU/ROlDpLas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxycQyELaUBvTvhXE2gPgRjSPXYSDYGQG6PHhx+c41fy8ZYtom+TaVRg7B1kkOzrlkQk6S9jDtA7Tgv1aKHzTjxaXgmEyX5nXNyNqA8p5yUvZwqNAxL3IM5deqVh/5R/M0jRVwIfP2anUj5HJlD7jSsyBLSIw0a3Bf5qsg/2iJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090D2C2BBFC;
	Tue,  4 Jun 2024 16:34:21 +0000 (UTC)
Date: Tue, 4 Jun 2024 12:34:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, don
 <zds100@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] tracing/fprobe: Support raw tracepoint events on
 modules
Message-ID: <20240604123418.22e16e97@gandalf.local.home>
In-Reply-To: <419b80da-9cbf-4bb2-aabb-dc04f0fb0f37@efficios.com>
References: <171723014778.258703.6731294779199848686.stgit@devnote2>
	<171723016594.258703.1629777910752596529.stgit@devnote2>
	<fbfec8d9-d0ed-4384-bbd2-dd5c1e568ed1@efficios.com>
	<20240604084955.29b9440687522a1347e0e7cd@kernel.org>
	<419b80da-9cbf-4bb2-aabb-dc04f0fb0f37@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 11:02:16 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> I see.
> 
> It looks like there are a few things we could improve there:
> 
> 1) With your approach, modules need to be already loaded before
> attaching an fprobe event to them. This effectively prevents
> attaching to any module init code. Is there any way we could allow
> this by implementing a module coming notifier in fprobe as well ?
> This would require that fprobes are kept around in a data structure
> that matches the modules when they are loaded in the coming notifier.

The above sounds like a nice enhancement, but not something necessary for
this series.

> 
> 2) Given that the fprobe module going notifier is protected by the
> event_mutex, can we use locking rather than reference counting
> in fprobe attach to guarantee the target module is not reclaimed
> concurrently ? This would remove the transient side-effect of
> holding a module reference count which temporarily prevents module
> unload.

Why do we care about unloading modules during the transition? Note, module
unload has always been considered a second class citizen, and there's been
talks in the past to even rip it out.

-- Steve
