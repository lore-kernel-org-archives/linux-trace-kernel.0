Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630DA3612D3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898545; cv=none; b=aywUdpAB2UHGSfcgAz+ZPh2IeX0UIf6b6azd7hsQEK1R4JoXrQBS4yGPRY02kDuoujsuLAno4YvYUIIKablgmcQDLOZ2cmz+9GxYSyLbioWdS7R+WOysllWaGbg3QXElMWXrNwv7uJ1WdL1BgZ0VPrxRMhaCmKDADCYh5lQ3Wf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898545; c=relaxed/simple;
	bh=bWUMr9rg61BGF8dhwL/biP3a4PN1qhxZMScflleD8lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=On5v30ulbRx524mRolDMNsfjSrYNGAL8Xu+ij+WVYYrgZbzZRpAA2ywjpy5H1ICZPxbLgfuAfyH4VdOuNP6hXjKl/SJk6BJITtwiPMdfFtDVrSgnmjx7xb3aXUk+gQ06RAaGAB2UurLysX2xxSiiKa/kJwufBlp2qfptLrn1fms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B26ekF1e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B26ekF1e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765898542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1iNwGC+xE5EXbVyOZqsQpJGHuL1qKY4rLA9Y+qtnfZY=;
	b=B26ekF1e8+b5LHE58fPa9VvZKC0MDH1TGME3JZkZZmsOrUkcsFLVWorjJQBQlbY/dtxGjL
	ZZpMxYkRXHflvfL3y7sxeSCTEUDpdmFtjaut/905l4y9ohRRSuwRvph6De4JUnWOUXx+h8
	yB4C/ZJ/5ZGLAXWBvaaGI59p7esvk8o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-4uNnrO-yPlC7gkwTnP7gHg-1; Tue,
 16 Dec 2025 10:22:18 -0500
X-MC-Unique: 4uNnrO-yPlC7gkwTnP7gHg-1
X-Mimecast-MFC-AGG-ID: 4uNnrO-yPlC7gkwTnP7gHg_1765898537
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADA301956096;
	Tue, 16 Dec 2025 15:22:16 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.62])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A77A730001A7;
	Tue, 16 Dec 2025 15:22:12 +0000 (UTC)
Date: Tue, 16 Dec 2025 12:22:10 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v4 3/7] rtla/timerlat: Add example for BPF action program
Message-ID: <yha47my7tmcu5yvbwelst32ipectzkhekxdorgpxws463kxsno@fcw5vv674yo6>
References: <20251126144205.331954-1-tglozar@redhat.com>
 <20251126144205.331954-4-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126144205.331954-4-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Nov 26, 2025 at 03:42:01PM +0100, Tomas Glozar wrote:
> Add an example BPF action program that prints the measured latency to
> the tracefs buffer via bpf_printk().
> 
> A new Makefile target, "examples", is added to build the example. In
> addition, "sample/" subfolder is renamed to "example".
> 
> If BPF skeleton support is unavailable or disabled, a warning will be
> displayed when building the BPF action program example.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/Makefile                      |  9 ++++++++-
>  tools/tracing/rtla/example/timerlat_bpf_action.c | 16 ++++++++++++++++
>  .../rtla/{sample => example}/timerlat_load.py    |  0
>  3 files changed, 24 insertions(+), 1 deletion(-)
>  create mode 100644 tools/tracing/rtla/example/timerlat_bpf_action.c
>  rename tools/tracing/rtla/{sample => example}/timerlat_load.py (100%)
> 
> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index 746ccf2f5808..5f1529ce3693 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -73,9 +73,15 @@ src/timerlat.bpf.o: src/timerlat.bpf.c
>  
>  src/timerlat.skel.h: src/timerlat.bpf.o
>  	$(QUIET_GENSKEL)$(SYSTEM_BPFTOOL) gen skeleton $< > $@
> +
> +example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
> +	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@

I couldn't understand the need for the `filter` function.

>  else
>  src/timerlat.skel.h:
>  	$(Q)echo '/* BPF skeleton is disabled */' > src/timerlat.skel.h
> +
> +example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
> +	$(Q)echo "BPF skeleton support is disabled, skipping example/timerlat_bpf_action.o"
>  endif
>  
>  $(RTLA): $(RTLA_IN)
> @@ -96,7 +102,8 @@ clean: doc_clean fixdep-clean
>  	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
>  	$(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
>  	$(Q)rm -rf feature
> -	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h
> +	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat_bpf_action.o
>  check: $(RTLA)
>  	RTLA=$(RTLA) prove -o -f tests/
> +examples: example/timerlat_bpf_action.o
>  .PHONY: FORCE clean check
> diff --git a/tools/tracing/rtla/example/timerlat_bpf_action.c b/tools/tracing/rtla/example/timerlat_bpf_action.c
> new file mode 100644
> index 000000000000..ac1be049a848
> --- /dev/null
> +++ b/tools/tracing/rtla/example/timerlat_bpf_action.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char LICENSE[] SEC("license") = "GPL";
> +
> +struct trace_event_raw_timerlat_sample {
> +	unsigned long long timer_latency;
> +} __attribute__((preserve_access_index));
> +
> +SEC("tp/timerlat_action")
> +int action_handler(struct trace_event_raw_timerlat_sample *tp_args)
> +{
> +	bpf_printk("Latency: %lld\n", tp_args->timer_latency);
> +	return 0;
> +}
> diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/rtla/example/timerlat_load.py
> similarity index 100%
> rename from tools/tracing/rtla/sample/timerlat_load.py
> rename to tools/tracing/rtla/example/timerlat_load.py
> -- 
> 2.51.1
> 

