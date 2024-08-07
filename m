Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4C2364BC
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061992; cv=none; b=Sfq052AlU9Zw7pkVV5ZqVQt8RYNdoSIl8kOWlISRJnG4IvKe202xVU2mAlzG0f2r9KEBiKefiVEKEb7mSIVbpn27QnCgUtB4xxcj502qhNcBQ3zH8IxgCyXH4VwNA8agx0kFl3/vOvYejFvZDzMUqZRFucKPDlrpmufcBJUCROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061992; c=relaxed/simple;
	bh=Mm5xBsEiMBizqy8uFWth36byIVjNv5JDXV//ZZE3CgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIFY6CqcQIrcsuUdL9n46k947ffJSWgpIi1QZ7hkZQD4rZdKC1NzCV0h61FVJF82XaIggqL7d9ZxAqgidIaq6oQ2RGCyuzAymqTQfLqDoc0PvHX0TQH8s4cNZJ1ivY6eFB5NZQRlcYO6AcYu3o8c6kcsVQLnqHyYk2NeEDBkk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=TNLazwZP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="TNLazwZP"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5b9d48d1456so375509a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Aug 2024 13:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1723061988; x=1723666788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l7FXBsAmmx0UR85DFWCTR+dBZBa9+irjHF1xNp8r5Cc=;
        b=TNLazwZPVc8f4wBBs65ruk0Fd1xfgAJfbj+gOPU6adNS1g8FvT3z9/BtaYPBukZL4U
         9LSthpNK8UPtuZPSNsUWw43R+9O86kPdhYlN/RjuJaXUHELvkkz0HDQuaw1/rBS0FSgK
         DMhAsvknulp62p+PYlG8Exm1MKC5I+YHdy6aT9KGUkd/J7nvq88OHUaKzmo69jFj1Dnx
         p/w+VqT5Ubs9y/6SIe5ElZ3oZqaWbtC4c1nEYOtba3SdaQmBlYLAAsF3h0fuFey5fRf4
         QQtKzjBG6ULntcK07KqPuJeoEAR/MDbtSm8cTq9j442pURpDI3PKVbGoBI+WoAjdrgZq
         t9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723061988; x=1723666788;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7FXBsAmmx0UR85DFWCTR+dBZBa9+irjHF1xNp8r5Cc=;
        b=VJl/4ndbQtVM3xCz9cZuMe8jpsKhjuk1YUdsY1cu4a/oc/AFCfdL2mEIzid0ryCREX
         FUTXwTOHaJDokyWIwDpF6L8DYGeOUlFSsH/D1U5djfcmvlp+scgNsRaJycu25/BtWuLn
         1U2UcC98pll7g6Pclh0sAw2T5XAsiZjr1pdYtAzUVgWvMhG6yuEz5thyp9LpfcPsduYg
         mIhVTWFGVi6yIHUJzFOKGqMlpdWdXNGA+yk59xwO3vkWU1p9euF6c9F6fw9WaN+5HQEE
         NrGFVoMTTjC00xcopCR1Mz0K7cqepjVTjST+aA0HgC3tB0qZAuoT/QiuqkU2R1vjxCJ9
         1BMg==
X-Forwarded-Encrypted: i=1; AJvYcCXtDWLc1l9RxGzV504Htk+lbWHcrsHnoP6zmfZ0Fa44eIWttxMvQos8HxXstChUpnBk9xqw4CYhLLJDtM6kdeCyuYDTwTpS1wDzHxtT96LRpUpY
X-Gm-Message-State: AOJu0YwQnUxzhm86n4y9rEPbcQBc6a5yv8Fwxt0Df++iFQEAXgXIsKjS
	7f/h8Pc+dE9+SRg2kHLfE0bP31AN9TmQiDdZbEA1AzRjIam2h7/uRs7D09lfkec=
