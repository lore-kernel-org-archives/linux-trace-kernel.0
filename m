Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D230145359
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723062482; cv=none; b=B9ZIwQdTtOh2f8ay6InESsguG794ZwX7EKUiZuLmEjATSwdDF5VY6B1sZJOJ94k8hzOtVSy9bdtB92Dmhk9aLU0wLDhA774UHl213Skc9Lm1PBDiPRG2aiErVXyM8hrHNX7ug1cILiPyAS/n9rvqUv2AnIsKb84GfnlFVTvKEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723062482; c=relaxed/simple;
	bh=rFf7hZpeHtrk4BHqXUYWampW+6Upf0s1r5hIMy27x1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=th3nT+DMNM/L7saxDdECpDCjdnkAmhF/V/dCUEZ0phXODOvVuXWVaAdBkaaN4UQY2PxIBBuAmOq7xue6THyfmh7QlowzWuaiCRmq5bjU7luLyzvGEzMJ14wjBYvGEQW5qvOlENW0f6uEvIhQLqZG80cewGYB2BBUSrSlH//Qw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=cwInjCqx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="cwInjCqx"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7ab63a388bso9092666b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Aug 2024 13:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1723062478; x=1723667278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BTz42cr1JbN8ycg8cwiTzfcvlsYceWEWcHUaslHiHqM=;
        b=cwInjCqxzXQt/0G79CKHAenygrBnjcT95y6p1TZPzhty0IFmLoLmigVwFTq7CPBBfR
         D4vINoOBArWUp3a/n5bQu/UVyZMqRvB8KR2FOa4tIXDuTwHafH6rfNFIggpQxxSAyBxc
         APAHeIgjAOGEFVRojRHJNfX84lmvJxPGZ5okFD/CUhOHbsjPK5ofTD34wLMKizL4pnPv
         46Y7b5TdP9TDXyendQl1YX6nLYvlzUq71IUp2hv9KitBl/pOtZR6p0OOAV8YKciwX1b1
         P/skJtkAr1vsB4SHhAB9HiJE0RQhkYrZ9DuAcV4zHpxW3W4alpKQQtQrFwRQJu1ZczNJ
         QrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723062478; x=1723667278;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTz42cr1JbN8ycg8cwiTzfcvlsYceWEWcHUaslHiHqM=;
        b=irSshoO1TrMdcun4rsTs5+1IBQ1oJKRFhQL3ZbfQlAZgsfVAkfN1aUy8TOVVL8ZuIz
         ElsAcp26AGS4xX3VCmE/o9n7qWV93SavvLFdQ7MDjehfoFsQEMJEwNTlZw5iNJLN+wKT
         u0BfpogU4lmsnfBmlkeJKT4DxjcfjAt92b4U8ddP/mbk49FlGlPzT+6dLJN/nH2LvpzM
         TXyMnM44+ULM3N7pG1VOIPcANPNc4olPtp1zgnm61hYUH+90v8vnHWRzy9Ch5szJfjgv
         BLvGBS493m4P9/uWq1ZWJhbmW6GlFuKoY6aJBMQLOOm7VJrQKbjGlXDTnTBajjXYIV6K
         CCOA==
X-Forwarded-Encrypted: i=1; AJvYcCX7m+cbVj8g3xHhKE3ePlDDbWxirTQDbqq7mHJ+wuzqUUsdyF/Xca77xPdvewHISliVFO20xi0wIYr7cvf0b3S46PrL1U5Ek31P+ATjeJ/Hqnmg
X-Gm-Message-State: AOJu0YwVFAtHyaAkajnDEKy6bLIhzbPY1aP/JdiTSmILqLY1dwrktqMM
	a8Iz5Oq5uh1th80K9r2o6PlTROmOyfNBLxbx4RONXQd6Lebtyang8u6VGuHYsjI=
