Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SmGi6NmM"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9209F4;
	Sun, 10 Dec 2023 06:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1702217865;
	bh=95FOqqEVlvMpVu60xKcTVHAxKd+ad692k9vCay/7OIc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SmGi6NmMr8M8UM9SD93vDg7+H16lkzxZdbVZdUOSatOmwq0RRnP7D8ItJLGmLth6g
	 MuRFqYbO0B82vEExpJ8fjRpe/ahu15CUQfWpiZotn1/7fDIuMY0J+76xyM45/VOx/r
	 VcD9qhLu1WR9H1yb89kYapLAQ5zXCgpevNlfFXL5t8A3wIiNvIhY1tcc96gPnH4Eoi
	 TBKnN5iSi1etbYHoDHF3WQdCCFW9lvHbjvH6CfxrZbBWQfDlxb6pLDucIV1bTM8dKm
	 617ArDJcUam1f3728aghyIvZQkMVkT+qGlKP96QLDbr6le4gJ5gPgZmXld0Pjxfqah
	 WShryYQuXOS7g==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Sp6Qw6jlVzFr3;
	Sun, 10 Dec 2023 09:17:44 -0500 (EST)
Message-ID: <76797ddd-bb87-4af9-9703-1ec00a0d318c@efficios.com>
Date: Sun, 10 Dec 2023 09:17:44 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] ring-buffer/tracing: Allow ring buffer to have
 bigger sub buffers
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Kent Overstreet <kent.overstreet@gmail.com>
References: <20231210035404.053677508@goodmis.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231210035404.053677508@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-09 22:54, Steven Rostedt wrote:
[...]
> 
> Basically, events to the tracing subsystem are limited to just under a
> PAGE_SIZE, as the ring buffer is split into "sub buffers" of one page
> size, and an event can not be bigger than a sub buffer. This allows users
> to change the size of a sub buffer by the order:
> 
>    echo 3 > /sys/kernel/tracing/buffer_subbuf_order
> 
> Will make each sub buffer a size of 8 pages, allowing events to be almost
> as big as 8 pages in size (sub buffers do have meta data on them as
> well, keeping an event from reaching the same size as a sub buffer).

Specifying the "order" of subbuffer size as a power of two of
number of pages is a poor UX choice for a user-facing ABI.

I would recommend allowing the user to specify the size in bytes, and
internally bump to size to the next power of 2, with a minimum of
PAGE_SIZE.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

