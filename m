Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC37139D;
	Sat, 31 May 2025 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748722578; cv=none; b=mhWuPTKw9XpZrz1SdnioWWFhNDSrTepmihWv5h7MhFxGHaMsnaAs7TU1c5L7KelgZk7TiygQL/eLkk0NhbqP+rlJGviUhVMR45jnhWjxuxrDmzC/BU/sKCw2P732nQjh4ZB9C8YybTO09r4nzkTzBxU3u0ZnMPtvjfx4TjiFImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748722578; c=relaxed/simple;
	bh=hFKWR9920oP07kYrAIiRmQsB0MK4P35TpSB16jHkzS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpVF5A5e48B7nuMR1+dIC/OMkj+wKpmJch1rkT3+392d9gPFW5MiVOo2UhXo2MmsQuJsdQMxz+d8GpRvDmfgijFvf3rRO31s80ADWES7sbRYKrM213S8UtqQSDqdeSFweJVCH0UUPZlXwt7AG8+r20boMuP9FJBxMldu6XJfpUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6707BC4CEE3;
	Sat, 31 May 2025 20:16:16 +0000 (UTC)
Date: Sat, 31 May 2025 16:17:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: [PATCH] x86/fpu: Remove unused trace events
Message-ID: <20250531161723.1ea6a41c@gandalf.local.home>
In-Reply-To: <20250529131024.7c2ef96f@gandalf.local.home>
References: <20250529131024.7c2ef96f@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Can I get an acked-by, and I'll pull this in through my tree (with the
other patches that remove unused events)?

Thanks,

-- Steve


On Thu, 29 May 2025 13:10:24 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The following trace events are not used and defining them just wastes
> memory:
> 
>   x86_fpu_before_restore
>   x86_fpu_after_restore
>   x86_fpu_init_state
> 
> Simply remove them.
> 
> Link: https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.home/
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  arch/x86/include/asm/trace/fpu.h | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
> index 0454d5e60e5d..721b408d9a67 100644
> --- a/arch/x86/include/asm/trace/fpu.h
> +++ b/arch/x86/include/asm/trace/fpu.h
> @@ -44,16 +44,6 @@ DEFINE_EVENT(x86_fpu, x86_fpu_after_save,
>  	TP_ARGS(fpu)
>  );
>  
> -DEFINE_EVENT(x86_fpu, x86_fpu_before_restore,
> -	TP_PROTO(struct fpu *fpu),
> -	TP_ARGS(fpu)
> -);
> -
> -DEFINE_EVENT(x86_fpu, x86_fpu_after_restore,
> -	TP_PROTO(struct fpu *fpu),
> -	TP_ARGS(fpu)
> -);
> -
>  DEFINE_EVENT(x86_fpu, x86_fpu_regs_activated,
>  	TP_PROTO(struct fpu *fpu),
>  	TP_ARGS(fpu)
> @@ -64,11 +54,6 @@ DEFINE_EVENT(x86_fpu, x86_fpu_regs_deactivated,
>  	TP_ARGS(fpu)
>  );
>  
> -DEFINE_EVENT(x86_fpu, x86_fpu_init_state,
> -	TP_PROTO(struct fpu *fpu),
> -	TP_ARGS(fpu)
> -);
> -
>  DEFINE_EVENT(x86_fpu, x86_fpu_dropped,
>  	TP_PROTO(struct fpu *fpu),
>  	TP_ARGS(fpu)

