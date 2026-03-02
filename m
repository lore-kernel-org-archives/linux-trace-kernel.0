Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B2339B96B
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447271; cv=none; b=PINBYzlga24Mp9UBYuNPgqoMzGLq7jzdOApYW0n4+9+Wo9/DwoKCmMmtnh2eEvTsXsWur2eS6p3wXTH1XEivlnKMZP/7UQofwEC5pMWlsoc6MDivxeKpWVWVRH5UFDjMAP4GGVR2Mj6ZkpMF2aGUmoEbawLBAwOLsse0JguUP0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447271; c=relaxed/simple;
	bh=OCl66BRYkfKDfChXbADv1Sn9d/fysBhI9zb/EpegXtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t755H2wj8+ZeKLE8+GSTCcQAVdyFyxuWjkST3NYYQT4O2Ya+fckkVYK/0s8XaczGCIMS4WS6fjGNEbANhBvdGfGEYbm2/q7DN3DQVKLlnXaogrXQh8gOj13ktkl/WixWQDIzBfBrUUIBpzxC7yDJzM1l9NVMh1/QNnwKV5Xd5yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A3QQtGbD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ma08+8hw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A3QQtGbD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ma08+8hw"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62285YvJ662249
	for <linux-trace-kernel@vger.kernel.org>; Mon, 2 Mar 2026 10:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cCz+HM87JTAOdjDoGRJLd9
	v8dw2YvkaYNJyf3SOdWa4=; b=A3QQtGbDYxDcrr0GTfvvuXKj+PASypKuKf6gF3
	PakiKQgR3alpmOWK4Av/xcZtTC1K8NIKCbamoCZDfMo3xF7dgFOALwL3xsDswCH1
	S0Oh0ZQ7fu/d/UF5eFilkwKWr9f9GMrh5fe5w9aLKODLYyO186ICvMHNRuNFcokZ
	49pSY9Kh1zbZ3N7gS4Dz92Kya9/5pKOqa36WR9xp17zZh/hKFoYfiyJjwBhq8ICj
	eKXt8iWJHPZGHC6slY4CCasL+1FBiI4euqzF4IKnwSR46YL3799lCBDb7btbcV+H
	ZVreFUvuIPcYV7rKUrhwpfhVqVkuWftbX3Aw0/H0rVjiAdfA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn6r2rkbe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 10:27:49 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb3a129cd2so4061131485a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 02:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772447269; x=1773052069; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cCz+HM87JTAOdjDoGRJLd9v8dw2YvkaYNJyf3SOdWa4=;
        b=Ma08+8hwF1ZbhctmiGUxSXrIBgrjFp4JEmPJkkXny3aAIThuIyq1Tx/4Wt52JtSwhz
         Oiq77tU5HiDcYCzHho9GQYrVBRwqPCl32/JvDBkTyw9fmW/idY4f7o9TLtHXJan7jfd4
         ow5/Pa7FzEiFsmtUWOgz1mWs/qSCG9Sc7wWPshrHZqcY5Tp5MjTVHj5y6z4dR33jmEll
         EvCf2Bmbbz0kSdro4lJsbJz5s/OGdoAD65Rm9m4f+dC0ncBTwmiKXBfceIs1FAorEvbU
         vN+1hDb35p/fECekTQYt/EudNMSAuUHcV/eRDzc44X43yY2PCjMV6O1LZL78FucRIy/6
         HJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772447269; x=1773052069;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCz+HM87JTAOdjDoGRJLd9v8dw2YvkaYNJyf3SOdWa4=;
        b=BqJK0B+k9rxPVpTkVlhXpDczgMqCy4RXrsLgE7sjPG6o/Scb3Jt9JQ+XPTJsfuUBvb
         U2SU1wkyq863zPKqtiQxmOV6qX15Ijk7zKHR9dFwBTbhUth2++cCwQ9kfw6Yd/5vx3mR
         ptxGuLQzIolSMBDIhixpD7Bvv+mF6lDMKltQX8kBPUZrV45YQ4DeFP6XuEJFqp+aNv7q
         tyk+KuIZacJKt0VYGAGomVS9or2BCDv+tEROeIAz7RTnai5r4lalFxkYBQI4PQSBQx7O
         YBWu0nRVc/uxI4LJ6ohvafIFOw9fRbd8nOE5FEJio2d6fWUGN+Zhdc3/GbxpzIz1aM3p
         xw0g==
