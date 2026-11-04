Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793752347;
	b=u8wO0eiw4OkHEIIoDcgcJthSX/HvDW30N1zs755lGzCKAtyyf1GQkkh8nJMrT6ersiJY
	 moX//Dk7jxZau5EdwwiSzYPAtN3i+cmsfE4isXj9RMRcjLY8JCW8K5myfAuSyEy1c3ppe
	 Sg6KxPDZLloPbWtqMxxOKI+LNmpaoV9IHKN9OpGCcWwUfpo9Bdq6ubwlPslKdGFjULv4G
	 iL3l5Y3dEyaG21nlP/bOQtTKJWW1ItSQlxcRQYDP/tZPtktc+N0yfU71A11OEEsK1SiRU
	 GNRBuWu1+KctdGl4MWVMXKgHYZ7xwfvgplQs7IsTjtqXiQAxBrSXIwuCF1ORts7Wprg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752347;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=E3LEqmXFvCMbyxfxq/JJyPbTV3zJ6Nq1u+0O1KDxtrs=;
	b=if/hpBeK3MquyBquMZ6pSvNTB8DyaA9MiL57MDw3FqytpQsKPzT8/Dp10dabf0AeULpZ
	 6dN46x6yUZoQk38vT5DUlSyo93d3aoM7cW9UQF98itlfQtW7ORNRS7grS53U+VW/mAuMR
	 8PGrT5FwjgXOflNX+tBMt1fB9wlw6v9rl8utAklcqSJY/X5jiMm2SkQ17oN/oDc0KBkBj
	 Hk5i6uDJ6nyUcxfdDx8j5Tlb45IK8Syjqk2XGnT9KgZpXVzl8rJdHjVGZZyqSV8k+/7a5
	 3i8wJEEjLYYjit/0Htdi6tvTXXJgm1uVv165tB331Rguv55JZgPGuJRE9Aqu8j7jJuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=paiI94ky;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TQYs9AZx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4503606A328
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 00:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4503606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=paiI94ky;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TQYs9AZx
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40RFEP3335359
	for <linux-trace-kernel@vger.kernel.org>; Wed, 4 Nov 2026 00:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E3LEqmXFvCMbyxfxq/JJyPbTV3zJ6Nq1u+0O1KDxtrs=; b=paiI94ky07z36C9R
	BtdvPo084taLci37jZ/cv/Fv+bqQY1xY8PlFhH6tigp16aICkFdPaWXfy+U/jMfR
	akbJ0N8AoAhHPBl8+9GqFTDfm1xmfoPmcnLULxly/FO2YMN7hO/h0632CQ+XCJFu
	9zyLNGvLA8Fo4IiV7O16a8UWwj8kAdE8djso/2/gYMNWwM8Ip05fi8s729SQLPzj
	vzkoAxXHDYMrcti/uBaJsFyL39EXJi7kA3kvUW6kEkdSXljydXDiOvKb4bwKjxMZ
	ffxpScMbmBARv+lADcOX86zuUrSPCk5uliWos+/GRoe0/hGCUnDZtsjOeRs2oTYz
	eev0Fg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqmjbsb5x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Nov 2026 00:32:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e94f72fb9fso1327615ad.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Nov 2026 16:32:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793752344; cv=none;
        d=google.com; s=arc-20260327;
        b=MBsoRny0tGyg7dAG8qawZ1v8qtkCPhq+unMXTuo8aMrBhZ3ztBDU9DMJEMG+Psibzn
         V5xLrezUqI2uLXS7jQdKTZ+caOJhvUBiT2EbDZV99mUTBa8shSIFeFICnTyKWXEeO1vs
         e2sPRtylnGIbnB2eWF6zGWxt4SG+KTryjFvVJiMnYVmsKhg0j/yhmUw3R7Kua5NVpBnH
         FXN2/SSEU1wHYAwh5N1pOGVNh2pCOBWKn//eHwLbn5EbwCJ7znY7A74Ll7fj+MlO0IiV
         zGAnGNeae9TYE5iHVn6K0C4uVozSADLPrfiQFIhwEIxOhH3jWYKKf+M1+uAdSSdy1ol0
         NEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E3LEqmXFvCMbyxfxq/JJyPbTV3zJ6Nq1u+0O1KDxtrs=;
        fh=Gz/OWLwMMVuYBxNt8GBwIroTWNY1hLjKIVipivZd5Uc=;
        b=C1nL+5pEQEuZ4WDl0ipjxPapAY24EOR0WnIPWrRfTzHvNaSef7Fwrpa55AFuj2AMvx
         n1leGlLThxXFeWgcLvCrYUkAz4sDbG1oSoCaeUjPT1vQb5ZCw3bAQ2vts9qDy2/pbIF1
         tbH5RMCamAwh/Zr/9TZhI2ifol+MZAtIOBPmCoKmmVmS/gOjj/Rfe9SmIKnqULsle3hv
         3UanENqdgHL4wn5RAmpRW7ey8lnQsVrcOcKx3yLcyA6VZP8z5TmM4nrHAuA940FwLULX
         2Z22dKpz4mfp2MRubG5SY+c78EChw+SjNozbu3bk6mrjuWEg93g0zCXR6RWXapxHYTQz
         sa3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793752344; x=1794357144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E3LEqmXFvCMbyxfxq/JJyPbTV3zJ6Nq1u+0O1KDxtrs=;
        b=TQYs9AZx3UZffDbI7HR50AL5laQngj0Tr/BhplqwFL5UTFBS7Ut4wtdNcwR7xxxMUA
         hTHBXUo9Qc4JxyHaKxdQffADLJMAPkr53MDJEOcAUOpnLp2X+82DHArJVcetDruBrgff
         0xxmv/44/weCM3dcqD93qLH8ogjEyt0jxJ7ATO65lUtQSactrdbMyiSwxLs8wFXBBLU8
         +Flr5nLkyWHCSlndHK4Jbbkhk1J1z9cTVcznCcyP1tWDk6qM4h86p9g9rbs3OQhFQUrx
         5rJuCylBQbmXshxbv0HFZvqH+HlUjHQH0DiJJFEm60CGiLzkeqeK1TWqncgkQQLj5nKg
         YAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752344; x=1794357144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E3LEqmXFvCMbyxfxq/JJyPbTV3zJ6Nq1u+0O1KDxtrs=;
        b=DNuAs4OsJ3o58DBocbmps/ivuOI+remuXfs/kpDI9FAVliRW3J3wZJcK3L9fW0Wn+l
         kOIKlSY3b/YymMHpIXzOrCMfra/r/yxGpIyyI5HmXwUNFp943IuGe+EeG2EAy0DcRBXL
         DEQ+uWWqpal8jYtYN5gMgjfIORDbJ9VpqqGDWMLxIbnKz2cOUJXXGvLAHfN8DJl79PHB
         MD+j59lpCnNArOzIrBrGBoKIw1B70xMyVyKx53qtwAjChE+RRKcZGLUp+k5SxYZ1G/bM
         106DR35eif0mm2PB7bt1rYDNNmSKFhz57OGAOxl8UW9+B9zMSGpgnvptSK6Wpt1iFpYF
         NjKA==
