Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B0B33A9EF
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225546; cv=pass; b=f88xTenMi/DjCNTmpN/aKE2gxLfUjYQwcZDLgtiKnTP0pK3G6Nnac9jSnTrj5D7KKYPeYRJ++wJ0Q/pnTPygJNKZzEDO5mcVmCQh+0xtOHzSQ5NlFAZyokxj+z0v6HKeKhzrVSeiUcakRmL+QAxsIN9eTXO1dCisjLReXApyxbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225546; c=relaxed/simple;
	bh=tIygcM6cRtUQKnLeh3AfwHRi5W4L/45ygoA9+ANqpyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jAJeHbSuILjQhViaezPIanOWZdYNu6/jSS7qLgia3sGurtko/k+KPXpHWxlvGPdhCfFUprinwFDSTiplXsn9zgnPCI942IUdDyg1ax46HKjB9Tfw/wfVONPb7d0eWb8COuI1vOnZZEJ/sq+dZepbZIXcnlR+RDwjiEEiO5Y/6ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=HWh7cEqY; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=QZPlrEsc; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="HWh7cEqY";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="QZPlrEsc"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RK4LmF4076739
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 20:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=default; bh=T/yQa6BgXqNpw2Qz7tBnZUnFLT
	WmHSzLy5oxbr8AsWo=; b=HWh7cEqYISvKSNYBrbgXFm+rxnnQpX+T1rmHqlaylz
	mnNw7s4fTDHgYabBtAuyBrZ6DnqbiuraDMyUf+kR9K00BPxX4PuEzbylVsG8mYmj
	E2muFoFcvp0U9HAaqG2pQgp/vEgqbMKZ1SydzUfMjKbdV1XgqPpAk4Fqevsmvu9v
	2r+YlUf/VLXq5BQ+W/LoM7aWGlj7xqelGhhS+B7ThNYW4PHkRtGr/N8oCFAQQJuH
	zny9f44Ix3u2cEj8y9YIMUW8J/K+oZrjfoYcHRlttZhQyJ5dM+OYPuweoHndPq/k
	JjdV76WsP1AhOGUvXxVTxhIVDL9q+LE3rKOQukL0dfIw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4ck5gvavpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 20:52:24 +0000 (GMT)