X-Forwarded-Encrypted: i=1; AJvYcCVdHKa/AEnEcX8qxdJfbEExssaNS4yXdMR1edkGstVimWxcnnnxYPxoiQerSwN2ngtiv106zgKsbp/cLWllsdxh9vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG6jihi/NvvMwbGeBz5rJnaIji96MWDTY6EYnsHYyqzLj1zxLI
	m4pvCaxKBngVA32KQYibL2Vmmri2OGM7PIgJBiIoJeVFoIt2+Le8Wprm+qJwiSMwBtMgTObqKnC
	e58pHIZfsOezlp4yr+Pxk6dGwvTPjhnSMbyS52zSOc/nyRVJXZzt4b29WW0+msaj5QbQJ/daX7X
	w=
X-Gm-Gg: ATEYQzxwTb8TEFcvLBjxLxVVwf8O7F5lTNkB3dxBuDVxPkwDunOr0sP8B+gJpRoFV8s
	nozeZXwbxqtgwMjRdwIWbH8akN8bhxbCCOWlFFcHMKG7LcNH6WgDOyFWZNzTumHqjQzhHHtxNsg
	1HSULO2HI7+f0G7tX/bzvOP4bAFz+YGZNWWM0DbC9t8nzp8vkP/jHSObZcg5frD91fgyKpZOGxA
	x7/DRYrrXgWOYwnXSFRVDy6NTgCEfV0tSC2HngVQZYe9ts9BB1WstfIM7UENXOKj0QCxwr97saa
	aImwnw/Fbrmi6Kdf0rtB84kjNhtDxC0+tT36hct3eV5uNbD5SYVRl7PNF4TwLd/hErPDex1x2Jo
	2HVOW2tPHhJQOYnH6zUhumhWUB9upPijjujDIpz1T4p+FIoiYfVqEzgniwDqzy39F1eu8
X-Received: by 2002:a05:620a:d8d:b0:8c7:110e:9cd5 with SMTP id af79cd13be357-8cbbf40e1bemr1789310385a.45.1772447268842;
        Mon, 02 Mar 2026 02:27:48 -0800 (PST)
X-Received: by 2002:a05:620a:d8d:b0:8c7:110e:9cd5 with SMTP id af79cd13be357-8cbbf40e1bemr1789308285a.45.1772447268404;
        Mon, 02 Mar 2026 02:27:48 -0800 (PST)
Received: from hu-atachici-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabd36224sm3392748a12.7.2026.03.02.02.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 02:27:48 -0800 (PST)
From: Andrei-Alexandru Tachici <andrei-alexandru.tachici@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 11:27:34 +0100
Subject: [PATCH] trace: trace_events: allow multiple modules
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-trace-events-allow-multiple-modules-v1-1-ce4436e37fb8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABVmpWkC/x3NwQqDMAyA4VeRnBfQSB3sVcYOXY1bILbSVCeI7
 27Z8bv8/wHGWdjg0RyQeROTFCu6WwPh6+OHUcZqoJaGluiOJfvAyBvHYuhV0w/nVYssyjincVU
 2JHL99Hau78IAtbRknmT/X56v87wAF9CVa3UAAAA=
X-Change-ID: 20260227-trace-events-allow-multiple-modules-2253fb5531c6
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com,
        Andrei-Alexandru Tachici <andrei-alexandru.tachici@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772447267; l=1883;
 i=andrei-alexandru.tachici@oss.qualcomm.com; s=20260227;
 h=from:subject:message-id; bh=OCl66BRYkfKDfChXbADv1Sn9d/fysBhI9zb/EpegXtE=;
 b=aKuBhm3dlAeoWXVmYAaVXI7Sd4tuW2RDsHP4VaubRJsDUoY74+2/FLXPP8VZW/sMwPnQfO6mh
 CJbRAm27/ayAH3cb1k3GtkBx1gqWDLFa/yhZtw39Pp/kvtqc7F2QCf9
