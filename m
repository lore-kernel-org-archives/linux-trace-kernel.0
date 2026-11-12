Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478393;
	b=i3m0WwzcphB3eOOizcJ4KgJCR+novJkdJt1TJmq8vmMSbQRoFg33AQR2eWyUNEGVj/vW
	 hY+Wf/W1Au3QridhOXxKSuStyrt5hT58wz3/ULj+0z/AQRU3yx7aWmYWCGBRgI/47qS5V
	 yK6C6R+otqQbKKvDwJQQeuBfFMdvot8lddVnZKryLv3/WMe8yQZk0vHI4l2XpJSlY9CVR
	 8AS3Ysd7MSmnZq7phu7nc7Mn6pLFM/7Ej1jBt+tc0nVbUxaWJ/Ood+AekdqNNIvCDq/zf
	 rCaQIH43od0zqVii3sLuKIck3qiDXBp+WTZ6wKRlMX+Q6zGwWg3dCP9lAIKWKkBmvcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478393;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=2BmWYKOiyjIsi4QXb/VAu1SFL4RNR0NUHUQfqyXSb28=;
	b=Ot5xTx6+HX2NgvRpSvOlrSP2WQARgUsowmxNVGMgj3NOXWWdc3BcG+xO3RkoVWbkFVSA
	 163hUzqiBwqV/EaZTwsf7rYuPz8+P+uf1iYv6KCKZ1lxUyEJ7gHdAMnWXrMX3L2Y66HDW
	 lwtlVihE8drisFUEoMD0GbWOJAxwZekvxhrA4uYcQGjSAHecckYD8tchDYimhAMz3Afy4
	 IoyUVzM0szdDadXdQoN6upWfyDnLxvN8UxK/JUc1ALdFlu8320VAWDH6EKLrRJOW3whg8
	 WayHChyk+NSjJugkt7NDVgEUkRSsmxBHc7lTO+wMtsleDILxim/rnKs8NBUkOcd7+ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=q0TPU5yP;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604B606A323;
	Thu, 12 Nov 2026 10:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9604B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=q0TPU5yP
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id C61571A055D;
	Thu, 12 Nov 2026 10:13:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 14D266000F;
	Thu, 12 Nov 2026 10:13:03 +0000 (UTC)
Date: Thu, 12 Nov 2026 05:12:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Wenwu Hou <hwenwur@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/hwlat: Store the maximum latency in nanoseconds
Message-ID: <20261112051249.7c19f22e@fedora>
In-Reply-To: <20261111031304.1442318-1-hwenwur@gmail.com>
References: <20261111031304.1442318-1-hwenwur@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4fy5uz88u5rz8yxckudtndmo5esdexp6
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 14D266000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX198Fmx32fbNpCc2swGmT014WFRtB7xiuzE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=2BmWYKOiyjIsi4QXb/VAu1SFL4RNR0NUHUQfqyXSb28=; b=q0TPU5yPLZ947aX3Sv3isuOYZBA7m2KqP762P/02ChGLc6vvPi3+qhkwOX7XLjBCSH1wp2Wxihf264VSdeWIX1XHdIsIqWoH5B3Bww0FFqONTl5WPZWRLDRi61cw/bwR1zvdWYxJACh5iXbWtX0OcK2qlavTYf6dXp1CiJ/GPGY=
X-HE-Tag: 1794478383-904335
X-HE-Meta: U2FsdGVkX1+Afnel4CygBPUzz6ifRPiBAp2WGZmEnf5aajhccC3buV9ITyD0sRbT2qBarctUj7GMLNH0pEmdUy8M+YF7/AFduefpXVF7Ngd7ytBKF7XnY7lg5vBy1Nq9F2MRpa5MaOS1dEKhekwfqoyQkudIJfTU27ify8xrU6sU2FcgXP+fC4t03pLcfcIaTi1URKGjlcAfy54/3Mos5uL+ZofYT0kAc3pzP9gjt/2wqMGOQbaEumEtNyGEOAZWVP5MYQY3lnFhuQqYf64D/K/Z7XsItUMKLw1SmSVdVT7rU05CVvZt4e/Y4uyDFVBOKvu7XsoOESQZeLdyIRb72EugCaEQY9ag

On Wed, 11 Nov 2026 11:13:04 +0800
Wenwu Hou <hwenwur@gmail.com> wrote:

> tr->max_latency is expected to hold nanoseconds: tracing_max_lat_read()
> converts it with nsecs_to_usecs() to print the usecs documented in
> hwlat_detector.rst, and the other latency tracers store nanoseconds there
> too.
> 
> Fixes: e7c15cd8a1133 ("tracing: Added hardware latency tracer")
> Signed-off-by: Wenwu Hou <hwenwur@gmail.com>

Amazing that this bug has been here for 10 years and nobody noticed.

> ---
>  kernel/trace/trace_hwlat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index 65e184d800ff1..701b6a542e51a 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -293,7 +293,7 @@ static int get_sample(void)
>  		s.count = count;
>  		trace_hwlat_sample(&s);
>  
> -		latency = max(sample, outer_sample);
> +		latency = max(sample, outer_sample) * NSEC_PER_USEC;

The real fix is to just use nanoseconds in the calculations. The only
reason it was doing the conversions was to match max_latency anyway.

The time recorded in the events would need to be converted to
microseconds too, if the raw numbers are in nanos.

Thanks,

-- Steve


>  
>  		/* Keep a running maximum ever recorded hardware latency */
>  		if (latency > tr->max_latency) {

