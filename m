Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79A412CDA5
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Sep 2026 01:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788831994; cv=none; b=JOgEVtZ6w7hzVReULzbiMZeKLvsFUYD9h9fONsFAvNOTG78cnn6OBjaugLtNyT0Yafkg48v9F77qsgdCXawqp5B4BTe35WSp+hFjT3siqCW4xdDgTvb0vj36phIxjnJJBJG1zP3QFdkB+B/NxsHcc2svbQzRW1HTmNcJSHIL8B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788831994; c=relaxed/simple;
	bh=yWnDVFbWGWBWRDM0X/thlfaK6I7BEXtCf3JqgeBIjmw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DtPZxHmiySrpXP8YinyaBf/tAYRf7fB9FqQtpTW0lsaUNvU810h5QPz1GaxVH6FAgCdpYJKMzBbCBtm9G8e6fmerive+gjoCGVy9pO/RJmqK+zCocAYTfZDW+FinZsdb99aGrQucBdNQrn7nhHjRw44EmwckeyRkMW4l6V+WBWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHbCIJs6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHbCIJs6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672EA1F00A3A;
	Tue,  8 Sep 2026 01:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788831992;
	bh=DgTHKWcm+lyC+tzTw5YEM65OlW8NAY82EFYkOlD796g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VHbCIJs6N83+1OKSzu3LNw8/5aJ5KxdN944lOoAZjxnsnQ0x/GTu3bZAjyjq9StTw
	 s0lrMzLTnB+BTa+im9daOSRO/XBhrpniyavGV4pQurjeNCpQzQdrtjfE+bMZHC+ooO
	 Dbei87sW0VptJBLt90+mT/T6gqmW2tYMgihH9pI7GxaB+fVESgyDntej7r/7+j2oN6
	 uZk8cupB1p7ecezCuozj4HqiA6YrDhoB/zuepw6h6pFxPsZCx+YuMZA55IGaSM/+Pk
	 /Pbzf+Bpwc8/Z4ypGpTWpWXpYA0OvjiIdkn6OiHC3aU7Fx/iA1qQSGqWu9tHf56UPC
	 sQ00kmK2R+FhA==
Date: Tue, 8 Sep 2026 10:46:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: remove unreachable index checks in
 xbc_verify_tree()
Message-Id: <20260908104629.e7a85a90e376b843dbc51dc7@kernel.org>
In-Reply-To: <20260905141637.1547429-1-ekffu200098@gmail.com>
References: <20260905141637.1547429-1-ekffu200098@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  5 Sep 2026 23:16:36 +0900
Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> xbc_verify_tree() checks that every node's next and child are below
> xbc_node_num. Both fields store the index of an existing node, which
> is below xbc_node_num.

This is a kind of foolpoof/defensive checking. (so I call it verify.)

> 
> So remove the checks.
> 
> No functional change.

Hmm, OK, I think we should decouple the logic/implementation
verification from runtime verification (e.g. wrong format)
and move the former to tools/bootconfig.

Thank you,

> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  lib/bootconfig.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 89c88e359179..d383430637ee 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -1005,7 +1005,7 @@ static int __init xbc_close_brace(char **k, char *n)
>  
>  static int __init xbc_verify_tree(void)
>  {
> -	int i, depth;
> +	int depth;
>  	size_t len, wlen;
>  	struct xbc_node *n, *m;
>  
> @@ -1022,17 +1022,6 @@ static int __init xbc_verify_tree(void)
>  		return -ENOENT;
>  	}
>  
> -	for (i = 0; i < xbc_node_num; i++) {
> -		if (xbc_nodes[i].next >= xbc_node_num) {
> -			return xbc_parse_error("No closing brace",
> -				xbc_node_get_data(xbc_nodes + i));
> -		}
> -		if (xbc_nodes[i].child >= xbc_node_num) {
> -			return xbc_parse_error("Broken child node",
> -				xbc_node_get_data(xbc_nodes + i));
> -		}
> -	}
> -
>  	/* Key tree limitation check */
>  	n = &xbc_nodes[0];
>  	depth = 1;
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
