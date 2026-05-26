Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDFF17745;
	Tue, 26 May 2026 05:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779772671; cv=none; b=dodL5PB8BGT3rpMjKNzLNf1lPv3zPUOJ0KvB01mKmZl+QOKzzTxhLhFiEUW9bE3CU7B4q8jJuPXOkuIhOtT5FImR3uaP2QL3sNq4fUVTlf15n4tOYOgaTMBOws0rrADTMpX2tFY6evwBXO/1TTCFSWH1/2JC/IvtDiQkrWqmTdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779772671; c=relaxed/simple;
	bh=xcuyQvppclcTkiCM7fWEjeCnPmgvq9nnoDxeeH9lZR4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QW73RlWgNmZfHB8VBQ8cCH4fVvepDCsQ91z3jD4qV0BuAv6gA/v07uyVMBxsidiox0ekv6JDAckh4QX8SDxjuLdXpLdc+bws6iUHDOgrG7Z7V3yUR9+qrqoDpSMRn/Tr5Uk4BCWLEM5jzFjLw7Kx4Pzffh/LsUHUn18P5aGzWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuwNdh6n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuwNdh6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1103D1F000E9;
	Tue, 26 May 2026 05:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779772669;
	bh=7/3Ayc/a0D63yfyAysqJKvnBu7YUjdfYDfXsRIV6OUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GuwNdh6npTmeKQ5yX0YMP9FfbM1hGQjLJUhPMymRiQQ8XQCmxSfVlQzgVyNWoWRXV
	 DMoGwVHC9b/7wkd8CBQvmx65JlLIWTAX9djgCc5NIUZxZP5FoTXbhTywNcTcLkkV+e
	 JP/V++KIx+I5eoTLa39uTGbsd4t3s6tSiPXGHJkwPzzmRd7ScgDkINQm6VjTdFkheH
	 i2BA19MXgRD8LyS9vQkXIUIho0+CK5TZ7D3WtyxbjaSWdqt5Qojh3yWbckF3xbZqVx
	 gUPinduEMSDVCkG5I4v5KBYl9k69tUfvsuWZleW+Y9S6gohDyrKM5IyrAY4smqs15J
	 Ohhv8jfUKgJdw==
Date: Tue, 26 May 2026 14:17:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v21 0/9] ring-buffer: Making persistent ring buffers
 robust
Message-Id: <20260526141746.cf0b3c0bed5db3baf8914095@kernel.org>
In-Reply-To: <20260522170857.263969486@kernel.org>
References: <20260522170857.263969486@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 13:08:57 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> This is to make the persistent ring buffer more robust when sub-buffers
> are detected to be corrupted. Instead of invalidating the entire buffer,
> just invalidate the individual sub-buffers.
> 
> I started with Masami's patches and modified some from Sashiko reviews.
> I added a few patches to display the dropped events when the persistent
> ring buffers validation checks found sub-buffers were dropped due to being
> corrupted data.

It seems that Sashiko still marks it "Incompleted".
Maybe we need base-commit: tag in this cover mail?
I also guess that this series does not use "In-Reply-To:" but
only uses "References:" tag in the mail header. I guess
Sashiko's mail header parser missed it.

Thanks,

> 
> Changes since v20: https://lore.kernel.org/all/20260520184938.749337513@kernel.org/
> 
> - squashed the fix for max_loops in rb_iter_peek()
> 
> - Still process reader page if head page fails validation (Sashiko)
> 
> - Removed left over printk() (Masami Hiramatsu)
> 
> 
> Masami Hiramatsu (Google) (6):
>       ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
>       ring-buffer: Skip invalid sub-buffers when rewinding persistent ring buffer
>       ring-buffer: Add persistent ring buffer invalid-page inject test
>       ring-buffer: Show commit numbers in buffer_meta file
>       ring-buffer: Cleanup persistent ring buffer validation
>       ring-buffer: Cleanup buffer_data_page related code
> 
> Steven Rostedt (3):
>       ring-buffer: Have dropped subbuffers be persistent across reboots
>       ring-buffer: Show persistent buffer dropped events in trace file
>       ring-buffer: Show persistent buffer dropped events in trace_pipe file
> 
> ----
>  include/linux/ring_buffer.h |   1 +
>  kernel/trace/Kconfig        |  34 +++
>  kernel/trace/ring_buffer.c  | 543 +++++++++++++++++++++++++++++---------------
>  kernel/trace/trace.c        |   4 +
>  4 files changed, 402 insertions(+), 180 deletions(-)




-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
