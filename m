Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FE028312D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901808; cv=none; b=SRV9fOcGf+t/q7y6SWc5aCy6pryo/3POk+NKaSD3eEhJFWPHpZBbqsDZShNrCKBDL+ck6gr6IvmJGBdzghnXQZeU7lQWgwC237m35HowCcTuD2en/Ljz4t8qaOce7LeByLZ7idjAX90NoGFJIFT3A+RISetAQxzk48lCQGfwB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901808; c=relaxed/simple;
	bh=vV6/+RZHf8loC8YOzXPOdTas/wgdJqv+yvSndfIpUPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT8OCnZLUVxhq2ywrIL2s6GRT1rGWA3L3JLt1HC1PXyrZf7srgO6vqAZQbUeVnvNef7z6EYD5UJwerx3Ep5nugRKwuh5uNMM8TU4UD8TOx14cm00i3i06fyAZXYyLLA3y70YIGj1F0t4+vYO1Ds9osfBsE2KNqN7dEKt8QrcJd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQc1ugsG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQc1ugsG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765901806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zCPrUgE1w2dzwH6cawuLKcaXVe0ehajsR9RdgSksM0=;
	b=RQc1ugsGWimiHt4k7J9Xip4meX5McC3u1wu8Ug/uff5wn4AseDkwdjoxQsdbac9om9fvGl
	EDnRCrltxRW7QTs8tDl/aMw+AXVTK2bLiALIKmL2s5rRENYDsQrO2/y2/AEiyKzuFfW+oc
	+xZmIiZaIEeL5WJUfBbDthb4CGXaxJw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-HFlkwjFaN3qhADK_aythNw-1; Tue,
 16 Dec 2025 11:16:42 -0500
X-MC-Unique: HFlkwjFaN3qhADK_aythNw-1
X-Mimecast-MFC-AGG-ID: HFlkwjFaN3qhADK_aythNw_1765901801
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21799180063F;
	Tue, 16 Dec 2025 16:16:41 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D04C71800662;
	Tue, 16 Dec 2025 16:16:37 +0000 (UTC)
Date: Tue, 16 Dec 2025 13:16:35 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] tools/rtla: Consolidate -c/--cpus option parsing
Message-ID: <53skdgz6ck6pmnyjs26qbitomi5lchepf3uyl74tpcri26nhhf@mupp5irjqdif>
References: <20251209100047.2692515-1-costa.shul@redhat.com>
 <20251209100047.2692515-2-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209100047.2692515-2-costa.shul@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Dec 09, 2025 at 12:00:41PM +0200, Costa Shulyupin wrote:
