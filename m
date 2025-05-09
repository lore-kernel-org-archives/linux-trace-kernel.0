Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B4C262FC9;
	Fri,  9 May 2025 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746829109; cv=none; b=l+D4TgtDVRpt+/1RR0wcr12bU14Wt5O7tmwiBNYwXpPcuNxRnMtHOmQ2VS9BoayobUUlBFb6Kc6XlR4ItwRffQ6eCN9quXonH4qjBtYWeBsNEHOTuFcLMRg+GmdKIlktoPX1RL2+Jr5+rrAWfnNpXBFWlOWeY4yb5prBJGfFzHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746829109; c=relaxed/simple;
	bh=dWjmlNsJglpptDDu7d3f3DTdCJ1+813rPDpe4IWz4q0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bR420TeTsrFYpxhU9vzzvrivw3P+9hu/eEDLNWt3Gz5R9tb4gcXYo1TTJV8KLazUVxVIRtXKFM58l7gRo85SZAbQkRqhgHHbGOpP7sT0lBY7TdT79tHBNBnnYCz100sVQw/IkA8311vSqxvwrWEDgALq0Yd5sBYd6fr/6aV9qOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MItuExzS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MItuExzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC38C4CEE4;
	Fri,  9 May 2025 22:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746829109;
	bh=dWjmlNsJglpptDDu7d3f3DTdCJ1+813rPDpe4IWz4q0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MItuExzSdwpOvwq80OgT/IJnnMHpfUI3pEdMsJP/vQr4CmeGy+ZyBpHtpazoK00EM
	 j58XPipTX9PccxAcBpDoUjHGAbO48uvfmaRW7LADOz85VjGC5zsTHdvGUyRkxk+KVC
	 Nj/WTuRsTLpwqinQRtrUvks1LQHcEGXYfLjkU1Ge2VOTYNKAUMEta6yaBCj8KT21ck
	 KIh/7gmjBFom/75DjKt/h1bFlNL2XNeinlubFs2RHd1I62ofzgRb1S+JyqAtet7Ydt
	 2PrJqIeFagQI1HA0Pxs/hjnjSX4gPx5xJYjBXpDiQAEAQAkfeLaY58h8NqWGilF45Y
	 0bYgaEKEA0/Nw==
Date: Sat, 10 May 2025 07:18:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: paulcacheux@gmail.com
Cc: Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: add missing trace_probe_log_clear for
 eprobes
Message-Id: <20250510071825.7311dd26183478e9e2c7855d@kernel.org>
In-Reply-To: <20250502-fix-trace-probe-log-race-v2-1-511ecc1521ec@gmail.com>
References: <20250502-fix-trace-probe-log-race-v2-0-511ecc1521ec@gmail.com>
	<20250502-fix-trace-probe-log-race-v2-1-511ecc1521ec@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 May 2025 15:15:52 +0200
Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org> wrote:

> From: Paul Cacheux <paulcacheux@gmail.com>
> 
> Make sure trace_probe_log_clear is called in the tracing
> eprobe code path, matching the trace_probe_log_init call.
> 
> Signed-off-by: Paul Cacheux <paulcacheux@gmail.com>

Looks good to me.

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Cc: stable@vger.kernel.org

Thank you,

> ---
>  kernel/trace/trace_eprobe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index c08355c3ef32b4124ac944d7e3a03efb66492269..916555f0de811f03feed9d923c63078b0e4c993b 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -969,10 +969,13 @@ static int __trace_eprobe_create(int argc, const char *argv[])
>  			goto error;
>  		}
>  	}
> +	trace_probe_log_clear();
>  	return ret;
> +
>  parse_error:
>  	ret = -EINVAL;
>  error:
> +	trace_probe_log_clear();
>  	trace_event_probe_cleanup(ep);
>  	return ret;
>  }
> 
> -- 
> 2.49.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
