Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF21A145B39;
	Wed,  4 Sep 2024 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433174; cv=none; b=Mq1gFbv9nR4OFgl1xIGW46omodhximUUn+/UBGMhv2cpADJ80kV5utDWCIaGrDN1WWbvuq/TH0/SPacY5/lzHraYUiWidENPXL+mQNRBUtLO4NeaBn98Z0Mum51LTyQA02QJsqdvBDTg0xiehMZYj0z6HbqfpDt3T8FF3o6wgrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433174; c=relaxed/simple;
	bh=97WvkdOLuH8nFg1jfDBA+OBN3SlRNf9YII4h9vv9Qpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IH1oILfhoKRswyBjXebfb1ylX4dpcCLVYydRX0ncpyrT2Nu70pk8VRFnsJWhyB0DVZB8tsdLwNV+rznsQ3w95HrLvrtnEd8AESZSIE1SRQstdeZNL+g7VJ136OMVZCxNRG4kdSwz3dncva5HlaPxe1qkzdvuoWgMYs5dABGm1pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tQGmHwE+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tQGmHwE+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483Mn3O8031356;
	Wed, 4 Sep 2024 06:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=5Y1gyYG60jOF3JE98uZpYCUiZX
	bStaASEh6e18i5Q1M=; b=tQGmHwE+Ps8bt17Iaquf5rQBl5WDo7mjSWYR4Wg4tI
	JhrxW53qYzmHI15te292CcSsvHw02Pu5cdzQQKr9cvNOCS6+8sAWIbLZ8r0VABwh
	B1GNQT71yvkaWhx9kwNLmklgTQ1B5dG26jlBRmnC4H8OemCENLm/dFg2xu3r9J7/
	9aaRfgyDl/p9yFmvwpC36kGasC5xDl2ru7jXdesBt1NA23kk8UlEkndgMlluBq3y
	wz76Gol9p9L+/sm4yVWYQv91z/JmCS8Cxb2kkcNwrdWXY22nTc2iRVDiJY7SZwmC
	hdntE7JUxzYyCnDuGMzfyBo2BGVOpr9ylXsMFLKihUhA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqt1tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:59:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4844rSWI012058;
	Wed, 4 Sep 2024 06:59:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cegpxf99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:59:17 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4846xFOR58720732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 06:59:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B0C52004B;
	Wed,  4 Sep 2024 06:59:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 888B220043;
	Wed,  4 Sep 2024 06:59:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Sep 2024 06:59:15 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 1C085E0297; Wed,  4 Sep 2024 08:59:15 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: [PATCH 0/7] add function arguments to ftrace
Date: Wed,  4 Sep 2024 08:58:54 +0200
Message-ID: <20240904065908.1009086-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IyPlP0Aqv9vpIEU4M-A0s0FHBpbG2XRG
X-Proofpoint-ORIG-GUID: IyPlP0Aqv9vpIEU4M-A0s0FHBpbG2XRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_04,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=829 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040049

These patches add support for printing function arguments in ftrace.

Example usage:

function tracer:

cd /sys/kernel/tracing/
echo icmp_rcv >set_ftrace_filter
echo function >current_tracer
echo 1 >options/func-args
ping -c 10 127.0.0.1
[..]
cat trace
[..]
            ping-1277    [030] ..s1.    39.120939: icmp_rcv(skb = 0xa0ecab00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    39.120946: icmp_rcv(skb = 0xa0ecac00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    40.179724: icmp_rcv(skb = 0xa0ecab00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    40.179730: icmp_rcv(skb = 0xa0ecac00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    41.219700: icmp_rcv(skb = 0xa0ecab00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    41.219706: icmp_rcv(skb = 0xa0ecac00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    42.259717: icmp_rcv(skb = 0xa0ecab00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    42.259725: icmp_rcv(skb = 0xa0ecac00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    43.299735: icmp_rcv(skb = 0xa0ecab00) <-ip_protocol_deliver_rcu
            ping-1277    [030] ..s1.    43.299742: icmp_rcv(skb = 0xa0ecac00) <-ip_protocol_deliver_rcu

function graph:

cd /sys/kernel/tracing
echo icmp_rcv >set_graph_function
echo function_graph >current_tracer
echo 1 >options/funcgraph-args

ping -c 1 127.0.0.1

cat trace

 30)               |  icmp_rcv(skb = 0xa0ecab00) {
 30)               |    __skb_checksum_complete(skb = 0xa0ecab00) {
 30)               |      skb_checksum(skb = 0xa0ecab00, offset = 0, len = 64, csum = 0) {
 30)               |        __skb_checksum(skb = 0xa0ecab00, offset = 0, len = 64, csum = 0, ops = 0x232e0327a88) {
 30)   0.418 us    |          csum_partial(buff = 0xa0d20924, len = 64, sum = 0)
 30)   0.985 us    |        }
 30)   1.463 us    |      }
 30)   2.039 us    |    }
[..]


Sven Schnelle (7):
  tracing: add ftrace_regs to function_graph_enter()
  x86/tracing: pass ftrace_regs to function_graph_enter()
  s390/tracing: pass ftrace_regs to function_graph_enter()
  Add print_function_args()
  tracing: add config option for print arguments in ftrace
  tracing: add support for function argument to graph tracer
  tracing: add arguments to function tracer

 arch/arm/kernel/ftrace.c             |  2 +-
 arch/arm64/kernel/ftrace.c           |  2 +-
 arch/csky/kernel/ftrace.c            |  2 +-
 arch/loongarch/kernel/ftrace.c       |  2 +-
 arch/loongarch/kernel/ftrace_dyn.c   |  2 +-
 arch/microblaze/kernel/ftrace.c      |  2 +-
 arch/mips/kernel/ftrace.c            |  2 +-
 arch/parisc/kernel/ftrace.c          |  2 +-
 arch/powerpc/kernel/trace/ftrace.c   |  2 +-
 arch/riscv/kernel/ftrace.c           |  2 +-
 arch/s390/kernel/entry.h             |  4 +-
 arch/s390/kernel/ftrace.c            |  4 +-
 arch/sh/kernel/ftrace.c              |  2 +-
 arch/sparc/kernel/ftrace.c           |  2 +-
 arch/x86/include/asm/ftrace.h        |  2 +-
 arch/x86/kernel/ftrace.c             |  6 +-
 include/linux/ftrace.h               |  4 +-
 kernel/trace/Kconfig                 | 12 ++++
 kernel/trace/fgraph.c                |  7 ++-
 kernel/trace/trace.c                 |  8 ++-
 kernel/trace/trace.h                 |  4 +-
 kernel/trace/trace_entries.h         |  7 ++-
 kernel/trace/trace_functions.c       | 46 ++++++++++++++--
 kernel/trace/trace_functions_graph.c | 74 +++++++++++++------------
 kernel/trace/trace_irqsoff.c         |  4 +-
 kernel/trace/trace_output.c          | 82 +++++++++++++++++++++++++++-
 kernel/trace/trace_output.h          |  9 +++
 kernel/trace/trace_sched_wakeup.c    |  4 +-
 28 files changed, 228 insertions(+), 73 deletions(-)

--
2.43.0
