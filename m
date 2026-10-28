Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194924;
	b=xLUiKbqTIaLkd/WPdEGUF6CZMb6hFzldzQtjQKrXZmiTDEtdfBN0jfB55fduXR0Ydjco
	 Y0dATODT/B1wUO8aIHawkT8Un6bLxy6Op+Vlg9ovUYvndOJPNUKI1oGoNJVq1V5LE92Y1
	 SbR/7OPw3LzyfZGS3p3M8P2uW/vX0zqu0JNN8UjqHyS6y6s2bn8cZaiBxpAv1Q191tLrg
	 tV/LiJAVHWy2mx8w2b7JOKhyy5YNSpKTyzQVJYnmpVk6vszROWKI2N225ii+B+QJs3PJm
	 BPTZcBjrriMj6x+TTsaoj4zrpQiCYXuWM5Pr66wJ3xR5FFvR0ENbhOMx4M/oUNFdgYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=1mZLWc84btDXl0MHk8lbS2Z2QDCAWwzGK7CzWjzphtY=;
	b=S4Lasnoo3ra4Mi+M2h+qQP/E4/tU+MED/9KnQyfHDtgvm6v1ARcNCkkU1IpRtzY9ORfp
	 g0+jUj75rUdQC7Z0czFIf7Cw/mhy+dkGSZRW9ik6HCNmBuuNDcvkF7WbAGFpsVRUjVN+r
	 cGBDr6ZkKTpl3ifJLqlPtuaCSzNiIXvy0MiD2gFQrPSr3XH4eA5OiwQHMFCtpXE3dp1QS
	 zfDBGaERTNr336pL6MoVteWnlh76NtJB85csKc64z/isodkXPJrSu4VVWjfjnhIcfaETV
	 AP4fEP+Me7bJ3gwXkYiPHg+N8nu/5lWEK4x0QJryziSS6PPN972Lkrsl9rUPCGlR4QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=MULD2iT9;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734D8606A31E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 13:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 734D8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=MULD2iT9
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5366463571cso13751951cf.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 06:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793194917; x=1793799717; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1mZLWc84btDXl0MHk8lbS2Z2QDCAWwzGK7CzWjzphtY=;
        b=MULD2iT9vqKXxE4Bobb4BC1FqAXTg3Gac46Ovpts/VEGnwZEnZpfuDiU5ZL8Lrv+iT
         QmGT8o7KY1DdnPLq5TtIHC5FHSk4X/MgzfPVlZtpUafCc7tVjL9WqaZWwI1msn0BsZr1
         o4s1aPJHaa+4VgKQF9JLCaFX/8FGDpyn7IU/yftUj/obLa/bW29vNsjD1MtqaG50COD/
         s5p5ay4a89S7pWulkPrRwE2/LqIpe0skRIAz7wOaIkHTqTamkNRRC59He1VIAe7GLIcq
         i7QWK9vHeH8x/bkSicmubBW4We5p95MfOL/zLRHHkoVLwLdomC1dOm1pewKuH1juBCl7
         8vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793194917; x=1793799717;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1mZLWc84btDXl0MHk8lbS2Z2QDCAWwzGK7CzWjzphtY=;
        b=o/PIoJZzfI/tirlpS2uiEseBJ0Bnlf0fEpoRUNdSpbeuKWj7uPX+mFIip0z4BYJqU5
         lGGp5QohuKLooHM2ONMm1Dm96v7jKICONANIoDjYscAaJYXrxUyWMrI/JCf3Ip6k5LNn
         bD8ey4Ig81+bZWswmHg29kjm6bd9ILMXGkTRpu6LDXb2tmqOPj0asoFn0dVLgOglP0KL
         uUbj2dRkQFTVRDrBx6XAx4j4IXLL4LJpYDFWB2cDZQKxpSQHHxOVHyT42n7xDcrPtl1b
         JGFAkVu8Ni7M4wmLbNAdE6b3kYEsy1DlpnVBe10LHxjfN/WRgIUJX70H/3q715k4iWd1
         o5uA==
X-Forwarded-Encrypted: i=1; AKwUvBzuAlIPD51sBdtvP9yTYbkgGN16rOq/vxeX21fpDfO38zJKsSM2QJT9i3GnR/N3y/ReRkodnaGU9rtZenHvacjBc0o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvkzdByScIrsA1tmcFaclS/e4eu85EnJ7sEKT/i9srWVSyVaxs
	P+fkrp/aAYHGS7BW0zr1T/ChYIH6CYDkqDX16fqcDMYXw6CcEa6SmpoiXO6JHRjRg4w=
