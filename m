Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DF42F2E;
	Sat, 26 Jul 2025 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753539394; cv=none; b=aih5ndCrNKB8UR8gVPBc9B109MrrpZBDDGC4l6w4m22yUGmVMVISJZghpzfTiKXxOEoD8TrembAo7z+CQAHN79yDnqvu8FhdyZVy5xnYoVDZO/RJSdT3rFggIEO1L8Gq6jkZjZAl5soKWjbBDmNvg+zFVRN8WiPskjbfZcISbFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753539394; c=relaxed/simple;
	bh=OYw2EC4Nk6dVoHq79Zccvq1CMs8v3h7XOUD1SHwa/lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKcfGiLI4bCmEDHkS97RRxBECJDysD2Q3QC061E2UDpJnUJeOdjiypgjKSL0EHqaAy+Oe//vbtbWa6Hx6+8Ffk5OuDXsDh6tytS+kwcitG7XTPI+kU2Xwz0NCUFZyKoBj+aak1feGuASnWtRcH5KkcElxS7XRklG55BXY1Y1fv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ohBTbFBd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ohBTbFBd"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56QEFYHO025639;
	Sat, 26 Jul 2025 14:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m4WMh1
	T5qEZ14i2wktI5urCi5smka4mqDvCq8eIjikc=; b=ohBTbFBdgfVA/EBXL19vJy
	4ql/lkZQZAgqmNoJVkuAg+QdseOvuMbWYhjuS6egpYRSOH8hHGBPbJG597tqpWuK
	cBZGHGH4vLewpfVSn4lFPhRizhoXroe6pCbPr1W3RFVWy7W4XEVFo3UrkVtCN8xk
	E6gavcePKa9H0x0Zh42r5+V/F7iyeciMUzFdoULMwxVDl8dO87I0NBjHOdYbXdz+
	iAO2B7ZCQA1ohUe6n7dsSL+r7mNPAn3fehr+9V+mXO67wLPRHo3b6zz/KqD5n1d5
	g7hO7b6Msdkm8Y1b63ZXBWLhk0w26Oy3Bg6uDqfJAujRhvqUHseQ9esz7FsM1Jww
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qd1sfw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Jul 2025 14:16:03 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56QEG2Xu026543;
	Sat, 26 Jul 2025 14:16:02 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qd1sfvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Jul 2025 14:16:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56QCIs5b005812;
	Sat, 26 Jul 2025 14:15:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 484t2w174a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Jul 2025 14:15:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56QEFlRQ34865806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Jul 2025 14:15:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12AF220043;
	Sat, 26 Jul 2025 14:15:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AA1620040;
	Sat, 26 Jul 2025 14:15:44 +0000 (GMT)
Received: from [9.43.49.31] (unknown [9.43.49.31])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 26 Jul 2025 14:15:44 +0000 (GMT)
Message-ID: <12112eb1-3ece-4968-a277-4c035c7d0010@linux.ibm.com>
Date: Sat, 26 Jul 2025 19:45:43 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] powerpc/fprobe: fix updated fprobe for
 function-graph tracer
To: Aditya Bodkhe <adityab1@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, venkat88@linux.ibm.com
References: <20250722085648.1640-1-adityab1@linux.ibm.com>
 <20250722085648.1640-2-adityab1@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20250722085648.1640-2-adityab1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zHR_0VfeDZSOBo--V9nLxe7u8hifTIlQ