X-Forwarded-Encrypted: i=1; AKwUvByJz490VXvtH4kgwVykpQDp0UVIq+2TKmJV7KUTd0XGabn+8wfwC4LT2bWq4i2YHOBSjLqI2FM1F1IzMz9lfj/XiYo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8762Gq/bIRrOTJkzc0nQxIgMAmM+HoaNctnrW0gd/fZGm/x/Jw
	hX5wn0fHmmKPFPYjNCPp+9N8VIcRLi9VMBFHfoQbWe+e+N7SMvDe3QIyIonjL4Gck3qi/Gcngep
	dYXiRAvAs4AEH2uopu3ksshyZcZKSUzfAysCk2uUvBzxjgTcg495b1JYFHfT8F/XZgXiPYAjAiT
	khGYtfxuP/rm8jR29Vl5ZSavd62CWnJyG7zhUbBRQhVkg0oLnPEA==
X-Gm-Gg: AYBFou098nAVPNsUistd8XyuC2GqNr8/mHCxdxdZATYDAKLhV++T2VZeT0hsKzhzNZT
	hdFLcq9ZIw8eR68BIj520M1j0Yb1AaIJpfvBMo9ICW4iaNvZk16gm/mlSG3LNnyZftrFY84/3Vc
	b/COxrDVGJPErcnMu76cE/Oho1ASjIAdo3IpTLNe+2lv4svJqCVq9zhBN/zW0=
X-Received: by 2002:a17:902:da4b:b0:2ed:e0d:dbb2 with SMTP id d9443c01a7336-2ed0e0de332mr151255ad.36.1793752344382;
        Tue, 03 Nov 2026 16:32:24 -0800 (PST)
X-Received: by 2002:a17:902:da4b:b0:2ed:e0d:dbb2 with SMTP id
 d9443c01a7336-2ed0e0de332mr151045ad.36.1793752343938; Tue, 03 Nov 2026
 16:32:23 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260924-add-pmdomain-tracepoints-v1-1-d89f3f0a6998@oss.qualcomm.com>
