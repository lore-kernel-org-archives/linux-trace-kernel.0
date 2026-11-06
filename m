Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793955072;
	b=3YI3pQ+Veamc1AOZdMCFFglyYeLaq7fM1Cjc63nAwR6dkBEiEMGWRW40xTl3rfo3T8Ss
	 iVKs9RVIcYsQsgtij9U9FP/5zlmnt+N3rBfpctMCAFC5nOOezoqB7EunB8z1ddkKPn1EI
	 oWNJa3pkUS+34vpxlUp7BkHlMUutiYQVss7W0w/IKFLvrkLyzeLnIi/AKvqKPRTlQJiqd
	 22LT5NatCy2U92vDY8QvY+npSW0L4FqkMj65KJHyQ2CYmxPGFZJSL1PxnHVKpsitR0qED
	 QkF0ILMBcHcPafPTkodyTP1spaZ16d9FFZ6oYs/Pp6OjLGnNZ1wOPtz2c7CMc8bClug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793955072;
	h=DMARC-Filter:DKIM-Signature:To:Content-Transfer-Encoding:Subject:
	 Content-Type:X-Original-From:X-Lms-Return-Path:Cc:Date:Message-Id:
	 In-Reply-To:X-Mailer:From:Mime-Version:References;
	bh=uw2jcbo2K94Ipub2qP4Q99pSQbMkC01ncZoy8NZ7ZtE=;
	b=5rz/v61oCr4fH95BmPNakpvC6z5h67zo9ZtIWLM6zr+0XqzzggD528Ffs6Vsu3sVM2GG
	 JxEyPJVKBY05CUiboYjn/p17SKRs83ESY/O3SJndD4zYuDmYo+PB3rtL0C9gaJJGMWH87
	 LFXOKNzvXsbA2REdh/5afDsEScCoThas6Z8VxxeXn8cFbA+ROcJqxKaqEiWHrOQA+O8HY
	 5ofw2cXDP8amO7Wt41dlDkoRvNxShAootc0yjtfcjEdKfqoZ2oNUb4Ak3RH8ZAASS3EOf
	 WfUUSqY8y4Axc1QPHECggIxE8wz3w684X6GyDdRtZjNiP+WFCFA/zJztw5sruOWzpww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=pMHWumRV;
	arc=none smtp.remote-ip=209.127.231.112
Received: from va-2-112.ptr.blmpb.com (va-2-112.ptr.blmpb.com [209.127.231.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C1C606A32F
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 08:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34C1C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=pMHWumRV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1793955066; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=uw2jcbo2K94Ipub2qP4Q99pSQbMkC01ncZoy8NZ7ZtE=;
 b=pMHWumRVhWl4GHAnN6yT80KLFBGpb6m22a8eJbNtT5sdmnpKL3wWxYDoQDwXyY2A2+0LcV
 63jD/uHcCGmMI9Wa3pq/gm6tAVjluNzHAZAGagXngnSq4e2mzmwCcdVIzJYUPpXsTI+LXH
 t5lCCWMSrzMmMn5zfzRJmOmi3DmziRYoNh5iyMQ3o7zYTOjs2+lEDn/PTVz93jNcoNkvHC
 NlhCVjk+KMYjvyFCZsatD7P5zGEQdiuE8037hSvXfT0Hv7WeB1fgRujUWHhmDEzX+Ior6C
 QO545QQW2zxsRpJdCLRPsUIe89BUA2FFUOx1hY2bA3yCRdS5sBbSBPoWVVps8A==
To: <nhuhuan@google.com>
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v3 0/3] mm: use non-temporal stores for demotion
Content-Type: text/plain; charset=UTF-8
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26aed94f7+7c0e03+vger.kernel.org+lizhe.67@bytedance.com>
Cc: <Liam.Howlett@oracle.com>, <akpm@linux-foundation.org>, 
	<alirad.malek@zptcorp.com>, <anna@kernel.org>, <apopple@nvidia.com>, 
	<bharata@amd.com>, <bp@alien8.de>, <byungchul@sk.com>, 
	<dave.hansen@linux.intel.com>, <dave@stgolabs.net>, <david@kernel.org>, 
	<dimitrios.palyvos@zptcorp.com>, <fvdl@google.com>, <gourry@gourry.net>, 
	<hannes@cmpxchg.org>, <hpa@zytor.com>, <jackmanb@google.com>, 
	<jic23@kernel.org>, <joshua.hahnjy@gmail.com>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<linux-nfs@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>, 
	<ljs@kernel.org>, <mathieu.desnoyers@efficios.com>, 
	<matthew.brost@intel.com>, <mhiramat@kernel.org>, <mhocko@suse.com>, 
	<mingo@redhat.com>, <nifan.cxl@gmail.com>, <rakie.kim@sk.com>, 
	<rientjes@google.com>, <rkodsara@amd.com>, <rostedt@goodmis.org>, 
	<rppt@kernel.org>, <ryan.roberts@arm.com>, <shivankg@amd.com>, 
	<sj@kernel.org>, <surenb@google.com>, <tglx@kernel.org>, 
	<trondmy@kernel.org>, <vbabka@kernel.org>, <weixugc@google.com>, 
	<x86@kernel.org>, <xuezhengchu@huawei.com>, 
	<yiannis.nikolakop@gmail.com>, <yiannis@zptcorp.com>, 
	<ying.huang@linux.alibaba.com>, <ziy@nvidia.com>
Date: Fri,  6 Nov 2026 16:50:19 +0800
Message-Id: <20261106085019.90487-1-lizhe.67@bytedance.com>
In-Reply-To: <20261103223025.2482227-1-nhuhuan@google.com>
X-Mailer: git-send-email 2.45.2
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103223025.2482227-1-nhuhuan@google.com>

On Tue, 3 Nov 2026 14:30:22 -0800, Huan Nguyen wrote:

> Using non-temporal stores and prefetching on x86 bypasses CPU cache
> allocation, protecting active workload working sets and improving
> demotion throughput.

Could you show some real workload numbers for this? I am wondering
whether the reduced cache allocation and improved demotion throughput
also translate into visible application-level benefits.

> - Memory ordering:
>   Add a wmb() barrier at the end of folio_mc_copy_nt() to ensure weakly
>   ordered non-temporal stores are drained before page tables are updated.

I have not looked into all the details here, so I may be missing
something. But before migration completes, there should eventually be a
publication step that makes the new folio visible. In theory, that
publication step should already provide the required ordering before
userspace can observe the new folio. So I wonder whether the wmb() in
folio_mc_copy_nt() is really needed here.

Thanks,
Zhe
