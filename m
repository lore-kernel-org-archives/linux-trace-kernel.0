Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E32514386A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jul 2024 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721768095; cv=none; b=KeioT3AiIqat92jNmg+h9AtSXqimDhgM9bnC1NNnBVZunGgzOOKKFX+taaE9pkwmc7ulelG2HbI4VTleVSIV5fwd6MKcDmw7l0sRBAK2T3RDrgkkCKWWn3/NXHsweqh0d7LbO9NqGtbaREguWDdkZoTiV6tQY5mGbe8lgnjR+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721768095; c=relaxed/simple;
	bh=c3dJCxNCMuvmNluI2NbiwjAxlTld8R1ci3G2AZApap8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNXjb9ZjV60912Mi9qiJXRrvDmUpNEyCC68FTGizUb4BEaUqyewjK6QJcgVi4kX3g+9+0HXMOHFU1qQ/GCv4j5Ro/7qvuAZ9QDBcjF7Mq1lri3KCVN1RBMygMK5bbvbAw78MJDgB2N1/Ox7SJCFh3ohChe4tcYO/8QcKwmzV+lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=mxLocVfX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="mxLocVfX"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a20de39cfbso5424663a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jul 2024 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1721768092; x=1722372892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0C5KvvCKRFRHGyXQ0+xgCLiKx4jBjXnWC42JoYTxDRM=;
        b=mxLocVfXwaJxVyhse8Z3hD7E4Bu/Fndwki4cvuTqLjJUAT28+3TwfFxwZTWOGhVtD7
         jWvIDh1LIJx7ZwPnp/TGbJJ3ouQ5tddPR/eN/OYSRegkDRbKVFH2RJvrFldxjPMxqSSR
         Bn0vfaDKUxcLFfD2HMemGsmo3ssQQ8LsPT4vqjOCOplNaMV9jdTTj9B0U8fnedi78U3i
         K21ntKLrWUlSV2Ja6I5+D3Kbqn0YWoHIZqO3ox/lYzsGfNVkpoygVqI0iO5QTJMNPwjU
         kFydnuFrHBJfcivkUjgrJOlKBokkAfvMsQm0u+w+X6EqGLjtQcG2w116BXjXicBmzT6p
         sv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721768092; x=1722372892;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0C5KvvCKRFRHGyXQ0+xgCLiKx4jBjXnWC42JoYTxDRM=;
        b=IfZKgXfmRxx3rOHnHHZ1N1S11QMc7CN1Ye4RbvpYF6YLNXr3RkP2oZ63IIb/wVW3il
         0mFQVBtdf1BpovCjZc3XDCnrTCXGZEN5QeyeMrjwDc6Mstv6FYdNUFVmgOofx3OJvdoE
         5LsTHbvTaMPI10iN4aM1gLF8pfHuaASSejOWO3hQVj6zin9HLyaIwPt/1ZOZ7hgIsADp
         YO8/vf3egJuNlBpK2WbzvtxMPMgwsVfsJILwHMKQ9FKBKRLZx0dsKMFNj5fcZDd564lX
         lE+hgngKz59XGD+72vHJtxtxUM3yFmc4c+ewuV3KtoWZld3hYPPTvU2i54PcqQYGwgyS
         gElA==
X-Forwarded-Encrypted: i=1; AJvYcCWDOkgfZf3Iops+ethzJAGy5L9/LmGesLZrewIpPJhdsIM2zJ1M6k6d3GkDyQnl6Z8ze5ut0GbyOkPuF6B27A9aXFDxiq3PpTdeLG86YpuQu2UV
X-Gm-Message-State: AOJu0Yz7DryHK2UNP+aNmQG5x9wTV9rb7P2uaL7b4K5P6TdyGRQioVQm
	PAwYqHBvecYksiKX2DmFe3kOTYKGPTOc34y/pG325uOoxDcwvwcnpCrK3OzQe6U=
