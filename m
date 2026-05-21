Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB22D7DC8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368946; cv=none; b=LctH61485k0oQgVYoKFQ53bo7Eu6RFMoajGej7aRDg5ErHxnDhLP0iikWixJjF6bRtV3iyYAaAH9phsz38TP8v5MA18ufq3Ee+8TfSdOMkT6wX17jgl13bRzHzXJWzXNDwSV6u+VT8M0wqneRwZkjbZ0U+MnX2v71cxI8vmymxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368946; c=relaxed/simple;
	bh=4XNB5JIGLjpANm8G9Mn+wCMnN2QbN2hJxUFucPulnHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oCXc+DoC0V9vCp7dLHCyuiQJ33BsvTqR5a2CSrtxFH4T5blJo6jn4MzzLPNf0NNt1GQKlSik9xYmuB0o5BDtJ30LjWbUzlc+T4CsruMMptvuY+kDrPX6qy0gV7LI0ulSQPRtzFIK+GoojpsRq+2FykjGpjSJKaAlDeKfObI+1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DfHRW4t2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gRrZut30; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DfHRW4t2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gRrZut30"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L99vjl2491830
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 13:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wNjMyJsY5JJvxdt736Bz6x
	bi/GKfy2/4NcKpcMc4sZ0=; b=DfHRW4t2jVP0JbnQ0MlXm7s1VWtw3o8ryf37z3
	FiZSjJltG/wMG8RxRwMbO8d36VkC86OfUUqM0FipPuN1xb84ZYhX+cdGVsheMIW+
	lK8qfw7t1hZwL9NAxz8yrmPjdEj7rHzws6Xl6I5zOXUHpj6Vc5TDmnlcJmMUq6O7
	fVGAZHf8o2p39zlkDHt55M9F6XsRDPbmO2OoVNmIhgSykqVCJhItancjxjcxhjlQ
	e2dy31Fgd1uIdPTga3RQJpXqCdNfeA9hLgvs1lG/zsKV4Va8qHB6KA+cQ9RkkwVT
	pWhXtSWPT8J9bEshQdn9j7pqH2ioONB0BkpzXesHr9qJ03pA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j53gw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 13:09:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ba3245a43dso64111915ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 06:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779368943; x=1779973743; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNjMyJsY5JJvxdt736Bz6xbi/GKfy2/4NcKpcMc4sZ0=;
        b=gRrZut30OVLx1PbSJ/RK1ay7XqrfGTuJzLHhm8OHWZSkJ1pD3qbmY4oqZ/9l/uZ83F
         p464dGnY00i/d8IrtJE+cuu36eRaCpxoyyJISUxpM+aGjl3f5LDUUL/kwYxj+H5jLy8x
         WfWAFAGROxfYBiUtDF6kP4IgkMj4+hpKyOyZajmvt9fDgnZrAHr0DDxt38ub/ULXzSFf
         iLXLryt7DYC55Jw8MftQX8oZsli3YAz2q8hQiTIrr+hClPENyFyhx/hBvBLFUP3I1o7z
         29+P7dJOO1uT93JAOy64BHH9Ov2EbK/ZVa0bk3O1TWtaLQI+Ipw5vtfsX3xUKMMLMYvI
         Wg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368943; x=1779973743;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNjMyJsY5JJvxdt736Bz6xbi/GKfy2/4NcKpcMc4sZ0=;
        b=WgGh27C6kPY+a5c8vZEnLGBFhLeNsyz+YYapz3z7utmAdaV4aHnwna7zZprqkATJOL
         nVcjq78cs5sStuYQYiL0oi/UsmEF8fW9Aq+1YMqAk8irEJeRYaPowXp+k4ACixQe8v8b
         aLIwG+FjNkp3DJsSlYFk3rLTiVFmh2up4fi+fUX8QdReIcfzDjUjewjkoU8g4UUUBR2t
         lkcvBcmXg3P0KGoDvmkWasoiTg/urVlIM7snb8Ix55Cre2C+lAO4NaVjnonAvW3KQ9K4
         UqYMCb2x114OmXofVZkYc21Q/cS/TPg8QiNNKnl8mxSbCkNFgQHZPSynoZZiGgQsihWe
         0EQA==
