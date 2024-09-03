Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED7A1DC72A;
	Tue,  3 Sep 2024 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393448; cv=none; b=GitNyNq0Pq9OV5yfzZ/ZqkrRcpKcgA0cSs6l1dplAskWk06wlaPpB3FU5WBWiKIcwWGyGQMud9QgLalyIiVmKqDTkmL15tJYrkxeuxSJQiBWUcAYpvfyDOncE9QlC/Uz0n/CDzH0ioDsj/cKalOU7glr6RCUxQp/iCoITxectw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393448; c=relaxed/simple;
	bh=XbVFqom1gojzJZgGdrKVLm1/qpgi6aWtrT+hPkvqhUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqnV8idfUo6GZzcsRxtiT4DVHyd+WLF5WS26qbrWG/HYlDwy0ptrkf120f40dOODx+SYomZC25QDWTxi7ORQGVspoNHWzN0Pbie2Lavxa/Y9n5SyCb9Q6dB6TZ9h11uI6D+X8LckzfCj0kLYj+sr8DeWw/Lz8F5DfiHf3XGnpCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B466DC4CEC5;
	Tue,  3 Sep 2024 19:57:26 +0000 (UTC)
Date: Tue, 3 Sep 2024 15:58:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Chi Zhiling <chizhiling@163.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Chi
 Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH v2] eventfs: fix a null pointer access in
 eventfs_iterate
Message-ID: <20240903155825.2ec26f1a@gandalf.local.home>
In-Reply-To: <20240829085025.3600021-1-chizhiling@163.com>
References: <20240829085025.3600021-1-chizhiling@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 16:50:25 +0800
Chi Zhiling <chizhiling@163.com> wrote:

> ---
>  fs/tracefs/event_inode.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 01e99e98457d..18aae67704dc 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -642,6 +642,12 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
>  	/* Subtract the skipped entries above */
>  	c -= min((unsigned int)c, (unsigned int)ei->nr_entries);
>  
> +	mutex_lock(&eventfs_mutex);
> +	if (ei->is_freed) {
> +		mutex_unlock(&eventfs_mutex);
> +		goto out;
> +	}
> +
>  	list_for_each_entry_srcu(ei_child, &ei->children, list,
>  				 srcu_read_lock_held(&eventfs_srcu)) {
>  
> @@ -659,9 +665,12 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
>  
>  		ino = eventfs_dir_ino(ei_child);
>  
> -		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
> +		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR)) {
> +			mutex_unlock(&eventfs_mutex);
>  			goto out_dec;
> +		}
>  	}
> +	mutex_unlock(&eventfs_mutex);
>  	ret = 1;
>   out:
>  	srcu_read_unlock(&eventfs_srcu, idx);
> -- 


Nope, still not correct. See my reply to v1.

Thanks!

-- Steve
