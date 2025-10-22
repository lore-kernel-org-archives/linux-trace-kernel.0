Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560362F617D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117821; cv=none; b=asjf1nSKQIsMu30gmD+/CvnNPxSBd1NbSTTkmHwL2pQWiiU6pLFr9QqceP40U2wxdU5wGIme6lpzMJi/Zx0bRT/1qucwOMdWS/G7GQIt/zDqiWaIb9vsNVN/nFcKTscr/RAvaunvkFw28h9XdVsNutOMJnPHkw6ag5GYknUka64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117821; c=relaxed/simple;
	bh=IgWE4AzriR2+0ccXFFZElXyHOodDkoKtiyGdupMFOgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EiRePDaM+9A5vLTLOyPj5+X2ifWFmswmPs+mQwqfZuamC6c2pjKmtOZ8xn9mlCaOGJryCECW8JW9tmA3jLvBO7JhiJHn3slMDtovT4oyql353mqviCxDm/h/BcoXAwIPj2dk954HsuXpASRpHAWJiA3SDoH8NCXcmXJHOEWti7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D5tEew0V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D5tEew0V"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LKexMX010315
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jQbMCxbpPfrhzFinfDjeulS4YqB0f4rNQAR
	ialM8XFo=; b=D5tEew0VV8bv0QeKM5DVdTHh4RsBXQW+zw14Awj7vpk1LRG47du
	S4omI6pFIX6wbSrAOmJ8jMEw6nIT63Xp8VVokkOUAn9/Ckde14+0XLo2oPOSiw3G
	lw/sEo84TiRoRoXp7Zve/BRRJULjYmum/dVTgDyhuqHa9Q2/CJxexJzmHmOP0YuR
	+SwUEpoVK0AawY25hIrvHcHCKLy+SUrYRKiuZsO2jG3nDHVFbwFLJa/igZlHzXp8
	xPfKJa7tF8dlzohzeydGic5qq8cdZF2i1faovfWIAkOWN2sV+zRK02sQ6n1kQIMv
	3rfwHMCn2raj+6N8jBoykFSvacIKGBXTV8Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0hh0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:23:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33be01bcda8so5847598a91.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761117816; x=1761722616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQbMCxbpPfrhzFinfDjeulS4YqB0f4rNQARialM8XFo=;
        b=FtQFo7WJEBujBeNdVgKpxJ6JlIBUTtvZruxoK+00ji+vyFcZE+siCY/jQpzi1HzYJg
         UyHUHeo5xR5xnCEnCJLl8SmxjGGcZFJIo+cusXoXNZ/SZh34PkGykpT9xYg57c/p1H0n
         q6AAvigiS2T7Q0TmD4zIE3+qrD3WI48M7Zn7xtd+wgkCXXfsUmwCg4QZpPdRo7iyH/5s
         2ICy7xyecEdgLmosCdzMwyP/kp1+nAb3YIZjEtVn2FZClPTEBz98k7ldndfdRjn4ybyb
         2wz++0kJfNpbVWrTGaNCne0UNVhjguiUQrNTlxnmalbaoUU6TtLHlPjBfJ8JmJA9cGoL
         u5xg==
X-Forwarded-Encrypted: i=1; AJvYcCUhm9Mvmxdi7D5OwAoYVbRqUSBljnrnjTzBg6Xway6ONnFwXDAJAyI0hz9aqs69u6GQa/d/jbkagAZlTR6Z2kp6Wfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMu5MXnwvsKGV/olb40PF742ZtYqw7bvbHxh/wMgFmb3jrTdER
	1dQKG9em33h9lgJ4z6V7yHu7r1pDprhgxu88+F2p4ZlVcT7SZxl7mhG02rQJsUx9QMxCZpAkwh/
	cjAww5eZ5eGXHQo24irqwDO1JfuHD4BPGGTpQcGcLSKcSKjiUBg3+9GHoxXXDhYsKERi6fXEfct
	A=
X-Gm-Gg: ASbGncuSNUE01UOoKBS0TgqSiCdchbfphuLFe1btLRKnSoWld6sd5IVZhiQfO3TlYsf
	yJOG4uWG9m4ypfrsk2jUpHNMeVIW+eHhU8bUmwxRhQp9Rkf3jDsYhc2B6EINPy2wXsKbi01ZsFm
	35A+SvTmHgUrrQGiWudHt2QQAjllb6qgdqMOqS3vKyyQFczwybw9OYfZLRnAtY09pDyJ4UKliAf
	uYvq65qHTsYG+InjZCNcN2aZrXPno02UJx0jiqFfONIkccg6WgzNBDXJyHpJhX1otIWpN2sVry3
	Ry1uqrBFW8BvNaCJjFVCVzN9FM18zpV0Y4TQc2Cm2bf24sqOiTLO8amzTsh5es/lEGNNN/jYO+2
	E0mbt7gJOz1dqbNCO7ARuIPHdSx0ZEJ2wfd5/iLcTJSJ7eLBOEmX4jGX4UccthccU09Y=
