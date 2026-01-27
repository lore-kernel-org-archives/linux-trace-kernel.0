Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240AB22256F;
	Tue, 27 Jan 2026 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769502951; cv=none; b=ObP/vWAM8DOqtU4p5/Xhy1xR1i8YpLZyUfBtjRo0aGB2jkETB+WPsP/ccK2vpPL28AkCUVaLbFjhrL5Doy5TFlfU5xy5drlDMETMS+pMcB4ayjswswW6bOaK7t+YhBkr7CtH/vOgkVFTeAsncnkHDMwADGtv6KhWQ/dnY8A2tR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769502951; c=relaxed/simple;
	bh=wBz8r1Trn1Tn1mJmxW7K8E0/ZEgGu3mnHM7QWiPEY2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q43GE5RtYeLoqweaCz0eaeCG5CFvSROYDyBTX/QwD+u8ZwBMqNGsY/3suydUcxbwupsDF8lYb/YHZ1LbMLT2z/hVbv+R53G7LwLdNp3VcfTTP7qQXeXr5rwrnwn4WO2DpgyTR2Q82Yhg47NmL6iCr5rUjt8hBkQS79Hba+JE9xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WzMfqtFG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WzMfqtFG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZcL+ZkRV9oy5GLOBN3NriL/eH1usbNp/Pj6fyDmPX6g=; b=WzMfqtFGUnQqGpox3mK5NThTNa
	n6dpXPShcfrKhOpe+0qUqNYj5yAqmrVQYHV1B4wPoNq2mb0NrkQ6mGujPLnqLf/omFlRB5uCCYPnh
	YL5cpabzmh6EDExicw9BxK8IvjMMB2aATFAuHa7PWyyELakLtiG678WBWTSJcvg0Pe7908MipYi+r
	lM5rwbKjB5B5Oz0T/D0xnHxGjQTizo219VGLYLCsCDlHX5DBbDnvqEVRtZ3XV28bUYNGv9zxh7hj3
	OYEUFBZg1IwoppnlttRHfok2+pi50lQlM3JuvUWLFI9KWocKUii6TINIvySr8j8E3hjVE6TzTU3CP
	PsNHbK8g==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkeY4-000000079zK-1Uad;
	Tue, 27 Jan 2026 08:35:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C55CC303018; Tue, 27 Jan 2026 09:35:43 +0100 (CET)
Date: Tue, 27 Jan 2026 09:35:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: add Rust files to STATIC BRANCH/CALL and
 TRACING
Message-ID: <20260127083543.GU171111@noisy.programming.kicks-ass.net>
References: <20260127-jump-label-rust-maintainers-v2-1-11b7c30b11d9@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-jump-label-rust-maintainers-v2-1-11b7c30b11d9@google.com>

On Tue, Jan 27, 2026 at 08:30:01AM +0000, Alice Ryhl wrote:
> I realized that these files were never listed in MAINTAINERS when they
> were added in commit ad37bcd965fd ("rust: add tracepoint support").
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Works for me; Steve were you taking this or should I?

In case Steve wants to route this:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
> Based on v6.19-rc1.
> ---
> Changes in v2:
> - Adjust MAINTAINERS entries as per discussion on v1.
> - Link to v1: https://lore.kernel.org/r/20260107-jump-label-rust-maintainers-v1-1-702b03482f2e@google.com
> ---
>  MAINTAINERS | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b11839cba9de1e9e43f63787578edd8c429ca39..d1bc1bd7584896c78e517f80194d5de6828298cf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25006,6 +25006,7 @@ STATIC BRANCH/CALL
>  M:	Peter Zijlstra <peterz@infradead.org>
>  M:	Josh Poimboeuf <jpoimboe@kernel.org>
>  M:	Jason Baron <jbaron@akamai.com>
> +M:	Alice Ryhl <aliceryhl@google.com>
>  R:	Steven Rostedt <rostedt@goodmis.org>
>  R:	Ard Biesheuvel <ardb@kernel.org>
>  S:	Supported
> @@ -25017,6 +25018,9 @@ F:	include/linux/jump_label*.h
>  F:	include/linux/static_call*.h
>  F:	kernel/jump_label.c
>  F:	kernel/static_call*.c
> +F:	rust/helpers/jump_label.c
> +F:	rust/kernel/generated_arch_static_branch_asm.rs.S
> +F:	rust/kernel/jump_label.rs
>  
>  STI AUDIO (ASoC) DRIVERS
>  M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> @@ -26474,6 +26478,17 @@ F:	scripts/tracing/
>  F:	scripts/tracepoint-update.c
>  F:	tools/testing/selftests/ftrace/
>  
> +TRACING [RUST]
> +M:	Alice Ryhl <aliceryhl@google.com>
> +M:	Steven Rostedt <rostedt@goodmis.org>
> +R:	Masami Hiramatsu <mhiramat@kernel.org>
> +R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> +L:	linux-trace-kernel@vger.kernel.org
> +L:	rust-for-linux@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> +F:	rust/kernel/tracepoint.rs
> +
>  TRACING MMIO ACCESSES (MMIOTRACE)
>  M:	Steven Rostedt <rostedt@goodmis.org>
>  M:	Masami Hiramatsu <mhiramat@kernel.org>
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20260107-jump-label-rust-maintainers-17040992e7db
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 
