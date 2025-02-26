Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E7784A2B;
	Wed, 26 Feb 2025 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578265; cv=none; b=idHWUQ/RQOIJjJfdUBz3S2HehJO6XvYGJlCGGs6ZR5Tkr/v+A2Nti5mRxz8BIccjCtP96j+q6iESA3sXaqv4QDRwsptvyseSCipTReW3Mus9acWmNy7r/M+UW+7pjWJN69BOolwjr579hQnRu6PICb3nwfA/NFrRH1FlvmEVsLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578265; c=relaxed/simple;
	bh=ws+1InrmhUma9fc64ZXG8y61cOhUI8SBlb6SItvojkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3qI8+FwGrTnJaNor5YlLkmvrLVMwGHMpGo3NHeDAlcHqD9e/yjTA8EJkBJhscdNVG+0hwcfXrjJL52vZSRzPVwYh+0cqmFB5oMWJFUt6x8XkY8rmYh0RVO1RKOVKlN+yaqQNKNCe7UcZvRVxBrarRApYhf1FfqQWNdoxnglBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S5jiPQm7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S5jiPQm7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QBYJpD027919;
	Wed, 26 Feb 2025 13:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=NM2X6lTw/OSkrzDZOuaw2o8ET7uOo8
	VB1Ds9KIx42aA=; b=S5jiPQm7xEDrKcFIWVYHUh1VgFKPS9ydn2+zvvbRFlxzao
	ndkyhP+bgh/8KZv2gPo6r7nOY9EGzsjzjlooKc9Sm/5IV3GKBYhPQfBmeNroDwoJ
	89V/zeHkMISWZ3mWMJyf1xyPrmZcaOkBm+Z8Rj9iHAU5+QvPZYkMUaybxlfMq+WR
	RGiL5oPcSM6BhYR8n9gsUN3cGz1tMmepIKLMWFmX2Iu3SEjqyvpxfy+3Tvyx8gnP
	wwGutsJdwEr7Z2kbVVDG0kOkaIuakRdG+bgfYvj6lhR0j8a99lzMicRtlj1RuSjT
	7zwvQ2xn6n3noTR/V/OUlznJe9hPvtNgpgRz3Y6g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451q5jbg1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 13:57:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QB4qxE012735;
	Wed, 26 Feb 2025 13:57:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwsu62k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 13:57:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QDvVhe54198710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 13:57:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CA9020040;
	Wed, 26 Feb 2025 13:57:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E614F20043;
	Wed, 26 Feb 2025 13:57:30 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Feb 2025 13:57:30 +0000 (GMT)
Date: Wed, 26 Feb 2025 14:57:29 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v3 5/5] selftests/ftrace: Update fprobe test to check
 enabled_functions file
Message-ID: <20250226135729.23133A21-hca@linux.ibm.com>
References: <20250220202009.689253424@goodmis.org>
 <20250220202055.733001756@goodmis.org>
 <20250226105028.16208A53-hca@linux.ibm.com>
 <20250226084759.05a4d573@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226084759.05a4d573@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QxbrBEOusbeZdoXbAZ2qcOwlJ4fuUqkp
X-Proofpoint-ORIG-GUID: QxbrBEOusbeZdoXbAZ2qcOwlJ4fuUqkp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=489 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260108

On Wed, Feb 26, 2025 at 08:47:59AM -0500, Steven Rostedt wrote:
> On Wed, 26 Feb 2025 11:50:28 +0100
> Heiko Carstens <hca@linux.ibm.com> wrote:
> > # cat tracing/enabled_functions 
> > free_user_ns (1) R         
> > bpf_lsm_path_mkdir (1) R   D   M        tramp: ftrace_regs_caller+0x0/0x68 (call_direct_funcs+0x0/0x20)
> >         direct-->bpf_trampoline_6442505669+0x0/0x148
> > bpf_lsm_path_mknod (1) R   D   M        tramp: ftrace_regs_caller+0x0/0x68 (call_direct_funcs+0x0/0x20)
> >         direct-->bpf_trampoline_6442505671+0x0/0x14e
> 
> After I submitted the patches, I then remembered that some user space tools
> add BPF programs that attach to functions, and those will show up in the
> enabled_functions table (that's a feature as it is always good to know what
> is modifying your kernel!). And I figured it will break this test.
> 
> I decided to wait until someone complains about it before fixing it ;-)
...
> > 
> > This could be worked around for example with something like the patch
> > below (against linux-next). But no idea what your preferred way to
> > handle this would be.
> 
> Actually, when I thought about fixing this, your patch is pretty much what
> I was thinking of doing.

Ok, I'll send a proper patch then.
