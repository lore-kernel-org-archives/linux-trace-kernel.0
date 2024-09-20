Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E696054277;
	Fri, 20 Sep 2024 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820286; cv=none; b=o/HF/nnDTIrGSKanI1gxA5zWfJrnNBnED25fgABiiHMJ92RG6z3blcaewFlmq5PaJv5GbXzC7Ob2AMtKHh6IE8HEUBP4BJzes5knNJqdOQYRaJ0pVPDn496O8HAMMt1uxwz230xjMrHTN+BWKkF7TDNHkJKWwhEELKq96CFWWdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820286; c=relaxed/simple;
	bh=seGYfVYfyPjidQeia0MSEPXhvPjaDb+jdaPoJ9YM/L8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a5n/uhhS2bSv5+zYcU5kyLaTP8ua66grBbe8waEuiDfhyQ8TmDh24tm39q5AhuxEUqdErARIRqKkm1Xs9oM6H9tOM9dY3+YP1jjczHl0u8Mj2OmpyE2JmztSJaaUTEbpMLMWZ4wKQ0CkMD6gAUmHLnD81MwE8uY9W1296ynXlqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKVW8JD9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKVW8JD9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DC5C4CED1;
	Fri, 20 Sep 2024 08:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726820285;
	bh=seGYfVYfyPjidQeia0MSEPXhvPjaDb+jdaPoJ9YM/L8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UKVW8JD9v7gxZ3lO5eOVhRM7Dae/E7cQ/gy5OZ/2TDHkPK6L3ccoY11FyDHU8I9oK
	 DBNgEyHPIPFAo+rYuN4gGStSeD+eT3YZNV3LKIH7pssRNPXkAVHfegsg022ejDjuvN
	 dVyz7L45+/PdN+j9Y+T/0AFCKD3pabW0L3HSfVimyaJk90mr01cBQSRBWXEZvPClhR
	 PVx2tTnro6fTEsHVeDo19mZTMhMrb60xS30VeOVtyDAHbi+ZcqrMPMf8IAWM0WmSor
	 CZ8nWn8uzP+gWaa0W3sNnsbl9/EHuWTZQ6Vv80MMR+jmXliaTg4OckmsjJIBc+YAZh
	 b++MGYJd8X2ig==
Date: Fri, 20 Sep 2024 10:17:58 +0200
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren
 <guoren@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-csky@vger.kernel.org
Subject: Re: [PATCH 0/7] add function arguments to ftrace
Message-Id: <20240920101758.60419ec040c6f0643b475720@kernel.org>
In-Reply-To: <yt9djzfgccoo.fsf@linux.ibm.com>
References: <20240904065908.1009086-1-svens@linux.ibm.com>
	<20240905111620.5211d9f8@gandalf.local.home>
	<yt9dv7z9l2zp.fsf@linux.ibm.com>
	<20240906100738.2526cffd@gandalf.local.home>
	<20240908222830.01a01b10d62d59ed73dcb676@kernel.org>
	<yt9dh6ape022.fsf@linux.ibm.com>
	<yt9djzfgccoo.fsf@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 08:03:51 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Sven Schnelle <svens@linux.ibm.com> writes:
> 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:
> >
> >> On Fri, 6 Sep 2024 10:07:38 -0400
> >> Steven Rostedt <rostedt@goodmis.org> wrote:
> >>
> >>> On Fri, 06 Sep 2024 08:18:02 +0200
> >>> Sven Schnelle <svens@linux.ibm.com> wrote:
> >>> 
> >>> 
> >>> > One thing i learned after submitting the series is that struct
> >>> > ftrace_regs depends on CONFIG_FUNCTION_TRACER, so it cannot be used
> >>> > with the graph tracer.
> >>
> >> Yeah, this is solved by my series [1].
> >>
> >> [1] https://patchwork.kernel.org/project/linux-trace-kernel/patch/172398532480.293426.13232399076477198126.stgit@devnote2/
> >>
> >> So I think this series is easier to apply after my series, which
> >> passes fgraph_regs in return handler.
> >
> > Thanks, i'll rebase my changes on top of your patches then.
> 
> While doing so i noticed that i completely forgot about arguments
> located on the stack. The current patchset tries to read from the
> current kernel stack, which is obviously wrong. So either the tracer
> needs to save the stack frame in the ringbuffer (which would be quite
> a lot of data), or ftrace only prints arguments located in registers.
> Also not nice. Opinions?

We can limit it to first 6 arguments in the ftrace_regs by default,
no need to save all of them. We can add an option to specify how
many stack entries (but it is set 0 by default).

Thank you,


> 
> Thanks
> Sven


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
