Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4C143C61;
	Thu,  8 Jan 2026 04:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767846613; cv=none; b=F1Qx11/vLSPhNwinrM05k/P5tw4rtpLjCT3FpgWL8/ryiUF2TTUbuEIEU1GlGrfsPKM18eEjqELFqXxCLF1hziuANGGjcul5dy1uFK18Gwk53ITlbAnVNOJE9K0IfYAiD5/VsYWhyTjhPLK44Gtuj/WqSOJJjki+FP7bi4NF/Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767846613; c=relaxed/simple;
	bh=gvRAqHbuqKKRtFvO+f1PJjVO/NnS+jLGecjdReyCo6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0GB2p0SBQgNYfIwCW/ZsroX4SaQPbKUmSQ+MBU2C2E2FpdnYPisyTBxmJba3T6MpDCh5oyS7vbSYLdg26NOYcQ1RUilhW0NE6HHegSvU3aBzdeRk3TH9Scw2sixPzTQfAxkp4AybMI3xw+UsaFIRSwMphRnRDxhmB39HtYdLb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g4ufmmph; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g4ufmmph"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=rILTvcfFCzMBvDAydZNMKJHZ64tLxPLyYof9q+dNOEk=; b=g4ufmmpht7nKKUq7R2AEokCLj5
	3CUzvn8vhj5sYhPl8p3yburK2t/5+1iV25wlCGCibDkk8fQWLTYeGpRzETQ+tXpoqEWJBgObqbh0U
	nc+YoO8NPcFGPNJ++ks5g/dcZeCMC53aYj9zaGwqsFhrxD9egWharhn28y+4Q15HQCjPrsihHoxoX
	oCUWvXDcAy6YxPKnDqoSj9E8GJlXb4Xx7BBvLU0dv8RfsJapy8K7tl2rSbi4V9ojPBSnzuSSd4uG8
	pYF4mAuhnc6TmmiLPAftV4uzNco+1EWceXheYCJyNyJODHBAmY3Q2D64imSI0ZGjnXiKpMGJhHYj8
	NU5KISQg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdhf0-0000000Fuc2-0TRu;
	Thu, 08 Jan 2026 04:30:10 +0000
Message-ID: <3a771987-d2fc-481c-892f-92c61819d282@infradead.org>
Date: Wed, 7 Jan 2026 20:30:09 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: tracing: Add toctree entry for PCI
 tracepoint
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
 <20260108013956.14351-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260108013956.14351-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/7/26 5:39 PM, Bagas Sanjaya wrote:
> Sphinx reports missing toctree entry htmldocs warning:
> 
> Documentation/trace/events-pci.rst: WARNING: document isn't included in any toctree [toc.not_included]
> 
> Fix it by adding the entry for PCI tracepoint documentation.
> 
> Fixes: d0eb853678a21b ("Documentation: tracing: Add PCI tracepoint documentation")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20260105160000.0368ec8d@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/trace/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
> index b4a429dc4f7ad6..0a40bfabcf19bf 100644
> --- a/Documentation/trace/index.rst
> +++ b/Documentation/trace/index.rst
> @@ -54,6 +54,7 @@ applications.
>     events-power
>     events-nmi
>     events-msr
> +   events-pci
>     boottime-trace
>     histogram
>     histogram-design

-- 
~Randy
