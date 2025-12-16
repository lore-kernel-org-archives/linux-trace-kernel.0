Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE381309EFA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901942; cv=none; b=EX/76dyIhU5Afa23C0DZOoHNNxPCKbApX7z+I6fS7eCYFuufqvpQ1wANO6gP6KsAFo5j72ungtosH6pybChKTzK0cXAloHoVBHBmi1hvtZu86s1acrZDiJWcBaIbj+9mEWpDxZ77so98D3jd3SyScAbHC3atjJjWa/Io9boBtRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901942; c=relaxed/simple;
	bh=fJ7PtaYEhaUidkOzaubc/AQfEMNI2qubTR0CYXwqjBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNvq4axT8AuYjHcNmADIeRX+IY8ODWdGMj4J9g86epGzlVwsaXRPyLCX/jGr8qmTvBRDz2pk7UznVbENCsmIueZrpaJLFh/aQNGWHei8jxEVcMzZECeZMcUZ6GYjrx2dpznpmQ3D859l6C49gYohI9FXkxKd5JLWnlqRtMbtjzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=arDglIyL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arDglIyL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765901939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q18ZiUlHdoNmDs9ooqiNVU/hQ5vD+uNsbCKDOPdI6fA=;
	b=arDglIyLuP2K4geKsNJiWQXinpDRr8ReO94kTcUWWsvFmhit+tKkoRDTb8kpBE2IrItiWC
	np+zPM5v3tj4XT4kC2t7HQy5SIpHvm/9PfXTk0ZgZmlspR1VH/ac5CVsjiT/WOtuCrdKS0
	lhz71qmeud4abGO6E7mLnas0sasmjVA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-M8gN1dqJMxWmjIKbYXafuA-1; Tue,
 16 Dec 2025 11:18:56 -0500
X-MC-Unique: M8gN1dqJMxWmjIKbYXafuA-1
X-Mimecast-MFC-AGG-ID: M8gN1dqJMxWmjIKbYXafuA_1765901935
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 610F21955F4A;
	Tue, 16 Dec 2025 16:18:55 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.62])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1475430001A2;
	Tue, 16 Dec 2025 16:18:51 +0000 (UTC)
Date: Tue, 16 Dec 2025 13:18:50 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] tools/rtla: Consolidate -H/--house-keeping option
 parsing
Message-ID: <nj75ar644yise2m6yphaydx62pxsqbom74uri2kofkgjnutc7e@knx6ryo3yb3d>
References: <20251209100047.2692515-1-costa.shul@redhat.com>
 <20251209100047.2692515-8-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209100047.2692515-8-costa.shul@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Dec 09, 2025 at 12:00:47PM +0200, Costa Shulyupin wrote:
> Each rtla tool duplicates parsing of -H/--house-keeping.
> 
> Migrate the option parsing from individual tools to the
> common_parse_options().
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/common.c        | 8 +++++++-
>  tools/tracing/rtla/src/osnoise_hist.c  | 9 +--------
>  tools/tracing/rtla/src/osnoise_top.c   | 9 +--------
>  tools/tracing/rtla/src/timerlat_hist.c | 9 +--------
>  tools/tracing/rtla/src/timerlat_top.c  | 9 +--------
>  5 files changed, 11 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
> index e042b2d9dbf5..8e90bb4a76f9 100644
> --- a/tools/tracing/rtla/src/common.c
> +++ b/tools/tracing/rtla/src/common.c
> @@ -62,12 +62,13 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
>  		{"debug",               no_argument,            0, 'D'},
>  		{"duration",            required_argument,      0, 'd'},
>  		{"event",               required_argument,      0, 'e'},
> +		{"house-keeping",       required_argument,      0, 'H'},
>  		{"priority",            required_argument,      0, 'P'},
>  		{0, 0, 0, 0}
>  	};
>  
>  	opterr = 0;
> -	c = getopt_long(argc, argv, "c:C::Dd:e:P:", long_options, NULL);
> +	c = getopt_long(argc, argv, "c:C::Dd:e:H:P:", long_options, NULL);
>  	opterr = 1;
>  
>  	switch (c) {
> @@ -97,6 +98,11 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
>  			tevent->next = common->events;
>  		common->events = tevent;
>  		break;
> +	case 'H':
> +		common->hk_cpus = 1;
> +		if (parse_cpu_set(optarg, &common->hk_cpu_set))
> +			fatal("Error parsing house keeping CPUs");
> +		break;
>  	case 'P':
>  		if (parse_prio(optarg, &common->sched_param) == -1)
>  			fatal("Invalid -P priority");
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
> index 6ed5f5594960..1ebd3b48b2d3 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -490,7 +490,6 @@ static struct common_params
>  			{"auto",		required_argument,	0, 'a'},
>  			{"bucket-size",		required_argument,	0, 'b'},
>  			{"entries",		required_argument,	0, 'E'},
> -			{"house-keeping",	required_argument,		0, 'H'},
>  			{"help",		no_argument,		0, 'h'},
>  			{"period",		required_argument,	0, 'p'},
>  			{"runtime",		required_argument,	0, 'r'},
> @@ -514,7 +513,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:b:E:hH:p:r:s:S:t::T:01234:5:6:7:",
> +		c = getopt_long(argc, argv, "a:b:E:hp:r:s:S:t::T:01234:5:6:7:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -550,12 +549,6 @@ static struct common_params
>  		case '?':
>  			osnoise_hist_usage();
>  			break;
> -		case 'H':
> -			params->common.hk_cpus = 1;
> -			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
> -			if (retval)
> -				fatal("Error parsing house keeping CPUs");
> -			break;
>  		case 'p':
>  			params->period = get_llong_from_str(optarg);
>  			if (params->period > 10000000)
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index d2dfad960440..02e5e6e18e8d 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -345,7 +345,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  	while (1) {
>  		static struct option long_options[] = {
>  			{"auto",		required_argument,	0, 'a'},
> -			{"house-keeping",	required_argument,	0, 'H'},
>  			{"help",		no_argument,		0, 'h'},
>  			{"period",		required_argument,	0, 'p'},
>  			{"quiet",		no_argument,		0, 'q'},
> @@ -366,7 +365,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:hH:p:qr:s:S:t::T:0:1:2:3:",
> +		c = getopt_long(argc, argv, "a:hp:qr:s:S:t::T:0:1:2:3:",
>  				 long_options, NULL);
>  
>  		/* Detect the end of the options. */
> @@ -390,12 +389,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  		case '?':
>  			osnoise_top_usage(params);
>  			break;
> -		case 'H':
> -			params->common.hk_cpus = 1;
> -			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
> -			if (retval)
> -				fatal("Error parsing house keeping CPUs");
> -			break;
>  		case 'p':
>  			params->period = get_llong_from_str(optarg);
>  			if (params->period > 10000000)
> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
> index e7ba083b5eb4..d1a6cf0c2e0d 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -797,7 +797,6 @@ static struct common_params
>  			{"auto",		required_argument,	0, 'a'},
>  			{"bucket-size",		required_argument,	0, 'b'},
>  			{"entries",		required_argument,	0, 'E'},
> -			{"house-keeping",	required_argument,	0, 'H'},
>  			{"help",		no_argument,		0, 'h'},
>  			{"irq",			required_argument,	0, 'i'},
>  			{"nano",		no_argument,		0, 'n'},
> @@ -830,7 +829,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:b:E:hH:i:knp:s:t::T:uU0123456:7:8:9\1\2:\3:",
> +		c = getopt_long(argc, argv, "a:b:E:hi:knp:s:t::T:uU0123456:7:8:9\1\2:\3:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -869,12 +868,6 @@ static struct common_params
>  		case '?':
>  			timerlat_hist_usage();
>  			break;
> -		case 'H':
> -			params->common.hk_cpus = 1;
> -			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
> -			if (retval)
> -				fatal("Error parsing house keeping CPUs");
> -			break;
>  		case 'i':
>  			params->common.stop_us = get_llong_from_str(optarg);
>  			break;
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> index 8250bea4b2fd..12e3d8c6f850 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -566,7 +566,6 @@ static struct common_params
>  		static struct option long_options[] = {
>  			{"auto",		required_argument,	0, 'a'},
>  			{"help",		no_argument,		0, 'h'},
> -			{"house-keeping",	required_argument,	0, 'H'},
>  			{"irq",			required_argument,	0, 'i'},
>  			{"nano",		no_argument,		0, 'n'},
>  			{"period",		required_argument,	0, 'p'},
> @@ -594,7 +593,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:hH:i:knp:qs:t::T:uU0:1:2:345:6:7:",
> +		c = getopt_long(argc, argv, "a:hi:knp:qs:t::T:uU0:1:2:345:6:7:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -635,12 +634,6 @@ static struct common_params
>  		case '?':
>  			timerlat_top_usage();
>  			break;
> -		case 'H':
> -			params->common.hk_cpus = 1;
> -			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
> -			if (retval)
> -				fatal("Error parsing house keeping CPUs");
> -			break;
>  		case 'i':
>  			params->common.stop_us = get_llong_from_str(optarg);
>  			break;
> -- 
> 2.52.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

