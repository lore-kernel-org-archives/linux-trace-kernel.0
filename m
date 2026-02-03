Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2712BDC16;
	Tue,  3 Feb 2026 02:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085912; cv=none; b=tJutlNFHOZN4TomNsSnTUZ2aWC0lb88KGjr6FHu241aCx2+40yCfx8m2WhG0VUTXbB3HcjuTednomfne6TEq7SCk2fFlj5eE/jxzTjzwJ8pmL/CiwoEAMjrDnjBtv38vZiaNLroeFbhptmUiSpA1szQy4yTeR1KcdYuCaRl6Iq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085912; c=relaxed/simple;
	bh=O+nYy5tZTS5nGbiW/bOFLVTSYy3UHSU8BFNWdmqBh0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ak7/cdjGxquajybtD5tFDsp3/4Qx7Xdq4ezr406DuGNM44EQmuJ7oBhQMRDATwaGdpwgQEIyCAnKq2xgBRHw/d1hWLxtD7XZqUkfgYb0VzUtpGLskZgCXbqM0+tcdTVI0h0QVE7zWqCRImVH4Mw/BK56FmnlbjQQrTnX4FF0mzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=egMzwR+L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="egMzwR+L"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612Fl1g83386990;
	Tue, 3 Feb 2026 02:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Eo/PIKYomjnKCQ1rpvBvw5Af2hkuVsEaK7Wwmunp8EQ=; b=egMzwR+L3+GFcgRo
	nogQlu8FROavcoXbIl4tkaTgJWnj0xUpMUpoQgFuGtEqa0WYg204cWp6xJDTyrXI
	iq8ipEe03lyicix4edCQo5VMGINXSPnSKFJI2lQhe2XcIETVZGytDBflNhx8t3eK
	8vIxoS+X2GxYe12uacyqejLSmNcTYsJZ2f32hi0SA0qPXJRXTbSAbo6cfE58cLr8
	AVqQ0X3qiSeRLddhDX8/Ddv/DUgvN9tzgTkwGcV8d5sGeSAjqLj7cdEi3XgMJ7E/
	qZh0lzfGT4Y+/99EJFM1/vMqxnt0/gRiOlMAPj6geuKuuBbFhGeEMzyg6U5n2KlC
	IRlovw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2xvbsq2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 02:31:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 6132VQDJ024983
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Feb 2026 02:31:26 GMT
Received: from [10.233.71.148] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 18:31:23 -0800
Message-ID: <7b02f748-7442-4272-b3b5-0dfff7c15e33@quicinc.com>
Date: Tue, 3 Feb 2026 10:31:21 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] stm: class: Add MIPI OST protocol support
To: Randy Dunlap <rdunlap@infradead.org>,
        Yingchao Deng
	<yingchao.deng@oss.qualcomm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Tingwei
 Zhang" <tingwei.zhang@oss.qualcomm.com>,
        Yuanfang Zhang
	<yuanfang.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>
References: <20260129-p_ost-v5-1-2b14fff39428@oss.qualcomm.com>
 <0ed08d07-5736-4874-9a0f-0f848e8419b6@infradead.org>
 <9ed4124e-a6f4-4994-a80e-860a1123c8ba@infradead.org>
Content-Language: en-US
From: "Yingchao Deng (Consultant)" <quic_yingdeng@quicinc.com>
In-Reply-To: <9ed4124e-a6f4-4994-a80e-860a1123c8ba@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ecqp3wLW9ERCAqOi3rlXPti9PPDEb91N
X-Proofpoint-ORIG-GUID: Ecqp3wLW9ERCAqOi3rlXPti9PPDEb91N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDAxOCBTYWx0ZWRfXzZdShie3Qx32
 ex/NTsH+bXvnaLc8rZkaPRqyfbD0bOZcgTRwW68VTv75p7my61flx+yvta3v67jHUTpPJ5AGOR8
 oOJxNbrZdBgz8M7dd1IMWnbfWPoa++9cYNlHHCSy22oemwnxY3jmh5EVMUODdHvtrW8EpNM1R2b
 ly99C8BmDFSDeRjjQkJ8eBT0v7oFk7Ky43S4CztCEqKtq+rnSOjJ2LuLZF897aObKmBNEqce55n
 fKElaefn4QbxvdAlqGuXlHhCpyVpfh/+XbZbAoKka3O2qGRuK3P/HX5d8Yp4JkrZ7WjydPCFDRa
 NBdLITKN6WiBfo6Aj+oDxbXaWikN0nxeDP5mV+3NmBJ5tHPlr52osw/o0tiVvKBJhpGn7Aju3LP
 oFHCMWeh5h/8ER3OaBzYM+ghsGmov7DHeEi+8utiuUUgZPv/8jctOmXMC9N8UmEQqTDea6LL4uM
 YYA/ZoewygapLrJcTuQ==
X-Authority-Analysis: v=2.4 cv=AurjHe9P c=1 sm=1 tr=0 ts=69815dff cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Dims_e6JDq1Cz65YlcUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_01,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602030018


On 1/30/2026 2:38 AM, Randy Dunlap wrote:
>
> On 1/29/26 10:31 AM, Randy Dunlap wrote:
>> diff --git a/Documentation/trace/p_ost.rst b/Documentation/trace/p_ost.rst
>> new file mode 100644
>> index 000000000000..df93b889eb4c
>> --- /dev/null
>> +++ b/Documentation/trace/p_ost.rst
>> @@ -0,0 +1,36 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +===================
>> +MIPI OST over STP
>> +===================
>> +
>> +The OST(Open System Trace) driver is used with STM class devices to
>     The OST (Open System Trace) driver
>
>> +generate standardized trace stream. Trace sources can be identified
>> +by different entity ids.
>> +
>> +CONFIG_STM_PROTO_OST is for p_ost driver enablement. Once this config
>> +is enabled, you can select the p_ost protocol by command below:
>> +
>> +# mkdir /sys/kernel/config/stp-policy/stm0:p_ost.policy
>> +
>> +The policy name format is extended like this:
>> +    <device_name>:<protocol_name>.<policy_name>
>> +
>> +With coresight-stm device, it will be look like "stm0:p_ost.policy".
>     With {a | the} coresight-stm device,
>
>> +
>> +With MIPI OST protocol driver, the attributes for each protocol node is:
>     With the MIPI OST protocol driver,                                   are:
>
>> +# mkdir /sys/kernel/config/stp-policy/stm0:p_ost.policy/default
>> +# ls /sys/kernel/config/stp-policy/stm0:p_ost.policy/default
>> +channels  entity    masters
>> +
>> +The entity here is the set the entity that p_ost supports. Currently
>                     is the set of {entities | features} that p_ost supports. Currently
>
>> +p_ost supports ftrace, console and diag entity.
>                                             entities.
>
>> +
>> +Set entity:
>> +# echo 'ftrace' > /sys/kernel/config/stp-policy/stm0:p_ost.policy/default/entity
>> +
>> +Get available and currently selected (shown in square brackets) entity that p_ost supports:
>> +# cat /sys/kernel/config/stp-policy/stm0:p_ost.policy/default/entity
>> +[ftrace] console diag
>> +
>> +See Documentation/ABI/testing/configfs-stp-policy-p_ost for more details.

Thanks, will update.

Yingchao

