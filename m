Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9B415443D;
	Fri,  4 Oct 2024 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085026; cv=none; b=gjfBib+DE8VvG4AzWT9DCgJH/Q9Mi4Po/x4sSWOcU8vFmVOB/sssgeZMAZqEpoHjSJsVyQGG+5/mo+hJUKYU+ZaSySQjrweMkpyfJCsWwc5VGlFhzRsZaJARc9tiKsZFm2C5Lhad3i4KEHeYA3OMphRon8XrQHa4RUXeVO/o3lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085026; c=relaxed/simple;
	bh=YZy/9sPr2SQgw4DnB48EfIfY3xFsflIqeLoZgX9V7Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUip/fDXNb7sPwoxpkNII27EN5BkeAtPNb4anxad5GLWhxnzDCosRGB6D3aiWhOjNWzw66EavNfHXbu6Pdj7LHtXSr56LHtWImjjp0i1FpAYnI0GUKrW387I+KPCSozw1lAlJRLBkgWmU7x6i4UhMUVF2Sc565PAHSgG9RBmBqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE3EC4CEC6;
	Fri,  4 Oct 2024 23:37:04 +0000 (UTC)
Date: Fri, 4 Oct 2024 19:38:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mike Rapoport <mike.rapoport@gmail.com>,
 Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Hans
 de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] Documentation/tracing: Mention that
 RESET_ATTACK_MITIGATION can clear memory
Message-ID: <20241004193800.2ffd0d36@gandalf.local.home>
In-Reply-To: <20241001095734.11a67b4b@gandalf.local.home>
References: <20241001095734.11a67b4b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Jon,

This version should be good to go.

Thanks,

-- Steve


On Tue, 1 Oct 2024 09:57:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> At the 2024 Linux Plumbers Conference, I was talking with Hans de Goede
> about the persistent buffer to display traces from previous boots. He
> mentioned that UEFI can clear memory. In my own tests I have not seen
> this. He later informed me that it requires the config option:
> 
>  CONFIG_RESET_ATTACK_MITIGATION
> 
> It appears that setting this will allow the memory to be cleared on boot
> up, which will definitely clear out the trace of the previous boot.
> 
> Add this information under the trace_instance in kernel-parameters.txt
> to let people know that this can cause issues.
> 
> Link: https://lore.kernel.org/all/20170825155019.6740-2-ard.biesheuvel@linaro.org/
> 
> Reported-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/20240926130159.19e6d0e2@rorschach.local.home
> 
>  - Added more detail explanation that the system may not be able to use
>    memory to preserve the tracing ring buffer across reboots and use
>    the CONFIG_RESET_ATTACK_MITIGATION as one example.
> 
>  Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1518343bbe22..9881e3b857d0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6867,6 +6867,12 @@
>  
>  				reserve_mem=12M:4096:trace trace_instance=boot_map^traceoff^traceprintk@trace,sched,irq
>  
> +			Note, saving the trace buffer across reboots does require that the system
> +			is set up to not wipe memory. For instance, CONFIG_RESET_ATTACK_MITIGATION
> +			can force a memory reset on boot which will clear any trace that was stored.
> +			This is just one of many ways that can clear memory. Make sure you system
> +			keeps the content of memory across reboots before relying on this option.
> +
>  			See also Documentation/trace/debugging.rst
>  
>  

