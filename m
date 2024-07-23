Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120417F;
	Tue, 23 Jul 2024 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721693473; cv=none; b=hLfl4hM/Ol1MTGNRVIugVvXpGZXJJEH6TU8esj3ieZueTIBAk/MBW/sa6dVg0WIvTDIW42ATegmXhh4cAeilsuOvt+WtF66l+4R94hPnJeQ6C+uuesIfe+gQrd0k05IzEva2w2w99xqpuYBoMnZ8DFzF1jbq5RNXw6tMQg7WnIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721693473; c=relaxed/simple;
	bh=MGKVCS0F4YI/ru64iTRyCUSnR5+KkP1YrDjKMBlfxjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Li86+ItYx0ZJtV55Rovcs061sCQXazweTxl1v0+vGftmmd0p4ZrTdaPElCnDg5TQxikOAqALYcKDrS+CD+8cB/Zvb3qD5PCt9kNh1ks3quLyW8WAbIc9bsp2MiTXMYyStxR2K5ZoliFjodRSUVogrHeWyno3ydHbPXhDfzrrWvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2A2C116B1;
	Tue, 23 Jul 2024 00:11:11 +0000 (UTC)
Date: Mon, 22 Jul 2024 20:11:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Ilkka =?UTF-8?B?TmF1bGFww6TDpA==?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al
 Viro <viro@zeniv.linux.org.uk>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info, Dan Carpenter
 <dan.carpenter@linaro.org>
Subject: Re: tracing: user events UAF crash report
Message-ID: <20240722201125.3fa6314b@gandalf.local.home>
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

> Subject: [PATCH] eventfs: Don't return NULL in eventfs_create_dir()
> 
> Commit 77a06c33a22d ("eventfs: Test for ei->is_freed when accessing
> ei->dentry") added another check, testing if the parent was freed after
> we released the mutex. If so, the function returns NULL. However, all
> callers expect it to either return a valid pointer or an error pointer,
> at least since commit 5264a2f4bb3b ("tracing: Fix a NULL vs IS_ERR() bug
> in event_subsystem_dir()"). Returning NULL will therefore fail the error
> condition check in the caller.
> 
> Fix this by substituting the NULL return value with a fitting error
> pointer.
> 
> Fixes: 77a06c33a22d ("eventfs: Test for ei->is_freed when accessing ei->dentry")
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>

This will not get into the workflow without being sent as a normal patch.

Please send it and Cc those listed in MAINTAINERS (see get_maintainers.pl).

-- Steve


> ---
>  fs/tracefs/event_inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 5d88c184f0fc..a9c28a1d5dc8 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -736,7 +736,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
>  	/* Was the parent freed? */
>  	if (list_empty(&ei->list)) {
>  		cleanup_ei(ei);
> -		ei = NULL;
> +		ei = ERR_PTR(-EBUSY);
>  	}
>  	return ei;
