Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A3C1EF09B;
	Fri, 13 Jun 2025 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749782280; cv=none; b=hQJNEY7i8UMQAE99jqKTzjM8+3poReAnV4CSL8G2D1EV1R2FnNpq8cVbvlDWtfXzNc9sB06dB1Vm3lvMqEjq5tNPkFYrIXvPhsNy9BacfCeZrmt9VQHFrPoXHunFfmKAefiAQhn3RO6l1HZy3tG/UF2AYakn9jibaWMArP2vons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749782280; c=relaxed/simple;
	bh=rLyoFCsONdMg1X5FWeZBMkMcATeLGJmZZ6dsAOCgWIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqG+tJFTSwyUscNKv7EihmB6bUw8lBZNMwDjGx0tzC0fShppdisiv86y3gCat8lTjkoqvnBwLnDYICXFPbY5b4LCb84RCzYKBV9rSWnDzOc7wKebyvxedVAeFVgsdi7Oo+juQv0PmnDpJYE9c6iDdw36Qdw71KoqVb0T+z9LGPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aCp9rHNO; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aCp9rHNO"
Message-ID: <6d0e5cd2-bb4e-45af-bf85-0b95d5d2ac18@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749782267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEexevjYeaESnUVPiOmfuE919TTbWUklAG5JrE9vJ2w=;
	b=aCp9rHNOudNL6WYLZrNQ5r4O7uk5JxlBhUWc/+JWs87qA62V+2p9z1u6MEheu/KcEneWfZ
	gXo2AIF3zlKmxaFA63HeEgSr8J+06PR4MvUeihuqI3KZUYZY9NR0rrPaP4C0PIs5MbMXgv
	unocSTYKHj52/jJraQKUoS6r1rUJOGw=
Date: Fri, 13 Jun 2025 10:37:38 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: clear user buf when bpf_d_path failed
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <20250611154859.259682-1-chen.dylane@linux.dev>
 <CAEf4Bzbn=RVhMOR7RapYwi+s8gbVS=1msOuZ7MhPvgz8zHiE9w@mail.gmail.com>
 <CAADnVQJ8cVi4KyJqWgEfyWYs+zSYQ73PevrNszPkisrdPSjYMg@mail.gmail.com>
 <CAEf4BzayBd9e5c9fiEPgDKPoRm-E4uB_u__xKcRpXDz18kNnkA@mail.gmail.com>
 <CAADnVQKw2u9y-Cf+8idB0bZ0v-p6BtuyRV=JpmN4to3_1Z6GEA@mail.gmail.com>
 <CAEf4BzbScdvawnTZ7364bXxU2QpW_ooCB-tjohBgC4WSvFigFg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzbScdvawnTZ7364bXxU2QpW_ooCB-tjohBgC4WSvFigFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/13 08:06, Andrii Nakryiko 写道:
> On Thu, Jun 12, 2025 at 4:56 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Thu, Jun 12, 2025 at 4:27 PM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>>>
>>> On Thu, Jun 12, 2025 at 2:40 PM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>>> On Thu, Jun 12, 2025 at 2:29 PM Andrii Nakryiko
>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>>
>>>>> On Wed, Jun 11, 2025 at 8:49 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>>>>>
>>>>>> The bpf_d_path() function may fail. If it does,
>>>>>> clear the user buf, like bpf_probe_read etc.
>>>>>>
>>>>>
>>>>> But that doesn't mean we *have to* do memset(0) for bpf_d_path(),
>>>>> though. Especially given that path buffer can be pretty large (4KB).
>>>>>
>>>>> Is there an issue you are trying to address with this, or is it more
>>>>> of a consistency clean up? Note, that more or less recently we made
>>>>> this zero filling behavior an option with an extra flag
>>>>> (BPF_F_PAD_ZEROS) for newer APIs. And if anything, bpf_d_path() is
>>>>> more akin to variable-sized string probing APIs rather than
>>>>> fixed-sized bpf_probe_read* family.
>>>>
>>>> All old helpers had this BPF_F_PAD_ZEROS behavior
>>>> (or rather should have had).
>>>> So it makes sense to zero in this helper too for consistency.
>>>> I don't share performance concerns. This is an error path.
>>>
>>> It's just a bizarre behavior as it stands right now.
>>>
>>> On error, you'll have a zeroed out buffer, OK, good so far.
>>>
>>> On success, though, you'll have a buffer where first N bytes are
>>> filled out with good path information, but then the last sizeof(buf) -
>>> N bytes would be, effectively, garbage.
>>>
>>> All in all, you can't use that buffer as a key for hashmap looking
>>> (because of leftover non-zeroed bytes at the end), yet on error we
>>> still zero out bytes for no apparently useful reason.
>>>
>>> And then for the bpf_path_d_path(). What do we do about that one? It
>>> doesn't have zeroing out either in the error path, nor in the success
>>> path. So just more inconsistency all around.
>>
>> Consistency with bpf_path_d_path() kfunc is indeed missing.
>>
>> Ok, since you insist, dropped this patch, and force pushed.
> 
> Great, thank you!

The changes in this patch are relatively simple, but the discussion 
between the two of you is more meaningful to me. I agree with Andrii's 
point of view. Thank you both for discussing this patch.

-- 
Best Regards
Tao Chen
