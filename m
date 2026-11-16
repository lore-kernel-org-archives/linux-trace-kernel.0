Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840525;
	b=nH5biTQj28Z5BazYnUWvTeEbA+XBbVvynOye+oKl0BbkNlcF84iBfpoeRxHJ503sq1IZ
	 YBMOXbGRojsEti/NaM/97tKy2mUFRzTyHwanGalciBA7xvqh5jkV6GcrPpzst3srR6OCe
	 RaGFv4rDTBVz7Tr8//81BaQ/bzxz6MlZVV/htrBX2OhsL8BA2d0Z45KKkcMSpDriGcwMC
	 KrQy/PmGNf4TJPX4FzeCoeaEkL3rpdlbsrQjZUrzqJMPxXldq0auyrORcq4zxDT0PGTBE
	 D780f4XRYpM7dWo4ulQnHj8pOZrgcgR0B63kVyogd2drhQuCcw88fvSHII+r4REy4SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840525;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition;
	bh=pA9V8D1wG0Eyw/8znW28sdVPMMRkVzuOllQ2VtP8AA4=;
	b=ZgzcuFKnUb5BSDlp4i70yckSpTOHbweYKQOP7VQGazZYNzEtpREl2hrC+Vo5DrtKXFbK
	 WQ9x5a12KdxmIGJ9SIKeQTu86A4C+xXa7XIS2lACX7UIZio2O6KfipdEEHMwhe0R+85WG
	 hsm9VgT35DrFkzQrg478KASVRNE/NyegI52257bOCmzcNkuS5xAm+6DGtm8IgrEWfPSQr
	 +7jiX6d6lJG47j7xLW45/YMxOPfdVnjUW3uqL3FH2wwx41b07wOth4nJjePj0gLdek+d8
	 YvGPoKbYAS/OgkadiqVSXJz3mOTdTpgQyLFkOzIixGAUw8QbBbSajy6ZhrbvE+UxD+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B5mxWmSz;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54097606A884
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 14:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54097606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B5mxWmSz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794840524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pA9V8D1wG0Eyw/8znW28sdVPMMRkVzuOllQ2VtP8AA4=;
	b=B5mxWmSzaQrf6oqjd+0d82U6E3CYfU3Pc9SCZNKCaz7lyb3i1L+xxPy1jTCUPkrewl+a13
	gi4xq0QLBG6Dh+tF2VMc2epRddfGVOwITtrIwM0Xt0I++dJq7Ev6CaAHvP9xswHfpgv0EX
	qQjmPzhufxLByaQ6M3AyRv879iwtFy4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-1M6OWw6JPauSGN-kCBZULQ-1; Mon,
 16 Nov 2026 09:48:37 -0500
X-MC-Unique: 1M6OWw6JPauSGN-kCBZULQ-1
X-Mimecast-MFC-AGG-ID: 1M6OWw6JPauSGN-kCBZULQ_1794840516
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05B7A18002CC;
	Mon, 16 Nov 2026 14:48:36 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 27D3141F;
	Mon, 16 Nov 2026 14:48:32 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon, 16 Nov 2026 15:48:35 +0100 (CET)
Date: Mon, 16 Nov 2026 15:48:31 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, andrii@kernel.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: avoid postponing return-probe SRCU lease
 expiration
Message-ID: <avsXv0CMBoilsB_1@redhat.com>
References: <20261115155921.260878-1-thnkslprpt@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261115155921.260878-1-thnkslprpt@gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: FL8rXgnarVMh0zu2MinE3QH9ddz5jW07MiKkbq35jSo_1794840516
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 11/15, Avi Weiss wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2052,6 +2052,9 @@ static void ri_timer(struct timer_list *timer)
>  	 */
>  	raw_write_seqcount_begin(&utask->ri_seqcount);
>
> +	/* Pair with prepare_uretprobe() to avoid a missed rearm. */
> +	smp_mb();
> +
>  	for_each_ret_instance_rcu(ri, utask->return_instances)
>  		hprobe_expire(&ri->hprobe, false);
>
> @@ -2304,7 +2307,9 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
>  	ri->next = utask->return_instances;
>  	rcu_assign_pointer(utask->return_instances, ri);
>
> -	mod_timer(&utask->ri_timer, jiffies + RI_TIMER_PERIOD);
> +	/* Pair with ri_timer() after publishing the instance. */
> +	smp_mb();
> +	timer_reduce(&utask->ri_timer, jiffies + RI_TIMER_PERIOD);

Hmm... timer_reduce() looks a bit confusing to me, perhaps

	if (!timer_pending(...))
		add_timer(...);

make more sense?

Either way, I am not sure I fully understand the memory barriers... Looks
correct, but IMO the "Pair with ..." comments do not really help.

IIUC, prepare_uretprobe() needs mb() between STORE in rcu_assign_pointer()
and LOAD in timer_pending(); while ri_timer() needs mb() between STORE in
expire_timers()->detach_timer() and LOAD in for_each_ret_instance_rcu().

Right?

Oleg.

