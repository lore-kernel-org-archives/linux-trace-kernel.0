Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9B258ECA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901875; cv=none; b=K0kFA07NYMAZ/64gDx3DyyCNdYdxz12QadzBOwka1tW3h1L4ps4EQT688SROP+z80mFiBJ15HG6j9jGnSWYE5LOn/qht6CJnjQ9ytvA8orAFZpHJHU+9qLwYF8dKcYg2cz/Ttj8MyHA0XqH2s9C0EQh56dWVNvBOAvFouYFltg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901875; c=relaxed/simple;
	bh=LphMVUNjtYosDpXVQXMKWV0wgMMqL43cYfFyNb1omUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTpptQxckeylo97WeqUVq6XX2elgtecrYDVzyoqS+6fReFatN1KBGavWnKy5Ife33h0UL5g1ca42zQhrfZkeW8avQZczSsd5M9nmjqS10wufRmYwRpoGN2CgAsUMXdTZSf0R+u5ehjQ8oKK5Prmz6/R5wwUQs6EZpjzhPQiYbAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FoK7R1r4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoK7R1r4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765901872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LF4dlNnDe7g0ivStA/oGjX4DMnDZCjNKvA9+4JRx79c=;
	b=FoK7R1r4x2d6Ti3exrr+5tBLUxArN4wjmZZmMCF49/UTrtXiTyIPIEiWkECk2585h9kRGY
	+CDqDQzkvs7JTIx0TNQh7LPqrecL0O8/DHaXZ0bieLYr6y6NhyNPn8+9fLNRltMN9wkdgP
	YnEHqh8qkbJtMCoL8iJDed05XtXok34=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-dnv3lp0yPli4ghkZ_Q_Q0w-1; Tue,
 16 Dec 2025 11:17:50 -0500
X-MC-Unique: dnv3lp0yPli4ghkZ_Q_Q0w-1
X-Mimecast-MFC-AGG-ID: dnv3lp0yPli4ghkZ_Q_Q0w_1765901868
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9FAB1800378;
	Tue, 16 Dec 2025 16:17:48 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.62])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5E8E81955F24;
	Tue, 16 Dec 2025 16:17:44 +0000 (UTC)
Date: Tue, 16 Dec 2025 13:17:43 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] tools/rtla: Consolidate -d/--duration option
 parsing
Message-ID: <krmo42jpyowqokrkkhhbwqauiyvovt2ankyr6ho6hiwwgotxhp@pxztuoifxemf>
References: <20251209100047.2692515-1-costa.shul@redhat.com>
 <20251209100047.2692515-5-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209100047.2692515-5-costa.shul@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Dec 09, 2025 at 12:00:44PM +0200, Costa Shulyupin wrote:
> Each rtla tool duplicates parsing of -d/--duration.
> 
> Migrate the option parsing from individual tools to the
> common_parse_options().
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/common.c        | 8 +++++++-
>  tools/tracing/rtla/src/osnoise_hist.c  | 8 +-------
>  tools/tracing/rtla/src/osnoise_top.c   | 8 +-------
>  tools/tracing/rtla/src/timerlat_hist.c | 8 +-------
>  tools/tracing/rtla/src/timerlat_top.c  | 8 +-------
>  5 files changed, 11 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
> index 5bf79a9bb152..e6ff011d2cd2 100644
> --- a/tools/tracing/rtla/src/common.c
> +++ b/tools/tracing/rtla/src/common.c
> @@ -59,11 +59,12 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
>  		{"cpus",                required_argument,      0, 'c'},
>  		{"cgroup",              optional_argument,      0, 'C'},
>  		{"debug",               no_argument,            0, 'D'},
> +		{"duration",            required_argument,      0, 'd'},
>  		{0, 0, 0, 0}
>  	};
>  
>  	opterr = 0;
> -	c = getopt_long(argc, argv, "c:C::D", long_options, NULL);
> +	c = getopt_long(argc, argv, "c:C::Dd:", long_options, NULL);
>  	opterr = 1;
>  
>  	switch (c) {
> @@ -79,6 +80,11 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
>  	case 'D':
>  		config_debug = 1;
>  		break;
> +	case 'd':
> +		common->duration = parse_seconds_duration(optarg);
> +		if (!common->duration)
> +			fatal("Invalid -d duration");
> +		break;
>  	default:
>  		optind = saved_state;
>  		return 0;
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
> index 6902486fb144..1b79bfefc214 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -491,7 +491,6 @@ static struct common_params
>  			{"auto",		required_argument,	0, 'a'},
>  			{"bucket-size",		required_argument,	0, 'b'},
>  			{"entries",		required_argument,	0, 'E'},
> -			{"duration",		required_argument,	0, 'd'},
>  			{"house-keeping",	required_argument,		0, 'H'},
>  			{"help",		no_argument,		0, 'h'},
>  			{"period",		required_argument,	0, 'p'},
> @@ -518,7 +517,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:b:d:e:E:hH:p:P:r:s:S:t::T:01234:5:6:7:",
> +		c = getopt_long(argc, argv, "a:b:e:E:hH:p:P:r:s:S:t::T:01234:5:6:7:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -544,11 +543,6 @@ static struct common_params
>  			    params->common.hist.bucket_size >= 1000000)
>  				fatal("Bucket size needs to be > 0 and <= 1000000");
>  			break;
> -		case 'd':
> -			params->common.duration = parse_seconds_duration(optarg);
> -			if (!params->common.duration)
> -				fatal("Invalid -D duration");
> -			break;
>  		case 'e':
>  			tevent = trace_event_alloc(optarg);
>  			if (!tevent)
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index 4a61fd50b990..619c5bcf8f35 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -346,7 +346,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  	while (1) {
>  		static struct option long_options[] = {
>  			{"auto",		required_argument,	0, 'a'},
> -			{"duration",		required_argument,	0, 'd'},
>  			{"event",		required_argument,	0, 'e'},
>  			{"house-keeping",	required_argument,	0, 'H'},
>  			{"help",		no_argument,		0, 'h'},
> @@ -370,7 +369,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:d:e:hH:p:P:qr:s:S:t::T:0:1:2:3:",
> +		c = getopt_long(argc, argv, "a:e:hH:p:P:qr:s:S:t::T:0:1:2:3:",
>  				 long_options, NULL);
>  
>  		/* Detect the end of the options. */
> @@ -390,11 +389,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  				trace_output = "osnoise_trace.txt";
>  
>  			break;
> -		case 'd':
> -			params->common.duration = parse_seconds_duration(optarg);
> -			if (!params->common.duration)
> -				fatal("Invalid -d duration");
> -			break;
>  		case 'e':
>  			tevent = trace_event_alloc(optarg);
>  			if (!tevent)
> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
> index 97d20e272583..0a7e5dcce121 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -798,7 +798,6 @@ static struct common_params
>  			{"auto",		required_argument,	0, 'a'},
>  			{"bucket-size",		required_argument,	0, 'b'},
>  			{"entries",		required_argument,	0, 'E'},
> -			{"duration",		required_argument,	0, 'd'},
>  			{"house-keeping",	required_argument,	0, 'H'},
>  			{"help",		no_argument,		0, 'h'},
>  			{"irq",			required_argument,	0, 'i'},
> @@ -834,7 +833,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:b:d:e:E:hH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
> +		c = getopt_long(argc, argv, "a:b:e:E:hH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -863,11 +862,6 @@ static struct common_params
>  			    params->common.hist.bucket_size >= 1000000)
>  				fatal("Bucket size needs to be > 0 and <= 1000000");
>  			break;
> -		case 'd':
> -			params->common.duration = parse_seconds_duration(optarg);
> -			if (!params->common.duration)
> -				fatal("Invalid -D duration");
> -			break;
>  		case 'e':
>  			tevent = trace_event_alloc(optarg);
>  			if (!tevent)
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> index 96bca67d419f..4340fbf3f879 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -566,7 +566,6 @@ static struct common_params
>  	while (1) {
>  		static struct option long_options[] = {
>  			{"auto",		required_argument,	0, 'a'},
> -			{"duration",		required_argument,	0, 'd'},
>  			{"event",		required_argument,	0, 'e'},
>  			{"help",		no_argument,		0, 'h'},
>  			{"house-keeping",	required_argument,	0, 'H'},
> @@ -598,7 +597,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:d:e:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
> +		c = getopt_long(argc, argv, "a:e:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -635,11 +634,6 @@ static struct common_params
>  			/* set aa_only to avoid parsing the trace */
>  			params->common.aa_only = 1;
>  			break;
> -		case 'd':
> -			params->common.duration = parse_seconds_duration(optarg);
> -			if (!params->common.duration)
> -				fatal("Invalid -d duration");
> -			break;
>  		case 'e':
>  			tevent = trace_event_alloc(optarg);
>  			if (!tevent)
> -- 
> 2.52.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

