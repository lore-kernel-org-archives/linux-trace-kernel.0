Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1B6288D6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901833; cv=none; b=BQ++0uOdPDo4W4++rRTt/b2Hx4VSmQY8sGXq0a9PRuPN/DefqaPJO1opJ5tdpqj7OaHjIePNXfN2bQjTXJErlz8BmWeiiRjJXQ2+YvvgPw1CeoqAbZS/sppj8O1Rcz8XXlyH6uvCJz09f7EeR05xpK3T2KnKe0KRXmUW2tBFa0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901833; c=relaxed/simple;
	bh=ZutuAkJ/OCL18Iz80zKijAC2a3ErEMPLqvnYx9hOyR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovW7vq7a3X6kGTcAzWOkgUekkIOyOFGrkNov7vQdZ813SvjrHCiGLNUzK0BrkmWjwHEUy0C25yTl+oeHlwBi6gNlpFJ5tvPK0Wh42Jh3ib1QAS+YeBhi2XaOUbhAUHMSevi2SWmw5Un3hhFa0OF9UWcDspagk1/RUrTZ7hjjn2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwlSN3G1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwlSN3G1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765901830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqzEcfVNwNKyyz1NLGKT/MRChymMURvLi54yGUR3JfQ=;
	b=iwlSN3G1sQWr6JRnP9llT8NKz60wctusbNYLomcw8e1Frwl9oRlwuMmpzejjV9yuf/A8XJ
	cSUBN64LswSPrfv3ZXSgKJyGnq10x1iHaH0mLu8W/kp9LoeL5w8hddiggCknRuVpE1iBAP
	6jUs7GWRmhOHmTmjz8KjLTUg7xN1V/o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-xDUSfuVIM1eZLWLXV8f0Pw-1; Tue,
 16 Dec 2025 11:17:06 -0500
X-MC-Unique: xDUSfuVIM1eZLWLXV8f0Pw-1
X-Mimecast-MFC-AGG-ID: xDUSfuVIM1eZLWLXV8f0Pw_1765901825
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8AE21956068;
	Tue, 16 Dec 2025 16:17:05 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.62])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E2EB330001A2;
	Tue, 16 Dec 2025 16:17:01 +0000 (UTC)
Date: Tue, 16 Dec 2025 13:17:00 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] tools/rtla: Consolidate -C/--cgroup option parsing
Message-ID: <tazkdgebtw7sgrw7cjrntde6hpcqqlbg7spllkquqxsqowj2uo@xegmfpfkgps7>
References: <20251209100047.2692515-1-costa.shul@redhat.com>
 <20251209100047.2692515-3-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209100047.2692515-3-costa.shul@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Dec 09, 2025 at 12:00:42PM +0200, Costa Shulyupin wrote:
> Each rtla tool duplicates parsing of -C/--cgroup.
> 
> Migrate the option parsing from individual tools to the
> common_parse_options().
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/common.c        | 7 ++++++-
>  tools/tracing/rtla/src/osnoise_hist.c  | 7 +------
>  tools/tracing/rtla/src/osnoise_top.c   | 7 +------
>  tools/tracing/rtla/src/timerlat_hist.c | 7 +------
>  tools/tracing/rtla/src/timerlat_top.c  | 7 +------
>  5 files changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
> index e5aa8c30cd7d..33428fa77f9f 100644
> --- a/tools/tracing/rtla/src/common.c
> +++ b/tools/tracing/rtla/src/common.c
> @@ -57,11 +57,12 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
>  
>  	static struct option long_options[] = {
>  		{"cpus",                required_argument,      0, 'c'},
> +		{"cgroup",              optional_argument,      0, 'C'},
>  		{0, 0, 0, 0}
>  	};
>  
>  	opterr = 0;
> -	c = getopt_long(argc, argv, "c:", long_options, NULL);
> +	c = getopt_long(argc, argv, "c:C::", long_options, NULL);
>  	opterr = 1;
>  
>  	switch (c) {
> @@ -70,6 +71,10 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
>  			fatal("Invalid -c cpu list");
>  		common->cpus = optarg;
>  		break;
> +	case 'C':
> +		common->cgroup = 1;
> +		common->cgroup_name = parse_optional_arg(argc, argv);
> +		break;
>  	default:
>  		optind = saved_state;
>  		return 0;
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
> index 9e721362989a..5cbe5e1f1b07 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -491,7 +491,6 @@ static struct common_params
>  			{"auto",		required_argument,	0, 'a'},
>  			{"bucket-size",		required_argument,	0, 'b'},
>  			{"entries",		required_argument,	0, 'E'},
> -			{"cgroup",		optional_argument,	0, 'C'},
>  			{"debug",		no_argument,		0, 'D'},
>  			{"duration",		required_argument,	0, 'd'},
>  			{"house-keeping",	required_argument,		0, 'H'},
> @@ -520,7 +519,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:7:",
> +		c = getopt_long(argc, argv, "a:b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:7:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -546,10 +545,6 @@ static struct common_params
>  			    params->common.hist.bucket_size >= 1000000)
>  				fatal("Bucket size needs to be > 0 and <= 1000000");
>  			break;
> -		case 'C':
> -			params->common.cgroup = 1;
> -			params->common.cgroup_name = parse_optional_arg(argc, argv);
> -			break;
>  		case 'D':
>  			config_debug = 1;
>  			break;
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index 73736cefd992..35db5b73c0d7 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -346,7 +346,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  	while (1) {
>  		static struct option long_options[] = {
>  			{"auto",		required_argument,	0, 'a'},
> -			{"cgroup",		optional_argument,	0, 'C'},
>  			{"debug",		no_argument,		0, 'D'},
>  			{"duration",		required_argument,	0, 'd'},
>  			{"event",		required_argument,	0, 'e'},
> @@ -372,7 +371,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:C::d:De:hH:p:P:qr:s:S:t::T:0:1:2:3:",
> +		c = getopt_long(argc, argv, "a:d:De:hH:p:P:qr:s:S:t::T:0:1:2:3:",
>  				 long_options, NULL);
>  
>  		/* Detect the end of the options. */
> @@ -391,10 +390,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  			if (!trace_output)
>  				trace_output = "osnoise_trace.txt";
>  
> -			break;
> -		case 'C':
> -			params->common.cgroup = 1;
> -			params->common.cgroup_name = parse_optional_arg(argc, argv);
>  			break;
>  		case 'D':
>  			config_debug = 1;
> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
> index 4ae77145adea..9ecab2bb0f1e 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -796,7 +796,6 @@ static struct common_params
>  	while (1) {
>  		static struct option long_options[] = {
>  			{"auto",		required_argument,	0, 'a'},
> -			{"cgroup",		optional_argument,	0, 'C'},
>  			{"bucket-size",		required_argument,	0, 'b'},
>  			{"debug",		no_argument,		0, 'D'},
>  			{"entries",		required_argument,	0, 'E'},
> @@ -836,7 +835,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
> +		c = getopt_long(argc, argv, "a:b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -858,10 +857,6 @@ static struct common_params
>  			if (!trace_output)
>  				trace_output = "timerlat_trace.txt";
>  
> -			break;
> -		case 'C':
> -			params->common.cgroup = 1;
> -			params->common.cgroup_name = parse_optional_arg(argc, argv);
>  			break;
>  		case 'b':
>  			params->common.hist.bucket_size = get_llong_from_str(optarg);
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> index 9774c26b27ff..6329c3a489aa 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -566,7 +566,6 @@ static struct common_params
>  	while (1) {
>  		static struct option long_options[] = {
>  			{"auto",		required_argument,	0, 'a'},
> -			{"cgroup",		optional_argument,	0, 'C'},
>  			{"debug",		no_argument,		0, 'D'},
>  			{"duration",		required_argument,	0, 'd'},
>  			{"event",		required_argument,	0, 'e'},
> @@ -600,7 +599,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
> +		c = getopt_long(argc, argv, "a:d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -637,10 +636,6 @@ static struct common_params
>  			/* set aa_only to avoid parsing the trace */
>  			params->common.aa_only = 1;
>  			break;
> -		case 'C':
> -			params->common.cgroup = 1;
> -			params->common.cgroup_name = optarg;
> -			break;
>  		case 'D':
>  			config_debug = 1;
>  			break;
> -- 
> 2.52.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