X-Forwarded-Encrypted: i=1; AFNElJ+oPb7nLIhIDJ3uz9iB3/7N4pe4olv+tmLy4IQTr2pQ6VJ9j9ldFqj50+RUqk4bNseiejCiff9QIxYp011L3flMLjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmNhaD1OcolBEygXRk/wmIhJSkpEmncucGsFqToT41Ff1/BAVz
	zt1DhCp3BRCtIy5oMcwm6fTdsdQeh5SD9eu9VnBeazMPx7Btuf/xMeKUTEWlsN7s6vaYzwTtFuX
	OFmdVFpHKVsXHtlxXNWfxM0h2BhisfEfSdMiTeHHpNtb1V5QxwbDN274mdyY655tsJurwmErLFq
	g=
X-Gm-Gg: Acq92OHU4EEG1f9q8UF8FQw6w3UCcxVRfOVuOHIPiE4y931Wf8tBFsXdj78r9fo+8Ia
	qPk0ub9V7DrUYcp5ztkKGc5yLknZyd+t0l0kvWgHAM1vJUOQfCQUpsTzBtLZfmzifAdZsYn2kGA
	nGcKk3iSDOZwcoswJJ/ANrLOUTW0PHc83ZyWUw4Jh6XLtW+Gn8P4q+cI8AOfqyRMe12MZ/2tnl/
	bTXcCeOtXb13RVuJScX0cCo8/o2zSz2XJTl2YdiaqieVbxS7Ofw06EF5DQgJJ4AGz0h2TrNHJTA
	5rdD7DqVcdHzgC6/Wh74flXrZk3fNUmkTzFPirpIEU6N19DOXoPfsAFzJ2VCRgBBJwvg0UWKfs5
	m8o6PqauuEuHkMGoa2wZe3CGj09r+ejq/zNMWJoAi5WXELlmwvnapjZcscm2u9XjL9klC23QgiE
	En1Sac/+OaGUdWtfPjfOGTVsfh
X-Received: by 2002:a17:903:24e:b0:2b4:61cc:37a8 with SMTP id d9443c01a7336-2bea301c5c2mr32099645ad.17.1779368942601;
        Thu, 21 May 2026 06:09:02 -0700 (PDT)
X-Received: by 2002:a17:903:24e:b0:2b4:61cc:37a8 with SMTP id d9443c01a7336-2bea301c5c2mr32099055ad.17.1779368941973;
        Thu, 21 May 2026 06:09:01 -0700 (PDT)
Received: from jinlmao-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea98ecc48sm11385025ad.50.2026.05.21.06.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:09:01 -0700 (PDT)
From: Yingchao Deng <yingchao.deng@oss.qualcomm.com>
Date: Thu, 21 May 2026 21:08:51 +0800
Subject: [PATCH v6] stm: class: Add MIPI OST protocol support
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-stm_p_ost-v6-1-8751fad35398@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOIDD2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHQUlJIzE
 vPSU3UzU4B8JSMDIzMDUyND3eKS3PiC+PziEl1jEwvLNBOjRMtUi2QloPqCotS0zAqwWdGxtbU
 A4LBz5VsAAAA=
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>,
        Yingchao Deng <yingchao.deng@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779368937; l=15483;
 i=yingchao.deng@oss.qualcomm.com; s=20260521; h=from:subject:message-id;
 bh=4XNB5JIGLjpANm8G9Mn+wCMnN2QbN2hJxUFucPulnHQ=;
 b=dAM/ebjErEO0lbW3/QVbclgJHQjkhp07ixEgzb6JYtXX553PTl5FbpF0S8p9qx0KnPSrVSrlA
 uvfOieY1xDuA5oibhL2WuuYQsAyDWr5w28DBAzER9gl2CKZXyNfiewv
