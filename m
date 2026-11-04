Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828374;
	b=bTDPlPNfDg4fHxeWuCnFOCf++asl4Ku6apMzBMxJvR3VMCSWPiUIxuPJwdJdaoHf0ojF
	 ch6KtyrSboO4WT0pv+Luf7vHN4P1Mu7x5l3z+lz9jlWeJn/5wt5BN8g1r24nrKJ/XJxaK
	 u0CE5hTAz5lJ8YHa8b3Ep+Np9W1i/xFNTFw37MKe/lo13juhbEUJx9QkDqn+ddMr2C7Ta
	 A384nflZIHk4/TSWF6iy8x1/xIogm4UpBjNRvuvHJK2UBiR+tBpkw3wc15WJg2zI9leVW
	 fDITPsnm3DNDp3qnEYf0ZT6p5SUcAAtGY7dXU945tNnWoQak1+2bXtn1WP5LixenwPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828374;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=KL1hmlvWAkZ/YeoXB36i/Q1Q9UPf9z5TUNk0Z4f7ulk=;
	b=SMEyS2gt6azS0Q3N0xGLO4TVyOrwGEc/20ANmxZXitkUCYu1NdrC+7rUMAGy/JiaNERB
	 AzxxQEuVU5gQFUzZnaKuVNdGSMwc6+KKo50Ifl3lJEux4ubBQHMUwyk0x+02ToLchFxWV
	 zCCTnkIabDMHvowRAN/3epjiVOGC/tMwkPPz+tfcQgC6zA88GEO2Bb0apx2WckTgoLwBW
	 nPRYKuInD4IyXdfvEtDGEsGhjJ9cRLXdmmFN5hIZmKhZR/991QAwm8P+sQZ7evi1/17/T
	 uPFMNGEzJJdq5KTrQS+mXUZoznObarA9zTuNSDr/kTfIRwPpZTh369UO9Sy92F6aiNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=G2CDuH+B;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861C6606D4F0;
	Wed,  4 Nov 2026 21:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 861C6606D4F0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=G2CDuH+B
Received: from CPC-beaub-VBQ1L.localdomain (unknown [70.37.26.59])
	by linux.microsoft.com (Postfix) with ESMTPSA id 735B520B7166;
	Wed,  4 Nov 2026 13:39:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 735B520B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793828358;
	bh=KL1hmlvWAkZ/YeoXB36i/Q1Q9UPf9z5TUNk0Z4f7ulk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2CDuH+Bh7dWM3ap/DTkd8h0PAyXrfM6gxm6I7URHKGGDOMTBkIo7u1muvuah4Vnf
	 wipUSW6cYVVK0bU6i7O36urSJM61BYLtFV/T7nLRCdLXn7R+JqT38LQB2Dlgpu+QdE
	 HAMG+NBZ5xZ3r0mK15hhl/yFlHpkJ8VZCj36vCIY=
Date: Wed, 4 Nov 2026 21:39:29 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing/user_events: validate dynamic cpumask size
Message-ID: <20261104213929.GA65-beaub@linux.microsoft.com>
References: <179367391951.8187.1770217673912340635@stu.pku.edu.cn>
 <179367391951.8187.4749000539954371762@stu.pku.edu.cn>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179367391951.8187.4749000539954371762@stu.pku.edu.cn>

On Tue, Nov 03, 2026 at 10:45:19AM +0800, Yifan Zhang wrote:
> user_event_validate() checks that a dynamic field lies inside the event but
> does not verify the minimum size required by its filter type.  A one-byte
> dynamic cpumask can therefore reach filter_pred_cpumask(), which consumes
> cpumask_size() bytes beyond the event buffer.
> 
> KASAN reports:
> 
>   BUG: KASAN: slab-use-after-free in filter_match_preds
>   Read of size 8
>   filter_match_preds

Hey Yifan,

In the V1 there was a repro case where this value was a __data_loc,
which defines where the actual data (and it's size) is in the payload.

There isn't a type min-size requirement when __data_loc is used, this
seems like the bug resides possibly in filter_match_preds for
__data_loc cases? See comments futher down.

Steve, do you think this is the case?

If not, then I guess we would have to validate min-size requirements of
all types in the dynamic case, and I hope we could do that centrally to
avoid fixing these in various spots.

>   trace_event_buffer_commit
>   user_event_ftrace
>   user_events_write_core
> 
> Mark dynamic cpumask fields and reject locations shorter than
> cpumask_size().
> 
> The patched kernel rejects the short event and accepts a full-size control
> event without a KASAN report.
> 
> Fixes: 2467cda1b5c9 ("user_events: Validate user payloads for size and null termination")
> Signed-off-by: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
> ---
>  kernel/trace/trace_events_user.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index f658c3a77aa7a..85938b45b7618 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -170,6 +170,7 @@ struct user_event_file_info {
>  
>  #define VALIDATOR_ENSURE_NULL (1 << 0)
>  #define VALIDATOR_REL (1 << 1)
> +#define VALIDATOR_CPUMASK BIT(2)
>  
>  struct user_event_validator {
>  	struct list_head	user_event_link;
> @@ -1159,6 +1160,9 @@ static int user_event_add_field(struct user_event *user, const char *type,
>  	if (strstr(type, "char") != NULL)
>  		validator_flags |= VALIDATOR_ENSURE_NULL;
>  
> +	if (strstr(type, "cpumask_t"))
> +		validator_flags |= VALIDATOR_CPUMASK;
> +

You can only get to this case if you put struct, __rel_loc, or __data_loc.
Those have their own size requirements and are dynamic in nature, IE:
Each write describes the actual size in the __rel_loc and __data_loc
cases, and statically for the struct case.

user_field_size() checks if a type name has a known size, if not, it
gets rejected. The only time this isn't the case is if you put struct in
front and then have to give a size that's expected. The other case is if
you put __data_loc or __rel_loc, both require the payload to dynamically
have a size associated.

In the dynamic case, the filter should be ensuring these values are
minimally sized.

>  	validator = kmalloc_obj(*validator, GFP_KERNEL_ACCOUNT);
>  
>  	if (!validator) {
> @@ -1598,6 +1602,10 @@ static int user_event_validate(struct user_event *user, void *data, int len)
>  		offset = loc & 0xffff;
>  		size = loc >> 16;
>  
> +		if (unlikely((validator->flags & VALIDATOR_CPUMASK) &&
> +			     size < cpumask_size()))
> +			return -EFAULT;
> +
>  		if (likely(validator->flags & VALIDATOR_REL))
>  			pos += offset + sizeof(loc);
>  		else
> -- 
> 2.39.5 (Apple Git-154)

Thanks,
-Beau
