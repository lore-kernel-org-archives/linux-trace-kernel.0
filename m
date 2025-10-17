Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4E320383;
	Fri, 17 Oct 2025 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692097; cv=none; b=ZtsIfNvxVQbXalQbdbWnefm+JajsQQEH4x5k+F7KtKl5nNZanrUXmImFl8hI8t/23m6dC/KICAqUMT0hE0tg9BPRzfoMveaTXxKSIeLOTQesBPW+Uhtynz0nFLIUtX3nJJdrWfNN0rDTkLpMxJnaG7IUFzx7eXj+giygNBHF1ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692097; c=relaxed/simple;
	bh=TDevOwq8Fg53oVZrY/fcRHqG6a0JmTWY5Pvv2S2l+2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWA5YFuoBGQNIGRpPztcbVjBx2umYAP2DiKcHsp+jO0pfrLSo55S6pMIQo9OiL7YhgfvJCZaYRI2wr/Haf1HUSINBwDXyPoSBoJZLogycqF5I7McR0+sHPrHERKnePj+dtaFD2zd5xk3+ntAbQPUupiTJAFUiU2T1j1QYM1chUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 406ED59EE3;
	Fri, 17 Oct 2025 09:08:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 7DA7D1A;
	Fri, 17 Oct 2025 09:08:05 +0000 (UTC)
Date: Fri, 17 Oct 2025 05:08:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <laijs@cn.fujitsu.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: fix kernel-doc format to avoid a warning
Message-ID: <20251017050804.48439442@batman.local.home>
In-Reply-To: <20251017070753.1638717-1-rdunlap@infradead.org>
References: <20251017070753.1638717-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jjnajoysxb6na165wa57ewadgimcet31
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7DA7D1A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+DryH5ZVkXrG114uREmsMu4K5MYAvZFrY=
X-HE-Tag: 1760692085-671928
X-HE-Meta: U2FsdGVkX18FBDdOfMGA/YeQ2Avh5KPx4DSe681DPyGlOI2qzkoNOGt2dKCxEkYsAo11u6WqEGzwxi+PlEEP+dQeMlcbMWDvWHlp7a9vgWf037iN1iYdihUdZ3sDH9kA6D5hpE8TdwWXUWTccnb0yS4bsbce2/ZGtnlTYSoUEf+6a7TkJAd3WTvEpqKI3jpmLygXUoKEAI4wyWbQDLBiNaGLC8ius1mSrzkDSG4+zyt9cSxG+cCB7r1j/VUoU6hgnFXh/HeVzZ+hG/HFu6DbyC5RI/8e4l2QCC8yT3eVN8MrHunw8YC5l+Voz7PObyGX7rQ5wwUBpYjIsi7HmUM031fgYL02NqB5G+lK+SIptj9QgVp+vTJZCmjfq4CDqceHs8hKHU5EWaXUqx4D4LXMfdWaJr3kb+P+fZly5DcZbFroaaqt4LZO3vbM/OkC7lei74tkJZO9+7NpDXhzi3e4ls1a8M2asVRpZJcEL5WM99vlMwDgIERHSiG329A2cFaZbVcwNSB5PgsEnbNxvPQ/6Kpw1ilrY3InlrfAlJ7jErY=

On Fri, 17 Oct 2025 00:07:53 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Format the kernel-doc for RINGBUF_TYPE_DATA_TYPE_LEN_MAX correctly
> to prevent a kernel-doc warning:
> 
> Warning: include/linux/ring_buffer.h:61 Enum value
>  'RINGBUF_TYPE_DATA_TYPE_LEN_MAX' not described in enum 'ring_buffer_type'

Then this needs to be updated differently, because that "<=" is stating
what happens when the value is <= RINGBUF_TYPE_DATA_TYPE_LEN_MAX.

It wasn't random characters.

Basically, the enum describes the event type.

enum ring_buffer_type {
        RINGBUF_TYPE_DATA_TYPE_LEN_MAX = 28,
        RINGBUF_TYPE_PADDING,
        RINGBUF_TYPE_TIME_EXTEND,
        RINGBUF_TYPE_TIME_STAMP,
};

When the type is > 28 it is either a padding, time-extend or
time-stamp. But if it is less than or equal to
RINGBUF_TYPE_DATA_TYPE_LEN_MAX then it is the length of a data event.

Perhaps we should have it be:

 * 0:
 *                              Data record
 *                                array[0] holds the actual length
 *                                array[1..(length+3)/4] holds data
 *                                size = 4 + length (bytes)
 *
 * 1 - @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
 *                              Data record
 *                                length = type_len << 2
 *                                array[0..(length+3)/4-1] holds data
 *                                size = 4 + length (bytes)

  ?

This data is more important that making kerneldoc work.

-- Steve


> 
> Fixes: 334d4169a659 ("ring_buffer: compressed event header")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Lai Jiangshan <laijs@cn.fujitsu.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: linux-trace-kernel@vger.kernel.org
> ---
>  include/linux/ring_buffer.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20251016.orig/include/linux/ring_buffer.h
> +++ linux-next-20251016/include/linux/ring_buffer.h
> @@ -43,7 +43,7 @@ struct ring_buffer_event {
>   *				 array[0] = top (28 .. 59) bits
>   *				 size = 8 bytes
>   *
> - * <= @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
> + * @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
>   *				Data record
>   *				 If type_len is zero:
>   *				  array[0] holds the actual length

