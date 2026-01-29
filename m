Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F29288D6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769696737; cv=none; b=cHdxp0SDRlmIgTBKN4Qqt7n3GoIpcA9GNk1Higo2IbiOe7tyanreC5YmXisCId1j9Cmwn6DyQYc1ac8lCCzEz3uX01iDGI+wBw8zxnNUZ/4ClqEfkRCAQxYGY7n8t2j0pvxZhRDo7pqphnX5IdDyhga35qMlUS3iZDu8wJ+LNMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769696737; c=relaxed/simple;
	bh=m0SivMH4qU2C480k94zrKGIj4JgPhQBQzNZ+vZrK148=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R8vicu5mfiG/ekqZ6lKYnXVtg/bLSLg6yer+ipFKGFUxpdIASiQMrRSew+qFccyfk6f1i2DiWTqdqVmH6v/QcRQUMlLrwin1fylhgsvVfm1988OwRYDL/bowywXUt0IXKQn0jY6RmisPCb8Ffrke98N43My2IUcKe/dVI9tZfUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EpMkBqEG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MFi2jcUB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EpMkBqEG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MFi2jcUB"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TAKZs43674068
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 14:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=oSQPqso7JiLEAC9KBcnanR
	cpr9Jj5fwMPnM/9PQb6kY=; b=EpMkBqEGBmcYypOuIKyAKP79ivvk65dJrb8hWF
	PB64KaQh0Zl72+ZCVGFL8YIy0r/KTGD2md0iI1Xrv7egZodqVDIaFY3UIf0S7eby
	GoTfdKpnw13jmi4U9iprKMN96zJhZg9SCHeM0+NNXDk00ZwVajY2zR+PWEJSKQJu
	gILGlBId9G0KdTYbV6siDsC1VzwjrZh1cE8X7mlCqXru6TFlqydgY+7opDmLbcWd
	IP3WyUI9wLaAibrOBpeJvYKBa08kP07NDa44KDZjRYWgE8ICeMGo3hmpcSss0q7A
	b0ZWSJyz2hmKJrZKJlhBYv3XIrac7VHhL6xIlxQ1p8674rjA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c05q7gp6e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 14:25:34 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c613426e8dcso1817386a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 06:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769696734; x=1770301534; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oSQPqso7JiLEAC9KBcnanRcpr9Jj5fwMPnM/9PQb6kY=;
        b=MFi2jcUBpQygDY0mKTPrwDzkNJyLZGmaOsuz/Bsk+kDQfrIPfIrl0Os/76040UmJ1k
         oasjqn0XLHazxUhqc5+mzvhT9GJFiWp7hHdIS61oEhawKhcWHx4btBbU/AvyP6QcK6L8
         OvUzvL3mZ4Cf3TB6V41uFYVZiskIUMcDS2xKmeOQdKwe/vSYIkSSeAQuIpWQAYrZc65R
         WClcCfLdbA91/Z2eouL1rEL03RFy2Ffq5CX3p/oMGCk+H36W9EXTc+R4WlLpDJsL5ZVy
         Gw/kYRWkaHO2wPuZhwAlSEmkwQKp60wHcCfUa9ylIEEwnBdARir3jAwtVGsxXRO1N3gi
         UGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769696734; x=1770301534;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSQPqso7JiLEAC9KBcnanRcpr9Jj5fwMPnM/9PQb6kY=;
        b=LIyR+R+YDMddQwUJoIoQOE14EUmDNN0Ii2XPxEM3VhX9kQegyvxxbVJwu/8Tnr4iXj
         MkUnETUPnQc6NWkPLZFrPfLqdoaozqpHqhE4Ha+472HRIhb6jKYbYBHKxFH65NQwsVgp
         uTOxUtMtftK8hfetelWK6bxe2YQ4O3jolwtx05f6qWoLkhfnsQefUXz3ZIwxBPJxm/h8
         NFjzALzTsVb3UBN6bA6eXViG2FmBEvo2wIrb+vk4oNno3BG2Z6DvDAQC5NUA3xOow5/3
         H9b/39gWaXUgtgLrCK+hN8Et3YeaSbpsCN6nUyvKyZmPGqzQEmLsgwIBy2HmQ5GzGmYQ
         aWGw==
