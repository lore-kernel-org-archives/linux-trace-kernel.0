Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1985829ACE6;
	Wed,  6 Aug 2025 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498564; cv=none; b=BYiELL4TKptHOBRCZ8URnCgJ+oYt6pPwqbhYDuHDX3S1OEcbHNQLpXMweHqTAM6OdMYIxOLl5X6OFBWCxvxfflMeFCdxpCKzw32DlloEbSh8NQHBenxWTCVHrAv6f8vmDSZB+SUj6maKqU8Cipjoe4DW8BYvQrGhpOQBZYT++ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498564; c=relaxed/simple;
	bh=nUNJ9101wu7DrNaDZmnYe7+I579EKK12FrDCjyKszR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bw4oYI1wgIfv8Cfx/wpraATMYjKrfvB6jEiR8LqEsYynBF/N6MPCDfL7QxwUi2LZeSica58pMqbUcbdXgl174wdbunsvF2QfgXVRnrykSn/bBEdCLnio23uaCcdVX+ZauMPco1KcWjBwKuOIhbukFKVvO3tUuCrBuG5mqPWn6oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D9D6176C;
	Wed,  6 Aug 2025 09:42:34 -0700 (PDT)
Received: from [192.168.1.127] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FC983F738;
	Wed,  6 Aug 2025 09:42:39 -0700 (PDT)
Message-ID: <8ec3ecea-a830-4de2-8191-e3a78b4427f0@arm.com>
Date: Wed, 6 Aug 2025 17:42:38 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] tracing: Have syscall trace events show "0x" for
 values greater than 10
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>,
 aahringo@redhat.com
References: <20250805192646.328291790@kernel.org>
 <20250805193234.915257520@kernel.org>
 <c4f1b8d4-774f-42c1-a828-42c79756503d@arm.com>
 <20250806083944.036de894@batman.local.home>
Content-Language: en-US
From: Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20250806083944.036de894@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06-08-2025 13:39, Steven Rostedt wrote:
> On Wed, 6 Aug 2025 11:24:33 +0100
> Douglas Raillard <douglas.raillard@arm.com> wrote:
> 
>> On 05-08-2025 20:26, Steven Rostedt wrote:
>>> From: Steven Rostedt <rostedt@goodmis.org>
>>>
>>> Currently the syscall trace events show each value as hexadecimal, but
>>> without adding "0x" it can be confusing:
>>>
>>>      sys_write(fd: 4, buf: 0x55c4a1fa9270, count: 44)
>>>
>>> Looks like the above write wrote 44 bytes, when in reality it wrote 68
>>> bytes.
>>>
>>> Add a "0x" for all values greater or equal to 10 to remove the ambiguity.
>>> For values less than 10, leave off the "0x" as that just adds noise to the
>>> output.
>>
>> I'm on the fence for the value-dependent format. This looks like
>> it could easily make life harder for quick&dirty scripts, but then both
>> awk's strtonum() and Python's int(x, base=16) seem to handle
>> the presence/absence of the 0x prefix so maybe it's a non-issue.
> 
> Yes, but the trace file is more for humans than scripts, and the 0x1 is
> just noise.
> 
>>
>> OTH, a hand-crafted regex designed after a small set of input may start
>> to randomly fail if one field unexpectedly goes beyond 10 ...
> 
> If you are doing hand crafted scripts, I'd suggest to use tracing
> filters or other tooling that can handle this easily ;-)

Well, we both know I don't do this sort of things (or do I ? :) ) but for
the first 5+ years of its existence, LISA was actually parsing the text
output of trace-cmd, and I'd be surprised if it was the only place this was done.

AFAIK to this day, there is no tool providing a simple script/SQL interface
to a trace.dat file beyond basic filtering like trace-cmd report. I've had this
PR [1] opened for a while in LISA that does exactly that but got distracted with
other things:

   # Show all the CPUs that emitted a cpu_frequency event
   lisa-trace sql trace.dat --query 'SELECT DISTINCT cpu_id FROM cpu_frequency'

   shape: (8, 1)
   ┌────────┐
   │ cpu_id │
   │ ---    │
   │ u32    │
   ╞════════╡
   │ 0      │
   │ 1      │
   │ 2      │
   │ 3      │
   │ 7      │
   │ 4      │
   │ 5      │
   │ 6      │
   └────────┘


[1] https://gitlab.arm.com/tooling/lisa/-/merge_requests/2444

> 
>>
>> Just using explicit hex may be the best here, as the actual proper fix
>> (type-level display hints) is harder. It could probably be implemented
>> using btf_decl_tag() and __builtin_btf_type_id() to retrieve the BTF info.
> 
> That would add a dependency on BTF, which I would like to avoid.
> 
> Thanks!
> 
> -- Steve
> 

--
Douglas
