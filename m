Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732D1399;
	Thu, 13 Jun 2024 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285558; cv=none; b=tAeCfkdAwMzaYsq9ll3VbRjcEfbTj6y0td6WrN6ooOknIe/2uCDVGuTwbT/fVcL1no/ArwD3/2k4gZPP5GFqZLRT6UA4CB2QkZy9yX+jeco/Flm3zg5BUfKXZpCGMZccUjdA0jdorhWVEDC5pN1RZE6PeJs4IJGk8PuyVW/WEyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285558; c=relaxed/simple;
	bh=FKt7+UU1VxhuIQoLvrL+gX4n/vvRN0L8KoESVkjihRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcgdQi7gTKVfdDgFyYUAkUY41BDPClXfZ9qdDUJ8G4mG/4tAYuvpqE7ndT/2KbglH5q+yNqzaYFmjzy8STLA09bGAHB0zLuVoE6CTG6AckR7P7ER7S4vydW7wdDYhiIawhZHo7hmeGXmP2IeDOvuKG3SufjDYpHVOhzOhGaSa+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF3BC2BBFC;
	Thu, 13 Jun 2024 13:32:35 +0000 (UTC)
Date: Thu, 13 Jun 2024 09:32:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Chiu <andy.chiu@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alexghiti@rivosinc.com>, Zong Li <zong.li@sifive.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/8] tracing: do not trace kernel_text_address()
Message-ID: <20240613093233.0b349ed0@rorschach.local.home>
In-Reply-To: <20240613-dev-andyc-dyn-ftrace-v4-v1-2-1a538e12c01e@sifive.com>
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
	<20240613-dev-andyc-dyn-ftrace-v4-v1-2-1a538e12c01e@sifive.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 15:11:07 +0800
Andy Chiu <andy.chiu@sifive.com> wrote:

> kernel_text_address() and __kernel_text_address() are called in
> arch_stack_walk() of riscv. This results in excess amount of un-related
> traces when the kernel is compiled with CONFIG_TRACE_IRQFLAGS. The
> situation worsens when function_graph is active, as it calls
> local_irq_save/restore in each function's entry/exit. This patch adds
> both functions to notrace, so they won't show up on the trace records.

I rather not add notrace just because something is noisy.

You can always just add:

 echo '*kernel_text_address' > /sys/kernel/tracing/set_ftrace_notrace

and achieve the same result.

-- Steve
