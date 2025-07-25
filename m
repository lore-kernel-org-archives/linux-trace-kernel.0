Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6721421E;
	Fri, 25 Jul 2025 03:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753413348; cv=none; b=nQ043vHLrnoqLlkS2129WvTbASgyY4hs2JMeo1eitt1gu2TS8eELZViqoORd12YNWvflEcY6b2FTc+CwrbZc51PCHC/OxDsaezB/3gSsWTkqx13PbjeVmWqH1s9YLKDw3cY1BCR5LH9eoYIYLLtcbV2dvFCyIcbxEeWOxLoJV+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753413348; c=relaxed/simple;
	bh=+f8vH1jJCMzg6chIAny7+gs+yTKqcpmYixHrGSnY0RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyqo/rMJ4qGF8UjVl6VijyVoD0TkkUUrcK0xS2etXK/catVYepyATkaH60ObdDcD2UnTw/5naaoGECLebppk1fignQYBH0N9MC6y7qw5w49T3iHyry+nc6oX43OebULr+77xAQBLS2gryRfjkMVyfwKQodq9CkXk61kJotq2VMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hzDYvTiA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hzDYvTiA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OM9jXU004457;
	Fri, 25 Jul 2025 03:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XML+wV
	DDRUmvGG8qWEzvXc05uJKnipeZiRtxzBQTwjg=; b=hzDYvTiAKOMUcOX1zyQAHZ
	kuZqt+R66M/2QICVFKkr24WWyFQ6MxARpTmtyERZSQVj1zUYzT6ig+GXXVgExB0B
	tPiBMeDShbpDE2tFxncG4RK/j5hgz3YSFJT0N1FZF8xirTuI96kQfd3KgpGZwpek
	Ns58uBvq/u5kTXTnqn4vfkUvhIS39sqd8uJBHX1dit3YE4bahVegrclRGWCbGKsj
	TYQU4NvC0u9pYbytRpQqqss5HSaYlpvHD/SfMROL7VVgbsOqZuQokSv3AktN1V5r
	kQngqY3R5xarLpVj/LHSTS6iQCJN8vIhdhMui+fvcYvV3droHiKgfxKh368zrw7g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wcjrrre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 03:15:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56OMvWlu005253;
	Fri, 25 Jul 2025 03:15:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480u8g6ud0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 03:15:19 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56P3FIjD24445492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 03:15:18 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB7355804E;
	Fri, 25 Jul 2025 03:15:18 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C84AB5803F;
	Fri, 25 Jul 2025 03:15:15 +0000 (GMT)
Received: from [9.204.206.224] (unknown [9.204.206.224])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Jul 2025 03:15:15 +0000 (GMT)
Message-ID: <8306ebfd-0836-4ed6-bd2d-0a8039f6a8c6@linux.ibm.com>
Date: Fri, 25 Jul 2025 08:45:02 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/thp: tracing: Hide hugepage events under
 CONFIG_PPC_BOOK3S_64
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20250612101259.0ad43e48@batman.local.home>
 <20250724092847.1aa83756@batman.local.home>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20250724092847.1aa83756@batman.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xIeP2VPgqZ_7tUbLAhcZoj2tFQPExAmH
X-Proofpoint-ORIG-GUID: xIeP2VPgqZ_7tUbLAhcZoj2tFQPExAmH
X-Authority-Analysis: v=2.4 cv=QOloRhLL c=1 sm=1 tr=0 ts=6882f6c8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=meVymXHHAAAA:8
 a=-C49POrsBXEG1DwCQcYA:9 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDAyNCBTYWx0ZWRfX4txqFrmfvDry
 eeLijhpzzVPIK+Xxy9JnO3plf4ZmR7y/qVKpArEuapN3I/GF2FDDz9rD02EO/ZAlX56pZ2wW4tw
 cAcJbT3SFfG/++B/6J+kuaxV8AHSa0SnDTURgNW/utU/1OVlMsG9AMcmflg7YuPB8Q/zIE5Iyvl
 50/U4qTyZUpVTZiCjPS2tTMaQPeBBNpPBVz3aUSCTPZA2yTpIpVUrjgMyuAyR00Cr0UYn/OVfPE
 K5vxa9/zfH/JOF/mLoU+tI3uunYzSWR6fhKf0BCIdtoL0BA2d6cmYuLWCzdqyiK/oA7t6utOUDH
 Pxrh/c31yz4PlhU1aLvcnhh5KI+eaC1yHKRow6RBAIMSqgQ/y5Y40+xVRo1Z1cqQ5ma9modXpT8
 KChxayUReuPrbUaztK9FJ7EGGZje1MGm+S8hS+GYL6ij6eAzs4eOs2irdHf47GeTSH2mSQi/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=581 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250024



On 7/24/25 6:58 PM, Steven Rostedt wrote:
> 
> Anyone have any issues with this patch? Should I take it in my tree?
> 
> -- Steve
> 
> 

Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>

Yes, kindly take it via your tree 

Thanks
Maddy

> On Thu, 12 Jun 2025 10:12:59 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: Steven Rostedt <rostedt@goodmis.org>
>>
>> The events hugepage_set_pmd, hugepage_set_pud, hugepage_update_pmd and
>> hugepage_update_pud are only called when CONFIG_PPC_BOOK3S_64 is defined.
>> As each event can take up to 5K regardless if they are used or not, it's
>> best not to define them when they are not used. Add #ifdef around these
>> events when they are not used.
>>
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>> ---
>> Note, I will be adding code soon that will make unused events cause a warning.
>>
>>  include/trace/events/thp.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/trace/events/thp.h b/include/trace/events/thp.h
>> index f50048af5fcc..c8fe879d5828 100644
>> --- a/include/trace/events/thp.h
>> +++ b/include/trace/events/thp.h
>> @@ -8,6 +8,7 @@
>>  #include <linux/types.h>
>>  #include <linux/tracepoint.h>
>>  
>> +#ifdef CONFIG_PPC_BOOK3S_64
>>  DECLARE_EVENT_CLASS(hugepage_set,
>>  
>>  	    TP_PROTO(unsigned long addr, unsigned long pte),
>> @@ -66,6 +67,7 @@ DEFINE_EVENT(hugepage_update, hugepage_update_pud,
>>  	    TP_PROTO(unsigned long addr, unsigned long pud, unsigned long clr, unsigned long set),
>>  	    TP_ARGS(addr, pud, clr, set)
> 
>>  );
>> +#endif /* CONFIG_PPC_BOOK3S_64 */
>>  
>>  DECLARE_EVENT_CLASS(migration_pmd,
>>  
> 

