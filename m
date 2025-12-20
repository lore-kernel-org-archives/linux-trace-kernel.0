Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20BE212FB9
	for <linux-trace-kernel@vger.kernel.org>; Sat, 20 Dec 2025 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766191135; cv=none; b=iB5OTDdZtSP5JejNKd967xB11/PjUbVhOjqSloE1KIr5rAXHt53eJDRLnf0ZTk2ZDNW+q9zHJcJQhv+4XCcEorFp32eLL4Awxi5OY98ceGPnbMi+JK/SAMMVnsUaRm/2WICyQfcCmELwlpKwqtNzg6hTOu7NJVtdAmTkTIwnpls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766191135; c=relaxed/simple;
	bh=eswaSaP3CWqx2hoek8DiKwQajXdjPn1g3D3AAWCCS6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9VUlDaXLuGAt7nd/63kvO8YRoyFgFCYIjhyhdzruO2S4TrY3a/T5cgwt5wAjEy0cShWS4ZidfsjX65JVn1gvxljxYXC0385tvbihqKACoD+UXXYQeIUEtKnjPQmlFG/Zpf+jWdVYjnWYJDZCU+kX03O15wJWP9yNzNYsqfFI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfmVhwWl; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfmVhwWl"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7a02592efaso337640766b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Dec 2025 16:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766191132; x=1766795932; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Y3Y0Yx+NCyZ6/DOSVsayIB2ojE39RciO6fXS+6DEgk=;
        b=mfmVhwWlQIDivFE7hcNjxBmO4eXeMsg2XsncLXjtduc8rPLFFGaAu5z9E8ymW8/Hu2
         KshHzIMAR2Yiz6zIKxmHJAnK2T6fps9ZeBECe98fb7QMUke8FYGPEAuTiumJZINrLM6J
         vc809OpheDPQ/0o9P1AJDXvAYLJCr/SkcPVEUiTCql0K/2OeikMkNyXlp9pH5qpMyegg
         eOGfZa3Q0udffT4DTgAepJU2ljDPtDKAFvuk+4RtAQ6O86BJdC42koTOZ24NNBF2hM7U
         Iwubfe7AICwrzsCWvuTIAuB0FvcAS/j8qu3lyNLf55j/75UY6GtclIc44uwvXnEs0YpU
         hRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766191132; x=1766795932;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Y3Y0Yx+NCyZ6/DOSVsayIB2ojE39RciO6fXS+6DEgk=;
        b=fuHENXj6QkNJwEBdb1sevn25HYb0pdqXzUuHmx3dmwEnU8+R9TzqSc8dWlmz8wHHH0
         4X7QPA56Y4vCNnUKjz2aOZuSmZoi6JsUjr+ZY36jPBHiipq3GZV/YJlbcjfXEkHHj1Te
         cQB2btSNkTfgBdc0FA+wHkxPSh8XZmfN9djl9n2cjB/sphDkJ8+nnq6V+VCXSrOigfrB
         Q6cr0pDseOW5adIyl18H8rF8fFVg5KuRwvkzcKF+WcOPQAtyCYn9+H6ZSH+BISjm3VBb
         xvAv+kMtuu0no6mu4gbnNLzUoA3bO3Ms2n+G40JGcQWrxNepXiIUCTA8T5Lb7OyCbzq7
         Y8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUymHnhr/XrlH/2ly3TJF2gclFSE29T+5XVZipBllXuNCYvcFazS+1AJ34nnbcFxA5kDKbO396OzIN9+ENXT0QG/TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb6SoFfu8UkKwtvK1YomrccyOY9qNiuheTAYrtGOKoh2Q7ZKDM
	c7a5fLxZ4LodTQ2gMpUEzH/PLs4HACulSy+b9YoVcEl1FBRjSwZeBAQJ
X-Gm-Gg: AY/fxX7sV8mJL6SveQOysqwXahyP8xsl2J6IQTUxTcFyxdrxDCVrvDEFqIP+bAzL+10
	Z4X/CQJ1DJN5KdKPAYhuLGg2ubGhgND+L7bvf95e0m1ICX5cAILx4kZW8e+lp9JIULJ/bxeD/Vl
	CF/p2KPuBwPOdXy5/GhgB5k+3/CeVqJvLPFYDZh0TuImAOT1Ln2o9TejLFNrodN2mBnMsGzQFsV
	6MvKfUVmulnyMJdZvwl1ulNotzA3n590LoX4Ei/7TyL3R9E1QyQFFro+RyoYgVLF1/fWsLvTKUK
	ft5oiIYrrS+1Ztjffe+nsS2FdjNcoxskWqRNayU1vbkOGhmf5VANIBCCwezavB61ToXwkA2zPgV
	sw6PQ9V2LV7un4GAvRXWkOXSoTpjcimv2YEg0JX/9RURnpMugdz3P/cp9NllF+PLAPfvWCAVTyo
	NEp+RLKTH+dA==
