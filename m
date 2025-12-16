Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6D62ED161
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901925; cv=none; b=KBqZiLPrgmghvsfXfx2PtQZj2dXOVu4cuq/QfbLKwAAh+lNTz9Ofo2ToCXXrMJe27hVUmX1iFYJch94MGHEykdFl0U8UXEm2HKJ7nzsBebwNa5OmeC7m7RxF2xEEvdI7qMiEi2LfP/qV362Y+uSQ2u7l0LW7NTJTAhCU6dLFtr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901925; c=relaxed/simple;
	bh=PXp0HFbzjk98DHP8qMrXbqRdiTpqVaeLOz0rpgaRM+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrJC5AlO+5Kw8NqXdGl9+ONN/ntemMrCcSK8kExQ5QmQ+1ok5AQti2Z+4TFuPRMZlnilvs44JGEX02Dj2jzHhoUHIntb/RdBCX9Czc2s3TvGHU0fqF31gfbBmlkxJNRWIhpKbSn4B8KSQv3F/olNHVfwYQd2Qauu3I5X4wd5osQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDh+Fun0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDh+Fun0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765901920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JN3PXKAKTYbjWwuatBvquXlMB9AKk/RK3tEKKgwtMVE=;
	b=GDh+Fun0LmBSYt2r41A9eM/dJKpJEDthjYaHJpqitqCTqEjSBJzyq/bF6Ac5OyCB0IF1cB
	YItpKIOmS/OqyjCG1kFfq74SvSf2SDwU8qsxIPilFFGckpL5fNSe6xD55Ae0acJp16H8Mu
	7V8xaLvRDa6sG7DkCYOiO4BDqBMP73M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-iP9WsvhhMNaoAa2HFSm-jQ-1; Tue,
 16 Dec 2025 11:18:34 -0500
X-MC-Unique: iP9WsvhhMNaoAa2HFSm-jQ-1
X-Mimecast-MFC-AGG-ID: iP9WsvhhMNaoAa2HFSm-jQ_1765901913
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A76FA195FCF7;
	Tue, 16 Dec 2025 16:18:33 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.62])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7086D19560B2;
	Tue, 16 Dec 2025 16:18:28 +0000 (UTC)
Date: Tue, 16 Dec 2025 13:18:26 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] tools/rtla: Consolidate -P/--priority option
 parsing
Message-ID: <pxadmwwfmz37ltqz6ob76znmonl7myjagr4ex2efnnxawbdybd@2ywrxciu5udd>
References: <20251209100047.2692515-1-costa.shul@redhat.com>
 <20251209100047.2692515-7-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209100047.2692515-7-costa.shul@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Dec 09, 2025 at 12:00:46PM +0200, Costa Shulyupin wrote:
> Each rtla tool duplicates parsing of -P/--priority.
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
> index 684ff49f0a4c..e042b2d9dbf5 100644
> --- a/tools/tracing/rtla/src/common.c
> +++ b/tools/tracing/rtla/src/common.c
> @@ -62,11 +62,12 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
>  		{"debug",               no_argument,            0, 'D'},
>  		{"duration",            required_argument,      0, 'd'},
>  		{"event",               required_argument,      0, 'e'},
> +		{"priority",            required_argument,      0, 'P'},
>  		{0, 0, 0, 0}
>  	};
>  
>  	opterr = 0;
> -	c = getopt_long(argc, argv, "c:C::Dd:e:", long_options, NULL);
> +	c = getopt_long(argc, argv, "c:C::Dd:e:P:", long_options, NULL);
>  	opterr = 1;
>  
>  	switch (c) {
> @@ -96,6 +97,11 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
>  			tevent->next = common->events;
>  		common->events = tevent;
>  		break;
> +	case 'P':
> +		if (parse_prio(optarg, &common->sched_param) == -1)
> +			fatal("Invalid -P priority");
> +		common->set_sched = 1;
> +		break;
>  	default:
>  		optind = saved_state;
>  		return 0;
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
> index c4013f50e803..6ed5f5594960 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -493,7 +493,6 @@ static struct common_params
>  			{"house-keeping",	required_argument,		0, 'H'},
>  			{"help",		no_argument,		0, 'h'},
>  			{"period",		required_argument,	0, 'p'},
> -			{"priority",		required_argument,	0, 'P'},
>  			{"runtime",		required_argument,	0, 'r'},
>  			{"stop",		required_argument,	0, 's'},
>  			{"stop-total",		required_argument,	0, 'S'},
> @@ -515,7 +514,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:b:E:hH:p:P:r:s:S:t::T:01234:5:6:7:",
> +		c = getopt_long(argc, argv, "a:b:E:hH:p:r:s:S:t::T:01234:5:6:7:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -562,12 +561,6 @@ static struct common_params
>  			if (params->period > 10000000)
>  				fatal("Period longer than 10 s");
>  			break;
> -		case 'P':
> -			retval = parse_prio(optarg, &params->common.sched_param);
> -			if (retval == -1)
> -				fatal("Invalid -P priority");
> -			params->common.set_sched = 1;
> -			break;
>  		case 'r':
>  			params->runtime = get_llong_from_str(optarg);
>  			if (params->runtime < 100)
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index 846d25ee4885..d2dfad960440 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -348,7 +348,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  			{"house-keeping",	required_argument,	0, 'H'},
>  			{"help",		no_argument,		0, 'h'},
>  			{"period",		required_argument,	0, 'p'},
> -			{"priority",		required_argument,	0, 'P'},
>  			{"quiet",		no_argument,		0, 'q'},
>  			{"runtime",		required_argument,	0, 'r'},
>  			{"stop",		required_argument,	0, 's'},
> @@ -367,7 +366,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:hH:p:P:qr:s:S:t::T:0:1:2:3:",
> +		c = getopt_long(argc, argv, "a:hH:p:qr:s:S:t::T:0:1:2:3:",
>  				 long_options, NULL);
>  
>  		/* Detect the end of the options. */
> @@ -402,12 +401,6 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  			if (params->period > 10000000)
>  				fatal("Period longer than 10 s");
>  			break;
> -		case 'P':
> -			retval = parse_prio(optarg, &params->common.sched_param);
> -			if (retval == -1)
> -				fatal("Invalid -P priority");
> -			params->common.set_sched = 1;
> -			break;
>  		case 'q':
>  			params->common.quiet = 1;
>  			break;
> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
> index 4744f84a452e..e7ba083b5eb4 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -802,7 +802,6 @@ static struct common_params
>  			{"irq",			required_argument,	0, 'i'},
>  			{"nano",		no_argument,		0, 'n'},
>  			{"period",		required_argument,	0, 'p'},
> -			{"priority",		required_argument,	0, 'P'},
>  			{"stack",		required_argument,	0, 's'},
>  			{"thread",		required_argument,	0, 'T'},
>  			{"trace",		optional_argument,	0, 't'},
> @@ -831,7 +830,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:b:E:hH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
> +		c = getopt_long(argc, argv, "a:b:E:hH:i:knp:s:t::T:uU0123456:7:8:9\1\2:\3:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -890,12 +889,6 @@ static struct common_params
>  			if (params->timerlat_period_us > 1000000)
>  				fatal("Period longer than 1 s");
>  			break;
> -		case 'P':
> -			retval = parse_prio(optarg, &params->common.sched_param);
> -			if (retval == -1)
> -				fatal("Invalid -P priority");
> -			params->common.set_sched = 1;
> -			break;
>  		case 's':
>  			params->print_stack = get_llong_from_str(optarg);
>  			break;
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> index b77e5b6550a1..8250bea4b2fd 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -570,7 +570,6 @@ static struct common_params
>  			{"irq",			required_argument,	0, 'i'},
>  			{"nano",		no_argument,		0, 'n'},
>  			{"period",		required_argument,	0, 'p'},
> -			{"priority",		required_argument,	0, 'P'},
>  			{"quiet",		no_argument,		0, 'q'},
>  			{"stack",		required_argument,	0, 's'},
>  			{"thread",		required_argument,	0, 'T'},
> @@ -595,7 +594,7 @@ static struct common_params
>  		if (common_parse_options(argc, argv, &params->common))
>  			continue;
>  
> -		c = getopt_long(argc, argv, "a:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
> +		c = getopt_long(argc, argv, "a:hH:i:knp:qs:t::T:uU0:1:2:345:6:7:",
>  				 long_options, NULL);
>  
>  		/* detect the end of the options. */
> @@ -656,12 +655,6 @@ static struct common_params
>  			if (params->timerlat_period_us > 1000000)
>  				fatal("Period longer than 1 s");
>  			break;
> -		case 'P':
> -			retval = parse_prio(optarg, &params->common.sched_param);
> -			if (retval == -1)
> -				fatal("Invalid -P priority");
> -			params->common.set_sched = 1;
> -			break;
>  		case 'q':
>  			params->common.quiet = 1;
>  			break;
> -- 
> 2.52.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

