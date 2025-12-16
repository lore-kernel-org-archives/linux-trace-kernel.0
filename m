Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07F2D838C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901855; cv=none; b=dzoZD5evOIjrWzlwtTAGjcc6jq3My8vvUDxhsiDKL2LaZ+PkMSi8ESjrkSMHYFhlS8W2KnA/YMx8VAnk0o2RgoGjYfpNMyY5OZ/qOu9H8eBRt4caL4SYIx8Uiqw6Sdvc7OHskkTxMRyDtHWJxhmyVg9XuTxBVW+VSBP8HvoVrWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901855; c=relaxed/simple;
	bh=AVrg02RH/isfydgXPxJQkC6CDtPtHri3rl05BCcVJYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th7I2ZWqlvsn/bZ0SrN9egiXWkA9kk3ix9YPW9dQ8sEXxzZiNXrdhOrIPB9/+pza5Y3G6P/kUDNBTTqpkH6YakTx9eHUPcpWulKvPDbxEGHBqMWJgMujAQw0kqZF0Prii4SfB3+IF2kLKpDNSdyGhIK7R/+ZBdVzD0bL8mJLgSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALbxM3ND; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALbxM3ND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765901852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=52fK8/g2Zg/PJcXI0aevRgl9lnEeHek3N+3TThLQPWo=;
	b=ALbxM3NDmKiiChXEkHGCVOzQJzJss5Sj72r2yZisT1ESW0ARaOTfqJnlpxoizKadGiNZNH
	1QCURDqyTYQZDUKiuRWgV4Hk8Ud7zMypKsfrBguqmNq8b5UjILg3ETYitCRVKgg23KrqJh
	cCDs1y9olkd84HOQDHaqfhZ18/9VDjw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-tjDGN6hkNgGLX9OHm6EuCg-1; Tue,
 16 Dec 2025 11:17:27 -0500
X-MC-Unique: tjDGN6hkNgGLX9OHm6EuCg-1
X-Mimecast-MFC-AGG-ID: tjDGN6hkNgGLX9OHm6EuCg_1765901847
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE6971955F34;
	Tue, 16 Dec 2025 16:17:26 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A9282180035A;
	Tue, 16 Dec 2025 16:17:23 +0000 (UTC)
Date: Tue, 16 Dec 2025 13:17:21 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] tools/rtla: Consolidate -D/--debug option parsing
Message-ID: <y4dhgsox7eak75ofci4wmv2bnfq5ijinhhcblgdcsqqy36od2z@ejvmikoxq6da>
References: <20251209100047.2692515-1-costa.shul@redhat.com>
 <20251209100047.2692515-4-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209100047.2692515-4-costa.shul@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Dec 09, 2025 at 12:00:43PM +0200, Costa Shulyupin wrote:
> Each rtla tool duplicates parsing of -D/--debug.
> 
> Migrate the option parsing from individual tools to the
> common_parse_options().
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/common.c        | 6 +++++-
>  tools/tracing/rtla/src/osnoise_hist.c  | 6 +-----
>  tools/tracing/rtla/src/osnoise_top.c   | 6 +-----
>  tools/tracing/rtla/src/timerlat_hist.c | 6 +-----
>  tools/tracing/rtla/src/timerlat_top.c  | 6 +-----
>  5 files changed, 9 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
> index 33428fa77f9f..5bf79a9bb152 100644
> --- a/tools/tracing/rtla/src/common.c
> +++ b/tools/tracing/rtla/src/common.c
> @@ -58,11 +58,12 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
>  	static struct option long_options[] = {
>  		{"cpus",                required_argument,      0, 'c'},
>  		{"cgroup",              optional_argument,      0, 'C'},
> +		{"debug",               no_argument,            0, 'D'},
>  		{0, 0, 0, 0}
>  	};
>  
>  	opterr = 0;
> -	c = getopt_long(argc, argv, "c:C::", long_options, NULL);
> +	c = getopt_long(argc, argv, "c:C::D", long_options, NULL);
>  	opterr = 1;
>  
>  	switch (c) {
> @@ -75,6 +76,9 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
>  		common->cgroup = 1;
>  		common->cgroup_name = parse_optional_arg(argc, argv);
>  		break;
> +	case 'D':
> +		config_debug = 1;
> +		break;
>  	default:
>  		optind = saved_state;
>  		return 0;
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
> index 5cbe5e1f1b07..6902486fb144 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -491,7 +491,6 @@ static struct common_params
>  			{"auto",		required_argument,	0, 'a'},
>  			{"bucket-size",		required_argument,	0, 'b'},
>  			{"entries",		required_argument,	0, 'E'},
> -			{"debug",		no_argument,		0, 'D'},
>  			{"duration",		required_argument,	0, 'd'},
>  			{"house-keeping",	required_argument,		0, 'H'},
>  			{"help",		no_argument,		0, 'h'},
> @@ -519,7 +518,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:7:",
> +		c = getopt_long(argc, argv, "a:b:d:e:E:hH:p:P:r:s:S:t::T:01234:5:6:7:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -545,9 +544,6 @@ static struct common_params
>  			    params->common.hist.bucket_size >= 1000000)
>  				fatal("Bucket size needs to be > 0 and <= 1000000");
>  			break;
> -		case 'D':
> -			config_debug = 1;
> -			break;
>  		case 'd':
>  			params->common.duration = parse_seconds_duration(optarg);
>  			if (!params->common.duration)
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index 35db5b73c0d7..4a61fd50b990 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -346,7 +346,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  	while (1) {
>  		static struct option long_options[] = {
>  			{"auto",		required_argument,	0, 'a'},
> -			{"debug",		no_argument,		0, 'D'},
>  			{"duration",		required_argument,	0, 'd'},
>  			{"event",		required_argument,	0, 'e'},
>  			{"house-keeping",	required_argument,	0, 'H'},
> @@ -371,7 +370,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:d:De:hH:p:P:qr:s:S:t::T:0:1:2:3:",
> +		c = getopt_long(argc, argv, "a:d:e:hH:p:P:qr:s:S:t::T:0:1:2:3:",
>  				 long_options, NULL);
>  
>  		/* Detect the end of the options. */
> @@ -390,9 +389,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  			if (!trace_output)
>  				trace_output = "osnoise_trace.txt";
>  
> -			break;
> -		case 'D':
> -			config_debug = 1;
>  			break;
>  		case 'd':
>  			params->common.duration = parse_seconds_duration(optarg);
> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
> index 9ecab2bb0f1e..97d20e272583 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -797,7 +797,6 @@ static struct common_params
>  		static struct option long_options[] = {
>  			{"auto",		required_argument,	0, 'a'},
>  			{"bucket-size",		required_argument,	0, 'b'},
> -			{"debug",		no_argument,		0, 'D'},
>  			{"entries",		required_argument,	0, 'E'},
>  			{"duration",		required_argument,	0, 'd'},
>  			{"house-keeping",	required_argument,	0, 'H'},
> @@ -835,7 +834,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
> +		c = getopt_long(argc, argv, "a:b:d:e:E:hH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -864,9 +863,6 @@ static struct common_params
>  			    params->common.hist.bucket_size >= 1000000)
>  				fatal("Bucket size needs to be > 0 and <= 1000000");
>  			break;
> -		case 'D':
> -			config_debug = 1;
> -			break;
>  		case 'd':
>  			params->common.duration = parse_seconds_duration(optarg);
>  			if (!params->common.duration)
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> index 6329c3a489aa..96bca67d419f 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -566,7 +566,6 @@ static struct common_params
>  	while (1) {
>  		static struct option long_options[] = {
>  			{"auto",		required_argument,	0, 'a'},
> -			{"debug",		no_argument,		0, 'D'},
>  			{"duration",		required_argument,	0, 'd'},
>  			{"event",		required_argument,	0, 'e'},
>  			{"help",		no_argument,		0, 'h'},
> @@ -599,7 +598,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
> +		c = getopt_long(argc, argv, "a:d:e:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -636,9 +635,6 @@ static struct common_params
>  			/* set aa_only to avoid parsing the trace */
>  			params->common.aa_only = 1;
>  			break;
> -		case 'D':
> -			config_debug = 1;
> -			break;
>  		case 'd':
>  			params->common.duration = parse_seconds_duration(optarg);
>  			if (!params->common.duration)
> -- 
> 2.52.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

