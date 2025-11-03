Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D28D22ACEB
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177463; cv=none; b=t1m6Pje7ARE8ZzN1MG3E8IGG+gDVWkcsHC6vK5QGqGxOABk1gQkL00EkqDBb+Xwu45wszv8pOF0CmkwFtLiuuDIP0kYfRyjKsvMUj4IxmXxx2XUKMUS94WynTD+B0E0ErUYieiAQYg0m8nNLu1DpA5zPsPcUZOgIvFTAh31fdmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177463; c=relaxed/simple;
	bh=Ho8xnwtVhCs170rsEmDxmxB/LnNMrvqKQDg/io/46bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPDJAePrFoHatNdpKasKcOSiZlPSuxeGuVEB505wVP2I6ibgvdrV3vH9S3hlkdbWkgZuNowJIoj031h0ecRU9UrtkigxJlwZQg0XYqA0RNUBBUThW4gsveQMa3A81ymw1k8CBhVvPb1+ephehf6VlAtEabjrL7j/2jYUgkYJ3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IIVmO4qF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIVmO4qF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762177461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7y5731YSFQoOJji3TgqoZH7giSydAFFycah6fSB5+eA=;
	b=IIVmO4qFXRuOZdnx2X6Yqf8pjk2JkM41s0okYlRdhj48AqD0VF53v5PstB0m55lr8FIg0S
	pGARKszAfVpJdq8pa+pNc+vaEFzFPs8vV0vWoqF4hTJtSf5l8dt48Dch2eI5NyzS6/UZE7
	3/9/S4WQ56K4jrQXtbC6o3Ag2cXQgiM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-sDtFBhtTPFKucNiVrIZhJg-1; Mon,
 03 Nov 2025 08:44:15 -0500
X-MC-Unique: sDtFBhtTPFKucNiVrIZhJg-1
X-Mimecast-MFC-AGG-ID: sDtFBhtTPFKucNiVrIZhJg_1762177454
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18941195609F;
	Mon,  3 Nov 2025 13:44:14 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.143])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D66BE1800451;
	Mon,  3 Nov 2025 13:44:09 +0000 (UTC)
Date: Mon, 3 Nov 2025 10:44:08 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 7/7] Documentation/rtla: Document --bpf-action option
Message-ID: <67caphyfdl7bivf2kqkp72eqd7bi4pjpbmsbu5loco7j46fmqw@enanot5eztwc>
References: <20251027153401.1039217-1-tglozar@redhat.com>
 <20251027153401.1039217-8-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027153401.1039217-8-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Oct 27, 2025 at 04:34:01PM +0100, Tomas Glozar wrote:
> Add new option --bpf-action into common_timerlat_options.txt, including
> the format in which it takes the BPF program, and a reference to an
> example.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  .../tools/rtla/common_timerlat_options.rst    | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
> index c6046fcf52dc..7e08a27e87fe 100644
> --- a/Documentation/tools/rtla/common_timerlat_options.rst
> +++ b/Documentation/tools/rtla/common_timerlat_options.rst
> @@ -65,3 +65,23 @@
>          Set timerlat to run without workload, waiting for the user to dispatch a per-cpu
>          task that waits for a new period on the tracing/osnoise/per_cpu/cpu$ID/timerlat_fd.
>          See linux/tools/rtla/example/timerlat_load.py for an example of user-load code.
> +
> +**--bpf-action** *bpf-program*
> +
> +        Loads a BPF program from an ELF file and executes it when a latency threshold is exceeded.
> +
> +        The BPF program must be a valid ELF file loadable with libbpf. The program must contain
> +        a function named ``action_handler``, declared with ``SEC("tp/timerlat_action")`` or
> +        a different section name beginning with "tp/". This tells libbpf that the program type is

nit: simply document that the section name must start with "tp/", the
part saying about "tp/timerlat_action" seems redudant, IIUC.

> +        BPF_PROG_TYPE_TRACEPOINT, without it, the program will not be loaded properly.
> +
> +        The program receives a ``struct trace_event_raw_timerlat_sample`` parameter
> +        containing timerlat sample data.
> +
> +        An example is provided in ``tools/tracing/rtla/example/timerlat_bpf_action.c``.
> +        This example demonstrates how to create a BPF program that prints latency information using
> +        bpf_trace_printk() when a threshold is exceeded.
> +
> +        **Note**: BPF actions require BPF support to be available. If BPF is not available
> +        or disabled, the tool will fall back to tracefs mode and BPF actions will not be
> +        supported.
> -- 
> 2.51.0
> 