X-Proofpoint-ORIG-GUID: 23MutpeS0dypybJRuzXv5GGf0hz0rw1e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDEyNSBTYWx0ZWRfX0z+Cr3N/g3n3
 9SLuy9MwMXfz/J54Si9X9iM5yO4UIgX33J6BP41iTvWaEOjqPuvmGMjesAWSAVL0yXAwDhDOAxT
 mdmOmZsSN7Ax87uHycwysDcm37m82gv1JP6UQvoYFRJT+B27xbIqysHnunil5ly9JV/MvfDElfy
 5u2GtXnPCB8a/e/UC4BrrS6wkEoRWuflpDwupERgu3WDSHVxcp2hdePyUwPFw/amMW9JXndJWm4
 UCzgUU2cKZHVp7gZlP85Xmc+m2r0MhmqiXrl6R6/G0Xz/je9XboHBu2TRR7emWXSh/1ancXqCIE
 qQzc/HViU7xr//T5q3mP0lEGTyn3xiSYXVEMQwkBa1PdoLQHGoj04oZRxFQLF8/k+cCjp0km56D
 9N/87mYb5u7EL2Fvo8LFt8d2+SaJiJp7EcIE/f0ZGlwAuqWQVbVBwkbFztOhYFzeWdSn7bNY
X-Authority-Analysis: v=2.4 cv=RYWQC0tv c=1 sm=1 tr=0 ts=6884e323 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=hjLnkWndKg4kFgHkvr4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=920 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507260125



On 22/07/25 2:26 pm, Aditya Bodkhe wrote:
> From: Hari Bathini <hbathini@linux.ibm.com>
> 
> Since commit 4346ba160409 ("fprobe: Rewrite fprobe on function-graph
> tracer"), FPROBE depends on HAVE_FUNCTION_GRAPH_FREGS. With previous
> patch adding HAVE_FUNCTION_GRAPH_FREGS for powerpc, FPROBE can be
> enabled on powerpc. But with the commit b5fa903b7f7c ("fprobe: Add
> fprobe_header encoding feature"), asm/fprobe.h header is needed to
> define arch dependent encode/decode macros. The fprobe header MSB
> pattern on powerpc is not 0xf. So, define FPROBE_HEADER_MSB_PATTERN
> expected on powerpc.
> 
> Also, commit 762abbc0d09f ("fprobe: Use ftrace_regs in fprobe exit
> handler") introduced HAVE_FTRACE_REGS_HAVING_PT_REGS for archs that
> have pt_regs in ftrace_regs. Advertise that on powerpc to reuse
> common definitions like ftrace_partial_regs().
> 

Aditya, I assume there is no change on this patch from v1. I see
you missed the Acked-by tag from Masami while sending v2 though:

https://lore.kernel.org/all/20250609164700.d8afe4ac1b4dea195bb7e379@kernel.org/ 


> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Aditya Bodkhe <adityab1@linux.ibm.com>
> ---
>   arch/powerpc/Kconfig              |  1 +
>   arch/powerpc/include/asm/fprobe.h | 12 ++++++++++++
>   2 files changed, 13 insertions(+)
>   create mode 100644 arch/powerpc/include/asm/fprobe.h
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 9163521bc4b9..2203e4fb64c1 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -246,6 +246,7 @@ config PPC
>   	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>   	select HAVE_GUP_FAST
>   	select HAVE_FTRACE_GRAPH_FUNC
> +	select HAVE_FTRACE_REGS_HAVING_PT_REGS
>   	select HAVE_FTRACE_MCOUNT_RECORD
>   	select HAVE_FUNCTION_ARG_ACCESS_API
>   	select HAVE_FUNCTION_DESCRIPTORS	if PPC64_ELF_ABI_V1
> diff --git a/arch/powerpc/include/asm/fprobe.h b/arch/powerpc/include/asm/fprobe.h
> new file mode 100644
> index 000000000000..d64bc28fb3d3
> --- /dev/null
> +++ b/arch/powerpc/include/asm/fprobe.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_PPC_FPROBE_H
> +#define _ASM_PPC_FPROBE_H
> +
> +#include <asm-generic/fprobe.h>
> +
> +#ifdef CONFIG_64BIT
> +#undef FPROBE_HEADER_MSB_PATTERN
> +#define FPROBE_HEADER_MSB_PATTERN	(PAGE_OFFSET & ~FPROBE_HEADER_MSB_MASK)
> +#endif
> +
> +#endif /* _ASM_PPC_FPROBE_H */

