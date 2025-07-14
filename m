Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E6C253F1B;
	Mon, 14 Jul 2025 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502456; cv=none; b=eIjfw3/3eK8APTFF1ls39r/k0YP0jawa2j2INb8NVuaqaQrmd+hvBVL+HH/La7ZzEPhTN6pMU968WughhO9wGPM5a9bbSgn9h3R3/14ZjgjfqXAL7URCE9faip1ibnY9iWxCnfOL3LEAXxKbAarb+BP8nX2nuDzkseJm2C3G9mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502456; c=relaxed/simple;
	bh=R5AKHwjJS9Xpz/7MjOy0gYDrQZY4Am3NMNCU45hHez4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M+qIsoUfu57noUrCyV7apVEGu4/MIDMqYWdOTp0tOvuB/plnEMxyLyhGF7YFmJSowTRw4OdiyVDv+ultwPsYIKvZF5JHIrRp5fZuLvZxdf33Onv0TvVo/fVYlSYxM1mUw5d1c04yLLQfC2+S8LuM05lFLdds+N1deWAHsG4pooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OILxuxUe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OILxuxUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE34C4CEED;
	Mon, 14 Jul 2025 14:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752502454;
	bh=R5AKHwjJS9Xpz/7MjOy0gYDrQZY4Am3NMNCU45hHez4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OILxuxUeyKPwXk6jVhETovqsVjEL8x91OUSidvKUQtqSGkhLa7DgugP0JpG/1lVDS
	 Pox0GXi7eJ+3RZ74jgCDkaVeZ4bkZKdvVF5vZx63mcJZ4cmI6RdnPLCntjiHMxP+la
	 oZs9SHLs52qeVpM6xVQftrYT1/EQp6kPDP4DAp4M9wypQ+AdAKlEdmAJgn4lildECY
	 0zVFS5dQn9Ydz7HlWZq1D42Kl8DlwzL5pfj3JoxzIlnN6qfWxbqCU57MaxUoYOMyhw
	 OlIKi0So9ECIL6OhfTIsUsLra5SQuwl8eKFdvlXG1k2v78Wox60+J+3mACm5iXnNim
	 ueEk/yqLjB2mA==
Date: Mon, 14 Jul 2025 23:14:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Remove "__attribute__()" from the type
 field of event format
Message-Id: <20250714231412.73e511c5c9524cde5d475770@kernel.org>
In-Reply-To: <20250712103732.79c7b9e1@batman.local.home>
References: <175197567999.977073.8989204607899013923.stgit@mhiramat.tok.corp.google.com>
	<175197568917.977073.2201559708302320631.stgit@mhiramat.tok.corp.google.com>
	<20250709131107.397a3278@batman.local.home>
	<20250711143703.60a1a9a9f31a45f2000eec9d@kernel.org>
	<20250711120322.4ddb9b39@batman.local.home>
	<20250712204524.13ece418f90ea66d4bd0e598@kernel.org>
	<20250712103732.79c7b9e1@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Jul 2025 10:37:32 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 12 Jul 2025 20:45:24 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Hmm, Ok. But when I sanitized the field->type in
> > update_event_fields(), it did not work. So something
> > we missed.
> 
> Ah, it's because we test to see if the event has enums or not before
> calling update_event_fields. We need something like this:
> 
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 120531268abf..52829b950022 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3349,6 +3349,8 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
>  				}
>  				update_event_printk(call, map[i]);
>  				update_event_fields(call, map[i]);
> +			} else if (need_sanitize_field_type(__type)) {
> +				sanitize_fields(call);
>  			}
>  		}
>  		cond_resched();
> 
> 
> And have the attribute fixed in both update_event_fields() and have
> your own sanitize_fields() that just does the attribute update.

Hmm, is this called unless loading modules? It seems that the
function is only kicked from trace_module_notify() -> trace_module_add_evals() -> trace_insert_eval_map() (but if mod has any trace_evals)

This sanitizing must be done with/without the module loading even if it
had no trace_evals. Thus I think it is hard to be done in
trace_event_eval_update().

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
