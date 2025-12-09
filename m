Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE131E86E;
	Tue,  9 Dec 2025 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765271436; cv=none; b=N49+SNIBRO1jS76lstp8KUc2IRx5sRfyZ6K7Kwriv2oQCb9gB7RAJ/5JFBqKxeYTvWVViPlPXK2DP7f8vd1cbY6jF+0uxgxgNP/XPc/9hnZEVLN5I25YOKDicnEBlxa1raGMQ4lLUttm8d/QL3BRuzgPzwq+0v0tFXsmFktaOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765271436; c=relaxed/simple;
	bh=JeXiekyZWzWI15Y57pGWiSLifk4/kc68isUmJzMZDE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VoeGlLW/SvxDFueifw3P2au0glUcnRozB1pZE7yyW3t5suHj+IkiKpy4a5gTnxKNr0M+ykVrOeN5qRZo2mvijwG7vyeRWK4dFeOjOoKWWBwgt6dBRBzACpGWISAX5OKJcTE2edwEROO6UdyCxjXJbqyzMi/798b2bZZYceTvkNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ILc1Omh0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ILc1Omh0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B93StBd019550;
	Tue, 9 Dec 2025 09:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nJSSn/
	LwgyfkCiqTpIzrVduboe20THaPXqdH+i6uw1c=; b=ILc1Omh0xNtHRQBLxAXDCW
	5+vfte1vcBHRmbnFrC8+ghiAkqueiYjRZxWLe+c8IbX83w4vC7YSYJ85HSVV2e+1
	A7bw4cS8FwRVE3QWFJsO4s67TV+yETgE8hf35oD+nIrkSpFzyL4pY8GLgqsMlJTz
	cnmUpm/KxjfHaH20tzNmzjruVuew1RdU6LTJaLWAwLCt3+TDgP/xh6678m9A1r9y
	Rj61JZOgt3PHY28X+O7UknCdJNh7HnNPzd8C6goS8wu6UY5dZt+s0u2gPmY5mxDW
	K87ACDvDb87zPEvRKF0dtdSDAHZRehKodB+dmgvbx4SN0uB5+EVDRpCfiHxerBQQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0jv045-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 09:10:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B96UFAL028099;
	Tue, 9 Dec 2025 09:10:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avy6xt6gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 09:10:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B99A1Zv23659190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Dec 2025 09:10:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6400120040;
	Tue,  9 Dec 2025 09:10:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D13320043;
	Tue,  9 Dec 2025 09:10:00 +0000 (GMT)
Received: from [9.111.148.198] (unknown [9.111.148.198])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Dec 2025 09:10:00 +0000 (GMT)
Message-ID: <2da7ebd8-3e7a-4f62-a8ba-83d6363b8e0c@linux.ibm.com>
Date: Tue, 9 Dec 2025 10:10:00 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] unwind_user: Cleanups
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        x86@kernel.org, Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20251208160352.1363040-1-jremus@linux.ibm.com>
 <20251208193605.GG3707891@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20251208193605.GG3707891@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=6937e76f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=0MvmVg10__VCTnNSAJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kMzsA-GhXEDdA4ZMExQhrO4rR7EWjXjy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfX4NgQ+S1hiNOa
 K4p5LbsN0mWKtXjNkxjqShSSta7RHBzlcp5OVf/VBuP3d0n8oF5G3tZDIU++F+QmELEfcSIU6o4
 a1UL/0+AbLnnkv1JRE8xwTeIhKlPSri8ObLAaRcXRQUHH9CPzfMHXD6EX8zbdVNDtVYM+NMzbVD
 vj6jNqc0tC/bdu90GY8F+pZ2QQC9DbN4satSGDRD/fcH49Jcz4m1VJ6Z4UH2bJs/wKQcQzhtip5
 albBJTsUFuUzyYlJzxDqegaHQ01SZvbPS5kLaZDh9thwWIFy5yTcRzDUIUSEu2zV2ERqZ8wn2eF
 CqOMOaLkf6JbcRvjW/UK30Db1sjqJzi4qrl5af5+3ELMHMQzkfqhwJsz3VCqDpX6FAsxcx4MSvo
 2NS0c46r7cZIXKNJuTbzP8Dehl6FOA==
X-Proofpoint-GUID: kMzsA-GhXEDdA4ZMExQhrO4rR7EWjXjy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016

Hello Peter!

On 12/8/2025 8:36 PM, Peter Zijlstra wrote:
> On Mon, Dec 08, 2025 at 05:03:48PM +0100, Jens Remus wrote:

>> Jens Remus (4):
>>   unwind_user: Enhance comments on get CFA, FP, and RA
>>   unwind_user/fp: Use dummies instead of ifdef
>>   x86/unwind_user: Guard unwind_user_word_size() by UNWIND_USER
>>   x86/unwind_user: Simplify unwind_user_word_size()
>>
>>  arch/x86/include/asm/unwind_user.h | 27 ++++++++++++++-------------
>>  include/linux/unwind_user.h        | 18 ++++++++++++++++--
>>  kernel/unwind/user.c               | 12 ++++--------
>>  3 files changed, 34 insertions(+), 23 deletions(-)
> 
> I'll go stick these patches in tip/perf/core after rc1 or so, no real
> hurry with these, right?
Perfect, that is fine with me.

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

