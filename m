Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E432B2EC560
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772737221; cv=none; b=IZBIddpMRjiRUCNQz0AUqiCLyr2/Lfqw+0rNfp9q38RzeHjKoAjUCKatAyDe5W2Wp8RgBUXIdw/vayh9Dx8bRRfENLhszAeGIMv5bIXk+fTQuwgJffWJqdcjkmZiYBGGEWKM6jHH0/T/B2S5gq0faPWH3eswePqEiQ/1GyfniFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772737221; c=relaxed/simple;
	bh=kXAItG71XvY4d9Pl7iswIgW8t3fyXQmAH7EftQTPxsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAQ1engcQDWNYk/k627LYk8n+Itby9L9pXRnTgyL+kgSReouf5zhUT49+E9fZqIoQ6CCEd/4FZu5xJgMkxH9MLcj3HvVFDJ/60XlYJpkDi13Csy+3Eg5BXiWgTh3JHX/x23WRBbS+NEA7FkIFFUZdSptJZk6pmzvUTlpbyF8sA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4WxZt0i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4WxZt0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772737219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aR5ra7UnNvsZdQxAhgAUxS4DtQm3eiNJ91FDQLXcpd4=;
	b=K4WxZt0iKloYiQgm2ZqVztB6cFEqJ5xJCzuZdZcCqspQZBq3lbg0Ut2dlw3c8GpR68e7pz
	ncuWrosFnQb5clL4rt//CiP5W/PjxowbJWXaL/UN8MQebD3z1aAU+fOi4734qoN0eT3IHL
	XeveWP2hwfZj35j9jtnCaQUuWOtmxLI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-6lxmoy2dNYiChAseosEaAA-1; Thu,
 05 Mar 2026 14:00:13 -0500
X-MC-Unique: 6lxmoy2dNYiChAseosEaAA-1
X-Mimecast-MFC-AGG-ID: 6lxmoy2dNYiChAseosEaAA_1772737211
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 597CF18005BA;
	Thu,  5 Mar 2026 19:00:11 +0000 (UTC)
Received: from [10.22.88.171] (unknown [10.22.88.171])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD839180049D;
	Thu,  5 Mar 2026 19:00:08 +0000 (UTC)
Message-ID: <d161ea96-8023-4a5e-a4eb-3e17780c8308@redhat.com>
Date: Thu, 5 Mar 2026 14:00:08 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: David Laight <david.laight.linux@gmail.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260304074650.58165-1-laoar.shao@gmail.com>
 <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net>
 <20260304095415.4d5f2528@pumpkin>
 <20260304155742.7b4de2d1@gandalf.local.home>
 <20260304214447.3e5817ea@pumpkin>
 <CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
 <20260304212802.458b878e@fedora>
 <CALOAHbBA643_QOsnTmrfjKE71hSa+v1cToiELvGk+vjtcgJsxg@mail.gmail.com>
 <20260304220019.3efa12ab@robin>
 <CALOAHbA4Dtc3cXs2JiQ=kxES3kT+Acb=amUxkOvQ22fns-Mqgw@mail.gmail.com>
 <748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com>
 <20260305093254.61facfb6@pumpkin>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260305093254.61facfb6@pumpkin>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: do858TXJXCijfl3cGlErFolKAoG48eOE2UBzWgFVZlc_1772737211
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/5/26 4:32 AM, David Laight wrote:
> On Wed, 4 Mar 2026 23:30:40 -0500
> Waiman Long <longman@redhat.com> wrote:
>
>> On 3/4/26 10:08 PM, Yafang Shao wrote:
>>> On Thu, Mar 5, 2026 at 11:00 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>>> On Thu, 5 Mar 2026 10:33:00 +0800
>>>> Yafang Shao <laoar.shao@gmail.com> wrote:
>>>>   
>>>>> Other tools may also read available_filter_functions, requiring each
>>>>> one to be patched individually to avoid this flaw—a clearly
>>>>> impractical solution.
>>>> What exactly is the issue?
>>> It makes no sense to spin unnecessarily when it can be avoided. We
>>> continuously improve the kernel to do the right thing—and unnecessary
>>> spinning is certainly not the right thing.
>>>   
>>>> If a task does a while 1 in user space, it
>>>> wouldn't be much different.
>>> The while loop in user space performs actual work, whereas useless
>>> spinning does nothing but burn CPU cycles. My point is simple: if this
>>> unnecessary spinning isn't already considered an issue, it should
>>> be—it's something that clearly needs improvement.
>> The whole point of optimistic spinning is to reduce the lock acquisition
>> latency. If the waiter sleeps, the unlock operation will have to wake up
>> the waiter which can have a variable latency depending on how busy the
>> system is at the time. Yes, it is burning CPU cycles while spinning,
>> Most workloads will gain performance with this optimistic spinning
>> feature. You do have a point that for system monitoring tools that
>> observe the system behavior, they shouldn't burn that much CPU times
>> that affect performance of real workload that the tools are monitoring.
>>
>> BTW, you should expand the commit log of patch 1 to include the
>> rationale of why we should add this feature to mutex as the information
>> in the cover letter won't get included in the git log if this patch
>> series is merged. You should also elaborate in comment on under what
>> conditions should this this new mutex API be used.
> Isn't changing mutex_lock() the wrong place anyway?
> What you need is for the code holding the lock to indicate that
> it isn't worth waiters spinning because the lock will be held
> for a long time.

I have actually thought about having a flag somewhere in the mutex 
itself to indicate that optimistic spinning isn't needed. However the 
owner field is running out of usable flag bits. The other option is to 
add it to osq as it doesn't really need to use the full 32 bits for the 
tail. In this case, we can just initialize the mutex to say that we 
don't need optimistic spinning and no new mutex_lock() API will be needed.

Cheers,
Longman

