Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FA018C340;
	Wed, 16 Oct 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070278; cv=none; b=lieH71M0TxxPdmRVJuZmNu3eGyfPdFqNgFvMG3Sw9DAt2CpJapapCg0yHWUcrZyiQ9JG+eNxhz8TKhp9FQR01m7c9QZh5XgtMZnrht/e1PgH9WCEb6NRj4znKo4curB8cCgGN0SegrGtDj3cxEQehpDHbp0vVAN/lKpfhzF6To0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070278; c=relaxed/simple;
	bh=bfOf4Cu/BWZ3tPhEgEHq+ruFEt18njgi52RV8Bz//3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2f8bJXZPC2UhC9Qq9dsRWi1FQp7PRfjMi5c1HmUMDvUbEX6pKTnZs8UPM9Sh5aHxhjgsl8qiSMGzxi/+9ToH76njxKpWm2OGyumWAA8IxbHSBjoAV9Mh8QSI4nydJ8ElkseAyMRQfUbn7ujDNj2L8yEI4CRDdW1/J8KyRWQpQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MHFPB13O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MHFPB13O"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8t7tE031177;
	Wed, 16 Oct 2024 09:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lRq0Wb
	oQ/V2PTWbWlrpBqtXUN3wSw5yHIw3Xse2+f/s=; b=MHFPB13OB5ZTVBjQxuGVKB
	D7HXSgmZ/jBeY6uW94K7xVXtwwyc4/PQqzj/E61k3E0SHMpXJKJKJxvYkvxS3RRe
	25pJyGBN5+Fr7iKN/SzK0WPTwW6lrvbe5/GVqNgFjXnPswbZWbqcIw6vWgF6EsDu
	x0dy58kAaUh3hZ0p6IZgTCsLYjV6LeUaqVU23GqIs4x8USn7xN5xCUwuGXLpz4a0
	DFqRmQcV8NIs53ZlMHglR0yq47qPF3s6AJ2qhpVWPqfakaYkm1xB/90dhrKlPDtD
	ee40A4iqHmlVA2cPF2HsF+aKKQyKrfnkWTGcUT/8WSqyuStfd+cmwNsFooCy+K3A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aad2g3y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 09:17:36 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49G9Eq4b010504;
	Wed, 16 Oct 2024 09:17:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aad2g3xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 09:17:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49G6vwmM027464;
	Wed, 16 Oct 2024 09:17:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txrhh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 09:17:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49G9HXiX39977406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 09:17:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C7FF2004D;
	Wed, 16 Oct 2024 09:17:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71E5F20040;
	Wed, 16 Oct 2024 09:17:29 +0000 (GMT)
Received: from [9.124.220.43] (unknown [9.124.220.43])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Oct 2024 09:17:29 +0000 (GMT)
Message-ID: <70a41c53-65da-4f3c-9ef7-caa364b5657c@linux.ibm.com>
Date: Wed, 16 Oct 2024 14:47:27 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tracing: Record task flag NEED_RESCHED_LAZY.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com,
        efault@gmx.de, Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20241009105709.887510-1-bigeasy@linutronix.de>
 <20241009105709.887510-3-bigeasy@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20241009105709.887510-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lXFKFNNYfFP2dC-xQtc1092pTo5152Yo
X-Proofpoint-ORIG-GUID: c802Sg5FJWdLJ53Gzk0qVpOjBFwTJQF6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160059



On 10/9/24 16:20, Sebastian Andrzej Siewior wrote:
> The scheduler added NEED_RESCHED_LAZY scheduling. Record this state as
> part of trace flags and expose it in the need_resched field.
> 
> Record and expose NEED_RESCHED_LAZY.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   include/linux/trace_events.h |  1 +
>   kernel/trace/trace.c         |  2 ++
>   kernel/trace/trace_output.c  | 14 +++++++++++++-
>   3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index d5c0fcf20f024..4cae6f2581379 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -185,6 +185,7 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status);
>   enum trace_flag_type {
>   	TRACE_FLAG_IRQS_OFF		= 0x01,
>   	TRACE_FLAG_NEED_RESCHED		= 0x02,
> +	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x04,
>   	TRACE_FLAG_HARDIRQ		= 0x08,
>   	TRACE_FLAG_SOFTIRQ		= 0x10,
>   	TRACE_FLAG_PREEMPT_RESCHED	= 0x20,
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 1c69ca1f10886..29d7703751aa9 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2544,6 +2544,8 @@ unsigned int tracing_gen_ctx_irq_test(unsigned int irqs_status)
>   		trace_flags |= TRACE_FLAG_NEED_RESCHED;
>   	if (test_preempt_need_resched())
>   		trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
> +	if (tif_test_bit(TIF_NEED_RESCHED_LAZY))
> +		trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
>   	return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
>   		(min_t(unsigned int, migration_disable_value(), 0xf)) << 4;
>   }
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 829daa0764dd9..23ca2155306b1 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -463,17 +463,29 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
>   		!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_SUPPORT) ? 'X' :
>   		'.';
>   
> -	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED |
> +	switch (entry->flags & (TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY |
>   				TRACE_FLAG_PREEMPT_RESCHED)) {
> +	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
> +		need_resched = 'B';
> +		break;
>   	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_PREEMPT_RESCHED:
>   		need_resched = 'N';
>   		break;
> +	case TRACE_FLAG_NEED_RESCHED_LAZY | TRACE_FLAG_PREEMPT_RESCHED:
> +		need_resched = 'L';
> +		break;
> +	case TRACE_FLAG_NEED_RESCHED | TRACE_FLAG_NEED_RESCHED_LAZY:
> +		need_resched = 'b';
> +		break;
>   	case TRACE_FLAG_NEED_RESCHED:
>   		need_resched = 'n';
>   		break;
>   	case TRACE_FLAG_PREEMPT_RESCHED:
>   		need_resched = 'p';
>   		break;
> +	case TRACE_FLAG_NEED_RESCHED_LAZY:
> +		need_resched = 'l';
> +		break;
>   	default:
>   		need_resched = '.';
>   		break;


Could you please update in Documentation/trace/ftrace.rst as well?
