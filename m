Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D90364BC
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723062254; cv=none; b=MQuZ81DZtOEFKEWT97MNixl0qblm4FknyehJ0PTV9Vus8d3Hpeof6bwNmVfKSNiDGyq5zIpQCwUZS2YF+dX5Q/2ShjhceC7WnsknrM6XuNztGBNdBFWoN7wxFKoihWZvxXpyvwOx9xS4zzl8Zxv/8PGNHOrskWJfI4XwML8CvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723062254; c=relaxed/simple;
	bh=TYgIdAzq3lDBI2YyReVQ2cAg1vqcDOqFH3Ci+NG71Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPMedXVAwLC6m8+0LG387CCwgnlEeVRqI8CD2nRj6RQf4g8IxvPUfqyi8Os3j+P3b1SvLXlVJNzTab2GLtUe/hYMf1cFbBpZpEf86iKUCxExajkErHPsJxGmdWKHxmyAZSFPkOJE0OeXzH7ITwhIIAeW6JzZAndhdyRZiBOYE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=XuGTXLIR; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="XuGTXLIR"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efdf02d13so408945e87.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Aug 2024 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1723062251; x=1723667051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iNk4Cu9oSx8itq3xzUHxSImZEvn1IJh/znmJ08m2Xck=;
        b=XuGTXLIRBwX8lairgqmwAeBkQakbNmE8OyCHyN5NeWpIBPJePqIk3sXgLB4m6dWULO
         8hshUXiRjZZa4uHWdBn29fpvOG4ZiMrg1CffwgYN6+fmQ42XPR20KG3aqjYIflpIAMkE
         +Dv/p0Ro5x2lIi1k9iM5c8o39wBPPULiCM1OrPqUczTBgf++tFq+BD9vKQHyl+ERoa0w
         GzIY0bRVO4LjWNj3/mHs0cTgtZPsdXhEruRkIjDapvPLfLXm82hH16YIY2ev+rT2AELH
         xiiNoEavsICqDkD62+hNgI0TqKRcTcqI/y0G7HLVa6AgSw2bBMjFjzRy8aw+9SFNHOHY
         w1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723062251; x=1723667051;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNk4Cu9oSx8itq3xzUHxSImZEvn1IJh/znmJ08m2Xck=;
        b=SUajYh6OAU/k0AuoNQe8Ceg35s48eEcosdtmBLwFr8YLPF2ZEyWe4oJePg/wl+A7rf
         3RUt7kQkeAtebDhIG8I7Hhk42Q6InKG2j13vIM4VIA5afLTAtZNXYrZ5IxX5wWMAdGZi
         8zbBE83e4BXddT+R8BVRVYL3PwF8naxAAuNBCm/xFoxrhRTFi7MXm+VSSO/6qYHW8yVZ
         14Lm4iQBvW5E2eU1j/TMQ43PbQUC9ttSfFWTEYPf8x5vhGgmMpX6p1QjZmBiqhqhyNwN
         DPS2cSH1gicMv5Q0Z/G6vJsid3z12TSPV2bpXp0azlazHOpdXAbN9jYrDCk5rAZiSIH5
         RqKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE/JqmmzsiPhu5KoX2rdCVBbVez8xIagZkuwD/RJGFpLFbuqS3/O9WlsDEa48BVCAqUp28YzFuB1gFmQNQ+hHJp9YpusXzrj9NbolSpObWnwm6
X-Gm-Message-State: AOJu0YySzv/yYtG0oMBd7eXgFS+y2HDDDbDOxk349/CzB3pvD5BrIYU5
	dtguJAYimPS9rql7+49OI3x7+nXSTnXJCJllWJQT3pfRYQkqofBX5qhSu+bF70E=
X-Google-Smtp-Source: AGHT+IECYnNuieGTAlEZH7ObyQIZpLVSySYzDhc1oG6OjCO52lqln+B+MkyK/wrWRz68pgqQqwJwRQ==
X-Received: by 2002:a05:6512:ad4:b0:52c:8342:6699 with SMTP id 2adb3069b0e04-530bb3bc058mr17852673e87.55.1723062251039;
        Wed, 07 Aug 2024 13:24:11 -0700 (PDT)
Received: from ?IPV6:2003:f6:af11:9b00:1236:f9a6:4d0d:776? (p200300f6af119b001236f9a64d0d0776.dip0.t-ipconnect.de. [2003:f6:af11:9b00:1236:f9a6:4d0d:776])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8067efcf0fsm179933166b.145.2024.08.07.13.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 13:24:10 -0700 (PDT)
Message-ID: <e10e465e-98d9-430f-bb71-cf4b8e046a71@grsecurity.net>
Date: Wed, 7 Aug 2024 22:24:09 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tracefs: Don't overlay 'struct inode'
To: Al Viro <viro@zeniv.linux.org.uk>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Ilkka_Naulap=C3=A4=C3=A4?=
 <digirigawa@gmail.com>, Brad Spengler <spender@grsecurity.net>
References: <20240807115143.45927-1-minipli@grsecurity.net>
 <20240807115143.45927-3-minipli@grsecurity.net>
 <20240807093545.4ec51d61@gandalf.local.home> <20240807134453.GZ5334@ZenIV>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20240807134453.GZ5334@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.08.24 15:44, Al Viro wrote:
> On Wed, Aug 07, 2024 at 09:35:45AM -0400, Steven Rostedt wrote:
> 
>> Perhaps:
>>
>> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
>> index f704d8348357..ab6d6c3d835d 100644
>> --- a/fs/tracefs/internal.h
>> +++ b/fs/tracefs/internal.h
>> @@ -10,12 +10,12 @@ enum {
>>  };
>>  
>>  struct tracefs_inode {
>> +	struct inode            vfs_inode;
>> +	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
>>  	union {
>> -		struct inode            vfs_inode;
>> +		struct list_head	list;
>>  		struct rcu_head		rcu;
>>  	};
>> -	/* The below gets initialized with memset_after(ti, 0, vfs_inode) */
>> -	struct list_head	list;
>>  	unsigned long           flags;
>>  	void                    *private;
>>  };
> 
> 	Your current variant gives you an RCU-delayed call of
> tracefs_free_inode(), which schedules an RCU-delayed call of
> tracefs_free_inode_rcu().
> 
> 	Do you really need that double RCU delay to start with?
> Because if you do not, just do that list_del_rcu() in ->destroy_inode()
> (which is called without an RCU delay) and have kmem_cache_free()
> in ->free_inode() (which is called *with* RCU delay started after
> the call of ->destroy_inode()).

Jepp, sounds much better indeed and doesn't require 'struct
tracefs_inode' to have its own 'struct rcu_head' member.

Thanks,
Mathias
