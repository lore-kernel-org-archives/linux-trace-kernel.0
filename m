Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010401A5BBE;
	Wed, 20 Aug 2025 01:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755652058; cv=none; b=c3COniuCV35winPC6n3mQmYWWK26HKFwQbW8+30Z23FiV7F/r48odMVB0aEvovtL0clV34BQvSZCQUlhTCMTci3r/6uuLqtyQSMK7ypFls/HK4KsrnVAqz9JXS+5K73wO0GfSf4iaHXICcWcRM2l5q0MyK9DnEX9w+3cTLEUK68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755652058; c=relaxed/simple;
	bh=7k1sO4iEhovzZCGouVmIOXCPWu2hqIEKv/p30wza8KM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Peg9/ieHxmEuxOb6ukW6SA41vNZjM41offM0Sa5yqCm/SjVpc/mNOjwA1xBo2lAO5FU1E0I64SC3pB2nYuBJX7ig/h/WqJZhsVYqB6sYn3/mawijjRm+E/CkwU5i/Ly3WkgvnYj0qsQcfdtuoL0DpFUbs0Hb6SAb7lxGDI21ZMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jm+YZY6+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jm+YZY6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55680C4CEF1;
	Wed, 20 Aug 2025 01:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755652055;
	bh=7k1sO4iEhovzZCGouVmIOXCPWu2hqIEKv/p30wza8KM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jm+YZY6+eKEYj/dwKSFp7pLWmr4rLJJ+lwO++Ltrmw8KhMyMguxRDbf/jHiIyl/jb
	 XRh3AtGTizFqz7pBQFHA1f9pwFiXWgmwaZkYVjvNCtT7PaDh9xtL2URYQ7vARarjb8
	 rtKaM1eJFl9yLS+i/ncdspn+Fwd0+HVjDn1h4wUsRGetXBR8dCz80At8Qngi6uSoD3
	 aMX9RnMBnWpOH0TBf6WA3MJ1YwTIsagJ1YrUSyErW5ReGUMVmE5rvccQSZ6jf6XZfU
	 cuGJ8mmym1nPbWwFi90Sjl17oIRXs+F2lOosccdSBP4TS4p5KERRs9ESK9BLO8GY/f
	 MVcLUl0XvQ3PQ==
Date: Wed, 20 Aug 2025 10:07:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ben Hutchings <benh@debian.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: Fix negative seeks on 32-bit with LFS
 enabled
Message-Id: <20250820100731.df29750fa21d864d18169d5c@kernel.org>
In-Reply-To: <aKHlevxeg6Y7UQrz@decadent.org.uk>
References: <aKHlevxeg6Y7UQrz@decadent.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 16:21:46 +0200
Ben Hutchings <benh@debian.org> wrote:

> Commit 26dda5769509 "tools/bootconfig: Cleanup bootconfig footer size
> calculations" replaced some expressions of type int with the
> BOOTCONFIG_FOOTER_SIZE macro, which expands to an expression of type
> size_t, which is unsigned.
> 
> On 32-bit architectures with LFS enabled (i.e. off_t is 64-bit), the
> seek offset of -BOOTCONFIG_FOOTER_SIZE now turns into a positive
> value.

Oops, I thought the sign bit would be extended.

> 
> Fix this by casting the size to off_t before negating it.
> 
> Just in case someone changes BOOTCONFIG_MAGIC_LEN to have type size_t
> later, do the same thing to the seek offset of -BOOTCONFIG_MAGIC_LEN.
> 
> Fixes: 26dda5769509 ("tools/bootconfig: Cleanup bootconfig footer size calculations")
> Signed-off-by: Ben Hutchings <benh@debian.org>

Thanks for the fix!

> ---
>  tools/bootconfig/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 57c669d2aa90..55d59ed507d5 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -193,7 +193,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
>  	if (stat.st_size < BOOTCONFIG_FOOTER_SIZE)
>  		return 0;
>  
> -	if (lseek(fd, -BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0)
> +	if (lseek(fd, -(off_t)BOOTCONFIG_MAGIC_LEN, SEEK_END) < 0)
>  		return pr_errno("Failed to lseek for magic", -errno);
>  
>  	if (read(fd, magic, BOOTCONFIG_MAGIC_LEN) < 0)
> @@ -203,7 +203,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
>  	if (memcmp(magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN) != 0)
>  		return 0;
>  
> -	if (lseek(fd, -BOOTCONFIG_FOOTER_SIZE, SEEK_END) < 0)
> +	if (lseek(fd, -(off_t)BOOTCONFIG_FOOTER_SIZE, SEEK_END) < 0)
>  		return pr_errno("Failed to lseek for size", -errno);
>  
>  	if (read(fd, &size, sizeof(uint32_t)) < 0)


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
