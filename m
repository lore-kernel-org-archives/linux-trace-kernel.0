Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1230C63C7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931161; cv=none; b=oil+k7dhy5ZMmFVzRdX/+LhUaYFl+7rN2Qjl134blp8RWxlvAD58lRCddF5NSMEQQUuR+nDvYKFt4Cfe3e+pgegZxWEXtnHC8wBjYXJI7jJ17uwAig9tbL/RHwpupg4OR96DQV8y+RA2xnAgSXFPnq6hy/pwXup8jL6HFDu41qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931161; c=relaxed/simple;
	bh=w8DjyYY/K+CfGUon4TY90xEz62jadfxf9SjD0FNzems=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzcKwS0apXCwrxDO20eq1bOXU8QX1Ib3EqBaonwYdLatkN/MUR/Zhbb3zVIOCYQS/0fe1aJW3aQyA1pJbd9Fcky4ADGqBrQRX0FPVGulc5YcQi8qux2PCkpJDBfnNh4oyQQMCANtK0+oNQ0ZaRCBVSKGtivvVaterqV/IFgp0Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=uySmCrT5; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="uySmCrT5"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a83a968ddso102329066b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1721931156; x=1722535956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LyY41qShAmJLjLcZhgj2IKLEjliDGOdLrIwF9D2YE9I=;
        b=uySmCrT5rjyqsuRy53d7IN4S4l1TnNVFXvADd+tWWvysf2NJRYUpMnEWShhOma1WiG
         poXgTVub7cojxrX/dq4dxMWbmfS7dHi+54eFJcnU3dgVIGNFmktN3nf/Cw+NzJvhQetI
         QmoXfCPQvVx3JaU3myBJepxfZt7fVplIs+RQphytZ7yW3Y3rpxHyOPxBBbHR+w4nt2Jx
         pxlOmcimZ6vgpXSmHe90zLJ27tpR5299OGhW3/X2gcJwUzDyx1L36SLJZZ1EVydJkdGx
         IWEi1QRezScPbyzJ3xMDQR6dAIZdVFkiN7TWFl8TERT37FeEzzcddJXve04fTjapn7Zq
         evAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931156; x=1722535956;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyY41qShAmJLjLcZhgj2IKLEjliDGOdLrIwF9D2YE9I=;
        b=WZ58Y6xuUYRRISiK8qm4+VhPS2iDvxwgOrGMs0cQ/0c3b9bCVfqH+XYgW60fKXe3Zq
         4QEaSvuD/LVoVcv//NuEy3seigJqHL5RRbKLZOv/kNPQ5bqC6AnoarTPz5rhLXDl+kmL
         UnBIJiq5v2jqPcXavskgRRyp5GzskDrOpOFEPcoBylao2ScRgBucRNi2Zs2Rfl8OQMH5
         XsZgfuBOVlwPeoRVspLAdBvVbnltvDZpxDt4/G5M07vhPN+WnxeTyv5ughvEvIu1wdln
         /4A5triIKxqMu8NcJuI7xc65nptJhjNM5zYrV0hiVMrDgucESEjQsUtJDbK3RyuLwPmY
         3QFw==
X-Forwarded-Encrypted: i=1; AJvYcCUurTea3cWfrEgb8shON2R0O+Ipb3xzRGLtC4/DWSttKhvquLCPXkQ2XLSufNUmtdz5VL42bVlCTXQMbImuRHM6a6rVKS0T/U4dPHTTD1SIfJSy
X-Gm-Message-State: AOJu0Ywh9EFO3yhTpcdfKhz+ABEHoBNpVPl1PBnknBnAJfK/sUaXEhxq
	ZItZ07/51Ovx5vT3Ij2QPQ0GHDuIbeMS/w++XLr/Zgwv/FK1dRAJdJ15pNvdfasB9FohmA+Dxot
	/
