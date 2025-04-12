Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C235170A23;
	Sat, 12 Apr 2025 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744491681; cv=none; b=W4N+BS2GL1PS32eCiyWYHry6vdBrZWyPnYpHluGytTUx4uNJVPTUaQbFTSbWte90DBk60qwfaunFTL+lM8fgc3mkuEbX4Fte04xYxo63Wn41qDHP255Jo2v2zKyjEoCFw0j54s/3kb2P0sz7WVi+IRLpZbYr0UWac5BnpXlj2Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744491681; c=relaxed/simple;
	bh=d1galf7rq47D2V+U+ZwTUxOcqWMuUopO+i2tZEem29U=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=smCuqepbyZ9hmBpNguyZmRSurDVyk+dNY5kPlYRRkz5kkW7O3p07+Tzxv272iWwd1GUFX0LfQcRFYaVH8JzmAGvXgDKTSlMvBWSzShie+UD5ZCmc0VhgN7Skc11H0i08Q7h0XamGNVB3SDxw4u3AoRs6Qd7S66ZqpTVIK7EukfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PFamEBUy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PFamEBUy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53CAfZlG012330;
	Sat, 12 Apr 2025 21:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/NX5mR
	K47P4P75OQ87H50QkPcpvtLBppnFCwMfUk9RU=; b=PFamEBUyFdhFaoeDICx/+Y
	zfThffxzbE71885Rfp7V/56uMaxKbnsBv6lAKjEFOrlLF7AN/cv2LbkjdNyu1tEv
	ohBrr2DEVvkMJpGvguU27KFkJbrGh7bUQ+TU+jTayR2TtatvLQqkvZPHJs5qJoij
	URStdflWl93zelTsoZtI5jb1j3NtYklCMRXoZY5WNMrfQIF19kvU+xHOkMPCbxZW
	D84cogS/k64SrjBzrcx0wnI5XCDdw9BCylX0fzagovSVPuIvPsx2utyQG17rD1L1
	BNNZAhpNp5Xz1R0l/QngkjAIqMXC5i8AiBEgN/zkEZuwT3xu7oFpdOQiOfId6T2g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ypmp9vgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Apr 2025 21:01:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53CJrjh2022682;
	Sat, 12 Apr 2025 21:01:08 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ygu4u08s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Apr 2025 21:01:08 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53CL14cq12124698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 21:01:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B91D058053;
	Sat, 12 Apr 2025 21:01:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0424558043;
	Sat, 12 Apr 2025 21:01:06 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Apr 2025 21:01:05 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 12 Apr 2025 23:01:05 +0200
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] ftrace: Fix type of ftrace_graph_ent_entry.depth
In-Reply-To: <20250412120712.67fc45d9@batman.local.home>
References: <20250411172207.61332-1-iii@linux.ibm.com>
 <20250412120712.67fc45d9@batman.local.home>
Message-ID: <6bbd72b60478d363d03c268ce8095f8a@linux.ibm.com>
X-Sender: iii@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GhDraqYsm8_2RHLEYPasQeD9LutLceP0
X-Proofpoint-GUID: GhDraqYsm8_2RHLEYPasQeD9LutLceP0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_09,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=539 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504120162

On 2025-04-12 18:07, Steven Rostedt wrote:
> On Fri, 11 Apr 2025 19:21:41 +0200
> Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> 
>> 
>> -	F_printk("--> %ps (%lu)", (void *)__entry->func, __entry->depth)
>> +	F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)
> 
> depth should never be negative. Why did you use "%d" and not "%u" ?
> 
> -- Steve

I used int, because it's int in ftrace_graph_ent and all other events.
If you think it's a good idea, I can change them all to unsigned int in 
a follow-up patch.
