Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4846EC90;
	Mon, 31 Aug 2026 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197033; cv=none; b=WdnB/nqcaBX5Ieg7UikqxarUBqYju2gfktXZDDEX5WhgttXOZP17ULinSVgIr8LTb+z8f84S6z0sx+F6dkWJtAmy1toNJPpXt08bzkeRCXNFdpaCX3/0Rq260/tzXVFeFkLaNKsU4O/WOvymStRkm199Fr0H8l+O5WhHc3YnY/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197033; c=relaxed/simple;
	bh=SofsqkZn9Sfflh3ZuGu0KB4bjMJ/qEOKFsuU4lZlqTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7rI5XMV+Lc8jdFuEilvUch2sjjGa6YTtTC62mc5DdT7qESOpOwqhx7Kz5/ECPgIk1A8v2hYHI9tIqXy4KZATy4jFVoVQ5KXma3/fLJdaOLiYRqKvrPiSND/UgimTNAtMCWDSQdHoOi8qI39rVddyAsP1Hjl2l2P263ShATJt40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=ijHpdeEs; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="ijHpdeEs"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 3D879401E0;
	Mon, 31 Aug 2026 17:23:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id A8F3B2002B;
	Mon, 31 Aug 2026 17:23:40 +0000 (UTC)
Date: Mon, 31 Aug 2026 13:24:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Vinod Koul
 <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 chandana.chiluveru@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: qcom: gpi: trace: Add trace events
 header for Qualcomm GPI DMA
Message-ID: <20260831132437.2477e920@gandalf.local.home>
In-Reply-To: <20260831-add-trace-support-gpio-v1-1-7b0fd0d0ddb3@oss.qualcomm.com>
References: <20260831-add-trace-support-gpio-v1-0-7b0fd0d0ddb3@oss.qualcomm.com>
	<20260831-add-trace-support-gpio-v1-1-7b0fd0d0ddb3@oss.qualcomm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: A8F3B2002B
X-Stat-Signature: tcjjuyeg8ochjc1mze7kfhqd6zmzfbc9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18fF0ui6xjKhLdEp6d+GUR4oNAc3xDXTh0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=TZXXHOZM/aShp3K6xp57FxmGWKsPm0eT9S0BWA7sJhI=; b=ijHpdeEsazzJhDAyk8i45p8+N9FTyKKs636cO2W/ExILrzN84VXHwGK6tA6cQgRHsalQloXkxTPmSx7Xs2WsPVAr5E5KBaa5sC1k1jQeOCkhLd81bsqrZCgPOqSNlggJXhNaPIw+dPvGzmWlUWISrJqPyRX9Wu97EQnDsSkRTP8=
X-HE-Tag: 1788197020-800869
X-HE-Meta: U2FsdGVkX19bNpgFulyRSYJnQtOa7YUgjITi2mr8MHUqqxYHbbNtgQJpAQxc5hS4v1JLecQECY2lApvgULoRWOAwG2WyhyElhHy4KfsokhPkiFg3Ch6om8u+ShSegKws22noG5/TxMIeMT/LEb2/05WMFvhzSu0f44Ef3dAp894vniN/MzzduL5fS9f94+JH2MR4ZAL1Jc9SVO9wPlmcFM6/9O3IBW0ruaipPCDzTLInXmYVSnxugsJD4gJwV4yrUBUBVVk1qXiWfZHAV2uauQETB84UzqhWl+My21+0mZgEncEtcvAiNs3h5TpO/5h40iYzRgTo+EIXKkcgEfywc/3efasR0uIf

On Mon, 31 Aug 2026 22:06:35 +0530
Praveen Talari <praveen.talari@oss.qualcomm.com> wrote:


> +TRACE_EVENT(gpi_ev_process,
> +	    TP_PROTO(struct device *dev, u32 chid, u32 ev_type, u8 code,
> +		     u16 status, u32 length),
> +	    TP_ARGS(dev, chid, ev_type, code, status, length),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
> +			     __field(u32, chid)
> +			     __field(u32, ev_type)
> +			     __field(u8, code)
> +			     __field(u16, status)
> +			     __field(u32, length)

I would swap the above a little to have the u8 code at the end to remove
any holes. It may have a hole at the end of the event, but you don't want
holes in the middle.

			     __field(u32, chid)
			     __field(u32, ev_type)
			     __field(u32, length)
			     __field(u16, status)
			     __field(u8, code)



> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->chid = chid;
> +			   __entry->ev_type = ev_type;
> +			   __entry->code = code;
> +			   __entry->status = status;
> +			   __entry->length = length;
> +	    ),
> +
> +	    TP_printk("%s: chid=%u ev_type=0x%02x code=%u status=%u length=%u",
> +		      __get_str(name), __entry->chid, __entry->ev_type,
> +		      __entry->code, __entry->status, __entry->length)
> +);
> +
>


> +TRACE_EVENT(gpi_alloc_ring,
> +	    TP_PROTO(struct device *dev, u32 elements, u32 el_size,
> +		     u32 req_len, u64 len, size_t alloc_size),
> +	    TP_ARGS(dev, elements, el_size, req_len, len, alloc_size),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
> +			     __field(u32, elements)
> +			     __field(u32, el_size)
> +			     __field(u32, req_len)
> +			     __field(u64, len)
> +			     __field(size_t, alloc_size)

Same here. I would move the 64 and size to the beginning and the other 4
byte fields to the end:

	    TP_STRUCT__entry(__field(u64, len)
			     __field(size_t, alloc_size)
			     __string(name, dev_name(dev))
			     __field(u32, elements)
			     __field(u32, el_size)
			     __field(u32, req_len)


And yes, the __string() is a 4 byte meta-data and should be treated as 4
bytes.

> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->elements = elements;
> +			   __entry->el_size = el_size;
> +			   __entry->req_len = req_len;
> +			   __entry->len = len;
> +			   __entry->alloc_size = alloc_size;
> +	    ),
> +
> +	    TP_printk("%s: elements=%u el_size=%u req_len=%u len=%llu alloc_size=%zu",
> +		      __get_str(name), __entry->elements, __entry->el_size,
> +		      __entry->req_len, __entry->len, __entry->alloc_size)
> +);
> +
> +TRACE_EVENT(gpi_ring_info,
> +	    TP_PROTO(struct device *dev, dma_addr_t dma_handle, phys_addr_t phys_addr,
> +		     u32 len, u32 el_size, u32 elements),
> +	    TP_ARGS(dev, dma_handle, phys_addr, len, el_size, elements),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))

Move the __string() to after phys_addr.

> +			     __field(u64, dma_handle)
> +			     __field(u64, phys_addr)
> +			     __field(u32, len)
> +			     __field(u32, el_size)
> +			     __field(u32, elements)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->dma_handle = dma_handle;
> +			   __entry->phys_addr = phys_addr;
> +			   __entry->len = len;
> +			   __entry->el_size = el_size;
> +			   __entry->elements = elements;
> +	    ),
> +
> +	    TP_printk("%s: dma_handle=%llx phys_addr=%llx len=%u el_size=%u elements=%u",
> +		      __get_str(name), __entry->dma_handle, __entry->phys_addr,
> +		      __entry->len, __entry->el_size, __entry->elements)
> +);
> +

-- Steve
