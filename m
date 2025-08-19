Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9FD20469E;
	Tue, 19 Aug 2025 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623884; cv=none; b=PD86zns/UMKg/8N7//E0RGW3DzNGXHMNBrNCeadt9kLamMlTzihiz+x4qoAEfeg285UKq5mJ5dTFhH+3oOC5rV7hedXFadX18oWKVlcc2Nt0/EG01JA+kw3+aT8vvLw6n5Jqj0ab2chxD3IssKYy4J++rL24famwGVnwlZyC3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623884; c=relaxed/simple;
	bh=y1gn1ppItBT617iahNUSOTZgBrO3Bemxe7cvYxvwW40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeOflyVgOa90+3Mib4ctgRWLPDUnVClXxzTFv3pHVWU45D7hyPx+ZU/k+hb/6FllwRSdqqcewp4VkI/8gTQ65Hjva0ctYDShsXjo+2vRBocUB28EFneW/e9CrswHUA076lFx4stae5wcu9G4m6oAMczJYrm9r7JzQK41XYfZtjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S5hyOat3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S5hyOat3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=k9T40x/ryGpUQ+rzosuC/CwY1mQ6mOTPssvplMLxzqQ=; b=S5hyOat3F9Jn4VPib3g33Aa51X
	8uyAL+EX5AjjqOkt3IL/YTNdbc64xw4I8jHAGf7ZIc5mFPYqRXvA33pEtaicW9cXJbroan14BbNjC
	D52IneFLVo/MFGY1A75ChVFA1L+PkFgPP6Xi0dmtc6YAViuKaqNkveMbmsCGyH5MTtJLc4imNeC4r
	rt20n3kEgCXtk/UbPXQ1aT2dmjSHNw8mqhkoV2t0R6fPsUDXWB2N4LgFXvQe+UzqUt7yEQZpxZKsM
	FGCoidSZB2jxco10AsO2N31RXWxHN1yd4Nt8ZG829xRAuKw6TSSetTAToKDypOOC7uBZ4B39RycyV
	9GwY/X5w==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoPyD-0000000B5HL-1ezR;
	Tue, 19 Aug 2025 17:18:01 +0000
Message-ID: <d14df81f-989f-4467-aa0c-5c65009fd66d@infradead.org>
Date: Tue, 19 Aug 2025 10:18:00 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Corrected typo in trace/events
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
 linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 corbet@lwn.net
Cc: linux-kernel-mentees@lists.linuxfoundation.org, mhiramat@kernel.org,
 rostedt@goodmis.org
References: <20250819085040.974388-1-mehdi.benhadjkhelifa@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250819085040.974388-1-mehdi.benhadjkhelifa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/19/25 1:49 AM, Mehdi Ben Hadj Khelifa wrote:
> -Changed 'Dyamically' to 'Dynamically' in trace/events.rst
> 
> under sections 7.1 and 7.3
> 
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/trace/events.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> index 2d88a2acacc0..18d112963dec 100644
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -629,8 +629,8 @@ following:
>    - tracing synthetic events from in-kernel code
>    - the low-level "dynevent_cmd" API
>  
> -7.1 Dyamically creating synthetic event definitions
> ----------------------------------------------------
> +7.1 Dynamically creating synthetic event definitions
> +----------------------------------------------------
>  
>  There are a couple ways to create a new synthetic event from a kernel
>  module or other kernel code.
> @@ -944,8 +944,8 @@ Note that synth_event_trace_end() must be called at the end regardless
>  of whether any of the add calls failed (say due to a bad field name
>  being passed in).
>  
> -7.3 Dyamically creating kprobe and kretprobe event definitions
> ---------------------------------------------------------------
> +7.3 Dynamically creating kprobe and kretprobe event definitions
> +---------------------------------------------------------------
>  
>  To create a kprobe or kretprobe trace event from kernel code, the
>  kprobe_event_gen_cmd_start() or kretprobe_event_gen_cmd_start()

-- 
~Randy
