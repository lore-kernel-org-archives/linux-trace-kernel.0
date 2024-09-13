Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71404224CF;
	Fri, 13 Sep 2024 06:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726207453; cv=none; b=lh0CGjQFu3hxvTadC09ZM6GFBgbcItkgYPMI0DgU3CI/Ib5xszbLsj4s2J6IcVfM+aM0eVr0xSuVv35UTCaPijrRuIgrSPajCyS18wIyWX17mDGTsqsqMwjiTjtCRc/LT8EhHhdAT468wIljJqDCUTvWD3BnihfMGCWvezJzrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726207453; c=relaxed/simple;
	bh=nstVZHkUy5pKTdbUjOMs70lhCwSaOSVyh/g/ucQQHw0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=WSeP6AITyl19d3WSxPso4fPCxqOm4vf4Zi06Q2AN2MW8octjIOTQTpymbsh1gwGfmRLQP0wHTFlZjDsZcHVSlNi6G4Oy63qzqGrGr4r6PnXbdo6LrpXmYYGIezFkrDE0WK38vyqoPngR7rC1SGl6WkNZZTH7GHQDTFRk6iST4kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B7TwvFZ6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B7TwvFZ6"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CNo6ej022644;
	Fri, 13 Sep 2024 06:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=pp1; bh=w8Yaj17rePOkc2oA8hmd/PPLMU
	G7M8Thql5tfawg9RU=; b=B7TwvFZ6cvkbhvnMBeO26n0h86Qnr6mIB4wCl18lm0
	EDaynUwRx2yqEcTSkUnj7vX74bkzHD3IMnTMobTf5JdYtniKUo+uMsIld0szlLM7
	j65sy82ZM58HKeVZbDERZZ0RNiUWY3uVAwLFE9/Hq6NPsq89hFc0hb3Qh36sptaO
	mPIv6Hq2pVeWW89ZrB2ONk8Q+0YXrb7ldbCFBznlshCnsaS2b3sstgGqUXGfKEKy
	JiUhLGk/W3V9Ve7hWCxkoQAy/WTzB0Sqhz5NCbw3qLvhZd1VTpRIyqUgEc7sLfqX
	P0N+c6XYNbAW6HSYnhjxrOeQ8A6MORxHZIS2wSqigMaQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebaqxgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 06:03:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48D2035B010729;
	Fri, 13 Sep 2024 06:03:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41kmb6yv6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 06:03:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48D63qmC46203320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 06:03:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 563AF20043;
	Fri, 13 Sep 2024 06:03:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AA1020040;
	Fri, 13 Sep 2024 06:03:52 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Sep 2024 06:03:52 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland
 <mark.rutland@arm.com>,
        Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,
        Paul Walmsley
 <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert
 Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: Re: [PATCH 0/7] add function arguments to ftrace
In-Reply-To: <yt9dh6ape022.fsf@linux.ibm.com> (Sven Schnelle's message of
	"Mon, 09 Sep 2024 09:52:21 +0200")
References: <20240904065908.1009086-1-svens@linux.ibm.com>
	<20240905111620.5211d9f8@gandalf.local.home>
	<yt9dv7z9l2zp.fsf@linux.ibm.com>
	<20240906100738.2526cffd@gandalf.local.home>
	<20240908222830.01a01b10d62d59ed73dcb676@kernel.org>
	<yt9dh6ape022.fsf@linux.ibm.com>
Date: Fri, 13 Sep 2024 08:03:51 +0200
Message-ID: <yt9djzfgccoo.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7nToZDWGKNT9QZOOlyB71xBhYhClmsHN
X-Proofpoint-GUID: 7nToZDWGKNT9QZOOlyB71xBhYhClmsHN
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_03,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=858 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409130042

Sven Schnelle <svens@linux.ibm.com> writes:

> Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:
>
>> On Fri, 6 Sep 2024 10:07:38 -0400
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>> On Fri, 06 Sep 2024 08:18:02 +0200
>>> Sven Schnelle <svens@linux.ibm.com> wrote:
>>> 
>>> 
>>> > One thing i learned after submitting the series is that struct
>>> > ftrace_regs depends on CONFIG_FUNCTION_TRACER, so it cannot be used
>>> > with the graph tracer.
>>
>> Yeah, this is solved by my series [1].
>>
>> [1] https://patchwork.kernel.org/project/linux-trace-kernel/patch/172398532480.293426.13232399076477198126.stgit@devnote2/
>>
>> So I think this series is easier to apply after my series, which
>> passes fgraph_regs in return handler.
>
> Thanks, i'll rebase my changes on top of your patches then.

While doing so i noticed that i completely forgot about arguments
located on the stack. The current patchset tries to read from the
current kernel stack, which is obviously wrong. So either the tracer
needs to save the stack frame in the ringbuffer (which would be quite
a lot of data), or ftrace only prints arguments located in registers.
Also not nice. Opinions?

Thanks
Sven
