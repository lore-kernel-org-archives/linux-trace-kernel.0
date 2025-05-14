Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA891487F6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 May 2025 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747255886; cv=none; b=q1iAueFOiD4JZXVhLyp1mtWFSNXYFvNwRBXrcMrzW6h6c30XalRgvYMhRFAFE7nidWRk1tChDwYUfUWwI5VWxYZopgNhx5jBq8jr1buCcV2mvI4S8G4TL/naFm/ppVYVK/yBpsEBBhnF9M1PfVNwf0+7hzqM+MzwAYbstitg9DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747255886; c=relaxed/simple;
	bh=BxZdSrOm8D19pnErfeYs8eUz8Puf3eLUAL5/CerOkIA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o6Wx9HJz74XpIHdQgeA9JvVgpEuKD0AaysFahummtiqhbATrgGTVEouaATbN1XJZhu//fnRGiVG9YSwIZws/IeF5SgnMmtrGMO6ydchWQo2puuMpDRwolqus2z5dXfHQKZani+iGUobpih7Sjyn7XD9C1HC7zBl+5Y6o0BmGKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=co74CYps; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="co74CYps"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJTEGm004384;
	Wed, 14 May 2025 20:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=ieQAqunnNvrfLFYBsEVYugs4rqKdlkL/5UMw8gVg9YE=; b=co74CYps
	qTdZqdxvrFNcK+VbP/v7a5/XHvsdI40Ax3/yhfCtOkDWHqhdkIKyTIcgSe5w8KE2
	fOLPsEKqnqrSjbgBoO27mVqrZVe7oXfoqFXpMgr7nI6We3hzIyaI4gDMFvVmsGiU
	zZBkop5PTQ4iIkw2JdL0Unls+H+0bOXryWmuHtKBlI9F2pT8APqdwoUAhHiYDYjy
	9gsA90z/03lmr87mkNMh41D4bSD3S5W0IB2WsY91fuUYHYHWp9jNn+WICzVt4BAs
	Oqhlns2pc+oTIWnKFq0QUAMTn5SuN47DIN4u5wOS+A/lrBxUV3l6xy+It+lGjPoi
	k3jAQaV1JjuMAQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mvd3a944-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 20:51:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJnGpt026912;
	Wed, 14 May 2025 20:51:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpefp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 20:51:18 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54EKpHBf50725142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 20:51:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FA4C20148;
	Wed, 14 May 2025 20:51:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 303A020146;
	Wed, 14 May 2025 20:51:16 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.215.2])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 14 May 2025 20:51:15 +0000 (GMT)
Date: Thu, 15 May 2025 02:21:13 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, mhiramat@kernel.org
Subject: trace-cmd No such device Errors
Message-ID: <aCUCQW98EpmQg3zr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v3Y9ssGzLwKsqK1s1Vxlzp1aLeBllim2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE5MCBTYWx0ZWRfX5cdHXCV1iGz7 6oZIOMoUWdDUCpaXthzxNa3UVmLaLIbysu7RU88zoRNLhtrCZAywXErgQcWcp3Z01hrN5bqjgWZ E5kGUXaaDHJQuKhoLnSmjBSj63WafLAbr5v6Bo+gPN2M5TcA3i9Yf1/5X4F3HmOMaKbdTBdH7+V
 VOQsYHUZdDVD0CQ2Mv81SAUv6qDyG4UFuSs0tBzunBEbm5qymUuXHYBXDAq1WwtSse0/DCi2vyd Az02pqH280uw5Ve8kU92REm25azt3QJd/OpmO8dDpzOWuCZQuL0A+7UzNFLzS/Ur7ngR/PvIcRt JPp7SOWufNCrVCuVhBqMwkB067MxrREZZr5WyAlqpARse4xY0bhrA4cPF0qsisiIuTP1W2F1/9E
 ogLtHHa7iaW+NSY+6+L5q7NlH6fZPvhaW5eAfb3DsZbvGGsGIkxtSbsqfW/knVwHaQRsEZHS