X-Google-Smtp-Source: AGHT+IGMkT3dRU7E8CU6/p5XRm3FX+P7Y1WZkYUD/SbScH7FS0t89FNoNETeJQo4FkXBW5inymANjQ==
X-Received: by 2002:a17:907:8e95:b0:b76:7e0e:4246 with SMTP id a640c23a62f3a-b8036ecbbb2mr420395466b.12.1766191131803;
        Fri, 19 Dec 2025 16:38:51 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11dasm349498466b.35.2025.12.19.16.38.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Dec 2025 16:38:51 -0800 (PST)
Date: Sat, 20 Dec 2025 00:38:51 +0000
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
Message-ID: <20251220003851.dzsafcxtlbgzwsm6@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251216111139.95438-2-shivankg@amd.com>
 <20251216111139.95438-4-shivankg@amd.com>
 <20251217024818.ngoime34bxeatqij@master>
 <c7c1d62c-7d27-4b73-8173-0493adc66cfc@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7c1d62c-7d27-4b73-8173-0493adc66cfc@amd.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Dec 19, 2025 at 02:54:40PM +0530, Garg, Shivank wrote:
>
>
>On 12/17/2025 8:18 AM, Wei Yang wrote:
>> On Tue, Dec 16, 2025 at 11:11:38AM +0000, Shivank Garg wrote:
>>> Replace 'goto skip' with actual logic for better code readability.
>>>
>>> No functional change.
>>>
>>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>>> ---
>>> mm/khugepaged.c | 7 ++++---
>>> 1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 6c8c35d3e0c9..107146f012b1 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -2442,14 +2442,15 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>>> 			break;
>>> 		}
>>> 		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
>>> -skip:
>>> 			progress++;
>>> 			continue;
>>> 		}
>>> 		hstart = round_up(vma->vm_start, HPAGE_PMD_SIZE);
>>> 		hend = round_down(vma->vm_end, HPAGE_PMD_SIZE);
>>> -		if (khugepaged_scan.address > hend)
>>> -			goto skip;
>>> +		if (khugepaged_scan.address > hend) {
>>> +			progress++;
>>> +			continue;
>>> +		}
>> 
>> Hi, Shivank
>> 
>> The change here looks good, while I come up with an question.
>> 
>> The @progress here seems record two things:
>> 
>>   * number of pages scaned
>>   * number of vma skipped
>> 
>Three things: number of mm. It's incremented 1 for whole khugepaged_scan_mm_slot().
>

Agree.

>
>> While in very rare case, we may miss to count the second case.
>> 
>> For example, we have following vmas in a process:
>> 
>>      vma1             vma2
>>     +----------------+------------+
>>     |2M              |1M          |
>>     +----------------+------------+
>> 
>> Let's assume vma1 is exactly HPAGE_PMD_SIZE and also HPAGE_PMD_SIZE aligned.
>> But vma2 is only half of HPAGE_PMD_SIZE.
>> 
>> When scan finish vma1 and start on vma2, we would have hstart = hend =
>> address. So we continue here but would not do real scan, since address == hend.
>> 
>> I am thinking whether this could handle it:
>> 
>> 		if (khugepaged_scan.address > hend || hend <= hstart) {
>> 			progress++;
>> 			continue;
>> 		}
>> 
>> Do you thinks I am correct on this?
>
>I think you're correct.
>IIUC, @progress acts as rate limiter here.
>
>It is increasing +1 for whole, and then increases by +1 per VMA (if skipped),
>or by +HPAGE_PMD_NR (if actually scanned).
>
>So, progress ensuring the hugepaged_do_scan run only until (progress >= pages)
>at which point it yields and sleeps (wait_event_freezable).
>
>Without your suggested fix, if a process contains a large number of small VMAs (where
>round_up hstart >= round_down(hend), it will unfairly consume more CPU cycles before
>yielding compared to a process with fewer or aligned VMAs.

You are right. While I am not sure it exists in reality, but in theory it
could be.

>
>I think your suggestion is ensuring fairness by charging 'progress' count correctly.
>

Thanks for your confirmation. Would you mind add a cleanup in next version, or
you prefer me to send it :-)

>Thanks,
>Shivank

-- 
Wei Yang
Help you, Help me
