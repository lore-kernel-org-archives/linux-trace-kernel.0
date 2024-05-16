Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C28615746A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 May 2024 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715889139; cv=none; b=Ww4i8ZtnLChibKO5SJxqCj42tVIJiKXycqZgiOV27u7RBHDuzUIQyGhygUy4cE0uTjpLwwdw8KHE1C/a8v4sXtY66YGqWsaGcHgwnodNlrPmgSi5aDy9zsA7MgNgJ/4w+hBWLn2Gll2ikpJjCX9EldA2wmUdpK2pne+ss4YFchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715889139; c=relaxed/simple;
	bh=sYjFO+L8TbyPNWQpad+KtWiBVUkXU+aTlBDoZfGaeNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HyA+1A99b28/isUpmI+QkoEzGpmus5Y5OeTB1X95AmAMFkVNSDykLLc+2PlkNkGunRbdpTMZ2vvWLVg+nQf3TSjSv9hoLTlYbFDDFuJvVaVTAStouW7M1PqJT1A9jSAj7+Swvgtc/qnvCdbA0IhLpjcOrezCRAtFRtZMURCiwS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/LDcynr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/LDcynr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715889137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yOaVcma5tcrC+WyFmJwugRefRDw+m2o6qqPO4RGSBy8=;
	b=f/LDcynrvbYJoJVeqSf07TFZyA1IbRfDwaernkxvjy2Dx63mWTHXOD3oLlyLlTQd73RxHQ
	rGoa06eDSbZcBRfHS5l8sitYdcU5JyGzLj3SRj4vtPjqLeJwo3hU5pV2LX2pJ+OFr7XXJf
	+S/N9buDJ6+EhEUqv7If4CmqVWa1Rec=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-tt49o_ZoMF6DKYlNjK17JQ-1; Thu, 16 May 2024 15:52:14 -0400
X-MC-Unique: tt49o_ZoMF6DKYlNjK17JQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36b1fda4c6dso99215615ab.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 May 2024 12:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715889134; x=1716493934;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yOaVcma5tcrC+WyFmJwugRefRDw+m2o6qqPO4RGSBy8=;
        b=RxwCN7A6gpwyZyGnIKImejk0ktY31lVHmbL81O+zE8ipj2UY0o/sK5eVfCElr2eW4R
         5IMnSwVgvUhKEgVU7/hSGn2eNXChwG9DA2IDvzDIJ5btOOokAdJqFhcT9y98xjCdPgvf
         EXELTTi/79JELHZM+WJkcEbCf72mXltsBRBimFulIOs6u6+EOj9NG9XMzJvLsTB5AZCD
         MIKaOXKvPe1CZlyWy0dx+JHnQ4w9NtKQDwcHXbRax87bqz7wcPwf+icL1ikD7TBdB00d
         PY+RlLP+6pEIPG5aDASGe3fJ3lltmKDNdt5SdkDnImG8NHUo7VM2rCOR/+NSduGSl9Fe
         6HUw==
X-Forwarded-Encrypted: i=1; AJvYcCUEjLkkHb9olZM5hN1Rzm6nG6Qyck81N1R9zK7TA//qIUeY2/Te6A8aMKs/9nygvgtOCPgTd3cw/Ig4ye8YPI9oRkhq4orl19bBeL8LNwdMqI0h
X-Gm-Message-State: AOJu0Yy4GJPlJNKkMSs4um4id1pth5lkxX3O1pOcrFtjY0RZ2HJKgihN
	8gYTN480M75pGLomG+kOh4Ao3jzUoa+ZlbTYav4f6ZvfR4hQfhSBOYPLVg1L4rDTxmLgf0EUPZ9
	CuL4IHfRUHZqRB58GGb+jwLm7zc/KOxS6LODZn4q9eRL46ECqsM9u3p2lfFOvjD4KYP/n5A==
X-Received: by 2002:a05:6e02:1d93:b0:36d:ac95:73ba with SMTP id e9e14a558f8ab-36dac9574a3mr109916795ab.7.1715889133685;
        Thu, 16 May 2024 12:52:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDQuZiKmMEglaQGsOKu9GDUDu8DRVOe2+OtE/ybfDRLeuau5Q9WytXrzQd9TIRAMdCEo8gAg==
X-Received: by 2002:a05:6e02:1d93:b0:36d:ac95:73ba with SMTP id e9e14a558f8ab-36dac9574a3mr109916615ab.7.1715889133303;
        Thu, 16 May 2024 12:52:13 -0700 (PDT)
Received: from [10.21.161.194] ([65.132.165.41])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9d8c018sm39399865ab.35.2024.05.16.12.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 12:52:12 -0700 (PDT)
Message-ID: <d23deb4c-c1dc-4ba8-a1dc-27b7c49085f7@redhat.com>
Date: Thu, 16 May 2024 21:52:12 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
To: Guillaume Morin <guillaume@morinfr.org>
Cc: oleg@redhat.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, muchun.song@linux.dev
References: <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
 <ZilvOi7ceSXmwkNq@bender.morinfr.org>
 <b1cf78f8-8480-4451-bbf8-78694ebd0438@redhat.com>
 <Zip0fEliGeL0qmID@bender.morinfr.org>
 <e84a82b8-b788-499c-be79-e6dcb64ac969@redhat.com>
 <Zirw0uINbP6GxFiK@bender.morinfr.org>
 <385d3516-95bb-4ff9-9d60-ac4e46104130@redhat.com>
 <ZiwGovSHiVCF7z6y@bender.morinfr.org>
 <8a7b9e65-b073-4132-9680-efc2b3af6af0@redhat.com>
 <ZjMPtrsrUi8-QJ0G@bender.morinfr.org> <ZkZGGkxXNaF5JPQ5@bender.morinfr.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZkZGGkxXNaF5JPQ5@bender.morinfr.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.05.24 19:44, Guillaume Morin wrote:
> On 02 May  5:59, Guillaume Morin wrote:
>>
>> On 30 Apr 21:25, David Hildenbrand wrote:
>>>> I tried to get the hugepd stuff right but this was the first I heard
>>>> about it :-) Afaict follow_huge_pmd and friends were already DTRT
>>>
>>> I'll have to have a closer look at some details (the hugepd writability
>>> check looks a bit odd), but it's mostly what I would have expected!
>>
>> Ok in the meantime, here is the uprobe change on your current
>> uprobes_cow trying to address the comments you made in your previous
>> message. Some of them were not 100% clear to me, so it's a best effort
>> patch :-) Again lightly tested
> 
> David, have you had a chance to take a look at both patches?

Not in detail, last weeks were busy (currently traveling back home from 
LSF/MM). I'll try to find time within the next two weeks to polish my 
changes and send them out. It would be great if you could send your 
stuff based on top of that then.

(the merge window just opened on Saturday, so we have plenty of time to 
make it to the next one :) )

-- 
Cheers,

David / dhildenb

