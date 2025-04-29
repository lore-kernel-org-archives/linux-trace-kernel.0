Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C3F24EABF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Apr 2025 17:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946921; cv=none; b=KEnpP3qKf/zO8sWVjCwHsMrBp3R9CEal0wKxnVtQatHUt4gbnfxFEdRXisGiVMVqOXSlNUgLh3wFA08azYmQtA85PWnlCEF9SUl7c62boJd5mVK9ghVJ+dJgxidRFlsHxBP0E9GknSbfliXgcRQsTPPFkZ5VM8zE90KQz3Wiyx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946921; c=relaxed/simple;
	bh=qgZAVzUxgIObEJQqyKmsbR8bW/1guX32nsbPniZMMfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LttUNE8ydrl9oHNGI6QOaoTOGuj58r/BnGFpXw/obk3fZYZh+OY94WMTaM6Ug+OsG4MmLuzIgbcHPt8W1K9t1Qufnsp9wbkmQgfk5BmEhbkv3nnh7N/IEUHJcwk5R0xgRuQA0i9CFPaKKlMkb6FElGIRdmDTj9+9hje1zkJhj4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IM0IddDl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IM0IddDl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745946919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lhmk4W/QX711OXoAAigeaTgerLt/k4PPR/4QLIaiOYE=;
	b=IM0IddDlcnQh8CN1kDVtyE4LSDd3TmYoanQpRSpRn3ozdueC2CoNK7HkreC/KTa2T6PYdf
	Tml0tCuF3zZJDYix+OrfAV02QFeIb/zIaIMI3/XcKuO3atoaxKbx5oancQXW1ijR0g8X+u
	Cx4oIXk7KDbhwEAUU/CCoQ+Fx20R1D4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-wxLXsdzgNSeM1E67J_MWZQ-1; Tue, 29 Apr 2025 13:15:17 -0400
X-MC-Unique: wxLXsdzgNSeM1E67J_MWZQ-1
X-Mimecast-MFC-AGG-ID: wxLXsdzgNSeM1E67J_MWZQ_1745946916
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39ee54d5a00so2115626f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Apr 2025 10:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745946916; x=1746551716;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lhmk4W/QX711OXoAAigeaTgerLt/k4PPR/4QLIaiOYE=;
        b=CrkBcZW/gxcChkxo5xCCFJCFQLYXIixfQtXuDxUHf+aYaKawvFN3AVo9IOp4Tki3Dn
         VJ8byOBiXS6qbrtSnFmsOc5p6sSO4CV70qaZVPAtmZ/m2sPrvO4brKYMgKXUTyeh9UyR
         JyOAUHA8HOc25vNhNfvibxQSxtWNB8B8SCd7vHZxLiGXq0w/U2503hp1zXvmcbNXOscJ
         mCG4q/tjqPgpLd5hMHdr6CTHTA94uEi/4j5gNi8ehpWz5pzJ7XaAnUxgZSylU8rjXEn9
         gYeCobbvPDqd37zMgO60dfy95LJgTP9ICUdOZpjeTo7lkSw6YjxlRiwqq7w/1eqx/8sh
         WKFA==
X-Forwarded-Encrypted: i=1; AJvYcCXtM+AlcMjMGb3BXrUt5PwGh2U89RncZcGRbYkoqkrotIf+C0ZWW1gK/xS23hxNu1ONKOz6RCPzqBSfBWzcPwne9kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuDWMSoBkEkVgAL97LjhG3xtHUwjM6Q6wKSDUmcPTqCrxKe6Ri
	f5VvCvMHqlybOg809bHqKreXOPVRPDosxG297TvWQCj/S5Vgz94InaKRs6CnBmfQk6S6ZGB9Z05
	+DXP0HGxhdcsY9iYJ5qr2KWvMI5ohnV+cxPYcZ+4ZnEFvpfpib/8rW9n5ORQu8p9DhcY1mw==
X-Gm-Gg: ASbGncu0XSllulg+lMMkDeCA/R/6jQ23sbVfYBuMe2RDYhNvZ+YJ4zSpNXwKkIiO9E7
	V8Qdye1xxo0tjKrMZNUeDGgNQntcdrUz6W0KTkZQ7GQ7zVs+r8ZP48LIJN7DumlzfcT/nHr2z5C
	Modl15VG8KsdKer5yEYXrl2jv4Ga9WH0a3wM8O7tmq0sszTXcNv6qrscJt/2oRCrMVSei4sWMye
	GXreyL0JZOSY9vBH0FjhCPP52Ksef3CunukmkdGZhi8xrf0m4ov4j7i/uQRWgENxcROSEDuQoW0
	lNER9i5qKkTDJpgtKWXaIckKDQOdnErGeSuTQ2VNM358SGSARDUfQKs29Ahpp9qOZyUEOdcQ/IS
	Hc2TujFHagwJ+Ux5bkVhq56yHHIm01Tyw/n/bwUU=
X-Received: by 2002:a5d:5f88:0:b0:3a0:7a7c:22a2 with SMTP id ffacd0b85a97d-3a08f7a3297mr173521f8f.39.1745946916523;
        Tue, 29 Apr 2025 10:15:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgH6DoLAf7tvJaD7FYGNldjP+rBYMQsOF8ISQ6TNdcg9FQKvME+xRtNnlHg/2ZPuEZ4EGFsg==
X-Received: by 2002:a5d:5f88:0:b0:3a0:7a7c:22a2 with SMTP id ffacd0b85a97d-3a08f7a3297mr173495f8f.39.1745946916174;
        Tue, 29 Apr 2025 10:15:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73b:fa00:8909:2d07:8909:6a5a? (p200300cbc73bfa0089092d0789096a5a.dip0.t-ipconnect.de. [2003:cb:c73b:fa00:8909:2d07:8909:6a5a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073cbec5csm14072342f8f.43.2025.04.29.10.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 10:15:15 -0700 (PDT)
Message-ID: <90677959-9ab2-438b-96b3-4024ea1a5c65@redhat.com>
Date: Tue, 29 Apr 2025 19:15:13 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] Documentation: mm: update the admin guide for
 mTHP collapse
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, ryan.roberts@arm.com, willy@infradead.org,
 peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com
References: <20250428181218.85925-1-npache@redhat.com>
 <20250428181218.85925-13-npache@redhat.com>
 <6fd003dc-2a2d-ca15-e7b6-9af988fdbc3f@gentwo.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6fd003dc-2a2d-ca15-e7b6-9af988fdbc3f@gentwo.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zyv7letj9eTuqoHO1-TjlP_6k6wHmsG3_VsYTKbNymg_1745946916
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.04.25 18:38, Christoph Lameter (Ampere) wrote:
> On Mon, 28 Apr 2025, Nico Pache wrote:
> 
>>   THP can be enabled system wide or restricted to certain tasks or even
>>   memory ranges inside task's address space. Unless THP is completely
>>   disabled, there is ``khugepaged`` daemon that scans memory and
>> -collapses sequences of basic pages into PMD-sized huge pages.
>> +collapses sequences of basic pages into huge pages.
> 
> huge pages usually have a fixed size like 2M and are tied to the page
> table levels.
> 
> Would it not be advisable to use a different term here like "large folio"
> or "mTHP sized folio" or something like that?

"Traditional THPs or mTHPs (both, currently represented as "large 
folios" in the kernel).

-- 
Cheers,

David / dhildenb

