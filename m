Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443BB2F2A;
	Wed, 14 May 2025 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747182983; cv=none; b=py91HJasTuuDpkmP2SEwdIKgisE2pMFDn3pbm+kq4VBfiKLl5AyRaSiMUxUvdgiVYshGI7LrjIKfJOf18I1yA5FMiM+6y5ScniVXSoqQqqqwSNvefadIH8jDArKNEYNYZAdvCMVxsh1SOqZpY9umpOWxQnjImIDU8H4mlwpeELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747182983; c=relaxed/simple;
	bh=Wbe+KueI8yTnS6J/mLNyv9s4kYOg3HU3ml9JB9+KqVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBYjHHL4UxHIThJV5ZOiFSouVn5rVw2XSR9+KJXXUgmwoAnHj3S/PSoA61mm9SPEUmLERtuGw4caoHPHK29bjFExxf4f2khOQHuRSa0xcm+P9VPSYY2P5q8JWumqEom5JgvUh3TzmdIaZOZoLsR2TCirEe5ALy0EJTQxBlIxyzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F92AC4CEE4;
	Wed, 14 May 2025 00:36:22 +0000 (UTC)
Date: Tue, 13 May 2025 20:36:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tracing: ring_buffer: Rewind persistent ring buffer
 when reboot
Message-ID: <20250513203647.524b1331@gandalf.local.home>
In-Reply-To: <20250513203237.0e7ff662@gandalf.local.home>
References: <174709742769.1964496.18203163435305117893.stgit@mhiramat.tok.corp.google.com>
	<20250513203237.0e7ff662@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 20:32:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -9628,6 +9636,14 @@ static void setup_trace_scratch(struct trace_array *tr,
>  
>  	/* Scan modules to make text delta for modules. */
>  	module_for_each_mod(make_mod_delta, tr);
> +
> +	/* Set trace_clock as the same of the previous boot. */
> +	if (tscratch->clock_id != tr->clock_id) {
> +		if (tracing_set_clock(tr, trace_clocks[tscratch->clock_id].name) < 0) {
> +			pr_info("the previous trace_clock info is not valid.");
> +			goto reset;
> +		}
> +	}
>  	return;
>   reset:
>  	/* Invalid trace modules */


Hmm, somehow I got your other patch in here :-D

-- Steve
