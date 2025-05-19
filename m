Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C3720AF87
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 May 2025 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674666; cv=none; b=AzDiQrlBMd3ew+6DP6giFNqJ85fQ1bi/ybrtIgVdH2JaAaO0sLSO/h8qnaSeoItnuqAxjJJnKrpM3bF+BGd5q99TmhBbiEh3vR7BaBxic4W7ZLlqmJZpu5rIaoOFXvkmEui9nBNEKuo2qLZMSvYpvkSaWeCq34HMTqlInVRe1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674666; c=relaxed/simple;
	bh=5D8ltLKbU2Trcefi+l+ebfZAKCsH1UJ12kR0Cg6i+0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzRj0rb0GBN3yPMBT98v/J5tbvE01suHVm5bkTe3PbKimlpWLrQkBchPuoUP+Fwcu7X40iYq41+4M1Zv/5Myaggii+hAsLrdX5ZejGKb+VzAG/1OBcE5hxM+z/JDSGbFk6vtE8sVVPyPOGpCHGPFLj90eeooMGv+azgphD1zLAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ijLjxdGf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ijLjxdGf"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JFQCwx031634;
	Mon, 19 May 2025 17:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=beypuHdCw69nm2YkShoWBRKKuZFQKP
	zgwKnz4MhRABo=; b=ijLjxdGffk8QxAtbS1WIWz1QTCdafuna2xVUHc061qf2PE
	F1w1B/9iGv0hUsORiIWmwSbxvkQtWKlm7P6hAyP7fKPcjbm4h7hB2vvJ/57bFWmw
	jt7sVcvV3yCi/28hqut1DJBHtxJ8l/QrOSD5rqSQVYXYksbzQRY8tDyYfS2BOy5D
	vMyli4KRqlEnvzcpNYyO5FjZiFt/zrmf+PKCapCjqqm5hlMr8YAJtv0KpLJbhtHm
	/pUv7I+HVrao6rC8+8321w5Lk6FQrpGDyPT5NBIImL5zsnPKyEeqIN81inl+xpUM
	NpM3zOUINDNudkwzh6CCy0pV46zFJzRRNO04tDLA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46qn68n23m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 17:11:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54JDMUSq028874;
	Mon, 19 May 2025 17:10:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46q55yqvan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 17:10:59 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54JHAvqw43647446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 17:10:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A92C5200D8;
	Mon, 19 May 2025 16:18:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1E59200D7;
	Mon, 19 May 2025 16:18:11 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.25.94])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 19 May 2025 16:18:11 +0000 (GMT)
Date: Mon, 19 May 2025 21:48:09 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: Re: trace-cmd No such device Errors
Message-ID: <aCtZwafBSwT7Iz8L@linux.ibm.com>
References: <aCUCQW98EpmQg3zr@linux.ibm.com>
 <20250519103914.5d3a1074@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519103914.5d3a1074@batman.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u9dOnTojzUa9n0J7k4JAzUusMDeCS94N
X-Proofpoint-GUID: u9dOnTojzUa9n0J7k4JAzUusMDeCS94N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE1OSBTYWx0ZWRfX6xopANEz+/5z iChm0jfMaXn/4MNiU8/ym7TLUJnTQj/Px1LOOgEIYihg89x+XFj9rlGeNEKj5tv3Tr5LYugWo4I V0zrmu9ohXF3j0f0G+QGe6w1k51qUmuK1YcCpdGr4i6ztHVWkMo7BcoY8DX56hveMumWo6EGNKh
 2+pGURbijRPNOY4Uex2B05o7wEqb96ELwveuEWtsTqDGUK9YYpXds/zK3+8ZB4v5OZq100/TiTk pYmZQHuwXti2Qc5H/oVxpQksd3zh0PN35+JQI6sfLIpiHMxpCWm9i1xCHuPDqQ97Mf629SgOubr Xkxja9YXToZ6OGjUZ9x4tXhf/qYLb9jPDrBDFIbPUPWkhYYb7hbMn0KURRNRutiymZg60KH75bn
 dKLFVoxv+I+8idWVYxwpI3RWJJlvOP9vMANX49m+ggXLwc+na2l5dbAiGGpuDdnNQvJIjrf6
X-Authority-Analysis: v=2.4 cv=CN4qXQrD c=1 sm=1 tr=0 ts=682b6624 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Ft4cJDVOhizU3t99LqYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 malwarescore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190159

On Mon, May 19, 2025 at 10:39:14AM -0400, Steven Rostedt wrote:
> On Thu, 15 May 2025 02:21:13 +0530
> Vishal Chourasia <vishalc@linux.ibm.com> wrote:
> 
> > When running trace-cmd record, I encounter multiple "No such device"
> > errors due to the splice syscall failing with ENODEV for
> > /sys/kernel/tracing/per_cpu/cpuX/trace_pipe_raw files corresponding to
> > CPUs that are possible but not present.
> > 
> > Environment:
> > - Operating System: Red Hat Enterprise Linux 9.5 (Plow)
> > - Kernel: Linux 6.12.0-55.9.1.el10_0.ppc64le
> > - Architecture: ppc64le
> > - Command Executed: trace-cmd record -o /dev/null -v -e sched_switch -- sleep 1
> > - System CPU Configuration:
> >   - /sys/devices/system/cpu/possible: 0-223
> >   - /sys/devices/system/cpu/present: 0-63
> >   - /sys/kernel/tracing/per_cpu/: Contains directories cpu0 to cpu223
> 
> Thanks for the report. Could you also submit a bug report here:
> 
>   https://bugzilla.kernel.org/buglist.cgi?component=Trace-cmd%2FKernelshark&list_id=1152443&product=Tools&resolution=---
https://bugzilla.kernel.org/show_bug.cgi?id=220139
> 
> 
> > 
> > Steps to Reproduce: 
> > 1. On a system with a mismatch between possible and present CPUs (e.g.,
> >    possible: 0-223, present: 0-63). 
> > 2. Ensure /sys/kernel/tracing/per_cpu/ contains directories for all possible 
> >    CPUs (e.g., cpu0 to cpu223). 
> > 3. Run the command:
> > strace --decode-fds -kk -o strace/trace-cmd -ff -- trace-cmd record -o /dev/null -v -e sched_switch -- sleep 1
> > 4. Observe the output and strace logs.
> > 
> > Expected Behavior: trace-cmd should only attempt to access
> > trace_pipe_raw files for CPUs that are present (e.g., cpu0 to cpu63),
> > completing the recording without errors.
> 
> Can you show me what you see in /sys/kernel/tracing/tracing_cpumask
$ sudo cat /sys/kernel/tracing/tracing_cpumask
ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
> 
> Thanks,
> 
> -- Steve
Thanks,

Vishal


