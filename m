Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742521E00B4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Jan 2026 06:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769753977; cv=none; b=Ccth7Am5FIcwr5giD4EMiy6RX92FVIZQxGLandTSab7QUH60LOCrHEyu7mZiBbHtg10TjwFRLMKNX0/8EQi0bctnzlRsoPOHjah6/PGGCenR0pb+PFzcihEVQHpPyudEnv2e/9G7kzQKONotpD9XaMT79cZSa7ZB0N6B/8wW6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769753977; c=relaxed/simple;
	bh=8wVtX+UvqwmUQx+ae1bjga1544wbNn+UslnYtmm/o/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mqfg8Wjr38Fu0qp7L42EwVt8QrmemnuqyziY/sCevI0FjdmL/dfLXGO49cnKDCYwqyopGU9FIPYghVso4M6Ad+BKjGc3zhSL9dLApHmiKY5HmioD337NXGmXjToqzO07x20a2hzJtze9kse3OHHgMlxVirxhUjlyP+eojqUlfYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aXecpj40; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aXecpj40"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60U0EBqL015530;
	Fri, 30 Jan 2026 06:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VzpX+D
	1T4NO0rxBtsw/qAjafd/dtQvbYUw2Hzo6xLTQ=; b=aXecpj40VtzWrULkv2//g0
	DNm4evtQAxe6kErip5vck8OYSe8wT0dY8PZfUyYZBCXSjIWNUAU8DdOdkd8jH9zY
	v1169dU8uEZ/5kuLpQ/GK08+MWz3u5yCWCkyh3/YRiJvGgHJ/NckhVbjAci0AWAy
	wWcHYWKZICLRsDN7auFUZsjPRrhPvNV1ZKcjTHjBgBViUfISzuRtWI9bdSOG6IFz
	fn1bLvX2sw9hX5JWjqQnDNsO69zqcvIVKUlUMRtKrzJaXTzO0KmYgTlf+V9Q1OUx
	jkO7t3xBHIWJUnxbs0DG0DKfy6BQrP22sX2EQasUtKyJPQklHE4pz7vimMdSLBtA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt84k96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 06:19:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60U5tCbX026805;
	Fri, 30 Jan 2026 06:19:04 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wkn364-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 06:19:04 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60U6J3jA22872656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 06:19:03 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38E9458052;
	Fri, 30 Jan 2026 06:19:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF90558056;
	Fri, 30 Jan 2026 06:18:59 +0000 (GMT)
Received: from [9.61.240.86] (unknown [9.61.240.86])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Jan 2026 06:18:59 +0000 (GMT)
Message-ID: <a5bc60c3-ec63-4aa6-a455-20817a8e7cff@linux.ibm.com>
Date: Fri, 30 Jan 2026 11:48:58 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] powerpc64/ftrace: fixes clang build issues
To: Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>, llvm@lists.linux.dev,
        Maryam Moghadas <maryammo@ca.ibm.com>
References: <20260127084926.34497-1-hbathini@linux.ibm.com>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20260127084926.34497-1-hbathini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jEaW0EEztOdj0g1ZFujptFKA60au6H7-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA0NyBTYWx0ZWRfX4irutqbuq9l6
 2f5rYw2Ae1O/chIYka3uERQgrUQfpcsSo/s4xDAXgPtDXAnXWqrfJR9S5LAbfv7Dd9JY5FsQ/HF
 qI5g8U6uyiLmMFtFmBdns/PWRLOS54eMMcHHz5WNg4VheXRaUIac1xotA4h7CfxKsRNklEv2qSd
 5HPG4b74KzBhWzdPOITdIaDrIpHeU4eLVGB1CL+aeH3/jZbB6yT7z/eUJVCxown/wIona+05UDP
 0NbJ5MhLhOpWX94SBf96mQnuE6vMIMmeCb9EHwSOfiKLKNlODbSQkUAFp4EZeXt+2LjtLxFqNa0
 eDb8ScEXvQ4JxvfvEG7+g5sDx9JpXNi8Q0xEZA+eICGEu5p5MhsStP0EWLAqre+/EBulIqSvA+b
 0OvXpzW9PVji5SzCTi15bR6t0EfGPdR8SAorgbWmXcEZgijMlGighHSpfXccMWkv4wJEO+/UPWw
 w9jvT24x1raYN4SfzpQ==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=697c4d59 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=nOZgRAGxndUz1iHlvXcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jEaW0EEztOdj0g1ZFujptFKA60au6H7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601300047


On 27/01/26 2:19 pm, Hari Bathini wrote:
> Support for -fpatchable-function-entry on ppc64le was added in Clang
> with [1]. Faced a couple of issues while building the linux kernel
> with Clang though. Patches 1 & 2 address those issues. The last patch
> provides workaround to ensure, an open issue [2] in Clang with
> -fpatchable-function-entry support, does not impact the linux
> ftrace subsystem.
>
> [1] https://github.com/llvm/llvm-project/pull/151569
> [2] https://github.com/llvm/llvm-project/issues/163706
>
>
> Hari Bathini (3):
>    powerpc64: make clang cross-build friendly
>    powerpc64/ftrace: fix OOL stub count with clang
>    powerpc64/ftrace: workaround clang recording GEP in
>      __patchable_function_entries
>
>   arch/powerpc/Kconfig                          |  4 +--
>   arch/powerpc/kernel/trace/ftrace.c            | 26 ++++++++++++++++---
>   ....sh => check-fpatchable-function-entry.sh} |  0
>   arch/powerpc/tools/ftrace-gen-ool-stubs.sh    |  4 +--
>   4 files changed, 26 insertions(+), 8 deletions(-)
>   rename arch/powerpc/tools/{gcc-check-fpatchable-function-entry.sh => check-fpatchable-function-entry.sh} (100%)
>
Tested this patch series, and bulild is successful with both GCC and 
clang23.x version.


KERNEL PARAMETER enabled:

CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY=y
CONFIG_PPC_FTRACE_OUT_OF_LINE=y
CONFIG_PPC_FTRACE_OUT_OF_LINE_NUM_RESERVE=32768


clang version 23.0.0git


Please add below tag for the series.


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>




Regards,

Venkat.

