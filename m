Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1A93A2E08;
	Mon,  8 Jun 2026 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909370; cv=none; b=Da2WGbSWFW5sIhtpn3p2a7w6So8BYqZmOAiT1fypgoSeXtMh/tBajeml5yooFAyruu1cTb2oZotaPbco37+/lv6XQr68858J2BZt/7HnXJiU4ONQokLAejLUq+i4V5eYNrU2OVwNQ+U503rlOpv/SLw6pnqOkwVAQXUxq1NGs8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909370; c=relaxed/simple;
	bh=mcoZ189zyNoNTBYWGE5B+NgOZfTznULo6nWgqOwSXQY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NTuCeFs2+yAeEnt/Jf2FHL1VH3oJHclG0mpCnrlEpwum8DUZdQvqFs6AfoRWBZr5Xz8pSzl+BQ1/W05tNCpmbubEBJQtlw4ulyTGRQ3SE/zEdYAJo9vzrTXl97RaxaZF4bRheyGrAV6sR6/AKSIM92un4PqTG+G99nmuRqKvJlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDiTz1Nh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDiTz1Nh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2718B1F00893;
	Mon,  8 Jun 2026 09:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780909369;
	bh=L6U9Kys9CgpeAZzRkFwaldlYw6S7K9OGIgWb0WV5n7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RDiTz1Nh/UeSsUrUZoT2XlbOeulPT2ybdwtGUE86VsTc2rzw5klaWTKSjfgCTuTBj
	 +5oKWOJ/TGjXdsR8YFo9daNZ6rGp31YSdIYeHUH7PjYZrD/gJrSp27ZSxKYfsopbH2
	 CW3h5rdDeenuFspHo7Q0p/ohi68HLrJGJBLjVSUiJYHtLFZ4NxHSb2TT1gq46sB6aY
	 7qLqho2bAjA5YFAnFwU07ZlkPe+sicqwC2GvrpAQSvlEw6nVh/kPDZ9uKourUm7pOP
	 IU1W3z32ykPh2E9vgedxW6psgTS9P52heCzWaUb9LIwHwur+hjAYMljjPyolmEmLV6
	 jFGiQziW5DFNA==
Date: Mon, 8 Jun 2026 18:02:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, pjw@kernel.org,
 linux-trace-kernel@vger.kernel.org, shuah@kernel.org,
 wangfushuai@baidu.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] ring-buffer: Fix event length with forced 8-byte
 alignment
Message-Id: <20260608180245.09e083867a7d4d96058d7323@kernel.org>
In-Reply-To: <20260607072431.125633-2-hui.wang@canonical.com>
References: <20260607072431.125633-1-hui.wang@canonical.com>
	<20260607072431.125633-2-hui.wang@canonical.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Jun 2026 15:24:30 +0800
Hui Wang <hui.wang@canonical.com> wrote:

> When RB_FORCE_8BYTE_ALIGNMENT is true, rb_calculate_event_length()
> reserves the space of event->array[0] for placing the data length and
> rb_update_event() stores the data length in event->array[0]
> accordingly. As a result the whole event length will add extra 4 bytes
> for sizeof(event.array[0]) unconditionally.
> 
> But ring_buffer_event_length() only subtracts the
> sizeof(event->array[0]) for events larger than RB_MAX_SMALL_DATA +
> sizeof(event->array[0]). As a result, small events on architectures
> with RB_FORCE_8BYTE_ALIGNMENT=true report a data length that is 4
> bytes larger than expected.
> 
> To fix it, add the RB_FORCE_8BYTE_ALIGNMENT as a condition to subtract
> the size of that length field whenever RB_FORCE_8BYTE_ALIGNMENT is
> true.
> 
> This issue is observed in a riscv64 kernel with
> CONFIG_HAVE_64BIT_ALIGNED_ACCESS set to y, when we run ftrace selftest
> trace_marker_raw.tc, we get the weird log: for cases where the id is
> 1..100, the number of data field is 8*N, but once id exceeds 100, the
> number of data field becomes 8*N+4:
>  # 1 buf: 58 00 00 00 80 5e d1 63 (number of data field is 8*1)
>  ...
>  # a buf: 58 ...                  (number of data field is 8*2)
>  ...
>  # 64 buf: 58 ...                 (number of data field is 8*13)
>  # 65 buf: 58 ...                 (number of data field is 8*13+4)
> 
> After applying this change, the number of data field keeps being 8*N+4
> consistently.
> 

Good catch!

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Fixes: 2271048d1b3b ("ring-buffer: Do 8 byte alignment for 64 bit that can not handle 4 byte align")
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  kernel/trace/ring_buffer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 56a328e94395..d9af2bbaf9c0 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -270,7 +270,8 @@ unsigned ring_buffer_event_length(struct ring_buffer_event *event)
>  	if (event->type_len > RINGBUF_TYPE_DATA_TYPE_LEN_MAX)
>  		return length;
>  	length -= RB_EVNT_HDR_SIZE;
> -	if (length > RB_MAX_SMALL_DATA + sizeof(event->array[0]))
> +	if (length > RB_MAX_SMALL_DATA + sizeof(event->array[0]) ||
> +	    RB_FORCE_8BYTE_ALIGNMENT)
>                  length -= sizeof(event->array[0]);
>  	return length;
>  }
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