> Each rtla tool duplicates parsing of -c/--cpus.
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
> index a78f9883521e..e5aa8c30cd7d 100644
> --- a/tools/tracing/rtla/src/common.c
> +++ b/tools/tracing/rtla/src/common.c
> @@ -56,14 +56,20 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
>  	int c;
>  
>  	static struct option long_options[] = {
> +		{"cpus",                required_argument,      0, 'c'},
>  		{0, 0, 0, 0}
>  	};
>  
>  	opterr = 0;
> -	c = getopt_long(argc, argv, "", long_options, NULL);
> +	c = getopt_long(argc, argv, "c:", long_options, NULL);
>  	opterr = 1;
>  
>  	switch (c) {
> +	case 'c':
> +		if (parse_cpu_set(optarg, &common->monitored_cpus))
> +			fatal("Invalid -c cpu list");
> +		common->cpus = optarg;
> +		break;
>  	default:
>  		optind = saved_state;
>  		return 0;
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
> index 35f4a068af95..9e721362989a 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -491,7 +491,6 @@ static struct common_params
>  			{"auto",		required_argument,	0, 'a'},
>  			{"bucket-size",		required_argument,	0, 'b'},
>  			{"entries",		required_argument,	0, 'E'},
> -			{"cpus",		required_argument,	0, 'c'},
>  			{"cgroup",		optional_argument,	0, 'C'},
>  			{"debug",		no_argument,		0, 'D'},
>  			{"duration",		required_argument,	0, 'd'},
> @@ -521,7 +520,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:7:",
> +		c = getopt_long(argc, argv, "a:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:7:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -547,12 +546,6 @@ static struct common_params
>  			    params->common.hist.bucket_size >= 1000000)
>  				fatal("Bucket size needs to be > 0 and <= 1000000");
>  			break;
> -		case 'c':
> -			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
> -			if (retval)
> -				fatal("Invalid -c cpu list");
> -			params->common.cpus = optarg;
> -			break;
>  		case 'C':
>  			params->common.cgroup = 1;
>  			params->common.cgroup_name = parse_optional_arg(argc, argv);
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index 550731c7addd..73736cefd992 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -346,7 +346,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  	while (1) {
>  		static struct option long_options[] = {
>  			{"auto",		required_argument,	0, 'a'},
> -			{"cpus",		required_argument,	0, 'c'},
>  			{"cgroup",		optional_argument,	0, 'C'},
>  			{"debug",		no_argument,		0, 'D'},
>  			{"duration",		required_argument,	0, 'd'},
> @@ -373,7 +372,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:c:C::d:De:hH:p:P:qr:s:S:t::T:0:1:2:3:",
> +		c = getopt_long(argc, argv, "a:C::d:De:hH:p:P:qr:s:S:t::T:0:1:2:3:",
>  				 long_options, NULL);
>  
>  		/* Detect the end of the options. */
> @@ -392,12 +391,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  			if (!trace_output)
>  				trace_output = "osnoise_trace.txt";
>  
> -			break;
> -		case 'c':
> -			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
> -			if (retval)
> -				fatal("Invalid -c cpu list");
> -			params->common.cpus = optarg;
>  			break;
>  		case 'C':
>  			params->common.cgroup = 1;
> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
> index ffcfcabb9964..4ae77145adea 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -796,7 +796,6 @@ static struct common_params
>  	while (1) {
>  		static struct option long_options[] = {
>  			{"auto",		required_argument,	0, 'a'},
> -			{"cpus",		required_argument,	0, 'c'},
>  			{"cgroup",		optional_argument,	0, 'C'},
>  			{"bucket-size",		required_argument,	0, 'b'},
>  			{"debug",		no_argument,		0, 'D'},
> @@ -837,7 +836,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
> +		c = getopt_long(argc, argv, "a:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -859,12 +858,6 @@ static struct common_params
>  			if (!trace_output)
>  				trace_output = "timerlat_trace.txt";
>  
> -			break;
> -		case 'c':
> -			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
> -			if (retval)
> -				fatal("Invalid -c cpu list");
> -			params->common.cpus = optarg;
>  			break;
>  		case 'C':
>  			params->common.cgroup = 1;
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> index d18d48671ccd..9774c26b27ff 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -566,7 +566,6 @@ static struct common_params
>  	while (1) {
>  		static struct option long_options[] = {
>  			{"auto",		required_argument,	0, 'a'},
> -			{"cpus",		required_argument,	0, 'c'},
>  			{"cgroup",		optional_argument,	0, 'C'},
>  			{"debug",		no_argument,		0, 'D'},
>  			{"duration",		required_argument,	0, 'd'},
> @@ -601,7 +600,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
> +		c = getopt_long(argc, argv, "a:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -638,12 +637,6 @@ static struct common_params
>  			/* set aa_only to avoid parsing the trace */
>  			params->common.aa_only = 1;
>  			break;
> -		case 'c':
> -			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
> -			if (retval)
> -				fatal("Invalid -c cpu list");
> -			params->common.cpus = optarg;
> -			break;
>  		case 'C':
>  			params->common.cgroup = 1;
>  			params->common.cgroup_name = optarg;
> -- 
> 2.52.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