X-Google-Smtp-Source: AGHT+IHynNSHyiGdoWpM/KpuEMOPO9NWXApR3ESELw9oE4siucbrVU7Vr6SSMFDZbdHuyjkpVjXyEg==
X-Received: by 2002:a17:906:d550:b0:a77:f65d:39ff with SMTP id a640c23a62f3a-a7a8847a636mr320365966b.53.1721768092203;
        Tue, 23 Jul 2024 13:54:52 -0700 (PDT)
Received: from ?IPV6:2003:f6:af04:ba00:683d:7717:ab42:e94? (p200300f6af04ba00683d7717ab420e94.dip0.t-ipconnect.de. [2003:f6:af04:ba00:683d:7717:ab42:e94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7aa8d8d0cesm38200066b.138.2024.07.23.13.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 13:54:51 -0700 (PDT)
Message-ID: <10dd9e0f-fb2d-4667-8fba-171040690055@grsecurity.net>
Date: Tue, 23 Jul 2024 22:54:49 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tracing: user events UAF crash report
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Ajay Kaher <ajay.kaher@broadcom.com>, =?UTF-8?Q?Ilkka_Naulap=C3=A4=C3=A4?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20240719204701.1605950-1-minipli@grsecurity.net>
 <20240723104348.645bf027@gandalf.local.home>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20240723104348.645bf027@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.07.24 16:43, Steven Rostedt wrote:
> On Fri, 19 Jul 2024 22:47:01 +0200
> Mathias Krause <minipli@grsecurity.net> wrote:
> 
>> Beside the obvious bug, I noticed the following (not fixing the issue,
>> tho):
>>
>> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
>> index 5d88c184f0fc..687ad0a26458 100644
>> --- a/fs/tracefs/event_inode.c
>> +++ b/fs/tracefs/event_inode.c
>> @@ -112,7 +112,7 @@ static void release_ei(struct kref *ref)
>>  			entry->release(entry->name, ei->data);
>>  	}
>>  
>> -	call_rcu(&ei->rcu, free_ei_rcu);
>> +	call_srcu(&eventfs_srcu, &ei->rcu, free_ei_rcu);
>>  }
> 
> This should be fixed too. Care to send a patch for this as well?

Sure, will do.

> 
> It use to need RCU but then everything was switched over to SRCU. This was
> just leftover.

SRCU usage came up with commit 63940449555e ("eventfs: Implement eventfs
lookup, read, open functions") and following, was further extended just
to get almost completely nuked by [1] earlier this year.

[1]
https://lore.kernel.org/linux-trace-kernel/20240131184918.945345370@goodmis.org/

> 
>>  
>>  static inline void put_ei(struct eventfs_inode *ei)
>> @@ -735,7 +735,9 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
>>  
>>  	/* Was the parent freed? */
>>  	if (list_empty(&ei->list)) {
>> +		mutex_lock(&eventfs_mutex);
>>  		cleanup_ei(ei);
>> +		mutex_unlock(&eventfs_mutex);
> 
> Why do you think this is needed? The ei is not on the list and has not been
> made visible. It was just allocated but the parent it was going to be
> attached to is about to be freed.

I have no strong understanding of the code, just reading into what the
context told me the rules should be, which would be on one hand the
following comment...:

/*
 * The eventfs_inode (ei) itself is protected by SRCU. It is released from
 * its parent's list and will have is_freed set (under eventfs_mutex).
 * After the SRCU grace period is over and the last dput() is called
 * the ei is freed.
 */

...and on the other the common pattern, mostly complying to the rule of
first taking the eventfs_mutex, then checking 'is_freed' for a given ei
-- supposedly implying, it can only be set under that very same mutex.

As cleanup_ei() is just a glorified free_ei() which sets ei->is_freed to
1, I was implying the lack of taking eventfs_mutex is a bug. But looking
further for the precondition, getting 'ei' unchained again after it was
put to the parent's children list, I can find eventfs_remove_rec() which
is only ever called under eventfs_mutex and does:

    list_del(&ei->list);
    free_ei(ei);

So you're right and I wasn't paying close enough attention and got
mislead by cleanup_ei() also setting ei->is_freed. But as it should
already be 1 at that point, no bug here.

Thanks,
Mathias
