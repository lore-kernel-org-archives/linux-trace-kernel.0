Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5714D2A0;
	Tue, 29 Apr 2025 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745903448; cv=none; b=kvmgyPGPjeu0CTnOZuTkTx/FJL8f7NJl1OewVgwjmzHUe2lItnu+0PI8rjsEAHAvcI8RwcCwWYd9p0spI8aYveULKzN59bFyuDyyXPxDSwNLmFEPxyjM05Jkug+yIDepOdPOUc+WRWrELOJNnJyVXQff1EBeNcjKvOd1Cl7t/m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745903448; c=relaxed/simple;
	bh=ZTeeFPzDCLqNrHogmQxRQpu/PV1VB3LkgPkxl3PnIcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JISuzNJsoscIy/+bce4W5I8bbiqGuSaYftflbGqHhuxFBbLoQ85OSFvQJKWyBCjI+FycGmmPGqco+T24Xw65rc/odFP6Kk1gmKi0ccJrzajnJVno7oIXo0Fjrw8oYpYzQclp7J1nWqD5JKYUdyoc+fZ8nWeBhzzof1RSYYiV6HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1a9AMhd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1a9AMhd"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2255003f4c6so60826695ad.0;
        Mon, 28 Apr 2025 22:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745903446; x=1746508246; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zX3Pd6vkQQ/3XX+ppdLcQfDQhkoHTDjgJ2yW/+pucr0=;
        b=D1a9AMhdBuLGbBHu+uLD1bp54CB5znTRNMwYi4PiRa7z+++pGxi+qvuhqgVob+yGjU
         /n0ODlPv9+B3R+YrZTEDUkny83GpefXwGT3pdREEYw3LjsE/zQOAYwGa8KXSqyamAHGt
         AOOUT8GC05xXYS8vymYqeiesXLChjaut47L2TUXdg9ZSDvuH4l2BRaEUCWlToDW4v+pY
         n7kuvEZ2wRlx0eIX0SWGp8KJuOv/i3UKsS8zuiEt4QDUaSyZoo2Ly85epydAayIOnpgY
         KekKSL3MJE/tCkJcLtoWWYviaNPzj9jBgsZ8z1reSQWQlM0/2AYb20AS19Z3glQSsgOQ
         FPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745903446; x=1746508246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zX3Pd6vkQQ/3XX+ppdLcQfDQhkoHTDjgJ2yW/+pucr0=;
        b=vTLxjpDccS+oTUEN2JPFMbxlhXEpgiUJbWJF/hLFgd9943Hr7gswezpfFjZH4HPZUh
         6iaA1oGg6msXIGh5go7+ns0V2k2Ql3CeonjKHdnbxNiMewAOBRrzzZwHI0Jweozg2X0T
         K9DWPw/MddDBXYC0jSS0SF9box4YKh6ELicmqbURatmWp7j40VQUIwQhEztOzy35E4vs
         xynupjfI3DMeAFQrSSqFDJ4rBIoC2Q7v5q4IYlyUsqKxxmCvhMGNPIG2uWnkELIv4sOa
         qNKrggdFCLFDhS9fOWpGDYKHLK/uMB2xhcBFHCHxfFgfJ9OK5IlxRvD6GtZz+Tp+TdEA
         li6g==
X-Forwarded-Encrypted: i=1; AJvYcCU2Ds+xzfkt0STMuAY4NECc0oM9nWD3SMhwnmFZONdpksYBLxHTHNiC+FjQ2YLP9/Trl6EP6kwcK7186EO7g7+R494d@vger.kernel.org, AJvYcCVTS7L4JGiA7JcEfNPhXsM4+qJsnZpNp28khDBsTcih+dIoNpfHAiameM2O3dGg4ebA14mSMi4g6n3A4lL6@vger.kernel.org, AJvYcCWr/aGgihBbfumRz6/IcTOKo6tpz1bqLX3BwoyLFGKjRkjjM213BewTFsTwgj1JkKQkSfs15MeeS/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsO25O7g337kFvyLKNkt64y5RjFMORcZ16/BTVID2HSZ8URluR
	tNlu6eSEwVUvcYXCjLF8UjIkUSjGqmEbs8T07czocoEzYWl/WkVB
