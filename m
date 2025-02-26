Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8791E1E06;
	Wed, 26 Feb 2025 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567050; cv=none; b=nSDL0kuITkdHbsi3rAIsLPczEt9kTfrWWI5rg9Dvu160de9OFfBQYEvMy8XeA8jXODhTzWHIw8qA9XSTnlzBPBYN/WBo9TO0J8uTjpy8YES8xvKLoB7U6P5uXHKAIWVtcRnio2MvSFkfZMQw39u5zhD1SQWdvRojCor9CDArvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567050; c=relaxed/simple;
	bh=j/lsfMgdXj4U0FmD8DOv1nxwAJF5yp/+dzneb1YLgsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h558v/o/GMwe2pQjH0WHqNoXqDURaG3C/OqSC8H1giZ8JDXf43e0eBcKDsd97pN9ySl8eKW9+Bal4WgX7yGCp+JeJRuRXP3tR4n+g/6HcoDRlribVpEW5/py2ViMlp0G/C752MIVAlJguT8yhvNvQGitAw7zAkNF04rGcyOdifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T7/X7BoS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T7/X7BoS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q6PdQl028521;
	Wed, 26 Feb 2025 10:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Sj6FPmDqgizR1Z+bfnuKYQu5oydtXc
	ls/cnkUdKywcs=; b=T7/X7BoSvV9QfTgWLe61QOrc8uRWYIRlu49CmSi36cQWnU
	9TD2r5sudIdeQpu1alswcvPWgc84XWac6kIZ0V/NoRbI+tHDaKmnKw/0spkv5qz6
	aWRi2Gt9jzkWYh5Nq3rXn+B7uq50B5n9zuSX54SI0R3SFYXBVKzv9HQ72i+OESHq
	oiLiYY1quXrIOvBNb1fPIA1v96gjQbkwYoVMOnAhZOWy22yjAuHxvN4rkPSfJOnm
	HnSNMUNEMITBnZKQ0L0ipcfasqCYUU5GPXOcZ28kRBA7WbJ8cR8TfCmi6cRLLDmk
	LxwXNBXq8ndC2yYYmFfXQNImEQji8bSg3EVlJjhw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451wp693tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 10:50:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QAPcWe027372;
	Wed, 26 Feb 2025 10:50:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum21rxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 10:50:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QAoUZv58523966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 10:50:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D0582004B;
	Wed, 26 Feb 2025 10:50:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10DD220043;
	Wed, 26 Feb 2025 10:50:30 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Feb 2025 10:50:30 +0000 (GMT)
Date: Wed, 26 Feb 2025 11:50:28 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v3 5/5] selftests/ftrace: Update fprobe test to check
 enabled_functions file
Message-ID: <20250226105028.16208A53-hca@linux.ibm.com>
References: <20250220202009.689253424@goodmis.org>
 <20250220202055.733001756@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220202055.733001756@goodmis.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VtondUeQLGDImSrNCPR2GLUOf1uEtfom
X-Proofpoint-ORIG-GUID: VtondUeQLGDImSrNCPR2GLUOf1uEtfom
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260084

On Thu, Feb 20, 2025 at 03:20:14PM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> A few bugs were found in the fprobe accounting logic along with it using
> the function graph infrastructure. Update the fprobe selftest to catch
> those bugs in case they or something similar shows up in the future.
> 
> The test now checks the enabled_functions file which shows all the
> functions attached to ftrace or fgraph. When enabling a fprobe, make sure
> that its corresponding function is also added to that file. Also add two
> more fprobes to enable to make sure that the fprobe logic works properly
> with multiple probes.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Tested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../test.d/dynevent/add_remove_fprobe.tc      | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
> index dc25bcf4f9e2..449f9d8be746 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
> @@ -7,12 +7,38 @@ echo 0 > events/enable
>  echo > dynamic_events
>  
>  PLACE=$FUNCTION_FORK
> +PLACE2="kmem_cache_free"
> +PLACE3="schedule_timeout"
>  
>  echo "f:myevent1 $PLACE" >> dynamic_events
> +
> +# Make sure the event is attached and is the only one
> +grep -q $PLACE enabled_functions
> +cnt=`cat enabled_functions | wc -l`
> +if [ $cnt -ne 1 ]; then
> +	exit_fail
> +fi

Bah.. :) this doesn't work always, since at least with Fedora 41 the
assumption that there are zero enabled functions before this test is
executed is not necessarily true:

# cat tracing/enabled_functions 
free_user_ns (1) R         
bpf_lsm_path_mkdir (1) R   D   M        tramp: ftrace_regs_caller+0x0/0x68 (call_direct_funcs+0x0/0x20)
        direct-->bpf_trampoline_6442505669+0x0/0x148
bpf_lsm_path_mknod (1) R   D   M        tramp: ftrace_regs_caller+0x0/0x68 (call_direct_funcs+0x0/0x20)
        direct-->bpf_trampoline_6442505671+0x0/0x14e
...

I didn't stumble across this before, since I tried a monolithic kernel
without modules when verifying your series; and then there aren't any
enabled functions. But with modules there are.

This could be worked around for example with something like the patch
below (against linux-next). But no idea what your preferred way to
handle this would be.

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index 449f9d8be746..b0f24c57b8e1 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -10,12 +10,14 @@ PLACE=$FUNCTION_FORK
 PLACE2="kmem_cache_free"
 PLACE3="schedule_timeout"
 
+ocnt=`cat enabled_functions | wc -l`
+
 echo "f:myevent1 $PLACE" >> dynamic_events
 
 # Make sure the event is attached and is the only one
 grep -q $PLACE enabled_functions
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 1 ]; then
+if [ $cnt -ne $((ocnt + 1)) ]; then
 	exit_fail
 fi
 
@@ -23,7 +25,7 @@ echo "f:myevent2 $PLACE%return" >> dynamic_events
 
 # It should till be the only attached function
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 1 ]; then
+if [ $cnt -ne $((ocnt + 1)) ]; then
 	exit_fail
 fi
 
@@ -32,7 +34,7 @@ echo "f:myevent3 $PLACE2" >> dynamic_events
 
 grep -q $PLACE2 enabled_functions
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 2 ]; then
+if [ $cnt -ne $((ocnt + 2)) ]; then
 	exit_fail
 fi
 
@@ -49,7 +51,7 @@ grep -q myevent1 dynamic_events
 
 # should still have 2 left
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 2 ]; then
+if [ $cnt -ne $((ocnt + 2)) ]; then
 	exit_fail
 fi
 
@@ -57,7 +59,7 @@ echo > dynamic_events
 
 # Should have none left
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 0 ]; then
+if [ $cnt -ne $ocnt ]; then
 	exit_fail
 fi
 
@@ -65,7 +67,7 @@ echo "f:myevent4 $PLACE" >> dynamic_events
 
 # Should only have one enabled
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 1 ]; then
+if [ $cnt -ne $((ocnt + 1)) ]; then
 	exit_fail
 fi
 
@@ -73,7 +75,7 @@ echo > dynamic_events
 
 # Should have none left
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 0 ]; then
+if [ $cnt -ne $ocnt ]; then
 	exit_fail
 fi
 