X-Forwarded-Encrypted: i=1; AJvYcCXebe+/Ohs9+/1uNCjoKX7xTFvLfckJIUT6k6R65kFrGJLSY62GgdUyR0nLOB898S8cUNzE5eu/0PRhEAgwRsX6RCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW4139KbW1o+GxsAcVIX9PSYDFnsF0CcIb3nzZtW6L3iUiQWXK
	zSD+cnEkRizwfh+hngK+VLQtMNgkztiwN3cP4gIqHfq+OqLoYInYzt3L73Kj0Z6No8SG68GOFO6
	VCLRDocnu+qpW2pr7RUYNyckl1Q2qcTu5vra+ur6m/0HYuFQr5jy509z8GEbCN2G0zldAzoxgbr
	Q=
X-Gm-Gg: AZuq6aKMRLyHV4uLPL9EIGRBPk/UtdzpijdfIy1mOdxvE3aHIVyyvY+gv8i5UNGUI4B
	02vNZHXcIhEzyBZbrUrb/3UNjpBKbiYmEAN6PyXqm3qVfEZw2oezAVuvJ70xtpbTVW1qRPRpVM2
	OXdEvvNcQChkvYdWzt/oewMvKXzqV99QJE89GhaIYwwHWh6BJyPZ89l2ogCtcwhhMc4nkQFUglh
	o+tTzX9nOatJ9OSm+wUKNZ6uDB2InvsceMvsbp2uupDo6qjWdkxoz58vMJAoUTyKIdfFtB3+hCc
	rgOXC3Y66OP9C0EPv+4iQrb6X9B4xJtvE0tg4QZnlzVeIz1xfZoav8hOMAg1hBDIbiiOU+Ne/5F
	AMHYKuCVOb8wsOK1nldXvpD0RFQg0tpt4KmmEZJYakRdv9JNTx9jzIkuXQbL6b8LaZDI11U6aWo
	hoJw==
X-Received: by 2002:a05:6300:14c:b0:35d:2172:6010 with SMTP id adf61e73a8af0-38ec63ca613mr9349362637.51.1769696733345;
        Thu, 29 Jan 2026 06:25:33 -0800 (PST)
X-Received: by 2002:a05:6300:14c:b0:35d:2172:6010 with SMTP id adf61e73a8af0-38ec63ca613mr9349333637.51.1769696732726;
        Thu, 29 Jan 2026 06:25:32 -0800 (PST)
Received: from jinlmao-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c40e1sm52999015ad.55.2026.01.29.06.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 06:25:32 -0800 (PST)
From: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 22:25:07 +0800
Subject: [PATCH v5] stm: class: Add MIPI OST protocol support
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-p_ost-v5-1-2b14fff39428@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMJte2kC/42Myw6CMBBFf8V0bUmfFF35H4aY0g7SRCi2SDSEf
 7ewMj4SN5OcyT1nQhGCg4j2mwkFGF10vksgtxtkGt2dATubGDHCJCVM4P7k44CtJJJVQnOqOEr
 bPkDt7mvnWCZuXBx8eKzZUSzf98IoMMXWAFRa1UBrevAxZtebvhjftlk6S/ebxHPJNMlrS6T8J
 eWEst2rpJZQYQVVVv0tETC64BYEFOJTKud5fgJM2R1+QAEAAA==
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, quic_yingdeng@quicinc.com,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>,
        Yingchao Deng <yingchao.deng@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769696728; l=13269;
 i=yingchao.deng@oss.qualcomm.com; s=20251024; h=from:subject:message-id;
 bh=m0SivMH4qU2C480k94zrKGIj4JgPhQBQzNZ+vZrK148=;
 b=YM2XryB2dMSK9R4XocwGM2wFbEN9kxz9VpmPTcIeqYjaPlpSZemrsdREDfmsHSPvJmjF6mCvF
 eStH6QtCNncA/HcKEoIMx63jLot0+Z5QaabGhTofTRFvEkLrgJXLwcS
X-Developer-Key: i=yingchao.deng@oss.qualcomm.com; a=ed25519;
 pk=NtBn/z8P2AMtGDeVaBWYauT/J/B0Js461LF0fOHs/u8=
