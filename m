Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBBF332EB5
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700824; cv=none; b=rzb0V2AamADeGKSRNqXs1TqNaf6WjvidXUSSWFc/LizVJGlpaEjEYfyAJWk/lwvn1HPBosN8VwLIEeQSBBjQ+xLPbMq0RvqwmP2d7AslXBpYZybKOfxmKVJchLJKqbtqdKVbyBv2+bclK857cv03lJXXhF+hLVanNtha1Sd6PKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700824; c=relaxed/simple;
	bh=UdTwS/dExcvw2xhiAcwl5dXsykAuEk55HCu7Gxo/fHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/1CgnLE29rx9dCx4+ZNTAfAua+ybIf7QktogVSHSMFn7l6jbNFPUqlrivTZulrrF+ZYbpvBeJX42iCTAPA+gpV+8g1kHXfz3rvjFzGzW8Qc7VB39xDgtSsnIcbYdw1+6E6c73qBvlgR5BJ1Qy/huNUiLZ3iOirXhCZ5cVANsZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I375PCkY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I375PCkY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760700821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qgJNG0+kfyblCxEFNQal2jyX2sK0ET1Tz4uKuV9Ge9k=;
	b=I375PCkYZhnGeHCCaoI3jnoPxOUF39kywQ1m8/YuQ/3f2HkzCjUAJdsnUhkMG7cSgycjv0
	w9xUhAry7VfV0MFNRdG9nSztktnwQOI94x42wXAe3tjtbCePH8WzLjw1Ga9b5fuCHkQw26
	yLlRaEoHV/ood4xKzSoXO+WdB/krPrI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-mYiih6jrOn-FzZqigFdGZg-1; Fri,
 17 Oct 2025 07:33:38 -0400
X-MC-Unique: mYiih6jrOn-FzZqigFdGZg-1
X-Mimecast-MFC-AGG-ID: mYiih6jrOn-FzZqigFdGZg_1760700817
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27C511800345;
	Fri, 17 Oct 2025 11:33:37 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.136])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 36C1419560AD;
	Fri, 17 Oct 2025 11:33:32 +0000 (UTC)
Date: Fri, 17 Oct 2025 08:33:31 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] rtla/timerlat_bpf: Stop tracing on user latency
Message-ID: <6iu2f3qpxuqsjq4vxygokmmppiuwj32kkxiv57ir524h2xgsxp@wmf5d4vckgvl>
References: <20251006143100.137255-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006143100.137255-1-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Oct 06, 2025 at 04:31:00PM +0200, Tomas Glozar wrote:
> rtla-timerlat allows a *thread* latency threshold to be set via the
> -T/--thread option. However, the timerlat tracer calls this *total*
> latency (stop_tracing_total_us), and stops tracing also when the
> return-to-user latency is over the threshold.
> 
> Change the behavior of the timerlat BPF program to reflect what the
> timerlat tracer is doing, to avoid discrepancy between stopping
> collecting data in the BPF program and stopping tracing in the timerlat
> tracer.
> 
> Cc: stable@vger.kernel.org
> Fixes: e34293ddcebd ("rtla/timerlat: Add BPF skeleton to collect samples")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat.bpf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/tracing/rtla/src/timerlat.bpf.c b/tools/tracing/rtla/src/timerlat.bpf.c
> index 084cd10c21fc..e2265b5d6491 100644
> --- a/tools/tracing/rtla/src/timerlat.bpf.c
> +++ b/tools/tracing/rtla/src/timerlat.bpf.c
> @@ -148,6 +148,9 @@ int handle_timerlat_sample(struct trace_event_raw_timerlat_sample *tp_args)
>  	} else {
>  		update_main_hist(&hist_user, bucket);
>  		update_summary(&summary_user, latency, bucket);
> +
> +		if (thread_threshold != 0 && latency_us >= thread_threshold)
> +			set_stop_tracing();
>  	}
>  
>  	return 0;
> -- 
> 2.51.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

