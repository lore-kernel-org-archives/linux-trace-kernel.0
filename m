Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1DE1F3BA2;
	Mon, 25 May 2026 00:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779670698; cv=none; b=qsUD5qZXgfNUEz1KqMoOZm+/m4JCNGCsT5pLJUiBgWj0sQszfXqkxUVx9Hu3REx0sqq0lzneDLG+DG7ZIlMhvu+BOb8mk0r71D7YhyKs1wFQdjNQ0YBIyjc+qQQrGZUYUf06z4M0Fz19L7dCgISSO2hhSngys76gkgeWmEbba3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779670698; c=relaxed/simple;
	bh=VXjNEbhXEAbacbs/W/C/pP4t4zdAdjb9xU+9zwa7KCY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oGADjk41Yv2X5RzrCMV8Fmhh+/2cByAJd6ql8plwnNlj0O3SLAoHO8pJ0J6tylZBVzTXMrY/62ETq2Om6FL7sNyTntzhe6poyBHn0KZZPK1P5hcy9HvLQ7JTmYUOfAaRYnO5nS/z/KUiwZR6BdZZ/6KwRMrHAJF3EnXlMIS8gJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRXBBhGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRXBBhGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8951F000E9;
	Mon, 25 May 2026 00:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779670697;
	bh=kItyJfk/NDXzfvCw5H+FZemy71G0tyI1fLonqwJ0+DM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gRXBBhGJZn36xgPTJT6CeayHJkWlwGrSN47by2MytBFPQpCtt7F1kdZ5YQDtMuuZU
	 6+4/GqdJiMgBnSVpVNTGCAu5btnLwa1H5oSeQ8lWNagJWzAUDVWn9D+7oTIZthOg+c
	 Rjpq9tXwpbx47wPnAdFvcPBMtbSXGd4i9GSnDhkD1Zegi2G7GeUnKwv1uVuh89h/po
	 UXBFGihgJQIr7CC+Vy0nVV+9eDflEQdIsD08HB9TGWuDMz9PEY6epwprQJmkTq7OjF
	 HnBq0mciX2r40VAr7RvZjkD8j43gYIcz8nX/QqZHJsR9Sf0aeV92UgSR2Qly9v5hrO
	 3kk+MuMR6Ilkw==
Date: Mon, 25 May 2026 09:58:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yifei Chu <yifeichu24@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] tracing/kprobe: perf dynamic ustring sample can exceed
 PERF_MAX_TRACE_SIZE and WARN
Message-Id: <20260525095814.fe02302d1610005e64138e2f@kernel.org>
In-Reply-To: <CAPJnbgKc7swb2MdOuRHcLUWNX5iApK=-RVN5r6kE74XF=nPgPg@mail.gmail.com>
References: <CAPJnbgKc7swb2MdOuRHcLUWNX5iApK=-RVN5r6kE74XF=nPgPg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi

On Sun, 24 May 2026 10:44:20 -0400
Yifei Chu <yifeichu24@gmail.com> wrote:

> Hello,
> 
> Short version: I can make a kprobe/kretprobe trace event with dynamic
> ustring fetch args ask perf_trace_buf_alloc() for more than
> PERF_MAX_TRACE_SIZE. That hits WARN_ONCE(), and with panic_on_warn=1 it
> becomes a reproducible kernel panic.
> 
> The reproducers create a kprobe or kretprobe trace event with several
> ustring args pointing at a 4095-byte userspace string, open the event
> through perf_event_open(PERF_TYPE_TRACEPOINT), and trigger it. The dynamic
> payload size is then passed to perf_trace_buf_alloc():
> 
> WARN_ONCE(size > PERF_MAX_TRACE_SIZE, …)
> 
> I reproduced this through both kprobe and kretprobe events.

This also should be fixed by [1]

[1] https://lore.kernel.org/all/20260428122302.706610ba@gandalf.local.home/

But thank you for reporting.

Thanks,

> 
> Tested environment:
> 
> Linux version 7.0.9, x86_64 QEMU
> gcc 12.3.0, GNU ld 2.38
> Boot args included: panic_on_warn=1 nokaslr console=ttyS0
> 
> Kprobe result:
> 
> perf buffer not large enough, wanted 16420, have 8192
> WARNING: kernel/trace/trace_event_perf.c:405 at
> perf_trace_buf_alloc+0x111/0x160
> Kernel panic - not syncing: kernel: panic_on_warn set …
> 
> Kretprobe result:
> 
> perf buffer not large enough, wanted 16428, have 8192
> WARNING: kernel/trace/trace_event_perf.c:405 at
> perf_trace_buf_alloc+0x111/0x160
> kretprobe_perf_func+0x24b/0x750
> Kernel panic - not syncing: kernel: panic_on_warn set …
> 
> I checked current mainline source and still see PERF_MAX_TRACE_SIZE as 8192
> and the WARN_ONCE path in perf_trace_buf_alloc(). I have reproduced the
> panic on the 7.0.9 QEMU build above; I have not yet runtime-tested current
> mainline.
> 
> My expectation is that a user-defined dynamic trace payload that is too
> large for the perf trace buffer should be rejected, capped, or dropped
> without reaching WARN_ONCE().
> 
> The attached tarball has README files, both C reproducers, and the full
> QEMU logs.
> 
> Thanks,
> Chuyifei


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
