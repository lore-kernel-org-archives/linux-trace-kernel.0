Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46A717BB6;
	Mon, 21 Apr 2025 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745245045; cv=none; b=Rvki+kY9FJuzx2Jc60wzvgBFEziw3N6ZHsScyMjwXWSx945QQvY+VHvAinDGekhPZBiwCoyKuYP15YrVN+GM6n+6AkfCyS0wz9XVGwGXs87UMIT4Jwe6Mv1KKpp+9/SbCEhPcCgN45fKojZO+Qctkag5p+prkod0IIDE+R2r/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745245045; c=relaxed/simple;
	bh=KyfHBIohRNr6+NpQwz6UuNu7wEu5lGIl5uEUC8dbxV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+cXmh43WZYx5Crv0ej13YGFBbvbZZAswXrdYquz8oLMmx0HUzKPFWuqQNKooOWpm2PXsNHs49rfKMPUdYXQ2gGCYd1rEencPUF2aK51T6v6GaN3O8ldNnCx/UQ1nSSWpvz6BZSvds/A6A5+W1rrS2xcrt6/dBrGHBj9x3Cl+LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01ADC4CEE4;
	Mon, 21 Apr 2025 14:17:24 +0000 (UTC)
Date: Mon, 21 Apr 2025 10:19:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 syzbot+c8cd2d2c412b868263fb@syzkaller.appspotmail.com
Subject: Re: [PATCH] tracing: fix oob write in trace_seq_to_buffer()
Message-ID: <20250421101912.4fd7c11a@gandalf.local.home>
In-Reply-To: <20250421134936.89104-1-aha310510@gmail.com>
References: <20250421134936.89104-1-aha310510@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 22:49:36 +0900
Jeongjun Park <aha310510@gmail.com> wrote:

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8ddf6b17215c..8ba6ea38411d 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1827,6 +1827,8 @@ static ssize_t trace_seq_to_buffer(struct trace_seq *s, void *buf, size_t cnt)
>  	len = trace_seq_used(s) - s->readpos;
>  	if (cnt > len)
>  		cnt = len;
> +	if (cnt > PAGE_SIZE)
> +		return -EINVAL;

You fixed the wrong location. The caller should know how much size the
buffer is, and that's passed in by cnt.

>  	memcpy(buf, s->buffer + s->readpos, cnt);
>  
>  	s->readpos += cnt;

The correct fix would be:

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b6e40e8791fa..c23b5ab27314 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6729,7 +6864,8 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 		/* Copy the data into the page, so we can start over. */
 		ret = trace_seq_to_buffer(&iter->seq,
 					  page_address(spd.pages[i]),
-					  trace_seq_used(&iter->seq));
+					  min(trace_seq_used(&iter->seq),
+					      PAGE_SIZE));
 		if (ret < 0) {
 			__free_page(spd.pages[i]);
 			break;

Especially since the trace_seq_to_buffer() code should be moved out of this
file and should have no idea how big the buffer passed in is.

-- Steve
