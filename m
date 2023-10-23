Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FAD12B7F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d8aJGOfi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0403B0;
	Mon, 23 Oct 2023 02:15:18 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N7qj1g000810;
	Mon, 23 Oct 2023 09:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LUoQr0hYJduIxljSjQr0HmVn2PUMQz/Kl4QD0zk+G4c=;
 b=d8aJGOfiNg9+34mYtnKAuCXXJRHhxPA7tnnLe/eseF1whJLbgqdUvM/QQt4dyBBMrJvz
 sQtu0z8IJ45kkOnMVzDR0jJuXr99eN8/OhXxws8jEk6uga5h8vcdC0RmvOUzsdVREfBX
 k17fFcnGLR8rxVJLChZqaU2Q2hp1jO0rJ3reBOk8zopNbcTH3sEpjzGRcbV30QqbHeBp
 upykvrPFrYFOm/QM75tn5+T3UjlJVe0FV6y/QEhiQQ3cuoLzm522hjIBNzg9XsBG/3U/
 rZANZNnxx9bxm8nmjWfiP4Jw/lrTD8QN+J9d4VxoxJFVfNfaZM2eECoJDsfT3PNYnd23 mA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv6873kff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Oct 2023 09:15:13 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N9FCN8030486
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Oct 2023 09:15:12 GMT
Received: from [10.216.32.116] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 23 Oct
 2023 02:15:10 -0700
Message-ID: <bf577aca-77f5-d50c-7a3c-28b0a5b6928c@quicinc.com>
Date: Mon, 23 Oct 2023 14:44:59 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tracing: Fix a NULL vs IS_ERR() bug in
 event_subsystem_dir()
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Steven Rostedt
	<rostedt@goodmis.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <ff641474-84e2-46a7-9d7a-62b251a1050c@moroto.mountain>
Content-Language: en-US
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <ff641474-84e2-46a7-9d7a-62b251a1050c@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j2UWuHmje0Xo7GCze61x4CmOSFT_pbgS
X-Proofpoint-ORIG-GUID: j2UWuHmje0Xo7GCze61x4CmOSFT_pbgS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_06,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=897 impostorscore=0
 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230079



On 10/20/2023 7:22 PM, Dan Carpenter wrote:
> The eventfs_create_dir() function returns error pointers, it never returns
> NULL.  Update the check to reflect that.
> 
> Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use eventfs_inode")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

LGTM, Thanks.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> ---
>   kernel/trace/trace_events.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index db46d2116500..f9e3e24d8796 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2354,7 +2354,7 @@ event_subsystem_dir(struct trace_array *tr, const char *name,
>   		nr_entries = ARRAY_SIZE(system_entries);
>   
>   	ei = eventfs_create_dir(name, parent, system_entries, nr_entries, dir);
> -	if (!ei) {
> +	if (IS_ERR(ei)) {
>   		pr_warn("Failed to create system directory %s\n", name);
>   		__put_system(system);
>   		goto out_free;
