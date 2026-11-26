Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795699945;
	b=3Bhaw573n2ZmQYiuIHARtsxhBJS/uDfusNbUueIx0ufaV7HIO4NypfcRc1D4O0+vZlW1
	 BXs6CHoXMpHtk44fPlHygN0B9B5dK3SCtGCh6tnhN9jotX/Kzcm/0B4kUvh/UHDo7qvDR
	 BirBslAQynAkh+34wlL8WZbk8Y1hq9W6M51leGRi5w1IYVQlEh5gZX2UjLgebbAdL0lVs
	 Z6yUPZQcJndkh31cDicIvG4Q69Ac8grKgqabr9JMVcggW+pD4Ptrd1mrXFrPIZ73YS15W
	 bSf+4DSl2Uv9PfLdWSKq00a31D1CCSOH1EEFk8rDZ00XbRmGe89Mpv1I+rheZw+u1yA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699945;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sI28Li+DzLKmJsQ0m+B2azDOTyIHcTaeGPC7ob45wUs=;
	b=DlVbW0iHQn1IKG47plFua76uRJpMIXt1vA1Y5gW6KHZARiMIAi2NmL+9m9EIAa15pDAQ
	 chIneZAD+l13sGmXSUJ1nAQP9+pAF7dl+ehDQen1bIpVO8aol5IWSY7AxpEVRUqVOZOFG
	 O38gPWiUNJBsPMR15XxRXScTZyoZI9FXX+/8wukC44R+uyuCkEeBMYpxLCwRCaToPHYxh
	 CMXvZ7V8A/xSJT97G6WwvZPtwxt0Fxkh6byD9bNTpmCzd26cFiHPh3GWS2yOArK/YeqDF
	 YuxdFYKRCEa3/KxJ3eWdwk7BfDikrPpEjpR39sWVgp3pk780pvWC89QkpewsHOyM22g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E8kd7VCY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SBvTLwR3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54287606A321
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 13:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54287606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E8kd7VCY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SBvTLwR3
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVc2q2758861
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 13:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sI28Li+DzLKmJsQ0m+B2azDOTyIHcTaeGPC7ob45wUs=; b=E8kd7VCYIxTT4Cpu
	lgGMUnLXpD0kZUAL6X+P5Rog3SYs5GFO2dju2DtYH4R9i9kNtjh0dDOym0Ft8QYZ
	g018+IOtBPipDyEAPe5srii8EzkRDO9lR6uoz6FjQE319ejxX2degYTOzj1FWaRB
	X0Cpe5Wqn/ljiQnqi0AIdDtud/gAQUMPkpUmv9yc0BZ58uTZIjGSRn/gaoUoqzaj
	Vjkk3BesHUMhzvq3JRfpwpC1MuBj9+LWobwpWirCh/qAIU10kOm7AqDDYFKGFwJc
	13hOiJWCZH9KkbeDaRP3cXE8JT18zUIBAhNbvFeH+aRh0gV4Pjp2PS71WT25SfsS
	8nmmRg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j61ahvkd6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 13:32:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ee04c49451so82188225ad.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 05:32:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795699944; cv=none;
        d=google.com; s=arc-20260327;
        b=M2e6JxJs0fSx9wTPyoLyxCjxYjr4YDqQZ8Wp0GU0LrZQiWWXGpXOAQFWYwihCaZJyj
         9CgPsTGjVllMIn/jHMSE7jcpNAz56rvxa6K3lMsCDpFyTlHWDKSZtYlLs4dOLbDkWgOd
         dcY+1O1yZMqQjKfsZ81xAQT1kaGYNpQOwfqBHlxttWGM2ioeS/YXrFkHJpwogcvriZRT
         WK1o5/q4bQm3pNYwinr2SGp/6S2eHOp+vW2OK6qJav8uuIkaCnbd7HUuwbJoSZ6aEHmO
         ssgn+EKPUOKIuBXRy4qnqW6dmeVsNEfiHb4n/DMQ99iA0bX9vS34hQycNlGZo33pC0+6
         7A4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sI28Li+DzLKmJsQ0m+B2azDOTyIHcTaeGPC7ob45wUs=;
        fh=Pyqd4nipsDdJsgkv1Th4ikBcD4WH0Zgqaoe6+lu0/wE=;
        b=Wi7rAtv7R1khJCRo9Eqqy3s3lW9icXuq1BaW0BM6lzl0xUi3EMUsWaDAVO/oTI+9Ju
         eSikVK5+F2leV19Zx3TFY49fty/ssOk3JMMh4SVF0ZlB5GgI59CDK9pV3bniTQ8Ok63N
         jIgClN0Qk6pnFCUhWdI5I17ux1K9Wl3R9YyK73w9vbVf2VTahUkrXeRIR5PyXZC/i8tj
         k8pRG2LImwWp0+OV+H4vPloZJOyhkDaa6rFZqgOAv7Whk1Xv7Uiu4Pow/d5RZgVWjmyj
         cqgbDx2i+Q/5YiLow55Hzb+vkAHjoftOVHljGXf21f8emwG+z57byD7xAh29w4L9sAN7
         9bRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795699944; x=1796304744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sI28Li+DzLKmJsQ0m+B2azDOTyIHcTaeGPC7ob45wUs=;
        b=SBvTLwR3xCLqLWk8VfxQgXoSSF72XtLrs8Ad5pPRfCBGelN766IO8WZA+H0XoKQjMe
         axZk3uHK6XSu5wwcOlXgrGDB58jDG14IfTLziTnVbVobLvGM/KdzEW/kQsh/4VuTwPxq
         Rqcqgl+JGxxCEwKXlHP/pYCAAg8rniJFk7KuWD39/Pi429r73++xZwo6M+LPzDMpZID2
         BcSKvZQV2tNrOU2m4nVt+geotB5Zb5NmlSYQ91Io01Tfka2TvM1m3ekDhmZeGAP6IeZH
         Ay7+YhA8OjWTnvrHX7L/uev4aG+O0aPXEhjps2RqiViNcQPFj41FkzsVmLzwT6VXP03d
         PE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699944; x=1796304744;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sI28Li+DzLKmJsQ0m+B2azDOTyIHcTaeGPC7ob45wUs=;
        b=LzcBSL4cJUPVHaffRBBLVAxxNuz5qxvTTk6CDZDCUY1MHDzn1xxt1Q3GGGArxUpCV2
         jdaN4JJ2K/MF4orGl5rQg2HofWMKTEWIVr22e7sUCn6XjISBrMAxvirs8PZlE+EdBgMM
         VPxSB+RSgyfbJuGI6tXTDnNX5J3eaB4eMubE26rO+9FnU/nTon90e2jDWPtnRUy5mcC3
         5gwhNid5klnXJQedjxhG7HCDhVP2x0TqgCC30HMjbCEAP24fR82LArvH6T+jddZ26QaB
         ZND+YCyuj94ac0p7dNDHTMBqmOaWVDpdxPz5DbfnUEneMNMA4/N2VE0JMt7+oua3TN/b
         ZmZQ==
