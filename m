Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C18C40584E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112101; cv=none; b=lA+cl3LrRoZiC1E5OsBj1IhnAy0cHrXhQcC4Wze4qTTKZWRUFm362nPp5drLZMVUH1tFqwfuPdqGydPv2tO55tOYN/v/obRi7rI4i9BKMHrfXA8wMTQ1hzmFZ/Fn3G9lZsPIlPDB1YjRUEsve0DbWOJwIp1s4NnwsrvBDqAMWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112101; c=relaxed/simple;
	bh=TsPTaLl4zd51BWfkw9BwNOjMimnL7v0jxxsg0D/DV0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeK6nNKCey6110Qa9WoQZak48jH2vD5bYAGtzs60cyOEkfYBqbhIHjcgHSrXrh2QVN5MQs8aLGGXsZn1TkrDj3I/mgmDC+6vCkzVav5eySuE59KCZubaeQwyS6KrqWZsNQMm2KPHEZc8k+fighXAw7DgeAz1wYkYkXLAUDKwkhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gavHswAi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FL3D02Co; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gavHswAi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FL3D02Co"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IDYv0g2891952
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 13:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N2Nbk6ywjfh6gS17Rx9fkMwIvBKLSedRDvKHTRiJg+Y=; b=gavHswAiwzXoxRxn
	rIOK7IzhysX5RfBgzYPgWnU6GzQxm+uLrW9rf9pVM4c8ncRjpCJbKckp5TfX2Xfn
	3q254r7zf7e/t04lnZ7pSjPE4Ep/Ep8pSxKl2INR5i57AIn4K/X2uKdEoVgj2VZQ
	G4hxOkUCdlPkMPziwXsgWALE6HGbnXaxVwRcoETNQPEyA3Q8HcX/WtXpZLJuLlSC
	U1pLJjiCIZ/VMIIuvL3B2eCcypIZmLxc78ki6NWpFAbUNVmAqI5dxwGHXXH1/do+
	mBzWvFUpe4tyGHQ4Wg3RfeSgHDRcx94TKVUpYNa/b+hXiRVVELBLtIWejVEv7U3u
	ChUC8w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xk19fth-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 13:48:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50e576143baso7940551cf.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 06:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779112099; x=1779716899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2Nbk6ywjfh6gS17Rx9fkMwIvBKLSedRDvKHTRiJg+Y=;
        b=FL3D02CoSROZFPllDTFmXauRTzLxMXIz9YB+NrFjNnIpoMP2whiYj55xHPp8O4jycP
         1Y2CoYtSCKXi0N9DWL5noIfHlpNtQFr8mofYLqMhzCH7Be95FtfQhlpgmnbYrKv39LSo
         EKgrRUehEIU8HgQ8aexG9IUn/X4ka70wu5oH+0sVPjUhmcKaoTPYArOnJiflGjjLTn0p
         TEAsQvH46ed4wGaZLxSwBOTqwGX/9LHwLAtJKrmSxBDAqbMtpMq7lAjcrRa1WnTmqclr
         f58OetHs4YTZYqSvWX9kzaJJoN/0LgPYZIJVNlK3ZqwP8YLVW7Qleir1bjAQzKSCAuvx
         TxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112099; x=1779716899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2Nbk6ywjfh6gS17Rx9fkMwIvBKLSedRDvKHTRiJg+Y=;
        b=d+C81ZRsVpbo4jmcYEAQeU7y5hO0CBOW38zB66kr4LwWdGpuBtTZySa9nMiAenvhiY
         vK618q/ztIcII2vYs5NZrFdNaMkBX5zA5BCU/p/opnh8Bsa0BgpOXBxn7tf5xx1hXRsf
         nu5w1nT04HCDZrllw22a7dD4yJN7A4jfPS0xDjHmHEEtrelCoTrO3sfDJpm8r0OfXGhn
         V2XVSvTM08USiTeeLQLamUpUuC3lO6rEsf/Ebmw8lg0F3pB5epQANwbMUVGRsLJVT5/7
         Ih2uHg2qSObITPKoVTbEikxV4yXCt6i/LKQUpcDzACOG3anbDk69xNWlEkLBovyTJ2Wx
         Ay3w==
X-Forwarded-Encrypted: i=1; AFNElJ8QeSEFjK/MVo+A1VD4MrEovUU96L/CZmtTnsfFsz2s/zPJKci3Lw0xa402tgr4jwkv4UoOJwf85UCgmqK6iY6JrAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2tJ2AOvTtQdFJdHaK0N7GXgU0JOzZqIfxEs8TFsNL01YZ1hEe
	2cvo1v5WcCBdiB9JwBSqh8cPyEH4HXPAKpwidNIAdX3j7i8MYg+CFlUw4RmY8nUurfxnl/iIGrM
	NJtAK/CJDqmr/v0rOHX6Iaq6vQRbKqt1423GIr8PuXddZHfqiZbdvqMYdom6t2g3HojDQdmd4zO
	Q=
