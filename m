Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981553B0584
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340279; cv=none; b=RAH2dx9qD4f/lGSzM9n2gXbtH+CfWMzJQsaNspQ+Z1YdhrcwLwLkYpSuQkDLxwCT70l4HQHmVAYvT1SbuTlzgxSxw4D3HHKZjbuSYDdjUM7G5ZWNz0Wd4IIUC7+uIapLNckd297NHaMRlEFgIoNcZSwXLMssDS5gewrxspVQirc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340279; c=relaxed/simple;
	bh=PFYS+vQPfiFQeDUa1KgTnTeG8ROhjor1xALOuf+wUr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPzQyES1JZzqDag/ezaEdePUsLDjRiGwgo3D83gftaRrrHmN7VbKrgXK55FMHZj6LaAFzDued8XOVhSrv0BY60xDDfChEpYULMf5g9zKJYbf2a1wwVfdcF/A+rMpwvABwYOQRJogx/fpfc626q/OuZkr7HlnBIzsAGVmPBJdblE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rf9LfqOZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rf9LfqOZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFI4xd357356;
	Wed, 29 Jul 2026 15:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bnPPyV
	/qBI3V/luwaekwNji/9sQof77Dnds9fONgT/o=; b=rf9LfqOZ/ntRPvFyTxzd0F
	NOWS4qLkHapK1yvitua8qNLVRRQ8VBIlEZoaL2O2BzYVqq5gque0tIytQrer7kWL
	J3Okb48Rr+/MpxBqIeBjumNhM+tuFPGcqs9axcToYMRClNRqmiJLu91Pu0oxTU8Z
	fb855PC6BGbwA5e7eySfZbNpNg91pDuMXMtZGJsimg06RQ/2J/YhnXJZqxM3gDkt
	6VJgWfKMLcHehDkNZScYSeUapMXqSszPim4Aq4jSJkNxuYSDZ+bNg/Wz/zf60o+K
	3KE8HM8LksST+MgS5UVi0BEWosEtmv5l5FnUqnmVexxpudeibHqL9Xlq4gBFLiGA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7kg0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:51:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFfIAw013753;
	Wed, 29 Jul 2026 15:51:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhf8fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:51:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFp2el29819486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:51:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 888BD20043;
	Wed, 29 Jul 2026 15:51:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09BDA20040;
	Wed, 29 Jul 2026 15:51:02 +0000 (GMT)
Received: from localhost (unknown [9.87.133.185])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jul 2026 15:51:01 +0000 (GMT)
Date: Wed, 29 Jul 2026 17:51:00 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Paul Murphy <paumurph@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, sashiko-reviews@lists.linux.dev,
        Paul Murphy <murp@redhat.com>, ojeda@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-trace-kernel@vger.kernel.org, Jan Polensky <japo@linux.ibm.com>,
        Eddy Stefes <eddy@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] rust: enable fentry support
Message-ID: <ttiy1d0@ub.hpns>
References: <20260724170132.3783816-1-murp@redhat.com>
 <20260724172024.0648C1F000E9@smtp.kernel.org>
 <CALYDSrQhUbKDHsPnQqp0K4WMe2iZC-G1nGrLT6eQ9doCqdVXKQ@mail.gmail.com>
 <CANiq72nJ=7TAjtArF2VzDZqwKDcuMFjeisD25R2GuA0NiJwk-Q@mail.gmail.com>
 <ttiwqgc@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ttiwqgc@ub.hpns>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _D4GtPgdzIvyQhGVsZe-LXKz_tq7PaQH
X-Proofpoint-ORIG-GUID: dJ2IKBnaJJSCzgqPBfGq7jqk4KipHYiA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNiBTYWx0ZWRfXxNwAWl+OZQm1
 LRuus+5Rr+tvTrj0Uq0QWywC3gLOgYpystXS9y0QQTS1Iov7zTz6502OKBRSk2mYGZvpd7u+vb4
 lc5L1X9gNmzEtrVltP0DynxPekR5pasPFtWGkIsRFqq2CYSugX6vZlVOCelSAmg9vPPcbAllpEu
 plxfTfQY7BEIgcAtVr9+J4G9O5mxjx5XZq2zW6HYLgecRerhSEma8PB88/nIeaBKB0VWYGosmaf
 6Jzv6v1MFAYMuljtWa7YGWknGHsapV0Voyu2pqrh+LgMlglxP7X/djqBqGuleHM/zhcxSDYDcca
 Tkkfcc7ldUQVVy+eD55fNxZWCdXXAnBnXu1Mns5hRYhi8bGpOiju8qMhcmisZeYHSDt65exGn7A
 +g3ZuK0D/R0Ca45DrHXPKTQrpQ/pFBc9uFHsMpcSL9eBCZROoWAuRnAzfwkShHg9eRlMsFG3ovW
 HGVslkH65wN1LTnD5Xw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6a216c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8
 a=AWlmS-Qe9MXJau6VXO8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNiBTYWx0ZWRfXxjG5hN7x9aIL
 IfUFXlVEBtek7+EWxPU8XVH4vHwnbcimWxWVhmmTvx4VAJUC5ldhZ2xi7z3RnLjyrWW3v6mpSx1
 5soh3zACftV/abvKxaW+Acs2fXDw4nQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290126

On Wed, Jul 29, 2026 at 12:57:48AM +0200, Vasily Gorbik wrote:
> On Mon, Jul 27, 2026 at 08:33:35PM +0200, Miguel Ojeda wrote:
> > On Mon, Jul 27, 2026 at 7:18 PM Paul Murphy <paumurph@redhat.com> wrote:
> > >
> > > Hrm, s390x has more nuanced usage. It still uses -mrecord-mcount and
> > > -mnop-mcount. The x86 configurations I've looked at use the kernel's
> > > tooling to nop and record as needed. Is there any reason s390x cannot
> > > use those, or should rustc support those (for s390x only)?

> So I do not think -mrecord-mcount Rust support is only needed for
> s390. The Rust build path needs an equivalent of -mrecord-mcount when
> FTRACE_MCOUNT_USE_CC is selected. And additionally an equivalent of
> -mnop-mcount for s390 (this is debatable, we could check if this brings
> us much or we could drop it).

Ok, I refreshed my memory on why exactly we stick to using -mnop-mcount:
it is not just an optimization that saves us a few milliseconds on the
initial NOP conversion.

s390 deliberately uses the same six-byte disabled function prologue for
both supported compiler paths:

  older compilers using -mhotpatch=0,3:
    brcl 0,0

  newer compilers using -mfentry -mnop-mcount:
    brcl 0,0

Without -mnop-mcount, the newer path would instead emit:

    brasl %r0,__fentry__

s390 would then need to support multiple initial prologue formats,
provide and export a no-op __fentry__ implementation, handle its module
relocations and PLTs, and distinguish fentry calls from hotpatch-generated
NOPs during initialization. -mnop-mcount avoids this and keeps the old
hotpatch path and the newer fentry path binary-compatible.

Since LLVM's SystemZ backend already implements the "mrecord-mcount" and
"mnop-mcount", teaching rustc to request those existing backend operations
appears considerably cleaner than reintroducing multiple s390 prologue
formats and startup conversion.
