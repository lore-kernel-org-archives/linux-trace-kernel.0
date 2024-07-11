Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8F166317;
	Thu, 11 Jul 2024 15:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711092; cv=none; b=ukF0SJEMrLRF6jIA/ucBwm/KAE4GO9L1/3ZEXcHL7Z5rDcNenvwe4H61UZc6M6ty3PxPTtB5zFhNhk8d6Sqfp7hCfaN6svtCpgZjxOxIFAch5C9wTqOrowV2INf8qJL4jNAOKkuWu5nI198mxZ1+GBhMnjeJnX74y/emELWuWDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711092; c=relaxed/simple;
	bh=d9RliYAECySZKv1l3D7lB1ybZJQjQsA3lRQS/PnpAMA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DTvp/R0Sl9z7z/J9oKKgc7abAjic2xIcQEtUrvzlp/e3hK74mkUREoAR+rVEVyiZfag9yqXnikiVUYV4iN4Y3D/lgH4kEj2weXXBel05EVMhtR3Q6jp8Bbpt4zb5HvZs8PSFyGFP6RZ7jeJevF5iTvU8PixFA7J9JF5NPbDKypc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2/0NtzS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2/0NtzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A90C116B1;
	Thu, 11 Jul 2024 15:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720711092;
	bh=d9RliYAECySZKv1l3D7lB1ybZJQjQsA3lRQS/PnpAMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O2/0NtzSVMD/wpS8x0vwW2cLRXsacwfuKXur/arjRVVzXm93l7kpDmK8+FsujS3jK
	 KUwPlSa6pEB7ZgMil/BxAhuomMqWGO+NK+drRXOInX70eQ8pxC+yo3HfmqWvOkoLI2
	 vNCVB4W+YZPILvf+4p792MYwuxzvoobewIo4VPQe8fTKXcBhzej1N9LdyhaeWI9jNq
	 mLB69SNSXQXOVn2+MaFGAPWua8V98pyD1HMkX4ApVSyHwC94YRMUxrW3u5m66GmK/k
	 cTJqAoHD+LVfL/GmZe31XGn7a9ZBg/98cxTAt3keDMdQbO9jH6wrrdhwhYSguuSiPE
	 5fqAhHMZMXPmw==
Date: Fri, 12 Jul 2024 00:18:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, peterz@infradead.org, clm@meta.com, jolsa@kernel.org,
 mingo@kernel.org, paulmck@kernel.org, rostedt@goodmis.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] uprobes: simplify error handling for alloc_uprobe()
Message-Id: <20240712001807.bd7589fc4f910ad14154e06a@kernel.org>
In-Reply-To: <20240710163111.GC13298@redhat.com>
References: <20240710140017.GA1074@redhat.com>
	<20240710163022.GA13298@redhat.com>
	<20240710163111.GC13298@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 18:31:11 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> From: Andrii Nakryiko <andrii@kernel.org>
> 
> Return -ENOMEM instead of NULL, which makes caller's error handling just
> a touch simpler.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> ---
>  kernel/events/uprobes.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4950decebe5c..e5b7c6239970 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -725,7 +725,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>  
>  	uprobe = kzalloc(sizeof(struct uprobe), GFP_KERNEL);
>  	if (!uprobe)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	uprobe->inode = inode;
>  	uprobe->offset = offset;
> @@ -1166,8 +1166,6 @@ int uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset,
>  
>   retry:
>  	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
> -	if (!uprobe)
> -		return -ENOMEM;
>  	if (IS_ERR(uprobe))
>  		return PTR_ERR(uprobe);
>  
> -- 
> 2.25.1.362.g51ebf55
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
