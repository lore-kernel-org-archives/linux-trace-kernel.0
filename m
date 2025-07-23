Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59E1286D56;
	Wed, 23 Jul 2025 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753263882; cv=none; b=YxucvT+MSecAB7JyMdLbafU0vsTszpQP6ixN6oh5wh6zu4lT6FniEe6/XXXQMsT4Q68Ip0uidE+30/n43UL+zlALznLnS5k4FJyNZMkg+vFrxIyDO0tT7HGAqx8LDt/X414e7KKPugkQSFj89U1hsZqYMeHsS/Z1cNv55KAWiMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753263882; c=relaxed/simple;
	bh=TqF5S/eJzZm94vMMG0tx8rzQRyIq7VfoN2F3rLiOnho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUbS+O9t3ju+4hXl4ACyefFiyxg53yapF8C8VRZnvshIvY76U/wrEXvNujTXLLUlTsZ04DZy5iNbaymtMOqcP1Z29UZFlgnHeap1oxIfiTXJbzXMeKovxo36LUeokZjjm20TfIHOkDznaJnw8j/+7CKbHw6xigGKq5XQLWr62h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TMYQTK+K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TMYQTK+K"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMPmSA030175;
	Wed, 23 Jul 2025 09:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gqrWal
	cU59oF4CnJQyu24hU/ox6MoJucIIfEPZGc2ss=; b=TMYQTK+KHppzxaIN0BhCie
	H5egX3hn27awyHjTQHhPwJ6cXAUyNEdnP8jchGOpAe443vgW5hqA3VNeJAyFYNbi
	ERFseI0+XZgAzplscm0YpD5MQEcAfMVz1BisvP/1geKmi7aIf9Qs+7qEkW4milUV
	6wmo1ZmYnhL9krhFjhWJR1S4h9nzv9RUfsxV84lMCWtMjs93S6MXYRa5kfLSVKyG
	zM7XMxNuC0m9g2KMf3LNAl/5AtK51ieONWk5Eg8+IJu5iP32TfYuV4KvqnkNroaT
	8emjEtvGrAUY9/HBHhL40hgwhxP4b/mfEsqr2GRYSYqOPdcwDU0WqyWQxK+K+EKw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482kdyjnya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 09:44:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56N8NTbe005478;
	Wed, 23 Jul 2025 09:44:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 480tvqxey4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 09:44:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56N9iT0c52101414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 09:44:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1329820040;
	Wed, 23 Jul 2025 09:44:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B771A20043;
	Wed, 23 Jul 2025 09:44:27 +0000 (GMT)
Received: from [9.39.18.80] (unknown [9.39.18.80])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Jul 2025 09:44:27 +0000 (GMT)
Message-ID: <708b26cc-e888-44d1-a7eb-ba37dea23a89@linux.ibm.com>
Date: Wed, 23 Jul 2025 15:14:26 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: sched: Hide numa events under
 CONFIG_NUMA_BALANCING
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
References: <20250612100552.39672cf9@batman.local.home>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250612100552.39672cf9@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DQg1WurTJf9V0O64s62LiDzeD7j3g9j4
X-Authority-Analysis: v=2.4 cv=XP0wSRhE c=1 sm=1 tr=0 ts=6880aeff cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=meVymXHHAAAA:8 a=VnNF1IyMAAAA:8
 a=Kfi56yhhYJ6IpBZ9KfsA:9 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: DQg1WurTJf9V0O64s62LiDzeD7j3g9j4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA4MSBTYWx0ZWRfX9U2nEwyWUn6B
 pSnH6m1G46hHvTbBObzDmbmWAjfO0C93kAJgbBFSZ+LfdFUUn+3AVjwo/1TIRPhvIgc55+0kBDy
 zpHrb4nf7Mt45bzVvChIX73wSRn/uiVeNjyWIx7OJaJhjDoTrdhuP1TCPtt2KCaIwQVBhG6Y8mM
 4E7hPWjHan4o3P++7YZQCNF7Y7aRJA/BQpzrewubzttTAn82p7OwiyGTDXCiMtiX9Lac2nYO1A+
 8dL3IGEQFcCNKH1iUquMTia6hmSTa/q4/HVn3nOvvwnplKsFPrmOhLSVwr8fgVIyKwob+rEE1au
 6yhE4IH/Hv5sswYi8hPE3uiUBPH7gFUTiBisXgqabHV0obRvYZWmSHzFRWLWnakv6jid783myTa
 OaqRRGio7DJaI8VOvuIe7uy5PCrdb+fIqHMpqQAY8F3PLfFWAYRCkwPoNLmjF04JVj2gJtyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=847 spamscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230081



On 6/12/25 19:35, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The events sched_move_numa, sched_stick_numa and sched_swap_numa are only
> called when CONFIG_NUMA_BALANCING is configured. As each event can take up
> to 5K of memory in text and meta data regardless if they are used or not,
> they should not be defined when used.

they should be defined when used?

> 
> Move the #ifdef CONFIG_NUMA_BALANCING to hide these events as well.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Note, I will be adding code soon that will make unused events cause a warning.
> 
>   include/trace/events/sched.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 4e6b2910cec3..0243f32e068a 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -628,6 +628,7 @@ TRACE_EVENT(sched_process_hang,
>   );
>   #endif /* CONFIG_DETECT_HUNG_TASK */
>   
> +#ifdef CONFIG_NUMA_BALANCING
>   /*
>    * Tracks migration of tasks from one runqueue to another. Can be used to
>    * detect if automatic NUMA balancing is bouncing between nodes.
> @@ -720,7 +721,6 @@ DEFINE_EVENT(sched_numa_pair_template, sched_swap_numa,
>   	TP_ARGS(src_tsk, src_cpu, dst_tsk, dst_cpu)
>   );
>   
> -#ifdef CONFIG_NUMA_BALANCING
>   #define NUMAB_SKIP_REASON					\
>   	EM( NUMAB_SKIP_UNSUITABLE,		"unsuitable" )	\
>   	EM( NUMAB_SKIP_SHARED_RO,		"shared_ro" )	\


Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