X-Forwarded-Encrypted: i=1; AL+hErHC3wm/b96tpPEg/FHPm7UeF83QJcbaDUW5F/Tar+JwDBfo7qod2eOXGQoyez6Clv3xHq6oHGYUMh56VElY3FvI7tQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WgY3ObiAQrQ9we459sKofu3RMdBYTlN9hLDOrpJRpwRGiSaMS
	S/dffiIqNkSVLNWj3WYFm6Kse4p/otSfwbzkqocP52uyg9Gbtn48EVdJR2QpYibfot3Mt3+qrhV
	GUrrrjLoli6QWGH1uXs8M+sBYQ/F2r122HTXn6NUWYDBCWHtGQDyv+y/ATBNwDBrT+lg9o2nKqF
	Ro9RVW8DdcUQHpkawiKa12IlTnd7DQiKhVgV4aDRGQx2RN6nlWAA==
X-Gm-Gg: AZFdTZe33T+uj5XtbfndcKmc9FbvLWlTpD/RNm17GDEg3LetNkOVYQ59yRTcDWNmZAK
	Y+97d2upLohWxc5oDOUyDKVO2NXtIYkkBAY7F84QbJhxpEMkh0J7aeSmi0SUo+eYV7OdI3S1qsL
	qgR51ustuIU1KJUhU9NDvl7mMC9wbz3QjGdD0TNgcM59W5Ki1Esg53XpyhNw==
