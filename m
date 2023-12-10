Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="js6U22hl"
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2287C2;
	Sun, 10 Dec 2023 06:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1702218540;
	bh=x6MLErZNlQVGUs1Jib1nzGnOdZ6XoYrxaz8AY77jVF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=js6U22hl+M3GPqo+VRXiaSJh2mk1f/k4aYZCMM4EYLHQm2ZnxFNisYENir+ZWrVHt
	 58cnjxndyo0eOxwGKagZTnHnNgy+n+/LdDHvxy2zNsMHi6+FWAPG7ksxYeuhGLI+dr
	 OGUHovL9iGWmmMWptfqh6b7GA0+kqV5YbU2e9dbCday611eFc/Ah3VEMX/GxwrSqZ5
	 mhwUyMY63Rus8wpMYYwdXf4dQdDKxJqLchaJAHctjyYMrk0/hz6+BrZubaO06mk4RD
	 fKMmRsLGtFNWmSN0hnc9bkum/K0Bs8Z5MwCPbAYBvVSRhRE+5ch49/BAWHDbCESGMF
	 OePxD+2GcLl3Q==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Sp6gw6CKDzFbv;
	Sun, 10 Dec 2023 09:29:00 -0500 (EST)
Message-ID: <298be08b-b010-47e8-b6d5-78910b63a6a7@efficios.com>
Date: Sun, 10 Dec 2023 09:28:55 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] ring-buffer: Add documentation on the
 buffer_subbuf_order file
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
 <20231210040451.982725347@goodmis.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231210040451.982725347@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-09 22:54, Steven Rostedt wrote:
[...]
> +  buffer_subbuf_order:
> +
> +	This sets or displays the sub buffer page size order. The ring buffer
> +	is broken up into several same size "sub buffers". An event can not be
> +	bigger than the size of the sub buffer. Normally, the sub buffer is
> +	the size of the architecture's page (4K on x86). The sub buffer also
> +	contains meta data at the start which also limits the size of an event.
> +	That means when the sub buffer is a page size, no event can be larger
> +	than the page size minus the sub buffer meta data.

The fact that the user ABI documentation for this tracer parameter needs
to dig into details about architecture page size is a good indicator
that this ABI is not at the abstraction level it should be (pages vs
bytes).

Thanks,

Mathieu

> +
> +	The buffer_subbuf_order allows the user to change the size of the sub
> +	buffer. As the sub buffer is a set of pages by the power of 2, thus
> +	the sub buffer total size is defined by the order:
> +
> +	order		size
> +	----		----
> +	0		PAGE_SIZE
> +	1		PAGE_SIZE * 2
> +	2		PAGE_SIZE * 4
> +	3		PAGE_SIZE * 8
> +
> +	Changing the order will change the sub buffer size allowing for events
> +	to be larger than the page size.
> +
> +	Note: When changing the order, tracing is stopped and any data in the
> +	ring buffer and the snapshot buffer will be discarded.
> +
>     free_buffer:
>   
>   	If a process is performing tracing, and the ring buffer	should be

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

