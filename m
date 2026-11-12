Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509824;
	b=fQVFExcdu2wa9edo8/iMgh+VNZcP4QMMtDKV2bQZR787+uBPb+GVNvGI/vle6vBFEYQL
	 uiiALW9k0GBdtEzOB+8qma7zly2WEHIvxyZr+1ogGCRxbxZDd1ifVoehbUw45ZO++cQyi
	 oANRIi8x9q1hJAMRjdvBVF/nFN9N+X2wMpgT5xHGol2rizFu5edFOblyFAT+mJohKuKvl
	 qx0HayJ6+l6AdqDy9K4PrZsqv9CoWnh2McAGQ2h3bwPUnCnsvS/DffFDKzRXcdUhc8HlO
	 s971uNzvVeb+hDHa6gcnwl4ESrSudD2o0Tr/Ic3rz+ySWOjsz0Y2BlS8DM8B6yQNIwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509824;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=6UJe59/fsUPIoYsN/MNCP1ohHjVugMHxP9bCwi+NXv0=;
	b=ekaDbveM0BRG4AqpQGL8mNL9Ronlng1vh4kijIQyAyvtjotdnHhFHQ383S3La5ql/Sa6
	 Ofv27K2TLUO4QngY3yEnughF5BgZ29kMgTO6HnCsjMRsvAb2nNFNBgTAv8PiLR4HHxUZK
	 IISFrjewOC8J/DGLT19/9gPzJHmJTdB522JbWUS7vratvjgzsYiNyeny2OhE90vIjRdRn
	 llgI2euKdkURPDNiZhhqgwqKMyGubxEVLldro/oKpYmbBMHH1lKwyIgDESOl+uv2HqGy4
	 ZXUEB5hy9s68HY6EcYTA9rUJpcLgYVE0lIReZZvwf/klylAy59vbSJoUhI9pZ0TsqRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NeJGoFBh;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE9606A321;
	Thu, 12 Nov 2026 18:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68DE9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NeJGoFBh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=6UJe59/fsUPIoYsN/MNCP1ohHjVugMHxP9bCwi+NXv0=; b=NeJGoFBhJPJTCi1ker1diZ0rs9
	6S3L9aANDGRqgpn+peI+DRHIAbZDC2nHdKcwPqQZqrG28mLduuFKalZHBzn1y55cjxL1o5wQiwQRU
	Pzq8zKgw7WdgvQWUzXMu3JjGMDnsP7cnuZ/eckkG9CR9/C+Hs3Ad5ZeEfIwbcgR9BYmft0bYelMV5
	HDEWIpLvnOPzfipidxrMZOXEP5lJOw5tPTbWgOC6AWp3cEAoEFLV9j6kEjbYgGh8K9hjvmRAD8jVo
	/4UEWVwnYjeY5UJxJ+8pdCN97Yn4vHXIsx+KZw/OITgsduhvKlgljhCC7lZlAHvQpF0ZdgTANOXi3
	2QwMncnA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRZyf-0000000Atwx-3n7m;
	Thu, 12 Nov 2026 18:56:53 +0000
Message-ID: <407dcd2b-6bc8-4814-9e0d-b577fcb8fc99@infradead.org>
Date: Thu, 12 Nov 2026 10:56:52 -0800
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs, kprobes: Fix bracket
To: Manuel Ebner <manuelebnerli@mailbox.org>, Naveen N Rao
 <naveen@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20261112085511.690900-2-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261112085511.690900-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/26 12:55 AM, Manuel Ebner wrote:
> Remove needless ')'
> 
> Fixes: a1dac767622c ("kprobes.txt: standardize document format")
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/trace/kprobes.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/kprobes.rst b/Documentation/trace/kprobes.rst
> index 19c04a91a6..91b76ed435 100644
> --- a/Documentation/trace/kprobes.rst
> +++ b/Documentation/trace/kprobes.rst
> @@ -31,7 +31,7 @@ can trap at almost any kernel code address [1]_, specifying a handler
>  routine to be invoked when the breakpoint is hit.
>  
>  .. [1] some parts of the kernel code can not be trapped, see
> -       :ref:`kprobes_blacklist`)
> +       :ref:`kprobes_blacklist`
>  
>  There are currently two types of probes: kprobes, and kretprobes
>  (also called return probes).  A kprobe can be inserted on virtually

-- 
~Randy
