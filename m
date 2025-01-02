Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871D41420A8
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Jan 2025 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735852790; cv=none; b=fRkjiwLAqL/gTVlEXyOTV5sjCPHbWz38684PEn67Sg4EPkZfGFBL2X3aAPKKtTzbXmgWi9bppm7SraBDskPG/syarrhAaas6h84BtoU44fOwuE+6IzQ9eRsx3nQcSfuhfesrMwn1nN4H0DNdNxiePbLu+KEZtAZZpaAqFFthLTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735852790; c=relaxed/simple;
	bh=DZpepdt0D7BoD/2lYM3PLrGAdcHfwsBLNF7IqjtIIyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWdvirfcDc/sJTYl1Ri8xsRXpDYsL5aBa3YoJCe+cWldSj17AaRnoXVWgXtdweA8yFWLjEBu0wJYr357OYyhavADfBTy4WzMx9JEtNrfgzMEHsHBawao8TsmkLjUniCet/8S2+VKgOhv8AI4ocsghBxdsyPuRKenkwiEglqhlVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EqaxXsTq; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EqaxXsTq"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844e06e5d11so396708239f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Jan 2025 13:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1735852786; x=1736457586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqSBiemQ2Bz4aDXI0PsW2FV8+vQOaGGeqetFAobMaIk=;
        b=EqaxXsTqULSrS7J8oANbp/GqTm4s/BidJDrHftYoipDxTVZX7ksfDnM3W/oula570Q
         wmB5QYmHH7UWxz8Q0uyxxA/xUZRfK4R1gLipbek8XddV2vLxkwEzDj6yv/IdQbksqMjQ
         bYWQcxfMv95GWUgSmWNKy4A/42/uUcW4nXv7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735852786; x=1736457586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqSBiemQ2Bz4aDXI0PsW2FV8+vQOaGGeqetFAobMaIk=;
        b=jdc9uyzjn96uM910lsE3VPUoyyyBemIrp5IR8vhAP78TTehHyiheTgptBfdBisWTAq
         F8bdq3CdhZ93qXNEnHlylOEZCZAX+mN9ONd01W29iOMu/P6bFBq1ATRLcmXHJ6Ml+3lb
         36D00uwt64oSVEqB91mi+uXa8+aW4eTCDdfKYgvEu0VfrYacljUXIeqPJJ9wpZpnpgyq
         X2XEoHNtflkHjQ5zZbUTiFSAxY9QLCoqDNg6z4yjQHXOgDmiqQajrnf1sbjcoV3pdKnZ
         9r++lBnI8pD7JcRZ8CpGKmBxsuOsu0Ys6W0hwE75HMzYVWgmKmAkTDZyqXvN2imrZ5NR
         mt2w==
X-Forwarded-Encrypted: i=1; AJvYcCVJ9hFsaydsUEYdCOL+LgCguW93fKm0Yl/UWIqYm+OQDy60RBj4lc4wvFWHOfzDafizp1N6bfsjms74+4MpPFk6ChE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztFphxrLGBB0xN/7rVfpaIdV5cOUnHg3LMfFiNfHN1KHx7cs+8
	paySMOnqNS/ixSfcS5e7H4ejAUp2u/PJ0SI7uZN8vx3/HxHNEtvy6dVEyluzsiw=
X-Gm-Gg: ASbGnctNKhCohX7yWccXVaEeSauo68u8KGNxbLtnLfiVRFvr5eXp1Sy0liCWaBCe41E
	KY/cbjDvUumkcrThrIFfwkpScmcKaXXkz8VZOptlqvODwiSTiBhQrylEkEzMhl4VHTtxQ3KEswa
	Ugh/DzC3QonMPYe2Z7kY1JdKcFpEbqhO1KJsahcoD5+ecO6+hR+ynJlPhi9VMvXVjIosjqKwirW
	z6dPE66d1Jw05/dx1StHnFsXvpUoje6M+VKFGF6PmBUSBhHP+bpqS0ILYj6rKe7NO8t
X-Google-Smtp-Source: AGHT+IEK/JzaNsJZOqhdk+7MFsiTwmma6S0mMV1zPf9tGg8pwTfMuDUpDINXDedjU/9t6jSnmAXLDg==
X-Received: by 2002:a05:6602:60c3:b0:83a:639b:bc44 with SMTP id ca18e2360f4ac-8499e4ee011mr4149299339f.3.1735852786669;
        Thu, 02 Jan 2025 13:19:46 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8498d4253c0sm686345539f.0.2025.01.02.13.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 13:19:46 -0800 (PST)
Message-ID: <b5ae70c4-055b-442c-be91-3430367f842b@linuxfoundation.org>
Date: Thu, 2 Jan 2025 14:19:45 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ring-buffer: Add test for out-of-bound pgoff
 mapping
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@android.com, aha310510@gmail.com, eadavis@qq.com,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241218170318.2814991-1-vdonnefort@google.com>
 <20241223220504.4ae4adf2@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241223220504.4ae4adf2@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/23/24 20:05, Steven Rostedt wrote:
> 
> Hi Shuah,
> 
> Care to take this through your tree?
> 
> On Wed, 18 Dec 2024 17:03:18 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
>> Extend the ring-buffer mapping test coverage by checking an out-of-bound
>> pgoff which has proven to be problematic in the past.
>>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
>>
>> diff --git a/tools/testing/selftests/ring-buffer/map_test.c b/tools/testing/selftests/ring-buffer/map_test.c
>> index d10a847130fb..a58f520f2f41 100644
>> --- a/tools/testing/selftests/ring-buffer/map_test.c
>> +++ b/tools/testing/selftests/ring-buffer/map_test.c
>> @@ -233,12 +233,18 @@ TEST_F(map, data_mmap)
>>   	ASSERT_NE(data, MAP_FAILED);
>>   	munmap(data, data_len);
>>   
>> -	/* Overflow the available subbufs by 1 */
>> +	/* Offset within ring-buffer bounds, mapping size overflow */
>>   	meta_len += desc->meta->subbuf_size * 2;
>>   	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
>>   		    desc->cpu_fd, meta_len);
>>   	ASSERT_EQ(data, MAP_FAILED);
>>   
>> +	/* Offset outside ring-buffer bounds */
>> +	data_len = desc->meta->subbuf_size * desc->meta->nr_subbufs;
>> +	data = mmap(NULL, data_len, PROT_READ, MAP_SHARED,
>> +		    desc->cpu_fd, data_len + (desc->meta->subbuf_size * 2));
>> +	ASSERT_EQ(data, MAP_FAILED);
>> +
>>   	/* Verify meta-page padding */
>>   	if (desc->meta->meta_page_size > getpagesize()) {
>>   		data_len = desc->meta->meta_page_size;
>>
>> base-commit: 61baee2dc5341c936e7fa7b1ca33c5607868de69
> 
> You can ignore the above "base-commit" (I don't have it), as it applies
> fine to v6.13-rc4.
> 

Applied to linux_kselftest next for Linux 6.14-rc1.

thanks,
-- Shuah

