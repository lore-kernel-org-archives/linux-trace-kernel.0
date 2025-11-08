Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFEB261B65
	for <linux-trace-kernel@vger.kernel.org>; Sat,  8 Nov 2025 03:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762570902; cv=none; b=d4VSwUe9iv7bS/vHYR8Eu2Cdl5I/w/7KoJhtoSFSToWHXgppk05rhwKMoviRsrK3cxePlovFbXgrZPjle15v2VB2lYI1rjaAg4xgqruXNxjFniUt2PbbBSs8GsHZLdAhXxO0mHKI0t2sAsLLttIYkEzHM4JgIczogOFSzz6ri1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762570902; c=relaxed/simple;
	bh=Y9YV3f8Hzry+Ze97F/cP+/xbypI1KDyCVKpqIvt9p8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGNe99sI/+i2zYYuXqtJ70VJ3Wo22MeAeIpzQ1SxI+/K8n7PmssvQLtZtUaIJHhUq6Ynb17+q/zKr2ULDc9XeqEf8N8YOsOwKgOngGQnWTAs7SbOAWNO5bGGsynagDovokI9ZeWnTIYHocN8bPY8hIqfL2t+euno8jZhubR1Rkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqvzXnEv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqvzXnEv"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so168492666b.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Nov 2025 19:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762570899; x=1763175699; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvQMGIBRXMAfRMIt2kKWb8Pd94P2qwTUjsmasBUxq4U=;
        b=OqvzXnEv/XhxHmFBcR1ZgdHs7bn8FQ5YaZxR9JHfFjyEalXa+PztZRYnpBlWol6T1a
         iPtyDoT1hfx0gKNJZQfU5X91OFEj27uhQbNL6ifXdIwZuYzSpkouweXU5O3Wm/ngn1wI
         qfQS+yAbrU5xnYzm8bYDYoThZmFG5oFhIpQM+y+ZzmppzZK1BZUBXK52fAqM4QyjRLrZ
         K6tHCMXcKPET8xrjS5whbhh1WridPW5weg0FySMWCw/VTL3kpazSSGiiaRW7ZjBusVBy
         Bva9dSc1kNmSGMxXOWULtg/owMftQ9hTOyYITPwOpNEeuKXcbZxfXMXDSMB6bIpIUkiC
         lnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762570899; x=1763175699;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvQMGIBRXMAfRMIt2kKWb8Pd94P2qwTUjsmasBUxq4U=;
        b=DDdIXIXJyDgJ95rq64+Tt6KpN87bY0z1aQplxiQLNUpkgt1cmU1NqMgVvYFD8rfiSO
         apBz2ETb8jwGl/fIgkHb50MPtKuzzVYzZY9NPvt47oaZb5RNC4fgfh6Vah4zacLsu7ji
         hfb5E95uVtkBAipkn6GQj4lgo+66i4kXOETtxXigerngJgn06wlSMxvPJCA0ugFMlwNC
         uO3AykMhlHSUQC7nfiT2IteQYIgt8eCm9eFBW6G1jOOCpwXeMHXRegIELqge6pYcnhyV
         RMtAlr6v6RtrYxcMp3RTTJ6X6c/jd0rRc+ig1OyCTAVnYeh4mn3N34QlbvejlT0q99ZH
         KH2A==
X-Forwarded-Encrypted: i=1; AJvYcCVf9brl4f8YE5Bk0vdBudAQUAmBynnKVyMVf1kzCTDW3Q97dgSYxhCSmUn9pNGWanfvUone++kwDHxTVbfXYUU7LDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBZ3UyR4ihuBfN3VCuqHWtiv3YSoqEpi2xFD5/E9AFsWIvn7qG
	HYkzl9B2t5TQb7gm2NnYDjWPiIs4N6BwWlOROjd7oxUkk1JcHEAgc+fM
X-Gm-Gg: ASbGncvvLDGH8skpqTFqICKROdrvqe6VdwB8hr1E25v4n7H6q1Ta4d0gWIFS7XV/YuI
	sBJcDTNvEuIbQzGtiYCkPxzfdkEMkG8puistOvusY+dnLscR5LkLe7BVNCrnuxoTiHczW+1rcHN
	Gk7UM1U5WrmDm+91YN+zNvEX+nprjZ8rs2ao+vJaMhBLaE0GReC8xpqw6c4fB+3nZOPmfomuDvz
	uzlEPio4RdSdJL7Aw2PeFZ4OeaSe/OlPi5ZCUDPJGv+tVAjNokACHoPmRBZbj16ezkRVDLPo3fW
	bEVN6UCyoSVPEZwfwl9eOH5UfnoeNczmI33dHl6Y42ipuhVCcGAgh/mFB5c+0zIlmSjYNQNB6WE
	IjXehp0My6HEoSrLhvAshOj7jyJQ46yCfb0J9NmHIx3Bi2Gj7Cm3P+sJGHovzNU4Fjbt2GSnBOF
	c=
X-Google-Smtp-Source: AGHT+IFpe9qLqPYcxu/67GnD+yfSvSPuX6hzgETXb3TcPECOp4WGRyEJjWKfcLIhMsnwyzl+jMrZig==
X-Received: by 2002:a17:906:7313:b0:b72:b8e4:3aea with SMTP id a640c23a62f3a-b72e02b35cbmr147921966b.10.1762570898658;
        Fri, 07 Nov 2025 19:01:38 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf312e25sm397398366b.20.2025.11.07.19.01.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Nov 2025 19:01:38 -0800 (PST)
Date: Sat, 8 Nov 2025 03:01:37 +0000
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
Subject: Re: [PATCH v12 mm-new 05/15] khugepaged: generalize
 __collapse_huge_page_* for mTHP support
Message-ID: <20251108030137.mud7xxwg5fxdgm6k@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-6-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022183717.70829-6-npache@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 22, 2025 at 12:37:07PM -0600, Nico Pache wrote:
>generalize the order of the __collapse_huge_page_* functions
>to support future mTHP collapse.
>
>mTHP collapse will not honor the khugepaged_max_ptes_shared or
>khugepaged_max_ptes_swap parameters, and will fail if it encounters a
>shared or swapped entry.
>
>No functional changes in this patch.
>
>Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Co-developed-by: Dev Jain <dev.jain@arm.com>
>Signed-off-by: Dev Jain <dev.jain@arm.com>
>Signed-off-by: Nico Pache <npache@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me
