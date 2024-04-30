Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DB8194C96
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Apr 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505139; cv=none; b=RpJLwD2hVXE+VsQPVVSgWRDjQG7WDCT2pJx152hThtPOWWoTe0x7p0Nwn2loxIv2GhhG5Uo7IwFIPf7PkRqI4ezgSM0C4S/5LBP+6Wa8K3GG7i4RQ1Zbk8LjIZvoiXLT4UikSAjhhAAwWPJD60GVLC3FIqtvYk4lVWt1Lw0hdQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505139; c=relaxed/simple;
	bh=zmMxgervacDaHsVq7PofJWwKs+AoLNVMNCFfOexepAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h46FcoyobVE5KJKkC2uUTtfuugaiIbv2muVbNh+gekk/TnZ4ohyyZ3G+hjza9PEJAnO3RsEjZYsZD62UjK8qR3wqgzf/2yugUoJvdAL7osULMsxvpBn+0/FXmCblQjdjIhEJTnc5aX7ikEaQv+t6JZAfFEm50M8sZ1Zx6VlovF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HV1wMxQk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HV1wMxQk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714505136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sml+apiELoPNP3CvzMuGtYw372bsozMO9mfooXuYDlk=;
	b=HV1wMxQkoMwMsbknI59XvgRNIC6Qv9Z48ENrbbxDQmD2QFXxfDQDyi2uEF6ro19YTNE7sF
	0XuxGJN5cA4ybhSfw0RCL7M0j4Cg4Cm4E8DKvXUKZ4aJs3XoJJ6S9gPQdB7POnGOeVsnh9
	W7x2Ixt4S5MI+mC/CJ/Mj/DdiFBrIwQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-_FH2UIrLNVe-zCfLF72e3Q-1; Tue, 30 Apr 2024 15:25:35 -0400
X-MC-Unique: _FH2UIrLNVe-zCfLF72e3Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34b5bece899so4223504f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714505134; x=1715109934;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sml+apiELoPNP3CvzMuGtYw372bsozMO9mfooXuYDlk=;
        b=ajZSl1pGaqOpvfEQ5N0gAko0cxbdAam8UeQeLMTM8bTqMI0v5bQzF2wEaJejhJxogm
         rvnGRiVqAAKCWAV0UfibAag4TCzthHxs5gHhCY/qufBzU8gF9DnwHqTjc4Y2Kzyhftho
         WWH52UCiMwVmKYF/rawR0t5OqvRej3J+s6naId3TVVY5nI3U3YrPwxBe+2jYgn14ysjs
         JKKTPMuUrenmIRrNXEOoDHjRB3+TjwH6VOraRYTJKrhGY0GprHrfcI/74ggmqkSajjeH
         yEYRsdQZ4M7P8XdiI+MgpfEGPxbE1kNA1pAnTYfO8Y11wuFqi9Nr4UkmJI9gJSHu+LdR
         QTkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO6kQ1T/pxtVw9lgq7tu6mlRF5mWuS/r4RsMEOYg6FFOI0Z/0ZNijrjkddWNRylJG6lMbV5VSXgRy/pQRfQW7Bh4d3DIu22xEeUKdTz4p20DFy
X-Gm-Message-State: AOJu0YzarPnkvuMKQ/g46dhNJCDc6rHbYVbPtJDgaRtArL6YiSjobcxP
	FBp6/XYqNK/8xzUTgKAqQUi2APoyuW8xON5lxrpRjs6SWZZIPx7R6FA4vmTOz2pxTFZNAubDuoT
	gxVBlkLhN0IsuxHJOhxG4LcoMLyLnWyvUSwQsJClPV/2Axl7lPp521/MJ2/5XLApqaHpBEw==
X-Received: by 2002:adf:ec4e:0:b0:34a:3f3d:bb14 with SMTP id w14-20020adfec4e000000b0034a3f3dbb14mr372798wrn.27.1714505133925;
        Tue, 30 Apr 2024 12:25:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4uhEiExqEYYZxn/B7q0uI5d5m/WLmdfFl1SLcz2mLWdf0JRp3urAf+J6ZV+dZOqctYlmLZQ==
X-Received: by 2002:adf:ec4e:0:b0:34a:3f3d:bb14 with SMTP id w14-20020adfec4e000000b0034a3f3dbb14mr372783wrn.27.1714505133499;
        Tue, 30 Apr 2024 12:25:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3d00:d57f:b4c9:850e:d0b8? (p200300cbc7073d00d57fb4c9850ed0b8.dip0.t-ipconnect.de. [2003:cb:c707:3d00:d57f:b4c9:850e:d0b8])
        by smtp.gmail.com with ESMTPSA id bl2-20020adfe242000000b0034c71090653sm11135935wrb.57.2024.04.30.12.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 12:25:33 -0700 (PDT)
Message-ID: <8a7b9e65-b073-4132-9680-efc2b3af6af0@redhat.com>
Date: Tue, 30 Apr 2024 21:25:32 +0200
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
References: <ZiaoZlGc_8ZV3736@bender.morinfr.org>
 <22fcde31-16c4-42d0-ad99-568173ec4dd0@redhat.com>
 <ZibOQI9kwzE98n12@bender.morinfr.org>
 <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
 <ZilvOi7ceSXmwkNq@bender.morinfr.org>
 <b1cf78f8-8480-4451-bbf8-78694ebd0438@redhat.com>
 <Zip0fEliGeL0qmID@bender.morinfr.org>
 <e84a82b8-b788-499c-be79-e6dcb64ac969@redhat.com>
 <Zirw0uINbP6GxFiK@bender.morinfr.org>
 <385d3516-95bb-4ff9-9d60-ac4e46104130@redhat.com>
 <ZiwGovSHiVCF7z6y@bender.morinfr.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZiwGovSHiVCF7z6y@bender.morinfr.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.04.24 21:55, Guillaume Morin wrote:
> On 26 Apr  9:19, David Hildenbrand wrote:
>> A couple of points:
>>
>> a) Don't use page_mapcount(). Either folio_mapcount(), but likely you want
>> to check PageAnonExclusive.
>>
>> b) If you're not following the can_follow_write_pte/_pmd model, you are
>> doing something wrong :)
>>
>> c) The code was heavily changed in mm/mm-unstable. It was merged with t
>> the common code.
>>
>> Likely, in mm/mm-unstable, the existing can_follow_write_pte and
>> can_follow_write_pmd checks will already cover what you want in most cases.
>>
>> We'd need a can_follow_write_pud() to cover follow_huge_pud() and
>> (unfortunately) something to handle follow_hugepd() as well similarly.
>>
>> Copy-pasting what we do in can_follow_write_pte() and adjusting for
>> different PTE types is the right thing to do. Maybe now it's time to factor
>> out the common checks into a separate helper.
> 
> I tried to get the hugepd stuff right but this was the first I heard
> about it :-) Afaict follow_huge_pmd and friends were already DTRT

I'll have to have a closer look at some details (the hugepd writability 
check looks a bit odd), but it's mostly what I would have expected!

-- 
Cheers,

David / dhildenb

