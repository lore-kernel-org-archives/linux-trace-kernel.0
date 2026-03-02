Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4655519ABD8
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474430; cv=pass; b=s5SisJZyAlmURLZhIKM+w5A33tY2p6Y0Q7rQB3TsJe2mZO9S7/AaeEEIONi171BTzw0d+/++bCTnkvsJjghFTVQcCZJX8m9D3HXwVz2MA+2N0R+7yCKnTdKjRL+tFKWISHzsDcp0Ugw+c8w15GYoq6FFileXK6zJaB6KAFtxNNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474430; c=relaxed/simple;
	bh=Q/aQt5PVJHr++XQKsok9pL1AZHyD3x2U3ZlYZarAK30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5wOXVD2+VQB1Z0/I5w6eIGwRwPiXaPSetLdxTFJuAjmmK2ztX+uJPxhOCBD1xRIuqCf42+8lC8LSvGmM/QzOudIuiDAUWorI1nVTCIkbdMbmQEoP2fgmUJxVerU4ZJXnGomnn5r3ihAyICh3lq9uNNcZlx2fzGKsWbqQ98F5vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=VwfWPS/0; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=mccwYJ5a; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="VwfWPS/0";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="mccwYJ5a"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622GcWqj3112676
	for <linux-trace-kernel@vger.kernel.org>; Mon, 2 Mar 2026 18:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=Q/aQt5PVJHr++XQKsok9pL1AZHyD3x2U3ZlYZarAK30=; b=VwfW
	PS/0n8BGR9928w6TadcX5yrXnmKeObeJQlvUW3GnP5LLIDREGe/iy16Y28tQweFT
	//ziFlcQ2AkEJEvIS3Ax9qge0L86WqftTEXtnlSL51US1eIhDPs8gxcJIU7hLXLc
	uHY5T5sEtQJQIDk5jUvtEUOCdP0kujkdYppeeksWuQg3fvViK6Y/rwNEjmAwExZz
	ODXiBU2rI42zaS2/qEeMEYvwdm5WzknRNFXNgB/YxxABcpA6cekw6MQpoCVUhUEe
	od8jq5v8le5HCtx8Ao8u+7ehJtN69puxLiSwjGSVCl0bsSAnEPGn0od0da0w7Xes
	SEduEICCFvT7v2InqA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4cmbahnh00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 18:00:27 +0000 (GMT)