X-Proofpoint-GUID: VuzvFHrYqhE8fgcIVwU0NRdANoYwSLsY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA5OCBTYWx0ZWRfX0BIHAiIVznt7
 M/oDMDo3FzRmo5oGWi4RrZtm4mMtWXpczk0RNeszrkfTP2akG6eBwWfCJvWICTX85JxOsC+3llP
 Azt2pP7sIkGt/y95tBWWh0l4i4tRxfNfe3sj7qc0N1Vxy8L3rB1EGKBIqVkMnKNVnBRlz58H22t
 TeIkVuCZRbTcwAP7+L9YmszDYkItlx3M870fziuRg9FAO1Vv1/AynLmbtVQyNx2t833YREauxv5
 MW6z4KjGso6tBfq3zV1JTlCWygHCfiZW8PMQmUQxjtx2nRNl1ouM0bFMST8F7e2T3zXemsju3yv
 Hxldpq9hUzZA/Urjc/PYDDcRJIaT5lFgZVujEVChs7QLR+CEZwaBrjAxqJIj2Jmu5OHqix3+QGw
 GRVhsv5R4gU1NVUKrMkW5SgTM7hzJMR1MZaTPXXlTwvMWIMm41Dwn2kuXY80a6awZmLWUgaqUvP
 CsX5W9yOFLG078ddjrw==
X-Authority-Analysis: v=2.4 cv=donWylg4 c=1 sm=1 tr=0 ts=697b6dde cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=XxusR3KdFzf1ftiqTncA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: VuzvFHrYqhE8fgcIVwU0NRdANoYwSLsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290098

Add MIPI OST(Open System Trace) protocol support for stm to format the
traces. The OST Protocol abstracts the underlying layers from the sending
and receiving applications, thus removing dependencies on the connection
media and platform implementation.

OST over STP packet consists of Header/Payload/End. Header is designed to
include the information required by all OST packets. Information  that is
not shared by all packets is left to the higher layer protocols. Thus, the
OST Protocol Header can be regarded as the first part of a complete OST
Packet Header, while a higher layer header can be regarded as an extension
designed for a specific purpose.

+--------+--------+--------+--------+
| start  |version |entity  |protocol|
+--------+--------+--------+--------+
|    stm version  |      magic      |
+-----------------------------------+
|                cpu                |
+-----------------------------------+
|              timestamp            |
|                                   |
+-----------------------------------+
|                tgid               |
|                                   |
+-----------------------------------+
|               payload             |
+-----------------------------------+
|                 ...      |  end   |
+-----------------------------------+

In header, there will be STARTSIMPLE/VERSION/ENTITY/PROTOCOL.
STARTSIMPLE is used to signal the beginning of a simplified OST protocol.
The Version field is a one byte, unsigned number identifying the version
of the OST Protocol. The Entity ID field is a one byte unsigned number
that identifies the source.

The Protocol ID field is a one byte unsigned number identifying the higher
layer protocol of the OST Packet, i.e. identifying the format of the data
after the OST Protocol Header. OST Control Protocol ID value represents
the common control protocol, the remaining Protocol ID values may be used
by any higher layer protocols capable of being transported by the OST
Protocol.

Co-developed-by: Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Signed-off-by: Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Co-developed-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Co-developed-by: Jinlong Mao <jinlong.mao@oss.qualcomm.com>
Signed-off-by: Jinlong Mao <jinlong.mao@oss.qualcomm.com>
Signed-off-by: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
---
Changes in v5:
1. Add Co-developed-by tag.
2. Use yearless copyright for new file.
- Link to v4: https://lore.kernel.org/all/20251024-p_ost-v4-1-3652a06fd055@oss.qualcomm.com/

Changes in v4:
1. Delete unused variable 'i'.
2. Fix build error: call to undeclared function 'task_tgid_nr'.
Link to v3 - https://lore.kernel.org/all/20251022071834.1658684-1-yingchao.deng@oss.qualcomm.com/

Changes in v3:
1. Add more details about OST.
2. Delete 'entity_available' node, and 'entity' node will show available
and currently selected (shown in square brackets) entity.
3. Removed the usage of config_item->ci_group->cg_subsys->su_mutex.
Link to v2 - https://lore.kernel.org/all/20230419141328.37472-1-quic_jinlmao@quicinc.com/
---
 .../ABI/testing/configfs-stp-policy-p_ost          |   6 +
 Documentation/trace/p_ost.rst                      |  36 ++++
 drivers/hwtracing/stm/Kconfig                      |  14 ++
 drivers/hwtracing/stm/Makefile                     |   2 +
 drivers/hwtracing/stm/p_ost.c                      | 236 +++++++++++++++++++++
 5 files changed, 294 insertions(+)

