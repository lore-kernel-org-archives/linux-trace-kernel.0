Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D102D28F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DLXA+u/j"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3033ED;
	Tue, 31 Oct 2023 02:48:33 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V6dd7F021340;
	Tue, 31 Oct 2023 09:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4y6/UUnLiFspiisyLHIS98YUAP4Jpm3aumYKQ9G92Q0=;
 b=DLXA+u/jts1mAC9eV4SUj7EyTBXRmuHg5Tmuu/Nk7jHMfgMnmtpRL0WEQNxJ2Ch1QuMQ
 XUnA3ZSRY/2d3lcDxyW7EXzuMnwqeM5GGwaE77c42wAG5N0vyjhIgqgz4kLVcrgsX4et
 Bhpx4a/xiMjvTwwgtnWkuXp5MWErxbdLZ0/+JbQU/DkmgFDbi1F3gthuUB6Q+Zb96gdg
 sMmHHmALmjGwWRnzZcDUeVPSC/L8AifozbGtL1SPMPPqvD4cmwZWnxIyXR/5JYqEF1dy
 KOsN87rU4ESc1ZHHE+qfU2zcbEBLpiq7ntO3f9bX6QFgn16K4hH06RscHgvnhtPQlRDL XA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2tpx0n4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Oct 2023 09:48:28 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V9mRCQ029465
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Oct 2023 09:48:27 GMT
Received: from [10.214.225.95] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 31 Oct
 2023 02:48:25 -0700
Message-ID: <98413d47-986f-bf94-0793-865a5a4dc80d@quicinc.com>
Date: Tue, 31 Oct 2023 15:18:14 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tracing/kprobes: Fix the order of argument descriptions
To: Yujie Liu <yujie.liu@intel.com>, <linux-trace-kernel@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt
	<rostedt@goodmis.org>,
        Tom Zanussi <zanussi@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231031041305.3363712-1-yujie.liu@intel.com>
Content-Language: en-US
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20231031041305.3363712-1-yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lbzy1QKhATs0k3Ybj_mYhOnzIQdegUY0
X-Proofpoint-GUID: lbzy1QKhATs0k3Ybj_mYhOnzIQdegUY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310076



On 10/31/2023 9:43 AM, Yujie Liu wrote:
> The order of descriptions should be consistent with the argument list of
> the function, so "kretprobe" should be the second one.
> 
> int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd, bool kretprobe,
>                                   const char *name, const char *loc, ...)
> 
> Fixes: 2a588dd1d5d6 ("tracing: Add kprobe event command generation functions")
> Suggested-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>

Thanks.

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> ---
>   kernel/trace/trace_kprobe.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index e834f149695b..47812aa16bb5 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1020,9 +1020,9 @@ EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
>   /**
>    * __kprobe_event_gen_cmd_start - Generate a kprobe event command from arg list
>    * @cmd: A pointer to the dynevent_cmd struct representing the new event
> + * @kretprobe: Is this a return probe?
>    * @name: The name of the kprobe event
>    * @loc: The location of the kprobe event
> - * @kretprobe: Is this a return probe?
>    * @...: Variable number of arg (pairs), one pair for each field
>    *
>    * NOTE: Users normally won't want to call this function directly, but
