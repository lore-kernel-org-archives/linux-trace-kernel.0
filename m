Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158103;
	b=xtT0PB3WFU4mCt0fGqfDyEBNL1DUbrwbTstkns6uYphmsBCWASZMYys21/JidBKObZNH
	 GffWQuSsWOUAkMyaji5L/R5wk+SFxx2iLSseCFdx0OK/auCYSPq9J5ncZPCFogyzlckME
	 ve9KUz4ybJ9cK4N+Ku0NsYH78NhNeKu8ph/WoE8vfVIsxtRBTMCguJ9K9xWqphmwSFOoI
	 ZaMbKA8jDClslUvf5aiDi4QcXH59mKUXW5onL1KOVk6QOx2QlQnf4+QHZYdMc/xaIYXaw
	 NVc1Z9nQSKN1uduspCp9BOn105/js1YfOn3+5krvwz4Rjc6EavQoDAlRNm3yfIGHOVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158103;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7YJ3VR/lK3Ypr21j50V93yJLpph7b+1DNy2JoCt6wc8=;
	b=P7Dri8ln9sQGqmSv+mknvrPw2Nf3XApyBHWCFlmw6/66kjLADOh83QL39Kw5W6WnKrHI
	 zecdwpbmfneUQ3VI5p9ydInhXeQQd9RWeLDywjGoaQniHDHN6jU5jUBgOGf5j5VJzwNid
	 QM/0us+NLK06f5SMZ65+/bm5ePsGhSNgnM5M4C8SWN/9ZGK1Gtw/rNAfRlT2eZB+e19QE
	 5ubvhRUdWLinrlSqv3epzDXFL5l26AMElXYm/IxYhgZjcLT3OMbZrtRWXEbBM/EBz+7Vi
	 uumTz/7EUvgv2Eh8d3vkw40Enji2D+D/85C9u7ommCuO2j9sbJjPYBUDMNZcobZwfQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA3E606A322;
	Wed, 28 Oct 2026 03:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DA3E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9af36daad27f11f19a56ed5b684f684d-20261028
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:31f716a8-b266-4c03-b4bb-6ca6c94775cb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:6,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:6
X-CID-META: VersionHash:7db8b62,CLOUDID:8bb064e096f5666a3dae38e6f9f026cd,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|865|898,TC:nil,Content:0|15|52
	|99,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9af36daad27f11f19a56ed5b684f684d-20261028
X-User: wangxuewen@kylinos.cn
Received: from [172.30.70.102] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <wangxuewen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1539901823; Wed, 28 Oct 2026 11:28:12 +0800
Message-ID: <4496ceae-5973-48c0-a2a9-7247f59de9c9@kylinos.cn>
Date: Wed, 28 Oct 2026 11:27:33 +0800
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
To: Randy Dunlap <rdunlap@infradead.org>, hughd@google.com,
 baolin.wang@linux.alibaba.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, skhan@linuxfoundation.org,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261027094014.2432692-1-wangxuewen@kylinos.cn>
 <20261027094014.2432692-2-wangxuewen@kylinos.cn>
 <f34f14ca-21bf-4ae4-9e7b-da7f72d1b134@infradead.org>
From: wangxuewen <wangxuewen@kylinos.cn>
In-Reply-To: <f34f14ca-21bf-4ae4-9e7b-da7f72d1b134@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Randy,
Thanks for catching this. I will fix the title underline in v2.
Xuewen

在 2026/10/28 07:55, Randy Dunlap 写道:
> 
> 
> On 10/27/26 2:40 AM, Xuewen Wang wrote:
>> diff --git a/Documentation/trace/events-shmem.rst b/Documentation/trace/events-shmem.rst
>> new file mode 100644
>> index 000000000000..45da82761360
>> --- /dev/null
>> +++ b/Documentation/trace/events-shmem.rst
>> @@ -0,0 +1,73 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +Tmpfs and shmem events
>> +=====================
> 
> Underline is one character too short:
> 
> Documentation/trace/events-shmem.rst:4: WARNING: Title underline too short.
> 
> Tmpfs and shmem events
> ===================== [docutils]
> 
> 
> 

