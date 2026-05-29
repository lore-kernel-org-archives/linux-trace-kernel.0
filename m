Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427373E8662;
	Fri, 29 May 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068364; cv=none; b=rx2JOfJw400gjzubrvtRjNFkCES6U1Qmex1yWhrcuLcAUhc52QUg4uq8ZV5df7LCKXmD/vP7HxY7L6v96Py9kZ+NVxSqCuOVXmErDxoXyiNH8PsXRK7+xuiuCnfG/wp3XozSwHPeJe0MiKO5AJ6brn7J8/q6j/o/OOd5jZyBUpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068364; c=relaxed/simple;
	bh=5Ulg+qlvA6F9f1UE7wl/v8L9RRdTMw67Nixw501vxo8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pg6IHI2LEFBqkzuEeL8wfD4+qIp8nKctDd3fLY3WqevNoFt8KJ00pojO6x+QMPR7FCu+j5eg26vjD0ldGAMh/TNTLU5RSUV+O8GXXysytvmvn2EMUucWZuceSrOFJEXO8zchPdor836OWj0d83KSBThPrRQYeRdsSta9WWXsG98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id C6B021C0DC8;
	Fri, 29 May 2026 15:26:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id DA70F3E;
	Fri, 29 May 2026 15:25:59 +0000 (UTC)
Date: Fri, 29 May 2026 11:25:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yu Peng <pengyu@kylinos.cn>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Rosen
 Penev <rosenp@gmail.com>
Subject: Re: [PATCH] tracing: Fix field_var_str allocation errno
Message-ID: <20260529112558.63e650d5@fedora>
In-Reply-To: <20260526095022.1330107-1-pengyu@kylinos.cn>
References: <20260526095022.1330107-1-pengyu@kylinos.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 585ob3yezsf1tbfz79gbt94spumqhjrk
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: DA70F3E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/hWZdvNbjuiQWVgIYu20jPKrnKzmtvUoA=
X-HE-Tag: 1780068359-818314
X-HE-Meta: U2FsdGVkX1/r6IXEy5PefJkIe3pWcMg8JXQ1ELgcWX0Lz6yihkzBPVUShCxBLezZa7FpZMu2xmQVNaHHSEmocJ5V0QfPM1+F0vzh8xkTFZdnw2iabaypycV1IJkNkPfbySfAsft77IeGJ0z3HcZS1hV5Uki8G2Flyyb7Ss0tqIqGSbuKDSq6ZYL5V8aoK70UZZB/MI7O5pLWAXYWxSkPY4Y8dUz/xLQInPt8IrYdQqkGzt5zrhoKuSoI9biv5npIcP/WTjyCucj9S8lWjviPLpaBYuvc4E4y3GNOfEmt4On69bOF1tZUlRfavCUuUZ49+kAjqps13IPTd/Mjm/gXgknHuJt/bFdzCx0g/IYNZdo2I1vPa/Q84Q==

On Tue, 26 May 2026 17:50:22 +0800
Yu Peng <pengyu@kylinos.cn> wrote:

> hist_trigger_elt_data_alloc() returns -EINVAL when the field_var_str
> kcalloc() fails. Return -ENOMEM instead, matching the other allocation
> failures in the function.
> 
> Fixes: c910db943d35 ("tracing: Dynamically allocate the per-elt hist_elt_data array")
> Signed-off-by: Yu Peng <pengyu@kylinos.cn>
> ---
>  kernel/trace/trace_events_hist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index eb2c2bc8bc3d..17fe13e12a4f 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1680,7 +1680,7 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
>  	elt_data->field_var_str = kcalloc(n_str, sizeof(char *), GFP_KERNEL);
>  	if (!elt_data->field_var_str) {
>  		hist_elt_data_free(elt_data);
> -		return -EINVAL;
> +		return -ENOMEM;
>  	}
>  	elt_data->n_field_var_str = n_str;
>  

Thanks but this code is made obsolete by this patch that I'm pulling in:

  https://lore.kernel.org/all/20260522214407.18120-1-rosenp@gmail.com/

-- Steve
