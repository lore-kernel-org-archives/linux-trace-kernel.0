Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1782B3F3272;
	Wed,  5 Aug 2026 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785967515; cv=none; b=eWozBoAAWtX2Yzm34fIDel+pU2rsLYEoo+fTVXNNeh+lij7jZr9fucxOXlndqwGLJ0QYc1Pd1f2uSggx57Y+6ZFD7LRh3O/BuOIaSs+VG0meZ2+anW9XoPJpyCfBLBPFKnmEnCfszrp9D1J2Mj7bTOIPdDV2iefi0Y/MwQGLT+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785967515; c=relaxed/simple;
	bh=BghQNH+cBbUXDqxxwnOmMTzb4UIB1SWj1wgoMS6WZ/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLYSJ6OibMOd44Qu+bfbwvrXkIxUONOPiD8bD8mMT5+kSxQ3+0FAxxKOTO43EFJfWeDSDcmBlrFqaiGrc1TDKs5VRLeZCKlM8AgxRUmD42/RRiOM4QUBn/CI9WtOQ8B8lYfMWryQvlAMBuUrbBGV28x8YBRtaGs6mfoWvm81V8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nT80dXsC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nT80dXsC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675HlcVc345990;
	Wed, 5 Aug 2026 22:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=yHQEgiQJJEtHtDk5ARQDt/t/xwo55w
	jIvVKh4SkBtEg=; b=nT80dXsCxQDLnt+K4APdK/mnvZjhpUE/Jupvg3bN6REJC7
	vdWszq+dr2P28Jg1Dg3MPCP8xChJ5Q7IKhWHz1mrGKiQ0Maa3ypTu7aoaY8UdE1m
	z7eYqsjJYCJzXwRPCQ0VnJbGEteFLkHFHFgV1ELmODVtHM2fl12Jo2wiB76FTkNG
	wNtApNKz0wdvAvVXFcBO36Hmd9/MKCEYEPsPzgBFHuw283vQmsL3Dq1RFavOZpse
	eMJnCcOGnx6p8/vppMzb52gPesKH/E2pyq5tHrpAHGybqeBUj6KALP39hEMQZtRx
	9duRatsxnZCRVwNFDgxhr/T9chVcvFeAEp/PiQZQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h559u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:05:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675LQHXL026073;
	Wed, 5 Aug 2026 22:05:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qrn8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:05:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675M55QG46924256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 22:05:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C6052004E;
	Wed,  5 Aug 2026 22:05:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97A2E2004B;
	Wed,  5 Aug 2026 22:05:04 +0000 (GMT)
Received: from li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com (unknown [9.111.1.132])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  5 Aug 2026 22:05:04 +0000 (GMT)
Date: Thu, 6 Aug 2026 00:05:03 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] uprobes: Skip breakpoint installation on non executable
 vmas
Message-ID: <anOzj_Ud351W1dMh@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
References: <20260805131904.1127416-1-sumanthk@linux.ibm.com>
 <anNTRb2aGsvY8_Rf@redhat.com>
 <CAEf4BzZum6AjU1G_hazOwW1ECNzHm=2vLVUGOjD-tSYqr-HRuA@mail.gmail.com>
 <anOrOJfOkGhLeDp5@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anOrOJfOkGhLeDp5@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE3OSBTYWx0ZWRfX1328j3FZ2cgu
 kqP0OGBOsFy7L8qnwYZTL8eG4nAjPQm1E9kpjSTo0ntJQJIb0vtjXkY7zDeFRLcTdVhlaYAjRo3
 EkveHHkBxa9x/g1ylYUhjtRtSbtVBCw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE3OSBTYWx0ZWRfXw10Z+UOWqTWi
 x7L7TkysVQjLjzf6Bsqkc9ju6QgAHAUyWbX0VjlAq7006ZOTBiPzTcJau4kegfj0YgjkPLG2LjO
 srx4iubRpCcoGJohF7IBY1D+78n9xX6Dz6lM/5wWA3SiVqp/lJKmNlZeW3N+XCufqeGEmCrJfzh
 r6nVz4jVnBtruARGmmvp9Sg+zw2e06TyVuIJBlT7Dz76Uk7z2tYZ54RWfAMvyFyOuAQ/lweGtbO
 ojY5W7m3oKGEm7lVUrGxnLQ0JXN35TXvEgcxdKGgC2ZyrJtx1YLSvFKrFdLUert3cOypZqLcTaS
 pV9OCWOw8MnOY6SVBC8sqfAeiDf8xWP1t2lcuV+4LSOR3+vYjC8JUNnXGYgyNxvPg5TQdWrLrKV
 uIQK6PiODTN2qMNbm0HZzTIMrD7I8JbfnCmZHWVuBlyFFAo3N20rq1CTg39DhslDnoOKXAGb5vs
 Dnisuj/LWQoJIJPTvfA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a73b396 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=6ZcJnWpbRGPcvNwef4MA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Bq0peI3Uc2aOtSRGeFmBCkYYYFNK2K3D
X-Proofpoint-GUID: IzQlRhUdTXSo1unB-zXYmYMlug_92Yfc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050179

> > Even though it's the same file offset, it is mapped to two different
> > virtual addresses, so I think it should be two different memory pages
> > that will have two separate int3 instructions. I don't think there is
> > any contradiction or surprise, is there?
> 
> True. cross checked the behaviour with bpftrace stacktrace. Pasted the
> output in previous thread.

I meant to say the following in response to your reply:
"Even though it's the same file offset, it is mapped to two different
virtual addresses, so I think it should be two different memory pages
that will have two separate int3 instructions."

Right, and traced this behaviour using bpftrace stacktrace. stacktrace
is pasted in the previous thread.

> > > > Installing a breakpoint for mapping without VM_EXEC and
> > > > updating usdt reference counter in that case is not useful.
> > > >
> > > > Skip non VM_EXEC mappings in install_breakpoint(). This fixes semaphore
> > > > double increment as shown in the above usecase.
> > 
> > You said that mapping is VM_MAYEXEC, which means that kernel allows to
> > re-mmap it as executable, if that happens, we will miss uprobe in that
> > location, so that's probably why breakpoint is installed for
> > VM_MAYEXEC.

ref commit 78a320542e6c ("uprobes: Change valid_vma() to demand
VM_MAYEXEC rather than VM_EXEC")

Thank you
