Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3545F2D0C8C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708953; cv=none; b=hbst3V7YMLVDKr6KWDcyNf/xiTFjW77/xHLGWvvLCbDFDDAsw73Px2zU32CVGeh5lf1d3nit3dBdTfRrIXGgVg6ZSejnl7FhJCqIX63Mfp1CB91yBwIxrw20RQvNrkyAxJOKXApMQYvmLTahqYkI16gRPWY1ZD9O9fUJLPMNBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708953; c=relaxed/simple;
	bh=CQSOU4KL00u8OV+8r4IhIf0vi+CEPGM0Nhi//XT63Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obpCI4Jeb+vddEgRNJ01CDQA7H7ah1l6U0OxcbJ/cgSSeo4ikXaQpnLrY5DfDAxgb4RSClxIN3xFd6RpUEh6Mi6vwTQK6fUvCqZbYwKEkwGSgFKQ37Q3rEHwf/7JDyWpCEM19sbtp5sq6Mlrue5FWCjhOXd7LYcj0rYMQeCvrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D/xPblQf; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D/xPblQf"
Message-ID: <7f591ac9-d3e0-4404-987c-40eceaf51fbb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757708943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+gBOvo8OmvEt95Yti7QbgbFG8TM5E2PZ/ZvdEq9MnA=;
	b=D/xPblQfNNhgfqJE7DlAGb0gleV7x5OawFi5FATZtIVfVPoharw7ndWDbC2rfIGFXXUx14
	N58SZwUJXAvT+qCDcqA3FE+tj31zplmd0VKDWGrd95hEy4PtW5eNyZJExLI+R//BkmVLO1
	2t8cUqBrERzex7ltrNApX9vNMlB6AQw=
Date: Fri, 12 Sep 2025 13:28:55 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv3 perf/core 0/6] uprobe,bpf: Allow to change app registers
 from uprobe registers
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>
References: <20250909123857.315599-1-jolsa@kernel.org>
 <CAEf4Bzb4ErWn=2SajBcyJxqGEYy0DXmtWuXKLskPGLG-Y9POFA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4Bzb4ErWn=2SajBcyJxqGEYy0DXmtWuXKLskPGLG-Y9POFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/9/25 9:41 AM, Andrii Nakryiko wrote:
> On Tue, Sep 9, 2025 at 8:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>
>> hi,
>> we recently had several requests for tetragon to be able to change
>> user application function return value or divert its execution through
>> instruction pointer change.
>>
>> This patchset adds support for uprobe program to change app's registers
>> including instruction pointer.
>>
>> v3 changes:
>> - deny attach of kprobe,multi with kprobe_write_ctx set [Alexei]
>> - added more tests for denied kprobe attachment
>>
>> thanks,
>> jirka
>>
>>
>> ---
>> Jiri Olsa (6):
>>        bpf: Allow uprobe program to change context registers
>>        uprobe: Do not emulate/sstep original instruction when ip is changed
>>        selftests/bpf: Add uprobe context registers changes test
>>        selftests/bpf: Add uprobe context ip register change test
>>        selftests/bpf: Add kprobe write ctx attach test
>>        selftests/bpf: Add kprobe multi write ctx attach test
>>
> 
> For the series:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Question is which tree will this go through? Most changes are in BPF,
> so probably bpf-next, right?

Hi Jiri.

This series does not apply to current bpf-next, see below.

Could you please respin it with bpf-next tag?
E.g. "[PATCH v4 bpf-next 0/6] ..."

Thanks!

$ git log -1 --oneline
a578b54a8ad2 (HEAD -> master, origin/master, origin/HEAD, 
kernel-patches/bpf-next) Merge branch 
'bpf-report-arena-faults-to-bpf-streams'
$ b4 am 20250909123857.315599-1-jolsa@kernel.org
[...]
$ git am 
./v3_20250909_jolsa_uprobe_bpf_allow_to_change_app_registers_from_uprobe_registers.mbx
Applying: bpf: Allow uprobe program to change context registers
Applying: uprobe: Do not emulate/sstep original instruction when ip is 
changed
error: patch failed: kernel/events/uprobes.c:2768
error: kernel/events/uprobes.c: patch does not apply
Patch failed at 0002 uprobe: Do not emulate/sstep original instruction 
when ip is changed
[...]

> 
>>   include/linux/bpf.h                                        |   1 +
>>   kernel/events/core.c                                       |   4 +++
>>   kernel/events/uprobes.c                                    |   7 +++++
>>   kernel/trace/bpf_trace.c                                   |   7 +++--
>>   tools/testing/selftests/bpf/prog_tests/attach_probe.c      |  28 +++++++++++++++++
>>   tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c |  27 ++++++++++++++++
>>   tools/testing/selftests/bpf/prog_tests/uprobe.c            | 156 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   tools/testing/selftests/bpf/progs/kprobe_write_ctx.c       |  22 +++++++++++++
>>   tools/testing/selftests/bpf/progs/test_uprobe.c            |  38 +++++++++++++++++++++++
>>   9 files changed, 287 insertions(+), 3 deletions(-)
>>   create mode 100644 tools/testing/selftests/bpf/progs/kprobe_write_ctx.c

