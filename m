Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA441CD0C;
	Mon, 14 Jul 2025 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752456079; cv=none; b=GGmfczPwtAMzu8uKxaIhmkQzrG+giCEG4OgHuyDfwY3PgmZAYPPACyQFjTAyhSfl2jIqII/D/k18KbKdbn3nIWCgGe9f1Xbx7Z98X9VigUgIDz6iJqYquSsSIBhUEp9XgnosjQ0cqdpE0f3UalrSciPP1ftoa6qsm5BqOtFq8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752456079; c=relaxed/simple;
	bh=0pZsjJPFjTBRzu8RCi7jbtGIzbhc2uOSBp2M4BX9wew=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l2pWtDZnILhnidSo4DBvDEGeMkmssPs5KTvCCIbenf+obreGnCHlLT1fAT9pVbn1pfMoTDvoe07dQX4Gi6qHRlGgYvkKXtQZxvBIzCTxhBcdYM82hWS3kh+Zc/5LGjT1NAdIoqbj/FmtDfPExeil5nmgntqXEctzdR4rvSaMY8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SULIFZse; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SULIFZse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC3CC4CEE3;
	Mon, 14 Jul 2025 01:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752456079;
	bh=0pZsjJPFjTBRzu8RCi7jbtGIzbhc2uOSBp2M4BX9wew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SULIFZsewYpgYsiHWclwUuuBuV2OF304Nj4f/AakRJ2I2Cfp3kd33gc9GtDSkFx9k
	 nBfbBvsyAySes0Bou1DMaJUi9SJsFj0iYTkjnUOtb1WafIJc7Be9HEjwGbGHfpqmMG
	 ntMmxoQHMSeQH+YXM6SyloZvJUMEnPbysnKQA5CWNDGUrxzgE2RiHFyonrwxykNEUI
	 Z+tgwapC2ZdQYoG1+Cpak/SGJa2m5h2sxwPyXP+pmgeg/HCmOH66Dmaz1p51m/Kulr
	 IA/pztecYxd8NLZ31o+BDTTtVshSalvljHcaAPcLCl7/MQRz56sRsZAq4ov0D4+BKV
	 AOlzY3wGY9zXA==
Date: Mon, 14 Jul 2025 10:21:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools: bootconfig: Regex enclosed with quotes to
 make syntax highlight proper
Message-Id: <20250714102115.eeb177ae2bbddb63e983002e@kernel.org>
In-Reply-To: <20250709030141.27483-1-unixbhaskar@gmail.com>
References: <20250709030141.27483-1-unixbhaskar@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Jul 2025 08:27:59 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> As suggested, changed the square brackets escaping to quote the whole Regex
> class.
> 

Yeah, let me pick it.

Thanks,

> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Changes to V2 from V1:
>  Surround the Regex class with single quotations.
> 
>  tools/bootconfig/test-bootconfig.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
> index a2c484c243f5..32401bf61340 100755
> --- a/tools/bootconfig/test-bootconfig.sh
> +++ b/tools/bootconfig/test-bootconfig.sh
> @@ -167,8 +167,8 @@ echo > $INITRD
> 
>  xpass $BOOTCONF -a $TEMPCONF $INITRD
>  $BOOTCONF $INITRD > $OUTFILE
> -xfail grep -q val[[:space:]] $OUTFILE
> -xpass grep -q val2[[:space:]] $OUTFILE
> +xfail grep -q 'val[[:space:]]' $OUTFILE
> +xpass grep -q 'val2[[:space:]]' $OUTFILE
> 
>  echo "=== expected failure cases ==="
>  for i in samples/bad-* ; do
> --
> 2.49.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
