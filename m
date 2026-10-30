Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356647;
	b=jw59yds7bGmr3q6wlWNxFzaT2boIWciIxfPpPhVe7+8B2oBd7IqCur5IkshOrCOc8IG4
	 FoUthgmDqtm+l6KPyy3KT1JgZbQiFXUQfES1oGcU3e+4tBDX3SOM62Ua/GEhuxSk9Zkxx
	 kdlmeztlOaP8mn0ttLA/R3o7KPewPjjZO88KQ8DqZwcmkC0ZtCGD3hegp+A/XqXta2oSC
	 JStinBnT/mJ/xB9yknDPUI19SuOSRHRHQkVS8iWhlaGCxHG+XeslPKXFJWSy5eY5WeRyD
	 3wZyej/uQ20LtmR7UHE2nol/X3mupURlv5eZpxl2oUClB2v5G5fUcmPYnJ3DJ/iSXDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356647;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=3+tGrQUgqt3jvWBD9zjeghzoD0fUBi5yiSERvvU1W4I=;
	b=UH2OI81CtSUDf6dgN4DlV2klv+wW7rbs16L2sUnamlcJFhs/VduqaVxLq3R2d7EMnvJA
	 lOyoDrBmsd7tqi+AfuEqPrbnL1DoN/oQS3xrijz2ima8/EfNFZFWpFLTEf5ioh/5Rn8ZF
	 6zIdNl/xKeNOrbdjp9WNBCwcX+DWZyLL51Tnv25QIEdXmaMc9e15cyPz7ZYPVCpDV+KzE
	 +u3sS5nCfD7enLWtU4EPsRAkzvOef3pzwIzKsy71Y4afRMg0kX0r8UXmbeFs1TUlIMZAX
	 1oovZGAe7QNpJ9lnwL9hyiC65BBFS7EYtM9bNYkZMTQLqv3vZD0JGMZ6o3WYt5QVeZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE2606A337;
	Fri, 30 Oct 2026 10:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92BE2606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e1d5617cd44d11f19a56ed5b684f684d-20261030
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0050466b-9e8b-475d-8eca-8bddcd04520c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:74927232b5489653969c8df4999435f1,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|865|898,TC:nil,Content:0|15|52
	|99,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e1d5617cd44d11f19a56ed5b684f684d-20261030
X-User: wangxuewen@kylinos.cn
Received: from [172.30.70.102] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <wangxuewen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1057454557; Fri, 30 Oct 2026 18:37:19 +0800
Message-ID: <1db65746-7af3-444c-92c0-32019bbfd937@kylinos.cn>
Date: Fri, 30 Oct 2026 18:37:16 +0800
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
Subject: Re: [PATCH 1/2] mm/shmem: trace swapin results and order fallbacks
To: Steven Rostedt <rostedt@goodmis.org>
Cc: hughd@google.com, baolin.wang@linux.alibaba.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, wangxuewen_ky@163.com
References: <20261027094014.2432692-1-wangxuewen@kylinos.cn>
 <20261027094014.2432692-2-wangxuewen@kylinos.cn>
 <20261029103615.31dff835@gandalf.local.home>
From: wangxuewen <wangxuewen@kylinos.cn>
In-Reply-To: <20261029103615.31dff835@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Steve,

Thank you for your review. I agree with you. The current field layout 
introduces padding holes on 64-bit systems. I'll rearrange the structure 
in v2, grouping long fields at the front and smaller integer fields 
after, to reduce ring buffer memory overhead.

Best regards,
Xuewen

在 2026/10/29 22:36, Steven Rostedt 写道:
> On Tue, 27 Oct 2026 17:40:13 +0800
> Xuewen Wang <wangxuewen@kylinos.cn> wrote:
> 
>> +TRACE_EVENT(shmem_swapin_folio,
>> +
>> +	TP_PROTO(struct inode *inode, pgoff_t index,
>> +		 unsigned int entry_type, pgoff_t entry_offset,
>> +		 int requested_order, int actual_order, unsigned int path,
>> +		 unsigned int fallback, int fallback_error, int error),
>> +
>> +	TP_ARGS(inode, index, entry_type, entry_offset, requested_order,
>> +		actual_order, path, fallback, fallback_error, error),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(dev_t, dev)
>> +		__field(unsigned long, ino)
>> +		__field(unsigned long, index)
>> +		__field(unsigned int, entry_type)
>> +		__field(unsigned long, entry_offset)
>> +		__field(int, requested_order)
>> +		__field(int, actual_order)
>> +		__field(unsigned int, path)
>> +		__field(unsigned int, fallback)
>> +		__field(int, fallback_error)
>> +		__field(int, error)
> 
> There's a lot of holes in the above structure.
> 
> dev_t is 4 bytes in size, which means you have a 4 byte hole between that
> and the ino (on 64 bit machines).
> 
> And another 4 byte hole between entry_type and entry_offset.
> 
> Move the longs to the beginning and the ints after that. The order of the
> structure isn't important for the output, but is important for saving ring
> buffer space.
> 
> -- Steve
> 
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->dev = inode->i_sb->s_dev;
>> +		__entry->ino = inode->i_ino;
>> +		__entry->index = index;
>> +		__entry->entry_type = entry_type;
>> +		__entry->entry_offset = entry_offset;
>> +		__entry->requested_order = requested_order;
>> +		__entry->actual_order = actual_order;
>> +		__entry->path = path;
>> +		__entry->fallback = fallback;
>> +		__entry->fallback_error = fallback_error;
>> +		__entry->error = error;
>> +	),
>> +
>> +	TP_printk("dev=%d:%d ino=%lu index=%lu entry=%u:%lu requested_order=%d actual_order=%d path=%s fallback=%s fallback_error=%d error=%d",
>> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
>> +		  __entry->ino, __entry->index,
>> +		  __entry->entry_type, __entry->entry_offset,
>> +		  __entry->requested_order, __entry->actual_order,
>> +		  __print_symbolic(__entry->path,
>> +				   { SHMEM_SWAPIN_LOOKUP, "lookup" },
>> +				   { SHMEM_SWAPIN_CACHE, "cache" },
>> +				   { SHMEM_SWAPIN_SYNC, "sync" },
>> +				   { SHMEM_SWAPIN_READAHEAD, "readahead" },
>> +				   { SHMEM_SWAPIN_POISON, "poison" }),
>> +		  show_shmem_swapin_fallback(__entry->fallback),
>> +		  __entry->fallback_error, __entry->error)
>> +);
>> +
>> +#endif /* _TRACE_SHMEM_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>