Received: from 04WPEXCH006.crowdstrike.sys (10.100.11.70) by
 04WPEXCH009.crowdstrike.sys (10.100.11.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 27 Feb 2026 20:52:23 +0000
Received: from mail-yx1-f70.google.com (10.100.11.78) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 27 Feb 2026 20:52:23 +0000
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-64c46202950so4646585d50.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 12:52:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772225542; cv=none;
        d=google.com; s=arc-20240605;
        b=CAoWdj9gaL2Ej5PHuao5jaZb1HaNhpU82ERjtVa70guIj8/RPkc0mAYXnr/fkI8vjj
         NIkl4pSsgITMzx1LcPXpNKVjM9jjyNtpycJq6DxVyh9qYEsVHY8nCpzVxHBNsy5HpXJ1
         Yj7Vu7Nng1s+L264FIKxraV8MmbKnzSi6c1daPoP8k1HtlJLwawr/raZ24VhzFN46UQl
         LBEce2ooXwCsjtOWIAhgYjn6Oqpkl9NIL7sDIYpx+wr3YGLsXvpjJ7M3qbzcMu7kubX2
         /e6BNbaZJhdaFvy6BZzXAPxeOfEkDJ1wDOYGlUnZt3pyo9mxAFVkPFqibIxdiPcCYCfL
         CF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=T/yQa6BgXqNpw2Qz7tBnZUnFLTWmHSzLy5oxbr8AsWo=;
        fh=IUNOrT4ipxwKpMdyFx06wDWSemgT4iBa2VrCCXwfAj0=;
        b=jpYySimLnGLer47xpYfWVMG7T7pdjqm0hxT6k9acItYZMV3eC3C9b8NJkhsiFX8CLR
         Jr3NT0exc0B0ZoGVS98C38qXea3etC++5D4VN1gWzxnrTAHDx4pHkODrbfv4YOh0zTuM
         6+CEB25sozcUc/r9n9gcbWUoiuOrD9TjnG9i5wJb5ayo+0UL2U+I4NzHRdkIIoQYKJXI
         lBanX5KB43lf30bn81+1/OtH+09YccSpd+0v0iD88NeMQhqtT3zv8k5+Rem/olaIEtuY
         HfbRZa0Yhmc5aDj1WzIISMZL5eFZM9F550zRa82Xt8/2P5uRy+jgBW3KeJ2oN4g8VOUk
         6ySw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772225542; x=1772830342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T/yQa6BgXqNpw2Qz7tBnZUnFLTWmHSzLy5oxbr8AsWo=;
        b=QZPlrEscQw/cV+kwA0PFNIUe5rHgcGHbw1BRLGc2HY0n4luKgnjUMElS+q1dLRUmok
         q5xLK93tr8tpSjrrDQaA4w3AyGZP7QospF5IBKusdvkQKj6qh8vyo2TPuXaz5KLbHefG
         EbQbYfZvzdjMdmyQ6L8zwWmvzkSldTgGPdzULOVu/q0Q7DJKXY5ATxNNuN99XDlgHSeh
         qPgLYrrrygAgTcjAxu0UD1E+ivHar/JQUlDWDrC7LKFN1i+p8habI/evNdljPdOfOeF+
         qnsUXFsmTcYWfB2dI5gJT/ZVNwOSiAaOVsWT2g25yOuhhhgcFo/1YUiWmYcoLIBMhbML
         k/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772225542; x=1772830342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/yQa6BgXqNpw2Qz7tBnZUnFLTWmHSzLy5oxbr8AsWo=;
        b=ibT84CwXu+FCubK7uMCTvryXloMC05ODHOe8S3S4QmJXu/gMNu3A6+vvA1R9qoVKbz
         7zXy22cUSjtlvlQkOj505u0bRTpacrxIRwYX+bTh+70tLr10Gu0Z8Dnr7I+S+LlfhXkt
         1z3inb6t0so0H6cIAe7fgmN990tsU+oeftq+msPDoiW4YVSoMK1JsfKUBLl8g7mwE1B1
         A8I8NcAzN06NfqfgmaVOy9SQ2lt/IYbkC6fvcnmm63llC3lAM3Y8T89H27/CUOfjLpNu
         64jDFl0VFB0vuTNbeHsZMXWcYHI8DsvzpW36nYi5gXmKJzW/Lkic4ZbronA4ZMc+slJK
         K96A==
X-Forwarded-Encrypted: i=1; AJvYcCVQyMf5cOnHxmKL7Ke0fVBfCu7/njswZCqspuWx0m4sXJWGg+07o7c2bhwTKx613LFVhLh3ENp7bS1zU08tn3vLP1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy43LJm8mG8NXIJWgB/CJBTVfi+sYqKnESZcx6wHzgoPmq1Uiu9
	ePTPcsLcCtnAgvamfq0YHOAcpKmtVuYmCmqPbaVR+YZ1hI86DBivYU2RusDYXTxyEcD/IkhoGkr
	eiSGNw5YDepmQCanlDuQ3FOEyzQUItDRM9w/31ijsxkDru2BMPJdJ84ub2r0y2Db6pxbcYfKSFk
	PnGDXBcpDXpPPoSWmy3Y4eBmSSJFQ49E33C6FzzvIX0+fkeCfHXIP/yaBIzUIikCUmWExsWY8=
X-Gm-Gg: ATEYQzyEUY614nJDCuwJ46PCIc38G5uymTFVEIK//it+ek550fUVWJuE6PE0WqPWBLE
	CYZ3KhnIYNdSjGz8LMWiUyKamMPBBbyyJWArOKyFaAdnGpo8d5GhSSV1yK3E+f3zkyg3ADbIlBu
	icnXgkuofoAWxqmgVu2MTlNDNrzlfx03ypVkm9mkfeppdYigfsqa5QHPjePRpaXNvdP586FSj/4
	cZi
X-Received: by 2002:a05:690e:687:b0:64a:d6fe:5e18 with SMTP id 956f58d0204a3-64cc22fd002mr2646344d50.64.1772225542607;
        Fri, 27 Feb 2026 12:52:22 -0800 (PST)
X-Received: by 2002:a05:690e:687:b0:64a:d6fe:5e18 with SMTP id
 956f58d0204a3-64cc22fd002mr2646329d50.64.1772225542085; Fri, 27 Feb 2026
 12:52:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226173342.3565919-1-andrey.grodzovsky@crowdstrike.com>
 <20260226173342.3565919-2-andrey.grodzovsky@crowdstrike.com> <aaHPfR_cOwKIm-lU@krava>
In-Reply-To: <aaHPfR_cOwKIm-lU@krava>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Fri, 27 Feb 2026 15:52:11 -0500
X-Gm-Features: AaiRm514vjjY59GDxNTDSyOndmwoCXClwBag-rid5uBCNQXeVTsSFL_NC3gc46Q
Message-ID: <CAOu3gNj0EWFqJ1wk5Mqowr=wxrgMg=0n-nsSSEzLwPX32SCJHA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next v2 1/3] libbpf: Optimize
 kprobe.session attachment for exact function names
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, linux-open-source@crowdstrike.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, rostedt@goodmis.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Disclaimer: USA
X-Authority-Analysis: v=2.4 cv=Scz6t/Ru c=1 sm=1 tr=0 ts=69a20408 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22
 a=5488X_8EJ3_aOaWkbUEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cSlm_a4vFX4NoHHrI31W8569g4D4ZHJ9