X-Received: by 2002:a17:902:ea0c:b0:2ed:15af:d38c with SMTP id d9443c01a7336-2f03ef44c04mr239219845ad.4.1795699943987;
        Thu, 26 Nov 2026 05:32:23 -0800 (PST)
X-Received: by 2002:a17:902:ea0c:b0:2ed:15af:d38c with SMTP id
 d9443c01a7336-2f03ef44c04mr239219555ad.4.1795699943484; Thu, 26 Nov 2026
 05:32:23 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-add-pmdomain-tracepoints-v3-1-1b41d412b455@oss.qualcomm.com>
In-Reply-To: <20261123-add-pmdomain-tracepoints-v3-1-1b41d412b455@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 14:32:12 +0100
X-Gm-Features: Aa3M54pWNY5rCJkG2YtJadZQS6MdGQmAUqNo-VtLVNXPchDOohVuC4g745cB6ME
Message-ID: <CAPx+jO-M-Mm72q4QL+SGiyZ_8GPLomYGnPH0JVEsSUkt0+opBQ@mail.gmail.com>
Subject: Re: [PATCH v3] pmdomain: core: Add tracepoints for domain state changes
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: naery0EbBIa9J34ZgfhkMMZLmT4EQ-Ir
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1MiBTYWx0ZWRfXwPRTcdL2nBlE
 gzo3bsR3+4O71uutleJL56esNQ36Dhd1f/tapfSWK/Ji85nRqu/h5EFIHPLLR06/5IL5cAOAeAH
 +8yTzXs8XkWCH25TceKeULBk+0+3F1o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1MiBTYWx0ZWRfX6/uYBUREsG0J
 /u+MGQCz1537dAmz6MAFuZhMaZ/QYY916xMA4PsHcR8Ik0pKWh9o0M8JKWNyP3N9vXOuDMXa0Zm
 hbuBd6N9ciqQk5q+hvlDSpipX+TTp8L/e6tkZcc3/2IXjx4yF0eRcOvOiXdH7ZkNIPV9xY0wzNK
 kQzj1b8VKF4QzHhiwMj6UXW56BFrDrlU2vhJRFns19jFGLpgbzkJyjPdO0q4JTBfWlypRNCj4HZ
 IoEpd4NIQglEJTE9v9RD1acM/BuAQCYw+kf3/dUJzB7qsATAszXyQ0diBQeULLEYYyWUYdi5Rgz
 NY9u7/PTTNs+m8Z96J22bivJmF6Ep0ikYtIUNuzM8R3AlYf8C2Kb6Vo/79AEd1F1hhYt15D3dUK
 tF9CMH3diykYv4Iom/5kpuoTYVGUH20wy2vzF/fiV3lDHSgmqohuruEmWSasPeO2HIeAuw5w7wQ
 UirUHuIOyXvkgeshNWg==
X-Proofpoint-ORIG-GUID: naery0EbBIa9J34ZgfhkMMZLmT4EQ-Ir
X-Authority-Analysis: v=2.4 cv=BbxNQbt2 c=1 sm=1 tr=0 ts=6b0834e8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=DEse3a4IbsX6LT34LuUA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260052

On Mon, Nov 23, 2026 at 9:23=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualcomm.c=
om> wrote:
>
> Power domain state changes are difficult to correlate with device activit=
y
> using snapshots of the genpd debugfs state alone.
>
> Add tracepoints for domain initialization, power-on and power-off
> operations, and performance-state changes. Record the domain name and
> initial power and performance states at initialization. For power
> operations, record the idle-state index and return value, and for
> performance-state changes, record the requested state and return value.
>
> Emit the operation tracepoints on both success and failure paths,
> including power notifier failures and performance-state rollback paths,
> to make failed transitions visible alongside successful ones.
>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v3:
> - Reuse the genpd_power event class for genpd_set_performance_state
>   through DEFINE_EVENT_PRINT, to save memory (Steven)
> - Link to v2: https://patch.msgid.link/20261105-add-pmdomain-tracepoints-=
v2-1-10672995e155@oss.qualcomm.com
>
> Prepared with help from an LLM-based assistant.
>
> Changes in v2:
> - Initialize ret to 0 at declaration instead of assigning it before the
>   trace labels in _genpd_set_performance_state(), _genpd_power_on() and
>   _genpd_power_off() (Ulf)
> - Link to v1: https://patch.msgid.link/20260924-add-pmdomain-tracepoints-=
v1-1-d89f3f0a6998@oss.qualcomm.com
> ---
>  drivers/pmdomain/core.c      | 30 ++++++++++------
>  include/trace/events/genpd.h | 85 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 105 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index e0bf30c59cce..c8bc57407634 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -29,6 +29,9 @@
>  #include <trace/events/ipi.h>
>  #include "core.h"
>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/genpd.h>
> +
>  /* Provides a unique ID for each genpd device */
>  static DEFINE_IDA(genpd_ida);
>
> @@ -510,7 +513,7 @@ static int _genpd_set_performance_state(struct generi=
c_pm_domain *genpd,
>                                         unsigned int state, int depth)
>  {
>         struct gpd_link *link =3D NULL;
> -       int ret;
> +       int ret =3D 0;
>
>         if (state =3D=3D genpd->performance_state)
>                 return 0;
> @@ -529,7 +532,7 @@ static int _genpd_set_performance_state(struct generi=
c_pm_domain *genpd,
>                 if (ret) {
>                         if (link)
>                                 goto rollback_parents_up;
> -                       return ret;
> +                       goto out;
>                 }
>         }
>
> @@ -543,15 +546,17 @@ static int _genpd_set_performance_state(struct gene=
ric_pm_domain *genpd,
>         }
>
>         genpd->performance_state =3D state;
> -       return 0;
> +       goto out;
>
>  rollback_parents_up:
>         list_for_each_entry_continue_reverse(link, &genpd->child_links, c=
hild_node)
>                 _genpd_rollback_parent_state(link, depth);
> -       return ret;
> +       goto out;
>  rollback_parents_down:
>         list_for_each_entry_continue(link, &genpd->child_links, child_nod=
e)
>                 _genpd_rollback_parent_state(link, depth);
> +out:
> +       trace_genpd_set_performance_state(dev_name(&genpd->dev), state, r=
et);
>         return ret;
>  }
>
> @@ -878,7 +883,7 @@ static int _genpd_power_on(struct generic_pm_domain *=
genpd, bool timed)
>         unsigned int state_idx =3D genpd->state_idx;
>         ktime_t time_start;
>         s64 elapsed_ns;
> -       int ret;
> +       int ret =3D 0;
>
>         /* Notify consumers that we are about to power on. */
>         ret =3D raw_notifier_call_chain_robust(&genpd->power_notifiers,
> @@ -886,7 +891,7 @@ static int _genpd_power_on(struct generic_pm_domain *=
genpd, bool timed)
>                                              GENPD_NOTIFY_OFF, NULL);
>         ret =3D notifier_to_errno(ret);
>         if (ret)
> -               return ret;
> +               goto trace;
>
>         if (!genpd->power_on)
>                 goto out;
> @@ -917,10 +922,12 @@ static int _genpd_power_on(struct generic_pm_domain=
 *genpd, bool timed)
>  out:
>         raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON,=
 NULL);
>         genpd->synced_poweroff =3D false;
> -       return 0;
> +       goto trace;
>  err:
>         raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF=
,
>                                 NULL);
> +trace:
> +       trace_genpd_power_on(dev_name(&genpd->dev), state_idx, ret);
>         return ret;
>  }
>
> @@ -929,7 +936,7 @@ static int _genpd_power_off(struct generic_pm_domain =
*genpd, bool timed)
>         unsigned int state_idx =3D genpd->state_idx;
>         ktime_t time_start;
>         s64 elapsed_ns;
> -       int ret;
> +       int ret =3D 0;
>
>         /* Notify consumers that we are about to power off. */
>         ret =3D raw_notifier_call_chain_robust(&genpd->power_notifiers,
> @@ -937,7 +944,7 @@ static int _genpd_power_off(struct generic_pm_domain =
*genpd, bool timed)
>                                              GENPD_NOTIFY_ON, NULL);
>         ret =3D notifier_to_errno(ret);
>         if (ret)
> -               return ret;
> +               goto trace;
>
>         if (!genpd->power_off)
>                 goto out;
> @@ -968,9 +975,11 @@ static int _genpd_power_off(struct generic_pm_domain=
 *genpd, bool timed)