X-Gm-Gg: Acq92OEOq+vlFwI22auzb6ZEb9RYnuCTOl2hSOpfdFcl2MpUaH00lfVOiQh+Q0GU72t
	57LDS/VKzvxfsdcNE8Zf07ij0z5o5zIAUAYsnZDVy4jJWm6qcr5wxYQ90+Tk99fBKyPnVu0D2Lx
	f69OiOYYZOcZjPIs59p/Cz7Dp3A841OTyG2kyyKrSaxKJBJYvk8QwcfE5SF1VrGsDhUjjLKhZlw
	udWuvTYjYkRGaMPD52fBJVmyVPQplySGNwp7KW0Eez6m3mdOpNP23jNpChOPldNYA2to6YfVGes
	wi5z+W0R0ffpXcccxPrX6wxDy7Z/XRR0cW5NfPTO40JO/e0AGnZmljIjgbRdfMrYohqR9ycd5vk
	ZC8zWc8+Ru5VZSG905shkFfap7KVqIt4PsUzra6wcye/AP1VMeCya2LiLbJP/h6eQoaRbM0jLDA
	TdLuc=
X-Received: by 2002:ac8:5945:0:b0:509:2b5a:808 with SMTP id d75a77b69052e-51659ffa7abmr160058201cf.2.1779112098393;
        Mon, 18 May 2026 06:48:18 -0700 (PDT)
X-Received: by 2002:ac8:5945:0:b0:509:2b5a:808 with SMTP id d75a77b69052e-51659ffa7abmr160057791cf.2.1779112097727;
        Mon, 18 May 2026 06:48:17 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e2d75bsm561146166b.45.2026.05.18.06.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:48:16 -0700 (PDT)
Message-ID: <f8ce8518-8a4d-4ad4-a948-70e133c91b05@oss.qualcomm.com>
Date: Mon, 18 May 2026 15:48:14 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] serial: qcom-geni: trace: Add tracepoint support
 for Qualcomm GENI serial
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260512-add-tracepoints-for-qcom-geni-serial-v2-0-a5726421b3af@oss.qualcomm.com>
 <20260512-add-tracepoints-for-qcom-geni-serial-v2-1-a5726421b3af@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-add-tracepoints-for-qcom-geni-serial-v2-1-a5726421b3af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BluZgRSVGTE8z_vchJ_h0jyp3jbrMJQB
X-Proofpoint-ORIG-GUID: BluZgRSVGTE8z_vchJ_h0jyp3jbrMJQB
X-Authority-Analysis: v=2.4 cv=BICDalQG c=1 sm=1 tr=0 ts=6a0b18a3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=zro_ik8Ip6B-mArceiMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzNSBTYWx0ZWRfX0PpKzDxyDUSH
 PN9gvcTuYufzoVkzpvZY3ARB4m21BAoo3hjnkGmhIKD929ogiMgdyB27Typh+dKchr74lF1dHhF
 aY6u6O0Jx4BG2NPEjVR8lnC+2x3H00i1zkHA/fC9faTIweybTV+rcZRU3aUAcRlhpstZRSSW1Yu
 thNcJqK2Ps+ib6O68iUiF95viG9y0AAbiZBHuwAU8HOGpq9cruOqTQxvdU5Y/iHcTDqSJJZvP3V
 CysNVmqptdBvwlr+X7ksmHL9McIfoMbFXaOAahbVY9JaX9v6cafyTGM3uXBPf0NqMF3Wil66QBW
 ctn/6x+p3gQ0Df4P4M6/PMPdZsCBt9gWoCSAZSMCyWo8fAWzRmC9csEe2CIf0Vma9xfL0uKWsyY
 iaYM43RhbVaTsq+qSwEpHH6VH9v1onLQutI4aJOG2QMe6fNWbhyWB7eOG9i+nYfQfyZw9jIpRyQ
 olg0XTxBOh96AP+XsFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180135

On 5/12/26 7:14 PM, Praveen Talari wrote:
> Add tracepoint support to the Qualcomm GENI serial driver to provide
> runtime visibility into driver behavior without requiring invasive debug
> patches.
> 
> The trace events cover UART termios configuration, clock setup, modem
> control state, interrupt status, and TX/RX data, making it easier to
> diagnose communication issues in the field.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
> v1->v2:
> - Removed multiple TX/RX trace events, instead used
>   DECLARE_EVENT_CLASS and DEFINE_EVENT.
> ---
>  include/trace/events/qcom_geni_serial.h | 172 ++++++++++++++++++++++++++++++++
>  1 file changed, 172 insertions(+)
> 
> diff --git a/include/trace/events/qcom_geni_serial.h b/include/trace/events/qcom_geni_serial.h
> new file mode 100644
> index 000000000000..5e23827881d0
> --- /dev/null
> +++ b/include/trace/events/qcom_geni_serial.h

Oh, I only noticed now that this isn't in a subsystem/driver-
local directory.. I suppose it's up to the other maintainers
whether they like that

Konrad