X-Proofpoint-ORIG-GUID: v3Y9ssGzLwKsqK1s1Vxlzp1aLeBllim2
X-Authority-Analysis: v=2.4 cv=GbEXnRXL c=1 sm=1 tr=0 ts=68250247 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=Ndo-IaqSSPyT4VBL0YYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxlogscore=614 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140190

When running trace-cmd record, I encounter multiple "No such device"
errors due to the splice syscall failing with ENODEV for
/sys/kernel/tracing/per_cpu/cpuX/trace_pipe_raw files corresponding to
CPUs that are possible but not present.

Environment:
- Operating System: Red Hat Enterprise Linux 9.5 (Plow)
- Kernel: Linux 6.12.0-55.9.1.el10_0.ppc64le
- Architecture: ppc64le
- Command Executed: trace-cmd record -o /dev/null -v -e sched_switch -- sleep 1
- System CPU Configuration:
  - /sys/devices/system/cpu/possible: 0-223
  - /sys/devices/system/cpu/present: 0-63
  - /sys/kernel/tracing/per_cpu/: Contains directories cpu0 to cpu223

Steps to Reproduce: 
1. On a system with a mismatch between possible and present CPUs (e.g.,
   possible: 0-223, present: 0-63). 
2. Ensure /sys/kernel/tracing/per_cpu/ contains directories for all possible 
   CPUs (e.g., cpu0 to cpu223). 
3. Run the command:
strace --decode-fds -kk -o strace/trace-cmd -ff -- trace-cmd record -o /dev/null -v -e sched_switch -- sleep 1
4. Observe the output and strace logs.

Expected Behavior: trace-cmd should only attempt to access
trace_pipe_raw files for CPUs that are present (e.g., cpu0 to cpu63),
completing the recording without errors.

Actual Behavior:
trace-cmd fails with multiple errors:
trace-cmd: No such device
recorder error in splice input

The strace output shows splice syscalls failing with ENODEV for
trace_pipe_raw files of non-present CPUs 
(e.g., /sys/kernel/tracing/per_cpu/cpu223/trace_pipe_raw). 

Example:
trace-cmd.47140:splice(5</sys/kernel/tracing/per_cpu/cpu223/trace_pipe_raw>, NULL, 7<pipe:[96498]>, NULL, 65536, SPLICE_F_MOVE) = -1 ENODEV (No such device)


Analysis:
- trace-cmd iterates over all directories in
  /sys/kernel/tracing/per_cpu/ (which includes cpu0 to cpu223 for all 
  possible CPUs).
- It attempts to invoke splice on trace_pipe_raw for each CPU, including
  those not present (e.g., cpu64 to cpu223).
- The splice syscall fails with ENODEV for non-present CPUs.
- Stack trace (from strace -kk):
splice(5</sys/kernel/tracing/per_cpu/cpu223/trace_pipe_raw>, ...)
  > /usr/lib64/glibc-hwcaps/power10/libc.so.6(splice+0x74)
  > /usr/bin/trace-cmd(splice_data+0x3b)
  > /usr/bin/trace-cmd(tracecmd_start_recording+0x93)
  > /usr/bin/trace-cmd(create_recorder+0x14f)
  > /usr/bin/trace-cmd(start_threads+0x81b)
  > /usr/bin/trace-cmd(record_trace.isra.0+0xf5f)
  > /usr/bin/trace-cmd(trace_record+0x47)
  > /usr/bin/trace-cmd(main+0xff)

# strace --decode-fds -kk -o strace/trace-cmd -ff -- trace-cmd record -o /dev/null -v -e sched_switch -- sleep 1
trace-cmd: No such device
    trace-cmd: No such device
recorder error in splice input  recorder error in splice input
recorder error in splice inputtrace-cmd: No such device
recorder error in splice input

trace-cmd: No such device
<snipped>
recorder error in splice input
trace-cmd: No such device
recorder error in splice input
recorder error in splice inputtrace-cmd: No such device

  recorder error in splice inputtrace-cmd: No such device

  recorder error in splice input
