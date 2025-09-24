Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8182C2FCC0D;
	Wed, 24 Sep 2025 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724087; cv=none; b=PJmYRfmHuknWIiG2Mo22SBGS5PPSyh9zLG8775vA4o0wBGvAUr3XUcucIUC9Bae9Cw6SL4dqyV/ALhwJX33QNWdoHR3TDRb2+ZzxjL7h/fpWLLBT1soStP2+smpd/FnRYUrfzQ3C+4dEcKooRo83m8NbIuyovz7f34l8BmEFN74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724087; c=relaxed/simple;
	bh=wWBL544oJKxXMSQqb/uCHLiqP15c4e1nuwJSwjeu2xs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Z9zVhyItv9D9obzl2eQ5tnn8E+QHYzDaE6Vj+rek5/7wBqGhiHd/j47Rk/iQQBlfLxwx/KY+z4vfJsAOQeUb+jFmALGzuYxPGlbK0TfkNSSFQ9LFZXHXRqjofy9WCBDkYL7KdhXQLOFnp4nfhd6uhpgIiS4t6QseggLfzGHYYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZUzHGqQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZUzHGqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D9BC4CEE7;
	Wed, 24 Sep 2025 14:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758724087;
	bh=wWBL544oJKxXMSQqb/uCHLiqP15c4e1nuwJSwjeu2xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bZUzHGqQOuHC5/+hlL+05A1THhlwaIQsFDyRiNkvD28DKmUI5gvAWi0dEkkAzvwdD
	 +XwkYImJZhG1dKysUC6ePt3RTlhH6OLNNJQLJrBymd/JYFrQH8bJyvRVmLeKzxxcY+
	 JVoVRRepgc+2oFOhH4KwR4Z/igLv3ZA7iMaPEz4uYzQkwFYaYVMXFpx7mgbCG6E+eP
	 J5slvz/0d/FECanSSnhOJ0Zyk/V5HsgLjVSLAQttIxNtFrdV9CKvnFcb4FjPw0MKy/
	 WJz+ti1HH3EYSCQI6h4nG7faQE2rroSKBgXuEeDY51LA2M/v7yRLeVKGuicv7kZkof
	 BmozITO9QDA7A==
Date: Wed, 24 Sep 2025 23:28:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: dynevent: Add a missing lockdown check on
 dynevent
Message-Id: <20250924232803.c6b1973802b969b86bb7a481@kernel.org>
In-Reply-To: <175824455687.45175.3734166065458520748.stgit@devnote2>
References: <175824455687.45175.3734166065458520748.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I think this should be backported to stable.

On Fri, 19 Sep 2025 10:15:56 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since dynamic_events interface on tracefs is compatible with
> kprobe_events and uprobe_events, it should also check the lockdown
> status and reject if it is set.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Fixes: 17911ff38aa5 ("tracing: Add locked_down checks to the open calls of files created for tracefs")
Cc: stable@vger.kernel.org

Thanks,

> ---
>  kernel/trace/trace_dynevent.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
> index 5d64a18cacac..d06854bd32b3 100644
> --- a/kernel/trace/trace_dynevent.c
> +++ b/kernel/trace/trace_dynevent.c
> @@ -230,6 +230,10 @@ static int dyn_event_open(struct inode *inode, struct file *file)
>  {
>  	int ret;
>  
> +	ret = security_locked_down(LOCKDOWN_TRACEFS);
> +	if (ret)
> +		return ret;
> +
>  	ret = tracing_check_open_get_tr(NULL);
>  	if (ret)
>  		return ret;
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