X-Google-Smtp-Source: AGHT+IGq+5OOobsAtqc09kR2IC6V2HMMsXNeozGUItHZXoV2jzuY8WjysyjBN8Z08Bx6GiPskP/Ntw==
X-Received: by 2002:a05:6402:2690:b0:5b4:cbba:902a with SMTP id 4fb4d7f45d1cf-5bba3672b67mr2880824a12.4.1723061987575;
        Wed, 07 Aug 2024 13:19:47 -0700 (PDT)
Received: from ?IPV6:2003:f6:af11:9b00:1236:f9a6:4d0d:776? (p200300f6af119b001236f9a64d0d0776.dip0.t-ipconnect.de. [2003:f6:af11:9b00:1236:f9a6:4d0d:776])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ba442ed7f1sm5650505a12.81.2024.08.07.13.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 13:19:47 -0700 (PDT)
Message-ID: <178d8e10-1dd8-48de-858f-1a04c419c331@grsecurity.net>
Date: Wed, 7 Aug 2024 22:19:46 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tracefs: Don't overlay 'struct inode'
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Ilkka_Naulap=C3=A4=C3=A4?=
 <digirigawa@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Brad Spengler <spender@grsecurity.net>
References: <20240807115143.45927-1-minipli@grsecurity.net>
 <20240807115143.45927-3-minipli@grsecurity.net>
 <20240807093545.4ec51d61@gandalf.local.home>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20240807093545.4ec51d61@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.08.24 15:35, Steven Rostedt wrote:
> On Wed,  7 Aug 2024 13:51:39 +0200
> Mathias Krause <minipli@grsecurity.net> wrote:
> 
>> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
>> index f704d8348357..a7769857962a 100644
>> --- a/fs/tracefs/internal.h
>> +++ b/fs/tracefs/internal.h
>> @@ -10,10 +10,8 @@ enum {
>>  };
>>  
>>  struct tracefs_inode {
>> -	union {
>> -		struct inode            vfs_inode;
>> -		struct rcu_head		rcu;
>> -	};
>> +	struct inode		vfs_inode;
>> +	struct rcu_head		rcu;
> 
> I rather not make this structure any bigger for the rcu element that is not
> used until freed.

Uhm, at least for my config, it won't consume more memory, as the slab
object is big enough to cover up for the additional two machine words:

root@deb11-amd64:~# slabinfo tracefs_inode_cache

Slabcache: tracefs_inode_cache  Aliases:  0 Order :  3 Objects: 144
** Reclaim accounting active

Sizes (bytes)     Slabs              Debug                Memory
------------------------------------------------------------------------
Object :    1200  Total  :       6   Sanity Checks : Off  Total:  196608
SlabObj:    1328  Full   :       4   Redzoning     : Off  Used :  172800
SlabSiz:   32768  Partial:       0   Poisoning     : Off  Loss :   23808
Loss   :     128  CpuSlab:       2   Tracking      : Off  Lalig:   18432
Align  :       8  Objects:      24   Tracing       : Off  Lpadd:    5376
[...]

While the size of 'struct tracefs_inode' is 1200 bytes for my kernel
build (LOCKDEP bloats it quite a lot), the slab object size is 1328
bytes, i.e. 128 bytes wasted per object which can, for sure, cover up
for these additional members.

> 
>>  	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
>>  	struct list_head	list;
>>  	unsigned long           flags;
> 
> Perhaps:
> 
> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> index f704d8348357..ab6d6c3d835d 100644
> --- a/fs/tracefs/internal.h
> +++ b/fs/tracefs/internal.h
> @@ -10,12 +10,12 @@ enum {
>  };
>  
>  struct tracefs_inode {
> +	struct inode            vfs_inode;
> +	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
>  	union {
> -		struct inode            vfs_inode;
> +		struct list_head	list;
>  		struct rcu_head		rcu;
>  	};
> -	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
> -	struct list_head	list;
>  	unsigned long           flags;
>  	void                    *private;
>  };

I'd rather not exchange trashing one RCU-walked list for another. Or how
will this play out for the RCU walk in tracefs_apply_options() if
there's a concurrent call to tracefs_free_inode() which will now trash
the list_head tracefs_apply_options() is walking over?

Thanks,
Mathias
