Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0DE20DD48
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901896; cv=none; b=bdDeVDACeH31csrPmYnkGtkutAQRqvoxqwELhA/ZsStXQdOyAhT/lDJJv5EfMEePjIBM/IaPgSUBGZFf8rZ681LCE9c1CpbOxop2/fA7oTwj2pLmP/z7WvzTACob+nmK0vuTQ+VD+LqOjPKD6/xOtuO/JXs5jYKfhckcHuIo78g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901896; c=relaxed/simple;
	bh=wKACWn29HoBuMJWVuqldgoDmIJoKzeGDIKoSOR/twQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRBYbCMp90zYxf4VRKpy8nAStL1q5ocLOOdTu6ERzGhFlPWFsBpaDHrXSYueOOdDrZ5+nVjYjv6fjJW3du4IlWqR2alynCsUchPhd6mY2avNtYwqKZbqGMnzsSYEz6ptdREzLiBgmyeXr+NATKPCvHyv5J5Ulhstlwa6VUv8Jhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBAV5Yfm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBAV5Yfm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765901893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3edM8+z0JXE7CSpWDgX3twmO9kbu+0yA5Qi4ELBLTD4=;
	b=gBAV5Yfmi2DaTqV8Zu++sCIKx2gU7zHZ/oOMqa2RgScd/DPO2qew5xUgOJD0oSK0JbSRqC
	W7zB8mNtgzk6Z/tEzuc1GIdTQqNi2ibOrYt976GW1yVeBTXM3DItOsxHviAcfAz/w69xo6
	HRnowCF9lkrEUEcyg1tO7j0pXR+we10=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-VVs1KxVtNDu9SRrOcBxYsQ-1; Tue,
 16 Dec 2025 11:18:12 -0500
X-MC-Unique: VVs1KxVtNDu9SRrOcBxYsQ-1
X-Mimecast-MFC-AGG-ID: VVs1KxVtNDu9SRrOcBxYsQ_1765901891
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A6AB1955E77;
	Tue, 16 Dec 2025 16:18:11 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.62])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BDA6C30001A2;
	Tue, 16 Dec 2025 16:18:07 +0000 (UTC)
Date: Tue, 16 Dec 2025 13:18:06 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] tools/rtla: Consolidate -e/--event option parsing
Message-ID: <a6s3qemoaxgv3kzhmjdqroggsrg5i3p56mqlpl3hcmicpesrxu@7bhepdxiy4ff>
References: <20251209100047.2692515-1-costa.shul@redhat.com>
 <20251209100047.2692515-6-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209100047.2692515-6-costa.shul@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Dec 09, 2025 at 12:00:45PM +0200, Costa Shulyupin wrote:
> Each rtla tool duplicates parsing of -e/--event.
> 
> Migrate the option parsing from individual tools to the
> common_parse_options().
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/common.c        | 13 ++++++++++++-
>  tools/tracing/rtla/src/osnoise_hist.c  | 14 +-------------
>  tools/tracing/rtla/src/osnoise_top.c   | 14 +-------------
>  tools/tracing/rtla/src/timerlat_hist.c | 14 +-------------
>  tools/tracing/rtla/src/timerlat_top.c  | 13 +------------
>  5 files changed, 16 insertions(+), 52 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
> index e6ff011d2cd2..684ff49f0a4c 100644
> --- a/tools/tracing/rtla/src/common.c
> +++ b/tools/tracing/rtla/src/common.c
> @@ -52,6 +52,7 @@ static void set_signals(struct common_params *params)
>   */
>  int common_parse_options(int argc, char **argv, struct common_params *common)
>  {
> +	struct trace_events *tevent;
>  	int saved_state = optind;
>  	int c;
>  
> @@ -60,11 +61,12 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
>  		{"cgroup",              optional_argument,      0, 'C'},
>  		{"debug",               no_argument,            0, 'D'},
>  		{"duration",            required_argument,      0, 'd'},
> +		{"event",               required_argument,      0, 'e'},
>  		{0, 0, 0, 0}
>  	};
>  
>  	opterr = 0;
> -	c = getopt_long(argc, argv, "c:C::Dd:", long_options, NULL);
> +	c = getopt_long(argc, argv, "c:C::Dd:e:", long_options, NULL);
>  	opterr = 1;
>  
>  	switch (c) {
> @@ -85,6 +87,15 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
>  		if (!common->duration)
>  			fatal("Invalid -d duration");
>  		break;
> +	case 'e':
> +		tevent = trace_event_alloc(optarg);
> +		if (!tevent)
> +			fatal("Error alloc trace event");
> +
> +		if (common->events)
> +			tevent->next = common->events;
> +		common->events = tevent;
> +		break;
>  	default:
>  		optind = saved_state;
>  		return 0;
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
> index 1b79bfefc214..c4013f50e803 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -469,7 +469,6 @@ static struct common_params
>  *osnoise_hist_parse_args(int argc, char *argv[])
>  {
>  	struct osnoise_params *params;
> -	struct trace_events *tevent;
>  	int retval;
>  	int c;
>  	char *trace_output = NULL;
> @@ -499,7 +498,6 @@ static struct common_params
>  			{"stop",		required_argument,	0, 's'},
>  			{"stop-total",		required_argument,	0, 'S'},
>  			{"trace",		optional_argument,	0, 't'},
> -			{"event",		required_argument,	0, 'e'},
>  			{"threshold",		required_argument,	0, 'T'},
>  			{"no-header",		no_argument,		0, '0'},
>  			{"no-summary",		no_argument,		0, '1'},
> @@ -517,7 +515,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:b:e:E:hH:p:P:r:s:S:t::T:01234:5:6:7:",
> +		c = getopt_long(argc, argv, "a:b:E:hH:p:P:r:s:S:t::T:01234:5:6:7:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -543,16 +541,6 @@ static struct common_params
>  			    params->common.hist.bucket_size >= 1000000)
>  				fatal("Bucket size needs to be > 0 and <= 1000000");
>  			break;
> -		case 'e':
> -			tevent = trace_event_alloc(optarg);
> -			if (!tevent)
> -				fatal("Error alloc trace event");
> -
> -			if (params->common.events)
> -				tevent->next = params->common.events;
> -
> -			params->common.events = tevent;
> -			break;
>  		case 'E':
>  			params->common.hist.entries = get_llong_from_str(optarg);
>  			if (params->common.hist.entries < 10 ||
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index 619c5bcf8f35..846d25ee4885 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -322,7 +322,6 @@ static void osnoise_top_usage(struct osnoise_params *params)
>  struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  {
>  	struct osnoise_params *params;
> -	struct trace_events *tevent;
>  	int retval;
>  	int c;
>  	char *trace_output = NULL;
> @@ -346,7 +345,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  	while (1) {
>  		static struct option long_options[] = {
>  			{"auto",		required_argument,	0, 'a'},
> -			{"event",		required_argument,	0, 'e'},
>  			{"house-keeping",	required_argument,	0, 'H'},
>  			{"help",		no_argument,		0, 'h'},
>  			{"period",		required_argument,	0, 'p'},
> @@ -369,7 +367,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:e:hH:p:P:qr:s:S:t::T:0:1:2:3:",
> +		c = getopt_long(argc, argv, "a:hH:p:P:qr:s:S:t::T:0:1:2:3:",
>  				 long_options, NULL);
>  
>  		/* Detect the end of the options. */
> @@ -388,16 +386,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  			if (!trace_output)
>  				trace_output = "osnoise_trace.txt";
>  
> -			break;
> -		case 'e':
> -			tevent = trace_event_alloc(optarg);
> -			if (!tevent)
> -				fatal("Error alloc trace event");
> -
> -			if (params->common.events)
> -				tevent->next = params->common.events;
> -			params->common.events = tevent;
> -
>  			break;
>  		case 'h':
>  		case '?':
> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
> index 0a7e5dcce121..4744f84a452e 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -766,7 +766,6 @@ static struct common_params
>  *timerlat_hist_parse_args(int argc, char *argv[])
>  {
>  	struct timerlat_params *params;
> -	struct trace_events *tevent;
>  	int auto_thresh;
>  	int retval;
>  	int c;
> @@ -810,7 +809,6 @@ static struct common_params
>  			{"user-threads",	no_argument,		0, 'u'},
>  			{"kernel-threads",	no_argument,		0, 'k'},
>  			{"user-load",		no_argument,		0, 'U'},
> -			{"event",		required_argument,	0, 'e'},
>  			{"no-irq",		no_argument,		0, '0'},
>  			{"no-thread",		no_argument,		0, '1'},
>  			{"no-header",		no_argument,		0, '2'},
> @@ -833,7 +831,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:b:e:E:hH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
> +		c = getopt_long(argc, argv, "a:b:E:hH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -862,16 +860,6 @@ static struct common_params
>  			    params->common.hist.bucket_size >= 1000000)
>  				fatal("Bucket size needs to be > 0 and <= 1000000");
>  			break;
> -		case 'e':
> -			tevent = trace_event_alloc(optarg);
> -			if (!tevent)
> -				fatal("Error alloc trace event");
> -
> -			if (params->common.events)
> -				tevent->next = params->common.events;
> -
> -			params->common.events = tevent;
> -			break;
>  		case 'E':
>  			params->common.hist.entries = get_llong_from_str(optarg);
>  			if (params->common.hist.entries < 10 ||
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> index 4340fbf3f879..b77e5b6550a1 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -538,7 +538,6 @@ static struct common_params
>  *timerlat_top_parse_args(int argc, char **argv)
>  {
>  	struct timerlat_params *params;
> -	struct trace_events *tevent;
>  	long long auto_thresh;
>  	int retval;
>  	int c;
> @@ -566,7 +565,6 @@ static struct common_params
>  	while (1) {
>  		static struct option long_options[] = {
>  			{"auto",		required_argument,	0, 'a'},
> -			{"event",		required_argument,	0, 'e'},
>  			{"help",		no_argument,		0, 'h'},
>  			{"house-keeping",	required_argument,	0, 'H'},
>  			{"irq",			required_argument,	0, 'i'},
> @@ -597,7 +595,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:e:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
> +		c = getopt_long(argc, argv, "a:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -634,15 +632,6 @@ static struct common_params
>  			/* set aa_only to avoid parsing the trace */
>  			params->common.aa_only = 1;
>  			break;
> -		case 'e':
> -			tevent = trace_event_alloc(optarg);
> -			if (!tevent)
> -				fatal("Error alloc trace event");
> -
> -			if (params->common.events)
> -				tevent->next = params->common.events;
> -			params->common.events = tevent;
> -			break;
>  		case 'h':
>  		case '?':
>  			timerlat_top_usage();
> -- 
> 2.52.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

