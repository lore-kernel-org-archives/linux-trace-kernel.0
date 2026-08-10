Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D9B39A7EA;
	Mon, 10 Aug 2026 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786344709; cv=none; b=SDdmqdXvHucIkAmpBY+JXtCzE97GZhzrCcVBthXWK1Ahi1fUTCeW4UwbmCRSM4XzaV+2uikSogakE9pHO6OXInKZNYP9ifOcWyezlbn/UiOjYnFp9Yn6asLHVs0HI+IoHJlbkyAonps396VCMa6XWtf01+VygHtowAVwh/F/GHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786344709; c=relaxed/simple;
	bh=ziVRFfTpFp6xHkgzzUxBn8M68gzyYX6a7DU4a586gPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDowNUXl5vApLYCQ88Vt18DWz/J5T9n3DDQ3t9gIpieZ3T/wAXgUcnCBW1iWKxM00flyXmdOqrH8iiFwENLhEnggpsEUnGXHzZx3xd8Mr9pqA2KLUqQk8AVNzYPKH4VVdgG2OjaeAtHE9j3BF5FVOfMf30KN3EKa44n+ZshIhwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com; spf=pass smtp.mailfrom=allwinnertech.com; arc=none smtp.client-ip=115.124.28.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=allwinnertech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allwinnertech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07548673|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.211983-0.121791-0.666227;FP=13040524414027417438|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.iiG3OqR_1786344692;
Received: from 192.168.208.183(mailfrom:michael@allwinnertech.com fp:SMTPD_---.iiG3OqR_1786344692 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 10 Aug 2026 14:51:33 +0800
Message-ID: <5257e858-f61a-2276-8d38-ddf7428f2c3a@allwinnertech.com>
Date: Mon, 10 Aug 2026 14:51:32 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4] tracing: Fix race between update_event_fields and,
 event_define_fields
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <6c515e5f-66f4-0dc7-00f2-69f319c8ad87@allwinnertech.com>
 <20260808220349.0a326dd1@robin>
From: Michael Wu <michael@allwinnertech.com>
In-Reply-To: <20260808220349.0a326dd1@robin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 9 Aug 2026 02:03:00 +0000, Steven Rostedt <rostedt@goodmis.org> wrote:
> The above description is way too verbose. What exactly is the race?
>
> I already tested it but when I went to write the log for Linus, I
> realized this description isn't acceptable for the commit itself.

Apologies for that. You are right, the commit message was indeed too
verbose. I have rewritten it to be concise and to the point — just
describing the actual race. The fix itself is unchanged.

v5 is now available at:
  https://patchwork.kernel.org/project/linux-trace-kernel/patch/2e5730d2-c631-da41-3a3a-ae35bb4895f3@allwinnertech.com/

On 8/9/2026 10:03 AM, Steven Rostedt wrote:
> On Mon, 3 Aug 2026 17:40:55 +0800
> Michael Wu <michael@allwinnertech.com> wrote:
> 
>> event_define_fields() (pri=1 MODULE_STATE_COMING notifier, locked by
>> event_mutex) populates class->fields via list_add(), while
>> update_event_fields() (called from the pri=0 notifier path via
>> trace_event_update_all) traverses class->fields protected only by
>> trace_event_sem.  These are two different locks guarding the same
>> data structure, so during cross-module loading a reader on one CPU can
>> observe partially initialized list nodes being concurrently added by a
>> writer on another CPU.
>>
>> On arm64 with weak memory ordering, __list_add() writes to two
>> different cache lines:
>>
>>         next->prev = new;                // (1) ordinary store
>>         new->next = next;                // (2) ordinary store
>>         new->prev = prev;                // (3) ordinary store
>>         WRITE_ONCE(prev->next, new);    // (4) release store
>>
>> The store buffer can drain (2) and (4) independently since they target
>> different cache lines.  A remote CPU may observe (4) before (2): it
>> sees prev->next pointing to the new node, but the new node's link.next
>> is still zero (kmem_cache_alloc zero-initialized via KMEM_CACHE with
>> SLAB_PANIC).  Since offsetof(struct ftrace_event_field, link) == 0,
>> list_for_each_entry() derives field == NULL from link.next == 0 and
>> crashes at field->type (offset 0x18):
> 
> The above description is way too verbose. What exactly is the race?
> 
> Was the above written by AI? It looks like it .
> 
> I already tested it but when I went to write the log for Linus, I
> realized this description isn't acceptable for the commit itself.
> 
> -- Steve


-- 
Regards,
Michael Wu