diff --git a/Documentation/ABI/testing/configfs-stp-policy-p_ost b/Documentation/ABI/testing/configfs-stp-policy-p_ost
new file mode 100644
index 000000000000..3cc4b38b456e
--- /dev/null
+++ b/Documentation/ABI/testing/configfs-stp-policy-p_ost
@@ -0,0 +1,6 @@
+What:		/config/stp-policy/<device>:p_ost.<policy>/<node>/entity
+Date:		Jan 2026
+KernelVersion:	6.20
+Description:
+		Set the entity which is to identify the source, RW.
+
diff --git a/Documentation/trace/p_ost.rst b/Documentation/trace/p_ost.rst
new file mode 100644
index 000000000000..df93b889eb4c
--- /dev/null
+++ b/Documentation/trace/p_ost.rst
@@ -0,0 +1,36 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================
+MIPI OST over STP
+===================
+
+The OST(Open System Trace) driver is used with STM class devices to
+generate standardized trace stream. Trace sources can be identified
+by different entity ids.
+
+CONFIG_STM_PROTO_OST is for p_ost driver enablement. Once this config
+is enabled, you can select the p_ost protocol by command below:
+
+# mkdir /sys/kernel/config/stp-policy/stm0:p_ost.policy
+
+The policy name format is extended like this:
+    <device_name>:<protocol_name>.<policy_name>
+
+With coresight-stm device, it will be look like "stm0:p_ost.policy".
+
+With MIPI OST protocol driver, the attributes for each protocol node is:
+# mkdir /sys/kernel/config/stp-policy/stm0:p_ost.policy/default
+# ls /sys/kernel/config/stp-policy/stm0:p_ost.policy/default
+channels  entity    masters
+
+The entity here is the set the entity that p_ost supports. Currently
+p_ost supports ftrace, console and diag entity.
+
+Set entity:
+# echo 'ftrace' > /sys/kernel/config/stp-policy/stm0:p_ost.policy/default/entity
+
+Get available and currently selected (shown in square brackets) entity that p_ost supports:
+# cat /sys/kernel/config/stp-policy/stm0:p_ost.policy/default/entity
+[ftrace] console diag
+
+See Documentation/ABI/testing/configfs-stp-policy-p_ost for more details.
diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
index eda6b11d40a1..daa4aa09f64d 100644
--- a/drivers/hwtracing/stm/Kconfig
+++ b/drivers/hwtracing/stm/Kconfig
@@ -40,6 +40,20 @@ config STM_PROTO_SYS_T
 
 	  If you don't know what this is, say N.
 
+config STM_PROTO_OST
+	tristate "MIPI OST STM framing protocol driver"
+	default CONFIG_STM
+	help
+	  This is an implementation of MIPI OST protocol to be used
+	  over the STP transport. In addition to the data payload, it
+	  also carries additional metadata for entity, better
+	  means of trace source identification, etc.
+
+	  The receiving side must be able to decode this protocol in
+	  addition to the MIPI STP, in order to extract the data.
+
+	  If you don't know what this is, say N.
+
 config STM_DUMMY
 	tristate "Dummy STM driver"
 	help
diff --git a/drivers/hwtracing/stm/Makefile b/drivers/hwtracing/stm/Makefile
index 1692fcd29277..d9c8615849b9 100644
--- a/drivers/hwtracing/stm/Makefile
+++ b/drivers/hwtracing/stm/Makefile
@@ -5,9 +5,11 @@ stm_core-y		:= core.o policy.o
 
 obj-$(CONFIG_STM_PROTO_BASIC) += stm_p_basic.o
 obj-$(CONFIG_STM_PROTO_SYS_T) += stm_p_sys-t.o
+obj-$(CONFIG_STM_PROTO_OST)   += stm_p_ost.o
 
 stm_p_basic-y		:= p_basic.o
 stm_p_sys-t-y		:= p_sys-t.o
