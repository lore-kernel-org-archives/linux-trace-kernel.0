Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020282AD37
	for <linux-trace-kernel@vger.kernel.org>; Sun, 21 Dec 2025 01:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766279798; cv=none; b=CrhgbM8JxEdv4SBTVBZZMrN21hgtDumHIUQoAm6QxQMmYejQeRUjiyZg//cx3Yfsue69mDtulU0rO6cW5siCnoi+ifrltz/upcstRej8+G3igLy0eKBnsavWmSJIbvVdse/wigzLTqEn9/gUGUibUVuc8JmlV83bd+5DoL8/WAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766279798; c=relaxed/simple;
	bh=83FMF98PAN/CGpEcVdX9reInOyi1Ps/02X4ql5Xb9ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kw99ni0t1sNUPaZDlhnz/WPZtFu9NdI2e0hmBCGosAqkXkRMgu0ucw2zxNDzFhssc21vdgpYFmEPPLIYJEi9Dj7pI+oaK5Ia65QFwZu5b8P6D4WFAE8JJnM70KIRDYh0L/fmgbJhNpcxq4HaGBhjh/hUd78Qf6CMvl/E65gx65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFFEZYiZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFFEZYiZ"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7a02592efaso424600066b.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 20 Dec 2025 17:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766279795; x=1766884595; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+2sMUT8kDC1Ir29lVu8GWpeD0f+cthDMl3JzZStKAs=;
        b=WFFEZYiZmIr6U5Y9nIBt5VYLtu4bhzxLckPjMGJrIiRbpjslhnfCIvMW8SsFjDwpux
         oueaATbPjId3ISaWCGNoRZi287B2GYZyDB1bEv82urpU0PLXj+aeUNfbX4WahwxB7wUf
         pbQSQCRIldtq0Rd7wpsVU6nPo1GD3CUrAdIrGHsvgF89V3+axzm4yOaWTX7UNPTRXx8N
         j86SIe0iqxbRyAmUN5y1mwKE3vgTJuvVPyZU8gx7KlYM2AmFquqGSYb/7mL64zaHyDpf
         Kzz3uXQc4DQBaaai89DTu1ML/qRrsK7ib/PMcJNGeTdxkdLHor8ZBUWiEevEstnL8sUM
         zEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766279795; x=1766884595;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+2sMUT8kDC1Ir29lVu8GWpeD0f+cthDMl3JzZStKAs=;
        b=RaTdCCRfywgsV0HAAFGJ5+tCIaKtVB4vzrXmGnDbOJXAWd7UAxH8fr1f3PFvo/EFME
         MNN47hbmncN4h6xPddJEIDIvMDTbTwos94DimiEfNdLkLMapc7w0FB2d8sI2vV5rs+5q
         j1p9xipJFij8qZjh/DwI6qo+jcIl+SqTxCsUja2MPPdeN7rPCP+vzbOdWawwsYS+N0M+
         S4WbHklm/5n2wZIOVeDHZKKussbfhMWteMTF/hK5ixOF4B4P7GDHE+/ARH4yKQEIOmyC
         Blf2ZVjhf4kM9iT1U2wsotMrtUFel6awFwKjJVDMUYfakIJW3x8LHM3v2iwHYYwLgp1g
         SYzA==
X-Forwarded-Encrypted: i=1; AJvYcCUNtqYBBETVrchsc+XLUpFuMHjAr204XoT9RQLNmJrFkebPH9CLnv235m1xYO/ItKqTS2Nx/JgEpIBkaugHEm5xfK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR0I7UNEmhQWBcSV+wPSAGlmmAjmyHguQTLCeYDGeeuFpHMN7l
	xaWQPLnqE15j8GGOds7npRrw8GFvGDhST+y0Y7hN/WiB75k3PrZ0yiR7
X-Gm-Gg: AY/fxX7wefsz24oaWqjA0/zHKNYkus2MYOMD264ZiHKFDyH6p8nErE2vVPfZOXinwHy
	g0hIUow+74Hr7XW9w7TcP2+ZvLL9N9sTngQVTKJGD7QfT4dDQx2Y47vIPZeF2nbwiyFcyJgZ1UJ
	86mJd0GHZ3Y1DuEh7ZSSsABOQ2jdSc/3biIhdmU5YbIjyheWGsprImh0HNx72WmKLBh9PE4/xDj
	TcFF+dntIkdSYwSdAZ7xcRWqSLGpTQLx7t7Def7O05bBkh6fgIeY1RYcdxcI073GmeBHL9WKkOl
	e5rw8BAcgl89c4yqzUOFh5rllG3hpQhHCstC8gpw/XsAtfFdkyfN0jYiV+hIiWke/elUrdN5wFg
	YvCgsnBv0oewByDbIWTy6rBFc5HHD1nMcRv/WOIEd0DozKYbBhDyuHhcu3ycTKGB8N++pbYnJE4
	YJUH8eCekr3OA0wfxjijkT