X-Received: by 2002:a17:90b:3fcc:b0:33b:cb9c:6f71 with SMTP id 98e67ed59e1d1-33bcf85a9f4mr23984840a91.1.1761117816198;
        Wed, 22 Oct 2025 00:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDxR3o7v8rSGdDOSOtPiAeegaDr0tXs44OIwJVMqccRN926+CF1wCU9+iGlDSpgmUzi6qB4A==
X-Received: by 2002:a17:90b:3fcc:b0:33b:cb9c:6f71 with SMTP id 98e67ed59e1d1-33bcf85a9f4mr23984793a91.1.1761117815540;
        Wed, 22 Oct 2025 00:23:35 -0700 (PDT)
Received: from jinlmao-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7aa27ff1sm11377217a12.32.2025.10.22.00.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:23:35 -0700 (PDT)
From: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Yingchao Deng <yingchao.deng@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, quic_yingdeng@quicinc.com,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>
Subject: [PATCH v3] stm: class: Add MIPI OST protocol support
Date: Wed, 22 Oct 2025 15:18:31 +0800
Message-ID: <20251022071834.1658684-1-yingchao.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX9UGVoa8Gq/BO
 cTqd+MTaXziZd3qyte2buZEqR7O0KarJOwpQn5W57+bs1WRwhVTw/jY1GDISIjJGsaobh1Y4HvN
 4rkSQjfI7kb39K1HCONy5Oq26T+eztk9qWT5WhNz5vg0SEiYBxbIo+oeJxe/FgLwkOUuPD6SFeq
 mVig+cLjK3RtwlDaeTlxj2pSM41jzN3m6OFmkL0Xxevys+tokI5NeU0ssoYOQpSrfCd7DK+CRLD
 8xzmQC6AYBmIkClgZC+xl2AQTueYVbMuiRhVZ2eKbo/ki/GXBx3P/B7zSH0yBCswhMjmzNxShAQ
 tI1OrDpqxsRWwvd+mMXh/ZWtqIiuO8khsNI7q0PkTxk9d/x//39nl6Cps2HxF7CLoAM1PV+pAby
 Jgzrx3JKHGqgk0+MA9z+WRY98Ud4fg==
X-Proofpoint-ORIG-GUID: bl2BWzyLx7rnfDjkQ5R7ljosXEvLRrhx
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f88679 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=eBY3WRN5359KEgwcfnIA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: bl2BWzyLx7rnfDjkQ5R7ljosXEvLRrhx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

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

Signed-off-by: Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Signed-off-by: Jinlong Mao <jinlong.mao@oss.qualcomm.com>
Signed-off-by: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
---
 .../ABI/testing/configfs-stp-policy-p_ost     |   6 +
 Documentation/trace/p_ost.rst                 |  36 +++
 drivers/hwtracing/stm/Kconfig                 |  14 +
 drivers/hwtracing/stm/Makefile                |   2 +
 drivers/hwtracing/stm/p_ost.c                 | 239 ++++++++++++++++++
 5 files changed, 297 insertions(+)
 create mode 100644 Documentation/ABI/testing/configfs-stp-policy-p_ost
 create mode 100644 Documentation/trace/p_ost.rst
 create mode 100644 drivers/hwtracing/stm/p_ost.c

diff --git a/Documentation/ABI/testing/configfs-stp-policy-p_ost b/Documentation/ABI/testing/configfs-stp-policy-p_ost
new file mode 100644
index 000000000000..498739b49da0
--- /dev/null
+++ b/Documentation/ABI/testing/configfs-stp-policy-p_ost
@@ -0,0 +1,6 @@
+What:		/config/stp-policy/<device>:p_ost.<policy>/<node>/entity
+Date:		Oct 2025
+KernelVersion:	6.18
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
index 000000000000..98bb62dfc5d3
--- /dev/null
+++ b/drivers/hwtracing/stm/p_ost.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ * MIPI OST framing protocol for STM devices.
+ */
+
+#include <linux/configfs.h>
+#include <linux/module.h>
+#include <linux/device.h>
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
+	ssize_t sz = 0;
+	int i;
+	struct ost_policy_node *pn = to_pdrv_policy_node(item);
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
+	int i;
+	struct ost_output *op = output->pdrv_private;
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
+	hdr.timestamp = sched_clock();
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
-- 
2.43.0

