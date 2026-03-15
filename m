Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0D31EBA14;
	Sun, 15 Mar 2026 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773562608; cv=none; b=q5A0mZPa3wk+E5sQKiSDqybQ6DVekpMRVGnvUC/2BHtWnQqoeYg1w6msslLF7y7JDDGPkun19i3vh2UicnwizqICWpumsluvPww0p9/xs7HU6a5JmHalsJjUO8BqoUPmIBT5Z3M4aTqd1oPju+rJYAOuX1PcpXJ1qdFnMVIKadI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773562608; c=relaxed/simple;
	bh=asEirovM0yxrksDqtmQwMqJlnlnKxib8/01w3vglH3A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oauiKqEgd67J5/se4r4j9oNgzS6MUCBepn+J4ZhAYZigqtEJL1k3ct8fkQuhyMOfpzoQ5Wxg1yVDRwoM68p7g5pp0vq/oqwnjMj1/W0BaSNJXlQiCEka8pvi4mj2bBoc8kt4Vh0N7FYRAtBiGbSYBFnIv5O+XhlbpEpV7wEMtZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHTT+uhs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHTT+uhs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212E1C4CEF7;
	Sun, 15 Mar 2026 08:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773562608;
	bh=asEirovM0yxrksDqtmQwMqJlnlnKxib8/01w3vglH3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uHTT+uhsQe6HDfofHtYCbLuyFfvsyH4+XjTTpTkHgWXjqyVzETiAFy0GqyIfa8r/j
	 8jnrQd9cktayZfrkA0rdVL1u2cuqp/mh3D1Qlj4r+wfHr4U6WwQChxeAyolA1/nJ9+
	 qMki4WtUgp2IwF2GQxi4bW3i7Cg06lDYR0QEDbbYwGkxP58i6otYrzLd8u6gc9HCGq
	 Vo2gSkN05pB4/CYGCEImxN8LFsEpqBWno8i4dpb3J2Qq8XDgyX0+JjgcoIZJiPs50v
	 mDZiU7Fr+xm6ghTkU7/VTC4C3fK3Kj+k019FGUbEy2fvQ49Aa209QkjF4/w47doxPc
	 Kfak5rZfGyJQg==
Date: Sun, 15 Mar 2026 17:16:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 17/17] tools/bootconfig: fix fd leak in
 load_xbc_file() on fstat failure
Message-Id: <20260315171645.f5bf64edf6aa68550096a231@kernel.org>
In-Reply-To: <20260314230155.155777-18-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
	<20260314230155.155777-18-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 23:01:55 +0000
Josh Law <objecting@objecting.org> wrote:

> If fstat() fails after open() succeeds, load_xbc_file() returns
> -errno without closing the file descriptor.  Add the missing close()
> call on the error path.
> 

OK, but anyway this exits soon after failure. So it does not
cause actual problem.

Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")

> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  tools/bootconfig/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 55d59ed507d5..8078fee0b75b 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -162,8 +162,10 @@ static int load_xbc_file(const char *path, char **buf)
>  	if (fd < 0)
>  		return -errno;
>  	ret = fstat(fd, &stat);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		close(fd);
>  		return -errno;
> +	}
>  
>  	ret = load_xbc_fd(fd, buf, stat.st_size);
>  
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
