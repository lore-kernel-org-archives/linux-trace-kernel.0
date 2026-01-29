Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8363D1D88AC;
	Thu, 29 Jan 2026 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769647599; cv=none; b=kb8uqgHjT1UUUuNarYQSirrwRLcKISyt/yh3P311+miBQ17PFku43Cma2VHCXcZJlGmz3EtjQ8qhui/HyxJl51UVzTF1noR4t7d9EnOy5fjsX069InDqn1vGpxaOO+hEAqqgVyN9v3TvIJo1rlab7dGu0J/u2lO1X/N7RoX09GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769647599; c=relaxed/simple;
	bh=7Xml+48FylCxkNKMZeTofrrUHZFglxeIWVQKeX3ax44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sI+Vut6PCecgv6KqUZ5LUGZlVGebOt/NXgC4MKmyXO5gvAoDpgksdqAAmuMyMef2rT/XhMYEt+wG2rZ1cpslQeB+fQwICugfTfnHLFdx8wJtgdIn4sUp1gR7DGw3vQFBHvUHtJEdK8uXVomUtu7EWoKSFZ5C/t0x06Osp7ZV858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 372E7BA563;
	Thu, 29 Jan 2026 00:46:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 23DA12000D;
	Thu, 29 Jan 2026 00:46:34 +0000 (UTC)
Date: Wed, 28 Jan 2026 19:46:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, Joerg
 Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2] iommu: Fix NULL pointer deref when io_page_fault
 tracepoint fires
Message-ID: <20260128194644.0c76eeb3@gandalf.local.home>
In-Reply-To: <20260128-iommu-io_page_fault_null_fix-v2-1-de047be6dd3a@riscstar.com>
References: <20260128-iommu-io_page_fault_null_fix-v2-1-de047be6dd3a@riscstar.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zbnrqykkbsctq1xypty1uxryh3hi8pak
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 23DA12000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19mNQtqSQkXD3+IliWA9iQPxr0OnT5GTl8=
X-HE-Tag: 1769647594-734317
X-HE-Meta: U2FsdGVkX18MOrD3v8VfqWZtxIFDGANwb1LiocAuKBOLEhLP+uqW9c6+dxvNIFq+OEEPdjNlAHmX5fwOoUtV4xD0aXUWrxY5XwNRVli6aznBP9SD2jLx1Z0qHupPrFT2dTPJJ/bHAzElKVWmxv47VqQKG3qyI4PLR9abAohEDCXA3XFkv2sE3RQOVCLkEqKY6Dh2MQEVoo/7nydrv8m6s5ucbEWbvxJFmVU80f1x/PwJARS9FMEXlmBxs6T65y6h33QJYSJvbPLdcPFuaOOO4yHiAqi+05Ckbkb5YVIsGy5BHM67DPr4BgzMRgbG26xbopW6W979+xdtLz+pAgO/Dgz0ZLsy45Vc2k0LIGGBtTtOANTEqIwjvDhUPfOvHuGT8dxOP7YO/thpp/7ZXnGWV17GtGb8VlDxbPoR8TSc7B1lU7bL/XYow29uGStBEyrnCAmfv0kwzXKDPcqeATABVA==


Note, event changes go through the maintainer's tree where the events are
used.

But from a tracing POV:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


On Wed, 28 Jan 2026 15:48:01 +0000
Daniel Thompson <daniel@riscstar.com> wrote:

> The arm-smmu driver is unable to allocate the blame for a page fault to
> a specific device so it calls report_iommu_fault() with the dev argument
> set to NULL. Normally this doesn't cause anything catastrophic but on a
> system with the io_page_fault tracepoint enabled this results in a NULL
> pointer deref (resulting in a fairly spectacular crash on the hardware
> I'm currently working on).
> 
> Fix this by adding logic to the tracepoint to safely propagate NULL.
> 
> Fixes: f8f934c180f6 ("iommu/arm-smmu: Add support for driver IOMMU fault handlers")
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> ---
> Changes in v2:
> - Add a Fixes:. It points to the earliest point I can find where it becomes
>   possible for the tracepoint to be triggered with dev set to NULL.
> - Link to v1: https://lore.kernel.org/r/20260116-iommu-io_page_fault_null_fix-v1-1-6c20c2e62987@riscstar.com
> ---
>  include/trace/events/iommu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
> index 373007e567cb827458a729b8200bbcc1b7d76912..1315193f13b8812ad4e29e6b0c0c66ca806ce08d 100644
> --- a/include/trace/events/iommu.h
> +++ b/include/trace/events/iommu.h
> @@ -131,8 +131,8 @@ DECLARE_EVENT_CLASS(iommu_error,
>  	TP_ARGS(dev, iova, flags),
>  
>  	TP_STRUCT__entry(
> -		__string(device, dev_name(dev))
> -		__string(driver, dev_driver_string(dev))
> +		__string(device, dev ? dev_name(dev) : NULL)
> +		__string(driver, dev ? dev_driver_string(dev) : NULL)
>  		__field(u64, iova)
>  		__field(int, flags)
>  	),
> 
> ---
> base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
> change-id: 20260116-iommu-io_page_fault_null_fix-f81b4e8b5423
> 
> Best regards,

