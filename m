Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE61EBA14;
	Sun, 15 Mar 2026 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773562695; cv=none; b=iqXn/3zSmtZcQTFlTSOebBMdisoa98yd8wEXQCLr7a71AeMGOrM/aG6shJZ/9Gateg3sAocmfdozD2Kz+WwruYCZ2BQrVPleS3454traeY/Wf2p9eDkxiwW9lAJtLWRoAqHGqe4HXWh003lm5Tgn3EFSxv6xI5YLNgBE52dNEoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773562695; c=relaxed/simple;
	bh=NvbMz6KMBKQu/VgZYhZ1tsN1oZMHhbQvQ/IAN+nZLkY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=emYYNR8n+wo5gMy51fITlZ9Z4ev2Nwdalz82wtvMr40x6f12MzftJub3My0udoSkNctSUggPpQHYXY/nG/JV2ggOnW/HBxFHdc1n8xvTL54ypG9X3skRQLzy0nHHjHYZkmi28+cGikR2RqEbmyZnxwUyQkm+kQOMcYYq9W4Cx0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1i9I4Z6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1i9I4Z6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF82C4CEF7;
	Sun, 15 Mar 2026 08:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773562695;
	bh=NvbMz6KMBKQu/VgZYhZ1tsN1oZMHhbQvQ/IAN+nZLkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b1i9I4Z6RO/RZqpKtQ5ruVRMGr2GyRrmS7KEtNJXj49tiunmNbACSGZ5MQAWhN1zv
	 0bqjFEUO7/25UVfuhr03P2O8Z4OL0ykzanKzbLxBL61E0L1Pz34dhDtb1q3X7NpOEa
	 x5kXg6nyV2WVXSB8lc2EZ1aNQZ/ItybtrjHwWcUpPUWWzuwCeiudR8viua1tjL5+tu
	 moQGaFZOWDNPRp3hF8tidIlmwFq7p8/WcXt87ppMrrHa6C0k+4AQy2PvfuFq0L0dxy
	 3MufSrcOykdgBZH2ZdtLBHFmJt7eaBNE1563QimZtUCe9EbuJaR1H39QciMFTD2JhD
	 /eAvZ+h2Ubxqg==
Date: Sun, 15 Mar 2026 17:18:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/17] bootconfig: add __packed definition to
 tools/bootconfig shim header
Message-Id: <20260315171811.da655bbf81f9e2b316d87478@kernel.org>
In-Reply-To: <20260314230155.155777-15-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
	<20260314230155.155777-15-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 23:01:52 +0000
Josh Law <objecting@objecting.org> wrote:

> The tools/bootconfig userspace build includes the main bootconfig.h
> via a shim header that defines kernel macros for userspace. Add the
> __packed macro so the struct xbc_node declaration works after the
> conversion from open-coded __attribute__((__packed__)).
> 

NACK. Please do not self recover after break something by yourself
in the same series.

> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  tools/bootconfig/include/linux/bootconfig.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/bootconfig/include/linux/bootconfig.h b/tools/bootconfig/include/linux/bootconfig.h
> index 6784296a0692..41c50ab95ba5 100644
> --- a/tools/bootconfig/include/linux/bootconfig.h
> +++ b/tools/bootconfig/include/linux/bootconfig.h
> @@ -48,6 +48,7 @@ static inline char *strim(char *s)
>  
>  #define __init
>  #define __initdata
> +#define __packed	__attribute__((__packed__))
>  
>  #include "../../../../include/linux/bootconfig.h"
>  
> -- 
> 2.34.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
