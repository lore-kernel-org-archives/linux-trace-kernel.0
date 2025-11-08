Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B72C29BDA5
	for <linux-trace-kernel@vger.kernel.org>; Sat,  8 Nov 2025 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762566899; cv=none; b=R7kgnhVY3A6io+L5TBzZWWaHrQw3J7vMAD+ZsHmZIrvnev+reOYSsYmSOYpuVvRSalkePsqoyZIcc6LtGWWhqkhZ6c/mjxKrj6L1vehWqZb7J552Q82dudXG3w0tQvMHPZ6kJrX7VkeiPVXG2iws3H1wieDabcGrJcnQlbQ2fBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762566899; c=relaxed/simple;
	bh=QT7HfEiG1nxjIP/5e3X1PMRzpD1izZm+tR0ZCD8Bd1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDNyBs8yGMsYxsbFWrRAw+BoUAPLX+uh9lwpF3WI4uhZPS+RU9vncWl4Q0eoW/mXq/lUsXMx35/Qyiu6kuv3XrFlmh41XMg3JxEv6re1mwifnFsIrlimwvrC+kkLxhdRVbxvVjXYYABuWfDQVkQsGVUrB+ds4amuPCcfbvI39mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ficmZjKW; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ficmZjKW"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso1632814a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Nov 2025 17:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762566896; x=1763171696; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0ZmaZCDwiHMLTx2bSrUVe6Saq+o65+OA8UrkrTQnt4=;
        b=ficmZjKWHGM6//HGEpxPPZDdDTw9ZXUYXfbvAg5T7evpvqTQ9DkeU7WZZrLFfami6E
         a1A5zyzFFPUvJsVYeRoP3LXvsowJynHg28xbLhmEmoz2LGI46nIRPTt0FTXUq6r8V+3e
         LNJ7cUMQwIETyAfMJecamW88ZME2tfUB8j6IJDpE27gRZiyiDUnjRC4LZljPK1O5mrJ5
         9nBb26eOjPsCPPr6geazMgi5CxslwIEWakOeoYFbv0NIZVhob5y/G1k/h2tu32tEkDkr
         bbwrnQs5n45m2nHU1aPRqInsV2cTViPm6lD9O96NY/tfBuPd+ZFY6yjgWEqgrx3G9eMI
         Rc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762566896; x=1763171696;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0ZmaZCDwiHMLTx2bSrUVe6Saq+o65+OA8UrkrTQnt4=;
        b=fi659Z/PlFEssBfuyskwRu1v7GHOujE3LAihF2e7ZjaONs2OOWT5oeIbJaeRJTjuOn
         ZoJJwFQz0yOfdnv5nOH+UWoqo7QeLW2EiPoBIalZqSm8SVD93Ba4xGvN4TBrItm1kVUt
         jVE7wToyjPzUVvR00PAvS8F26jLOSxkUTfeFXfUkC0uljXqna2SIkd6gD/QcU6d2S3aW
         1KngsXQ7YcPwJvmZ9KbyR3Kfya7T114Gwo5MZFUkbyKZE28F1kedYldFtH2nVKnQVGdo
         wBlhHmpVjOFXpaHkute8Z3GQrs2R29HqN1ndmupe6j3HPn5T/+Fz3GEKqH4yTa85WGf6
         Dhxw==
X-Forwarded-Encrypted: i=1; AJvYcCU2MVZvA3RakjfvhLdBEVO19fPf2yH9gLiPPgGtc5XyXLI48C9Fc40sdr+lBd5yxxYJXIZ603Axp+sJ6SeG3hnHvJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdyUkRpT228SVwcTdzFFpjFhlguwAD5SaUP3QXyLLBZWxxzghM
	e0luNdiz3BlPNr42IuGY7HEwiWe9Fcs5drGaO946ew/9XZ547+jF6itG
X-Gm-Gg: ASbGncsB0DvCHvt5zKsR+80wdItzA0OFLAiJfrYHxSIBec6hI26zfEYymd09c0FnWNv
	irtw77bkGwTYIfqtLoluBK2/V5pw263g1lYI5V80lSZM1TrZCX9t9TkgHlMHMwhb76sWHPXda5M
	3jTtqC4Jfp99GHE7SVLlziq0IEpa74ZuxdAHM/HR5eHWjXMbU88zavuMgFba3WtmFzsQy1sAMF9
	h5g+0XDVkhXmFtkBQ5/48NBBjWEAYaAx1j2kSLEXMFYqWZkKKzqb5kDs/a+WQnR8sWsCv8i7N2B
	XoLtmJ336IBsimho3WdXdWHDkmSMaoL7lS2yY4voGEj2i6jy2AJV+H2ufY17qau7KFDMY52gRBf
	60xv4SDKo3thQbEgrxya7+m5QfH+/NMgk0RuIV5FCVWv+EOlbhPUwtlUI7xAITwQ7++tXSKwWwk
	kMerKoShJCe+sIfjIlPELd
X-Google-Smtp-Source: AGHT+IETDq1IeCw5XplonpY1pcN21ELAuNqusNEyhCeZTqp1tHeSu1woXZrdQ1IgGv97Z7tZaS+umg==
X-Received: by 2002:a05:6402:46dc:b0:640:37df:e798 with SMTP id 4fb4d7f45d1cf-64146c0cbe0mr3504024a12.1.1762566896182;
        Fri, 07 Nov 2025 17:54:56 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eb6sm5496824a12.14.2025.11.07.17.54.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Nov 2025 17:54:55 -0800 (PST)
Date: Sat, 8 Nov 2025 01:54:55 +0000
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
Subject: Re: [PATCH v12 mm-new 03/15] khugepaged: generalize
 hugepage_vma_revalidate for mTHP support
Message-ID: <20251108015455.qc244lvt2pep4t5f@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-4-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022183717.70829-4-npache@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 22, 2025 at 12:37:05PM -0600, Nico Pache wrote:
>For khugepaged to support different mTHP orders, we must generalize this
>to check if the PMD is not shared by another VMA and that the order is
>enabled.
>
>No functional change in this patch. Also correct a comment about the
>functionality of the revalidation.
>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Co-developed-by: Dev Jain <dev.jain@arm.com>
>Signed-off-by: Dev Jain <dev.jain@arm.com>
>Signed-off-by: Nico Pache <npache@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me
