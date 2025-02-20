Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B824C1DDC3A;
	Thu, 20 Feb 2025 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052394; cv=none; b=DHyz5yfxXWRY5FDphI4IgZmhmJ+zDjRhURjj/sa4KMf3idQqL+yFNWA858+UXqIQ9Dhoe17005fPBfHoLGE52HSBaYXTjMbhmETWXGQChr7yxog8bj4hNqtVZ6JrhsWlj6wNS8xqjmgCORXzlYsn6dcoETMgXsLZdcgoisR45z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052394; c=relaxed/simple;
	bh=tpyBoxI5qMXzINsVgoVISpA2J5RByzXnSUPMqHuNecU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkA/1ao9aeuQfZtgaT2tt9sPxVlHytwplVyx7Q8BGxXXHmm/WyYNls4hBj1rF/lDo/BRUwPU8QpR3oiOwG4BFbA8Vf7LNMFpeu4D7tZ2a79qkJjeLbeqcMT2GXdjLPA0a5m1vFYR2gMT7byTqT3JnrEjpbKB8efi5T4yOvkyiL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SKorP5qD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SKorP5qD"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K9P5R7007707;
	Thu, 20 Feb 2025 11:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qOTIXEgZBdBPbP5wfG94fNSYaqQcZk
	oqvNhtqiQLdwo=; b=SKorP5qDur+VyH4yz+WCL5dWRAb+oHbOz2my0W0fXs7BTh
	f+/JJhJJbB2/Fkj7y76VKRENKdc6B8tZpzRvK2Usl7lIl8qvXfNSLclYorP0Uh4H
	Xjgwx1dzIcSYvKFoAyo02H50DB1AozzB5vhUpSIz7blg+1DCuan/RWRS4owHtdrs
	q0zNZB8Mi6218PBcyv8SpnHByxFG4NlGi/odrEtHqA6HsdzWek4ZBc3iu2Vw0p2g
	FCPA/TRY/nctoXGuyW58VA3brA/klgEyqZhHdAOFkefW3eJWM59mbaIICD7twGqo
	xYuibX5C4ZDPHIBxCjGi5z/bdjbxT9qSX/IKt7KQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44x1qy8nrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 11:53:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KBPV2q030147;
	Thu, 20 Feb 2025 11:53:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01x9u0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 11:53:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KBr0GL31260980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 11:53:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CA2E20043;
	Thu, 20 Feb 2025 11:53:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58AD420040;
	Thu, 20 Feb 2025 11:53:00 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Feb 2025 11:53:00 +0000 (GMT)
Date: Thu, 20 Feb 2025 12:52:58 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v2 0/5] ftrace: Fix fprobe with function graph accounting
Message-ID: <20250220115258.7558Aa9-hca@linux.ibm.com>
References: <20250219220436.498041541@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219220436.498041541@goodmis.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PnCLRCC862pKH9cvgqtn4oeWul4Fd7J2
X-Proofpoint-ORIG-GUID: PnCLRCC862pKH9cvgqtn4oeWul4Fd7J2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=436 adultscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200086

On Wed, Feb 19, 2025 at 05:04:36PM -0500, Steven Rostedt wrote:
> Heiko Carstens reported[1] a bug when running the ftrace selftests.
> After running them, he noticed that the enabled_functions file had
> all functions enabled in it. That means something was registered to
> ftrace that shouldn't be.
> 
> The issue was with the accounting of the new fprobe logic which was
> built on top of the function graph infrastructure. Patch 3 of this
> series is the fix for that bug, but while debugging that, 3 other
> accounting bugs were discovered.
...
> Steven Rostedt (5):
>       ftrace: Fix accounting of adding subops to a manager ops
>       ftrace: Do not add duplicate entries in subops manager ops
>       fprobe: Always unregister fgraph function from ops
>       fprobe: Fix accounting of when to unregister from function graph
>       selftests/ftrace: Update fprobe test to check enabled_functions file
> 
> ----
>  kernel/trace/fprobe.c                              | 12 ++---
>  kernel/trace/ftrace.c                              | 33 +++++++++----
>  .../ftrace/test.d/dynevent/add_remove_fprobe.tc    | 54 ++++++++++++++++++++++
>  3 files changed, 82 insertions(+), 17 deletions(-)

FWIW, I can confirm that this fixes the bug I reported.
Feel free to add

Tested-by: Heiko Carstens <hca@linux.ibm.com>
