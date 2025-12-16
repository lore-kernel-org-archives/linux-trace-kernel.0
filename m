Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFC2280338
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765901781; cv=none; b=eBN5LnHUbuOGSUixdSmNcmCToP00sSldraCTo3DmCO2ETJVOP1vqsXyHC6gP+KeDXx+ZfAm6E0PPhwv2HwebBjzKLJjQ8M/VyTDXt1ZruO5aQTbCITlQPembE2wufZX57g7yOAbIRg/Bqf0W56PoXZToJfX2sU7uI2aqjG2X0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765901781; c=relaxed/simple;
	bh=z2seVOwhK7KoCFcnQi/bu9/JzM7sL/c083UPiTw1n9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgTwvsO/RmEeKBD5CNQOmTj878OhYedd7+uRWmdXAQHubH78Ez5Dq8u+ypGBCsSkEIWRg1C8adiC9thzmlNHfVyRLl2EvJuHYK9keudE87k03wTje50W3WZdq8tiaBS6gXDvrctfpQV1O+tQ/b3Um40IeWS5qIKehbnUqBgdvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+TJ4spG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+TJ4spG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765901778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SDqWzX41CaWzUB+gNufmJSXxNvGAkQ78nOrVnPw+Yn8=;
	b=J+TJ4spGIdDr+n7eoTh9iJr0VUadyqWDcY++MWBdRx8jspTDVoSdGhEQ4ylGtEp4RGgWba
	Vu0oSVnsHmMGXQiO2XGr8WUbAKuFxGqfn/OHmP3R/IUq0JAnXKYVxgzbbunic4KFnLthYG
	aznI0AbOUaFGJ6KyDtXoF/iPWgfO73E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-2jh_-OfaPN2T5Hm4_aunDw-1; Tue,
 16 Dec 2025 11:16:16 -0500
X-MC-Unique: 2jh_-OfaPN2T5Hm4_aunDw-1
X-Mimecast-MFC-AGG-ID: 2jh_-OfaPN2T5Hm4_aunDw_1765901775
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75E4D1955F34;
	Tue, 16 Dec 2025 16:16:15 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.80.62])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 132201955F24;
	Tue, 16 Dec 2025 16:16:11 +0000 (UTC)
Date: Tue, 16 Dec 2025 13:16:10 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] tools/rtla: Add common_parse_options()
Message-ID: <gn5hxzkearslf44kel63ytwwxasvwefdhb4w3fudwehw3xtj26@hksywj6prp7s>
References: <20251209100047.2692515-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209100047.2692515-1-costa.shul@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Dec 09, 2025 at 12:00:40PM +0200, Costa Shulyupin wrote:
> Each rtla tool duplicates parsing of many common options. This creates
> maintenance overhead and risks inconsistencies when updating these
> options.
> 
> Add common_parse_options() to centralize parsing of options used across
> all tools.
> 
> Common options to be migrated in future patches.
> 
> Changes since v1:
> - restore opterr
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/common.c        | 35 ++++++++++++++++++++++++++
>  tools/tracing/rtla/src/common.h        |  1 +
>  tools/tracing/rtla/src/osnoise_hist.c  |  3 +++
>  tools/tracing/rtla/src/osnoise_top.c   |  3 +++
>  tools/tracing/rtla/src/timerlat_hist.c |  3 +++
>  tools/tracing/rtla/src/timerlat_top.c  |  3 +++
>  6 files changed, 48 insertions(+)
> 
> diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
> index b197037fc58b..a78f9883521e 100644
> --- a/tools/tracing/rtla/src/common.c
> +++ b/tools/tracing/rtla/src/common.c
> @@ -5,6 +5,7 @@
>  #include <signal.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> +#include <getopt.h>
>  #include "common.h"
>  
>  struct trace_instance *trace_inst;
> @@ -37,6 +38,40 @@ static void set_signals(struct common_params *params)
>  	}
>  }
>  
> +/*
> + * common_parse_options - parse common command line options
> + *
> + * @argc: argument count
> + * @argv: argument vector
> + * @common: common parameters structure
> + *
> + * Parse command line options that are common to all rtla tools.
> + *
> + * Returns: non zero if a common option was parsed, or 0
> + * if the option should be handled by tool-specific parsing.
> + */
> +int common_parse_options(int argc, char **argv, struct common_params *common)
> +{
> +	int saved_state = optind;
> +	int c;
> +
> +	static struct option long_options[] = {
> +		{0, 0, 0, 0}
> +	};
> +
> +	opterr = 0;
> +	c = getopt_long(argc, argv, "", long_options, NULL);
> +	opterr = 1;
> +
> +	switch (c) {
> +	default:
> +		optind = saved_state;
> +		return 0;
> +	}
> +
> +	return c;
> +}
> +
>  /*
>   * common_apply_config - apply common configs to the initialized tool
>   */
> diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
> index 9ec2b7632c37..1066d777a823 100644
> --- a/tools/tracing/rtla/src/common.h
> +++ b/tools/tracing/rtla/src/common.h
> @@ -153,6 +153,7 @@ struct osnoise_tool *osnoise_init_tool(char *tool_name);
>  struct osnoise_tool *osnoise_init_trace_tool(const char *tracer);
>  bool osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *record);
>  
> +int common_parse_options(int argc, char **argv, struct common_params *common);
>  int common_apply_config(struct osnoise_tool *tool, struct common_params *params);
>  int top_main_loop(struct osnoise_tool *tool);
>  int hist_main_loop(struct osnoise_tool *tool);
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
> index ff8c231e47c4..35f4a068af95 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -518,6 +518,9 @@ static struct common_params
>  			{0, 0, 0, 0}
>  		};
>  
> +		if (common_parse_options(argc, argv, &params->common))
> +			continue;
> +
>  		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:p:P:r:s:S:t::T:01234:5:6:7:",
>  				 long_options, NULL);
>  
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index 04c699bdd736..550731c7addd 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -370,6 +370,9 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
>  			{0, 0, 0, 0}
>  		};
>  
> +		if (common_parse_options(argc, argv, &params->common))
> +			continue;
> +
>  		c = getopt_long(argc, argv, "a:c:C::d:De:hH:p:P:qr:s:S:t::T:0:1:2:3:",
>  				 long_options, NULL);
>  
> diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
> index 1fb471a787b7..ffcfcabb9964 100644
> --- a/tools/tracing/rtla/src/timerlat_hist.c
> +++ b/tools/tracing/rtla/src/timerlat_hist.c
> @@ -834,6 +834,9 @@ static struct common_params
>  			{0, 0, 0, 0}
>  		};
>  
> +		if (common_parse_options(argc, argv, &params->common))
> +			continue;
> +
>  		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
>  				 long_options, NULL);
>  
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
> index 29c2c1f717ed..d18d48671ccd 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -598,6 +598,9 @@ static struct common_params
>  			{0, 0, 0, 0}
>  		};
>  
> +		if (common_parse_options(argc, argv, &params->common))
> +			continue;
> +
>  		c = getopt_long(argc, argv, "a:c:C::d:De:hH:i:knp:P:qs:t::T:uU0:1:2:345:6:7:",
>  				 long_options, NULL);
>  
> -- 
> 2.52.0
> 

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

