Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE53155CA8;
	Tue, 23 Jul 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745814; cv=none; b=IN0GskSaD/92b9gnggtfF4osQNoUFn14VPZdVnrt2REqvKA1jBOJZeuJq719dAZUapG6cJbJVGrzqpkDN3hhxdpqSwknCzFmlo0jLVoeWnEK5bOgPmD0ELfmpk92ctaIsKGzuxvjDxwGAiG2PnDtKH9Lll7c48QD3clcHOzbmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745814; c=relaxed/simple;
	bh=Ejv0JS3Xt/DkboUHqrgaXHCqNAPp6TQh90Kc96zSX8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQk5Xq7162C8+3CReQv873iTZTQ01w1Pz01ufFGQOHBCrnTq8FOTggOuijCsUcFIzN+jTm9+GmQ45/q/L3gkkvWslis4ebdk9v/PCjXdrraaJACVER6+73XiXquPFr7U8TCLj1Z19j3wh+nPivLQywu7nQY/nCBANdOimwepxJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6DAC4AF0C;
	Tue, 23 Jul 2024 14:43:32 +0000 (UTC)
Date: Tue, 23 Jul 2024 10:43:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al
 Viro <viro@zeniv.linux.org.uk>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: Re: tracing: user events UAF crash report
Message-ID: <20240723104348.645bf027@gandalf.local.home>
In-Reply-To: <20240719204701.1605950-1-minipli@grsecurity.net>
References: <20240719204701.1605950-1-minipli@grsecurity.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jul 2024 22:47:01 +0200
Mathias Krause <minipli@grsecurity.net> wrote:

> Beside the obvious bug, I noticed the following (not fixing the issue,
> tho):
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 5d88c184f0fc..687ad0a26458 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -112,7 +112,7 @@ static void release_ei(struct kref *ref)
>  			entry->release(entry->name, ei->data);
>  	}
>  
> -	call_rcu(&ei->rcu, free_ei_rcu);
> +	call_srcu(&eventfs_srcu, &ei->rcu, free_ei_rcu);
>  }

This should be fixed too. Care to send a patch for this as well?

It use to need RCU but then everything was switched over to SRCU. This was
just leftover.

>  
>  static inline void put_ei(struct eventfs_inode *ei)
> @@ -735,7 +735,9 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
>  
>  	/* Was the parent freed? */
>  	if (list_empty(&ei->list)) {
> +		mutex_lock(&eventfs_mutex);
>  		cleanup_ei(ei);
> +		mutex_unlock(&eventfs_mutex);

Why do you think this is needed? The ei is not on the list and has not been
made visible. It was just allocated but the parent it was going to be
attached to is about to be freed.

>  		ei = NULL;
>  	}
>  	return ei;

Thanks,

-- Steve
