Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C80E2FFF9B;
	Tue,  6 Jan 2026 06:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767679850; cv=none; b=MNZvP7/h2TW/UDqTduKOlKocPmcS/oYkmtU/PBJOShZuzdsYAwCAZWbsVJd/cM3Ur9CKtV+YqesblA4/m6+vW8M4zidlHp9fMPqg/tC0c9NIsq/PKTjLdARqvlMJPS/m1qSGqe8nL04JvTzH6D5KMyRuNy/hE+G/UHwmjtxm1iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767679850; c=relaxed/simple;
	bh=yDnqfx7Xtpqg/kBnR5uF+gu4LSY2j5dxsPSmxheg0/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t85ewUGtWcLa6i1WTSQjwRVVR8K5ZOv6qyweUXQws34q0S5LlJuFivu2K14deSklQxzIPC06uHa3kovOexBPUgK1HTGNvgHT5BkTt2az+SQBlYjcrte4bTUoDJ3W0nJvk4N0t/ZGBh/ERUX2N0N64KHU4PRMOHCS0EpIuIdxet4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ipWsFnd+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ipWsFnd+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/0GUmICIrAvBdSBnhOk5as4wAwpoKO0AzhZXINqW1zU=; b=ipWsFnd+o90CBmcfFlq2NhJgv5
	wi/5IKUTMVpIQpZWYn94CEhPyyJauFMlnFi7kaqTdjPDNINCp3Q4S/h4sKDdHpQ2cfcm4c5ZS5YGu
	vwO+s3IjkCjQHbZqmYvmxKbB1YrK9Xd5Kk8ZdAqtIragDrBeUwHcdZIZ4CA4ZiLcRo1dTiBSwa12v
	IfHuY+IXRCisvFMbqgRsLpA+7unVWn8ck28QftCNpE1h6N94yGlvY2JiXGEy7IzdGk7VnM1nPd9+H
	mDA51StgIssSPbJmayEB4psIa+EoWu56++GvdF84lv2bv8xg1QxHDvHRasDqI02xK4CdUxqmo5nZf
	F/Z9Vjqg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd0HA-0000000CST1-10q4;
	Tue, 06 Jan 2026 06:10:41 +0000
Message-ID: <95feb439-2298-4539-8833-e05ed06f273b@infradead.org>
Date: Mon, 5 Jan 2026 22:10:39 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH 2/2] tracing: Add show_event_triggers to expose active
 event triggers
To: Aaron Tomlin <atomlin@atomlin.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 corbet@lwn.net
Cc: neelx@suse.com, sean@ashe.io, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260105142939.2655342-1-atomlin@atomlin.com>
 <20260105142939.2655342-3-atomlin@atomlin.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260105142939.2655342-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/5/26 6:29 AM, Aaron Tomlin wrote:
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 4ce01e726b09..b9efb148a5c2 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -692,6 +692,14 @@ of ftrace. Here is a list of some of the key files:
>  
>  	See events.rst for more information.
>  
> +  show_event_triggers:
> +
> +	A list of events that have triggers. This shows the
> +	system/event pair along with the trigger that is attached to
> +	the event.
> +
> +	See events.rst for more information.
> +

Isn't this the same chunk that was in patch 1/2?

>    available_events:
>  
>  	A list of events that can be enabled in tracing.

-- 
~Randy

