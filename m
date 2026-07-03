Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66073D8909
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Jul 2026 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086072; cv=none; b=IMd1VVWRQA+FpCl+crRsj+KeYe2+spsH0d1VzXIO+OwN6iD8JwzAvOiCzMpZm5WKu5FDsOb2GEPdkNXI9VTa7awLwGLaWpZcL0f2U9DYl4rcPRSws1X/14ZPI1hJ3B73uHNYRls66ICqxxMNDCIv/OMLZuoq9DayQJl4PGpXnB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086072; c=relaxed/simple;
	bh=he9cX6jEcZEfVujqV1zCzc5qhfJIrA0GiR+K6I2CB/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pp4IRY65q2a++Y5vXQ6ix4VHAUfa4wBrrYym8wVFvIxcof3QC33WNY7SCLOihjXIQ1EfVXlzFKA81R/+LJ0FE34d2IbETRqLA5P4AqBMH2CgInnlAiSXDnbA21Pknme9s8hUK81S9JNEiHpIJqeZj84aRT3CJmCNk2LuLFJg7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y733nta0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ChETj1vM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y733nta0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ChETj1vM"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663D16R1053891
	for <linux-trace-kernel@vger.kernel.org>; Fri, 3 Jul 2026 13:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xHoWqgO4GGZQYSbUIkeyWKJxMlWu2YG7NbRNUUTVKQE=; b=Y733nta0Ed05LQVY
	2nkqryDpPGe+/VmOmPcrRkwvXjCULclXx+fqYVKbKabzriS3Hirs98E9MGk7MNO1
	vFgAd8eYQUOyya0jdPDfxypWvRYzFNFjNTlQZg0TnrFL2SQOWmELjWWO9SwsKxoy
	lJRNSJaOs3cz61rv4hM+wZH+Sm2WYGKPvnni2myBg1+iYOxTso3oGas9SmoZEHoU
	PjFDGWGqr+tJR0Kn2cvQ1T2T+Sp9/aVw4yah+BCAgexcMXV7f9qAR1rGgNj1HTH8
	03HxutIPCR5Eu56SDm9TsX0GECIE19j4JF7f5H3qtoUQ74nkseCm9bwucqSA/y4b
	noIL8w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkg49w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Jul 2026 13:41:09 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f2747d334dso1572106d6.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Jul 2026 06:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086069; x=1783690869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xHoWqgO4GGZQYSbUIkeyWKJxMlWu2YG7NbRNUUTVKQE=;
        b=ChETj1vMSWEzvf4zhdhElZOhdXRTCNDqn1Plf+xK0msLtf/9KJDJLqhM29lZBaw5fX
         jjRgntNvPrj0+z5GgPSjjrJoZ2VdLFX1EkQrerJ/9t0jkPsJ8Kso/wq4/xoR/swr4h6V
         oqyZ3dsmzFSZ3XO7RIJE/MR8J/n+XaeqSlLGKYMumLXdT9NaUbao4IX1vo/n3ZD9OptI
         j6RjCM0oeSak/1QN3Ja1JykMa4mh2C/mbD62BdTX/E24X76Vy88aBYPxT/7CF1gAppX8
         2IOQRcutU7i+i/twx9y0kCu6YYh7O3jpoPsp4ifCEq2gsZPccWEOCp7K+4csiPDX86Pu
         Ai/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086069; x=1783690869;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xHoWqgO4GGZQYSbUIkeyWKJxMlWu2YG7NbRNUUTVKQE=;
        b=suzZTeC+xsHBKHPKsbM1ICIVRCvSrxLNRKeW7KDt9XVWUvNg1sGYOGVmamGDL4+8KE
         0q6GHBT7nCfZTGLt8lVf+hM2CQx2IjRirUpk8vBrT6ea6cSDM1itWu1Ozfa1imAh6Ybz
         k3CycDrdqTbOvY5vhWE+yhQWZYDVQGYCVIAX/gppAJQeVgYaBGWoEu86qLhDwgGQMMTx
         EtzKDNXMzPwMG/IoIyhsyKfBQFJ1jS+MUvOio0/nXvJeYd6npinBKKgLmuUJgqex/aWt
         WSPYNwCpVp1Fn4ohJhq5Ro1GwmB86odr2hGSrAhVFgTJccZatYyZQuNKkkAEqLNC/fOC
         dZaQ==
X-Forwarded-Encrypted: i=1; AHgh+Roo558vmNYw4dsNwJ2QMmHFYibkehse+1piyklmKYUwM0lj2d7gGJX/FA3QSG+o2snYT2CWd+orWhgTpFmdvucLcN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMPnMYG4zyTPwkKfYssfC5nKOMXPY5DdUSTlw9wFARGuTWTAEO
	A0kugO/yRWcNudVb0R92x86CLg+QcNdRInrLlKWDro3uyxjPVEPDnoahCtaxL5gPVAPQy1FANGf
	t4OGqaOXBcZezJxUv66+LN277+uys3u+X6aNBprhiY1LXwJ40zTRUV3m5SIgYtqT0gNDQZ8TBlf
	Y=