X-Gm-Gg: ASbGnctJxDzApGsCr2Awzw4VSVZ36zl/xTOvsKJjBxn6mnMOS2IMU3gANDd6WzdpAel
	u8R1dTfIQRNdKtQ/M4SqoblLhINWFq+sc2O0AdBVOdOlq/oNHcA02dcab03hhzMfcdfrFqsUd81
	rQq53rXgQDtLAWRPJOClXWkE3IHdQ4d2iqS9aX7LHZrgLhYLCXJYEBT1x15QwptTBC9Fu+uj7ur
	yPVT8jiU+sHa+SHRf/P3A8QOzRfEloOkhlIz/06D7N0Jl7HzWr+JJEMlkDSzi2v0+2u3xEFJCW0
	eCj5JJ1LAOaqyID1p2DaKIo39Qco5CJZ6P8wy4Cp
X-Google-Smtp-Source: AGHT+IFkA7SJBp9SgRZ6+ivRwUkAsuFLNkKqWS5lYr05a34CF2VlAv/KjTjzxI9PfiK0PctIfZICsA==
X-Received: by 2002:a17:902:ecc5:b0:221:331:1d46 with SMTP id d9443c01a7336-22de6e939e2mr24815235ad.2.1745903445803;
        Mon, 28 Apr 2025 22:10:45 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbb204sm92921295ad.57.2025.04.28.22.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 22:10:45 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 28FB74050AE5; Tue, 29 Apr 2025 12:10:43 +0700 (WIB)
Date: Tue, 29 Apr 2025 12:10:43 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	david@redhat.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com, willy@infradead.org, peterx@redhat.com,
	ziy@nvidia.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
	sunnanyong@huawei.com, vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
	kirill.shutemov@linux.intel.com, aarcange@redhat.com,
	raquini@redhat.com, dev.jain@arm.com, anshuman.khandual@arm.com,
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
	jglisse@google.com, surenb@google.com, zokeefe@google.com,
	hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
	rdunlap@infradead.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com
Subject: Re: [PATCH v5 12/12] Documentation: mm: update the admin guide for
 mTHP collapse
Message-ID: <aBBfU09ujXgw61LH@archie.me>
References: <20250428181218.85925-1-npache@redhat.com>
 <20250428181218.85925-13-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250428181218.85925-13-npache@redhat.com>

On Mon, Apr 28, 2025 at 12:12:18PM -0600, Nico Pache wrote:
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index dff8d5985f0f..5c63fe51b3ad 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -63,7 +63,7 @@ often.
>  THP can be enabled system wide or restricted to certain tasks or even
>  memory ranges inside task's address space. Unless THP is completely
>  disabled, there is ``khugepaged`` daemon that scans memory and
> -collapses sequences of basic pages into PMD-sized huge pages.
> +collapses sequences of basic pages into huge pages.
> =20
>  The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
>  interface and using madvise(2) and prctl(2) system calls.
> @@ -144,6 +144,18 @@ hugepage sizes have enabled=3D"never". If enabling m=
ultiple hugepage
>  sizes, the kernel will select the most appropriate enabled size for a
>  given allocation.
> =20
> +khugepaged uses max_ptes_none scaled to the order of the enabled mTHP si=
ze
> +to determine collapses. When using mTHPs it's recommended to set
> +max_ptes_none low-- ideally less than HPAGE_PMD_NR / 2 (255 on 4k page
> +size). This will prevent undesired "creep" behavior that leads to
> +continuously collapsing to a larger mTHP size; When we collapse, we are
> +bringing in new non-zero pages that will, on a subsequent scan, cause the
> +max_ptes_none check of the +1 order to always be satisfied. By limiting
> +this to less than half the current order, we make sure we don't cause th=
is
> +feedback loop. max_ptes_shared and max_ptes_swap have no effect when
> +collapsing to a mTHP, and mTHP collapse will fail on shared or swapped o=
ut
> +pages.
> +
>  It's also possible to limit defrag efforts in the VM to generate
>  anonymous hugepages in case they're not immediately free to madvise
>  regions or to never try to defrag memory and simply fallback to regular

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara
