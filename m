Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD49C6FA9D
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  1 Mar 2023 14:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCAOFe (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 1 Mar 2023 09:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCAOFd (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:05:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9F82A6F3;
        Wed,  1 Mar 2023 06:05:32 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321DRUkJ015784;
        Wed, 1 Mar 2023 14:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=P5ET8qBLDn34D7OkJoOyAwbq2DhePVDTPzxjHBx8I7o=;
 b=ESxCNK1vIlDo93unv6s/gYDbRrXYTKaoSOT7COGP8JJRLRTPTcUDxRvAtA8UPkwVjNAQ
 vVR8NN2gA8p2t4FXi4DOMsPz1ic7qzJ5z1EVqDPPrNWgyruMY6vKcR9uLjitRBCX1Vm7
 FFTCe+l/uTHEzR/q94/7XyoX7cD78QfcNzD+CTqlQy51YWxu2T0jxPeqBvqdMgSppkqc
 /FjfCCEdHLXkBDqMqNjyOBPWutQRZ/Ktp39zfQl2EO6ULfb5yqKJNm6NLSOaK4LVEwmM
 AHgxyZ//KnjOwXSTCC6DrkmnSGoLbNS3N/IaCAt8GgawnC4IhupS7v1IlDTkFGt1uR2x Mw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1mwxb24d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 14:05:18 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 321E5HCi009727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 14:05:17 GMT
Received: from [10.216.28.98] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 1 Mar 2023
 06:05:12 -0800
Message-ID: <e6b29d58-e517-4064-8c4d-ac580ca6e016@quicinc.com>
Date:   Wed, 1 Mar 2023 19:35:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] bootconfig: Change message if no bootconfig with
 CONFIG_BOOT_CONFIG_FORCE=y
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <ndesaulniers@google.com>, <vbabka@suse.cz>, <hannes@cmpxchg.org>,
        <joel@joelfernandes.org>, <quic_neeraju@quicinc.com>,
        <urezki@gmail.com>
References: <167754610254.318944.16848412476667893329.stgit@devnote2>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <167754610254.318944.16848412476667893329.stgit@devnote2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: podqk58quiT_NrwlvamdFAZIalmxhDCl
X-Proofpoint-GUID: podqk58quiT_NrwlvamdFAZIalmxhDCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_10,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010118
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org



On 2/28/2023 6:31 AM, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Change no bootconfig data error message if user do not specify 'bootconfig'
> option but CONFIG_BOOT_CONFIG_FORCE=y.
> With CONFIG_BOOT_CONFIG_FORCE=y, the kernel proceeds bootconfig check even
> if user does not specify 'bootconfig' option. So the current error message
> is confusing. Let's show just an information message to notice skipping
> the bootconfig in that case.
> 
> Fixes: b743852ccc1d ("Allow forcing unconditional bootconfig processing")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/all/CAMuHMdV9jJvE2y8gY5V_CxidUikCf5515QMZHzTA3rRGEOj6=w@mail.gmail.com/
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   init/main.c |   10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 4425d1783d5c..bb87b789c543 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -156,7 +156,7 @@ static char *extra_init_args;
>   
>   #ifdef CONFIG_BOOT_CONFIG
>   /* Is bootconfig on command line? */
> -static bool bootconfig_found = IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE);
> +static bool bootconfig_found;
>   static size_t initargs_offs;
>   #else
>   # define bootconfig_found false
> @@ -429,7 +429,7 @@ static void __init setup_boot_config(void)
>   	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
>   			 bootconfig_params);
>   
> -	if (IS_ERR(err) || !bootconfig_found)
> +	if (IS_ERR(err) || !(bootconfig_found || IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)))
>   		return;
>   
>   	/* parse_args() stops at the next param of '--' and returns an address */
> @@ -437,7 +437,11 @@ static void __init setup_boot_config(void)
>   		initargs_offs = err - tmp_cmdline;
>   
>   	if (!data) {
> -		pr_err("'bootconfig' found on command line, but no bootconfig found\n");
> +		/* If user intended to use bootconfig, show an error level message */
> +		if (bootconfig_found)
> +			pr_err("'bootconfig' found on command line, but no bootconfig found\n");
> +		else
> +			pr_info("No bootconfig data provided, so skipping bootconfig");


Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

>   		return;
>   	}
>   
> 
