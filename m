Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359E325485;
	Tue, 19 May 2026 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213294; cv=none; b=sNNCiipBLGrrPEJXaE72yydwMN7HBg1xAf1oBIUejgN+khP1RvE22Tr+VUxjw2IFWxBv/P2z8DwpjPBP5w1/kVlM0buU1XvI4dYyh8C/hS4CXjDdQaPOiY9bCo9yJ7Yj06DpOnkMlqkmtc0j2qGKhuwciAVMPleaHsZHZr2d/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213294; c=relaxed/simple;
	bh=Bc5UuBILd2SqG/GAJYvlGQFu3tpAy6sYNSj8QIJ/bXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyR+G3V0J6i58MIWkADdXskOY6zbLDRfGSlRYjs7I0VapbwkRZaDVeqRVoFDaVMmzGWrObpQfins1W/9zIQeUm1meKbOpGzUSQa9Kq5SeCXMW+Ac9rwxRJFYHEpBJxz9XgMXYJqsWyINYi8L6cfjB68DswL2d1qtbMp0vssnIbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 56E0E407ED;
	Tue, 19 May 2026 17:54:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 8AEE130;
	Tue, 19 May 2026 17:54:47 +0000 (UTC)
Date: Tue, 19 May 2026 13:54:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
 mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
 chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
Message-ID: <20260519135446.4126a79a@fedora>
In-Reply-To: <20260518-add-tracepoints-for-qcom-geni-spi-v3-1-7928f6810a79@oss.qualcomm.com>
References: <20260518-add-tracepoints-for-qcom-geni-spi-v3-0-7928f6810a79@oss.qualcomm.com>
	<20260518-add-tracepoints-for-qcom-geni-spi-v3-1-7928f6810a79@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8wxuffs4adx9q156exjm7a3yhca9mh74
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 8AEE130
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19iWoyoF27xM5v+HXTjcDVWLl2I61JBYDI=
X-HE-Tag: 1779213287-261146
X-HE-Meta: U2FsdGVkX1+/3o9pDDttQfdXjWiapJj+p+/+V0F6h48kk4VeLhrzUI4TDI+ddFd6BVYAZB4pe9V3BnlkWLi3X8Qa1d1Z0eJc6GKqZwwTuNpeCA/7qAxtQUDoIgJSSPCLMo91wln6r63Iw3OCw9RW2BX+W0RyMhxrVHtViQxuW4E0CI5CUnLUrx4BdQu/of0gcdD1Am/aRl2sfKKfKIhhgX6B32EEgi3RHiGwxosezz/Vk++yYFR4QC1/GvHkhgtFef4FJS9tCjNvzAI6CG0MeYYM8tJgfFGJEtW+TSJPaEU45N0zwjQVqRCQIF/VBtukuF3xcOJ3IdqUGbYJjyjT3B888LXGbJ16

On Mon, 18 May 2026 22:30:51 +0530
Praveen Talari <praveen.talari@oss.qualcomm.com> wrote:

> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM qcom_geni_spi
> +
> +#if !defined(_TRACE_QCOM_GENI_SPI_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_QCOM_GENI_SPI_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(geni_spi_setup_params,
> +	    TP_PROTO(struct device *dev, u8 cs, u32 mode,
> +		     u32 mode_changed, bool cs_changed),
> +	    TP_ARGS(dev, cs, mode, mode_changed, cs_changed),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
> +			     __field(u8, cs)

A u8 followed by a u32 will create a 3 byte hole in the structure
layout that gets recorded onto the ring buffer. Best to move that field
to after the bool cs_changed, for better compaction.

> +			     __field(u32, mode)
> +			     __field(u32, mode_changed)
> +			     __field(bool, cs_changed)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->cs = cs;
> +			   __entry->mode = mode;
> +			   __entry->mode_changed = mode_changed;
> +			   __entry->cs_changed = cs_changed;
> +	    ),
> +
> +	    TP_printk("%s: cs=%u mode=0x%08x mode_changed=0x%08x cs_changed=%d",
> +		      __get_str(name), __entry->cs, __entry->mode,
> +		      __entry->mode_changed, __entry->cs_changed)
> +);
> +
> +TRACE_EVENT(geni_spi_clk_cfg,
> +	    TP_PROTO(struct device *dev, unsigned long req_hz,
> +		     unsigned long sclk_hz, unsigned int clk_idx,
> +		     unsigned int clk_div, unsigned int bpw),
> +	    TP_ARGS(dev, req_hz, sclk_hz, clk_idx, clk_div, bpw),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))

__string items inject a 4 byte meta data so they are basically the same
as a u32 item on the structure. Move this to the end or after the long
words so that on 64 bit architectures you don't create a 4 byte hole
here.

-- Steve

> +			     __field(unsigned long, req_hz)
> +			     __field(unsigned long, sclk_hz)
> +			     __field(unsigned int, clk_idx)
> +			     __field(unsigned int, clk_div)
> +			     __field(unsigned int, bpw)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->req_hz = req_hz;
> +			   __entry->sclk_hz = sclk_hz;
> +			   __entry->clk_idx = clk_idx;
> +			   __entry->clk_div = clk_div;
> +			   __entry->bpw = bpw;
> +	    ),
> +
> +	    TP_printk("%s: req_hz=%lu sclk_hz=%lu clk_idx=%u clk_div=%u bpw=%u",
> +		      __get_str(name), __entry->req_hz, __entry->sclk_hz,
> +		      __entry->clk_idx, __entry->clk_div, __entry->bpw)
> +);
