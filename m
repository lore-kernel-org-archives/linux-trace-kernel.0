Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462146;
	b=lTZkNBbRVeUKCyZqo/YSa+TNY9uLQChc6WnFxgfuXP+GYCJG6LcK2aotA1Rooq2HoSsQ
	 //GsIF8HOIQ0O28z4sa+luAEGtllvJ7MgoUCINNckbv3Fd07URcPxZW45BKohWS8AcO9r
	 RXWz8VMBHz0mOVtJLBKNBgvZ5oPMHiXoVDXRvbs+XLUDBVDhzj3ujsvI1bDvG2e7elTzH
	 qrkyr0k7YVMar8dPK+P4h+YXAhkVbT1koE6QeOBZncVhoBnztdgCLh22T5uvFEUnjFXeH
	 URyrVhOBOkADoFt//DswW99WaS1+PLM/l227cxp0HNUNVjhOq9tONQJU60RoPDkrCBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462146;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=TeZxHpGh3vWRRTaeJFYcxVxI1elb8LVFe44ig17WH2E=;
	b=HngU5KL8FatzZmWMRk1elWR/rA22UkRQUFxFDFzBaGvCjCsJnXl/uvMMvDdotsu5iCM0
	 5IoXT6jSGpkmYuGtRoV05R6oJt5VpW5SPqzifuF8OwFC+sX4GCHb6HUCxor7D9U5t9Pv7
	 tgq6kQb4ybPtYxlZNCxM4GI0UMXNoV0Q5Yfq1BIPnoXjuNz/qxGvCU2P+dtqjGLrzWMX7
	 PM3H0miH2reHWpeDjB8mLAbtvhB3d2Y8HvB9keWRFq2kkb2EIJ253D+zZSFiBXYQBIKG5
	 VPYbfhl1JqaairEqM4t/+aT5u46SPwlRDpPz4Xquc3Et7UxMgk++fRDKmpYzyNBA9Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12148606A319;
	Tue, 20 Oct 2026 02:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12148606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 336331fccc2b11f19a56ed5b684f684d-20261020
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:9bb30357-dc27-4730-a0a6-f1b93114ffbd,IP:0,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:2
X-CID-META: VersionHash:7db8b62,CLOUDID:ce2317bdb65c040030a3bf03e4371919,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|865|898,TC:nil,Content:4|15|50|99,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 336331fccc2b11f19a56ed5b684f684d-20261020
X-User: tianyaxiong@kylinos.cn
Received: from [10.42.13.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1420643749; Tue, 20 Oct 2026 10:08:54 +0800
Message-ID: <be63bc89-0a3a-4617-af78-587f8746f0f7@kylinos.cn>
Date: Tue, 20 Oct 2026 10:08:51 +0800
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ftrace: speed up module enable by binary searching
 module symbols
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260916082715.320853-1-tianyaxiong@kylinos.cn>
 <undine-1792423513137811483-832e0e20f49f84bd@undined.local>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <undine-1792423513137811483-832e0e20f49f84bd@undined.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2026/10/19 23:25, Masami Hiramatsu (Google) wrote:
> Hi,
>
> On Wed, 16 Sep 2026 16:27:15 +0800, Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:
>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -8010,11 +8011,137 @@ void ftrace_release_mod(struct module *mod)
>> +
>> +	/* mod->kallsyms is not replaced until do_init_module() returns. */
>> +	rcu_read_lock();
>> +	kallsyms = rcu_dereference(mod->kallsyms);
> Consider using rcu_access_pointer(mod->kallsyms) or
> rcu_dereference_raw(mod->kallsyms) rather than a transient
> rcu_read_lock()/rcu_read_unlock() pair.
Agreed, I will use rcu_dereference_raw() and drop the lock pair.

>> +	rcu_read_unlock();
>> +
>> +	if (!kallsyms || kallsyms->num_symtab < 2)
>> [...]
>> +	 * ftrace never came up, where the loop below would not run anyway; that
>> +	 * also makes reading ftrace_disabled without the lock safe.
>> +	 */
>> +	syms = ftrace_disabled ? NULL : ftrace_mod_syms_alloc(mod);
> Because ftrace_disabled is one-way flag, if you find ftrace_disabled here,
> you can return from this function soon.
>
> Thanks,
Right. I will check it once before the allocation and jump to a common
out_cached_mods label, so ftrace_lock is not taken at all in that case and
process_cached_mods() still runs exactly once. I keep the second check
under the lock because ftrace_kill() can set the flag after the unlocked
read.

    if (ftrace_disabled)
        goto out_cached_mods;

    syms = ftrace_mod_syms_alloc(mod);

    mutex_lock(&ftrace_lock);

    if (ftrace_disabled)
        goto out_unlock;
    ...
 out_unlock:
    mutex_unlock(&ftrace_lock);
    kvfree(syms);
 out_cached_mods:
    process_cached_mods(mod->name);

>> +
>>  	mutex_lock(&ftrace_lock);
>>  