X-Google-Smtp-Source: AGHT+IFD2cY/Wxoo2IxpcvIXcNiq4H/08jKq0RxJx57XdtKMD/Rf+oialktXa+Hm/L916QKJkZCtbQ==
X-Received: by 2002:a17:907:e109:b0:b80:4030:1eca with SMTP id a640c23a62f3a-b804030298fmr439312266b.2.1766279794994;
        Sat, 20 Dec 2025 17:16:34 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11e5sm627341866b.39.2025.12.20.17.16.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Dec 2025 17:16:34 -0800 (PST)
Date: Sun, 21 Dec 2025 01:16:34 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Garg, Shivank" <shivankg@amd.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/khugepaged: remove unnecessary goto 'skip' label
Message-ID: <20251221011634.uolx6ajnnpaevnvb@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251216111139.95438-2-shivankg@amd.com>
 <20251216111139.95438-4-shivankg@amd.com>
 <20251217024818.ngoime34bxeatqij@master>
 <c7c1d62c-7d27-4b73-8173-0493adc66cfc@amd.com>
 <20251220003851.dzsafcxtlbgzwsm6@master>
 <63453d94-6410-43fd-8676-dbb04e423b10@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63453d94-6410-43fd-8676-dbb04e423b10@amd.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sun, Dec 21, 2025 at 12:02:11AM +0530, Garg, Shivank wrote:
>
>
>On 12/20/2025 6:08 AM, Wei Yang wrote:
>> On Fri, Dec 19, 2025 at 02:54:40PM +0530, Garg, Shivank wrote:
>>>
>>>
>>> On 12/17/2025 8:18 AM, Wei Yang wrote:
>>>> On Tue, Dec 16, 2025 at 11:11:38AM +0000, Shivank Garg wrote:
>>>>> Replace 'goto skip' with actual logic for better code readability.
>>>>>
>>>>> No functional change.
>>>>>
>>>>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>>>>> ---
>>>>> mm/khugepaged.c | 7 ++++---
>>>>> 1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>>> index 6c8c35d3e0c9..107146f012b1 100644
>>>>> --- a/mm/khugepaged.c
>>>>> +++ b/mm/khugepaged.c
>>>>> @@ -2442,14 +2442,15 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>>>>> 			break;
>>>>> 		}
>>>>> 		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
>>>>> -skip:
>>>>> 			progress++;
>>>>> 			continue;
>>>>> 		}
>>>>> 		hstart = round_up(vma->vm_start, HPAGE_PMD_SIZE);
>>>>> 		hend = round_down(vma->vm_end, HPAGE_PMD_SIZE);
>>>>> -		if (khugepaged_scan.address > hend)
>>>>> -			goto skip;
>>>>> +		if (khugepaged_scan.address > hend) {
>>>>> +			progress++;
>>>>> +			continue;
>>>>> +		}
>>>>
>>>> Hi, Shivank
>>>>
>>>> The change here looks good, while I come up with an question.
>>>>
>>>> The @progress here seems record two things:
>>>>
>>>>   * number of pages scaned
>>>>   * number of vma skipped
>>>>
>>> Three things: number of mm. It's incremented 1 for whole khugepaged_scan_mm_slot().
>>>
>> 
>> Agree.
>> 
>>>
>>>> While in very rare case, we may miss to count the second case.
>>>>
>>>> For example, we have following vmas in a process:
>>>>
>>>>      vma1             vma2
>>>>     +----------------+------------+
>>>>     |2M              |1M          |
>>>>     +----------------+------------+
>>>>
>>>> Let's assume vma1 is exactly HPAGE_PMD_SIZE and also HPAGE_PMD_SIZE aligned.
>>>> But vma2 is only half of HPAGE_PMD_SIZE.
>>>>
>>>> When scan finish vma1 and start on vma2, we would have hstart = hend =
>>>> address. So we continue here but would not do real scan, since address == hend.
>>>>
>>>> I am thinking whether this could handle it:
>>>>
>>>> 		if (khugepaged_scan.address > hend || hend <= hstart) {
>>>> 			progress++;
>>>> 			continue;
>>>> 		}
>>>>
>>>> Do you thinks I am correct on this?
>>>
>>> I think you're correct.
>>> IIUC, @progress acts as rate limiter here.
>>>
>>> It is increasing +1 for whole, and then increases by +1 per VMA (if skipped),
>>> or by +HPAGE_PMD_NR (if actually scanned).
>>>
>>> So, progress ensuring the hugepaged_do_scan run only until (progress >= pages)
>>> at which point it yields and sleeps (wait_event_freezable).
>>>
>>> Without your suggested fix, if a process contains a large number of small VMAs (where
>>> round_up hstart >= round_down(hend), it will unfairly consume more CPU cycles before
>>> yielding compared to a process with fewer or aligned VMAs.
>> 
>> You are right. While I am not sure it exists in reality, but in theory it
>> could be.
>> 
>>>
>>> I think your suggestion is ensuring fairness by charging 'progress' count correctly.
>>>
>> 
>> Thanks for your confirmation. Would you mind add a cleanup in next version, or
>> you prefer me to send it :-)
>
>Sure, I'll add this fix patch in the next version.
>

Thanks

>Thanks,
>Shivank

-- 
Wei Yang
Help you, Help me
