Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259DF1509AE;
	Mon,  9 Sep 2024 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869836; cv=none; b=VPJoVRS0maxUbFKrAN/NtjEBtiSS7INWjMXHpdg2CoIMsltDOk3CXV33o2aCJTvAaaGHwzTbMd08SHCLYZKnesmZmuMK/JRq7hBBzunNC4Pu4CEjq9O8avuknN6BR3ohiCcMhN6aZc+o4NQMQZGM0FtMBlNBgDw+Bqc0H4tnwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869836; c=relaxed/simple;
	bh=GRxevNuPMu1MgCyhaA3tBQBh8Ap4Vrj4anC2Bl8rHus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LDMhYQH/dKrXQF/+djhOOK9yfGdqjHJ4c8fgjItjl1mxwx0uXCSIu9pfl8owC5IqXdtmeeCK5u9NAXafdzRob+5UIk/JHZiFiPpBUWoOhD9IG56WNLodVVD8628G0uTyuNCl9FXdT1En6rVsqzrjlnZxIDtC86ACNRxhUHFdBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W+ZSEvoV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W+ZSEvoV"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 488NrD4f017225;
	Mon, 9 Sep 2024 08:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:mime-version:content-type; s=pp1; bh=Ff50iY574PIFtn6sDdnGnoLINv
	8P5HvooDUmf0KyjIQ=; b=W+ZSEvoVwAW9btce7GmEmsuCOB6/2dJWreXtcopSxT
	Jwon2mcziGy84O/u1oXsumdQ7nO5RQRLk21tuv8ddj/ToaSEoJqDf4lzw+46LJch
	0yWWhpPILFivhvzpIep9IFW/r5ObIrZ5yaTUiKbD1G8vDhLPYhi+ORfRbBu0opoZ
	l1ZtpZLZ4cdx1kj8pny9ZI4LBzD4ixJJ4GP7WkOfHYvt2UvtVwZ5mHfCqsxNTSEJ
	Sn4BPkzTzNev2w8H0zacGqrm6xcEMg26LYbvCsCb15OJconaCXwWPJtGf5pPS9A+
	SLP0la/O6xsXWHarInB3Tp32HMJTwYLKuKITZvKCjMQQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefy8jf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 08:16:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4897oD6w032103;
	Mon, 9 Sep 2024 08:16:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h2nmdddt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 08:16:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4898Gu7U34079358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Sep 2024 08:16:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F2C82004B;
	Mon,  9 Sep 2024 08:16:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 071BA20040;
	Mon,  9 Sep 2024 08:16:56 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  9 Sep 2024 08:16:55 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Zheng Yejian <zhengyejian@huaweicloud.com>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] tracing: add config option for print arguments in
 ftrace
In-Reply-To: <20240908223048.8bd6961dbc741d971f57b5c2@kernel.org> (Masami
	Hiramatsu's message of "Sun, 8 Sep 2024 22:30:48 +0900")
References: <20240904065908.1009086-1-svens@linux.ibm.com>
	<20240904065908.1009086-6-svens@linux.ibm.com>
	<69b78634-3295-c22e-c09c-e41aa4554df3@huaweicloud.com>
	<20240908223048.8bd6961dbc741d971f57b5c2@kernel.org>
Date: Mon, 09 Sep 2024 10:16:55 +0200
Message-ID: <yt9dcylddyx4.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dL4bbYGfjc6JMytpqv5Jnl0CY_Mv3G7M
X-Proofpoint-ORIG-GUID: dL4bbYGfjc6JMytpqv5Jnl0CY_Mv3G7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_02,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=991 priorityscore=1501
 adultscore=0 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090062

Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:

> On Fri, 6 Sep 2024 11:36:11 +0800
> Zheng Yejian <zhengyejian@huaweicloud.com> wrote:
>
>> On 2024/9/4 14:58, Sven Schnelle wrote:
>> > Add a config option to disable/enable function argument
>> > printing support during runtime.
>> > 
>> > Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>> > ---
>> >   kernel/trace/Kconfig | 12 ++++++++++++
>> >   1 file changed, 12 insertions(+)
>> > 
>> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
>> > index 721c3b221048..8b9b6cdf39ac 100644
>> > --- a/kernel/trace/Kconfig
>> > +++ b/kernel/trace/Kconfig
>> > @@ -242,6 +242,18 @@ config FUNCTION_GRAPH_RETVAL
>> >   	  enable it via the trace option funcgraph-retval.
>> >   	  See Documentation/trace/ftrace.rst
>> >   
>> > +config FUNCTION_TRACE_ARGS
>> > +	bool "Kernel Function Tracer Arguments"
>> > +	depends on HAVE_FUNCTION_ARG_ACCESS_API
>> > +	depends on DEBUG_INFO_BTF && BPF_SYSCALL
>> 
>> Nice feature!
>> 
>> Just a nit, DEBUG_INFO_BTF currently depends on BPF_SYSCALL,
>> so BPF_SYSCALL may not be necessary here. This feature
>> also doesn't seem to depend on bpf.
>
> Indeed. Sven, you can check the PROBE_EVENTS_BTF_ARGS as
> an example.
>
> config PROBE_EVENTS_BTF_ARGS
>         depends on HAVE_FUNCTION_ARG_ACCESS_API
>         depends on FPROBE_EVENTS || KPROBE_EVENTS
>         depends on DEBUG_INFO_BTF && BPF_SYSCALL
>         bool "Support BTF function arguments for probe events"

Now i'm confused - Zheng wrote that DEBUG_INFO_BTF depends on
BPF_SYSCALL. I just verified that. So i could just remove BPF_SYSCALL
from the dependencies - but your example also has BPF_SYSCALL listed.

Regards
Sven
