Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCEA3C00;
	Sun,  2 Jun 2024 03:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717298120; cv=none; b=G9hAOwOhpmGEv0tbOOmAlKr2k+XkOdM67p1R591IbODlSY71Og3AtoKY2biulldUHMmuznC8L6gGzWtR0QSrlWmK7qbQvOyznVX9J95nMHlenBlkxkENYQQ8SySJ0oADv5/RO0USDymPgUXHuf9rH9XhxCv0GdCLlyQZQW4DdVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717298120; c=relaxed/simple;
	bh=edP8nsQBYJd0TE352wO287BLS+JWhbL3wrSTC+ycZXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jLN9BkhSFmnb4ziV/URU2SUnEyYJnkwubZ9woQ5rdsNJfsPdoKTLJdlGelMulH79mTIPgJWqrqe5O9h1I8yB9JRa12AtNiEulPe+oGMWV4cqitxF1XqPXVhsBibfeLOcon3sGUF6hwiVOdlpduNHo1/aV0U3xF+wE0Vd6fSZYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ALPY0Web; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ALPY0Web"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4521vPHL008978;
	Sun, 2 Jun 2024 03:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oYn5Sk8sgs0xTPxHzq8192f59eLtim9v34973Bym1G4=; b=ALPY0Web6Kn8iWpf
	BBeZsd5lQqjjhgHX+Yca2CLejJTm/+R+7N2yMCQATDZS5bMVlCwYFvn3YzzDgX+H
	9Xf0rIov/cuCGYhVrSPH/29r1Ubg85I0mkaCPuhKLRTwWBJ5z/CwHTWu0ihegO7B
	Qgg015qGjQ6t/Q/7qV4qZ1r8JcIRTuGPlxVsKDWyoGo38ah9rcHqfsk/22vJ0Sjm
	G1DVWs5b8r49pR685QJSr7lxF44Uh6coyYu+vC7Vvm4emVgR9PaXytWa/zXDBBbB
	f1rv3dwHI6FlgohlLqANhe1KSvs6Fs4GF6Cdd57AU5lPRgBAtz/FuE6eYe9BduwU
	GAxh6g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5khj48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 03:15:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4523F8PO015548
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 03:15:08 GMT
Received: from [10.48.241.139] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 1 Jun 2024
 20:15:07 -0700
Message-ID: <42a6c483-5ad0-4985-971d-898ef91cec42@quicinc.com>
Date: Sat, 1 Jun 2024 20:15:06 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KUnit: add missing MODULE_DESCRIPTION() macros for
 lib/test_*.ko
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy
	<anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240601-md-lib-test-v1-1-a728620e37d8@quicinc.com>
 <20240602120126.bdf79b0a209ad016f8a91a73@kernel.org>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240602120126.bdf79b0a209ad016f8a91a73@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V8Lduz61aFqhfa_2OnnlIPUcdVTFTMlv
X-Proofpoint-ORIG-GUID: V8Lduz61aFqhfa_2OnnlIPUcdVTFTMlv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_19,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406020025

On 6/1/2024 8:01 PM, Masami Hiramatsu (Google) wrote:
> On Sat, 1 Jun 2024 15:19:39 -0700
> Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
> 
>> make allmodconfig && make W=1 C=1 reports for lib/test_*.ko:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_hexdump.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_dhry.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_firmware.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_sysctl.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_hash.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_ida.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_list_sort.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_min_heap.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_module.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_sort.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_user_copy.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_static_keys.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_static_key_base.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_memcat_p.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_blackhole_dev.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_meminit.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_free_pages.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_kprobes.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_ref_tracker.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_bits.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
> [...]
> 
>> diff --git a/lib/test_kprobes.c b/lib/test_kprobes.c
>> index 0648f7154f5c..e707f7b3a366 100644
>> --- a/lib/test_kprobes.c
>> +++ b/lib/test_kprobes.c
>> @@ -400,4 +400,5 @@ static struct kunit_suite kprobes_test_suite = {
>>  
>>  kunit_test_suites(&kprobes_test_suite);
>>  
>> +MODULE_DESCRIPTION("simple sanity test for *probes");
> 
> nit: Could you make it "simple sanity test for k*probes" ? because
> there is test_fprobe.c.
> 

sure, I'll spin a v2
do you want me to modify the header comment as well since I just copied it:
/*
 * test_kprobes.c - simple sanity test for *probes

/jeff


