Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C58225765;
	Wed, 26 Feb 2025 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583731; cv=none; b=ShnlLQpv5oBIWczyo6SMSSDaf3xEjV2X+fPRrZZJGWK5ChFgyPAAw34p/SKC7dfmzPcvQMF1RgQi+b7gVphkT7yvDprbChfY5w5mmGprOFBkueVx8uz/Lv8Dfl3zShU7ir77aeHLL89BmvJt+Q5Pjl+t59R0MNC/zCa5VXYqxes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583731; c=relaxed/simple;
	bh=VM9I5nf065I8fnnLyyQf7REZw13uxwQJKBYV4xFx4ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIzCB8zpw1ZE+EH+QIKu/kuGdWFcv+eOIPkei6H8ISc37p3CbaN+zZdK9M4zxRJP5eda+PbfUBT1JHLrB8zbXIQxtw+xTu9C/teebwyHMW6q6Hj0VCh8jlh/rK0Et/VKdPVqJQ9tfkNgopLAqStqPnWZ/WyHhCnJRMp8AYjSdoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZWif5UKp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZWif5UKp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QC3YBl011835;
	Wed, 26 Feb 2025 15:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=KRgrU4A1VYTDq8Ci0BpTJNNd91va9E
	GiZLuXXspm07g=; b=ZWif5UKpel/mwtT2JewjQCnsRXXAs1UWeBOIJ61pCL077F
	NH4x5r3T/3sn/aP3OzvkdiWKSxgt7YRPGcgJWk8XvyO9MaGUr9MsMVkS6HAd3L48
	I+8X5ET9yT9Kc6f+KMUK7D4kwQ4Vl/4ID11PIXlgelpUV63R6wPUus+7Ufg4XA+/
	yn09WPEfXBkVnl+U1VZfzhgVxFmhBjLSy7L0YNd39MV0bEiJ8v91YvSvSrUPvug+
	XbAv130hHzSBAMDVAl78d0yAaVGpnS/TeJZeV9BVoCDZenE6TAzZ2JdI8g8aQ08s
	t8afw7aQiw9e0L1jMRVaMUQOvObhpXameq/nfZuw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451s19bh5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 15:28:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QEx7Ah012515;
	Wed, 26 Feb 2025 15:28:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ys9ykh23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 15:28:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QFSbcK33292596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 15:28:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E659420043;
	Wed, 26 Feb 2025 15:28:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B367820040;
	Wed, 26 Feb 2025 15:28:36 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Feb 2025 15:28:36 +0000 (GMT)
Date: Wed, 26 Feb 2025 16:28:35 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Let fprobe test consider already
 enabled functions
Message-ID: <20250226152835.23133Bd0-hca@linux.ibm.com>
References: <20250226142703.910860-1-hca@linux.ibm.com>
 <20250226235447.7fab8051b2968277ce6920db@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226235447.7fab8051b2968277ce6920db@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u5n1Pw95785qS4QIXj8bi7KFPKJZm7pb
X-Proofpoint-ORIG-GUID: u5n1Pw95785qS4QIXj8bi7KFPKJZm7pb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=591 mlxscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260119

On Wed, Feb 26, 2025 at 11:54:47PM +0900, Masami Hiramatsu wrote:
> On Wed, 26 Feb 2025 15:27:03 +0100
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> > The fprobe test fails on Fedora 41 since the fprobe test assumption that
> > the number of enabled_functions is zero before the test starts is not
> > necessarily true. Some user space tools, like systemd, add BPF programs
> > that attach to functions. Those will show up in the enabled_functions table
> > and must be taken into account by the fprobe test.
> 
> Hmm, this ftrace selftests has been expected to be run without 
> any BPF programs... Is there any other issue on other test cases?

At least on s390 all tests pass now.

That is of course except for the "add/remove/test uprobe events" test
where I sent a patch. Not sure what will happen with that one:

https://lore.kernel.org/all/20250220130102.2079179-1-hca@linux.ibm.com/
