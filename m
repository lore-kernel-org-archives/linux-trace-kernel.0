Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B3258CF5;
	Tue, 27 May 2025 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355457; cv=none; b=R2qBCTAW8XjlllVsZKEkWYAWIfSdqYuVSBcbS+r4tJ8GODfXCr+atplE/BVvUzhfTIxlZvEhjP+SjIVLih7XnCOT9RGslaUM0trdKssQcoadmV2wtFNk1aTJgFE3hzEPc1RmNkgBuSXA52WsFc9YZmDWn3bxnWKpJeWn5OZGf+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355457; c=relaxed/simple;
	bh=ahFl9aCQqEQb7ktYvVw2ExzugFahjZxmir57oh1c2Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDYMNKYG4buX7/PYV2EZyRJASq0DCLVxjK4btwTlshTEKnX8Rlr4OVjrlb5OPQanqJYn7lpFOZ+YX6Rg7qLJZ+gzai97h46Lhwtaa8aj01rqTP63+GR8f5N+VOlhzD/rp3XU4AxthUnyevdMno0gvJhQalRg8N3jCwA6ZmK2g40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gWmeq+dR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gWmeq+dR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R3ZVhm025612;
	Tue, 27 May 2025 14:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/gzvDF
	7B6Gpe874ER1+xVQsIaOStUNi32ktHp53rVmA=; b=gWmeq+dRJWBX0BS5VbHuEX
	g7i9HlXi1e79dSGX9PFLF3ir9TD0kCBWoEViA8DxF8zSSUk6BstkRPSoEJpInI5U
	GKaM38yQ2qSegGYcAsbNs3ViZyMCCpYq3jEd2XpZPf9VX5Xm3tyAgeux9zuGyoJs
	efB6CZLjSAu9F0f7ww9TxN8OKh1u7MQVSb8KiQtz1IT+HwnwQSpgGDmaMaNpHvN1
	ozX2FADbWWoEcZwpD7MXXgDmGLXwhTTadfSC8kDG0i5x3YF6vq7GwB6SN8veBP6Z
	WI8Y8EYlrnJ28t0ItqIfJD+QXlgpV+RDl/94UQs3R66PHT8qDNUR3mRy2H9RCxIg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46u5ucpsfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 14:17:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54RD4rwR016174;
	Tue, 27 May 2025 14:17:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46uru0k2ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 14:17:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54REGwO559703688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 14:16:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E670A2004B;
	Tue, 27 May 2025 14:16:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CB7120043;
	Tue, 27 May 2025 14:16:57 +0000 (GMT)
Received: from [9.152.222.246] (unknown [9.152.222.246])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 May 2025 14:16:57 +0000 (GMT)
Message-ID: <0219c58d-6375-4f98-84bc-9c65c1570aa0@linux.ibm.com>
Date: Tue, 27 May 2025 16:16:57 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] x86/vdso: Enable sframe generation in VDSO
To: Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf
 <jpoimboe@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20250425023750.669174660@goodmis.org>
 <20250425024023.173709192@goodmis.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250425024023.173709192@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7oosbzVA6NumzN8mRLM6lgUJM9bg-qYL
X-Proofpoint-GUID: 7oosbzVA6NumzN8mRLM6lgUJM9bg-qYL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDExNSBTYWx0ZWRfX8PfJfOKfRNYv /xwu3Lc58d9K5KexAtv+cxtyW+Ex/AuVKG5X8TLWnGcl/AmPc5Yf9Y1dR11pIHYE2J6QcxSvRHk GqZzt63+u3Lj8HXub2EN1CUMnwgz3bDyeaOiYtTPU2vpmbQotv7XPF8Uf30JIF4doix67XcwQ6P
 HKxt1gSG7GZ9s+C6Te8pMwvwTntCHFpdkhoNHXJRORuJk1mrpKTc63jP9yWCv5Y7hGb8G38mSXg KqEmXBkKz5UnsJu/DY0IGeKcseYhxW52eiHco2J0MDozvGOqW/ONN+B+mn7xFMM/POCyIpya+O4 gK0gMSj6BcyXF5acxvVoIlcdZ+iMo6g12gyr2MQqEcYKAIVYw24LqL52QusONZhLY8IBKX97phT
 WKa7JKwfiE5biT0HUB73IujEVxnNfwlweGwSbA9P+LO2tCnMS9OavPg34+rN3KHxS8fD8AD+
X-Authority-Analysis: v=2.4 cv=fJM53Yae c=1 sm=1 tr=0 ts=6835c95e cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=VnNF1IyMAAAA:8 a=0MvmVg10__VCTnNSAJcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_07,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270115

On 25.04.2025 04:37, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Enable sframe generation in the VDSO library so kernel and user space
> can unwind through it.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v5: https://lore.kernel.org/20250422183722.919601983@goodmis.org
> 
> - Replace $(comma) with a comma in the Makefile
>   (Jens Remus)

> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile

> @@ -47,13 +47,17 @@ quiet_cmd_vdso2c = VDSO2C  $@
>  $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
>  	$(call if_changed,vdso2c)
>  
> +ifeq ($(CONFIG_AS_SFRAME),y)
> +  SFRAME_CFLAGS := -Wa,-gsframe

Nit: The GNU assembler (GAS) option as of "as --help" and "man as" is
"--gsframe" (with two dashes).  But as GAS uses getopt_long_only() it
accepts long options prefixed with "--" as well as "-".  I don't have
any preference.

> +endif
> +

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

