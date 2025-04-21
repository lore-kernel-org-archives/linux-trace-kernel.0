Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ABB4690;
	Mon, 21 Apr 2025 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745249956; cv=none; b=FNG+Y6sXgF8YtpFpQmGa7STcCWZhpaC1d631whSlOxuNfpVrdEkODt+yzEszB3LQR12uzI6khC5IMOse9IluHzy2eBIrx2li+E1LmP6pmIWxLpS9VycHw7f8Tdli1twCZJK61n+WPqS3FRnk1mAgy2I5qJaL2ibOGxW7xjqxOhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745249956; c=relaxed/simple;
	bh=Yu7c3yQAEBvBOch+cyaGlI6kIvYsRTdUcwGyh0W7SdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+Ij09kTdPH6IESGnriPJDvOAICN/9EKVcaJ1iXMvUFcHkvMkSYQz/FIqxmcpU4tYUnzd4WdhCa9Zk7dBTgD/5XBd8vu1qpDfh5HLC6LaGNFgRa66xFTyPP/FhuJHt1ZOX1pa6WFzP9KQcGTez/DdlAOAR5NwXIfrwY4AU0RJzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55927C4CEE4;
	Mon, 21 Apr 2025 15:39:15 +0000 (UTC)
Date: Mon, 21 Apr 2025 11:41:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 syzbot+c8cd2d2c412b868263fb@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] tracing: fix oob write in trace_seq_to_buffer()
Message-ID: <20250421114103.3c006379@gandalf.local.home>
In-Reply-To: <20250421152850.15387-1-aha310510@gmail.com>
References: <20250421152850.15387-1-aha310510@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Apr 2025 00:28:50 +0900
Jeongjun Park <aha310510@gmail.com> wrote:

> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6784,7 +6784,7 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
>  	};
>  	ssize_t ret;
>  	size_t rem;
> -	unsigned int i;
> +	unsigned int i, copy_len;

FYI, I don't care for variables to be on the same line unless they are
related. As "i" and "copy_len" are not related, the should be separate
declarations.

	unsigned int copy_len;
	unsigned int i;

>  
>  	if (splice_grow_spd(pipe, &spd))
>  		return -ENOMEM;
> @@ -6818,16 +6818,18 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
>  
>  		rem = tracing_fill_pipe_page(rem, iter);
>  
> +		copy_len = trace_seq_used(&iter->seq);

Why not have the min here?

		copy_len = min(trace_seq_used(&iter->seq), PAGE_SIZE);

??

> +
>  		/* Copy the data into the page, so we can start over. */
>  		ret = trace_seq_to_buffer(&iter->seq,
>  					  page_address(spd.pages[i]),
> -					  trace_seq_used(&iter->seq));
> +					  min(copy_len, PAGE_SIZE));
>  		if (ret < 0) {
>  			__free_page(spd.pages[i]);
>  			break;
>  		}
>  		spd.partial[i].offset = 0;
> -		spd.partial[i].len = trace_seq_used(&iter->seq);
> +		spd.partial[i].len = min(copy_len, PAGE_SIZE);

And actually, len should equal ret as that's how much was copied.

-- Steve


>  
>  		trace_seq_init(&iter->seq);
>  	}
> --

