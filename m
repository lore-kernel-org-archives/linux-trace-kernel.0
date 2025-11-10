Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1620C302774
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786500; cv=none; b=UMbmxoaUT5kalGtsdQvmITIVViGD4eDO0FXKaCgCg6q/Lc82PHwhNRzbR6BvBPYEGDRHirl70NPIFruXDiECHj5raKYXr6o4PwfhS0OmCogGrQMIBMOUgsXTxADapnkZnJmMiLHfFuP5oJUrz/jgxgu1ZJzN+EbsbrLIaHlPq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786500; c=relaxed/simple;
	bh=rUU+f9PcX0qzROWhXtT3SwA2QFBOOJW99Rko/d/EA8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXGNIZ2rSU4t/a/w9UoygjouSi+Bx8U9m6RkO7jkvTMJWcCTRlZbfNo/DA3Xz43jYgzX2aS0TRuoRxDOLq1WXoi9gS7WNQTaHNDqHzSi35k8Q4iS/P89iAsi13F6d67nKtG8slEj6veuA0N1NoiUSKCfUdFA9ABDnbfDWhAwUSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKs4Dt3l; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKs4Dt3l"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so865657f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762786497; x=1763391297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UtT4O7BewVOdeU11dvM5Ug5fQnG1uIMIXCN1qCElv4g=;
        b=gKs4Dt3lupO4jFXFyhqlH4TmOdSJRTexG4WgQSCYNgQUXYOCp5R+F3aLvLmSSQzeWv
         rG1CIyu9DbkThk6M2/8vHizTrAdi+2kYIDeW7KXIWlALbDzWJqCIe58L1Gx4tc8NnNHy
         Ntee/Zcj3OTeVeUaX1PEzdP6KfO2HSdfRgwtP2sebACk4t7XW/CviSebkZJ6+io5Oadv
         8dnBhi9Fj/jLO99xKv7dFq5HRm2n3fTny8uDUCJ3ivOdCqhpK15PO9PQHZywOy4adQBX
         sAHhuMoHMM6ghE/HWKxOKfs21ZbaqbvzjGr85ACu4RHftRMKeN2k+fyPRM+KdHsoBO0Y
         AGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786497; x=1763391297;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtT4O7BewVOdeU11dvM5Ug5fQnG1uIMIXCN1qCElv4g=;
        b=HcQPCbckSVvBE78/2J0HajUD8YmOSMRwyNPGvy1M+an7WIJ36SgOeh3E6hDd+tNgmz
         Dewl1qPjgbOM9VNQqg8knvmFou+2hcG2+2TQO5cXPGEEgZ0R+33iAfSOyAhNbqAOh23r
         pW5YjHumCwR8IWRY6h9GljR+GrSSg1za8wfVxv+/mdT7cUAMvotweMiY/fliREGKSfjD
         fbSLXkB8OG4ezxGKB2vBd+KBjgrTHMDUTajs6El7Zd8OaY128uXRoK1N/dP4QEn703gU
         /EoVD8bZ4CjUjowJ+PhvC8oFpydk6YopInhb3nWYFqaZ8Vy6zLe8yO1zLz6lc1GF2Voj
         w26Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2mN/XUaFCNa0e8I0CgTRO9lNQfEpgx5IGzSqqU48EwEbPjwGT2KNkZccb/ZvGU6AVhazOBgywDnfhWueCtVmkmBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDHG3BBiJBCDG7J1N0h2e/kKJYL/1A2i6wbNDe2oW/2IrqKnRM
	UqNGDZaGsXx0DCf1EoY2BfmPVIR7A1kSp5wloggvsopN7RZVBqO1j7az
X-Gm-Gg: ASbGnctule4RMMnUBIePNy5GjVI5JpI9vVypF9hcSsF4UW3iXLW4jcWyWZR03Fu3vqr
	GcrOuKnH0W2w6BrB84/danTFPKur3XPgCATMhOaHspOyk9KuHPpjvLaILGaZMW7gpk88a0DkhAG
	1fARtOxndSCiK+pSOwZA0S5GJH9ogu1UcjPiqMKV252LpsNlsgMx4Zd/qlNi0CS6LPAbVwJAz+2
	0m8uovE/9dzXP4ZAPz5TbAQyWoKYFLCOhkbecod+DMe+k6/1RG/uf78MIKIJlZ18+Ua/0h/12O2
	FeDn6lcLiNE/krM1iMMrwzIddlSCMA31M+QDz3yIN3L99Rb2BZ2FeLMG+PfT7HQeIBEClzZbvdJ
	Pt7ng20ohk4A+wPXLCQer6i3sqDXJiRhM6l8IWLay3CYWlUNnbrv1hXqhEHK4yqi1P0UhDbHsXC
	AoDCa0Z1l44HsiMBz2CnYyQCfUQrD7tSx5m3U70jPvfYSzx6sCwpJKcI/IVI8LoDBR9Ocpscw5Q
	4tP1XNxMyBx6t9ws6rm/NYiHNaDag45K31j9yprM9eflG0x+g==
X-Google-Smtp-Source: AGHT+IFgYtF0Zf+P6CHYXSeBIt6XkOznTNcFaXqJDPZp+x8TaTAwDPOPyk8sB9F+rWpsk9Zy+d+pvA==
X-Received: by 2002:a05:6000:2302:b0:429:c4bb:fbc4 with SMTP id ffacd0b85a97d-42b2dc24800mr7139287f8f.25.1762786497116;
        Mon, 10 Nov 2025 06:54:57 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm12777750f8f.16.2025.11.10.06.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:54:56 -0800 (PST)
Message-ID: <69884a4d-60cb-4a66-a225-38d3a17712c6@gmail.com>
Date: Mon, 10 Nov 2025 15:54:55 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/khugepaged: do synchronous writeback for
 MADV_COLLAPSE
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Shivank Garg <shivankg@amd.com>, Andrew Morton
 <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Branden Moore <Branden.Moore@amd.com>
References: <20251110113254.77822-1-shivankg@amd.com>
 <aRHs3pA2kOr_uD3k@casper.infradead.org>
 <9b622374-778a-4459-aca9-4eb406a58516@gmail.com>
 <aRHwv3XzI4XHcLPP@casper.infradead.org>
 <2e6153c9-1729-463a-86b5-0973b3f56ea6@lucifer.local>
From: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Content-Language: en-US
In-Reply-To: <2e6153c9-1729-463a-86b5-0973b3f56ea6@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.11.25 15:05, Lorenzo Stoakes wrote:
> On Mon, Nov 10, 2025 at 02:03:43PM +0000, Matthew Wilcox wrote:
>> On Mon, Nov 10, 2025 at 03:00:32PM +0100, David Hildenbrand (Red Hat) wrote:
>>> On 10.11.25 14:47, Matthew Wilcox wrote:
>>>> On Mon, Nov 10, 2025 at 11:32:53AM +0000, Shivank Garg wrote:
>>>>> When MADV_COLLAPSE is called on file-backed mappings (e.g., executable
>>>>> text sections), the pages may still be dirty from recent writes. The
>>>>
>>>> That explanation derails my brain entirely.  Text isn't writable!  How
>>>> can the pages be dirty and file-backed text?
>>>
>>> Files are writable :)
>>
>> Well, if you're root ...
>>
>> -rwxr-xr-x 1 root root 158632 Jun  4 11:14 /bin/ls
>>
> 
> gcc foo.c -o foo && ./foo
> 
> Is more the issue I think

Yeah, that's my understanding as well. I guess stuff like 
package/container updates might similarly trigger it.
