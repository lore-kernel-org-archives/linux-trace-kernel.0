Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794538697;
	b=cwlwHCuYtsTx9kZTL2nA9ytH4pQQquURrUayoMFjMk/hOKO1D58fQoqFz4YNZleUu/3f
	 gchrA4X2jC7QG8rZaos/boY7ZAhP6BaixlQQhQmIBzeOjlOAEyoN8SzYYnVO6iFRVkq80
	 3pXzCBHlpBvw0fqGU5sku2s/9sp2SKnIPMnfZC2Pf5RK3jkdD2Z+nFczHmj59fsHhd7RB
	 HijswdPLfSuNIOPwPTjQKPU7P8kjLvkqvTAOy92Y8A6Tff/Rt4t7U/KKg4+1sRQRIoH95
	 /bHShn3J6sdYJ03oDEnFH4wHTDqdrMPZOlzz6YK2UsG/aAYpbxe+s5A2ypeXLu007sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794538697;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KsErnpxVH5I9VR4RHXusJqUJMR99navlKOjFGXUa6QU=;
	b=MkBHJ5qXSTLaIFExnyzv2QUxGl6Bt0b/UZ4AgzXowXiiOehf3s60ubr3leQ7PTcrux05
	 psqYN/PpjX/CNAVQYxxfpi1/EI85dOphukaDM4JWERqNV+KDifUThRwjJtu7AZyjjVtWJ
	 amHbtG4A3grIEWiS+4T0tBSpmvNvOGbk4JYc+8NO9IVlF5x4AhU1zjA0C8d6WxC2HYQHX
	 JFXFBIR10bb3yohnVcIt4gGoP7ox7mFwqjCJgieWMpbWmJzKgrddaK4k4d2nEe+zLAg9t
	 GjxNsIqAKGx5CZkWeGY9p7+gj0sXujEx5QKtKuwnelJSnMbMkQFcmK537NJtKrKLV8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANlLRg0V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649B9606A31C;
	Fri, 13 Nov 2026 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANlLRg0V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7851F000C4;
	Fri, 13 Nov 2026 02:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794538697;
	bh=KsErnpxVH5I9VR4RHXusJqUJMR99navlKOjFGXUa6QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ANlLRg0VdMF5PRwjWp3M6DpjVX0NZnKUoaM5reptp7LZi+xx+oTdOqEwTv5h98Asi
	 cG6KM3n3rzl+1HdPJ4mrVd0Gp5JytyN8ilqZAff8r7iKy0LNAAOcQ3XqFkP9QrtuFR
	 n6eIiiogQPOklKnaubLcP2F0wWESEZ5mm9hPYtcuMYN9vpwvMp3SUFfDCEfU1covtL
	 oarUiYlfZGmgYwxuIlvmX7oSr99YgDNx5p9jojC/aAoh6BL/QnoDQxnkRwt+TFJjFA
	 ydrsx/4MpPFgD82VtjQZyfHX0orrxFmLRtt4ouZ/imSxoWCoekotGW8X89d1qd27Hr
	 JfO8y82xws+Fw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Cc: akpm@linux-foundation.org, rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tools/bootconfig: Close only opened braces in compact output
Date: Fri, 13 Nov 2026 11:58:14 +0900
Message-ID: <undine-1794538694073445946-7fde07ae541bfa5c@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <6ad67e4cda05238cd173c99e820a85de2c13f5fc.1794337724.git.edumucelli@gmail.com>
References: <cover.1794333957.git.edumucelli@gmail.com> <cover.1794337724.git.edumucelli@gmail.com> <6ad67e4cda05238cd173c99e820a85de2c13f5fc.1794337724.git.edumucelli@gmail.com>
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

On Tue, 10 Nov 2026 20:08:45 +0100, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> [...]
> Extend the mixed-value/subkey sample to cover the lost sibling.
>
> Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
> Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>

This basically looks good to me.

Just have a comment below.

> ---
> Changes in v2:
> - Determine whether braces were opened from the key children instead of
> [...]

> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -68,6 +68,23 @@ static int xbc_show_value(struct xbc_node *node, bool semicolon)
> +/* Match the conditions under which the compact formatter opens braces. */
> +static bool xbc_node_needs_braces(struct xbc_node *node)
> +{
> +	struct xbc_node *child = xbc_node_get_child(node);

Nit: You can use `xbc_node_get_subkey(node)` here instead of manually
fetching the first child and skipping the value node:

```
	struct xbc_node *child = xbc_node_get_subkey(node);
```

Thanks,

> +
> +	if (child && xbc_node_is_value(child))
> +		child = xbc_node_get_next(child);

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
