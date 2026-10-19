Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0E918FC97;
	Mon, 19 Oct 2026 01:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792371994; cv=none; b=CDsJrgy7LnBhs/sKkbEWP6m4fEXezTjgFbsnVfpxO++LDhRTp57Fj7A4x2jwkeEQuh9XDFlQgqcrkXf7lHH/qD5RJZMLa1CYxymh2SsAMGC6dQ7T+at7SFdhQ8nN+Wzw3tI4nRTLM0H4vaIZZGyYTyAGCxBnnH+JkyRnyCkiTf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792371994; c=relaxed/simple;
	bh=UU6aloxqeOHtF+nhBqz9yTTb6H1s5ivUFGXPz+J1fLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s77ulPQtkVhXD39x7BxsKOrIq6uc05N1YFsgLCbNLHgvsxB+6YXq41jwTHIajxIlkgXGKfkiGXn6Vxda8aEkKfQSQLhQSFqmfERRmBD4ltDiNrzLGyUOHiXwXkKATGAH0VLNaXmbqP6ZgdCSzU1mWyqTB21tdnY99UZ2cAu7jKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4aeec5fccb5911f19a56ed5b684f684d-20261019
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:41113f68-e5d4-4e63-949b-ba23bace2cd0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:5675c162610e92e99f3843e3d46b28a2,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0|15|50|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4aeec5fccb5911f19a56ed5b684f684d-20261019
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 296505823; Mon, 19 Oct 2026 09:06:19 +0800
Message-ID: <5deadb6b-8422-4adb-997b-96c2ddddcb9e@kylinos.cn>
Date: Mon, 19 Oct 2026 09:06:16 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ftrace: speed up module enable by binary searching
 module symbols
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260916082715.320853-1-tianyaxiong@kylinos.cn>
 <20261016140701.0756b893@gandalf.local.home>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <20261016140701.0756b893@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2026/10/17 02:07, Steven Rostedt wrote:
> On Wed, 16 Sep 2026 16:27:15 +0800
> Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
>
> Hi Yaxiong,
>
> I've been traveling since September 14th to October 10th and my backlog is
> very long. Unfortunately, I will not be able to look at this patch until
> after the merge window. But it is not forgotten, just postponed.
>
> -- Steve
>
Thanks for letting me know — completely understandable. No rush; I'll
wait until after the merge window. Looking forward to your feedback when
you get to it.


>
>> Loading a module with many functions takes seconds, almost all of it in
>> ftrace_module_enable().  amdgpu modules stall for about ten seconds, and
>> disabling CONFIG_DYNAMIC_FTRACE makes the stall disappear.
>>
>> Every record is validated by test_for_valid_rec(), which resolves its ip
>> through kallsyms_lookup(); for a module address that ends up in
>> find_kallsyms_symbol(), which walks the whole module symbol table from
>> index 1.  The core kernel instead binary searches its sorted kallsyms
>> table in get_symbol_pos().  So only modules pay, and the cost is
>> quadratic: both the record count and the symbol count grow with the
>> module.  An amdgpu.ko from this tree has 17282 records and 55332 symbol
>> table entries.
>>
>> Fix this by collecting the addresses of a module's symbols once, sorting
>> them, and binary searching that array instead of walking the table once
>> per record; a loaded module's symbol table cannot change, so the array
>> stays valid for the whole pass.  What comes back is what the linear scan
>> returned: the same entries are skipped - SHN_UNDEF, unnamed and mapping
>> symbols - and the closest address not below the base of the record's
>> memory region is taken.  Whenever the array cannot answer, because it
>> could not be built or because no such symbol exists, the record is handed
>> to test_for_valid_rec(), so the rest of kallsyms_lookup() still has its
>> say and no verdict can change.
>>
>> On the machine that reported the stall, modprobe of that amdgpu.ko takes
>> 12.242 s before and 2.870 s after, and the time spent inside ftrace_lock
>> drops from 9.368 s to 1.585 ms - 15.195 ms if the price of building the
>> array is included, that build being 13.6 ms, 0.15% of the 9.37 s saved.
>> The array costs O(symbols * log symbols), it does not grow with the
>> record count.  Across the 74 modules loaded at boot, total lock time
>> drops from 491 ms to 2.33 ms.
>>
>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
