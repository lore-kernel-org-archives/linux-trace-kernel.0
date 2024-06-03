Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1443580603;
	Mon,  3 Jun 2024 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451332; cv=none; b=PfSAI6uV8FLPb37YbNluISawAUex289OHkgxKsQV40OZCWqwS4kYg0qsqvln7SnEwHNQ2GUnYHXV0g/clXhkJi6vvs6eWbdutbLvEizKYdrJ07B4OaBypuR45R7m3RxtfuTwR08IksAelYLP4ET7PoG42Od7/3oPoREM0Ev0Wso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451332; c=relaxed/simple;
	bh=O6uxIQ2+m4DWt8r05WCJpLj0L+gvfDUljJouVxNAmhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHaNYoMipW2jK8Zke3GOsXqONX6QeVcqTXaRyZ2q4vKTJVg1WJAC+sKMCxx4I+3QRXXdFtFR9y2ZptC2cCcBaIwSnZnIams1cy/AGFDXcuiuzIWfhrBtZWoR0uoUie9kzOCI8k5GKp+lwskgoYiXe5jf/jC6vgqA661acvFDBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DD5C2BD10;
	Mon,  3 Jun 2024 21:48:50 +0000 (UTC)
Date: Mon, 3 Jun 2024 17:50:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, don
 <zds100@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] tracing/fprobe: Support raw tracepoint events on
 modules
Message-ID: <20240603175001.603be0f4@gandalf.local.home>
In-Reply-To: <fbfec8d9-d0ed-4384-bbd2-dd5c1e568ed1@efficios.com>
References: <171723014778.258703.6731294779199848686.stgit@devnote2>
	<171723016594.258703.1629777910752596529.stgit@devnote2>
	<fbfec8d9-d0ed-4384-bbd2-dd5c1e568ed1@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 15:50:55 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Hi Masami,
> 
> Why prevent module unload when a fprobe tracepoint is attached to a
> module ? This changes the kernel's behavior significantly just for the
> sake of instrumentation.
> 
> As an alternative, LTTng-modules attach/detach to/from modules with the
> coming/going notifiers, so the instrumentation gets removed when a
> module is unloaded rather than preventing its unload by holding a module
> reference count. I would recommend a similar approach for fprobe.

I think one major difference between fprobes and LTTng module attachment,
is that fprobes is an internal mechanism used by other utilities (like BPF).

You could have a program loaded that expects an fprobe to succeed, and may
have undefined behavior if the fprobe suddenly disappears. That is, we
don't know what is depending on that fprobe to simply disable it on module
unload.

-- Steve
