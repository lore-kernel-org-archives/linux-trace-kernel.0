Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533750;
	b=ALlvrL/fbfjvmSZO2VK4iR4i/i/BBM8kbd9YNhX/0FKJB+E+a8zx1kRaIz4sZdy62Amp
	 5b+WGEF87QQdF5aJVYRS1B184mcL2kqBgkhPneGScFyBNUlbn4WftJUF0U0egZKhx99K9
	 Rc7PA7s5gXY1rSCOf4PCsrcASdj/BCED5InBCCTf4rzZ6GmFd9FoUKf8lxFhsn+5cRjSt
	 08JrsiSjg2iR61852uxVEoRMs6QsfOFtO3GUtSdcF0s2uPrpuSouHG6arlan0ZnUGzbPA
	 eU/mqQTNaPn7UQ4BFwU1FKbp460ZirzuLXL6hnOE4gtEJRJuWdc2v5QxknrDyDf4zAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533750;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Y80tsRK+PbS/OQgpPYHw4t5IwacRfcv9sJ3mwn5iarE=;
	b=YDNU+MbS+Zea3ntIZweaEmpZm6Trro7j9ajINQrGuCic3Pnp8cqXMg5LPyCVHyxF/xz6
	 yppojoaIatBNPjF3nkyMGXRN0honddERSa1oXzizhDoPkI+LgkUoF0WvA7JF8dcIRO22j
	 Zt7XEcoHR1Xtgvjp+DNN6NJhcYIkv0e/5sULqNRsAM+2Z0UAKmuEDnRUrbhu4CGPyKNQr
	 B34J4ZR3rJ2+hVWlZdtcHqXZbHYiGwHoQzbnhqAGn5L6fAtu4JpkneRvL8nAOLBlXY0zu
	 db7cU4JA2/zIlt3ecW8b4Ht+ufA7FzGb02NdS4MFbmwHkkr1gnChhaGbh9YJHERePZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mu629Aat;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF27606A323;
	Fri, 13 Nov 2026 01:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mu629Aat
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01A11F000C4;
	Fri, 13 Nov 2026 01:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794533750;
	bh=Y80tsRK+PbS/OQgpPYHw4t5IwacRfcv9sJ3mwn5iarE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mu629AatxKn+3ea+NCIFuYDKuK8yRNS8niYI+AID3dh02eYbcxSxgKyWpINhbc9nH
	 m9tsH4CYs6twvpUO1ZrNF+bD+IfDZ5E0Y8sClackuRW3ThLV0s4WAr8A9wuwx/6gaA
	 O6q9NGdPvkOsJI/hX3huuu7QNRL/Epcb9+MRV2X1Cbva8sFlrte85wB5PLTpfdHnkM
	 wN0u5uaxeQ3BZNpBVOywR2x7lZWzj+zU9S1wgYgLxN15O8qeYORlEjiB3QELWX32fF
	 zsgo2wE3TtmI174kA01YneO/Sn//iR85CgW5U/nl/uCVT5HLW7aoS3V2dgleOvxio2
	 Ei2z/SQQGUMmQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Naveen N Rao <naveen@kernel.org>, "David S. Miller" <davem@davemloft.net>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs, kprobes: Fix bracket
Date: Fri, 13 Nov 2026 10:35:45 +0900
Message-ID: <undine-1794533745876605613-da001b387e6fb572@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261112085511.690900-2-manuelebnerli@mailbox.org>
References: <20261112085511.690900-2-manuelebnerli@mailbox.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Thu, 12 Nov 2026 09:55:11 +0100, Manuel Ebner <manuelebnerli@mailbox.org> wrote:
> Remove needless ')'
>
> Fixes: a1dac767622c ("kprobes.txt: standardize document format")
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, looks good to me.

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
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
