Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11442185955
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Dec 2025 02:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765939702; cv=none; b=QQxE00IvrFVwv3BqD9XF+Y+NJD06marekNFxLMsrNhNM9Zmp/jPYHfFoyXdQ6FqQhJC1KP07urck2G+uZ9N29WhZVUJVhLbghs+8AMPcKEe88IE6mIQt7qOdpLrSQ34hQfyvHpG1NNgIB3Ji5bq2qGDdBLH9KUBVfSB5CPBKJnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765939702; c=relaxed/simple;
	bh=uSmA6DQVTv/+hcPh4rPx7fbtGhYhOk5OPWoNkXLA70g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiQLQt8yucup2Mbd79pwYoPJgmDdI1QlDnVx3byDi6nWOuVugLndbJpZQv7iVCInNbsICsmUcUDCtsRXulB1NULpnCqGzkyoUGDOHvNS1DuKkryB1MR8OtoDFBX5JjMNdv2bRet2Jbesx3czt3bG1QNccn/9+/dftpnHf5PhjsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRY2BwH6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRY2BwH6"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6498a6f8ab4so8305947a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 18:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765939699; x=1766544499; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTMYwp/g74fxgb/i/Lv8htybblW+OirvMdDQqwF3ziU=;
        b=LRY2BwH6Rc0xd5QVQlvecp4HcoKfGSdGmPAKWAIfR1jIwLS5W4mL9tjxTOFXeZycnx
         XcprsvGs0s3kn5TmTYsrtZuOgjKNgu1/wpmNTXIMhiE9OgzFzXg4tkEnFRsDcyomjaCL
         hStcjG+HDy5oItrpZudxMBtkSZV6RJGnSHy/qRgGuNyxXEjxXi349nKdTwhz20PeCOYL
         /x7x7qZ+CZBU4Bocv/jKQBS8xcqhVxCet3NnNTY5ZPE4WQAMifbfxjowt7g5NzZfg4Gu
         cFtZt9mnikiE8fh/4/pwKlhvGaXOE2PU23aifdFXTN8NallmqYmAzmS8adsUxYUhdJON
         Q1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765939699; x=1766544499;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTMYwp/g74fxgb/i/Lv8htybblW+OirvMdDQqwF3ziU=;
        b=DepMex/XKvxzppRDkLTy+Tm5fEjN+Y7f5fzu9oyq8JB7Cd9JNQQhJ1mS360ojzQLiB
         Hj/KWMjTZ9hJAOPVprrf4LBqvZhoWcobquYOIkXt4OCz67sauxmgrwnCrocacyMA7kVw
         NLfcDeZCt2a4AW9Xc3rPChGNf+WtOp79V9sIQni+xw2GBltlKCMFqZKdI18Hslk3tJeW
         idgiul2nklHcKw3h6OyK3+rY27rJaXQdfoA16OSdGQRTdNfIjTGRneeC/eyRwGW8SEo0
         73t4joFeG8ExPVt6RcO2DzEVQ8WqFD/AxFHLegAAvd0ZVrfqksS6SY3kyKrJ1l1WYXos
         QZig==
X-Forwarded-Encrypted: i=1; AJvYcCVDQNkinrvNbZhzXKXZKx0Ehw2VELdpyzg9QOsQbXtEBxp1vA0UBHA6EZmgT3kz3Lus64McohjQii0yl9D8QNJFnvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoDaPHSszNi6GwmRD8gmyKVzirw2oEvMPvJkwdoRZ/5UzdrF3T
	kxWk9+v5m9wRl8+g/RDYVfPCdcmPL3JPUMj6C0BgcN6b0Dj6cr0Ga9SW
X-Gm-Gg: AY/fxX71Mc7WmxOL50TZ1yJxANaf0fuMpO/sEw7YGyWINCcGJoNYL6H2o70rKxc95SI
	0jZqLtT0QwiC/8yhxt6WXzYyc4RjHh6eG3CgqxLPeG56Gi0UYJ+ataqPiXIOX1TTClG7yM3K7Jc
	WiI6MmfJA3RCltnCpMwN2o4osc08d3ISHJlYegbiVym6e1PmmHThhvejg3AqA/7Xnn59U+y6YDN
	/VeP6CsivdTzwr3uTLdTtkFEfUeEaVy3tuTbXMzZif/B+iIKxEZS1+DGi8NNSPTnQlS1I6BHlqz
	GCbooWFmcHdQ7slXad1wkGy8y9aPacmsx7eAGQWaJxxlahQmn96yJoNYKzRu/qLwECUZa1WG8JG
	BFldd1KdLZwmOuF66KHPUmlA1wlAu54wFt7OLvjeQidDtK23cwIlNacJi+BqUDCPMh7TEfdA7dc
	tB879DQq5+VA==
X-Google-Smtp-Source: AGHT+IFhKEFOVaiZGW0iX8z6HR1iAF8pgy5NX5EasuQ15D3ejV9v3HpNxYAjBAX045Mp0eeJPN6AQA==
X-Received: by 2002:a17:906:7951:b0:b7d:11ae:4006 with SMTP id a640c23a62f3a-b7d23a68805mr1809328966b.52.1765939699191;
        Tue, 16 Dec 2025 18:48:19 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2ebafcsm1837731166b.28.2025.12.16.18.48.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Dec 2025 18:48:18 -0800 (PST)
Date: Wed, 17 Dec 2025 02:48:18 +0000
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
Subject: Re: [PATCH 1/3] mm/khugepaged: remove unnecessary goto 'skip' label
Message-ID: <20251217024818.ngoime34bxeatqij@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251216111139.95438-2-shivankg@amd.com>
 <20251216111139.95438-4-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216111139.95438-4-shivankg@amd.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Dec 16, 2025 at 11:11:38AM +0000, Shivank Garg wrote:
>Replace 'goto skip' with actual logic for better code readability.
>
>No functional change.
>
>Signed-off-by: Shivank Garg <shivankg@amd.com>
>---
> mm/khugepaged.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index 6c8c35d3e0c9..107146f012b1 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -2442,14 +2442,15 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
> 			break;
> 		}
> 		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
>-skip:
> 			progress++;
> 			continue;
> 		}
> 		hstart = round_up(vma->vm_start, HPAGE_PMD_SIZE);
> 		hend = round_down(vma->vm_end, HPAGE_PMD_SIZE);
>-		if (khugepaged_scan.address > hend)
>-			goto skip;
>+		if (khugepaged_scan.address > hend) {
>+			progress++;
>+			continue;
>+		}

Hi, Shivank

The change here looks good, while I come up with an question.

The @progress here seems record two things:

  * number of pages scaned
  * number of vma skipped

While in very rare case, we may miss to count the second case.

For example, we have following vmas in a process:

     vma1             vma2
    +----------------+------------+
    |2M              |1M          |
    +----------------+------------+

Let's assume vma1 is exactly HPAGE_PMD_SIZE and also HPAGE_PMD_SIZE aligned.
But vma2 is only half of HPAGE_PMD_SIZE.

When scan finish vma1 and start on vma2, we would have hstart = hend =
address. So we continue here but would not do real scan, since address == hend.

I am thinking whether this could handle it:

		if (khugepaged_scan.address > hend || hend <= hstart) {
			progress++;
			continue;
		}

Do you thinks I am correct on this?

> 		if (khugepaged_scan.address < hstart)
> 			khugepaged_scan.address = hstart;
> 		VM_BUG_ON(khugepaged_scan.address & ~HPAGE_PMD_MASK);
>-- 
>2.43.0
>

-- 
Wei Yang
Help you, Help me