X-Proofpoint-ORIG-GUID: cSlm_a4vFX4NoHHrI31W8569g4D4ZHJ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MyBTYWx0ZWRfXyR/mUUF7pjuy
 rVhppB7TOXlIfViJlex5HwOAYa1nKAporIyO2mxqjUt7qLvWiNtd6vIuzLENDJLpev1IrKUHUxe
 +zeBllO2knaiyQ7jgnGItLPB2GeK9nQ8GmPDPGTghI5UjhZNPNIfelZRuo8rnIgfFI2kGcs+E1T
 yJVu4W1Kf4epWqw8ZYiGnS0zV1Qmocda0qk3OwxthEvg+tql8wIlM1gGz9KRjxBGiOHmcZoNw2d
 B5sysWKsDMcKaCspZLdANNmqckDlP9FJKU8MF7ZuCHwr/pnwbLPyoKxXnVJCqDY9HY/EIdMQOrd
 VzgYhNyQ9PdE1mR1N3ySnJXwvWRZKIyHh7cWJr31yi+WtDhgJnVs5I1PZn3TB4IkmbSimq0eDsG
 Jq+MUF0XxU0qBU68adevhLzhpCp/TA1dmE4yid7Pu66wjWKWVZU9xVUEU0ao4fZZvWePZQUm41c
 SZXouDOBzsJgV/27r3w==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11714
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270183

> -       if (pattern) {
> +       /*
> +        * Exact function name (no wildcards): bypass kallsyms parsing
> +        * and pass the symbol directly to the kernel via syms[] array.
> +        * The kernel's ftrace_lookup_symbols() resolves it efficiently.
> +        */
> +       if (pattern && !strpbrk(pattern, "*?")) {
> +               syms = &pattern;
> +               cnt = 1;
> +       } else if (pattern) {
>                 if (has_available_filter_functions_addrs())
>                         err = libbpf_available_kprobes_parse(&res);
>
>
> wdyt?

Totally agree, updated in V3.

Thanks,
Andrey