+stm_p_ost-y		:= p_ost.o
 
 obj-$(CONFIG_STM_DUMMY)	+= dummy_stm.o
 
diff --git a/drivers/hwtracing/stm/p_ost.c b/drivers/hwtracing/stm/p_ost.c
new file mode 100644
index 000000000000..51fffa942959
--- /dev/null
+++ b/drivers/hwtracing/stm/p_ost.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * MIPI OST framing protocol for STM devices.
+ */
+
+#include <linux/pid.h>
+#include <linux/sched/clock.h>
+#include <linux/slab.h>
+#include <linux/stm.h>
+#include "stm.h"
+
+/*
+ * OST Base Protocol Header
+ *
+ * Position	Bits	Field Name
+ *      0       8       STARTSIMPLE
+ *      1       8       Version
+ *      2       8       Entity ID
+ *      3       8       protocol ID
+ */
+#define OST_FIELD_STARTSIMPLE		0
+#define OST_FIELD_VERSION		8
+#define OST_FIELD_ENTITY		16
+#define OST_FIELD_PROTOCOL		24
+
+#define OST_TOKEN_STARTSIMPLE		0x10
+#define OST_VERSION_MIPI1		0x10
+
+/* entity id to identify the source*/
+#define OST_ENTITY_FTRACE		0x01
+#define OST_ENTITY_CONSOLE		0x02
+#define OST_ENTITY_DIAG			0xEE
+
+#define OST_CONTROL_PROTOCOL		0x0
+
+#define DATA_HEADER ((OST_TOKEN_STARTSIMPLE << OST_FIELD_STARTSIMPLE) | \
+		     (OST_VERSION_MIPI1 << OST_FIELD_PROTOCOL) | \
+		     (OST_CONTROL_PROTOCOL << OST_FIELD_PROTOCOL))
+
+#define STM_MAKE_VERSION(ma, mi)	(((ma) << 8) | (mi))
+#define STM_HEADER_MAGIC		(0x5953)
+
+enum ost_entity_type {
+	OST_ENTITY_TYPE_NONE,
+	OST_ENTITY_TYPE_FTRACE,
+	OST_ENTITY_TYPE_CONSOLE,
+	OST_ENTITY_TYPE_DIAG,
+};
+
+static const char * const str_ost_entity_type[] = {
+	[OST_ENTITY_TYPE_NONE]		= "none",
+	[OST_ENTITY_TYPE_FTRACE]	= "ftrace",
+	[OST_ENTITY_TYPE_CONSOLE]	= "console",
+	[OST_ENTITY_TYPE_DIAG]		= "diag",
+};
+
+static const u32 ost_entity_value[] = {
+	[OST_ENTITY_TYPE_NONE]		= 0,
+	[OST_ENTITY_TYPE_FTRACE]	= OST_ENTITY_FTRACE,
+	[OST_ENTITY_TYPE_CONSOLE]	= OST_ENTITY_CONSOLE,
+	[OST_ENTITY_TYPE_DIAG]		= OST_ENTITY_DIAG,
+};
+
+struct ost_policy_node {
+	enum ost_entity_type	entity_type;
+};
+
+struct ost_output {
+	struct ost_policy_node	node;
+};
+
+/* Set default entity type as none */
+static void ost_policy_node_init(void *priv)
+{
+	struct ost_policy_node *pn = priv;
+
+	pn->entity_type = OST_ENTITY_TYPE_NONE;
+}
+
+static int ost_output_open(void *priv, struct stm_output *output)
+{
+	struct ost_policy_node *pn = priv;
+	struct ost_output *opriv;
+
+	opriv = kzalloc(sizeof(*opriv), GFP_ATOMIC);
+	if (!opriv)
+		return -ENOMEM;
+
+	memcpy(&opriv->node, pn, sizeof(opriv->node));
+	output->pdrv_private = opriv;
+	return 0;
+}
+
+static void ost_output_close(struct stm_output *output)
+{
+	kfree(output->pdrv_private);
+}
+
+static ssize_t ost_t_policy_entity_show(struct config_item *item,
+					char *page)
+{
+	struct ost_policy_node *pn = to_pdrv_policy_node(item);
+	ssize_t sz = 0;
+	int i;
+
+	for (i = 1; i < ARRAY_SIZE(str_ost_entity_type); i++) {
+		if (i == pn->entity_type)
+			sz += sysfs_emit_at(page, sz, "[%s] ", str_ost_entity_type[i]);
+		else
+			sz += sysfs_emit_at(page, sz, "%s ", str_ost_entity_type[i]);
+	}
+
+	sz += sysfs_emit_at(page, sz, "\n");
+	return sz;
+}
+
+static int entity_index(const char *str)
+{
+	int i;
+
+	for (i = 1; i < ARRAY_SIZE(str_ost_entity_type); i++) {
+		if (sysfs_streq(str, str_ost_entity_type[i]))
+			return i;
+	}
+
+	return 0;
+}
+
+static ssize_t
+ost_t_policy_entity_store(struct config_item *item, const char *page,
+			  size_t count)
+{
+	struct ost_policy_node *pn = to_pdrv_policy_node(item);
+	int i;
+
+	i = entity_index(page);
+	if (i)
+		pn->entity_type = i;
+	else
+		return -EINVAL;
+
+	return count;
+}
+CONFIGFS_ATTR(ost_t_policy_, entity);
+
+static struct configfs_attribute *ost_t_policy_attrs[] = {
+	&ost_t_policy_attr_entity,
+	NULL,
+};
+
+static ssize_t
+notrace ost_write(struct stm_data *data, struct stm_output *output,
+		  unsigned int chan, const char *buf, size_t count,
+		  struct stm_source_data *source)
+{
+	struct ost_output *op = output->pdrv_private;
+	unsigned int c = output->channel + chan;
+	unsigned int m = output->master;
+	const unsigned char nil = 0;
+	u32 header = DATA_HEADER;
+	struct trc_hdr {
+		u16 version;
+		u16 magic;
+		u32 cpu;
+		u64 timestamp;
+		u64 tgid;
+	} hdr;
+	ssize_t sz;
+
+	/*
+	 * Identify the source by entity type.
+	 * If entity type is not set, return error value.
+	 */
+	if (op->node.entity_type)
+		header |= ost_entity_value[op->node.entity_type];
+	else
+		return -EINVAL;
+
+	/*
+	 * STP framing rules for OST frames:
+	 *   * the first packet of the OST frame is marked;
+	 *   * the last packet is a FLAG with timestamped tag.
+	 */
+	/* Message layout: HEADER / DATA / TAIL */
+	/* HEADER */
+	sz = data->packet(data, m, c, STP_PACKET_DATA, STP_PACKET_MARKED,
+			  4, (u8 *)&header);
+	if (sz <= 0)
+		return sz;
+
+	/* DATA */
+	hdr.version	= STM_MAKE_VERSION(0, 3);
+	hdr.magic	= STM_HEADER_MAGIC;
+	hdr.cpu		= raw_smp_processor_id();
+	hdr.timestamp	= sched_clock();
+	hdr.tgid	= task_tgid_nr(current);
+	sz = stm_data_write(data, m, c, false, &hdr, sizeof(hdr));
+	if (sz <= 0)
+		return sz;
+
+	sz = stm_data_write(data, m, c, false, buf, count);
+
+	/* TAIL */
+	if (sz > 0)
+		data->packet(data, m, c, STP_PACKET_FLAG,
+			STP_PACKET_TIMESTAMPED, 0, &nil);
+
+	return sz;
+}
+
+static const struct stm_protocol_driver ost_pdrv = {
+	.owner			= THIS_MODULE,
+	.name			= "p_ost",
+	.write			= ost_write,
+	.policy_attr		= ost_t_policy_attrs,
+	.output_open		= ost_output_open,
+	.output_close		= ost_output_close,
+	.policy_node_init	= ost_policy_node_init,
+};
+
+static int ost_stm_init(void)
+{
+	return stm_register_protocol(&ost_pdrv);
+}
+module_init(ost_stm_init);
+
+static void ost_stm_exit(void)
+{
+	stm_unregister_protocol(&ost_pdrv);
+}
+module_exit(ost_stm_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MIPI Open System Trace STM framing protocol driver");

---
base-commit: efb26a23ed5f5dc3554886ab398f559dcb1de96b
change-id: 20251024-p_ost-d5052b4a3173

Best regards,
-- 
Yingchao Deng <yingchao.deng@oss.qualcomm.com>

