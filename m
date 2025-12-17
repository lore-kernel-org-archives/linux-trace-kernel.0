Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9A18027
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Dec 2025 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765939732; cv=none; b=laxltN2vkxzyOXSoImQI0Ief/PTw5avv5XdBPqor3QYIAKnWEQQ/kzRkViSL30L5572mJ2HjUhBulajHI21Tkrz/LZJNx7CtWjxd/RSnMp5HlkqRgzmS0935Ktl6qKyZe0z36Zt53uvAnPXBqtRTHqLj9Vy8zUfXowbPAEB2jKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765939732; c=relaxed/simple;
	bh=Wbj2BPFSD4+24X9YllNFBBT5gywBCPBLau96yo+gKgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwJUMX2NC/1Y6w3+35NCWVfpKOPXcxFSpoP8gwj58iWkumM/9gV8MzA/MBJQtr+l8ADiFMBS62O3cKxD52xiVQgyeJ2mKS+Wzfpng1gJWPmWLq2EotbS68lxX+PqfDv/MZa1AKVVnr+GbYZ2C8klJJ4jvWpJquvKlYXATaAkaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQb+LqFg; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQb+LqFg"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b79ea617f55so461035166b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 18:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765939729; x=1766544529; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggnpTKjc7CoueWSBfB7b7LA8VoJO3XLRhf05Pp+Akus=;
        b=VQb+LqFgHLNTw6uaDi42lL3n4uKtyQ8xnbOE5vnXPGBQx5O2zTyihE2kK1i1g9TNcj
         b2FPZeXJoNLV5ncp06M6lRS6ASVCQ8nPamXxlbmEvAsl+Z88KVzA4qDHLoaPL9zPCNN7
         m5SLA6I4ZBdk70U6cWS4fLOs/mkxeUOy7djwOfUhElzBeHPWqoVzcHelbcmYPyzyR/gz
         jS7Rg8p/LDto1fx1p2CxyDrq9NDc3eZ5dDLhL03Sh7lwjW5rEJAacQScYVSXAExiCfa9
         oAipXz8zgrvhvvDnvvZiHmThOnbOxVVBnq+rl6kDyRdMvON+m0jBgQHXCkowE8wF9rmu
         QgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765939729; x=1766544529;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggnpTKjc7CoueWSBfB7b7LA8VoJO3XLRhf05Pp+Akus=;
        b=He8PXkN2V06nD79wJAFCQ7YqPtim/+NhtUaYnAGgfPBvFk9GCTRULwyUrrRidx9vim
         fU1bD7Pc6vdMIFzjBUEPYOlREkB+tmyAdRdFClH8/dCkF9BCerhmRjc9rzr08PMF1xi5
         FWiUY44ojuRqcw4hjXR7wEV3FM5dSnit942wD6HUyMZgLOKVygPOwEzgMEswR18s+Giv
         4VspXvVst5q3lJeJoLYVa02V7RF+xe7Oe5eXvmaw+reW+lGcDepHJP8hndV0jkdwTGRc
         t7ZlbfP9X70uZp/04FuzqDa9lT3jIFXNBQkMQXOp0xc4UMSBgQOzwXLD9xrGd9YH296D
         34vg==
X-Forwarded-Encrypted: i=1; AJvYcCXuPkxAVHBYZIBCy9YQC2Y79LvHcBMVXFyIAk4drrv3vhv2H/OOU9Ur8PVm2QuXISZK2BWtRSNesr8SMgsDB5pcnIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBUkrKRGuHTTNSi9te9XXAWGleLvngq5vgAs71c8sMQsOfO4EV
	1yZ2to2p+BnS9OnzqkmXynd7IxPl4MGx1tEom7mg1XvuJTSBaYi3Py6z
X-Gm-Gg: AY/fxX7/7Vax6Jt66Ln6Zw6entEc0BzYwMSeHCUfFn/NsACBirt2ZeXEl+Sl2hMLOLv
	+ZnifJyLqaWgKN6z8dcbzEL8XYSGMsrxZ/U9PCHXpqBVoadiuDl4+X8uXMeqlcnJilIJjsTOpYc
	Eb6ylgTbxejRG9oAoDOTgdGFItUb3PV/uHR6GHOo3U3mlzPthB4F1tXJIk08tdD+7QVqLWQADdd
	Qp4qA6eUOobZrCdbNsFwhfNgPXdHIU0YE0RC/0PNTcWYvkUUIgynFQ8KwQ0jIkVeJftkeMSDjwz
	JyHJVtWSKwzOSx0Ec3wRC17NV82HlqFdo79AHKgeXgr4hcbdw6j40qxhZCno539PZj3R4+rrpFN
	zm6Z1GKDaru/S/VeDyyqFvr8c9SjK5dLFie+0GDEy2JB+f+j5nWnW4uRUoOPAXnGIwUuKXLIrb+
	yBaBhVVCP1TQ==
X-Google-Smtp-Source: AGHT+IEGzrL4ei4CYURCoMiWH15xVOBFZFp8TlRYA+TPMXKI5GJcECNuu0kOntwSve234QDDTf/kzQ==
X-Received: by 2002:a17:907:e895:b0:b72:5fac:d05a with SMTP id a640c23a62f3a-b7d23a96f0amr1628477866b.37.1765939728848;
        Tue, 16 Dec 2025 18:48:48 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa57190dsm1884704666b.49.2025.12.16.18.48.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Dec 2025 18:48:48 -0800 (PST)
Date: Wed, 17 Dec 2025 02:48:48 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Shivank Garg <shivankg@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/khugepaged: make khugepaged_collapse_control
 static
Message-ID: <20251217024848.uolcvqwywhpwdibp@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251216111139.95438-2-shivankg@amd.com>
 <20251216111139.95438-8-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216111139.95438-8-shivankg@amd.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Dec 16, 2025 at 11:11:42AM +0000, Shivank Garg wrote:
>The global variable 'khugepaged_collapse_control' is not used outside of
>mm/khugepaged.c. Make it static to limit its scope.
>
>Signed-off-by: Shivank Garg <shivankg@amd.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> mm/khugepaged.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index 65b1b778378a..d130357a2d88 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -829,7 +829,7 @@ static void khugepaged_alloc_sleep(void)
> 	remove_wait_queue(&khugepaged_wait, &wait);
> }
> 
>-struct collapse_control khugepaged_collapse_control = {
>+static struct collapse_control khugepaged_collapse_control = {
> 	.is_khugepaged = true,
> };
> 
>-- 
>2.43.0
>

-- 
Wei Yang
Help you, Help me
