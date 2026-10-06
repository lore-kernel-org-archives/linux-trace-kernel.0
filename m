Received: from mx0b-00617f01.pphosted.com (mx0b-00617f01.pphosted.com [205.220.177.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70AB2AD35
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Oct 2026 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791357558; cv=none; b=mfieX927XUS5ncccD0M1ugESUJr1s/dDhIq2aPoAUaoSceTd5ZSHgIjsVmTkkX/jY3vyjRElmosCj7e9P8HXjSsQl9qlItvWU6xLq6NtmlFUX0k89m2L17pgxr/qso7uEvOE3vAbha7NfeVMv8zwBOoTLMHAabUWqSmP7/yQyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791357558; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BN3fq9mCcrEXutgsOPuKTDkGv/tW795szWohZAH1QBfYSoOK51vcPrhXtYIEJfeoxo4adkzyqlBPwpVU9yiiZCrH4hCXUaWTjCJzjABv63P2h8IMfIzxT/kUxLKOYbfe8nTpN/wv6avwYFFjTsP+UxgN/YlKDonIykSqT1HrHRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=psmicorp.com; spf=pass smtp.mailfrom=psmicorp.com; arc=none smtp.client-ip=205.220.177.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=psmicorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=psmicorp.com
Received: from pps.filterd (m0247528.ppops.net [127.0.0.1])
	by mx0a-00617f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69702doS3358284
	for <linux-trace-kernel@vger.kernel.org>; Tue, 6 Oct 2026 20:08:04 -0400
Received: from egc-exch2.psmicorp.com (webmail.psmicorp.com [38.142.134.66] (may be forged))
	by mx0a-00617f01.pphosted.com (PPS) with ESMTPS id 4h5b6q80dv-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Oct 2026 20:08:02 -0400 (EDT)
Received: from EGC-EXCH2.psmicorp.com (10.1.1.111) by EGC-EXCH2.psmicorp.com
 (10.1.1.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 6 Oct
 2026 17:55:53 -0400
Received: from psmicorp.com (10.1.1.107) by EGC-EXCH2.psmicorp.com
 (10.1.1.111) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.2507.61 via Frontend
 Transport; Tue, 6 Oct 2026 17:55:51 -0400
Reply-To: <greg@gospelmusicuniversity.com>
From: Evans Thomas <_us@psmicorp.com>
To: <linux-trace-kernel@vger.kernel.org>
Subject: fund transfer opportunity,Reply..
Date: Tue, 6 Oct 2026 23:55:49 +0200
Message-ID: <20261006235549.2501D1E3C369FFBD@psmicorp.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: iIyydwu1_ufF8ghnJuZ1fejfuS6IoQbY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA5NSBTYWx0ZWRfX+cx0o8/j8LWh
 hpuY1Gv486K/wepRFmUyqzlAA63a5C31F677+PvIeD8/4veFG8D9fHoGTf2/U/pByjJzgV47Oq/
 lKzRbRFJOdVUgOlveW85+HpdbszEb4+Tha9Kk7ET/JlUvoPVhqlw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA5NSBTYWx0ZWRfX8CgLnBRlJqpJ
 zuj+5k5aqHiUwU4ExYWLeLhArLpfthBGzDH7eOJPBM1MYk4vYW6haKqhc+ytpBeSHcwAkGdF2B3
 /yBAjyb5xj9ygP0ZecRe3r4IxBw1rubllG1WMouNRG11H78Ol3dxLME0D8HfXH9snAse2ZUYd9m
 tGPE+atDU2Uvy1esP65ty7548cfhTzBoSgObbk2of6OV38rNpSziDusmY2yHZ0ZJ2+SHNR0dPMm
 5qV87xe/buXOw+3zIUqQGOGj8dQhyEWjC+MWxOedCbiXzAE+hUSx0wyBW4Pxy/EGO+JsC3xotON
 nPWzy5pBeHGThdNwYD514tMG+OHt4176jBPexbCzgWP6jz91LwbONH2xCYuNxe93YeGcEoiZXYc
 rOXuszCQXhzO3T5NTqZOnqINlZgdwzmvZ06woEYu25W92t5zah7IEvUmxMT+lyk8umeCIwnipEw
 5+On2ndxyFIe8nbcMkA==
X-Authority-Analysis: v=2.4 cv=E7BYNqdl c=1 sm=1 tr=0 ts=6ac58d62 cx=c_pps
 a=sNj4pI0fii9qGHoVqNzRVg==:117 a=sNj4pI0fii9qGHoVqNzRVg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=ZHGAjPH774soz-f4Le74:22
 a=FHnH0SYMNjvGwZk24hmG:22 a=tclcd6dtLQvEqt9_mmAA:9
X-Proofpoint-ORIG-GUID: iIyydwu1_ufF8ghnJuZ1fejfuS6IoQbY
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610060095