X-Developer-Key: i=andrei-alexandru.tachici@oss.qualcomm.com; a=ed25519;
 pk=swe7GbVcwADS8p/5z8CtTCYHAtqxUs6tE7qZwkQtHHY=
X-Proofpoint-GUID: Wy1VKC8JFm_u_GpiNijYl6l552Fne8A3
X-Proofpoint-ORIG-GUID: Wy1VKC8JFm_u_GpiNijYl6l552Fne8A3
X-Authority-Analysis: v=2.4 cv=Hpp72kTS c=1 sm=1 tr=0 ts=69a56625 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=RZPzDTZrk9g9jceTaOsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA4NiBTYWx0ZWRfXybOp2mFDxYqf
 NuRDg9Pkwde498EedLevMV3vN56/WBzbNGewtum+bKd4v8GqOiM3qI5QawY1rnqJQ2xq/5o9sUq
 WwU1LkusLr+0VqtN6auzzLKAXoZj1h6H2nqD58xx2cQVw8abUXONpznkdf3bHYhdeG09Q1enLj6
 GxkhRHZsW7YL1I19LiSEjcthRDtjPyKGCSX/9cM8TwVq32/Ia9GIKq375V3m3bdhDnZi5gvC1TD
 jPaLWMtr7rX5tj1G4hLIG8dBguvF4k1tmnWMdebI0hYTFKcxen9FieEgbWiqR66Px5A7BbnJIHr
 OrIfMYIcrUHuEXLOUi1+tBle185T3QnoJhq6w3iUByYDrs2nz4yF1fyihT1gYQbRl3cBKXRgUab
 lEjDbzEOMtcYKjIzaOloSJd1fM8goDgbOs7HJG6PPp7nZVp06Wk0U/k10xAve7ZfjOZrc+JrU19
 4e7NdjYWHoVawHSqRnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020086

Currently when multiple modules will be specified at boot
time in "kernel.trace_event=" only the last entry will
have trace events enabled.

Reconstruct through multiple setup calls the whole array
in bootup_event_buf in order to be parsed correctly by
early_enable_events().

Signed-off-by: Andrei-Alexandru Tachici <andrei-alexandru.tachici@oss.qualcomm.com>
---
Currently when multiple modules will be specified at boot
time in "kernel.trace_event=" only the last entry will
have trace events enabled.

Reconstruct through multiple setup calls the whole array
in bootup_event_buf in order to be parsed correctly by
early_enable_events().

Example bellow of a bootconfig:

kernel.trace_event = ":mod:rproc_qcom_common", ":mod:qrtr", ":mod:qcom_aoss"

Without the patch for the above only qcom_aoss would have
events enabled and debugging multiple modules that are
inserted at boot time would not be possible.
---
 kernel/trace/trace_events.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9928da636c9d..b07325e8b19a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -4491,7 +4491,11 @@ static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
 
 static __init int setup_trace_event(char *str)
 {
-	strscpy(bootup_event_buf, str, COMMAND_LINE_SIZE);
+	if (bootup_event_buf[0] != '\0')
+		strlcat(bootup_event_buf, ",", COMMAND_LINE_SIZE);
+
+	strlcat(bootup_event_buf, str, COMMAND_LINE_SIZE);
+
 	trace_set_ring_buffer_expanded(NULL);
 	disable_tracing_selftest("running event tracing");
 

---
base-commit: a75cb869a8ccc88b0bc7a44e1597d9c7995c56e5
change-id: 20260227-trace-events-allow-multiple-modules-2253fb5531c6

Best regards,
-- 
Andrei-Alexandru Tachici <andrei-alexandru.tachici@oss.qualcomm.com>

