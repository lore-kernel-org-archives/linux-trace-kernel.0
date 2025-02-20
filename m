Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213301F5833
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054374; cv=none; b=c5W5lGltnFYz+3XzzTRuuZoc3UtpzvLC1LdS0YYSqerBMYxaaXCW6HFUN8M3eO+zQ9wp8pE1vRPeaEaM6eaLa/AATZcBoxfHR5zlOnq1bwk8hGifZZJifUQztXHRjIEauk8dtFnftNotvE41IhlZhWmNrZj/HD6ExFgqvLngQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054374; c=relaxed/simple;
	bh=YvVj3Y+E/X9aMBDeF+0zodv5Y6r1iWhyl676Hl/yr5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teuvG/AsNCPlLur6K6chN0ExihH4G45KghyUos2iCaYmrSPre5TkP1pkkv7BqPXOpHSL4NvEI6qSe6eLKZC+WQiUQx2OdlqnDm5wpGMcDppfgs0BUgLukWMxC6ptTkRJoqr09ShhtmDcKv+dpBLZ0zcTUiYDHT9xadZKFQuUOeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgZ+kY9L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgZ+kY9L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740054372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvVj3Y+E/X9aMBDeF+0zodv5Y6r1iWhyl676Hl/yr5o=;
	b=HgZ+kY9LVHzVBXRjeLbCdP+z+IotU+rjRa7YG/qA9G4upP9h6cFdlYDY/lxuP6T5SBfJlV
	pFmkPnNe/MAY/wQ3jWiyNushwY3ot65fvM12N2zLLsXa8dvtu20gzFV4LAqg3CTTmQyya2
	0KMIaArNSLFfpbQlXchY9IWDPQyr0es=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-Lpk1sia7P76NWT0yuqVEtQ-1; Thu,
 20 Feb 2025 07:26:09 -0500
X-MC-Unique: Lpk1sia7P76NWT0yuqVEtQ-1
X-Mimecast-MFC-AGG-ID: Lpk1sia7P76NWT0yuqVEtQ_1740054366
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78AE419373C4;
	Thu, 20 Feb 2025 12:26:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.147])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9AE43180035F;
	Thu, 20 Feb 2025 12:25:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 20 Feb 2025 13:25:36 +0100 (CET)
Date: Thu, 20 Feb 2025 13:25:26 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: David Hildenbrand <david@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	wangkefeng.wang@huawei.com, linux-mm <linux-mm@kvack.org>
Subject: Re: Add Morton,Peter and David for discussion//Re: [PATCH -next]
 uprobes: fix two zero old_folio bugs in __replace_page()
Message-ID: <20250220122525.GA30669@redhat.com>
References: <20250217123826.88503-1-tongtiangen@huawei.com>
 <c2924e9e-1a42-a4f6-5066-ea2e15477c11@huawei.com>
 <3b893634-5453-42d0-b8dc-e9d07988e9e9@redhat.com>
 <24a61833-f389-b074-0d9c-d5ad9efc2046@huawei.com>
 <20250219152237.GB5948@redhat.com>
 <34e18c47-e536-48e4-80ca-7c7bbc75ecce@redhat.com>
 <2fe4c4d1-c480-c250-1ba2-1a82caf5d7fa@huawei.com>
 <196fc7d8-30a8-439a-89bd-57353fd98df8@redhat.com>
 <85725388-180b-267c-e121-3af1f1b75f94@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85725388-180b-267c-e121-3af1f1b75f94@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 02/20, Tong Tiangen wrote:
>
> 在 2025/2/20 16:38, David Hildenbrand 写道:
> >On 20.02.25 03:31, Tong Tiangen wrote:
> >>
> >>@@ -506,6 +506,12 @@ int uprobe_write_opcode(struct arch_uprobe
> >>*auprobe, struct mm_struct *mm,
> >>          if (ret <= 0)
> >>                  goto put_old;
> >>
> >>+       if (WARN(is_zero_page(old_page),
> >
> >This can likely be triggered by user space, so do not use WARN.
>
> OK,thanks.
>
> Hi Oleg, is that all right?

Thanks, LGTM.

Oleg.