X-Google-Smtp-Source: AGHT+IEveBglM+6d2pnGpOLzQpp7XUy6FiGpWFD5wNmd7/fBC3dQqSZ0kcTJYlh0U6XyWrCQha1xFw==
X-Received: by 2002:aa7:d4c4:0:b0:5af:5342:c5c0 with SMTP id 4fb4d7f45d1cf-5b7f521e0a5mr16732102a12.23.1723062478266;
        Wed, 07 Aug 2024 13:27:58 -0700 (PDT)
Received: from ?IPV6:2003:f6:af11:9b00:1236:f9a6:4d0d:776? (p200300f6af119b001236f9a64d0d0776.dip0.t-ipconnect.de. [2003:f6:af11:9b00:1236:f9a6:4d0d:776])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b931794sm7336927a12.64.2024.08.07.13.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 13:27:58 -0700 (PDT)
Message-ID: <400f3e4f-551e-4f7a-9751-84d711c6572b@grsecurity.net>
Date: Wed, 7 Aug 2024 22:27:57 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tracefs: Don't overlay 'struct inode'
To: Steven Rostedt <rostedt@goodmis.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Ilkka_Naulap=C3=A4=C3=A4?=
 <digirigawa@gmail.com>, Brad Spengler <spender@grsecurity.net>
References: <20240807115143.45927-1-minipli@grsecurity.net>
 <20240807115143.45927-3-minipli@grsecurity.net>
 <20240807093545.4ec51d61@gandalf.local.home> <20240807134453.GZ5334@ZenIV>
 <20240807114948.6d57af23@gandalf.local.home>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20240807114948.6d57af23@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.08.24 17:49, Steven Rostedt wrote:
> [...]
> 
> So I could use destroy_inode() for the removing of the link list, and then
> free_inode to free it. Something like:
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 1028ab6d9a74..ae2cb2221acd 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -53,15 +53,14 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
>  	return &ti->vfs_inode;
>  }
>  
> -static void tracefs_free_inode_rcu(struct rcu_head *rcu)
> +static void tracefs_free_inode(struct inode *inode)
>  {
> -	struct tracefs_inode *ti;
> +	struct tracefs_inode *ti = get_tracefs(inode);
>  
> -	ti = container_of(rcu, struct tracefs_inode, rcu);
>  	kmem_cache_free(tracefs_inode_cachep, ti);
>  }
>  
> -static void tracefs_free_inode(struct inode *inode)
> +static void tracefs_destroy_inode(struct inode *inode)
>  {
>  	struct tracefs_inode *ti = get_tracefs(inode);
>  	unsigned long flags;
> @@ -69,8 +68,6 @@ static void tracefs_free_inode(struct inode *inode)
>  	spin_lock_irqsave(&tracefs_inode_lock, flags);
>  	list_del_rcu(&ti->list);
>  	spin_unlock_irqrestore(&tracefs_inode_lock, flags);
> -
> -	call_rcu(&ti->rcu, tracefs_free_inode_rcu);
>  }
>  
>  static ssize_t default_read_file(struct file *file, char __user *buf,
> @@ -437,6 +434,7 @@ static int tracefs_drop_inode(struct inode *inode)
>  static const struct super_operations tracefs_super_operations = {
>  	.alloc_inode    = tracefs_alloc_inode,
>  	.free_inode     = tracefs_free_inode,
> +	.destroy_inode  = tracefs_destroy_inode,
>  	.drop_inode     = tracefs_drop_inode,
>  	.statfs		= simple_statfs,
>  	.show_options	= tracefs_show_options,
> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> index f704d8348357..d83c2a25f288 100644
> --- a/fs/tracefs/internal.h
> +++ b/fs/tracefs/internal.h
> @@ -10,10 +10,7 @@ enum {
>  };
>  
>  struct tracefs_inode {
> -	union {
> -		struct inode            vfs_inode;
> -		struct rcu_head		rcu;
> -	};
> +	struct inode            vfs_inode;
>  	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
>  	struct list_head	list;
>  	unsigned long           flags;
> 
> 
> I'll run this under some more tests and see if it doesn't crash.
> 
> I'll apply the first patch of this series too, and then probably use this
> one.

LGTM, will give it some testing here too.

Thanks,
Mathias
