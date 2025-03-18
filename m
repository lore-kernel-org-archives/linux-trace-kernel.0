Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E6381749;
	Tue, 18 Mar 2025 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742263623; cv=none; b=dxEWdSW6EW43DEYYAeRVdlYJClrfetEgcp2TUNEMKcq/+7hFEveZnOC0VSn9Q6RPnPpCmIConxOKu86f2StCv44JmDUekIuKpOdZPYczdSU0xKiUGHsngAkt+q7sIoaUt5Rz8sa0KCxq6JDKFedBE0PHT1eCOq95zF/YHh97ZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742263623; c=relaxed/simple;
	bh=Hh5p9FFcqND1o5HA7sfG6uEdJJxe4gC7Q+CWEDduIuA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NIHs3elgis+TZW4dHnfRr6AOjXpgrGROdiDVJ5kzGU6RZ+GlKhu87lahvuLMf6fNZqXYzRXstJzj+QkOeEdTysuXc84iEqp2ARmtSIa2VrqHV58uuucUv1PeLrEaUqFxL+wXq6koZ0wbA7Ij5K+Ons0aryinw53BYb/F6M6zOLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEtuFURq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEtuFURq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10768C4CEE3;
	Tue, 18 Mar 2025 02:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742263622;
	bh=Hh5p9FFcqND1o5HA7sfG6uEdJJxe4gC7Q+CWEDduIuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tEtuFURqQZLz9OMfOF9dbLuTjdbavdZdn7JpiRnxRYe5H84DM0nDW6gdx7PYBvApt
	 25OBX4H/yELojDNuJ3H9lV4srgb6aROHTYu/f7IeMQ8O8dYvvJnKKYghlxOoHYLkwE
	 7HxyGLjjGq9xWhTbHDfDYq41L+46ZuVytLUWo4A4GEZxKo5TAv5aAbN18I6Gqqujnd
	 frTpLb3D93dQa2bOLbe5yU8AnKBNr3Kq+fFfCkZZu0rHu6G1YfB/RdTpqjjmJHDbuP
	 0aF20bbJBexZO17mvTvQpBkvMfGOnqXrw60KHySE2SnTQNlodJ0vD98TRbpRwFLGb5
	 SeHvHYItzd3fw==
Date: Tue, 18 Mar 2025 11:07:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tracing: fix return value in
 __ftrace_event_enable_disable for TRACE_REG_UNREGISTER
Message-Id: <20250318110700.510f05df7e113180503fc036@kernel.org>
In-Reply-To: <20250314125725.6425-1-gpaoloni@redhat.com>
References: <20250314125725.6425-1-gpaoloni@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 13:57:25 +0100
Gabriele Paoloni <gpaoloni@redhat.com> wrote:

> When __ftrace_event_enable_disable invokes the class callback to
> unregister the event, the return value is not reported up to the
> caller, hence leading to event unregister failures being silently
> ignored.
> 
> This patch assigns the ret variable to the invocation of the
> event unregister callback, so that its return value is stored
> and reported to the caller.

Just out of curiosity, have you saw such issue? I think
event unregister should be succeeded or it warns the
fault.

> 
> Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> ---
> Sending this as RFC since I am not sure if checking the ret
> value is really needed.
> I have been mainly driven by the implementation of
> disable_trace_kprobe, disable_trace_fprobe,
> tracepoint_probe_unregister, disable_trace_eprobe that can
> return an error.
> 
>  kernel/trace/trace_events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 513de9ceb80e..8d92b271ce0d 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -790,7 +790,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
>  				clear_bit(EVENT_FILE_FL_RECORDED_TGID_BIT, &file->flags);
>  			}
>  
> -			call->class->reg(call, TRACE_REG_UNREGISTER, file);
> +			ret = call->class->reg(call, TRACE_REG_UNREGISTER, file);

This is not enough. As same as enable failure, this function needs to handle
this error to report it and break.

Thank you,

>  		}
>  		/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else clear it */
>  		if (file->flags & EVENT_FILE_FL_SOFT_MODE)
> -- 
> 2.48.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
