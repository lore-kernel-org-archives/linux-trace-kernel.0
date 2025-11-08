Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5BE28000F
	for <linux-trace-kernel@vger.kernel.org>; Sat,  8 Nov 2025 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762566147; cv=none; b=iPFMeR1XYBvAHRLACj1j3tyUP2SWXPPdCx/EcsL6WFI6jdwN5wCGSqraCNGTI03S1YW8C0rVUAOsmMFZoY2Pb8BuSk1ZSAVPT7L9iuHXmHApRYrt0A3Puhktn141Fg324R5oaSXZIB6zdtJBQQGAFJJxjh3rC4LknI2/9kdBFbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762566147; c=relaxed/simple;
	bh=2BoJwDhWmDPG4AVqZIXWOTh2l/C5ji/bwn5DT8jGj5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOeACWoOshySv5BJwS6XGDmNzgNrRF2qkhhWPhfxQRj8OADpZQoU4NRd6rNwmhA8f+3K42LqZU8eJxgvmXf4b01zZhywLANDOGzaqD6rVHvQQTBRGGMMfZlIHKd5sjIt15/EKg3/zuIuF4P3c/WjRp0MjZKDtXJtr0cpA46FXFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfiJ9ISX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfiJ9ISX"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b72db05e50fso141758166b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Nov 2025 17:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762566143; x=1763170943; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txzBDkuu6HQXRdAmWeqGcCpUJ0ARUbkkBrAd0TRurdY=;
        b=LfiJ9ISXQelqWzBVj4ny7A9nTjIbcSg2MeaNw9335bzIYQvQnHaiyWiCz6RNmdwLxK
         pS9CcCNnUkn3CslqMhTBLHZsAHyhgHr0QpNtqiHSHZYxF7V1y8IJ/vq6zOFC+kyER/QC
         jjtvTzynnrWDLdrmkYp/znrm5jTYp8W1iDpePrMKDjVi8jrA3ORN0ks0PtVEBgz8qELJ
         P9uyc/NHMiEhlsXnRSzYWIVr1T/6gdNac/IU0r5EoV2foVU3w+ikCb8XHhaqEZ5cGDbw
         +TWB7odawleaF8uJ0zmeXUSd99DtpGwVIYEsIh4c3iDLkPh3XQkxs1s4DWn0YVgu7V5q
         35Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762566143; x=1763170943;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txzBDkuu6HQXRdAmWeqGcCpUJ0ARUbkkBrAd0TRurdY=;
        b=GDHgG1FHcsiwutiuVnH/94zVlf+1IhMmv/87wRMrgYPCKsDMQG4i8e7dPHCzgUKzzZ
         yPBvckPq+u8OCO7wN07Mg75dct4QOwvobggh1og3VJBF4Og3ZkD885EfofwyPfsvDTjN
         ODhx5KsNfkYI4YEoLOtpDb88Zqi0OlQGpCcIlR5h7U+mtRflI21xb59D5Ds6+zWkXJNe
         VC/jC9n91ZA1R6GJFZ7TRmeidQZF2JRkKa/HnWeET82o+tVjRbn/6utLlIewFvPiAxTh
         vyJCTxWXgYHwTOeUhuDz7cCYP2qsLYdP9D22VAPLZ4Kv9JpH99w4ZGVL1IQQowANyp3h
         EAPw==
X-Forwarded-Encrypted: i=1; AJvYcCVdgVh9qZU5AfcfSefBN0VtyV91pchkhGykga3MS1CbnNUrrLf6rrt+U46C1l1yLNOo5vcFlKzl/LRegZGM9iuJ9PA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf9ULXmVRWhpHB+n6LxLuXSSeBRuISgmhya6TsbNyeamEwzNGD
	d+yKZljfsOL0OvRt3vDWHFYO83/V7OmtDue52zvRQWujaT3khHiyBYF8
X-Gm-Gg: ASbGncvOBGok5SD6hnIr3+Jos6g/jUjuBcgBMGltKSHW6yuiPEiLHHzodc9JrG+sjHS
	9rZr3VK0mmZuYIO5CRPIVMS5+dSxydvLpKFj5P1LkQbNTioo+xtFI4NaiYCkwLAwtRp8dCi7KLz
	OxepQE0LFgphg3eNmPNTcR8Ew4qD/2IXmJBi3D7FOLJXjApzRScNQpdywWp5+43lm6obPxIXsDl
	mXw15f4exXmZWVRrRRHuSIOIf1VtRcmgA8+yYJob67VM41G9og4do6/KyL4/OtrYmZtgjMdnNjZ
	bQjwyajydItY6Tk0X3Z6bUUfAwnbzzZGf6k2ExnRe+NPPU+/TwQ7uwz6zRjNR4LpKLE+CmBZM1k
	qpN845j1J5LeHjmxz6I8Kk0SG8HWFJXsHxN1Cps6WNmHzXK8yoaoBR1RmCkniCmMY4G3MfDZITC
	Ytyz24DbyY6g==
X-Google-Smtp-Source: AGHT+IE6lrXy8Q8tj4IT56byqhqDOcFo2Ljy91kXlQBEAHGBuKzDKR+fUlhhjwifft9Xb8qZcgHL3A==
X-Received: by 2002:a17:906:6a19:b0:b72:9d56:ab52 with SMTP id a640c23a62f3a-b72e02d20c7mr117552366b.8.1762566143114;
        Fri, 07 Nov 2025 17:42:23 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d0ffsm406996266b.46.2025.11.07.17.42.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Nov 2025 17:42:21 -0800 (PST)
Date: Sat, 8 Nov 2025 01:42:20 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
	sunnanyong@huawei.com, vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
	kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
	cl@gentwo.org, jglisse@google.com, surenb@google.com,
	zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
	mhocko@suse.com, rdunlap@infradead.org, hughd@google.com,
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz,
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v12 mm-new 01/15] khugepaged: rename hpage_collapse_* to
 collapse_*
Message-ID: <20251108014220.wpstoj3kqxxnes26@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-2-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022183717.70829-2-npache@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 22, 2025 at 12:37:03PM -0600, Nico Pache wrote:
>The hpage_collapse functions describe functions used by madvise_collapse
>and khugepaged. remove the unnecessary hpage prefix to shorten the
>function name.
>
>Reviewed-by: Lance Yang <lance.yang@linux.dev>
>Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Signed-off-by: Nico Pache <npache@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me
