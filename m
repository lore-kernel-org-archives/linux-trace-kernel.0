Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAAC199920;
	Tue,  7 Jan 2025 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290857; cv=none; b=IWzMdFcjnnLZ91nL+rftbuV40mG/nzaLimcV9g7GzFAKKNv2icp9LuyawlYLpaj02PH9O5ZLsr1KOth5IF5b4ukBdvU/DHVcGrffIfiRMAiHDSsn6rMBfFZa3uuf9XneT2IPKUenQRuh1VLT4mE7YhHEcIWwJqh5P1n4TnTSces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290857; c=relaxed/simple;
	bh=PHt57ooON+08o2Qc1ie8Evdp2XaFqguYJfKXq7ORGJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHTCpxGwLQMLb9vKKb7Flumo6RY9XbA7y4zH/ihmlP8XrEeToBaOnIxFJMj+2w2QP+DWPTLAUbqSyIu5tKbwD3aIt2CHG4Jz7a2eUoZ0Gh8kccI1Xudacb9ndeShFYagG5hwpOUDrA48Owr/U5T/KHTmuaKScA5MPpL1fukvT2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F360EC4CED6;
	Tue,  7 Jan 2025 23:00:55 +0000 (UTC)
Date: Tue, 7 Jan 2025 18:02:24 -0500
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
Message-ID: <20250107180224.54c3d3c6@gandalf.local.home>
In-Reply-To: <b108b7edec16444ab04da770c796c60c@huawei.com>
References: <20250102174317.1594-1-shiju.jose@huawei.com>
	<20250106122204.0f16cb58@gandalf.local.home>
	<edd0ebb243684fc0a14e8974c8dabf8a@huawei.com>
	<20250106171150.4d3da6e5@gandalf.local.home>
	<b108b7edec16444ab04da770c796c60c@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 11:04:57 +0000
Shiju Jose <shiju.jose@huawei.com> wrote:

> Please find attached format file, which might have failed to parse because of the
> unsupported formats in the libtraceevent you mentioned in the following thread.
> https://lore.kernel.org/lkml/20241127104132.6c1729e1@gandalf.local.home/#t    
> 
> Please find the improvement in the libraceevent which I mentioned for not returning error
> when parsing failed,
> ===========================================
> diff --git a/src/event-parse.c b/src/event-parse.c index 0427061..b9264cb 100644
> --- a/src/event-parse.c
> +++ b/src/event-parse.c
> @@ -7905,9 +7905,14 @@ __parse_event(struct tep_handle *tep,
>               const char *buf, unsigned long size,
>               const char *sys)
>  {
> -       int ret = parse_format(eventp, tep, buf, size, sys);
> -       struct tep_event *event = *eventp;
> +       int ret;
> +       struct tep_event *event;
> +
> +       ret = parse_format(eventp, tep, buf, size, sys);
> +       if (ret)
> +               return ret;
>  
> +       event = *eventp;
>         if (event == NULL)
>                 return ret; 

Actually, this is the proper patch:

diff --git a/src/event-parse.c b/src/event-parse.c
index 33ed7fb47fff..f2e50b0e8992 100644
--- a/src/event-parse.c
+++ b/src/event-parse.c
@@ -7841,7 +7841,7 @@ static enum tep_errno parse_format(struct tep_event **eventp,
 	ret = event_read_format(event);
 	if (ret < 0) {
 		ret = TEP_ERRNO__READ_FORMAT_FAILED;
-		goto event_parse_failed;
+		goto event_alloc_failed;
 	}
 
 	/*


As it's OK if it returns that it failed to parse the print format, as it
can still read the event. But if it fails to read the fields, then it is
basically useless.

-- Steve
