Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A6D134CF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784515171; cv=none; b=YHH8mfwUHcllJtchgWE1LQjYRaIVHAiifCrGGcXmF98rqha8J0CS+Yhkl+iHJfvwNlW7vQrW3RKq3Otf0Css2XG6EpY06NsNtFOO5JM8nHZ+9lC6Cj332arzjn1VqUIDKaA1xpQIaTVijXQe61dTRpU+ezPY98r6PS9Cr8DVWD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784515171; c=relaxed/simple;
	bh=QJ3mHYCtSXsn6Mmy+Tpar/Uuv/hEseZbLgDW2q/++fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmmL+5oUMSsKRV+OtB3hKMtCKDBoBXkvo2wMjHH0ZtT/NNuGMz2nQSoMlIiaqBROI6EJ8KvPLSXEHaAgEpq+lt0BCz8utF8UU/brXYp+R0mvVH4K3kJzM5q0Z1XtJ8ojEoCJC87MFSB3IQ8mox0wfBxDmyVjkSXbcTXEIAzqYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jRIcjr/U; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jRIcjr/U"
Message-ID: <89050232-0371-48af-9a3c-a9ab2b535c15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784515167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRngtLPWkQ7+WF5w95aCgY6CpKHiVyh4kOZhXjYGgs0=;
	b=jRIcjr/UmTbgoPYTP9G2unjyvVNk+HGHShAGAuNuOPyqToAyb9ldEWWyq4pfmd+fR6DW51
	dEse5qnVORb02DfEWKNr2UTDHSh/ghhY1n3EoY0+ncdCU42WtKV0oGKhD7NuncMfpTZKn9
	gm+lvAChMqskhcRk/4Xk5eHb8askwK8=
Date: Mon, 20 Jul 2026 10:39:17 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 2/9] mm/page_owner: add MR_NEVER to enum migrate_reason
 and use it for last_migrate_reason
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Kieran Bingham <kbingham@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260714015117.78351-1-ye.liu@linux.dev>
 <20260714015117.78351-3-ye.liu@linux.dev>
 <9e0db1c2-06ca-4dba-8fb1-552fab91cb02@kernel.org>
 <037d58c6-de55-4b69-bb71-905e03985657@kernel.org>
 <9e9345c8-30a4-4f78-ba55-d7fa073b82d5@kernel.org>
 <2911979b-193c-4cbc-85ed-f1d04a9977f0@kernel.org>
 <86ce288c-f82f-4d73-ba51-4d4f4a6ef1e6@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <86ce288c-f82f-4d73-ba51-4d4f4a6ef1e6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/7/14 22:44, David Hildenbrand (Arm) 写道:
> On 7/14/26 15:49, Vlastimil Babka (SUSE) wrote:
>> On 7/14/26 15:22, David Hildenbrand (Arm) wrote:
>>> On 7/14/26 15:09, Vlastimil Babka (SUSE) wrote:
>>>>
>>>> It's not used ever as a reason that would be actually passed to migration.
>>>
>>> Right, it's a placeholder for "there is no migrate reason because it is unset"
>>>
>>>> So I think the name is more descriptive this way.
>>>
>>> Not sure I agree. The usual translation of -1 -> unset is NONE or UNSET.
>>
>> (note it's no longer -1 after the patch.)
>>
>>> At least I was confused by "NEVER".
>>
>> I won't bikeshed this, so whatever.
> 
> Just to be clear: if everybody here agrees that MR_NEVER is the right thing to
> use, fine with me.
> 
> I just stumbled over it and it caught my attention.
> 
>>
>> Just to avoid another extra respin, please also say how the following line
>> should change, as if we only rename MR_NEVER to MR_NONE, it will be:
>>
>> +	EMe(MR_NONE,		"never_migrated")
> 
> I would probably just have use "not set".
> 
> And if "last_migrate_reason == MR_NONE" that would imply "never".
> 
> Ye Liu, feel free to keep it as is if you agree that using NEVER is better here.
> 
> 
Let's keep things as they are.

-- 
Thanks,
Ye Liu