In-Reply-To: <20260924-add-pmdomain-tracepoints-v1-1-d89f3f0a6998@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 01:32:11 +0100
X-Gm-Features: AclHuK_yJ0UFNaHojG-mXEOXNFQIByshULBfM9QEn2cdyRS_Or0qUUS8_D9tVQw
Message-ID: <CAPx+jO97Af9xvSigY71U65GozKRCpuCjU=7DBEqBXMbN-fRcQA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Add tracepoints for domain state changes
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: LvTJyd4aHa69K3GAOGuiyNgm8g3OaHoW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAwMSBTYWx0ZWRfX74Db5+3OywEY
 AcQX6USikM+ex2VwP4ND4H4TAclPhQjhEdZmPPW1/pHa2wvkOfcMDklBZXFfyYkvW6fuPNGK5hS
 FiWLKquGIPXMv6Q4DyF6mG51HiD7ybWb8+aoKQpQwtYWK9FJmUrdifMe+o5/yvXBUQ6aVuzFAeQ
 wHoMNJ97SSuiGAfUvxAQ+Oip/6FbRHxXkDiTFe5DMrURH7Udrt4Si2d4yZS02WDXYTKqSmi77jJ
 E2XHhaGv9QPc/ojJD/7XBnWKIBQjFxSkeepxL/7m5U1e1tBFrebS3GOWQtK71ZlZ7xx1YUsv2fe
 WeIoSgU3a0slt6HJrTEWhxYl0X82SJx806d+aWCCRDxnHK68UYsN2K3MxH9fT7ByHfBH+D3/xuV
 aTNYtn/047g4AGYfGtOHlXhvs1KC/2G3pNYnHcaqHIOQ0gcd8H27THMxvM4LEA/BXS69Lu4tBUz
 691bB/qoE/gBcPGjmyQ==
X-Proofpoint-ORIG-GUID: LvTJyd4aHa69K3GAOGuiyNgm8g3OaHoW
X-Authority-Analysis: v=2.4 cv=NMhAaE6g c=1 sm=1 tr=0 ts=6aea7d19 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=a0ICRLMdHAicX5uOO4UA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAwMSBTYWx0ZWRfX5Md4cwvNchtG
 INt77K/LI9gQvY5Q88fHgD0V5swITtbInU28bmlgikE/Ma7caW4MTRo+ZrF6nKGOpUguIW9kKlg
 3mfq94+G13W/rMrDNrfG/AgG+gFzHvg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040001

On Thu, Sep 24, 2026 at 5:07=E2=80=AFPM Abel Vesa <abel.vesa@oss.qualcomm.c=
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
> Assisted-by: LLM
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  drivers/pmdomain/core.c      | 27 +++++++++----
>  include/trace/events/genpd.h | 94 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 114 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index b99c2dcf3d8f..62bd29e5918d 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -28,6 +28,9 @@
>
>  #include <trace/events/ipi.h>
>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/genpd.h>
> +
>  /* Provides a unique ID for each genpd device */
>  static DEFINE_IDA(genpd_ida);
>
> @@ -485,7 +488,7 @@ static int _genpd_set_performance_state(struct generi=
c_pm_domain *genpd,
>                 if (ret) {
>                         if (link)
>                                 goto rollback_parents_up;
> -                       return ret;
> +                       goto out;
>                 }
>         }
>
> @@ -499,15 +502,18 @@ static int _genpd_set_performance_state(struct gene=
ric_pm_domain *genpd,
>         }
>
>         genpd->performance_state =3D state;
> -       return 0;
> +       ret =3D 0;

Nitpick, probably nicer to initialize ret to 0 while declaring it.

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
> @@ -842,7 +848,7 @@ static int _genpd_power_on(struct generic_pm_domain *=
genpd, bool timed)
>                                              GENPD_NOTIFY_OFF, NULL);
>         ret =3D notifier_to_errno(ret);
>         if (ret)
> -               return ret;
> +               goto trace;
>
>         if (!genpd->power_on)
>                 goto out;
> @@ -873,10 +879,13 @@ static int _genpd_power_on(struct generic_pm_domain=
 *genpd, bool timed)
>  out:
>         raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON,=
 NULL);
>         genpd->synced_poweroff =3D false;
> -       return 0;
> +       ret =3D 0;

Ditto.

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
> @@ -893,7 +902,7 @@ static int _genpd_power_off(struct generic_pm_domain =
*genpd, bool timed)
>                                              GENPD_NOTIFY_ON, NULL);
>         ret =3D notifier_to_errno(ret);
>         if (ret)
> -               return ret;
> +               goto trace;
>
>         if (!genpd->power_off)
>                 goto out;
> @@ -924,9 +933,12 @@ static int _genpd_power_off(struct generic_pm_domain=
 *genpd, bool timed)
>  out:
>         raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_OFF=
,
>                                 NULL);
> -       return 0;
> +       ret =3D 0;

Ditto.

> +       goto trace;
>  busy:
>         raw_notifier_call_chain(&genpd->power_notifiers, GENPD_NOTIFY_ON,=
 NULL);
> +trace:
> +       trace_genpd_power_off(dev_name(&genpd->dev), state_idx, ret);
>         return ret;
>  }

[...]

Kind regards
Uffe
