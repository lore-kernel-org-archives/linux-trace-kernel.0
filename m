Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B0DC54E94
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 25 Jan 2023 22:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbjAYWyl (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 25 Jan 2023 17:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjAYWyk (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:54:40 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C2745F77;
        Wed, 25 Jan 2023 14:54:39 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PMbfeD011156;
        Wed, 25 Jan 2023 22:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ShNDCs/hYU1h67HATsn0qG9LFaTmURi2um0s6wqdc2U=;
 b=tX1SnapGhx29F4qOA9ufEbid/ROUjp74rkypIHjM6/I571RyuT3unjYsAqFTVBhafFK7
 /YWw1E5gpR/XXvApeLq8u7cg3NCTbXqIYJSbhn7AsxbYodwC8U6gDQcdewT13PnPhOH1
 E8dGUQ5OqHNFwbclebbTqBXNxbnvmfXSQekekkgaucyXuZoGzSR/2Oop20NytZwUiRWP
 OJJBZAez3a1fjK4Due61XNs5QKgTJyuHxkDNnAnmrVBCRH0LwngaDXJDjAg8pexCwnPa
 oXDai+FPtR+wosbR6N2lWzDgDdAe4/0yrToO7DmdpDAIWlKMLbFPhi2y0wrIco61fNy7 NQ== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb2smtuy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:54:21 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PMnH66019851;
        Wed, 25 Jan 2023 22:54:20 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3n87p7gvw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:54:20 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PMsJN354657512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 22:54:19 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A02058065;
        Wed, 25 Jan 2023 22:54:19 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 472585804B;
        Wed, 25 Jan 2023 22:54:17 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.77.150.21])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 22:54:17 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, rostedt@goodmis.org, alistair@popple.id.au,
        joel@jms.id.au, jk@ozlabs.org, andrew@aj.id.au,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, eajames@linux.ibm.com
Subject: [PATCH v2 0/2] fsi: Add IBM I2C Responder virtual FSI master
Date:   Wed, 25 Jan 2023 16:54:14 -0600
Message-Id: <20230125225416.4074040-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W-wLbNMXEBCJveMhmoGvHShloq3qQF3L
X-Proofpoint-ORIG-GUID: W-wLbNMXEBCJveMhmoGvHShloq3qQF3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 clxscore=1011
 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250200
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

The I2C Responder (I2CR) is an I2C device that translates I2C commands
to CFAM or SCOM operations, effectively implementing an FSI master and
bus.

Changes since v1:
 - Fix the binding document
 - Change the binding name
 - Clean up the size argument checking
 - Reduce __force by using packed struct for the command

Eddie James (2):
  dt-bindings: fsi: Document the IBM I2C Responder virtual FSI master
  fsi: Add IBM I2C Responder virtual FSI master

 .../bindings/fsi/ibm,i2cr-fsi-master.yaml     |  41 ++++
 drivers/fsi/Kconfig                           |   9 +
 drivers/fsi/Makefile                          |   1 +
 drivers/fsi/fsi-master-i2cr.c                 | 225 ++++++++++++++++++
 include/trace/events/fsi_master_i2cr.h        |  96 ++++++++
 5 files changed, 372 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
 create mode 100644 drivers/fsi/fsi-master-i2cr.c
 create mode 100644 include/trace/events/fsi_master_i2cr.h

-- 
2.31.1