X-Developer-Key: i=yingchao.deng@oss.qualcomm.com; a=ed25519;
 pk=YbHeeX0Qzqo7voZLva784lFhVChB9yF3a4sceW95ljA=
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0f03ef cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=56qk-FYNGTj2BDIEd0YA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: oJ7GowmxALQZPupG1QZvHxKfY1j84it6
X-Proofpoint-ORIG-GUID: oJ7GowmxALQZPupG1QZvHxKfY1j84it6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEzMSBTYWx0ZWRfXzgyX7mOxDHQo
 0mxslnEA101KgT5IB/xKh0bG/cOF83yb9F/gf9JZT7J+WsBFaQOeW3R/qqndIj0slGm81PZeuzs
 bkTJ50Sf4kL1Wz+Tgki+5reFYMAG57DlMrTEMdck0wWw2CYWYrGi0DO4gXjIyjaON+MAKQxpODe
 caFk0u/EJK/plxeQK2SUkUWJ1WlIMLiXshXr9FGDiHBN5/D9OFW9Dmf/cKLDZeu5SMjWc4JB+bB
 7FzlBvQ+H6krm07Cfs8OQ5vCuDrqyLKQ7WQX+bGT4aKS6F8HGGtTP2uUOHQi/pjVG5L8OG7e1KQ
 d0oDDZDSg66ZI6Q5dB00KegWVz0OKrY69Yuhs5wcVl7q/d+Du4uhZDHl80Y0WfZ1GeRhyYqQ1i7
 DGOG0JA5IpX/eTcUR5DS0clQxzILYMNgOoxD5+C5d5Jy2Cee74yfxifCPJA2eFgmTz9wbfWbXAK
 0Q018XmwKhcj4IXStiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210131

Add MIPI OST (Open System Trace) protocol support for stm to format the
traces. The OST Protocol abstracts the underlying layers from the sending
and receiving applications, thus removing dependencies on the connection
media and platform implementation.

OST over STP packet consists of Header/Payload/End. Header is designed to
include the information required by all OST packets. Information that is
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

Entity ID values (0~239) are defined and controlled by the TS owner, and
shall be unique for the whole TS. The configfs entity attribute allows the
user to configure which Entity ID is associated with each policy node.

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
Changes in v6:
1. Rebase on top of linux-next-20260518.
2. Fix Kconfig: 'default CONFIG_STM' -> 'default STM'.
3. Fix documentation grammar issues.
4. Add p_ost entry to Documentation/trace/index.rst.
5. Add missing priv_sz field to stm_protocol_driver registration.
6. Use kzalloc_obj() instead of kzalloc() in ost_output_open().
7. Add mutex protection in entity configfs store handler.
8. Keep the configfs entity attribute: entity ID values (0~239) are
   defined and controlled by the TS owner and are deployment-specific.
   stm_source_type only carries a small number of in-kernel source
   classifications and cannot represent the full range of OST entity
   assignments needed in practice. The configfs attribute allows each
   policy node to declare its entity.
   OST_ENTITY_TYPE_NONE is an enum sentinel (not entity ID 0) that causes
   ost_write() to return -EINVAL when no entity is configured, preventing
   emission of packets with an unintended entity field.
   OST_ENTITY_DIAG (0xEE) is a TS-owner-defined value used by Qualcomm's
   diagnostic framework as the standard entity identifier for diagnostic
   trace sources.
Link to v5: https://lore.kernel.org/all/20260129-p_ost-v5-1-2b14fff39428@oss.qualcomm.com/

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
 .../ABI/testing/configfs-stp-policy-p_ost          |   9 +
 Documentation/trace/index.rst                      |   1 +
 Documentation/trace/p_ost.rst                      |  39 ++++
 drivers/hwtracing/stm/Kconfig                      |  14 ++
 drivers/hwtracing/stm/Makefile                     |   2 +
 drivers/hwtracing/stm/p_ost.c                      | 241 +++++++++++++++++++++
 6 files changed, 306 insertions(+)

diff --git a/Documentation/ABI/testing/configfs-stp-policy-p_ost b/Documentation/ABI/testing/configfs-stp-policy-p_ost
new file mode 100644
index 000000000000..8fb160b50c40
--- /dev/null
+++ b/Documentation/ABI/testing/configfs-stp-policy-p_ost
@@ -0,0 +1,9 @@
+What:		/config/stp-policy/<device>:p_ost.<policy>/<node>/entity
+Date:		May 2026
+KernelVersion:	7.1
+Description:
+		Set the entity ID which identifies the trace source in the
+		OST packet header. Entity ID values (0~239) are defined by
+		the TS owner. Currently supported values are ftrace, console
+		and diag. RW.
+
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 5d9bf4694d5d..9cd1e0b5af6d 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -72,6 +72,7 @@ interactions and system performance.
    intel_th
    stm
    sys-t
