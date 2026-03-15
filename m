Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5524230270;
	Sun, 15 Mar 2026 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773562706; cv=none; b=IzxV1OkqmWTKZgWfiUMiXp4xGok3v+W/kV0t6iCPrM6y/Dk+fPKHk1Pd000TjrCMjjy6g8DZRiQMHPl8x9tNCKxRd38rqnHZ7VFcO4yB5j8FJDUAfn59MPldsYlaidOF22BFTX9a2/f6tTUPOxR4bhoPcTW8RGwJZFAAW6GSX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773562706; c=relaxed/simple;
	bh=BN2sgxZRUKXW5/1Z45wCyHuKDroHqDeNiKnQJRx8b8s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GWx+ACCzSwALlDbmeovqiR8mSALrBAgARG0PsF3nAoxmHW3B5FPmEL8ApnqwDhH9FUpDTVFEOgQXn0b+SOQ4yRl6CtL/SAMz/vOhpRQmEChg3woD6G6mOO4c3+ltimWqwoWysg9B4G6FAXnvhbbe3gjI7khxEIYlTGYA8P0tu8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRibpwCs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRibpwCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BF6C4CEF7;
	Sun, 15 Mar 2026 08:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773562706;
	bh=BN2sgxZRUKXW5/1Z45wCyHuKDroHqDeNiKnQJRx8b8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QRibpwCsJf1Zsb6HHPfu+xwwoJgEf5BKE9b63HiK3Wae4naUAuWTwQPgXGApjvN/1
	 23unx2XLkKbMv3uR0ZcBUGmryNmjZPp6J2zAmickxoqmGXLxbUvtOoUbVmqmtG9OiF
	 IngpPTljuMXTj1wPoUc9Pm/Qi7ETn8QXWD+XuSPMhvJnpqDMSnCVQw8Q8KKvnVHLRg
	 5u2NH3NjU7V1X+oMqifC8GtZKjC0gSpdzi4RN1iZ/HQPOWdkgoZ1uZCf32HyX5WdvD
	 x33ZCqin8fDF03PWk1jtMW73aum6DgGr/zbTM1nlweHP8/PIg5k9KYaL7tSTyC3okv
	 +KO92SsXI1eXg==
Date: Sun, 15 Mar 2026 17:18:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/17] bootconfig: use __packed macro for struct
 xbc_node
Message-Id: <20260315171822.aa9074468302841d17c56826@kernel.org>
In-Reply-To: <20260314230155.155777-12-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
	<20260314230155.155777-12-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 23:01:49 +0000
Josh Law <objecting@objecting.org> wrote:

> Replace the open-coded __attribute__((__packed__)) with the kernel
> __packed macro for consistency with the rest of the kernel.

NACK. Since I made this header to be shared with user tool.
As you sent in [14/17], this just breaks tools/bootconfig.

Thanks,

> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  include/linux/bootconfig.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> index 25df9260d206..c37e0096c4f1 100644
> --- a/include/linux/bootconfig.h
> +++ b/include/linux/bootconfig.h
> @@ -53,7 +53,7 @@ struct xbc_node {
>  	uint16_t child;
>  	uint16_t parent;
>  	uint16_t data;
> -} __attribute__ ((__packed__));
> +} __packed;
>  
>  #define XBC_KEY		0
>  #define XBC_VALUE	(1 << 15)
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