trace-cmd: No such device
  trace-cmd: No such device
recorder error in splice input
  recorder error in splice inputtrace-cmd: No such device

  recorder error in splice input
trace-cmd: No such device
  recorder error in splice inputtrace-cmd: No such device

recorder error in splice inputtrace-cmd: No such device
<snipped>
recorder error in splice input
recorder error in splice inputtrace-cmd: No such device

  recorder error in splice inputtrace-cmd: No such device

  recorder error in splice inputtrace-cmd: No such device

  recorder error in splice input
CPU0 data recorded at offset=0x10000
    0 bytes in size
CPU1 data recorded at offset=0x10000
    0 bytes in size
<snipped>
CPU10 data recorded at offset=0x10000
    0 bytes in size
CPU11 data recorded at offset=0x10000
<snipped>
    0 bytes in size
CPU63 data recorded at offset=0x10000
    0 bytes in size
CPU64 data recorded at offset=0x10000
    0 bytes in size
<snipped?
CPU213 data recorded at offset=0x10000
    0 bytes in size
<snipped>
CPU222 data recorded at offset=0x10000
    0 bytes in size
CPU223 data recorded at offset=0x10000
    0 bytes in size

# grep -i "such device" * | grep splice
trace-cmd.46981:splice(5</sys/kernel/tracing/per_cpu/cpu64/trace_pipe_raw>, NULL, 7<pipe:[86367]>, NULL, 65536, SPLICE_F_MOVE) = -1 ENODEV (No such device)
trace-cmd.46982:splice(5</sys/kernel/tracing/per_cpu/cpu65/trace_pipe_raw>, NULL, 7<pipe:[82351]>, NULL, 65536, SPLICE_F_MOVE) = -1 ENODEV (No such device)
trace-cmd.46983:splice(5</sys/kernel/tracing/per_cpu/cpu66/trace_pipe_raw>, NULL, 7<pipe:[81717]>, NULL, 65536, SPLICE_F_MOVE) = -1 ENODEV (No such device)
trace-cmd.46984:splice(5</sys/kernel/tracing/per_cpu/cpu67/trace_pipe_raw>, NULL, 7<pipe:[1932]>, NULL, 65536, SPLICE_F_MOVE) = -1 ENODEV (No such device)
trace-cmd.46985:splice(5</sys/kernel/tracing/per_cpu/cpu68/trace_pipe_raw>, NULL, 7<pipe:[92520]>, NULL, 65536, SPLICE_F_MOVE) = -1 ENODEV (No such device)
trace-cmd.46986:splice(5</sys/kernel/tracing/per_cpu/cpu69/trace_pipe_raw>, NULL, 7<pipe:[93494]>, NULL, 65536, SPLICE_F_MOVE) = -1 ENODEV (No such device)
<snipped>
trace-cmd.47136:splice(5</sys/kernel/tracing/per_cpu/cpu219/trace_pipe_raw>, NULL, 7<pipe:[19742]>, NULL, 65536, SPLICE_F_MOVE) = -1 ENODEV (No such device)
trace-cmd.47137:splice(5</sys/kernel/tracing/per_cpu/cpu220/trace_pipe_raw>, NULL, 7<pipe:[29868]>, NULL, 65536, SPLICE_F_MOVE) = -1 ENODEV (No such device)
trace-cmd.47138:splice(5</sys/kernel/tracing/per_cpu/cpu221/trace_pipe_raw>, NULL, 7<pipe:[42069]>, NULL, 65536, SPLICE_F_MOVE) = -1 ENODEV (No such device)
trace-cmd.47139:splice(5</sys/kernel/tracing/per_cpu/cpu222/trace_pipe_raw>, NULL, 7<pipe:[81737]>, NULL, 65536, SPLICE_F_MOVE) = -1 ENODEV (No such device)
trace-cmd.47140:splice(5</sys/kernel/tracing/per_cpu/cpu223/trace_pipe_raw>, NULL, 7<pipe:[96498]>, NULL, 65536, SPLICE_F_MOVE) = -1 ENODEV (No such device)