X-Gm-Gg: AYBFou1UNwO/JOLzvfR/uEsST+WcJbHw1OLeoMSex547gGxKLHrDKoXVLQsYkB0R7cI
	Cv3TeRUPt1TWC6Nz+3P/9X6LyyfrbKQQ7EZ5d4lrI4WvLbRP/TpJ5lZhnkzgSBscV/BLVmayfkK
	b1d+fCUwU4Pehe6zuWJJ+Bzdkz8DvBO18wG+Jp/ZNZRA3vtcQ5FntmH8qmSEz+p63F6wFS7sJAF
	YISXHjYd2FWwBSywfo/jneRd0k4ow1ROFbo0+La1filZF2n9+gTRF6Kha0FpQeqVW4xV1Xk1sRy
	iX7P+oV7us52MKv61CprMGfQoE++viYocfTKxC7AZ13cwevp67htU1UXPbI1f63NzlSmFaAOLbP
	ZbkJu8KzaO37HuAok8bIXymkeRd01pkVv7LLItyZC2Fq0T1Wjs4gwL0l57iAaSJnFWgZZ8pr5dp
	TkBm7S3ZFN2K0NMp9P1CjGxjdKVgt0gql1SgAWVY8bJ3/3kWZrVTL1gbiSH2jqw9ACC5i1sqRck
	3549ZkXcw7sLdvbM5vQD27X8VN35ECEIphmt0wSQbHjeBw67ZpQwIa99hQauqxZb3zkDNvBvJT/
	t2SfNi7pXSgsVUuO6Sqyj6OjJPC+hwce9p03ZNZ8S+DkJUVOAahibqhFCtrsQ4Z9IV//FmolwkH
	b
X-Received: by 2002:ac8:59cd:0:b0:535:52c:a2d6 with SMTP id d75a77b69052e-53fc919dd94mr39416861cf.3.1793194917292;
        Wed, 28 Oct 2026 06:41:57 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c96375sm132097726d6.33.2026.10.28.06.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:41:56 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/8] mm: fix allocator races with memory hotplug
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, kernel-team@meta.com, 
 akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com, 
 shakeel.butt@linux.dev, rostedt@goodmis.org, mhiramat@kernel.org, 
 mathieu.desnoyers@efficios.com, muchun.song@linux.dev, osalvador@suse.de, 
 ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
 surenb@google.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, 
 ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org, 
 mgorman@techsingularity.net, anshuman.khandual@arm.com, 
 Bessel.Wang@huawei.com, jiang.liu@huawei.com
In-Reply-To: <5e980194-d892-4b68-80fe-612c910c29d7@kernel.org>
References: <20261021023940.1940971-1-gourry@gourry.net>
 <5e980194-d892-4b68-80fe-612c910c29d7@kernel.org>
Date: Wed, 28 Oct 2026 09:41:55 -0400
Message-Id: <179319491540.2032926.7199366288730313291.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-28 09:37 +0100, David Hildenbrand (Arm) wrote:
> On 10/21/26 04:39, Gregory Price (Meta) wrote:
> > Eight fixes for allocator paths that can act on state another CPU is
> > updating: zonelists rebuilt by memory hotplug, and the pagesets of a
> > zone that offlining empties.
> > 
> > I've packaged these together because they're all related to hotplug.
> > 
> > *** Backport note - Patches 5-7 build on patch 1: without it, their
> >     retry is compiled out when CONFIG_MEMORY_HOTREMOVE=n.
> > 
> > Most of these race conditions stem from zonelists being re-ordered
> > in-place at runtime during hotplug.  The result is a mixture of failed
> > allocations, NULL dereferences, incorrect placement (GFP_KERNEL in
> > ZONE_MOVABLE), node misplacement, or incorrectly allowing hugetlb /
> > contig allocations on a node/zone otherwise not eligible.
> > 
> > Most of these are incredibly narrow race conditions, but since the most
> > likely impacted machines are VMs with memory hotplug, the narrow
> > condition can more easily occur when a vCPU takes a long interrupt / VM
> > exit of some kind.  I've made all of these race conditions
> > deterministics with a kprobe reproduction module described below.
> 
> What's the status of this? "memory hotplug" caught my attention, but then then
> is all page_alloc material :)
> 

I have a v4 with the requested tweaks and some performance analysis,
though i think there is some overlap with the other Fixes: series.

I can send it out and if it helps i can pull together a report on
overlap between the different Fixes: series.

~Gregory

-- 
~Gregory

