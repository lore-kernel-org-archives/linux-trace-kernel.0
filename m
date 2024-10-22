Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579C2811F1;
	Tue, 22 Oct 2024 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580202; cv=none; b=Bg0I7yBHXzqEYUavo0k1F/vFlsjhAgzO8eC2XYRE8mhWSqPcBhd04BnVuc4yiK0mDRPT6iZpqi4+xqu4pOn7qgtwGBKBKNnadOrC2mjN9PpmsApKbQQ3x1GS/1bUxxiVXnvgL57U4i5AR6YzGT9S/RsKmFPknRSDnYc7B/Qm/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580202; c=relaxed/simple;
	bh=1yIlvSXY/Rv3BHmPoud25WQ741qvCQ2J1M4VqyS72VM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtGcX563G2mGj4hGPX9HSUNnXZRbDU1vO99mfx6RUrsXje+l1QJNFYUJE11EsroCVG5Og7piL6Iq4xiGa70SQA30abd8H2oYOMcwL41Vy0Jddira1t/u/8NTxqa9A7p7L8O9LVMMmpzGn4MjkPkDbzJPxvTZOQtYdmnrOuQHhSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5F2C4CEC3;
	Tue, 22 Oct 2024 06:56:40 +0000 (UTC)
Date: Tue, 22 Oct 2024 02:56:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gianfranco Trad <gianf.trad@gmail.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] fgraph: fix unused value in register_ftrace_graph()
Message-ID: <20241022025637.6852bac9@rorschach.local.home>
In-Reply-To: <20241021102428.287998-2-gianf.trad@gmail.com>
References: <20241021102428.287998-2-gianf.trad@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 12:24:29 +0200
Gianfranco Trad <gianf.trad@gmail.com> wrote:

> Coverity reports unused assignment to value ret. [1]
> ret is assigned to 0 here, but that stored value is overwritten before
> it can be used. The overwrite might happen either at line 1277, 1290 
> or eventually at line 1306. Therefore, cleanup the unused assignment.
> 
> [1] Coverity Scan, CID 1633338

What does the above mean? For such a simple change, is it really
unnecessary?

> 
> Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
> ---
>  kernel/trace/fgraph.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 41e7a15dcb50..cc2e065c1c8d 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1262,7 +1262,6 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  			return ret;
>  		}
>  		fgraph_initialized = true;
> -		ret = 0;

Not to mention that if this is to go, why not get rid of the
declaration part too? That is:

-	int ret = 0;
+	int ret;

But still, this code is about to be merged with other code where this
change may cause issues. This is such a slow path that getting rid of
the extra initialization may not be worth it.

-- Steve


>  	}
>  
>  	if (!fgraph_array[0]) {

