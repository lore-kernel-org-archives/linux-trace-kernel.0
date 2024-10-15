Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A557A189BB2;
	Tue, 15 Oct 2024 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990585; cv=none; b=P8KY7OXuAImGCrnHL2np8qRhkiTeRWiXlJPNEzBHozR2a8T52je5jfhXESJ08d5pAER3kJOQZVl+KBhcMTuJyczPOznob016EuOxD5ZAVgOhc/rmxiDoUgDdfVn8p6tkLvlp62KDLDUynOrtCzhpFVeT066l6o8tj7jMxYwCnlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990585; c=relaxed/simple;
	bh=tXPO7KmjdcWYool96chGvBJ0Wdccziar2tj15Bs1opo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpepYUxK0M0FlRluwu+JY4FZiinohuatOJEGWGcuSW1EnTbF2U4+n0FbY03QCRGUIt2Y+IFzGta/digB94v6jDzuBuVav2NhNYyGsFWZfiCP1T7WYkbCMDCXy5UmkDJa9K7UXpiSJZGDWHml0+mPE1ClbPHA/so04L6pbo2PxE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60B211007;
	Tue, 15 Oct 2024 04:10:12 -0700 (PDT)
Received: from [10.57.86.207] (unknown [10.57.86.207])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE1ED3F51B;
	Tue, 15 Oct 2024 04:09:39 -0700 (PDT)
Message-ID: <e5067bb8-0fcd-4739-9bca-0e872037d5a1@arm.com>
Date: Tue, 15 Oct 2024 12:09:38 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 18/57] trace: Remove PAGE_SIZE compile-time
 constant assumption
Content-Language: en-GB
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Matthias Brugger <mbrugger@suse.com>, Miroslav Benes <mbenes@suse.cz>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-18-ryan.roberts@arm.com>
 <20241014124656.3ffb0f65@gandalf.local.home>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241014124656.3ffb0f65@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2024 17:46, Steven Rostedt wrote:
> On Mon, 14 Oct 2024 11:58:25 +0100
> Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> To prepare for supporting boot-time page size selection, refactor code
>> to remove assumptions about PAGE_SIZE being compile-time constant. Code
>> intended to be equivalent when compile-time page size is active.
>>
>> Convert BUILD_BUG_ON() BUG_ON() since the argument depends on PAGE_SIZE
>> and its not trivial to test against a page size limit.
>>
>> Redefine FTRACE_KSTACK_ENTRIES so that "struct ftrace_stacks" is always
>> sized at 32K for 64-bit and 16K for 32-bit. It was previously defined in
>> terms of PAGE_SIZE (and worked out at the quoted sizes for a 4K page
>> size). But for 64K pages, the size expanded to 512K. Given the ftrace
>> stacks should be invariant to page size, this seemed like a waste. As a
>> side effect, it removes the PAGE_SIZE compile-time constant assumption
>> from this code.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>
>> ***NOTE***
>> Any confused maintainers may want to read the cover note here for context:
>> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
>>
>>  kernel/trace/fgraph.c | 2 +-
>>  kernel/trace/trace.c  | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
>> index d7d4fb403f6f0..47aa5c8d8090e 100644
>> --- a/kernel/trace/fgraph.c
>> +++ b/kernel/trace/fgraph.c
>> @@ -534,7 +534,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
>>  	if (!current->ret_stack)
>>  		return -EBUSY;
>>  
>> -	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
>> +	BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
> 
> Absolutely not!
> 
> BUG_ON() is in no way a substitution of any BUILD_BUG_ON(). BUILD_BUG_ON()
> is a non intrusive way to see if something isn't lined up correctly, and
> can fix it before you execute any code. BUG_ON() is the most intrusive way
> to say something is wrong and you crash the system.

Yep, totally agree. I'm afraid this was me being lazy, and there are a couple of
other instances where I have done this in other patches that I'll need to fix.
Most of the time, I've been able to keep BUILD_BUG_ON() and simply compare
against a page size limit.

Looking at this again, perhaps the better solution is to define
SHADOW_STACK_SIZE as PAGE_SIZE_MIN? Then it remains a compile-time constant. Is
there any need for SHADOW_STACK_SIZE to increase with page size?

> 
> Not to mention, when function graph tracing is enabled, this gets triggered
> for *every* function call! So I do not want any runtime test done. Every
> nanosecond counts in this code path.
> 
> If anything, this needs to be moved to initialization and checked once, if
> it fails, gives a WARN_ON() and disables function graph tracing.

I'm hoping my suggestion above to decouple SHADOW_STACK_SIZE from PAGE_SIZE is
acceptable and simpler? If not, happy to do as you suggest here.

Thanks,
Ryan

> 
> -- Steve
> 
> 
>>  
>>  	/* Set val to "reserved" with the delta to the new fgraph frame */
>>  	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index c3b2c7dfadef1..0f2ec3d30579f 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -2887,7 +2887,7 @@ trace_function(struct trace_array *tr, unsigned long ip, unsigned long
>>  /* Allow 4 levels of nesting: normal, softirq, irq, NMI */
>>  #define FTRACE_KSTACK_NESTING	4
>>  
>> -#define FTRACE_KSTACK_ENTRIES	(PAGE_SIZE / FTRACE_KSTACK_NESTING)
>> +#define FTRACE_KSTACK_ENTRIES	(SZ_4K / FTRACE_KSTACK_NESTING)
>>  
>>  struct ftrace_stack {
>>  	unsigned long		calls[FTRACE_KSTACK_ENTRIES];
> 

