Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2636916436
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE011C433C7;
	Fri, 29 Sep 2023 11:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695987183;
	bh=ext+jvw1wYtQkqXLamyev8P69HV+CW6d/4Z5KiCqMTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QEOxmNpBXq8nrAg8/RoyOmmBLqY0ECrXlK6QkmYCZPBFdtNUj8vjAtiqhRLxiz6Hv
	 +vtzZReLChWzpZpzsH3MEOYzv3i9Gq29+Zs+wZH/WyKkc5xfUH1QAT0pIUu+oRDnxK
	 bOR12gEBo4TZfB80OzxrLCWjJ/HioOBE5nJHrKOiiV1pPV1NstVEgy8n1L1PFoKQuQ
	 p+xqKgpCAS5ldtY+89v9MFKEoFjhw5v0vU/ZV3fCfNxPa36nBRuSw7XOjA96/UoHld
	 2teBaiOJKqJ///DhEn4CpukRShl+iar2k1IcSg+9kbFMuh0ZC7gmsb29F5LsvFIIgB
	 JFgBkXWy9jQzg==
Date: Fri, 29 Sep 2023 20:32:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Steven Rostedt <rostedt@goodmis.org>, kernel-janitors@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/eprobe: drop unneeded breaks
Message-Id: <20230929203259.74d4ba263b3455172ef37f06@kernel.org>
In-Reply-To: <20230928104334.41215-1-Julia.Lawall@inria.fr>
References: <20230928104334.41215-1-Julia.Lawall@inria.fr>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Sep 2023 12:43:34 +0200
Julia Lawall <Julia.Lawall@inria.fr> wrote:

> Drop break after return.
> 

Good catch! This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

And

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")

> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  kernel/trace/trace_eprobe.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 72714cbf475c..03c851f57969 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -788,12 +788,9 @@ find_and_get_event(const char *system, const char *event_name)
>  		name = trace_event_name(tp_event);
>  		if (!name || strcmp(event_name, name))
>  			continue;
> -		if (!trace_event_try_get_ref(tp_event)) {
> +		if (!trace_event_try_get_ref(tp_event))
>  			return NULL;
> -			break;
> -		}
>  		return tp_event;
> -		break;
>  	}
>  	return NULL;
>  }
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