Received: from 04WPEXCH010.crowdstrike.sys (10.100.11.80) by
 04WPEXCH015.crowdstrike.sys (10.100.11.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 2 Mar 2026 18:00:26 +0000
Received: from mail-yw1-f199.google.com (10.100.11.78) by
 04WPEXCH010.crowdstrike.sys (10.100.11.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 2 Mar 2026 18:00:26 +0000
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7986f771f69so61933917b3.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 10:00:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772474426; cv=none;
        d=google.com; s=arc-20240605;
        b=fTtOjyw/t2oirvSYWOOdGSNdYrnptY21qQuBCqYbwaTVFH4NxOnSsX0h3qnyrdRUeH
         CI7DBm/i16TXRe1LjpKXq7KcntotLRIt5gbq+EECcY4jMj4cdyai+JDlA0FyDJkoxzRA
         OC6eJBeA82xVtVJnOnhsaGICB0cvyZ+F67d5ZgaNxC1ddYwTJtU7AWNoiRZ8lJEz0W4E
         RHylgv8SOq3y/k7SMls6IQQwacFMGhtgSU5/22/U/LYI9v50gDxSC6grEuGCMxrXHerg
         THKCSSXR7sOyRHd01pvHj6FSYCfcVmWQJAlIen2s+ZpTxLIzfecy3FanrOdm25YPcgDP
         UnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q/aQt5PVJHr++XQKsok9pL1AZHyD3x2U3ZlYZarAK30=;
        fh=N3Q73IisF6znwRWwcjQMAFS6WaVBCV6pYBihktbQMMI=;
        b=hS2z3e1Tiz/TxOzueDiOzXYCq3Sxo92Li5DDCdcskMnJiPqE0gaL1ZRDgslexlodU1
         oGx8Hd1yyhjfHv9yLnGL3W/TivakbN2RfDTnbNrY9KzQrAnvAgfJju3iaV+9tsKAThmK
         H5jwdGfqWZfYMCqgi0gbl4Ab8CIA9IvR0t9EkzC3WFQvJhIgiYA467ZzXArz9gBV1saP
         qjSg6t/7bifAl/G6EAFvCDf9X/EBJjhE+zMDXlI/H5jOWpi1xT1ax5fDdhfFs1tV6cqE
         q0Qngw3rNLYVTIVoP/KCc4uePV0CaM/Y7UIxKQreOhq+TnXZvMEiC4/CZDKvz4Bmf9uz
         qf2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1772474426; x=1773079226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/aQt5PVJHr++XQKsok9pL1AZHyD3x2U3ZlYZarAK30=;
        b=mccwYJ5a8VIL1Tt7mrSV5ggQ3WfvxxtTZ2Te3y2nw6y7MzXYwMpzB1E1cdQMWXF+rW
         Ia31rEJny/eKyuf9c05H2Ex8rgusZiZmcZVXytL6S6rdjHg7otzvYv8AWrEX7czSnvuz
         DVd/HeHuCFc1eB+1n7peR6+lIjT6KjtVFt2MkhKEERb0DjQEBtzSAnIOqxRmHFb6Pq0s
         CRSuoOUsw7B9sj43uPD+I8hBdYgtLjlwIxULJfFBT7oBNrHXeX/5kS8o1jvZYUMwb3pn
         EQnOl5fohulVwQC3mwaAF1VD4jf5O7T4MSnaGksNELBHXjRbTXohgCaJ4ihj+gwsHlh6
         y8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772474426; x=1773079226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q/aQt5PVJHr++XQKsok9pL1AZHyD3x2U3ZlYZarAK30=;
        b=ktP9O7hz9DmTKe0r5c9PjVhh4bVlU2lX78rxTWUCAUtMNnDSlcITK3nBGOy7zQ1dtN
         WLn1l13thsvY+BDAoHbzBB7pnGRQUJ9gpx7q4CTgrROJbDZlkbmN+8FRYSEQ4IxDp9IP
         k40fp4xSBWCXjbwrvI7rxgLyiyFMW+3q/nESC6hUsNyO7vt2mT1gc2CG29N4Fzi9W4dy
         fDW9MiTp5FAjs3KPJeZOx0V7rT8CHU02RPJVd7ihPBIlE1VuffJEXsyFecXSYnYsMWmp
         mkJzyE6dsPQQEVeKBtgQ6NTwIxiJzsbcIoTrGmrFgZydSFfDerNnNyyhzn49pFbzHgwV
         H7AA==
X-Forwarded-Encrypted: i=1; AJvYcCV6E6zU6pAHpx/XcaLTl3XjyA2lj+U5lgfBd51ncGxLdCcz29u5vbwjqByRLyC6xFHyh4EcRLSI3egbvprxmSKerUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMkrZFs52RFQWMiXyGThHJTPhcANKCB/WxrFsL/tVfzlcxT4ol
	4Lrpcc5YOY8oqAFWCXGLFWUn3h/3GHlfQbthQxiTnVseBq5ILYQ9cCZzIpu3oieo4PTeix0V6k9
	I28f5RxrFocJZUKHYiK3Czee4QjYJEjYZMRF3OGoSdEPQnhLwaranDJReEIVhd/pgSxc6jH6922
	ksEGs7GNZKYyjTeyq/Z0Jyji+XT72PNWLvryLK5D59FN5fKZ9Ea7Q+/hKDFXNVyIM=
X-Gm-Gg: ATEYQzynzMmiO3oqOU6gBTyhpL6ddITjdbZ+7NCQ8t19gG1IfHccmJ8+5Ot0ybCSwVq
	v8WmbEL2/vIh403oevB7FhtNCeNo2CUJdtinaZFPUdPYJwA07SkeATCH9sMti7wHhdSq7oIPoG4
	NRGEVINwYid5P2XhPBEm6kOiIK8Lw2g2QqhEcyROaUeKWYPchZSSKYsckWCXZlex9aYFZRcYepW
	6gz
X-Received: by 2002:a53:8581:0:b0:64c:9ee6:1ff7 with SMTP id 956f58d0204a3-64cc2ec651fmr8267064d50.17.1772474425847;
        Mon, 02 Mar 2026 10:00:25 -0800 (PST)
X-Received: by 2002:a53:8581:0:b0:64c:9ee6:1ff7 with SMTP id
 956f58d0204a3-64cc2ec651fmr8267016d50.17.1772474425021; Mon, 02 Mar 2026
 10:00:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227204052.725813-1-andrey.grodzovsky@crowdstrike.com> <87o6l6e6td.fsf@cloudflare.com>
In-Reply-To: <87o6l6e6td.fsf@cloudflare.com>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Mon, 2 Mar 2026 13:00:13 -0500
X-Gm-Features: AaiRm53JADr2PFbHAdzOiPHNYtrjmhka4oHQHSkhMU3e00CqwsJzEQjLMls36-M
Message-ID: <CAOu3gNjBHokznoRKD1bY_zdV8KjHBJ0-tuLCtWLoKBy1N6vnpg@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH bpf-next v3 0/3] Optimize
 kprobe.session attachment for exact function names
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, linux-open-source@crowdstrike.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org,
        rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE0MyBTYWx0ZWRfX2tgvtdooIMfe
 znZ3xdWJXeXias5Lxwu0iCBJuDXxnHUvkoeOe0lSkEyhfmG76S916JC9iQL3piEMaYAoagjTsPR
 zLni/wCBYJG+m5/bTwb+BaCpPmvXgXQe9Tk5l6y/7L+MCclxASd7SoTxOXjbQ/EiEc5Uf/o28x7
 XHaiVE+Xhq/CHs3+FhVBAVtvHny3kfCEb+9GNWoKMOIwuyAVxp94u8/xy2TxqLcemofoGRaSogM
 uCTedJy4kM3L60DljrchFmJR8et2x7qpyQNZ1LR26T18T5r2yKqeZsGeUitB8hQAUgJT/HMpWhW
 SoMI/ZPTknJZEYQ35GfgNxuaCP4UxR91/9y5H+3az8XjljSs9WInOnKWct74gJI3CGrZ1EX3MoQ
 rgY173LAuJW/dJugq/byVPFzv/hm9m0ZFSXbMjH7plGw8pbzuB1ypLZcatHLb8oMlX7BZaR808o
 mRBWZRmDZJoPRbQtVDg==
X-Authority-Analysis: v=2.4 cv=UNbQ3Sfy c=1 sm=1 tr=0 ts=69a5d03c cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=KZhmPCYDdY0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22
 a=VwQbUJbxAAAA:8 a=EG7W4yiQAAAA:8 a=eitxDzI_jGvlV6N2DNYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Yg--0P4D8Dy3BMtZQeyVYPHa-Dlb5nJC
X-Proofpoint-ORIG-GUID: Yg--0P4D8Dy3BMtZQeyVYPHa-Dlb5nJC
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11717
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020143

On Mon, Mar 2, 2026 at 7:48=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> On Fri, Feb 27, 2026 at 03:40 PM -05, Andrey Grodzovsky wrote:
> > - Patch 1: libbpf detects exact function names (no wildcards) in
> > bpf_program__attach_kprobe_multi_opts() and bypasses kallsyms parsing,
> > passing the symbol directly to the kernel via syms[] array.
> > ESRCH is normalized to ENOENT for API consistency.
>
> FWIW, Ivan was also trying to make it faster from the kernel side:
>
> https://urldefense.com/v3/__https://lore.kernel.org/bpf/20260129-ivan-bpf=
-ksym-cache-v1-1-ca503070dcc0@cloudflare.com/__;!!BmdzS3_lV9HdKG8!zla5HijIg=
6Vbdu0M8yoWocdwUD_o1-XyD5HUD7ZHbjKt9D846oT35Srz6_uXjkfS4eSc_i-lOw6IllBHvfaZ=
gPHdXrKp$
>
> But, IIUC, with this change we're not hitting get_ksymbol_bpf at all.

Exactly. Also, note plz that patch [2/3] includes an extra
optimisation in the kernel ftrace path too.

Andrey
