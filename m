Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942B978F58;
	Wed, 29 Jan 2025 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738110202; cv=none; b=YsXb+vsShsAH+I/UC6rcAAb3HHNzdXGIm0cT/cWxNHMsJUlxyXoQfEvirXbeamBTkP8JRhWQDQWQHcieUZlgwA3YyA8lcPqfAi0W32bz5KfAbxuQsyK7Qz7KLbLZLduYu8977yAl0d75Qi6nNvsJqMW0F3GKk1g3ncIDDx0UO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738110202; c=relaxed/simple;
	bh=HIbZ0RYEC992ijKc3xp7imXE24WUwuSk05qiAPWLCks=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tOYr59inMQEoN/cg7pgyAlHm5hZdht/2ittzNaWp5s5d6ma22Yp8MdEY0vlXUO0sIBY7Q6aOfswwNX6wv/Zd7V8aJ94GIWbRCWh9+hSZVQhAXJ6g2jceXYtQ8G/8yPXWo15VeCYnFXWS3iUX1fxhTsV9uH+x5b6aTNbJDt5auHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRpE0URS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRpE0URS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99323C4CED3;
	Wed, 29 Jan 2025 00:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738110202;
	bh=HIbZ0RYEC992ijKc3xp7imXE24WUwuSk05qiAPWLCks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TRpE0URSR9IC2Tiwbd5wy8t2hrJepOOTIGS0oRrIuKtZ4UGS5bR+Vg13mpKQr0EuC
	 kW7slKG1lSiaNd6X2L4oSCMkXN7fx/XuHzxB7dz86Um5Quj3vke64cyV+V207i50WA
	 XrUwCGqS+utT+EmpyMVf97NuRm/1s1C175W0UTASpTZzO3AsaiAAzZJA4q/vtxiCPx
	 EcKynG8VK7arpq9RrHp9UUCM25XIv/+wyW9dKC6XgvXIn2tv3+4cL19NZgRVc8Rvs0
	 F0uBqBkg02chOKTMLPHTzLttHdXyqnrc8R1Srr4TYdsqlSM9Cd5IhYVVxKh/d1HpIL
	 Yzyp5mWxo7wJQ==
Date: Wed, 29 Jan 2025 09:23:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] tracing: Introduce relative stacktrace
Message-Id: <20250129092317.c0c58eb62fa7b74133eb4d51@kernel.org>
In-Reply-To: <a7a171c4-7feb-4f26-a832-18d38a3ee973@efficios.com>
References: <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
	<a7a171c4-7feb-4f26-a832-18d38a3ee973@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 10:46:21 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2025-01-28 10:36, Masami Hiramatsu (Google) wrote:
> > Hi,
> > 
> > This introduces relative stacktrace, which records stacktrace entry as
> > the offset from _stext instead of raw address. User can enable this
> > format by setting options/relative-stacktrace.
> > 
> > Basically, this does not change anything for users who are using ftrace
> > with 'trace' text-formatted interface. This changes how each stacktrace
> > entry address is stored, so users who is using 'trace_pipe_raw' needs
> > to change how to decode the stacktrace.
> > 
> > Currently, the stacktrace is stored as raw kernel address. Thus, for
> > decoding the binary trace data, we need to refer the kallsyms. But this
> > is not useful on the platform which prohibits to access /proc/kallsyms
> > for security reason. Since KASLR will change the kernel text address,
> > we can not decode symbols without kallsyms in userspace.
> > 
> > On the other hand, if we record the stacktrace entries in the offset
> > from _stext, we can use System.map file to decode it. This is also good
> > for the stacktrace in the persistent ring buffer, because we don't need
> > to save the kallsyms before crash anymore.
> > 
> > The problem is to decode the address in the modules because it will be
> > loaded in the different place. To solve this issue, I also introduced
> > 'module_text_offsets' event, which records module's text and init_text
> > info as the offset from _stext when loading it. User can store this
> > event in the (another) persistent ring buffer for decoding.
> 
> This does not handle the situation where a module is already loaded
> before tracing starts. In LTTng we have a statedump facility for this,
> where we can iterate on all modules at trace start and dump the relevant
> information.

BTW, if we only covers the crash by watchdog or oops, we can dump the
all loaded module info at the panic code.

Thank you,



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
