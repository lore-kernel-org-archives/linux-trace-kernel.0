Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE061B012A;
	Mon,  9 Sep 2024 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868362; cv=none; b=aKtBIW6s95QBns5RyvcPkXhlENzzRL55IXmYvmg7yD8KpfbERI0DmjyRIDC3glJZXvry9NlURhVOO8cV+JW9OwpEj0BIs/JLz4FNoO7qe/23Fe12Br2J2PlKJbLUcM/zQfqu3WPpduKijnQP1F8BrP6jbZPOsvL2TXUsbORVCkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868362; c=relaxed/simple;
	bh=BcuSQx643SHfhyrLiS2tq0Rnh9mIkchyToPZe+TkftI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Bf2XG3STwhfanAe4CT33f/aMtL76gqftq5HgnWQ3qEvHV0X+w5gxnYNsbqLSIbUqrlfT6Zp+d7t9voR827dSnWrph/0Z42oEIz6ETrw0MvtPv7JItoKPIPvBAAUBKkMEsu/fCdlQyHNtos97AFYCi0CcXz6oAdpVyBpDiSDsRy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sdc1ZcbQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sdc1ZcbQ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 488EGkuL028493;
	Mon, 9 Sep 2024 07:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=pp1; bh=moBXgB70de3lqjGc3xvwz3nwGd
	M+kLX4K4e1CtqCfZ4=; b=sdc1ZcbQ/8Uu30BI3hll/ZZKmpbCvKSUaQBgtC4Oft
	h0CbuIuk2EVJzTcp492wfWrPk+jbTSvpPq768JHxnPo5xBp4UsSRsmPXtNAPxLDU
	4vRfRwV3AqB4MypjtDPSc9HjovscGDk95GuElNQxzX7ihpdQcNqbROwxKp4tV/Fo
	YFDpniTP5gt7xwrD3pqXvXFo8oxDE903tv5OY1exvkteLz7QBzO3jAb6U3dnm/yB
	WJ1BJDhtg7msCVnZNCfL+Ptm0r2LpLnWrhwk4BtUygvaVU7f7wHii6mBOUk/ponX
	X/Z/XydQbXbkckwbVTi3IcBAUb3387hkOODAsvH1iKuw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefy8dw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 07:52:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4894XkfN027333;
	Mon, 9 Sep 2024 07:52:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3v2w2dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 07:52:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4897qLQu22217104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Sep 2024 07:52:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBBDB2005A;
	Mon,  9 Sep 2024 07:52:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A018320040;
	Mon,  9 Sep 2024 07:52:21 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  9 Sep 2024 07:52:21 +0000 (GMT)
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
In-Reply-To: <20240908222830.01a01b10d62d59ed73dcb676@kernel.org> (Masami
	Hiramatsu's message of "Sun, 8 Sep 2024 22:28:30 +0900")
References: <20240904065908.1009086-1-svens@linux.ibm.com>
	<20240905111620.5211d9f8@gandalf.local.home>
	<yt9dv7z9l2zp.fsf@linux.ibm.com>
	<20240906100738.2526cffd@gandalf.local.home>
	<20240908222830.01a01b10d62d59ed73dcb676@kernel.org>
Date: Mon, 09 Sep 2024 09:52:21 +0200
Message-ID: <yt9dh6ape022.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jS8qGd1Kag-0cgWKKAQwQPih_Lh8MSWc
X-Proofpoint-ORIG-GUID: jS8qGd1Kag-0cgWKKAQwQPih_Lh8MSWc
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_01,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=765 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090059

Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:

> On Fri, 6 Sep 2024 10:07:38 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Fri, 06 Sep 2024 08:18:02 +0200
>> Sven Schnelle <svens@linux.ibm.com> wrote:
>> 
>> 
>> > One thing i learned after submitting the series is that struct
>> > ftrace_regs depends on CONFIG_FUNCTION_TRACER, so it cannot be used
>> > with the graph tracer.
>
> Yeah, this is solved by my series [1].
>
> [1] https://patchwork.kernel.org/project/linux-trace-kernel/patch/172398532480.293426.13232399076477198126.stgit@devnote2/
>
> So I think this series is easier to apply after my series, which
> passes fgraph_regs in return handler.

Thanks, i'll rebase my changes on top of your patches then.

Regards
Sven
