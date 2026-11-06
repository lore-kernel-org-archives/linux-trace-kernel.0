Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931309;
	b=u5b/M6NECURGZOnDRWXq2Ope/KTy82BRDXbGDSQMw4pVpJxqpqS8YU0dw7G1PWMO8hv4
	 /DWU4+f9ZZiwIAfADkMG6C1jsoBLDvIgjKNSG4xK2C18w9m/s4vcujWjtAFMoS22b8hPd
	 3CV+8f0mnQfwgG93FICrL7Hfw/oS6hhDJXwYW9npFEqDkUSJuGd5LPLf2FCFFIuQxnIa6
	 qRYiOVybzp2Y4Iqn7oJp0b1RxPjlDUYhFMCY9qi3GxQwtbj+PMX+/dytIZGFVp7R20ZfU
	 5M+XPki4KuuwFNSKRD/qX7kutZeuSIKtlUXTWn+tzLAnJdfKqbqL/yPOZqkQh982Xjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931309;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4vnDvBUlIXZ+ZcvRqoDSheUxxBsto/lfaYqFOupf+M4=;
	b=L+rmVnnrelMllFlcw7B/aZhAKxx5MEkqjVTiKsYputpQnTn2MxuUmSqMHQn/d044TXO1
	 m8p1TAb0yEGUovusHyUNn9ygeZA/Vnhk0bd55MgIRFzhH0bjs/Swoz2P+lskaCGpNY562
	 sSZig2vDM/bjzzm7NgyajWb5QXQMTLQ+Xq8zVXXma1IXmUPrwrCEgI6s6X1iVYCjbD0go
	 yzcAPHtVzBrhBvVbJHJ0P9QcRGPPa4S5pXatJ1IBPL1D8Eg4BuO6JHjvVT9hAoHykdFBA
	 nk0yYOnK12H7Blr8TzyqihPzME0/XOtSylMA8Lkq8lG+2zanETkTDmGlYrb3Kayx55w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qti.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GR7D5lh7;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733DF606A326;
	Fri,  6 Nov 2026 02:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 733DF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GR7D5lh7
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5NeSFC3216022;
	Fri, 6 Nov 2026 02:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=4vnDvBUlIXZ+ZcvRqoDSheUxxBsto/lfaYq
	FOupf+M4=; b=GR7D5lh7e/bgxt8IRB/sHxBj+5Ij3PSj07ep5+p014vG3fEIxDa
	m3iSJzz/igyDkWSEgT0TuITI11e8+5TmVbWMyiL79BWXSQLt0sKtds47+DbbfI/o
	L4grVdF2Z3Iw6PK4sHXc9FwCHk8UWLv2ka3ynXNdq9gsksLHLHkpgHn2ODe0UGYb
	AM7Aug9e+e1rFMm1u6Q9qb7o4uH/bj0/T82qAmHE2HQZxMIEVWvmyG3jO6OZ+Bzx
	B/qMjpzSKVX5zeMWbxYIAQZWdXhrnnw8Rigp280W60XZ627W4dfm0yAs14xSMseM
	RaXMW0xqv69yq2ezPi54Nh3zDk5gmcB+AEQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9rfhn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 02:15:02 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A62F1eR1526177;
	Fri, 6 Nov 2026 02:15:01 GMT
Received: from perf-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A62F0SB1526167
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 02:15:00 +0000 (GMT)
Received: by perf-sh02-lnx.ap.qualcomm.com (Postfix, from userid 3975139)
	id BFFF9AC6; Fri,  6 Nov 2026 10:14:59 +0800 (CST)
From: Wenwen Fu <wenwfu@qti.qualcomm.com>
To: rostedt@goodmis.org, mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Wenwen Fu <wenwfu@qti.qualcomm.com>
Subject: [PATCH] tracing: skip boot kprobe setup when no events were requested
Date: Fri,  6 Nov 2026 10:14:57 +0800
Message-ID: <20261106021457.2648231-1-wenwfu@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAwOCBTYWx0ZWRfXxWqu+dKJ291b
 Jv66+EzKvdO6ThswC7NSf0WGMoC7w8WvW30bvtxvuA0lv8vyMlLCo17V5CNCmrDIMTqRmjeQYNR
 H1SWm/6E9KmCodM4WqnKlUb8rfPkHtI=
X-Proofpoint-GUID: c0Cy7r_RZLDJOusza7o69x4pEDqQ5KoP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAwOCBTYWx0ZWRfX17PAGPczXA1a
 Dp+JjxrU5mZ8GTcu4dtVRhGJ+KJ8V+3qzCF+VxOKsSlPjDCtYZwGcVz21rSL/kWMqEoDxVfHtlO
 +TcuJPf9NrGwP8kdXt6EN/x95qTX7hbfk0ItXbC2unBkIz0upgbVOxhno/vHL+/jHpJB6s26Yqf
 E+kzGbA9ueEX2k7dlGh01XI6nmUxExcNd/IATZorF0rGloo5p6fFE15pHa62anLn7Z1Go1cHP2Q
 4Hmnjyw+6fsTQL4F9Z5dwOcNeP582NS+LTltDbolUztFI3yWAWYpL7MMot4nqe/OOEDWWrPWrxj
 BevzGCF76hCej80FT8GVeHw0RfjEEFg9pH0i0FVuOyB+mhcD+KkuJT2CBggW2siFt/MCye1OEgT
 VmUIeSf7HO5r33Nfcl2yPpjwa5jlrPtipGpXBMWTp1isY5k8yxRkN/EubeWRuw8G27PdLzVLs7z
 bxwsooLksfFCKijXfXw==
X-Proofpoint-ORIG-GUID: c0Cy7r_RZLDJOusza7o69x4pEDqQ5KoP
X-Authority-Analysis: v=2.4 cv=ZIZCCn7b c=1 sm=1 tr=0 ts=6aed3827 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=cFI_XdFft7piRKW2HDgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060008

setup_boot_kprobe_events() calls enable_boot_kprobe_events() even when
the kprobe_event= boot parameter was not supplied. That call takes
event_mutex without any command-line probes to enable.

Asynchronous eval-map updates also hold event_mutex. A normal boot can
therefore wait in init_kprobe_trace() for this background work despite
having no boot probes to set up.

Return early when the boot-event buffer is empty. Keep the mutex
protection in trace_event_update_all() and retain setup for explicit
kprobe_event= parameters. Bootconfig handles its own probe enablement,
and the existing trace_eval_sync() still waits for background work
before init memory is freed.

Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
---
 kernel/trace/trace_kprobe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index ee8171b19bee..52ec16d8d838 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1995,6 +1995,9 @@ static __init void setup_boot_kprobe_events(void)
 	char *p, *cmd = kprobe_boot_events_buf;
 	int ret;
 
+	if (!kprobe_boot_events_buf[0])
+		return;
+
 	strreplace(kprobe_boot_events_buf, ',', ' ');
 
 	while (cmd && *cmd != '\0') {
