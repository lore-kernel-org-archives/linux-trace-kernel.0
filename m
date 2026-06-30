Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAA43E120E;
	Tue, 30 Jun 2026 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849956; cv=none; b=l5pKg9f3M5sDkuoHTo9wUJICkw5dgvIYjBHP2rvEFap0Tvxg6FQ1jWUn1AOS6xZh4+FI1BlQCroRAaTuBPra4fj6f3RkIGv2IqJISnhxzBEzJKJoGzXkUCT7Su2CrPyFFkMQq7Qfu8JMRfqagtv85IUoeFsunrPM6q6GZfUTE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849956; c=relaxed/simple;
	bh=wXYrBA7wmIUWDjv7Lixw4Gt/wHmHBy2BN8qiBfevZt4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJcfxvfOLUx3YoCUM7y6Jec6gBe8L2J0pi8Q/ufwMwKsDAxlEL7ohklz7SojM9oV0FU9va6Y5y90o5UDsi1V6OYGtkmaiLBym5GxWBj5HmD9cyAFNVch75iUafgLNqOXmrAzKYy0FVW1q/UsgvuzVwVs9ws7E8dCPWz++z329Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id E57121C3413;
	Tue, 30 Jun 2026 20:05:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id DE02831;
	Tue, 30 Jun 2026 20:05:44 +0000 (UTC)
Date: Tue, 30 Jun 2026 16:05:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, imx@lists.linux.dev,
 dmaengine@vger.kernel.org
Subject: Re: [PATCH] fsl-edma: tracing: no ptr dereference during log output
Message-ID: <20260630160544.4211ae88@gandalf.local.home>
In-Reply-To: <20260630200022.1826420-1-martin@kaiser.cx>
References: <20260630200022.1826420-1-martin@kaiser.cx>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: g4df88d511wstq86nawngj5kw7buwgb3
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: DE02831
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18rnJGZ54CSFm+gk+R9JZcXV5ATx/xQG94=
X-HE-Tag: 1782849944-709085
X-HE-Meta: U2FsdGVkX1/3O4ac0gpDF0BpWm6kNKMSKML84U3v58SolETU9Nt/Ld+9rXAcXH4l/Vb+7aJNwPlECYMSz/1708tmCDYOBKxokGY9RzZAA5ZSaWOOMqesVS8FPtoHydlTyI4VCY+QfGO2Ui0WJMlStse5Jsl2dUOxrERq0jOsnHUB7/jSWt7/TLzNqd2EDR7Rkm7fIAXQPvLxPsG3lHkCVYhrvurwZH69O7Z65FKWVB1A7s8QspHAu5W7SgxyUMZKQG3+otwl26/RZk3s9jNbkqqSsYJzQSN6qpj/vdmNVmVfRpYjU2fcCstS/FiiIhhG/tkq4TjJGQjIiX3FxiZx+d2WbjYD6zRVGtay90Q8GZKuGNf8WdVfgssvTtGOh5Mf67rSkZAEYSkBCKqfYiJbAw==

On Tue, 30 Jun 2026 22:00:11 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> The fsl edma events store a pointer to a struct fsl_edma_engine in the
> ringbuffer and dereference it when a log entry is printed. At this time,
> the pointer may no longer be valid.

Nice catch.

> 
> Event injection can be used to trigger a crash:
> 
> $ cd /sys/kernel/tracing
> $ echo 'value = 0' > events/fsl_edma/edma_writeb/inject
> $ cat trace
> 
> The log output needs only edma->membase. Add a membase field at the end
> of the event and use the new field for log output. Keep the existing
> fields for backward compatibility.
> 

Cc: stable@vger.kernel.org

> Fixes: 11102d0c343b ("dmaengine: fsl-edma: add trace event support")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

> ---
>  drivers/dma/fsl-edma-trace.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/fsl-edma-trace.h b/drivers/dma/fsl-edma-trace.h
> index d3541301a247..45d964a3726d 100644
> --- a/drivers/dma/fsl-edma-trace.h
> +++ b/drivers/dma/fsl-edma-trace.h
> @@ -19,14 +19,16 @@ DECLARE_EVENT_CLASS(edma_log_io,
>  		__field(struct fsl_edma_engine *, edma)
>  		__field(void __iomem *, addr)
>  		__field(u32, value)
> +		__field(void __iomem *, membase)
>  	),
>  	TP_fast_assign(
>  		__entry->edma = edma;
>  		__entry->addr = addr;
>  		__entry->value = value;
> +		__entry->membase = edma->membase;
>  	),
>  	TP_printk("offset %08x: value %08x",
> -		(u32)(__entry->addr - __entry->edma->membase), __entry->value)
> +		(u32)(__entry->addr - __entry->membase), __entry->value)

Hmm, I think I should update the TP_printk checks at boot to cover this too.

-- Steve

>  );
>  
>  DEFINE_EVENT(edma_log_io, edma_readl,