>  out:
>         raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF=
,
>                                 NULL);
> -       return 0;
> +       goto trace;
>  busy:
>         raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON,=
 NULL);
> +trace:
> +       trace_genpd_power_off(dev_name(&genpd->dev), state_idx, ret);
>         return ret;
>  }
>
> @@ -2576,6 +2585,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>                 return ret;
>
>         mutex_lock(&gpd_list_lock);
> +       trace_genpd_init(dev_name(&genpd->dev), !is_off, genpd->performan=
ce_state);
>         list_add(&genpd->gpd_list_node, &gpd_list);
>         mutex_unlock(&gpd_list_lock);
>         genpd_debug_add(genpd);
> diff --git a/include/trace/events/genpd.h b/include/trace/events/genpd.h
> new file mode 100644
> index 000000000000..2113bec56e09
> --- /dev/null
> +++ b/include/trace/events/genpd.h
> @@ -0,0 +1,85 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM genpd
> +
> +#if !defined(_TRACE_GENPD_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_GENPD_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(genpd_init,
> +
> +       TP_PROTO(const char *name, bool on, unsigned int performance_stat=
e),
> +
> +       TP_ARGS(name, on, performance_state),
> +
> +       TP_STRUCT__entry(
> +               __string(name, name)
> +               __field(bool, on)
> +               __field(unsigned int, performance_state)
> +       ),
> +
> +       TP_fast_assign(
> +               __assign_str(name);
> +               __entry->on =3D on;
> +               __entry->performance_state =3D performance_state;
> +       ),
> +
> +       TP_printk("%s on=3D%d performance_state=3D%u", __get_str(name),
> +                 __entry->on, __entry->performance_state)
> +);
> +
> +/*
> + * state_idx identifies the idle state entered or exited for the power
> + * events and the requested performance state for the performance event.
> + */
> +DECLARE_EVENT_CLASS(genpd_power,
> +
> +       TP_PROTO(const char *name, unsigned int state_idx, int ret),
> +
> +       TP_ARGS(name, state_idx, ret),
> +
> +       TP_STRUCT__entry(
> +               __string(name, name)
> +               __field(unsigned int, state_idx)
> +               __field(int, ret)
> +       ),
> +
> +       TP_fast_assign(
> +               __assign_str(name);
> +               __entry->state_idx =3D state_idx;
> +               __entry->ret =3D ret;
> +       ),
> +
> +       TP_printk("%s state_idx=3D%u ret=3D%d", __get_str(name),
> +                 __entry->state_idx, __entry->ret)
> +);
> +
> +DEFINE_EVENT(genpd_power, genpd_power_on,
> +
> +       TP_PROTO(const char *name, unsigned int state_idx, int ret),
> +
> +       TP_ARGS(name, state_idx, ret)
> +);
> +
> +DEFINE_EVENT(genpd_power, genpd_power_off,
> +
> +       TP_PROTO(const char *name, unsigned int state_idx, int ret),
> +
> +       TP_ARGS(name, state_idx, ret)
> +);
> +
> +DEFINE_EVENT_PRINT(genpd_power, genpd_set_performance_state,
> +
> +       TP_PROTO(const char *name, unsigned int state_idx, int ret),
> +
> +       TP_ARGS(name, state_idx, ret),
> +
> +       TP_printk("%s state=3D%u ret=3D%d", __get_str(name),
> +                 __entry->state_idx, __entry->ret)
> +);
> +
> +#endif /* _TRACE_GENPD_H */
> +
> +/* This part must be outside protection. */
> +#include <trace/define_trace.h>
>
> ---
> base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
> change-id: 20260924-add-pmdomain-tracepoints-15254f2cd40f
>
> Best regards,
> --
>
> Abel
>
