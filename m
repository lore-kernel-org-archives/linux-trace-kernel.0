Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5FC273F9;
	Tue,  7 Jan 2025 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291873; cv=none; b=Yo7lpQdpRbXtRC6MpYF+rX01klmhy/nCu6ammSqxPGCmN60uGUssuYuC3VB1wxGOefxX/2Ec5xtApl+UNYHYyldFz6N+V7KXu7LpK/w7IsTPGk2KzRFFJBGIxhjRGbjJoFBITyHa3/hEPZaeN4wFu8gcPGVbvqKJMAN6Ubr3yZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291873; c=relaxed/simple;
	bh=owYP10fQl8rZsHIUhxD32EEN9L1s5/7dTqpVGULZJRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGT+9eevKUChqKZ9RjGCXdbixY5wAhyO0CZFLktggDUSMklbv/IXWra86E8qc8eXt6R9+2ipmx9BebDXkkDcHoyBiQKANNRKdFCv2P27pyR31CLuy9cENV7j6piIogRIYUxAbHqequIPDzOrwD0H5JaJ8deDusjGOnE7CG78ekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722A8C4CED6;
	Tue,  7 Jan 2025 23:17:52 +0000 (UTC)
Date: Tue, 7 Jan 2025 18:19:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shiju Jose <shiju.jose@huawei.com>
Cc: "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linuxarm
 <linuxarm@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)"
 <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 1/1] tracing: Support reading trace event format file
 larger than PAGE_SIZE
Message-ID: <20250107181921.2ba79257@gandalf.local.home>
In-Reply-To: <20250107180224.54c3d3c6@gandalf.local.home>
References: <20250102174317.1594-1-shiju.jose@huawei.com>
	<20250106122204.0f16cb58@gandalf.local.home>
	<edd0ebb243684fc0a14e8974c8dabf8a@huawei.com>
	<20250106171150.4d3da6e5@gandalf.local.home>
	<b108b7edec16444ab04da770c796c60c@huawei.com>
	<20250107180224.54c3d3c6@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 18:02:24 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> diff --git a/src/event-parse.c b/src/event-parse.c
> index 33ed7fb47fff..f2e50b0e8992 100644
> --- a/src/event-parse.c
> +++ b/src/event-parse.c
> @@ -7841,7 +7841,7 @@ static enum tep_errno parse_format(struct tep_event **eventp,
>  	ret = event_read_format(event);
>  	if (ret < 0) {
>  		ret = TEP_ERRNO__READ_FORMAT_FAILED;
> -		goto event_parse_failed;
> +		goto event_alloc_failed;
>  	}
>  
>  	/*
> 
> 
> As it's OK if it returns that it failed to parse the print format, as it
> can still read the event. But if it fails to read the fields, then it is
> basically useless.

And the event you posted would still succeed. And it should succeed
actually. It just failed to parse the print format. There's a lot of events
that do as the print format is pretty much full C code, and libtraceveent
is not a full C parser. It can also call functions that it doesn't know
about which means even if it were a full C parser it would still fail to
parse.

But it does flag the event as "TEP_EVENT_FL_FAILED", and should display
"[FAILED_TO_PARSE]" when printing the generic output.

I still think failing to parse the fields is more of a critical error
though. That shouldn't happen, and if it does, it should be corrected.

-- Steve
