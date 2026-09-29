Received: from mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259BF392C3A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 02:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790647317; cv=none; b=S3OnpcrQqcuoQGC1BDJ4hpMS+PjYy03Vp7AfqAh+cTRsSBTx78qxzhl9H2eS5YO67isUSuYNS1umvDLyAsqLBNFxbLCvRBAfXBaSCtFO6OwsTeuEhQQlrhsuuoBbPk078P/j3Baw1/hwngeA45Qp5deVLOyn20GYkYi9i162qAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790647317; c=relaxed/simple;
	bh=3EXYENbSnVGFPe8EJ/yXVjyE7HPdhLG5URV3ZJY1edg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgOMwaCSIqG095+LZkm5zqyB4MsSpzYlWF36VCC17ahNj74pFmxXltpRqxCgfA/wVN/trOU4cWnFzbkFp2kae6YI52hOe7kd6bxghERKQgHQKmUFn+AUF1lZ0rU80a1hCF1jJsPjU4KQE9Q6cunjJoCQCP6zAdmSz4m9sRC6Wps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IXPI+rPt; arc=none smtp.client-ip=95.215.58.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IXPI+rPt"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3EXYENbSnVGFPe8EJ/yXVjyE7HPdhLG5URV3ZJY1edg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790647312; v=1; x=1791252112;
 b=IXPI+rPtZeQ9RVNFiGbLNumK6V6Q3Yl4sHnD/kCOMDJtY99j1uashfbgWXJ0dVIw/KQEmNSk
 PMeP9sqlJhILHg6DP4lka/xjdeFIKYwuP40pUdZuycsPsoSdNyS/IU2JHb4sytz1g9viU+rLKiv
 UqLS8HSAIaej2gVtcKsbD3d8=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 26e1c67174581918;
	Tue, 29 Sep 2026 02:01:51 +0000
X-Mizu-Trace-ID: 26e1c67174581918
X-Migadu-Flow: FLOW_OUT
Message-ID: <129d5af2-81a8-4465-b5a4-617b88bab748@linux.dev>
Date: Tue, 29 Sep 2026 10:01:49 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 7/7] mm/vmscan: pass scan_control to
 mm_vmscan_balance_pgdat_end
To: sashiko-reviews@lists.linux.dev
Cc: hannes@cmpxchg.org, linux-trace-kernel@vger.kernel.org, tj@kernel.org,
 mkoutny@suse.com
References: <20260928114625.3609130-1-ridong.chen@linux.dev>
 <20260928114625.3609130-8-ridong.chen@linux.dev>
 <20260928115827.18B291F00893@smtp.kernel.org>
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260928115827.18B291F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/28/2026 7:58 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] mm: BPF raw tracepoint ABI breakage and commit message mismatch in mm_vmscan_balance_pgdat_end
> --
> 
> commit eb8bc6091aab714af4b68f316fecfc08d43c39dc
> Author: Ridong Chen <chenridong@xiaomi.com>
> 
> mm/vmscan: pass scan_control to mm_vmscan_balance_pgdat_end
> 
> This commit updates the mm_vmscan_balance_pgdat_end tracepoint to receive
> a struct scan_control pointer rather than passing individual struct fields.
> It updates the TP_PROTO and TP_ARGS while leaving the exported event format
> unchanged.
> 
>>      balance_pgdat() passes sc.order and sc.nr_reclaimed to
>>      mm_vmscan_balance_pgdat_end as bare arguments. Pass the enclosing
>>      struct scan_control instead and read the fields out in TP_fast_assign,
>>      mirroring mm_vmscan_balance_pgdat_begin. highest_zoneidx stays a
> 
> [Severity: Medium]
> The commit message states this change is "mirroring
> mm_vmscan_balance_pgdat_begin." Is this description accurate?
> 
> Looking at mm_vmscan_balance_pgdat_begin in mm/trace_vmscan.h, it still takes
> individual arguments and was not updated to take struct scan_control *sc:
> 
> TRACE_EVENT(mm_vmscan_balance_pgdat_begin,
>          TP_PROTO(int nid, int order, int highest_zoneidx),
> 
> Could the commit message be more precise about the rationale?
> 

You're right, that wording is misleading and I'll fix it in next version.

I just mixed it up with other xxx_begin tracepoints.

>> diff --git a/mm/trace_vmscan.h b/mm/trace_vmscan.h
>> index 04f285e776596..c27bc7cc60630 100644
>> --- a/mm/trace_vmscan.h
>> +++ b/mm/trace_vmscan.h
> [ ... ]
>> @@ -124,10 +124,9 @@ TRACE_EVENT(mm_vmscan_balance_pgdat_begin,
>>   
>>   TRACE_EVENT(mm_vmscan_balance_pgdat_end,
>>   
>> -	TP_PROTO(int nid, int order, int highest_zoneidx,
>> -		 unsigned long nr_reclaimed),
>> +	TP_PROTO(int nid, struct scan_control *sc, int highest_zoneidx),
>>   
>> -	TP_ARGS(nid, order, highest_zoneidx, nr_reclaimed),
>> +	TP_ARGS(nid, sc, highest_zoneidx),
> 
> [Severity: Medium]
> The commit message mentions there is "No functional change", but could this
> modification break existing BPF programs hooked to this tracepoint?
> 
> While standard trace events parse the formatted output, BPF raw tracepoints
> consume the TP_PROTO arguments directly via ctx->args. Changing the number
> and type of arguments alters the BPF raw tracepoint ABI for this event.
> 
> Does this inadvertently break user space tools that attach to this raw
> tracepoint and expect the 4 original arguments?
> 

Thanks, "No functional change" is inaccurate here.

Kernel behaviour and the tracefs format are unchanged (TP_STRUCT__entry /
TP_printk are untouched), so perf / trace-cmd / libbpf CO-RE consumers are
unaffected. But for BPF raw tracepoints the arg layout does change: a program
reading the old args[3] (nr_reclaimed) now has to read it out of sc. I
shouldn't have hidden that under "no functional change".

Raw tracepoints aren't a stable ABI though 
(Documentation/bpf/bpf_design_QA.rst), so the change itself is fine — I'll just 
fix the commit message in next version.

-- 
Best regards
Ridong

