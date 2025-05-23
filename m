Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B1F1F3B87;
	Fri, 23 May 2025 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748035690; cv=none; b=IcutdnHMBduvepHJLL65KoGctjCSHDOKnoslacLI/YtN3VLfByv1umvaN1AFBKHCK+3DoF8ky48GNH1cNbGasRDxFOM6SuLNcEWZNCeW65KfzHKXhIKPEK/mBF2PSa1IRpLVS/v3ZrHyxafe9/utoFvydCMSZ243t0y/HKQBNIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748035690; c=relaxed/simple;
	bh=USlj8qHFdcuihLb7PKYsyoiTFuu/IQ7ZLoTDyKwO35E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRxE1+lB5EvFUK/dNBi8owu/pH+XKH9nIlh5BYt2CI/zZyuXQXeTptXMokDfms0LmhJXaJufGjXr+I0FmGE0SzLlncqOA7auurh3kDH2KjPhX6IJp77X6Jj8zBjECY5z5y5oLtOI2STP5dTxOBt34Twk3Zf6XmfMXEaKoZoWnC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA480C4CEE9;
	Fri, 23 May 2025 21:28:08 +0000 (UTC)
Date: Fri, 23 May 2025 17:28:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: ring_buffer: Rewind persistent ring
 buffer when reboot
Message-ID: <20250523172857.02ab4a75@gandalf.local.home>
In-Reply-To: <20250523165425.0275c9a1@gandalf.local.home>
References: <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
	<174792928413.496143.17979267710069360561.stgit@mhiramat.tok.corp.google.com>
	<20250523165425.0275c9a1@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 16:54:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I think we also need this:
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 7d837963dd1e..456efebc396a 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3638,6 +3638,9 @@ rb_move_tail(struct ring_buffer_per_cpu *cpu_buffer,
>  
>  	rb_reset_tail(cpu_buffer, tail, info);
>  
> +	/* The new page should have zero committed */
> +	rb_init_page(next_page->page);
> +
>  	/* Commit what we have for now. */
>  	rb_end_commit(cpu_buffer);
>  	/* rb_end_commit() decs committing */

No we don't need it ;-)

I'm looking deeper into the code and we have this:

		/*
		 * No need to worry about races with clearing out the commit.
		 * it only can increment when a commit takes place. But that
		 * only happens in the outer most nested commit.
		 */
		local_set(&next_page->page->commit, 0);

When the tail page gets moved.

-- Steve