X-Gm-Gg: AfdE7ck1AuEcoT/XgC7jnGdVhrv3x/u56iAaE/NwO/Ycoi4RpojxvPTOkURXFF5PVuh
	Sng/b4ZVbOVuDspM+dQMa18KmtC5gkTEHwxI9t32GCmj02eq8GipzKvllOMZjR7K8xKKFbBJ+vN
	H8TytsObs5TEeLXHk0jnalB4h1cpwVuLntLKaDyFy61pZt39huH8FS4Ej96OfLD88Bv7qGx1LMO
	N9lE8VAVoqH0EMCihTebe3uC8C7kt9bWqjZs/+G2b0ovxVVGQwBgOVFdUAGl6yRFTCJHC2WHyLl
	YUgvVi2Xq90LhqPJU8KT11QbTIfnqIBpV0q8tPTmsl8a0HGtZWqITiPi9lwKLoTUU45H0k+64xd
	StnVPo8e+xooJ8gNn6PuCTAMNdqoYRF6vyWQ=
X-Received: by 2002:a05:6214:83c8:20b0:8e9:f0a5:b9c0 with SMTP id 6a1803df08f44-8f3c6dc6e3fmr73950506d6.3.1783086069077;
        Fri, 03 Jul 2026 06:41:09 -0700 (PDT)
X-Received: by 2002:a05:6214:83c8:20b0:8e9:f0a5:b9c0 with SMTP id 6a1803df08f44-8f3c6dc6e3fmr73950186d6.3.1783086068687;
        Fri, 03 Jul 2026 06:41:08 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-698ad13426fsm2348675a12.26.2026.07.03.06.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 06:41:07 -0700 (PDT)
Message-ID: <b43bf30a-be47-418a-8070-4a58a1a8a972@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 15:41:04 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] i2c: qcom-geni: Add trace events for Qualcomm GENI
 I2C driver
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260630-add-tracepoints-for-qcom-geni-i2c-v1-0-474cd6cdbe27@oss.qualcomm.com>
 <20260630-add-tracepoints-for-qcom-geni-i2c-v1-2-474cd6cdbe27@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260630-add-tracepoints-for-qcom-geni-i2c-v1-2-474cd6cdbe27@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzMyBTYWx0ZWRfX5jyn2I/UBh3N
 pe3ZTb1iODZndraJp9CYhMMXe9Vl5Zn1PJ3rlWoovR/e/HipjSqH0oAFCq+qEsC/63UKmgkOh6a
 PnlOTU7YjqUiG8Chym1AcdF3pcRdDrbghpi6AVWIm6mhWKaXNgANjQJFomJlWj03oErHl+4HtBD
 H102ldXHsZinm5HHbzOyHk0N3gbp7wNRGMkq2ny4QJvcGlpfiGpl+fobzPLJF5oVLBb4XiGjfmh
 KNs5tGR6X7dRqch2k4hCwwZQneHhKNlUaPjvJyy9F6Ir7SzdeuMDzFTGJVVo8PYiD4V1lTneTGd
 wSAIIUW2GGBtW6O1SsFhg8pCD/dz3LpvqTlF/PIQUQCg6FRHSvMghd6Qc2qJFub035FE+IVsZv7
 +glQoawdGxDYoJ5VIyLgtVubFf9zRyNIq53YHGgfcNjX53XO/YxNNiujVZkg2uzfNWlFS52m0iB
 avqLc8+1+5kSELA3pmw==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a47bbf5 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=od6cqOq-T75QGo3hM78A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: E64Lwjys0J8RIXt1lA_Col8ux9-vr2pS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzMyBTYWx0ZWRfX98I3L1HC2lWy
 N2ZI/qr/8ytoEoeljum9uz9xcUK6yhCTY8e6mV5tNKb38cWPURuCFIHKAxvLJs8g25QFSgDimFa
 gAmZEFWSwrMS5D//KpSFSEFsUhreMxc=
X-Proofpoint-GUID: E64Lwjys0J8RIXt1lA_Col8ux9-vr2pS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030133

On 6/30/26 8:02 AM, Praveen Talari wrote:
> Add trace event definitions for the Qualcomm GENI (Generic Interface)
> I2C driver. These trace events enable runtime debugging and performance
> analysis of I2C operations.
> 
> The trace events capture I2C clock configuration, interrupt status and
> error code and message.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
