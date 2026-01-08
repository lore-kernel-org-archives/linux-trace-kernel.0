Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD9F4F1;
	Thu,  8 Jan 2026 04:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767846613; cv=none; b=k+Qes7SvHOxpru0oeT3JfO0V61wBFozIv5bKJv0FHd6eJ6dcVu1FaPUAeAUjvs2BsZfYHQ7ivA/cUDFR10aAcQn2ZYI311S4alozemPP1zEPznNZyO+FqgZG60VTeJ/eEmIUAMjoQmLho4U7nQ0Mbe5MZN8YXFijULvskcjtSaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767846613; c=relaxed/simple;
	bh=1RTsX2DZnzwicpE+on8OTdyM2tDt1/XcLi4B6ncbVQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbaXmMMd7cfSNQEiet3K4Muf98bHLdMHeXkUrWBoJ6J+9HMI8M085kTQYMRu2okfGA4bRYE+YaaZUxx3G4eeJ4Rx26YLlYuu3+Oc+vd0Xe5MS3ljMYSw/w1NyakEz4qmchvR8nRxslLfcI3lPP3WyZYLtJ82Bj64L3O0Xt8B+DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ivkEgx++; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ivkEgx++"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=NBfMN0NI64KX4XiizZcqXAdGS97p7Dg6mUYEK0ai2gM=; b=ivkEgx++++Im/clDvjRig+C4Cb
	heiGASazDVv97x6mA6pm1UZjALDcPBLgUkMwRFaimUxvwn64lCel/ifK7ibh+y87XZaEAktWSwU31
	6ql5K1uEfNZysnm21tNyhtsWf668dj3CL5xeJYepJV3bbjaU5whMvmjGjAilq7OK9H4c7mSkShnE6
	9PZWJFeVgJdFT1ZsY592gFn3ZXlt5WnAWmgcE8S5RIjZlUKjPdYrUZgOVmkBVRcMnVIU2uKzV77db
	xuGmVwbcvrhjrFk648kk/hyQTz3QYnYJGROeGTNF8GN9aIRgJiotMfqmHstmmocUJpltlJfH5BaVE
	i6X4bNUQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdhex-0000000Fuc2-2FEe;
	Thu, 08 Jan 2026 04:30:09 +0000
Message-ID: <ce37d2b0-275a-4358-a0be-ffe3aa7ee12b@infradead.org>
Date: Wed, 7 Jan 2026 20:30:06 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation: tracing: Wrap PCI tracepoint examples
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20260108013956.14351-1-bagasdotme@gmail.com>
 <20260108013956.14351-3-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260108013956.14351-3-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/7/26 5:39 PM, Bagas Sanjaya wrote:
> Sphinx reports htmldocs warnings:
> 
> Documentation/trace/events-pci.rst:43: ERROR: Unexpected indentation. [docutils]
> Documentation/trace/events-pci.rst:74: ERROR: Unexpected indentation. [docutils]
> 
> Fix them by wrapping example shell snippets in PCI tracepoint
> documentation in literal code blocks.
> 
> Fixes: d0eb853678a21b ("Documentation: tracing: Add PCI tracepoint documentation")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20260105160000.0368ec8d@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/trace/events-pci.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/events-pci.rst b/Documentation/trace/events-pci.rst
> index c1ad0fc54777e0..03ff4ad30ddfa1 100644
> --- a/Documentation/trace/events-pci.rst
> +++ b/Documentation/trace/events-pci.rst
> @@ -33,7 +33,7 @@ state changes.
>  * ``CARD_PRESENT`` - Card detected in slot
>  * ``CARD_NOT_PRESENT`` - Card removed from slot
>  
> -**Example Usage**:
> +**Example Usage**::
>  
>      # Enable the tracepoint
>      echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
> @@ -64,7 +64,7 @@ Monitors PCIe link speed changes and provides detailed link status information.
>    - ``4`` - Hotplug event
>  
>  
> -**Example Usage**:
> +**Example Usage**::
>  
>      # Enable the tracepoint
>      echo 1 > /sys/kernel/debug/tracing/events/pci/pcie_link_event/enable

-- 
~Randy
