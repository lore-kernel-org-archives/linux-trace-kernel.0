Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC9D2459C6
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179850; cv=none; b=nGke43SviLraWkuwWyPgpQPscv/+zHJmS7GJ2t27EydQlPgIqY6RRqt4KcaoE72j3mVMw4NwWVawHkAFmt5/jMxEV3kennGgfOLv6FTdQIxPQg0HrpM3/xLh1/tM6l9ZpgJniQDSmuQun6JiBYkqo/VBWZjP8ouBIswo0M4So04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179850; c=relaxed/simple;
	bh=3YCSoTTCO6yCWGmiep6fmJxEdfQK32XhDAT5MUPalJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8WEDBWYXB7KkY8bkrWtwwX8Uuq03C4jmZH7Oh2u6LNJaQcrHyiCRMkvAy4tSv24Tzp/cerKOepmjIa94SWyDt2I9UuWfGVKciTME9zdOG/vRFyzExlNcnRmEm9JyWfwzzeeyJDGpKCHi9KP1x7GhPd02cnCDmiAOzAF/4h7PLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTcCNyLS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTcCNyLS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762179848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=65jXSeMKSZYnQFCjONKvkkryS9O5MQBveQ8USpiQYy8=;
	b=KTcCNyLS4HgJGSuhsnyoop/pyhLVdvtKEX3KhlFnd9bZVtEzeS7djMdMOq9gVhX3AXFfF1
	/btck+Ous+ndgbed7gn2gzqkAxz/mmr9DvUACBWmqVqSumjgD/7UMO95jGWAcuVNOIINnt
	/D2NtSRfBThcEtM502asuOf43CFmcVM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-mPi14YyKOcmbQImyjdjzcQ-1; Mon,
 03 Nov 2025 09:24:05 -0500
X-MC-Unique: mPi14YyKOcmbQImyjdjzcQ-1
X-Mimecast-MFC-AGG-ID: mPi14YyKOcmbQImyjdjzcQ_1762179844
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C881B1800742;
	Mon,  3 Nov 2025 14:24:03 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.143])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 630CF1800576;
	Mon,  3 Nov 2025 14:23:59 +0000 (UTC)
Date: Mon, 3 Nov 2025 11:23:57 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 1/7] rtla/timerlat: Support tail call from BPF program
Message-ID: <ijizcoufpxwtrutqpurumsx7zls2dixyanlcn6oshvhpon5osd@aeuzrsmkidrz>
References: <20251027153401.1039217-1-tglozar@redhat.com>
 <20251027153401.1039217-2-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027153401.1039217-2-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Oct 27, 2025 at 04:33:55PM +0100, Tomas Glozar wrote:
> Add a map to the rtla-timerlat BPF program that holds a file descriptor
> of another BPF program, to be executed on threshold overflow.
> 
> timerlat_bpf_set_action() is added as an interface to set the program.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/timerlat.bpf.c | 23 ++++++++++++++++++++---
>  tools/tracing/rtla/src/timerlat_bpf.c | 13 +++++++++++++
>  tools/tracing/rtla/src/timerlat_bpf.h |  1 +
>  3 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/timerlat.bpf.c b/tools/tracing/rtla/src/timerlat.bpf.c
> index 084cd10c21fc..19ccd9abf8d4 100644
> --- a/tools/tracing/rtla/src/timerlat.bpf.c
> +++ b/tools/tracing/rtla/src/timerlat.bpf.c
> @@ -40,6 +40,17 @@ struct {
>  	__uint(max_entries, 1);
>  } signal_stop_tracing SEC(".maps");
>  
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> +	__uint(key_size, sizeof(unsigned int));
> +	__uint(max_entries, 1);
> +	__array(values, unsigned int (void *));
> +} bpf_action SEC(".maps") = {
> +	.values = {
> +		[0] = 0
> +	},
> +};
> +
>  /* Params to be set by rtla */
>  const volatile int bucket_size = 1;
>  const volatile int output_divisor = 1000;
> @@ -109,7 +120,7 @@ nosubprog void update_summary(void *map,
>  	map_set(map, SUMMARY_SUM, map_get(map, SUMMARY_SUM) + latency);
>  }
>  
> -nosubprog void set_stop_tracing(void)
> +nosubprog void set_stop_tracing(struct trace_event_raw_timerlat_sample *tp_args)
>  {
>  	int value = 0;
>  
> @@ -118,6 +129,12 @@ nosubprog void set_stop_tracing(void)
>  
>  	/* Signal to userspace */
>  	bpf_ringbuf_output(&signal_stop_tracing, &value, sizeof(value), 0);
> +
> +	/*
> +	 * Call into BPF action program, if attached.
> +	 * Otherwise, just silently fail.
> +	 */
> +	bpf_tail_call(tp_args, &bpf_action, 0);
>  }
>  
>  SEC("tp/osnoise/timerlat_sample")
> @@ -138,13 +155,13 @@ int handle_timerlat_sample(struct trace_event_raw_timerlat_sample *tp_args)
>  		update_summary(&summary_irq, latency, bucket);
>  
>  		if (irq_threshold != 0 && latency_us >= irq_threshold)
> -			set_stop_tracing();
> +			set_stop_tracing(tp_args);
>  	} else if (tp_args->context == 1) {
>  		update_main_hist(&hist_thread, bucket);
>  		update_summary(&summary_thread, latency, bucket);
>  
>  		if (thread_threshold != 0 && latency_us >= thread_threshold)
> -			set_stop_tracing();
> +			set_stop_tracing(tp_args);
>  	} else {
>  		update_main_hist(&hist_user, bucket);
>  		update_summary(&summary_user, latency, bucket);
> diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
> index e97d16646bcd..1d619e502c65 100644
> --- a/tools/tracing/rtla/src/timerlat_bpf.c
> +++ b/tools/tracing/rtla/src/timerlat_bpf.c
> @@ -59,6 +59,19 @@ int timerlat_bpf_init(struct timerlat_params *params)
>  	return 0;
>  }
>  
> +/*
> + * timerlat_bpf_set_action - set action on threshold executed on BPF side
> + */
> +static int timerlat_bpf_set_action(struct bpf_program *prog)
> +{
> +	unsigned int key = 0, value = bpf_program__fd(prog);
> +
> +	return bpf_map__update_elem(bpf->maps.bpf_action,
> +				    &key, sizeof(key),
> +				    &value, sizeof(value),
> +				    BPF_ANY);
> +}
> +

I believe it makes more sense to add the definition of this function to
the patch where it is called.

>  /*
>   * timerlat_bpf_attach - attach BPF program to collect timerlat data
>   */
> diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
> index 118487436d30..b5009092c7a3 100644
> --- a/tools/tracing/rtla/src/timerlat_bpf.h
> +++ b/tools/tracing/rtla/src/timerlat_bpf.h
> @@ -12,6 +12,7 @@ enum summary_field {
>  };
>  
>  #ifndef __bpf__
> +#include <bpf/libbpf.h>
>  #ifdef HAVE_BPF_SKEL
>  int timerlat_bpf_init(struct timerlat_params *params);
>  int timerlat_bpf_attach(void);
> -- 
> 2.51.0
> 

