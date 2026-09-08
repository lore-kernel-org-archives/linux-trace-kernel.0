Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C784A53A8AA;
	Tue,  8 Sep 2026 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871611; cv=none; b=YADboNyErEfhVGL5iyPa309ycYDJMGsI/HY8yjG90zW16HikF0x+710mrUeWKUQrYtU7wHGfSfdl5haVgFq4XmoaKnATTirtwEUODQpzM8wCOHS/DoScWKaW9eaITAcwINnJcs00WkjterE3TXhwm0B6FSlU3KyxfsMDyL0E3Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871611; c=relaxed/simple;
	bh=hFwSZaU4jX+gf2S7p1+ZS5OtlLj8rto2j+q1fKuvxqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY8O/0Z1nJoXM/GpXer9//FG3sU5XJf5t/mgkvC5Bb3PwLBz2+j9HEduWZ1BGInJZXN1DSLYJUIOPb45f1qxOpC+eVNMFLFMqfofpD1d2iJIeQIliV98KONfR1gvjQNbKtAS5qtKPdk92OnqpJIIYeLMYGuVX6YrHkgIR5AEl3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HFrpLme8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HFrpLme8"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688AVcoD2959797;
	Tue, 8 Sep 2026 12:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hFwSZaU4jX+gf2S7p1+ZS5OtlLj8rt
	o2j+q1fKuvxqs=; b=HFrpLme8WhjkMoAoeZlZ3zjb2vlP1fJZWJtmDTIFeX3Tgg
	bdnhU2zG0AOIexcFSQPK/s/McVN0l8TEHIv+AxmZiVaLhc8pVyJZzWU9v06dM1WN
	2EgaTiciQK6iaWmy3eNCMkYyd00Tb9i7XYxfNLoBru5IHF+2iqtyTvp2WefhLm14
	WHPY1XblnziJnAfxFhUYAtrhy8ZrHdKUNR+zu227/juONnXypoEdD4sOgd7ka+lI
	l+kIXJvFm76Vl0MaK/HaHbvhHfhvaAU6M3MYqGhCRUqA6nlKjR3vSJpwnAVyDTVQ
	KhZo+oJ4BZR+2b6nWwejlzgFHdXKp8bUywDdwCTg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqjxuy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 12:46:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688CfEQ1008738;
	Tue, 8 Sep 2026 12:46:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw3x43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 12:46:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688CkgxP34013494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 12:46:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7908D20043;
	Tue,  8 Sep 2026 12:46:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5402E20040;
	Tue,  8 Sep 2026 12:46:42 +0000 (GMT)
Received: from tuxmaker (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Sep 2026 12:46:42 +0000 (GMT)
Date: Tue, 8 Sep 2026 14:46:41 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] ftrace/selftests: Fix registering kprobe on
 non-unique symbol
Message-ID: <20260908124641.1135846Aeb-agordeev@linux.ibm.com>
References: <cover.1787670777.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1787670777.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n_uIeoWkxEb1tAfiJfjUDKsT8nFFife0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEzNCBTYWx0ZWRfX0QsiZieEoLwh
 olfpXjkEWAVoN4N1ZBWrTIju7Y95I1ckZY+bWtndO+Im4sYvAcu9Q8NYR2ZIil9RmoRCFeteIl4
 Q/LeVwy3kjC0o/OBy5wCyZXjO7SpXOw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEzNCBTYWx0ZWRfXzFFnAKT+VKSs
 JGOJPf9K6AwCdCT6Adm0VkRVrwe86ZnBqY/Fw0DLJGFhyCfdDs1LqtD17NK/0tqE1uaZ3lqaUhn
 Ac+0IwEZ7Jpa7eD2VgyZ2u7gu5SzK57+7F4qnLBE/76d4Y4bwJRADAhc8bPW7JZHLB4bKfgF0Fj
 kpjVdZICd+oNF6HHsHbpgIWJThvUooRQKZdHfQvlwkaY77cZgm1MdXHlBl0jEaM48TQOVP9NR0i
 Fj6glPHjckDz9NaFQcaHBY45QK4K3KCS/c2qvnNV5pqchvP3yhDqxJ0IKldTeeiYVf2gMWHa4Vh
 ulQVpNGujGuAQqZ0Zk2GJoV89gIaJ7wJ8lQO5scLuKFtOmV8HK8lilOzrx80nXiTOumU/Qxp+qI
 3VQJfKv9dAuF9lgRtPi1WiCUMqJvwjJ/+Gb1r8KrF/ESsUhKzrvqgLMNwYc9Q6GiTA+0jxrndoq
 DKuSUljAzsN4dZfiQ7w==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6aa003b5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=wdextDOBopOhIuI0tKgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: n_uIeoWkxEb1tAfiJfjUDKsT8nFFife0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080134

Polite ping.