+   p_ost
    coresight/index
    rv/index
    hisi-ptt
diff --git a/Documentation/trace/p_ost.rst b/Documentation/trace/p_ost.rst
new file mode 100644
index 000000000000..2b92e2229653
--- /dev/null
+++ b/Documentation/trace/p_ost.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================
+MIPI OST over STP
+===================
+
+The OST (Open System Trace) driver is used with STM class devices to
+generate standardized trace stream. Trace sources can be identified
+by different entity IDs.
+
+CONFIG_STM_PROTO_OST is for p_ost driver enablement. Once this config
+is enabled, you can select the p_ost protocol by command below:
+
+# mkdir /sys/kernel/config/stp-policy/stm0:p_ost.policy
+
+The policy name format is extended like this:
+
+  <device_name>:<protocol_name>.<policy_name>
+
+With a coresight-stm device, it will look like "stm0:p_ost.policy".
+
+With the MIPI OST protocol driver, the attributes for each protocol node are:
+
+# mkdir /sys/kernel/config/stp-policy/stm0:p_ost.policy/default
+# ls /sys/kernel/config/stp-policy/stm0:p_ost.policy/default
+channels  entity    masters
+
+The entity here is the set of entities that p_ost supports. Currently
+p_ost supports ftrace, console and diag entities.
+
+Set entity:
+# echo 'ftrace' > /sys/kernel/config/stp-policy/stm0:p_ost.policy/default/entity
+
+Get available and currently selected (shown in square brackets) entity:
+# cat /sys/kernel/config/stp-policy/stm0:p_ost.policy/default/entity
+[ftrace] console diag
+
+See Documentation/ABI/testing/configfs-stp-policy-p_ost for more details.
+
diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
index cd7f0b0f3fbe..4c83da5d95a0 100644
--- a/drivers/hwtracing/stm/Kconfig
+++ b/drivers/hwtracing/stm/Kconfig
@@ -40,6 +40,20 @@ config STM_PROTO_SYS_T
 
 	  If you don't know what this is, say N.
 
+config STM_PROTO_OST
+	tristate "MIPI OST STM framing protocol driver"
+	default STM
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
index 000000000000..d2174872b761
--- /dev/null
+++ b/drivers/hwtracing/stm/p_ost.c
@@ -0,0 +1,241 @@
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
+ *      3       8       Protocol ID
+ */
+#define OST_FIELD_STARTSIMPLE		0
+#define OST_FIELD_VERSION		8
+#define OST_FIELD_ENTITY		16
+#define OST_FIELD_PROTOCOL		24
+
+#define OST_TOKEN_STARTSIMPLE		0x10
+#define OST_VERSION_MIPI1		0x10
+
+/* entity id to identify the source */
+#define OST_ENTITY_FTRACE		0x01
+#define OST_ENTITY_CONSOLE		0x02
+#define OST_ENTITY_DIAG			0xEE
+
+#define OST_CONTROL_PROTOCOL		0x0
+
+#define DATA_HEADER ((OST_TOKEN_STARTSIMPLE << OST_FIELD_STARTSIMPLE) | \
+		     (OST_VERSION_MIPI1 << OST_FIELD_VERSION) | \
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
+	opriv = kzalloc_obj(*opriv, GFP_ATOMIC);
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
+	struct mutex *mutexp = &item->ci_group->cg_subsys->su_mutex;
+	struct ost_policy_node *pn = to_pdrv_policy_node(item);
+	int i;
+
+	i = entity_index(page);
+	if (i) {
+		mutex_lock(mutexp);
+		pn->entity_type = i;
+		mutex_unlock(mutexp);
+	} else {
+		return -EINVAL;
+	}
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
+		header |= (ost_entity_value[op->node.entity_type] << OST_FIELD_ENTITY);
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
+	.priv_sz		= sizeof(struct ost_policy_node),
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
base-commit: 80dd246accce631c328ea43294e53b2b2dd2aa32
change-id: 20260521-stm_p_ost-3489f42a9e8c

Best regards,
-- 
Yingchao Deng <yingchao.deng@oss.qualcomm.com>

