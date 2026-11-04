Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752569;
	b=O5v4xpL2TY27dw4o3dWxIXQwnLaB+HThFLxmpArBvsMo8h9ll9Vhlfg1cc90/+oESmKD
	 8s7l5VUcsC0MUNvDSAGZUVsREjXBwJuEkW/aHb7pdUgZVIz5FrdI747UT+f8eobrLfJ/r
	 Nebe8cQDjcQYG8mNtpOcVLGLwmZG523rJdLEUDe0AAh01KsKLMWtjbMMFl9t5SI1vs7UI
	 iLNeovfFdYF9oxNlaxSbX4ZxRvSmuBuNrQr1Cso0amYYyKx9qEfeTVNwMfcNa8/Foy14h
	 js59+Ell5N0QmUL9H4r321Rsw15cKHnoOBUW7I3WnyNYySGfBOu0qFfMTJ1+ZEdwLeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752569;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=vDUPKTWcIidOZTIQvMJFLhi7DccfMnmv2OT7dhJ4cfY=;
	b=UecFzQsDDA0ftfp2qGOBHE0aQkWK0TG3Dwc0LK14Uhv4oVOmDEn41dFf/D6RQeK4WiUj
	 Dv3ZmCT1tjKlnigoVMYUYuLvpDKPUI7TdI67QQ5HukoVshKp1SMgCRKnYYcGw9ldJLmnK
	 9/yX2ysL61fhKdl0A9iZoiKMWMeqFPoxYv9PzrkwB57vVdCx8R6tz54wOj65i3uAI/+Fh
	 tKsjYREgfMV+9KPX9IpjUwYjDASiTzViQQe0D0G8Y5o/VOjbXenAVTJPPI03cC7w9dwPK
	 nFWgJus4pVeBMzcnARn8bSBUtUVqjrgFRQKAwSMQ8t0RI5B6M7Yc7BxclcMcVb1lG4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=3NeCSA0P;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B26F606A31B;
	Wed,  4 Nov 2026 00:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B26F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=3NeCSA0P
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 6FF0340575;
	Wed,  4 Nov 2026 00:36:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id E62182002D;
	Wed,  4 Nov 2026 00:36:03 +0000 (UTC)
Date: Tue, 3 Nov 2026 19:36:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Pengfei <ljdlns1987@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mark.rutland@arm.com, corbet@lwn.net, skhan@linuxfoundation.org,
 lkp@intel.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, zhangbo56@xiaomi.com,
 lipengfei28@xiaomi.com
Subject: Re: [RFC PATCH v7 03/10] trace: add stackmap statistics interface
Message-ID: <20261103193602.563c52ce@gandalf.local.home>
In-Reply-To: <20260912083753.3426176-4-lipengfei28@xiaomi.com>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
	<20260912083753.3426176-4-lipengfei28@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
X-Rspamd-Queue-Id: E62182002D
X-Stat-Signature: y4z7j8drbsddsufrz7qko7pmyy731eb9
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18N8quONP+xPHBazUzQOJwFF5f0cr+Y798=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=vDUPKTWcIidOZTIQvMJFLhi7DccfMnmv2OT7dhJ4cfY=; b=3NeCSA0PpiYIUdZa9hJDzYi0n9j3PbBxIZVw780WjHYqiRqJgB/lHdyqOSSTrO5Yv4AqpJO6HRXLmRQ0nD+zrBHrd7x+oTQMuPhbM5uiEK7wfb6/Ca0DfBpXL+DXf3Xkpb8u3YmgakbFzZUH0pvkK/P3bsQBOFWFI/7IlJDx/CI=
X-HE-Tag: 1793752563-44244
X-HE-Meta: U2FsdGVkX19mNzFCjor3J5d8cEDVJYR2GHL8av1QN0eP71rtGuyxcgLSkc1MQIn4uWYnTzbgOKxvzKptHIoBNQsq6fIKlw10Hsyq+mFurMn9R8/S51t3VKjtZ4QGnOKyZPQbDN/8KikeJGZZt/4hjwurvwX1rbEuPqgxatOFhu4LUpAmXF4LNE7rIDCXaXODUKc7lIsNEfiKnBrpbdGJsi3B8oxJ+TG6rqEWlMJufSsckOosQI0DlyMXeV+9LnAGlH/f7PLu3qxNpwCo4cgsEa86QyV8tPInuCYcu48YaRqxh0yCQSL6ATPPrtmbbjE62cTV6WMTqoQnIPH2oVCxw1EwhYpO8DpA

On Sat, 12 Sep 2026 16:37:46 +0800
Li Pengfei <ljdlns1987@gmail.com> wrote:

> @@ -9411,6 +9411,18 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
>  				 */
>  				smp_store_release(&global_trace.stackmap, smap);
>  				WRITE_ONCE(stackmap_init_state, STACKMAP_INIT_DONE);
> +				/*
> +				 * stat is an auxiliary observability
> +				 * surface. If it fails to be created we keep
> +				 * dedup enabled -- the kernel side still
> +				 * works and stack_map alone is enough to
> +				 * resolve and reset; trace_create_file()
> +				 * already pr_warn()s on failure.
> +				 */

The above comment is useless. Get rid of it.

-- Steve


> +				trace_create_file("stack_map_stat",
> +						  TRACE_MODE_READ, NULL,
> +						  smap,
> +						  &ftrace_stackmap_stat_fops);
>  			}
>  		} else {
>  			pr_warn("ftrace stackmap init failed, dedup disabled\n");
