Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33567149C41;
	Wed,  9 Jul 2025 02:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027177; cv=none; b=CaRRgvMRx5XEcJXoqo+GVc2cTIJXiM30SEGKE3WwHr5kIZ9VtYDbyhKQn57/vhR31BYrp8F1mBOAL1Ve3S7dMlmwrEe4plVQoWwqXVI0TWTcttYj9p8f0W/ywc0Cdj0r6T+4s4+NxuUlsSrn+5MljhG+yUnN7ZjINlJGS2sTkXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027177; c=relaxed/simple;
	bh=+FIfxC/8IGst/T4gMAFlP74yh/DdL1C4DT5sZ1mSO9s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fxZTF8Ico9toHCC/TJZZktcUSPIlyPDlycwh0AbEKXHB/vNy58ShBEsrWtG0UxeM8I3uUFPNHsxK67va12WU0ANP+9fOjSuhPdZVisUpwGjozTFCqBgheDXLUgnPF6BmGAeRx4hWaEtglYQ3nO1jGGVM75NSroHHkZJYD6WUkK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbWNujdX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbWNujdX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D36C4CEED;
	Wed,  9 Jul 2025 02:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752027177;
	bh=+FIfxC/8IGst/T4gMAFlP74yh/DdL1C4DT5sZ1mSO9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LbWNujdXc5jYrJBRheZq1vULbJVIMIksrsZeTGL+zzJuRCJ0uOhVth7OuXcc+l03q
	 xDoNZ6e6ev30CKidTV6QGtT5dOXcHmFzla1Mjfk17GJopHl7Lp8dK3Lr83rhrqiydB
	 4/P6HpofUPI182G6mSUCQFX1gEyG9bpkmiJvgow/SsFvDMkzDfLTihkf6VmB8ayNR7
	 3al17PI7nHZsGr2ZGIQs8lw9V8bXndkQJMHG+evJKn4XkULAx2eMA0kBfVItxXepn0
	 O56S6MwDMuBIorSUqKn96ycL9LnmMuhCh+7YGgJmv2I9ms7O5dIeHSBlv/3cu2wCsL
	 4IhftIN1jcX9g==
Date: Wed, 9 Jul 2025 11:12:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: bootconfig:  Regex brackets need escape
Message-Id: <20250709111254.e85d0238a0e286dec33a3e46@kernel.org>
In-Reply-To: <20250708092204.1558-1-unixbhaskar@gmail.com>
References: <20250708092204.1558-1-unixbhaskar@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Bhaskar,

On Tue,  8 Jul 2025 14:46:08 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> It was showing malformed syntax colors below those lines,escaping the posix
> class brackets bring back the syntatic reference back.
> 
> Oh, malformed syntax colors means,(in a editor,in this case Vim, where syntax
> highlight is on). In essence, it might complain while running the script.

Hmm, that means your editor's parser's bug, right?

> 
> Hence, this trivialities.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  tools/bootconfig/test-bootconfig.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
> index a2c484c243f5..211409539737 100755
> --- a/tools/bootconfig/test-bootconfig.sh
> +++ b/tools/bootconfig/test-bootconfig.sh
> @@ -167,8 +167,8 @@ echo > $INITRD
> 
>  xpass $BOOTCONF -a $TEMPCONF $INITRD
>  $BOOTCONF $INITRD > $OUTFILE
> -xfail grep -q val[[:space:]] $OUTFILE
> -xpass grep -q val2[[:space:]] $OUTFILE
> +xfail grep -q val\[\[:space:\]\] $OUTFILE
> +xpass grep -q val2\[\[:space:\]\] $OUTFILE

Can you escape it by quotations? In that case, it is acceptable
as a cleanup. e.g. 'val[[:space:]]'.

Thank you,


> 
>  echo "=== expected failure cases ==="
>  for i in samples/bad-* ; do
> --
> 2.49.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
