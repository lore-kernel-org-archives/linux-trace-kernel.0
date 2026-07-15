Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC98480DD9
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126277; cv=none; b=NQZLrpwr7xoSwzlD3W5FAGHuRNhZOZ9MUZTS/E8eac8uTfDLC+Q/nErEng70H6uWAzjanipl+mTdy0D3ggnfGRC+lItomi0DOxxNKB6+t+e3THs2KkRxAc7F1q9yza3IoKVXfBYSBOGJelvyQqm6hbBuFLO1ZNjMMz6rdczmpdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126277; c=relaxed/simple;
	bh=17/kcwmRNECXYwNpkgG9xOYa5VM6FFSYqzV7omCzZ7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KajGOEjVNfyMJnAsZAImhnKK+MNuwTDP5dmMg1f5mj4vLzFznJ87xt5ruU4NyCHzzcBK+6fiSvP1pS0VovJKPhZUpT2AhWtO6W8+HklqskRZT0o/HvTEJ+SRXzzhnebyw+XURFv037r1uAu4lzwRtwnRBuWjw72NudQv++UKjWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T85fO7Xl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T85fO7Xl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784126274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Flle/+ZUaf8L7jQvi512ghCW0vf0okCWt9F71a7CkPE=;
	b=T85fO7Xly7TSkZt2IwkRu7FwUA7pbtrfW0CGAPBm8a++ARjzKqDCLJosrVn9FVm/0YwUoR
	eo5Nw3vPdg1Fgtq+aSsXpXMP3vmQU0Q9f5T37LILcZBPQS5E2B5KwWDcvT0+Q0C5NlTkAH
	ZgX+Lpa1yAQcnXQAykPIfVy5f3wl8Vo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-_5UHVb_2OhShwxCax-7mqQ-1; Wed,
 15 Jul 2026 10:37:49 -0400
X-MC-Unique: _5UHVb_2OhShwxCax-7mqQ-1
X-Mimecast-MFC-AGG-ID: _5UHVb_2OhShwxCax-7mqQ_1784126269
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9D5D1955DAF;
	Wed, 15 Jul 2026 14:37:48 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.81.1])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 26F6719541AA;
	Wed, 15 Jul 2026 14:37:44 +0000 (UTC)
Date: Wed, 15 Jul 2026 11:37:43 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Attila Fazekas <afazekas@redhat.com>
Subject: Re: [PATCH] rtla/timerlat_top: Fix on-threshold actions firing on
 signal
Message-ID: <alebJDUA5lxhJFTa@wcosta-defaultstring.rmtbr.csb>
References: <20260713141047.687877-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260713141047.687877-1-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: eZgzFoBW8mILwpU7qeubiiERr8nEtbsz97594KDPI3s_1784126269
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 13, 2026 at 04:10:47PM +0200, Tomas Glozar wrote:
> A bug was reported when rtla-timerlat-top tool performs on-threshold
> actions, even though no threshold was hit. This is reproduced even if no
> threshold is set at all:
> 
> $ rtla timerlat top -q -c 0 --on-threshold shell,command='echo BAD'
> BAD
>                                      Timer Latency
> ...
> 
> The bug is due to incorrect logic in timerlat_top_bpf_main_loop().
> The loop uses timerlat_bpf_wait(), the return values of which are:
> 
> - > 0 (number of ringbuffer entries): at least 1 CPU hit threshold
> - = 0: time out
> - < 0: wait was interrupted by a signal
> 
> Commit 3138df6f0cd0 ("rtla/timerlat: Exit top main loop on any non-zero
> wait_retval") changed the condition for "threshold hit" from
> "wait_reval == 1" (exactly 1 CPU hit threshold) to "wait_retval != 0",
> to fix a race where multiple CPUs hit the threshold at the same time.
> 
> That also made it incorrectly include a signal (< 0), coming from either
> duration expired (SIGALRM) or user interrupt (SIGINT).
> 
> Check for wait_retval greater than zero in the if condition to cover all
> return values correctly.
> 
> Fixes: 3138df6f0cd0 ("rtla/timerlat: Exit top main loop on any non-zero wait_retval")
> Reported-by: Attila Fazekas <afazekas@redhat.com>
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat_top.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> index 18e1071a2e242..6206a0a565ad3 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -536,7 +536,7 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *tool)
>  		if (!params->quiet)
>  			timerlat_print_stats(tool);
>  
> -		if (wait_retval != 0) {
> +		if (wait_retval > 0) {
>  			/* Stopping requested by tracer */
>  			retval = common_threshold_handler(tool);
>  			if (retval)
> -- 
> 2.55.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

