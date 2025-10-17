Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816ED332EC5
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760703678; cv=none; b=BszQ+8HJ5A6Um2yFpVdM0GDI9+YY/ug0GfaTZ2Vngxgb3mbkVmA/R9w/uuH0/92VEx8IaDEk9hNcaMh9VW1lU4XDMTHAOcByWkr4i7WkDNp038lf/M4/H2UkTWY0JoMBKRQYjYFinEzJwkn+UJGViyUZJBBj50iD7Xw+4aYzO/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760703678; c=relaxed/simple;
	bh=hQZkWL4FYwonkErogwq5cv3EFiJxqaYBqYJl7G+MmDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dO46KJiZYgiRbUnuQcMxvyKDuMj5RrG5TP+XVsx1iubZcujEzN0k4qjMKJ2wEJ0mLP/NPXjyKCnmRgB9pZCw7mZUd6VXiaC4m5T8jBu/6GX5Suz6Mlbe6fiDTtvH6aPkQBVJFvZTRovRUY7C4QDVadbXnDmSbPE+TmNAtaX0gA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJeOsVgx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJeOsVgx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760703674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7tcPfFXHvy4uKB1MSRdLttHRim/63XVrXgZtcwVzV+g=;
	b=bJeOsVgxnXXrOW5vIsoS1L3J1kng/FJK7RKCJTXtF0qsqB0X/W2AdaU6aE8hhBynT2lwms
	SYvZVO2eeEKg36Vl2NPqzdj6hxzTOTPh5B4t4o+LNzMlXismfeuo1E5dzs3K8sl7itCXZI
	0I/GQ6CF5V0Rv6agXbKKaSts5WlTNR0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-OVLXnGEaMkObmzZab8mAaA-1; Fri,
 17 Oct 2025 08:21:11 -0400
X-MC-Unique: OVLXnGEaMkObmzZab8mAaA-1
X-Mimecast-MFC-AGG-ID: OVLXnGEaMkObmzZab8mAaA_1760703670
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 501481800451;
	Fri, 17 Oct 2025 12:21:10 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.136])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 95F3019560AD;
	Fri, 17 Oct 2025 12:21:06 +0000 (UTC)
Date: Fri, 17 Oct 2025 09:21:05 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>
Subject: Re: [PATCH v2 1/3] tools/rtla: Fix --on-threshold always triggering
Message-ID: <gwophnr3qcjvhe4wt2th5idkidjhejt2pei6swol7pwtsfpnhb@qjjwghig7wlt>
References: <20251007095341.186923-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007095341.186923-1-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Oct 07, 2025 at 11:53:39AM +0200, Tomas Glozar wrote:
> Commit 8d933d5c89e8 ("rtla/timerlat: Add continue action") moved the
> code performing on-threshold actions (enabled through --on-threshold
> option) to inside the RTLA main loop.
> 
> The condition in the loop does not check whether the threshold was
> actually exceeded or if stop tracing was requested by the user through
> SIGINT or duration. This leads to a bug where on-threshold actions are
> always performed, even when the threshold was not hit.
> 
> (BPF mode is not affected, since it uses a different condition in the
> while loop.)
> 
> Add a condition that checks for !stop_tracing before executing the
> actions. Also, fix incorrect brackets in hist_main_loop to match the
> semantics of top_main_loop.
> 
> Fixes: 8d933d5c89e8 ("rtla/timerlat: Add continue action")
> Fixes: 2f3172f9dd58 ("tools/rtla: Consolidate code between osnoise/timerlat and hist/top")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> Reviewed-by: Crystal Wood <crwood@redhat.com>
> ---
> v2:
> - add one more patch fixing a bug noticed by Crystal in context of
> the following one (doing v2 just to avoid conflicts, the first two
> patches were not changed)
> 
>  tools/tracing/rtla/src/common.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
> index 2e6e3dac1897..b197037fc58b 100644
> --- a/tools/tracing/rtla/src/common.c
> +++ b/tools/tracing/rtla/src/common.c
> @@ -268,6 +268,10 @@ int top_main_loop(struct osnoise_tool *tool)
>  			tool->ops->print_stats(tool);
>  
>  		if (osnoise_trace_is_off(tool, record)) {
> +			if (stop_tracing)
> +				/* stop tracing requested, do not perform actions */
> +				return 0;
> +
>  			actions_perform(&params->threshold_actions);
>  
>  			if (!params->threshold_actions.continue_flag)
> @@ -315,20 +319,22 @@ int hist_main_loop(struct osnoise_tool *tool)
>  		}
>  
>  		if (osnoise_trace_is_off(tool, tool->record)) {
> +			if (stop_tracing)
> +				/* stop tracing requested, do not perform actions */
> +				break;
> +
>  			actions_perform(&params->threshold_actions);
>  
> -			if (!params->threshold_actions.continue_flag) {
> +			if (!params->threshold_actions.continue_flag)
>  				/* continue flag not set, break */
>  				break;
>  
> -				/* continue action reached, re-enable tracing */
> -				if (tool->record)
> -					trace_instance_start(&tool->record->trace);
> -				if (tool->aa)
> -					trace_instance_start(&tool->aa->trace);
> -				trace_instance_start(&tool->trace);
> -			}
> -			break;
> +			/* continue action reached, re-enable tracing */
> +			if (tool->record)
> +				trace_instance_start(&tool->record->trace);
> +			if (tool->aa)
> +				trace_instance_start(&tool->aa->trace);
> +			trace_instance_start(&tool->trace);
>  		}
>  
>  		/* is there still any user-threads ? */
> -- 
> 2.51.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