X-Google-Smtp-Source: AGHT+IEVUPlD764fuwcVRZ2jqnDEagaalzJOoY2pO/v+bNg4ObHKlqR02a0G9UvBZUFhcMq7gXOjnA==
X-Received: by 2002:a17:907:368a:b0:a77:cdaa:889f with SMTP id a640c23a62f3a-a7acb481672mr221132966b.24.1721931156086;
        Thu, 25 Jul 2024 11:12:36 -0700 (PDT)
Received: from ?IPV6:2003:f6:af0d:f500:3285:7112:e461:c95c? (p200300f6af0df50032857112e461c95c.dip0.t-ipconnect.de. [2003:f6:af0d:f500:3285:7112:e461:c95c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab580b4sm96286666b.58.2024.07.25.11.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 11:12:35 -0700 (PDT)
Message-ID: <cff51d4b-80eb-4587-b4ad-bfe7d7361b19@grsecurity.net>
Date: Thu, 25 Jul 2024 20:12:33 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tracing: user events UAF crash report
To: Steven Rostedt <rostedt@goodmis.org>, Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 =?UTF-8?Q?Ilkka_Naulap=C3=A4=C3=A4?= <digirigawa@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>
References: <20240719204701.1605950-1-minipli@grsecurity.net>
 <CAD2QZ9bDcQ46jOAc_Hxy6sG5-N5RPxw4zPuLK6R+M_GhxZR+=g@mail.gmail.com>
 <5083301c-6dc9-45c9-8106-da683ac6bfbb@grsecurity.net>
 <CAD2QZ9ZxZ+mjfju2JMw3fPATNNWkqT1p97QxXgeGo54AFzQ-Cw@mail.gmail.com>
 <CAD2QZ9bTrQ1p3zTZOXe6Gk4Xq8kjYSziAYAdbTrvRSZzAGPY9A@mail.gmail.com>
 <CAD2QZ9YAzq3jq8CyAcoG9YuMD9XWHbk3jKxAmszuSkJ3mtGoGw@mail.gmail.com>
 <20240725131021.788374d0@gandalf.local.home>
 <20240725131632.64cab267@gandalf.local.home>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20240725131632.64cab267@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.07.24 19:16, Steven Rostedt wrote:
> On Thu, 25 Jul 2024 13:10:21 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
>> index 3a2b46847c8b..e9ed2826ff46 100644
>> --- a/kernel/trace/trace_events_user.c
>> +++ b/kernel/trace/trace_events_user.c
>> @@ -321,6 +321,8 @@ static void user_event_put(struct user_event *user, bool locked)
>>  	 */
>>  	refcount_set(&user->refcnt, 1);
>>  
>> +	user->call.data = NULL;
> 
> Hmm, it may be possible to just have:
> 
> 	user->call.get_fields = NULL;
> 
> and then it will just use the call->class->fields instead and that should
> be initialized to empty.

Uhm, it's 'user' that has been free'd which makes all of the above
reading/writing already free'd memory. So no, I don't think that'll fly.

In fact, in our test environment with memory sanitation features enabled
we saw that dereferencing 'class' in trace_get_fields() trapping
(because the underlying object was free'd).

> 
> -- Steve
> 

> 
>> +
>>  	if (WARN_ON_ONCE(!schedule_work(&user->put_work))) {
>>  		/*
>>  		 * If we fail we must wait for an admin to attempt delete or
>> @@ -973,6 +975,11 @@ size_t copy_nofault(void *addr, size_t bytes, struct iov_iter *i)
>>  static struct list_head *user_event_get_fields(struct trace_event_call *call)
>>  {
>>  	struct user_event *user = (struct user_event *)call->data;

Dereferencing a potentially free'd object, so 'user' is now "random" data.

>> +	static LIST_HEAD(head);
>> +
>> +	/* If the user event is about to be deleted, return no fields */
>> +	if (!user)
>> +		return &head;
>>  
>>  	return &user->fields;
>>  }
> 

Thanks,
Mathias
