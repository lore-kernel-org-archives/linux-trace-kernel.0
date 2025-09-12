Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2836EEADC
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757635437; cv=none; b=jYMtaWJ5yUeasI8CJVRKIimcbB6BscqrteEKvtPsiHfzl/FoKOuu7YdorC6H68arSE1bVcVEw5IYb8/vKVqgAtfctw2sV3wHPVZz4vRwBjWhFWp+YzkKFhPMS0zrSe60kowh08wucmcL1mxyC6Qd3iSw59ntzxxCV7EYraAFWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757635437; c=relaxed/simple;
	bh=RseXRYYxeFl3ygcQ9n+X6SAhU2s/akwHzrJ0pW2nKRw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ossvfD7tDC++V4KBiL322Y/YNtMfoQS2d3sQTdsnYy98C355yGUNKc1yQTeyEu/i6+ftfrT8nWxTIGBKERoiJuk8FEXeO8RH2ziJS3wCzGdcxcU63IwysAy/QCc3uIQGTNIMPplCGw1L7VZ63iqHWtdc41fAiqlDcUpEMsRkRPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVFHLRO4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVFHLRO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0414C4CEF0;
	Fri, 12 Sep 2025 00:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757635436;
	bh=RseXRYYxeFl3ygcQ9n+X6SAhU2s/akwHzrJ0pW2nKRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lVFHLRO406gOPdRocvvWHhG8JwH4mYWTlE1iT1aC2UlxNserPjDUFwVN/5KCvR4fX
	 26O6CXXktuTiDA3wVM3CiptkNleKUdtkfnHA265aE0k/nqrAGM7U5i12z8PpmpxTJo
	 3uI/EhTG16jbABXe8v7hUaqoDGXmLlF/BLa3InRC5gVR8INFBXIMt95O5Ih54YzzIz
	 y9gdnGv4VRNu2ulMayV3LAgjhXmllKP1OUFtDWD/7E6MOB15dbcI9LgTZrj0aqEl+f
	 JqETFue2EoNBU2usiYIYhXh05dRCWuygMwUEjy6CGHUAOjTlSjfK6YBnNvEGzu1XcJ
	 ePpBv6Cn6jzvA==
Date: Fri, 12 Sep 2025 09:03:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: zhuangqiubin@linux.spacemit.com
Cc: mark.zhuang@spacemit.com, Dave Hansen <dave.hansen@linux.intel.com>,
 Naveen N Rao <naveen@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing kprobes maintainer
Message-Id: <20250912090352.1f1f7098aea172164f8f31f1@kernel.org>
In-Reply-To: <20250911092757.2423-1-zhuangqiubin@linux.spacemit.com>
References: <20250911092757.2423-1-zhuangqiubin@linux.spacemit.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

This commit has been merged to v6.17-rc2 already.

Thank you,

On Thu, 11 Sep 2025 17:27:57 +0800
zhuangqiubin@linux.spacemit.com wrote:

> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The kprobes MAINTAINERS entry includes anil.s.keshavamurthy@intel.com.
> That address is bouncing. Remove it.
> 
> This still leaves three other listed maintainers.
> 
> Link: https://lore.kernel.org/all/20250808180124.7DDE2ECD@davehans-spike.ostc.intel.com/
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Naveen N Rao <naveen@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: linux-trace-kernel@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..a2bc2bb91970 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13686,7 +13686,6 @@ F:	scripts/Makefile.kmsan
>  
>  KPROBES
>  M:	Naveen N Rao <naveen@kernel.org>
> -M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>  M:	"David S. Miller" <davem@davemloft.net>
>  M:	Masami Hiramatsu <mhiramat@kernel.org>
>  L:	linux-kernel@vger.kernel.org
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
