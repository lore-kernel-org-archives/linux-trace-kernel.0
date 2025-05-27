Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D761DFCE;
	Tue, 27 May 2025 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353621; cv=none; b=HPiqX8Mvwdm4rA2i9jDSw5JRNe8FUejBd+b5E5Cddt3b/XISvAGJaVatMP0ZK1XoR6FZA4Rojzbwv5sUVfABmvzMgCbq0wD2ulaggArH7LBOhaJK7LFTcC7RMacIctKHQ20Jtx8AwysKD/bIw3W3a9e5s099aZNKRRh+9f9wIkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353621; c=relaxed/simple;
	bh=druQO90/3aoZGZpAmzbmlfxa785/GK+2GPpQUanFOok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZNFAaqUk9HTq0apwZIwnRnbXwpZsU49bfG8frCggTN/qiVF6X0Ext8qY36Kv4P1fqxRCIjd98js0E5fIxMVsZT986dEYNvZ6BTN5zKvs51OW6wTTc3Ny+JHV3c4slRJY4atsHvMBsSXbHXRsr3hbo5CDdQWTvXh07G6iYSn2OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCFCC4CEE9;
	Tue, 27 May 2025 13:47:00 +0000 (UTC)
Date: Tue, 27 May 2025 09:47:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tracing: ring_buffer: Rewind persistent ring
 buffer when reboot
Message-ID: <20250527094757.791e8f10@gandalf.local.home>
In-Reply-To: <20250527125444.80e59e659a7f087fed3c6fc9@kernel.org>
References: <174792927500.496143.10668210464102033012.stgit@mhiramat.tok.corp.google.com>
	<174792928413.496143.17979267710069360561.stgit@mhiramat.tok.corp.google.com>
	<20250523165425.0275c9a1@gandalf.local.home>
	<20250523172857.02ab4a75@gandalf.local.home>
	<20250526120342.cdcfca9ac3c2161d48c03af5@kernel.org>
	<20250527091743.d036018195b7668aea0753c0@kernel.org>
	<20250527121549.2d40608e9463199d85bf9ba4@kernel.org>
	<20250527125444.80e59e659a7f087fed3c6fc9@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 12:54:44 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Here is what I meant. As far as I ran my test, it looks good (it prevents
> over-read by `cat per_cpu/cpu0/trace_pipe_raw`)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 5034bae02f08..de1831eb3446 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5405,6 +5405,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
>         unsigned long flags;
>         int nr_loops = 0;
>         bool ret;
> +       u64 ts;
>  
>         local_irq_save(flags);
>         arch_spin_lock(&cpu_buffer->lock);
> @@ -5423,6 +5424,18 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
>  
>         reader = cpu_buffer->reader_page;
>  
> +       /*
> +        * Now the page->commit is not cleared when it read.
> +        * Check whether timestamp is newer instead. We also don't
> +        * care the head_page is overwritten. In that case, timestamp
> +        * should be newer than reader timestamp too.
> +        */
> +       ts = cpu_buffer->head_page->page->time_stamp;
> +       if (ts < reader->page->time_stamp) {

Hmm, I think this test may be too fragile. The head_page can be moved
by the writer, and this would need to handle races.

I found an issue with commit overflow and have a couple of bugs to fix that
touches some of this code. Let's revisit after I get those fixed.

Thanks,

-- Steve



> +               reader = NULL;
> +               goto out;
> +       }
> +
>         /* If there's more to read, return this page */
>         if (cpu_buffer->reader_page->read < rb_page_size(reader))
>                 goto out;
> 

