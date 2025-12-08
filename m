Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159BD26B08F
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Dec 2025 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210155; cv=none; b=kUIy/gYvAP+tYF6C3+pTw8XD2dio6Xcg4Thr3v5KCGo5SYdhyX/bsQ3InQyJ4wocsvSfLIZoD1i7Fc4ls2XyVFgCqR0jHdLphB6kar6I+MZwYmralAmzV6jPZFz7YI3u42iA1r5roBpRvglBQ3h0iTmMeLwXGzMxMKrbpIH4u3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210155; c=relaxed/simple;
	bh=5wq/pG9NjW/Xc3CZ8gT2muSpid7LybWAcae+d1HITLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0zvUU/DKJWiq1E+3wUciMDvdogHpVnGAKcJNTG9lV4GqyLCYpG+xL5y5dfsftPucvF53jnXJtggSmFoKJmMPgdmOFb9kSI+ThnDKOB+KzjaRG6ApBHK4NQD79Ic8tAq7ym87rba6CfWZ1nHMc0wfneIV1tTR1WYzW4NoHr/c1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=giBTBVFx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="giBTBVFx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B86DSJx014598;
	Mon, 8 Dec 2025 16:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iilKg1
	8ysnmI4ONROC9vF2l+9+u4XZIiuBwCGpbDEgg=; b=giBTBVFxTzhTFiCP2XdhJ1
	CR1fit3AmQJqI1y/nNr9hb/jKW8odZM3EIt4kn8IZzIhiIEkSxG0B+FtE9/VbFG+
	SKzws/a+lV/js3DYIyJFKhnYTRa2INkCaqC9ROuPmj8lMQLcBy2DJFzhHxVibtCz
	nz1aodxs3vMaK/+IvpPNcaw6BFgjBYFMi+m3yHpzU/WaqsJVKhSHpp/QZhcW0IqZ
	KB2TGtD1VgXPx/jfIYcJvwKcQYGAPfxLCF/gGABxFhEQRBf89K440C52bGRJ2TGn
	L9WRBVUM5OSCoAtTU2gfGPE5BZukphlVXUe0S4e3UU3J5CO1KrnY8SKffhdpQeSw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc5383fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 16:08:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8FdFEG001998;
	Mon, 8 Dec 2025 16:08:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw11j6a7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 16:08:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8G8nEX55836948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 16:08:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C60E20043;
	Mon,  8 Dec 2025 16:08:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C4D220040;
	Mon,  8 Dec 2025 16:08:47 +0000 (GMT)
Received: from [9.43.1.23] (unknown [9.43.1.23])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 16:08:47 +0000 (GMT)
Message-ID: <874f8ec4-4f3f-402d-a9f2-4267d37a5bc9@linux.ibm.com>
Date: Mon, 8 Dec 2025 21:38:46 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] powerpc64/ftrace: workaround clang recording GEP in
 __patchable_function_entries
To: Naveen N Rao <naveen@kernel.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, llvm@lists.linux.dev,
        Maryam Moghadas <maryammo@ca.ibm.com>
References: <20251108210405.2375472-1-hbathini@linux.ibm.com>
 <20251108210405.2375472-4-hbathini@linux.ibm.com>
 <sjheprnafkraauotmi2fwjz6l6fha5te7jdp74t4zfh3jvs2if@vjpey276fsti>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <sjheprnafkraauotmi2fwjz6l6fha5te7jdp74t4zfh3jvs2if@vjpey276fsti>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX9VNsTMEkm0V3
 acsg7v1LTpLHtW9U1nkuRwh/sSfQ49XoY6HPI2267UdlTK7KkOM1vN7aRVq9IzbGlxSDf7iFNgr
 VYgv/k7Mstt68u3/Xa2UlCWSyYER6IDKDxjItOVdT7MBzN0kfY7j7DGbWUEbSHuKUZw8cqMN4RM
 VPRqb+diMMxpw2/3aXXfQvA7+IFN+HAdnCVOETLOz3iMTZ32DCpoUc/yJHsFV831aE9WN0tBgA/
 3CL06XiUmzNVWu92c+MAzm1zgZuWnyY+RbPodBqI0NJUqHc2xHExyZJ2KRN0ahJN/eX8KIaO4h9
 LJWQL3o4+7mOQM7tuy46q+MvJ883LTsrtzmr0A2W6W2+Ugw0a74+N5aqwKlId8ywLIS3hlaiZO0
 VVD6jffw16hRmjvkomzbisHCbFlmRA==
X-Authority-Analysis: v=2.4 cv=S/DUAYsP c=1 sm=1 tr=0 ts=6936f815 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=cFmaXs7E2_rN6eu18uoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nQw_vPY9gvYZw9Fvk4z581Q2D8Yku0B-
X-Proofpoint-GUID: nQw_vPY9gvYZw9Fvk4z581Q2D8Yku0B-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020



On 24/11/25 11:25 am, Naveen N Rao wrote:
> On Sun, Nov 09, 2025 at 02:34:05AM +0530, Hari Bathini wrote:
>> Support for -fpatchable-function-entry on ppc64le was added in Clang
>> with [1]. However, when no prefix NOPs are specified - as is the case
>> with CONFIG_PPC_FTRACE_OUT_OF_LINE - the first NOP is emitted at LEP,
>> but Clang records the Global Entry Point (GEP) unlike GCC which does
>> record the Local Entry Point (LEP). Issue [2] has been raised to align
>> Clang's behavior with GCC. As a temporary workaround to ensure ftrace
> 
> Any reason to put in a "temporary" workaround rather than waiting for
> this to be fixed?

Pushing for this temporary workaround as the fix ETA for clang is not
available at the moment and the temporary workaround is likely
harmless even on a clang version with the fix included..

- Hari
