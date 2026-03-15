Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DFD39FD9;
	Sun, 15 Mar 2026 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773562587; cv=none; b=av67K6LBAbWZtvF+bNsxf9y9JCAjTvaWwY3qpc9VvxZsS1bTntllqFjQT9d2dxWS+3f9RLSPlN31hMnZR2SQ66UppCbKu2bVJ5TNApL6z/K/qDBcOGt07qHE+FKxMyla80zVeDxZai3HUEYC7WuHPlRygLL8fOJSzDW9CaiVD7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773562587; c=relaxed/simple;
	bh=ysyJnOtIqZct2pZ3iXioJN0eAbOEnihDPP5cEAlD3BY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p43RQlNsRFhg3Cdc7dn1zXpVzLsYbV+nowZHmNI+32Gej8SyB7Sv/Y8RFKBfwJ4gxeu+JU88VpS9ffeD3gXKca2y3gzonl0zSroyRjDo2BOT6UwpkYa+0KMHQIog11xf+4aqnJYuso94IrZ6oVJBS12ncUb/bm3FTnMjnmkdrgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCWZRPqh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCWZRPqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACA2C4CEF7;
	Sun, 15 Mar 2026 08:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773562587;
	bh=ysyJnOtIqZct2pZ3iXioJN0eAbOEnihDPP5cEAlD3BY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pCWZRPqhNoFfWji+gYJklMzUGq2G4QhARD5NrZfHeVhghFD6cf4NDcA2cn6S0sp02
	 ZaWkgLv+Lz4P6acnCVHjBlNCeZ70M2qyTr2299TOk5Az4Wluy1UH14D94eoo8sE49S
	 FJu0kHSTRJazYVp3ivss1c+eAEvMIe8cqtzOQpfzE99125dT1I6wiOhmIqLKCI4hUa
	 8lEdoMR8GBkJ2Z3PqWCsusxKgtmmWp015dNL24v1djTowJlYfqqsu328t2N8wWBJqS
	 Y3ftn+8AeO7RQsDZA51JoTrgip3P0AkY1hgl7f/fQ/jT+dAtAZV1OgALAoMJUiTB79
	 QudvyM1skVO2Q==
Date: Sun, 15 Mar 2026 17:16:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/17] lib/bootconfig: increment xbc_node_num after
 node init succeeds
Message-Id: <20260315171623.717a3429f8356bca3bbfcdf0@kernel.org>
In-Reply-To: <20260314230155.155777-10-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
	<20260314230155.155777-10-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 23:01:47 +0000
Josh Law <objecting@objecting.org> wrote:

> Move the xbc_node_num increment to after xbc_init_node() so a failed
> init does not leave a partially initialized node counted in the array.
> 
> If xbc_init_node() fails on a data offset at the boundary of a
> maximum-size bootconfig, the pre-incremented count causes subsequent
> tree verification and traversal to consider the uninitialized node as
> valid, potentially leading to an out-of-bounds read or unpredictable
> boot behavior.

In that case, it returns a parse error(-ENOMEM) and the parsing stops.
This seems a hardening not a fix unless actual example you can show.

Thank you,

> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  lib/bootconfig.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 56fbedc9e725..06e8a79ab472 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -429,9 +429,10 @@ static struct xbc_node * __init xbc_add_node(char *data, uint16_t flag)
>  	if (xbc_node_num == XBC_NODE_MAX)
>  		return NULL;
>  
> -	node = &xbc_nodes[xbc_node_num++];
> +	node = &xbc_nodes[xbc_node_num];
>  	if (xbc_init_node(node, data, flag) < 0)
>  		return NULL;
> +	xbc_node_num++;
>  
>  	return node;
>  }
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
