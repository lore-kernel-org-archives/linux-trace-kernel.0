Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE92EDE99F
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 14 Sep 2023 10:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbjINKDn (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 06:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237695AbjINKDl (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:03:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09101BE7;
        Thu, 14 Sep 2023 03:03:37 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E4XZqw007245;
        Thu, 14 Sep 2023 10:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=PGSqgTIPvnE5Ukz6W8bUGYZScce92dk3erQnFRoHlhU=;
 b=dIPJ42sYgrwwoArUlwuwbK2UanC6PYrNvDDbCGcyhXh6pPUMOxYMbXef+9Vr+2AbBukM
 xS2VU+IYEdVBdkPRHhvKPJKFkBrJ9cuzpyIA/EGV2czWXRnimNCbkMXxZUwvaq/wD17l
 xV4kkN/HvKQ/edkVIqAK5n85t/yyOquarqCuEFCKcJqJP/qWk+DwYLzwOO/5xF3Wj9dE
 P9MdZgcojlunxB2RlkhMG2bW9k1R1mZO7FZIRxPwMxLCerMxie0/didpsqDEDI1KyM/r
 Glnxp/EpVyGqivX6/JE/uRSBnWOcJzrg4tW6HLyBagPK9L0o7ok2+Md3cPRuZRQOmcjJ 9A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3ds42qrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:03:17 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EA3G1d003875
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:03:16 GMT
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 03:03:13 -0700
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        "Linyu Yuan" <quic_linyyuan@quicinc.com>
Subject: [PATCH 0/8] usb: gadget: reduce usb gadget trace event buffer usage
Date:   Thu, 14 Sep 2023 18:02:54 +0800
Message-ID: <20230914100302.30274-1-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OLAMRJzdPcaNuabdE-X-nBk3RxsLw1Vn
X-Proofpoint-GUID: OLAMRJzdPcaNuabdE-X-nBk3RxsLw1Vn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_07,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=776 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140085
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

some trace event use an interger to to save a bit field info of gadget,
also some trace save endpoint name in string forat, it all can be
chagned to other way at trace event store phase.

bit field can be replace with a union interger member which include
multiple bit fields.

ep name stringe can be replace to a interger which contaion number
and dir info.

to allow trace output stage can get bit info from save interger,
add DECLARE_EVENT_CLASS_PRINT_INIT() clas which allow user defined
operation before print.

v1: https://lore.kernel.org/linux-usb/20230911042843.2711-1-quic_linyyuan@quicinc.com/
v2: fix two compile issues that COMPILE_TEST not covered
    https://lore.kernel.org/linux-usb/20230911112446.1791-1-quic_linyyuan@quicinc.com/
v3: fix reviewer comments, allow bit fields work on both little and big endian
    https://lore.kernel.org/linux-usb/20230912104455.7737-1-quic_linyyuan@quicinc.com/
v4: add DECLARE_EVENT_CLASS_PRINT_INIT() new trace class and use it

Linyu Yuan (8):
  trace: add new DECLARE_EVENT_CLASS_PRINT_INIT class type
  usb: gadget: add anonymous definition in some struct for trace purpose
  usb: udc: trace: reduce buffer usage of trace event
  usb: cdns3: trace: reduce buffer usage of trace event
  usb: dwc3: trace: reduce buffer usage of trace event
  usb: cdns2: trace: reduce buffer usage of trace event
  usb: mtu3: trace: reduce buffer usage of trace event
  usb: musb: trace: reduce buffer usage of trace event

 drivers/usb/cdns3/cdns3-trace.h            | 201 ++++++++++++++-------
 drivers/usb/cdns3/cdnsp-trace.h            | 105 +++++++----
 drivers/usb/dwc3/trace.h                   |  99 ++++++----
 drivers/usb/gadget/udc/cdns2/cdns2-trace.h | 175 ++++++++++++------
 drivers/usb/gadget/udc/trace.h             | 154 +++++++---------
 drivers/usb/mtu3/mtu3_trace.h              |  76 +++++---
 drivers/usb/musb/musb_trace.h              |  20 +-
 include/linux/tracepoint.h                 |  22 +++
 include/linux/usb/gadget.h                 | 113 +++++++-----
 include/trace/bpf_probe.h                  |   4 +
 include/trace/perf.h                       |  43 +++++
 include/trace/stages/stage3_trace_output.h |   3 +
 include/trace/trace_events.h               | 118 ++++++++++++
 13 files changed, 784 insertions(+), 349 deletions(-)

-- 
2.17.1

